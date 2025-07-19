PATCH_DIR=$(cd $(dirname $0); pwd)
BASE_PATCH_DIR="/home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1"
dry_run=0
verbose=1
update=1
try=0

run_command()
{
    if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
	echo "$1"
    fi
    if [ $dry_run -eq 0 ]; then
	eval "$1"
    fi
}

run_patch()
{
    if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
        echo "## patch ${PATCH_DIR}/${1}"
    fi
    if [ -e "${PATCH_DIR}/${1}" ]; then
        run_command "patch -p1 < ${PATCH_DIR}/${1}"
        run_command "git add --all"
        run_command "git commit -m '[patch] ${1}'"
    elif [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
	echo "## not found ${PATCH_DIR}/${1}"
    fi
}

update_patch()
{
    if [ -e "${PATCH_DIR}/${1}" ]; then
        if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
            echo "## patch already exiists ${PATCH_DIR}/${1}"
        fi
    elif [ -e "${BASE_PATCH_DIR}/${1}" ]; then
        if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
            echo "## make patch ${PATCH_DIR}/${1}"
        fi
        run_command "patch -p1 < ${BASE_PATCH_DIR}/${1}"
        run_command "git add --all"
        run_command "git commit -m '[patch] ${1}'"
        run_command "git diff HEAD^ > ${PATCH_DIR}/${1}"
    else
        if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
            echo "## not found ${BASE_PATCH_DIR}/${1}"
	fi
    fi
}

try_patch()
{
    if [ $dry_run -ne 0 ] || [ $verbose -ne 0 ]; then
	echo "## try patch ${BASE_PATCH_DIR}/${1}"
    fi
    run_command "patch -p1 < ${BASE_PATCH_DIR}/${1}"
}

update_patch 010_arch-arm-mach-zynq.patch
update_patch 011_arch-arm-configs.patch
update_patch 012_arch-arm-boot-dts.patch
update_patch 020_arch-arm64.patch
update_patch 021_arch-arm64-configs.patch
update_patch 022_arch-arm64-boot-dts.patch
update_patch 030_arch-microblaze.patch
update_patch 100_kernel-irq.patch
update_patch 101_net-ipv4.patch
update_patch 102_crypto.patch
update_patch 103_fs-nfsd.patch
update_patch 202_drivers-clk.patch
update_patch 203_drivers-clocksource.patch
update_patch 204_drivers-crypto.patch
update_patch 205_drivers-dma.patch
update_patch 206_drivers-edac.patch
update_patch 207_drivers-firmware.patch
update_patch 208_drivers-fpga.patch
update_patch 210_drivers-gpu-drm.patch
update_patch 211_drivers-hwmon.patch
update_patch 212_drivers-i2c.patch
update_patch 213_drivers-i3c.patch
update_patch 214_drivers-iio.patch
update_patch 216_drivers-irqchip.patch
update_patch 218_drivers-media-common.patch
update_patch 219_drivers-media-i2c.patch
update_patch 220_drivers-media-mc.patch
update_patch 221_drivers-media-platform.patch
update_patch 222_drivers-media-test-drivers.patch
update_patch 224_drivers-media-v4l2.patch
update_patch 225_drivers-mfd.patch
update_patch 226_drivers-misc.patch
update_patch 227_drivers-mmc.patch
update_patch 228_drivers-mtd.patch
update_patch 230_drivers-net-ethernet.patch
update_patch 231_drivers-net-phy.patch
update_patch 234_drivers-nvmem.patch
update_patch 235_drivers-of.patch
update_patch 236_drivers-pci.patch
update_patch 237_drivers-phy.patch
update_patch 238_drivers-pinctrl.patch
update_patch 240_drivers-ptp.patch
update_patch 241_drivers-pwm.patch
update_patch 242_drivers-remoteproc.patch
update_patch 246_drivers-soc-xilinx.patch
update_patch 247_drivers-spi.patch
update_patch 248_drivers-staging.patch
update_patch 249_drivers-thermal.patch
update_patch 250_drivers-tty.patch
update_patch 251_drivers-ufs.patch
update_patch 252_drivers-uio.patch
update_patch 260_drivers-usb-core.patch
update_patch 261_drivers-usb-chipidea.patch
update_patch 262_drivers-usb-dwc3.patch
update_patch 263_drivers-usb-gadget.patch
update_patch 264_drivers-usb-host.patch
update_patch 265_drivers-usb-misc.patch
update_patch 266_drivers-usb-phy.patch
update_patch 271_drivers-video.patch
update_patch 272_drivers-virtio.patch
update_patch 273_drivers-w1.patch
update_patch 275_drivers-xen.patch
update_patch 301_sound-soc-xilinx.patch
update_patch 999_other-document.patch
