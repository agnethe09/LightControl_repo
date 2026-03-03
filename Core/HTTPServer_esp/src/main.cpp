#include <WiFi.h>
#include <WebServer.h>
#include "secrets.h"

const char *ssid = WIFI_SSID;
const char *pass = WIFI_PASS;

WebServer server(80);

const int RELAY_PIN = 4;      
const bool ACTIVE_LOW = true; 

bool relayOn = false;

void writeRelayPin(bool on)
{
  if (ACTIVE_LOW)
  {
    digitalWrite(RELAY_PIN, on ? LOW : HIGH);
  }
  else
  {
    digitalWrite(RELAY_PIN, on ? HIGH : LOW);
  }
}

void setRelay(bool on)
{
  relayOn = on;
  writeRelayPin(on);
}

void handleRoot()
{
  server.send(200, "text/plain", "LightControl ESP32\nUse /on /off /status");
}

void handleOn()
{
  Serial.println("[HTTP] /on");
  setRelay(true);
  server.send(200, "application/json", "{\"relay\":\"on\"}");
}

void handleOff()
{
  Serial.println("[HTTP] /off");
  setRelay(false);
  server.send(200, "application/json", "{\"relay\":\"off\"}");
}

void handleStatus()
{
  server.send(200, "application/json",
              relayOn ? "{\"relay\":\"on\"}" : "{\"relay\":\"off\"}");
}

void handleNotFound()
{
  server.send(404, "text/plain", "404 Not Found");
}

void setup()
{
  Serial.begin(115200);
  delay(200);

  
  pinMode(RELAY_PIN, OUTPUT);
 
  digitalWrite(RELAY_PIN, ACTIVE_LOW ? HIGH : LOW);
  relayOn = false;

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, pass);

  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(300);
    Serial.print(".");
  }

  Serial.println();
  Serial.print("Connected. IP: ");
  Serial.println(WiFi.localIP());

  server.on("/", handleRoot);
  server.on("/on", handleOn);
  server.on("/off", handleOff);
  server.on("/status", handleStatus);
  server.onNotFound(handleNotFound);

  server.begin();
  Serial.println("HTTP server started");
}

void loop()
{
  server.handleClient();
}
