# Config Folder
Gateway hardware and software configuration files and procedures.

1. [Configure ETH Interface](configure-eth-interface)
2. [Configure LTE Modem](configure-lte-modem)
    - [Power-Up Sequence](power-up-sequence)
    - [Set PPPD Connection](set-pppd-connection)
    - [Test LTE Modem](test-lte-modem)
3. [Configure Wi-Fi AP](configure-wifi-interface)
    - [Set Fixed IP Address](set-fixed-ip-address)
    - [Enable Access Point Mode](eanble-access-point-mode)
    - [Test Wi-Fi](test-wi-fi)

**Note:** This documentation is for setup purposes only. The aim is to move these configuration files into a set of Yocto recipes, creating a workflow to generate an image with all configurations correctly applied.

## Configure ETH Interface
By default, Yocto does not provide a network configuration file for **eth0**. However, for a more flexible gateway configuration, it is necessary to create one. This way, custom configurations such as fixed IP addresses or Modbus TCP routes can be more easily set. Copy the [10-eth0.network](etc/systemd/network/10-eth0.network) file into the following folder:

```
/etc/systemd/network
```

## LTE Modem

### Power-Up Sequence
By default, the LTE Modem is turned off at boot to save power. Use the sequence provided by Engicam to power up the device.

```
echo 0 > /sys/class/gpio/UMTS_RESET/value
sleep 0.5
echo 1 > /sys/class/gpio/UMTS_ON/value
sleep 0.5
echo 0 > /sys/class/gpio/UMTS_ON/value
sleep 0.5
```

After a few seconds, a new network interface will appear:

```
ip addr show wwan0
```

The device will show up even if it is not yet fully enabled.

### Set PPPD Connection
Once **wwan0** is visible, copy the [lte-connect-chat](etc/ppp/lte-connect-chat) file in the following folder

```
/etc/ppp
```

and the [ltedial](etc/ppp/peers/ltedial) file in the follwing folder

```
/etc/ppp/peers
```

### Test LTE Modem
**Important: please disconnect eth0 before starting modem to prevent default route conflict during manual tests**

To start the connection, run the following command

```
pon ltedial &
```

The connection log will appear in the terminal, showing the procedure's result. If everything goes smoothly, running **networkctl status ppp0** should display output similar to the following:

```
                     Link File: n/a
                  Network File: /etc/systemd/network/20-ppp0.network
                          Type: ppp
                         State: routable (configuring)
                  Online state: online                                                
                           MTU: 1500
                         QDisc: pfifo_fast
  IPv6 Address Generation Mode: eui64
          Queue Length (Tx/Rx): 1/1
                       Address: 100.117.104.4
             Activation Policy: up
           Required For Online: yes
             DHCP6 Client DUID: DUID-EN/Vendor:0000ab11bca8b4f3a56c5d300000

Mar 17 11:02:59 imx6ull-microgea systemd-networkd[541]: ppp0: Link UP
Mar 17 11:02:59 imx6ull-microgea systemd-networkd[541]: ppp0: Gained carrier
Mar 17 11:02:59 imx6ull-microgea systemd-networkd[541]: ppp0: found matching network '/etc/systemd/network/20-ppp0.network', based on potentially unpredictable interface name.

```

Now you can test the established connection with:

```
ping google.com
```

## Configure Wi-Fi AP

### Set Fixed IP Address
Before configuring Wi-Fi in Access Point mode, it is essential to assign a fixed IP address to the interface. Copy the [10-wlan0-static.network](etc/systemd/network/30-wlan0.network) file into the following folder:

```
/etc/systemd/network
```

Once copied, restart **systemd-networkd** to apply the changes. Check if the desired IP address is shown with **ip addr** and try pinging Google to ensure there are no DNS conflicts between network interfaces.

```
systemctl restart systemd-networkd
ip addr show wlan0
ping google.com
```

If you experienced some delay while pinging at google, maybe there's something wrong in network resolution.

### Enable Access Point Mode

Once both network interfaces are up, overwrite the [hostapd.conf](etc/hostapd.conf) file at this path:

```
/etc/hostapd.conf
```

And overwrite the [dnsmasq.conf](etc/dnsmasq.conf) at this path.

```
/etc/dnsmasq.conf
```

Now we're ready to use Wi-Fi in Access Point mode, remember to enabled both services and restart the gateway.

```
systemctl enable hostapd
systemctl enable dnsmasq
reboot
```

### Test Wi-Fi
If everything is set up correctly, you should now see *capetti-gateway* in the available networks list on your PC or smartphone. Try to connect using the password set in *hostapd.conf* to test the new configuration.

[<< BACK TO HOME <<](../README.md)