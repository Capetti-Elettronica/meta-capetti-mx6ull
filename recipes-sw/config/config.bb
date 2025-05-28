LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://dummy \
            "

do_install () {
    install -d ${D}${sysconfdir}/gw25lx
    install -m 0644 ${WORKDIR}/dummy ${D}${sysconfdir}/gw25lx/
}
