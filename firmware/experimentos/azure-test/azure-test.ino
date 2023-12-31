#include <WiFi.h>

//  Bibliotecas:  https://github.com/knolleary/pubsubclient
//                https://github.com/bblanchon/ArduinoJson
//                https://github.com/tzapu/WiFiManager
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFiClientSecure
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WebServer
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/DNSServer


#define BAUD_RATE          115200
#define MACHINE_NAME       "656271c009e851dbcb7adb63"
#define IOTHUB_URL         "central-iot.azure-devices.net"
#define IOTHUB_DEVICE_NAME "nodemcu-0001"
#define IOTHUB_USER        "central-iot.azure-devices.net/nodemcu-0001/?api-version=2020-03-13"
#define IOTHUB_SAS_TOKEN   "SharedAccessSignature sr=central-iot.azure-devices.net%2Fdevices%2Fnodemcu-0001&sig=FqTKMr%2B7OCc7CyG31JYH19HVRPVn2tDmPULxLM9E%2Fc0%3D&se=3600001650221522"
#define IOTHUB_PORT        8883

#include <WebServer.h>
#include <DNSServer.h>
#include <WiFiManager.h>
#define MQTT_MAX_PACKET_SIZE 256
#define MQTT_KEEPALIVE 240
#include <ArduinoJson.h>
#include <PubSubClient.h>
#include <WiFiClientSecure.h>

WiFiClientSecure espClient;
WiFiManager wifiManager;
PubSubClient mqttClient(espClient);

void setup() {
  Serial.begin(BAUD_RATE);
  Serial.println();

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

  Serial.println('MQTT config init');
  mqttClient.setServer("central-iot.azure-devices.net", 8883);
  mqttClient.setCallback(callback);
  connectMqtt();
  Serial.println("MQTT config done");

  delay(1000);

  DynamicJsonDocument doc(1024);
  char JSONbuffer[1024];
  doc["roboticArm"] = MACHINE_NAME;
  doc["color"] = "GREEN";
  doc["count"] = 5;
  serializeJson(doc, JSONbuffer);
  Serial.println(JSONbuffer);
  mqttClient.publish("devices/nodemcu-0001/messages/events/", JSONbuffer);
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

void loop () {}