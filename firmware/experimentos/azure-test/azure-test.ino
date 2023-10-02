//  Bibliotecas:  https://github.com/knolleary/pubsubclient
//                https://github.com/bblanchon/ArduinoJson
//                https://github.com/tzapu/WiFiManager
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFi
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WiFiClientSecure
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/WebServer
//                https://github.com/espressif/arduino-esp32/tree/master/libraries/DNSServer


#define BAUD_RATE          115200
#define MACHINE_NAME       "CAP_COLECTOR_001"
#define IOTHUB_URL         "central-iot.azure-devices.net"
#define IOTHUB_DEVICE_NAME "nodemcu-0001"
#define IOTHUB_USER        "central-iot.azure-devices.net/nodemcu-0001/?api-version=2020-03-13"
#define IOTHUB_SAS_TOKEN   "SharedAccessSignature sr=central-iot.azure-devices.net%2Fdevices%2Fnodemcu-0001&sig=FqTKMr%2B7OCc7CyG31JYH19HVRPVn2tDmPULxLM9E%2Fc0%3D&se=3600001650221522"
#define IOTHUB_PORT        8883

#include <WiFi.h>
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
  mqttClient.setServer(IOTHUB_URL, IOTHUB_PORT);
  mqttClient.setCallback(callback);
  connectMqtt();
  Serial.println("MQTT config done");

  delay(1000);
}