
META-CAPETTI-MX6ULL
================

Based on NXP Yocto Kirkstone 2.2 GA and meta-engicam-nxp


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

```
mkdir imx-yocto-bsp
cd imx-yocto-bsp
repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-kirkstone -m imx-5.15.71-2.2.0.xml
repo sync
```

Clone capetti layer
-------------------

```
cd sources
git clone https://github.com/Capetti-Elettronica/meta-capetti-mx6ull -b kirkstone
```


SOMs supported
--------------

- imx6ull-microgea
- imx8mp-icore
- imx8mp-icore-fasteth
- imx8mp-icore-2e
- imx8mp-smarcore
- imx8mm-icore
- imx8ulp-microgea
- imx93-icore
- imx6dl-icore-edimm2
- imx6qd-icore-edimm2
- imx6sx-smarcore
- imx6sx-icore

Supported distros
-----------------

- fsl-imx-wayland: Distro for Wayland without X11. This distro includes wayland feature but doesn’t have X11 support.
- fsl-imx-xwayland: Distro for Wayland with X11. This distro includes both wayland and X11 emulation features.


Images available
----------------

- engicam-evaluation-image-mx6ull
- engicam-evaluation-image-mx6
- engicam-evaluation-image-mx8
- engicam-evaluation-image-mx93


First build
-----------

```
DISTRO=fsl-imx-wayland MACHINE=imx6ull-microgea source imx-setup-release.sh -b build
bitbake-layers add-layer ../sources/meta-capetti-mx6ull
bitbake capetti-gateway-image-debug (or release)
```


Populate SDK
------------

If you also need to modify the gateway binaries you need to populate the SDK. Using Rust you do not need a full cross-compilation toolchain,
however Rust needs to use a sysroot to ensure that everything compiles properly. To do so you need to populate the SDK (non the extended version)

```
bitbake capetti-gateway-image-debug -c populate_sdk
```

