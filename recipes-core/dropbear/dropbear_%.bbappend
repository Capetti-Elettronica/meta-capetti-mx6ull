FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " file://dropbear.socket"

do_install:append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/dropbear.socket ${D}${systemd_system_unitdir}/dropbear.socket
}