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

💾 Backup & Restore
Ein Script ermöglicht Backup und Restore von Anpassungen auf einem USB‑Stick.

📊 Screenshots

![screenshot](https://github.com/hflocki/camper_mqtt_dash/blob/main/images/status.png?raw=true)

![screenshot](https://github.com/hflocki/camper_mqtt_dash/blob/main/images/control.png?raw=true)


🚀 Features
Echtzeit‑Anzeige von Sensordaten

Steuerung von Camper‑Geräten über MQTT

Einfache Integration in OpenWrt‑Router

Backup/Restore für schnelle Wiederherstellung

📌 Hinweis
Dieses Projekt ist für den Einsatz im Camper‑Umfeld gedacht und kann flexibel erweitert werden.