LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://gateway.service \
            file://wait_sdma.sh \
            "

do_install () {
    install -d ${D}/etc/systemd/system
    install -m 0644 ${WORKDIR}/gateway.service ${D}/etc/systemd/system/
    install -d ${D}/usr/bin
    install -m 0744 ${WORKDIR}/wait_sdma.sh ${D}/usr/bin/
}