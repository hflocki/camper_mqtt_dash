#!/bin/sh

# Pfad zum USB-Stick
USB_DIR="/tmp/mountd/disk1_part1"
# Name des Sicherungsverzeichnisses (mit Datum/Zeit)
BACKUP_NAME="glinet_config_$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$USB_DIR/$BACKUP_NAME"

echo "--- Starte Systemsicherung auf USB-Stick: $BACKUP_DIR ---"

# 1. Sicherungsverzeichnis erstellen
mkdir -p "$BACKUP_DIR/www"
mkdir -p "$BACKUP_DIR/etc_config"
mkdir -p "$BACKUP_DIR/etc_mosquitto"

# 2. Dashboard Dateien sichern (www/dash)
echo "Sichere Dashboard Dateien (/www/dash)..."
cp -r /www/dash "$BACKUP_DIR/www/"

# 3. Mosquitto Daemon Konfiguration sichern (sehr wichtig)
echo "Sichere Mosquitto Konfigurationsdateien..."
cp /etc/config/mosquitto "$BACKUP_DIR/etc_config/"

# 4. Mosquitto Zertifikate/Keys sichern (falls TLS verwendet wird)
if [ -d /etc/mosquitto ]; then
    cp -r /etc/mosquitto/* "$BACKUP_DIR/etc_mosquitto/"
fi

# 5. uHTTPd Webserver Konfiguration sichern
echo "Sichere uHTTPd Konfiguration..."
cp /etc/config/uhttpd "$BACKUP_DIR/etc_config/"

echo "Sicherung abgeschlossen unter: $BACKUP_NAME"
echo "--- Ende Sicherung ---"
