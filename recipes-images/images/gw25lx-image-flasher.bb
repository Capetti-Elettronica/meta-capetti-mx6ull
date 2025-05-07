# Copyright (C) 2015 Freescale Semiconductor
# Copyright 2017-2019 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Capetti GW25LX Flasher Image"
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
	ethtool \
	i2c-tools \
	iproute2 \
	e2fsprogs-resize2fs \
	usbutils \
	fsl-rc-local \
	engicam-mtd-script \
	mtd-utils \
	mtd-utils-ubifs \
	imx-kobs \
	u-boot-fw-utils \
	zstd \
"

IMAGE_INSTALL += " \
	packagegroup-core-full-cmdline \
	${PKG_DEBUG} \
"
