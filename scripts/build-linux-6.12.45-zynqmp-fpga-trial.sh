#!/bin/bash

CURRENT_DIR=`pwd`
KERNEL_VERSION=6.12.45
KERNEL_EXTRA_VERSION=-zynqmp-fpga
KERNEL_LOCAL_VERSION=-trial
KERNEL_STABLE_VERSION=v$KERNEL_VERSION
BUILD_VERSION=1
KERNEL_RELEASE=$KERNEL_VERSION$KERNEL_EXTRA_VERSION$KERNEL_LOCAL_VERSION
KERNEL_VERSION_TAG=v$KERNEL_VERSION$KERNEL_EXTRA_VERSION
LINUX_BUILD_DIR=linux-$KERNEL_RELEASE
PATCH_SCRIPT=zynqmp_fpga_patch.sh
KERNEL_DEFCONFIG=zynqmp_fpga_trial_defconfig

echo "KERNEL_VERSION   =" $KERNEL_VERSION
echo "KERNEL_RELEASE   =" $KERNEL_RELEASE
echo "BUILD_VERSION    =" $BUILD_VERSION
echo "LINUX_BUILD_DIR  =" $LINUX_BUILD_DIR
echo "KERNEL_DEFCONFIG =" $KERNEL_DEFCONFIG

## Download Linux Kernel Source

### Clone from linux-stable.git

git clone --depth 1 -b $KERNEL_STABLE_VERSION git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git $LINUX_BUILD_DIR

### Make Branch

cd $LINUX_BUILD_DIR
git checkout -b $KERNEL_RELEASE refs/tags/$KERNEL_STABLE_VERSION

## Patch to Linux Kernel

### Patch for linux-6.12.27-xlnx-2025.1

sh ../patches/linux-$KERNEL_VERSION-xlnx-v2025.1/$PATCH_SCRIPT

### Patch for builddeb

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-builddeb.diff
git add --all
git commit -m "[patch] scripts/package/mkdebian"

### Add ATWILC3000 Linux Driver for Ultra96-V2

rm -rf drivers/net/wireless/microchip/wilc
cp -r ../patches/microchip-wilc-driver/wilc1000 drivers/net/wireless/microchip/wilc
patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-wilc.diff
patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-pwrseq-wilc.diff
git add --all
git commit -m "[add] drivers/net/wireless/microchip/wilc"

### Patch for Ultra96

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-ultra96.diff
git add --all
git commit -m "[patch] for Ultra96."

### Patch for Ultra96-V2

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-ultra96v2.diff 
git add --all
git commit -m "[patch] for Ultra96-V2."

### Patch for Kria KV260

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-kv260.diff 
git add --all
git commit -m "[patch] for Kria KV260."

### Patch for Kria KR260

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-kr260.diff 
git add --all
git commit -m "[patch] for Kria KR260."


### Patch for Lima

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-lima-drv.diff
git add --update
git commit -m "[add] CONFIG_DRM_LIMA_OF_ID_PREFIX to drivers/gpu/drm/lima/Kconfig and lima_drv.c" \
           -m "[add] CONFIG_DRM_LIMA_OF_ID_PARAMETERIZE to drivers/gpu/drm/lima/Kconfig and lima_drv.c"

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-lima-clk.diff
git add --update
git commit -m "[change] clk of lima_device to use clk_bulk."

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-lima-irq.diff
git add --update
git commit -m "[change] lima_device to be able to specify multiple IRQ names."

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-drm-xlnx-align.diff
git add --all
git commit -m "[add] Dumb Buffer Alignment Size to Xilinx DRM KMS Driver for Lima support."

patch -p1 < ../patches/linux-$KERNEL_VERSION$KERNEL_EXTRA_VERSION-drm-xlnx-gem.diff
git add --all
git commit -m "[update] Xilinx DRM KMS Driver to enable data cache for Lima support."

### Add defconfig

cp ../files/$KERNEL_DEFCONFIG arch/arm64/configs/
git add arch/arm64/configs/$KERNEL_DEFCONFIG
git commit -m "[add] $KERNEL_DEFCONFIG to arch/arm64/configs"

## Build

### Create tag and .version

git tag -a $KERNEL_VERSION_TAG -m "release $KERNEL_VERSION_TAG"
echo `expr $BUILD_VERSION - 1` > .version

### Setup for Build 

if [ -z $ARCH ]; then
    export ARCH=arm64
fi
if [ -z $CROSS_COMPILE ]; then
    export CROSS_COMPILE=aarch64-linux-gnu-
fi
make $KERNEL_DEFCONFIG

### Build Linux Kernel and device tree

export DTC_FLAGS=--symbols
rm -rf debian
make deb-pkg

### Install kernel image to this repository

cp arch/arm64/boot/Image.gz ../vmlinuz-$KERNEL_RELEASE-$BUILD_VERSION
cp .config             ../files/config-$KERNEL_RELEASE-$BUILD_VERSION

### Install devicetree to this repository

install -d ../devicetrees/$KERNEL_RELEASE-$BUILD_VERSION
cp arch/arm64/boot/dts/xilinx/* ../devicetrees/$KERNEL_RELEASE-$BUILD_VERSION

