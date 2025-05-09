DESCRIPTION = "Capetti GW25LX Image"
LICENSE = "MIT"

inherit core-image

## Select Image Features
IMAGE_FEATURES += " \
	debug-tweaks \
	ssh-server-dropbear \
	tools-debug \
	"

PKG_DEBUG = "\
	devmem2 \
	dosfstools \
	e2fsprogs \
	e2fsprogs-resize2fs \
	engicam-mtd-script \
	ethtool \
	fsl-rc-local \
	i2c-tools \
	imx6ull-lwb5plus \
	imx-kobs \
	iperf3 \
	iproute2 \
	ldd \
	libgpiod \
	libgpiod-tools \
	minicom \
	mtd-utils \
	mtd-utils-ubifs \
	parted \
	serialtools \
	stress-ng \
	usbutils \
	zstd \
"

IMAGE_INSTALL += " \
	brcm-patchram-plus \
	packagegroup-core-full-cmdline \
	packagegroup-tools-bluetooth \
	sqlite3 \
	mosquitto \
	mosquitto-clients \
	ppp \
	hostapd \
	dnsmasq \
	${PKG_DEBUG} \
"
