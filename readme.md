# Camper MQTT Dashboard 🚐📡

Ein Dashboard zur Steuerung und Überwachung von Camper‑Geräten über MQTT und WebSockets.

## 🔧 Hardware & Setup
- **Router**: OpenWrt, z. B. GL‑MT3000 (Beryl AX)
- **ESP‑Geräte**: Sensoren senden Daten per MQTT an Mosquitto
- **Webseite**: Zentrale Status‑ und Steuerungsseite mit WebSocket‑Integration
- **Steuerung**: ESP‑Geräte wie Truma oder MaxxFan können direkt über MQTT/WebSocket bedient werden

## 📦 Abhängigkeiten
MQTT‑Library wird über CDN eingebunden:
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/mqtt/5.14.1/mqtt.min.js"></script>

Status Page
![screenshot](https://github.com/hflocki/camper_mqtt_dash/blob/main/images/status.png)

Control Page
![screenshot](https://github.com/hflocki/camper_mqtt_dash/blob/main/images/control.png)
