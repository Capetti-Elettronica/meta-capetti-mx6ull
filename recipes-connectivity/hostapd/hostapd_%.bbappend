FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://hostapd.conf"

inherit systemd

SYSTEMD_SERVICE:${PN} = "hostapd.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install:append() {
    install -m 0644 ${WORKDIR}/hostapd.conf ${D}${sysconfdir}/hostapd.conf
}