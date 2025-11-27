LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://check_gw_sts.sh \
            file://wait_sdma.sh \
            "

do_install () {
    install -d ${D}/usr/bin
    install -m 0744 ${WORKDIR}/check_gw_sts.sh ${D}/usr/bin/
    install -m 0744 ${WORKDIR}/wait_sdma.sh ${D}/usr/bin/
}