LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://dummy \
            "

do_install () {
    install -d ${D}/var/www/gw25lx
    install -m 0644 ${WORKDIR}/dummy ${D}/var/www/gw25lx/
}