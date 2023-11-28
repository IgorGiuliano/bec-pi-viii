#include <ESP32Servo.h>


#include "constants.h"
#include "azure.h"
#include "WString.h"
#include "driver/mcpwm.h"
#include <ArduinoJson.h>
#include <Adafruit_TCS34725.h>
#include <WiFi.h>
#include <WebServer.h>
#include <DNSServer.h>
#include <WiFiManager.h>
#define MQTT_MAX_PACKET_SIZE 256
#define MQTT_KEEPALIVE 240
#include <WiFiClientSecure.h>
#include <PubSubClient.h>
#include <string>

class ArmServo {
  Servo servo;
  bool move_foward;
  bool move_backward;
  std::string foward_msg;
  std::string backward_msg;
  uint8_t pin;
  uint8_t position;

public:
  ArmServo(uint8_t pin, const char* bwd_msg, const char* fwd_msg)
    : servo{}, move_foward{ false }, move_backward{ false }, foward_msg{ fwd_msg }, backward_msg{ bwd_msg }, pin{ pin }, position{ 0 } {
    servo.attach(pin);
    servo.write(0);
  }

  void update_status(const char* msg) {
    if (!msg) {
      return;
    }

    if (msg == foward_msg) {
      move_foward = !move_foward;
      move_backward = false;
    } else if (msg == backward_msg) {
      move_backward = !move_backward;
      move_foward = false;
    }

    move();
  }

  void move() {
    if (move_foward && position < 179) {
      position += 2;
    }
    if (move_backward && position > 1) {
      position -= 2;
    }

    servo.write(position);
  }
};

std::vector<ArmServo> servos{
  ArmServo(MOTOR_BASE_PIN, "rightshoulder", "leftshoulder"),
  ArmServo(MOTOR_ANTEBRACO_PIN, "back", "start"),
  ArmServo(MOTOR_ANTEBRACO_PIN, "b", "a")
};

WiFiClientSecure espClient;
WiFiManager wifiManager;
PubSubClient mqttClient(espClient);

Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_614MS, TCS34725_GAIN_1X);
Servo servo_base;
Servo servo_ante;
Servo servo_braco;
Servo servo_rotacao;
Servo servo_garra;


void setup() {
  Serial.begin(BAUD_RATE);
  pinMode(IR_INICIO_PIN, INPUT);
  pinMode(IR_FIM_PIN, INPUT);

  pinMode(MOTOR_BASE_PIN, OUTPUT);
  pinMode(MOTOR_ANTEBRACO_PIN, OUTPUT);
  pinMode(MOTOR_BRACO_PIN, OUTPUT);
  pinMode(MOTOR_ROTACAO_GARRA_PIN, OUTPUT);
  pinMode(MOTOR_GARRA_PIN, OUTPUT);
  servo_base.attach(MOTOR_BASE_PIN);
  servo_ante.attach(MOTOR_ANTEBRACO_PIN);
  servo_braco.attach(MOTOR_BRACO_PIN);
  servo_rotacao.attach(MOTOR_ROTACAO_GARRA_PIN);
  servo_garra.attach(MOTOR_GARRA_PIN);

  servo_base.write(0);
  delay(250);
  servo_ante.write(50);
  delay(250);
  servo_braco.write(0);
  delay(250);
  servo_rotacao.write(0);
  delay(2000);

  mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM0A, GPIO_PWM0A_OUT);
  mcpwm_gpio_init(MCPWM_UNIT_0, MCPWM0B, GPIO_PWM0B_OUT);

  mcpwm_config_t pwm_config;
  pwm_config.frequency = 1000;                 //frequência = 500Hz,
  pwm_config.cmpr_a = 0;                       //Ciclo de trabalho (duty cycle) do PWMxA = 0
  pwm_config.cmpr_b = 0;                       //Ciclo de trabalho (duty cycle) do PWMxb = 0
  pwm_config.counter_mode = MCPWM_UP_COUNTER;  //Para MCPWM assimetrico
  pwm_config.duty_mode = MCPWM_DUTY_MODE_0;    //Define ciclo de trabalho em nível alto
  //Inicia(Unidade 0, Timer 0, Config PWM)
  mcpwm_init(MCPWM_UNIT_0, MCPWM_TIMER_0, &pwm_config);

  Wire.begin(SDA_PIN, SCL_PIN);
  if (tcs.begin()) {
    Serial.println("Found sensor");
  } else {
    Serial.println("No TCS34725 found ... check your connections");
    while (1)
      ;
  }

  Serial.println("Initiated");
  Serial.println("WIFI config init");
  wifiManager.setAPCallback(configModeCallback);
  wifiManager.setSaveConfigCallback(saveConfigCallback);

  if (!wifiManager.autoConnect("ESP32", "123asd123")) {
    Serial.println("failed to connect and hit timeout");
    delay(3000);
    ESP.restart();
    delay(5000);
  }

  espClient.setInsecure();
  Serial.println("WIFI config done");

  Serial.println("MQTT config init");
  mqttClient.setServer(IOTHUB_URL, IOTHUB_PORT);
  mqttClient.setCallback(callback);
  connectMqtt();
  Serial.println("MQTT config done");
}

