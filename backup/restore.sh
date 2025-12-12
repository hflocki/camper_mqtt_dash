#!/bin/sh

# Pfad zum USB-Stick
USB_DIR="/tmp/mountd/disk1_part1"
# Name des Haupt-Installationspakets (mit SSL-Unterstützung)
MOSQUITTO_PACKAGE="mosquitto-ssl"
MOSQUITTO_CLIENT_PACKAGE="mosquitto-client-ssl"

echo "--- Starte automatische Wiederherstellung der Konfiguration ---"

# 1. Letzten Sicherungsordner finden
LATEST_BACKUP=$(ls -td $USB_DIR/glinet_config_* | head -1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "FEHLER: Kein Sicherungsordner (glinet_config_*) auf dem USB-Stick gefunden!"
    exit 1
fi

echo "Wiederherstellung aus: $LATEST_BACKUP"

# --- A. Dashboard (Webserver) Dateien wiederherstellen ---
echo "1/3: Stelle Dashboard Dateien und uHTTPd Konfiguration wieder her..."

# Dashboard kopieren (überschreibt alle Standarddateien im www-Ordner)
cp -r "$LATEST_BACKUP/www/dash" /www/

# Webserver Konfiguration wiederherstellen
cp "$LATEST_BACKUP/etc_config/uhttpd" /etc/config/

# Webserver neu starten
/etc/init.d/uhttpd restart
echo "Dashboard Wiederherstellung abgeschlossen."

# --- B. Mosquitto (MQTT Broker) Konfiguration prüfen und installieren ---

# 2/3: Mosquitto Installation prüfen und ggf. installieren
echo "2/3: Prüfe Mosquitto SSL-Installation..."

# Prüfe, ob das Hauptpaket (mosquitto-ssl) im Systempfad existiert
if ! command -v mosquitto >/dev/null 2>&1; then
    
    echo "$MOSQUITTO_PACKAGE ist NICHT installiert. Starte Installation..."
    
    # OPKG Paketliste aktualisieren, da diese nach einem Update veraltet ist
    opkg update
    
    # Mosquitto Broker und Client mit SSL-Unterstützung installieren
    opkg install $MOSQUITTO_PACKAGE $MOSQUITTO_CLIENT_PACKAGE
    
    if [ $? -ne 0 ]; then
        echo "FEHLER: Installation von $MOSQUITTO_PACKAGE fehlgeschlagen! Bitte manuell prüfen."
    else
        echo "Mosquitto SSL erfolgreich installiert."
    fi
else
    echo "Mosquitto ist bereits installiert. (Weiter mit Konfig.)"
fi


# 3/3: Mosquitto Konfiguration und Zertifikate wiederherstellen und Service starten
echo "3/3: Stelle Mosquitto Konfiguration und Zertifikate wieder her und starte Service..."

# Mosquitto Konfiguration wiederherstellen (/etc/config/mosquitto)
cp "$LATEST_BACKUP/etc_config/mosquitto" /etc/config/

# Mosquitto Zertifikate/Keys wiederherstellen (falls vorhanden in /etc/mosquitto)
if [ -d "$LATEST_BACKUP/etc_mosquitto" ]; then
    mkdir -p /etc/mosquitto
    cp -r "$LATEST_BACKUP/etc_mosquitto/"* /etc/mosquitto/
fi

# Mosquitto Service aktivieren und starten
/etc/init.d/mosquitto enable
/etc/init.d/mosquitto restart

echo "--- Wiederherstellung erfolgreich abgeschlossen! ---"
