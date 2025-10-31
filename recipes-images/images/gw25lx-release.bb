DESCRIPTION = "Capetti GW25LX Image"
LICENSE = "MIT"

inherit core-image

## Select Image Features
IMAGE_FEATURES += " \
	debug-tweaks \
	ssh-server-dropbear \
	tools-debug \
"

IMAGE_INSTALL += " \
	brcm-patchram-plus \
	cpufreq \
	dnsmasq \
	hostapd \
	migrations \
	mosquitto-clients \
	packagegroup-core-full-cmdline \
	ppp-config \
	sqlite3 \
	systemd-network-config \
	${PKG_DEBUG} \
"
