SUMMARY = "Custom modem configuration with ppp"
DESCRIPTION = "This package provides basic ppp configuration for Simcom 7600 LTE-4G modem"
LICENSE = "CLOSED"

inherit allarch

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI = "file://lte-connect-chat \
           file://ltedial \
          "

RDEPENDS:${PN} += "ppp"

do_install () {
    install -d ${D}${sysconfdir}/chatscripts
    install -d ${D}${sysconfdir}/ppp
    install -d ${D}${sysconfdir}/ppp/peers
    install -m 644 ${WORKDIR}/lte-connect-chat ${D}${sysconfdir}/chatscripts/lte-connect-chat
    install -m 644 ${WORKDIR}/ltedial ${D}${sysconfdir}/ppp/peers/ltedial
}

CONFFILES:${PN} += "${sysconfdir}/chatscripts/lte-connect-chat \
                    ${sysconfdir}/ppp/peers/ltedial"