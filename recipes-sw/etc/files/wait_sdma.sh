#!/bin/sh

TIMEOUT=60
COUNT=0

echo "[wait_sdma] Waiting for SDMA firmware to load..."

# Loop finché la stringa non compare nei log del kernel
while ! dmesg | grep -q "imx-sdma .* loaded firmware"; do
    sleep 1
    COUNT=$((COUNT + 1))

    if [ "$COUNT" -ge "$TIMEOUT" ]; then
        echo "[wait_sdma] Timeout after $TIMEOUT seconds — continuing anyway"
        exit 0
    fi
done

echo "[wait_sdma] SDMA firmware loaded"
exit 0