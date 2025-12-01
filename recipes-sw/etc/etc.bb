LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://check_gw_sts.service \
            file://wait_sdma.service \
            "

inherit systemd

SYSTEMD_SERVICE:${PN} = "check_gw_sts.service wait_sdma.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install () {
    install -d ${D}/etc/systemd/system
    install -m 0644 ${WORKDIR}/check_gw_sts.service ${D}/etc/systemd/system/
    install -m 0644 ${WORKDIR}/wait_sdma.service ${D}/etc/systemd/system/
}
