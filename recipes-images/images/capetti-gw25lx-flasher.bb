DESCRIPTION = "Capetti GW25LX Image"
LICENSE = "MIT"

inherit core-image

## Select Image Features
IMAGE_FEATURES += " \
	debug-tweaks \
	ssh-server-dropbear \
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
	usbutils \
	zstd \
"

IMAGE_INSTALL += " \
	packagegroup-core-full-cmdline \
	${PKG_DEBUG} \
"