void loop() {
  if (!Serial.available()) {
    rotina();
  }

  String serial_str = Serial.readString();
  char* str = (char*)malloc(serial_str.length() + 1);
  strcpy(str, serial_str.c_str());

  char* token = strtok(str, "/");

  while (token) {
    for (auto& servo : servos) {
      servo.update_status(token);
    }
    token = strtok(NULL, "/");
  }

  free(str);
  str = NULL;

  delay(15);
}

void rotina() {
  // lê infravermelho
  int inicio, fim;
  inicio = digitalRead(IR_INICIO_PIN);

  if (inicio) {
    Serial.println("Nao ha objeto");
    return;
  }

  // move até o meio
  moveEsteira(MCPWM_UNIT_0, MCPWM_TIMER_0, 10.0);
  delay(500);
  paraEsteira(MCPWM_UNIT_0, MCPWM_TIMER_0);

  // verifica cor
  float r, g, b;
  char* status = "";
  tcs.getRGB(&r, &g, &b);
  if ((r > g) && (g > (r / 2))) {
    Serial.println("DESCONHECIDO");
    return;
  } else if ((g > r) && (g > b)) {
    Serial.println("APROVADO");
    char* status = "APROVADO";
  } else if ((r > g) && (r > b)) {
    Serial.println("REPROVADO");
    char* status = "REPROVADO";
    useArm();
  }

  // envia os dados
  sendData(status, 1);

  // move até o final
  moveEsteira(MCPWM_UNIT_0, MCPWM_TIMER_0, 10.0);
  delay(500);
  paraEsteira(MCPWM_UNIT_0, MCPWM_TIMER_0);

  // lê infravermelho

  fim = digitalRead(IR_INICIO_PIN);

  if (fim) {
    Serial.println("Nao ha objeto");
    return;
  }

  return;
}

void configModeCallback(WiFiManager* myWiFiManager) {
  Serial.println("Modo de configuração");
  Serial.println(WiFi.softAPIP());
  Serial.println(myWiFiManager->getConfigPortalSSID());
}

void saveConfigCallback() {
  Serial.println("Configuração Salva");
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.printf("\nMessage arrived: ");
  for (int i = 0; i < length; i++) {

    Serial.print((char)payload[i]);
  }
  Serial.println("---");
}

