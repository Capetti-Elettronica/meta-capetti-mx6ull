
META-CAPETTI-MX6ULL
===================

Based on NXP Yocto Scarthgap


Install the `repo` utility:
---------------------------

To use this manifest repo, the `repo` tool must be installed first.

```
$: mkdir ~/bin
$: curl http://commondatastorage.googleapis.com/git-repo-downloads/repo  > ~/bin/repo
$: chmod a+x ~/bin/repo
$: PATH=${PATH}:~/bin
```


Download the Yocto Project BSP
------------------------------

```bash
mkdir gw25lx-scarthgap
cd gw25lx-scarthgap
repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-scarthgap -m imx-6.6.52-2.2.0.xml 
repo sync
```

Clone capetti layer
-------------------

```
cd sources
git clone https://github.com/Capetti-Elettronica/meta-capetti-mx6ull -b scarthgap
```

SOMs supported
--------------

- imx6dl-icore
- imx6qd-icore
- imx6ull-microgea
- imx8mm-icore
- imx8mp-icore
- imx8mp-icore-2e
- imx8mp-icore-fasteth
- imx8mp-smarcore
- imx8ulp-microgea
- imx91-microgea
- imx93-icore



Boards supported
----------------



|SOM                   |                BOARD                |
|----------------------|-------------------------------------|
|imx93-icore           |ctouch2                              |
|imx91-microgea        |microdev-rev3                        |
|                      |micro5                               |
|imx8mm-icore          |ctouch2                              |
|                      |starterkit-v2                        |
|imx8mp-icore-2e       |ctouch2                              |
|                      |starterkit-v2                        |
|imx8mp-icore-fasteth  |ctouch2                              |
|                      |starterkit-v2                        |
|imx8mp-icore          |ctouch2                              |
|                      |starterkit-v2                        |
|imx8ulp-microgea      |microdev-rev3                        |
|imx8mp-smarcore       |xtouch2                              |
|                      |starterkit-v2                        |
|imx6dl-icore          |starterkit-v2                        |
|imx6qd-icore          |starterkit-v2                        |
|imx6ull-microgea      |microdev-rev3                        |



Supported distros
-----------------

- fsl-imx-wayland: Distro for Wayland without X11. This distro includes wayland feature but doesn’t have X11 support.
- fsl-imx-xwayland: Distro for Wayland with X11. This distro includes both wayland and X11 emulation features.

Images available
----------------

- engicam-evaluation-image-mx6
- engicam-evaluation-image-mx6ull
- engicam-evaluation-image-mx8
- engicam-evaluation-image-mx93
- engicam-evaluation-image-mx91

First build
-----------

```
DISTRO=fsl-imx-wayland MACHINE=imx6ull-microgea source imx-setup-release.sh -b build
bitbake-layers add-layer ../sources/meta-capetti-mx6ull
bitbake capetti-gateway-image-debug (or release)
```

Flash on SD-Card
----------------

Once ready, you could flash your image onto an sd-card. 

```
cd tmp/deploy/images/imx6ull-microgea
zstdcat -cd capetti-gateway-image-debug-imx6ull-microgea.wic.zst | sudo dd of=/dev/sdb bs=10M status=progress && sync
```


Populate SDK
------------

If you also need to modify the gateway binaries you need to populate the SDK. Using Rust you do not need a full cross-compilation toolchain,
however Rust needs to use a sysroot to ensure that everything compiles properly. To do so you need to populate the SDK (non the extended version)

```
bitbake capetti-gateway-image-debug -c populate_sdk
```

Modifying an Existing Recipe
-------

In case you need to customize some recipes before creating a custom repo for them, use this approach:

```
devtool modify linux-engicam
devtool modify u-boot-engicam
```

Create SYSROOT
--------------

In case you prefer to have an external/custom sysroot or if yocto sdk has some problem creating it, follow these passages

```
mkdir "your sysroot dir"
sudo debootstrap --arch=armhf --foreign bookworm "/path/to/your/sysroot/folder" http://deb.debian.org/debian/
```

Be sure to have in your project the path to the sysroot properly set.