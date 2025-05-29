SUMMARY = "Custom network configurations for GW25LX"
DESCRIPTION = "This package provides basic network configuration for all network interfaces"
LICENSE = "CLOSED"

inherit allarch


SRC_URI = " file://eth0.network \
			file://ppp0.network \
			file://wlan0.network \
			"

do_install () {
	install -d ${D}${sysconfdir}/systemd/network
	install -m 644 ${WORKDIR}/eth0.network ${D}${sysconfdir}/systemd/network/eth0.network
	install -m 644 ${WORKDIR}/ppp0.network ${D}${sysconfdir}/systemd/network/ppp0.network
	install -m 644 ${WORKDIR}/wlan0.network ${D}${sysconfdir}/systemd/network/wlan0.network
}


FILES:${PN} += "${sysconfdir}/systemd/network"

CONFFILES:${PN} += "${sysconfdir}/systemd/network/eth0.network \
                    ${sysconfdir}/systemd/network/ppp0.network \
                    ${sysconfdir}/systemd/network/wlan0.network"