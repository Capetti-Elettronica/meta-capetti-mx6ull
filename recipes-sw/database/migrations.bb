LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI = " file://0_drop.sql \
            file://1_init_tables.sql \
            file://2_set_indexes.sql \
            file://3_set_triggers.sql \
            file://4_set_views.sql \
            file://5_gateway_data.sql \
            file://6_default_settings.sql \
            file://7_default_users.sql \
            "

do_install () {
    install -d ${D}/var/lib/gw25lx/migrations
    install -m 0644 ${WORKDIR}/0_drop.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/1_init_tables.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/2_set_indexes.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/3_set_triggers.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/4_set_views.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/5_gateway_data.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/6_default_settings.sql ${D}/var/lib/gw25lx/migrations/
    install -m 0644 ${WORKDIR}/7_default_users.sql ${D}/var/lib/gw25lx/migrations/
}
