SUMMARY = "Custom network configurations for GW25LX"
DESCRIPTION = "This package provides basic network configuration for all network interfaces"
LICENSE = "CLOSED"

inherit allarch


SRC_URI = " file://10-eth0.network \
			file://20-ppp0.network \
			file://30-wlan0.network \
			"

do_install () {
	install -d ${D}${sysconfdir}/systemd/network
	install -m 644 ${WORKDIR}/10-eth0.network ${D}${sysconfdir}/systemd/network/10-eth0.network
	install -m 644 ${WORKDIR}/20-ppp0.network ${D}${sysconfdir}/systemd/network/20-ppp0.network
	install -m 644 ${WORKDIR}/30-wlan0.network ${D}${sysconfdir}/systemd/network/30-wlan0.network
}


FILES:${PN} += "${sysconfdir}/systemd/network"

CONFFILES:${PN} += "${sysconfdir}/systemd/network/10-eth0.network \
                    ${sysconfdir}/systemd/network/20-ppp0.network \
                    ${sysconfdir}/systemd/network/30-wlan0.network"