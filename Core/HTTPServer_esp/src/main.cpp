#include <WiFi.h>
#include <WebServer.h>

const char *ssid = "3.TV";
const char *pass = "jeger9nja";

WebServer server(80);

const int RELAY_PIN = 4;      // your chosen GPIO
const bool ACTIVE_LOW = true; // typical relay modules are active-low

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

  // ---- Safe relay boot state ----
  pinMode(RELAY_PIN, OUTPUT);
  // force OFF immediately (prevents a brief click on some modules)
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
