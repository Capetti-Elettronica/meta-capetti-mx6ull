FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://my-gw.conf"

do_install:append() {
    rm -f ${D}${sysconfdir}/nginx/conf.d/default.conf
    rm -f ${D}${sysconfdir}/nginx/sites-enabled/default_server
    install -d ${D}${sysconfdir}/nginx/conf.d
    install -m 0644 ${WORKDIR}/my-gw.conf ${D}${sysconfdir}/nginx/conf.d/
}

SYSTEMD_AUTO_ENABLE_${PN} = "enable"