void connectMqtt() {
  Serial.printf("\nTrying to connect to MQTT server: %s\n", IOTHUB_URL);

  while (!mqttClient.connected()) {
    Serial.print("Attempting MQTT connection... ");

    if (mqttClient.connect(IOTHUB_DEVICE_NAME, IOTHUB_USER, IOTHUB_SAS_TOKEN)) {

      Serial.printf("\nMQTT connected at: %s", IOTHUB_URL);
      mqttClient.subscribe("devices/nodemcu-0001/messages/devicebound/#");
      Serial.printf("\n Connected to MQTT server:\t%s", IOTHUB_URL);

    } else {

      Serial.print("failed, state=");
      Serial.print(mqttClient.state());
      Serial.println("Trying again in 10 seconds.");

      delay(10000);
    }
  }
}

void sendData(char* status, float quantity) {
  DynamicJsonDocument doc(1024);
  char JSONbuffer[1024];
  doc["roboticArm"] = MACHINE_NAME;
  doc["color"] = status;
  doc["count"] = quantity;
  serializeJson(doc, JSONbuffer);
  Serial.println(JSONbuffer);
  mqttClient.publish("devices/nodemcu-0001/messages/events/", JSONbuffer);
}

void useArm() {
  servo_base.write(0);
  delay(250);
  servo_ante.write(50);
  delay(250);
  servo_braco.write(0);
  // delay(250);
  // servo_rotacao.write(0);
  delay(2000);

  // giro
  servo_ante.write(90);
  delay(250);
  servo_braco.write(30);
  delay(250);

  servo_base.write(180);
  delay(2000);

  // desce
  for (int i = 90; i > 50; i -= 1) {
    servo_ante.write(i);
    delay(50);
  }
  delay(250);
  for (int i = 30; i > 0; i -= 1) {
    servo_braco.write(i);
    delay(50);
  }
  delay(250);

  // giro
  for (int i = 50; i < 90; i += 1) {
    servo_ante.write(i);
    delay(50);
  }
  delay(250);
  for (int i = 0; i < 30; i += 1) {
    servo_braco.write(i);
    delay(50);
  }
  delay(250);
  servo_base.write(0);
  // delay(250);
  delay(2000);


  // desce

  for (int i = 90; i > 50; i -= 1) {
    servo_ante.write(i);
    delay(50);
  }
  delay(250);

  for (int i = 30; i > 0; i -= 1) {
    servo_braco.write(i);
    delay(50);
  }
  delay(2000);
}

static void moveEsteira(mcpwm_unit_t mcpwm_num, mcpwm_timer_t timer_num, float duty_cycle) {
  //mcpwm_set_signal_low(unidade PWM(0 ou 1), Número do timer(0, 1 ou 2), Operador (A ou B));    => Desliga o sinal do MCPWM no Operador B (Define o sinal em Baixo)
  mcpwm_set_signal_low(mcpwm_num, timer_num, MCPWM_OPR_B);

  //mcpwm_set_duty(unidade PWM(0 ou 1), Número do timer(0, 1 ou 2), Operador (A ou B), Ciclo de trabalho (% do PWM));    => Configura a porcentagem do PWM no Operador A (Ciclo de trabalho)
  mcpwm_set_duty(mcpwm_num, timer_num, MCPWM_OPR_A, duty_cycle);

  //mcpwm_set_duty_tyoe(unidade PWM(0 ou 1), Número do timer(0, 1 ou 2), Operador (A ou B), Nível do ciclo de trabalho (alto ou baixo));    => define o nível do ciclo de trabalho (alto ou baixo)
  mcpwm_set_duty_type(mcpwm_num, timer_num, MCPWM_OPR_A, MCPWM_DUTY_MODE_0);
  //Nota: Chame essa função toda vez que for chamado "mcpwm_set_signal_low" ou "mcpwm_set_signal_high" para manter o ciclo de trabalho configurado anteriormente
}

static void paraEsteira(mcpwm_unit_t mcpwm_num, mcpwm_timer_t timer_num) {
  mcpwm_set_signal_low(mcpwm_num, timer_num, MCPWM_OPR_A);  //Desliga o sinal do MCPWM no Operador A
  mcpwm_set_signal_low(mcpwm_num, timer_num, MCPWM_OPR_B);  //Desliga o sinal do MCPWM no Operador B
}