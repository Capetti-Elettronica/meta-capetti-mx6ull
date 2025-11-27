#!/bin/sh

PROGRAM="gateway"
LED_STATUS_PATH="/sys/class/leds/led_status"

while true; do
    if ! pidof "$PROGRAM" > /dev/null; then
        echo "255" > "$LED_STATUS_PATH/brightness"
        echo "220 70 0" > "$LED_STATUS_PATH/multi_intensity"
    fi
    sleep 1
done