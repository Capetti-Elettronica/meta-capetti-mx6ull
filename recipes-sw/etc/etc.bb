LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://gateway.service \
            file://web_server.service \
            "

do_install () {
    install -d ${D}/etc/systemd/system
    install -m 0644 ${WORKDIR}/gateway.service ${D}/etc/systemd/system/
    install -m 0644 ${WORKDIR}/web_server.service ${D}/etc/systemd/system/
}