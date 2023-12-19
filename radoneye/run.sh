#!/usr/bin/with-contenv bashio
# shellcheck disable=SC2046,SC2093,SC1008,SC1091

source ./bin/activate

DEVICES="$(bashio::config devices)"

if [ "$DEVICES" == "null" ]; then
    echo "Discovering available devices..."
    ./radoneye-scan.py | tee /tmp/discovered-devices.txt
    DEVICES="$(cut -d ' ' -f 1 < /tmp/discovered-devices.txt)"
    if [ -z "$DEVICES" ]; then
        echo "Unable to find any devices"
        exit 1
    fi
else
    echo "Use following devices: $DEVICES"
fi

MQTT_HOSTNAME="$(bashio::config mqtt_hostname)"
MQTT_PORT="$(bashio::config mqtt_port)"
MQTT_USERNAME="$(bashio::config mqtt_username)"
MQTT_PASSWORD="$(bashio::config mqtt_password)"
CONNECT_TIMEOUT="$(bashio::config connect_timeout)"
READ_TIMEOUT="$(bashio::config read_timeout)"
RECONNECT_DELAY="$(bashio::config reconnect_delay)"
ATTEMPTS="$(bashio::config attempts)"
DEBUG="$(bashio::config debug)"
DEVICE_TOPIC="$(bashio::config device_topic)"
DISCOVERY_TOPIC="$(bashio::config discovery_topic)"
DEVICE_RETAIN="$(bashio::config device_retain)"
DISCOVERY_RETAIN="$(bashio::config discovery_retain)"
INTERVAL="$(bashio::config interval)"
EXPIRE_AFTER="$(bashio::config expire_after)"
FORCE_UPDATE="$(bashio::config force_update)"
DISCOVERY_DELAY="$(bashio::config discovery_delay)"

echo "Running reader in daemon mode..."
exec ./radoneye-reader.py \
    --daemon \
    --discovery \
    --mqtt \
    --mqtt-hostname "$MQTT_HOSTNAME" \
    --mqtt-port "$MQTT_PORT" \
    $([ "$MQTT_USERNAME" != "null" ] && printf "%s %s" --mqtt-username "$MQTT_USERNAME" ) \
    $([ "$MQTT_PASSWORD" != "null" ] && printf "%s %s" --mqtt-password "$MQTT_PASSWORD" ) \
    $([ "$CONNECT_TIMEOUT" != "null" ] && printf "%s %s" --connect-timeout "$CONNECT_TIMEOUT") \
    $([ "$READ_TIMEOUT" != "null" ] && printf "%s %s" --read-timeout "$READ_TIMEOUT") \
    $([ "$RECONNECT_DELAY" != "null" ] && printf "%s %s" --reconnect-delay "$RECONNECT_DELAY") \
    $([ "$ATTEMPTS" != "null" ] && printf "%s %s" --attempts "$ATTEMPTS") \
    $([ "$DEBUG" = "true" ] && printf "%s" --debug) \
    $([ "$DEVICE_TOPIC" != "null" ] && printf "%s %s" --device-topic "$DEVICE_TOPIC") \
    $([ "$DISCOVERY_TOPIC" != "null" ] && printf "%s %s" --discovery-topic "$DISCOVERY_TOPIC") \
    $([ "$DEVICE_RETAIN" = "true" ] && printf "%s" --device-retain) \
    $([ "$DISCOVERY_RETAIN" = "true" ] && printf "%s" --discovery-retain) \
    $([ "$INTERVAL" != "null" ] && printf "%s %s" --interval "$INTERVAL") \
    $([ "$EXPIRE_AFTER" != "null" ] && printf "%s %s" --expire-after "$EXPIRE_AFTER") \
    $([ "$FORCE_UPDATE" = "true" ] && printf "%s" --force-update) \
    $([ "$DISCOVERY_DELAY" != "null" ] && printf "%s %s" --discovery-delay "$DISCOVERY_DELAY") \
    $DEVICES
