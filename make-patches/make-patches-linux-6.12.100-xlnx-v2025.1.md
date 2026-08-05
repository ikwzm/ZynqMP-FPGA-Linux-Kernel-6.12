Make ./paches/linux-6.12.100-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.95

```console
shell$ git clone --depth 1 -b v6.12.95 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.95
```

### Get linux-6.12.95-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.95 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.95-xlnx-v2025.1
shell$ cd linux-6.12.95-xlnx-v2025.1
shell$ git checkout -b linux-6.12.95-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.95-xlnx-v2025.1/origin_patch.sh
shell$ cd ..
```

### Get linux-6.12.100

```console
shell$ git clone --depth 1 -b v6.12.100 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.100
```

### Make diff-linux-6.12.95-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.95-xlnx-v2025.1 -A linux-6.12.95 -B linux-6.12.95-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.95-xlnx-v2025.1.txt linux-6.12.95 linux-6.12.95-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.95-xlnx-v2025.1
## A   : {name: linux-6.12.95, path: linux-6.12.95}
## B   : {name: linux-6.12.95-xlnx-v2025.1, path: linux-6.12.95-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.95-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.95-6.12.100.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.95-6.12.100 -A linux-6.12.95 -B linux-6.12.100 -o ./make-patches/diff-linux-6.12.95-6.12.100.txt linux-6.12.95 linux-6.12.100 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.95-6.12.100
## A   : {name: linux-6.12.95, path: linux-6.12.95}
## B   : {name: linux-6.12.100, path: linux-6.12.100}
## OUT : ./make-patches/diff-linux-6.12.95-6.12.100.txt
```

### Compare diff-linux-6.12.95-6.12.100.txt and diff-linux-6.12.95-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.95-6.12.100.txt make-patches/diff-linux-6.12.95-xlnx-v2025.1.txt
contents: 
 - U: drivers/gpu/drm/drm_edid.c
 - U: drivers/hwmon/Kconfig
 - U: drivers/iio/adc/Kconfig
 - U: drivers/iio/adc/xilinx-ams.c
 - U: drivers/media/v4l2-core/v4l2-common.c
 - U: drivers/mfd/rsmu_i2c.c
 - U: drivers/mtd/spi-nor/spansion.c
 - U: drivers/mtd/spi-nor/swp.c
 - U: drivers/pci/controller/pcie-xilinx-nwl.c
 - U: drivers/soc/xilinx/zynqmp_power.c
 - U: drivers/spi/spi-xilinx.c
 - U: drivers/spi/spi.c
 - U: drivers/ufs/core/ufshcd.c
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/host/xhci.c
```

### Make linux-6.12.100-xlnx-v2025.1

#### make patches/linux-6.12.100-xlnx-v2025.1

#### make patches/linux-6.12.100-xlnx-v2025.1/xxx_update.sh

```sh:patches/linux-6.12.100-xlnx-v2025.1/xxx_update.sh
PATCH_DIR=$(cd $(dirname $0); pwd)
BASE_PATCH_DIR="$PATCH_DIR/../linux-6.12.95-xlnx-v2025.1"
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

update_patch 002_include.patch
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
update_patch 217_drivers-mailbox.patch
update_patch 218_drivers-media-common.patch
update_patch 219_drivers-media-i2c.patch
update_patch 220_drivers-media-mc.patch
update_patch 221_drivers-media-platform.patch
update_patch 222_drivers-media-test-drivers.patch
update_patch 224_drivers-media-v4l2.patch
update_patch 225_drivers-mfd.patch
update_patch 226_drivers-misc.patch
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
update_patch 243_drivers-reset.patch
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
update_patch 266_drivers-usb-phy.patch
update_patch 271_drivers-video.patch
update_patch 272_drivers-virtio.patch
update_patch 273_drivers-w1.patch
update_patch 275_drivers-xen.patch
update_patch 301_sound-soc-xilinx.patch
update_patch 999_other-document.patch
```

#### make linux-6.12.100-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.100 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.100-xlnx-v2025.1
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-1
```

#### run patches/linux-6.12.100-xlnx-v2025.1/xxx_update.sh

```console
shell$ sh ../patches/linux-6.12.100-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/002_include.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/002_include.patch
patching file include/linux/regmap.h
git add --all
git commit -m '[patch] 002_include.patch'
[linux-6.12.100-xlnx-v2025.1-1 dd668967e] [patch] 002_include.patch
 1 file changed, 16 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/002_include.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patching file arch/arm/mach-zynq/Makefile
patching file arch/arm/mach-zynq/common.c
patching file arch/arm/mach-zynq/common.h
patching file arch/arm/mach-zynq/efuse.c
patching file arch/arm/mach-zynq/platsmp.c
git add --all
git commit -m '[patch] 010_arch-arm-mach-zynq.patch'
[linux-6.12.100-xlnx-v2025.1-1 aba2eeb8a] [patch] 010_arch-arm-mach-zynq.patch
 5 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-zynq/efuse.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/011_arch-arm-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/011_arch-arm-configs.patch
patching file arch/arm/configs/xilinx_zynq_defconfig
git add --all
git commit -m '[patch] 011_arch-arm-configs.patch'
[linux-6.12.100-xlnx-v2025.1-1 015297c8f] [patch] 011_arch-arm-configs.patch
 1 file changed, 222 insertions(+)
 create mode 100644 arch/arm/configs/xilinx_zynq_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/012_arch-arm-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/012_arch-arm-boot-dts.patch
patching file arch/arm/boot/dts/xilinx/zynq-7000.dtsi
patching file arch/arm/boot/dts/xilinx/zynq-cc108.dts
patching file arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts
patching file arch/arm/boot/dts/xilinx/zynq-parallella.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc702.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc706.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts
patching file arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts
patching file arch/arm/boot/dts/xilinx/zynq-zed.dts
patching file arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts
patching file arch/arm/boot/dts/xilinx/zynq-zybo.dts
git add --all
git commit -m '[patch] 012_arch-arm-boot-dts.patch'
[linux-6.12.100-xlnx-v2025.1-1 eaefd1b99] [patch] 012_arch-arm-boot-dts.patch
 13 files changed, 421 insertions(+), 69 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/020_arch-arm64.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/020_arch-arm64.patch
patching file Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
patching file arch/arm64/kernel/irq.c
git add --all
git commit -m '[patch] 020_arch-arm64.patch'
[linux-6.12.100-xlnx-v2025.1-1 2be2cc1c6] [patch] 020_arch-arm64.patch
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/021_arch-arm64-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/021_arch-arm64-configs.patch
patching file arch/arm64/configs/defconfig
patching file arch/arm64/configs/xilinx_defconfig
git add --all
git commit -m '[patch] 021_arch-arm64-configs.patch'
[linux-6.12.100-xlnx-v2025.1-1 912f9b90c] [patch] 021_arch-arm64-configs.patch
 2 files changed, 670 insertions(+)
 create mode 100644 arch/arm64/configs/xilinx_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patching file arch/arm64/boot/dts/xilinx/Makefile
patching file arch/arm64/boot/dts/xilinx/versal-clk.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-emb-plus-ve2302-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-net-clk-ccf.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-net-vn-p-b2197-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-net.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-v350-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA-ospi.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA-ospi.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-05-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck190-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vck5000-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vek280-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vek280-revB.dts
patching file arch/arm64/boot/dts/xilinx/versal-vhk158-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vmk180-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vp-x-a2785-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vpk120-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-vpk120-revB.dts
patching file arch/arm64/boot/dts/xilinx/versal-vpk180-revA.dts
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtso
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtso
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtsi
patching file arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtso
patching file arch/arm64/boot/dts/xilinx/versal.dtsi
patching file arch/arm64/boot/dts/xilinx/x-prc-07-i3c-revA.dtso
patching file arch/arm64/boot/dts/xilinx/x-prc-07-revA.dtso
patching file arch/arm64/boot/dts/xilinx/x-prc-08-revA.dtso
patching file arch/arm64/boot/dts/xilinx/x-prc-09-i3c-revA.dtso
patching file arch/arm64/boot/dts/xilinx/x-prc-09-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-a2197-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
patching file arch/arm64/boot/dts/xilinx/zynqmp-dlc21-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revB.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-g-a2197-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-01-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-02-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-03-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-revB.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-revC.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revB.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vhk158-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vm-p-m1369-00-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vn-p-b2197-00-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk120-revB.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revB.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
patching file arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-vp-x-a2785-00-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-vpk120-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revB.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu1285-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu208-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu216-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revA.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revB.dts
patching file arch/arm64/boot/dts/xilinx/zynqmp.dtsi
patching file include/dt-bindings/clock/xlnx-versal-net-clk.h
patching file include/dt-bindings/power/xlnx-versal-net-power.h
patching file include/dt-bindings/power/xlnx-versal-power.h
patching file include/dt-bindings/power/xlnx-versal-regnode.h
patching file include/dt-bindings/reset/xlnx-versal-net-resets.h
git add --all
git commit -m '[patch] 022_arch-arm64-boot-dts.patch'
[linux-6.12.100-xlnx-v2025.1-1 683d29261] [patch] 022_arch-arm64-boot-dts.patch
 114 files changed, 19966 insertions(+), 148 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-emb-plus-ve2302-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-clk-ccf.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-vn-p-b2197-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-net.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-v350-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA-ospi.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA-ospi.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-05-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck190-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vck5000-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vek280-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vek280-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vhk158-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vmk180-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vp-x-a2785-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vpk120-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vpk120-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-vpk180-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/versal.dtsi
 create mode 100644 arch/arm64/boot/dts/xilinx/x-prc-07-i3c-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/x-prc-07-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/x-prc-08-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/x-prc-09-i3c-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/x-prc-09-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-a2197-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-dlc21-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-g-a2197-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-01-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-02-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-03-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-revC.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vhk158-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vm-p-m1369-00-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vn-p-b2197-00-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk120-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-vp-x-a2785-00-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-vpk120-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revB.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu1285-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu208-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu216-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revA.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revB.dts
 create mode 100644 include/dt-bindings/clock/xlnx-versal-net-clk.h
 create mode 100644 include/dt-bindings/power/xlnx-versal-net-power.h
 create mode 100644 include/dt-bindings/power/xlnx-versal-power.h
 create mode 100644 include/dt-bindings/power/xlnx-versal-regnode.h
 create mode 100644 include/dt-bindings/reset/xlnx-versal-net-resets.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/030_arch-microblaze.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/030_arch-microblaze.patch
patching file arch/microblaze/configs/mmu_defconfig
patching file arch/microblaze/include/asm/sections.h
patching file arch/microblaze/kernel/head.S
patching file arch/microblaze/kernel/setup.c
patching file arch/microblaze/kernel/vmlinux.lds.S
patching file arch/microblaze/mm/init.c
git add --all
git commit -m '[patch] 030_arch-microblaze.patch'
[linux-6.12.100-xlnx-v2025.1-1 dd1129fb9] [patch] 030_arch-microblaze.patch
 6 files changed, 22 insertions(+), 11 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/100_kernel-irq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/100_kernel-irq.patch
patching file kernel/irq/handle.c
git add --all
git commit -m '[patch] 100_kernel-irq.patch'
[linux-6.12.100-xlnx-v2025.1-1 634a38084] [patch] 100_kernel-irq.patch
 1 file changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/101_net-ipv4.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/101_net-ipv4.patch
patching file net/ipv4/af_inet.c
git add --all
git commit -m '[patch] 101_net-ipv4.patch'
[linux-6.12.100-xlnx-v2025.1-1 3c9583b32] [patch] 101_net-ipv4.patch
 1 file changed, 6 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/102_crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/102_crypto.patch
patching file crypto/ecdsa.c
git add --all
git commit -m '[patch] 102_crypto.patch'
[linux-6.12.100-xlnx-v2025.1-1 64df5098e] [patch] 102_crypto.patch
 1 file changed, 4 insertions(+), 8 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/202_drivers-clk.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/202_drivers-clk.patch
patching file Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt
patching file Documentation/devicetree/bindings/clock/renesas,proxo.yaml
patching file Documentation/devicetree/bindings/clock/silabs,si5324.txt
patching file Documentation/devicetree/bindings/clock/xlnx,fclk.yaml
patching file Documentation/devicetree/bindings/clock/xlnx,vcu.yaml
patching file Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt
patching file drivers/clk/Kconfig
patching file drivers/clk/Makefile
patching file drivers/clk/clk-proxo.c
patching file drivers/clk/clk-si5324.c
patching file drivers/clk/clk-si5324.h
patching file drivers/clk/idt/Makefile
patching file drivers/clk/idt/clk-idt8t49n24x-core.c
patching file drivers/clk/idt/clk-idt8t49n24x-core.h
patching file drivers/clk/idt/clk-idt8t49n24x-debugfs.c
patching file drivers/clk/idt/clk-idt8t49n24x-debugfs.h
patching file drivers/clk/idt/clk-idt8t49n24x.c
patching file drivers/clk/si5324.h
patching file drivers/clk/si5324drv.c
patching file drivers/clk/si5324drv.h
patching file drivers/clk/xilinx/clk-xlnx-clock-wizard.c
patching file drivers/clk/xilinx/xlnx_vcu.c
patching file drivers/clk/zynqmp/clkc.c
git add --all
git commit -m '[patch] 202_drivers-clk.patch'
[linux-6.12.100-xlnx-v2025.1-1 95a9eaafe] [patch] 202_drivers-clk.patch
 24 files changed, 5304 insertions(+), 261 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/silabs,si5324.txt
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,fclk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,vcu.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt
 create mode 100644 drivers/clk/clk-proxo.c
 create mode 100644 drivers/clk/clk-si5324.c
 create mode 100644 drivers/clk/clk-si5324.h
 create mode 100644 drivers/clk/idt/Makefile
 create mode 100644 drivers/clk/idt/clk-idt8t49n24x-core.c
 create mode 100644 drivers/clk/idt/clk-idt8t49n24x-core.h
 create mode 100644 drivers/clk/idt/clk-idt8t49n24x-debugfs.c
 create mode 100644 drivers/clk/idt/clk-idt8t49n24x-debugfs.h
 create mode 100644 drivers/clk/idt/clk-idt8t49n24x.c
 create mode 100644 drivers/clk/si5324.h
 create mode 100644 drivers/clk/si5324drv.c
 create mode 100644 drivers/clk/si5324drv.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/203_drivers-clocksource.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/203_drivers-clocksource.patch
patching file drivers/clocksource/timer-cadence-ttc.c
git add --all
git commit -m '[patch] 203_drivers-clocksource.patch'
[linux-6.12.100-xlnx-v2025.1-1 f97cb8857] [patch] 203_drivers-clocksource.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/204_drivers-crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/204_drivers-crypto.patch
patching file Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
patching file drivers/crypto/Kconfig
patching file drivers/crypto/xilinx/Makefile
patching file drivers/crypto/xilinx/xilinx-ecdsa.c
patching file drivers/crypto/xilinx/xilinx-rsa.c
patching file drivers/crypto/xilinx/xilinx_ecdsasig.asn1
patching file drivers/crypto/xilinx/zynqmp-aes-gcm.c
patching file drivers/crypto/xilinx/zynqmp-rsa.c
patching file drivers/crypto/xilinx/zynqmp-sha.c
patching file include/crypto/ecdsa.h
git add --all
git commit -m '[patch] 204_drivers-crypto.patch'
[linux-6.12.100-xlnx-v2025.1-1 3bfeba33a] [patch] 204_drivers-crypto.patch
 10 files changed, 2385 insertions(+), 258 deletions(-)
 create mode 100644 drivers/crypto/xilinx/xilinx-ecdsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx_ecdsasig.asn1
 create mode 100644 drivers/crypto/xilinx/zynqmp-rsa.c
 create mode 100644 include/crypto/ecdsa.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/205_drivers-dma.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/205_drivers-dma.patch
patching file Documentation/devicetree/bindings/dma/xilinx/amd,mmi-dcdma-1.0.yaml
patching file Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma-test.yaml
patching file Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-frmbuf.yaml
patching file Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-vdma-test.yaml
patching file drivers/dma/Kconfig
patching file drivers/dma/xilinx/Makefile
patching file drivers/dma/xilinx/axidmatest.c
patching file drivers/dma/xilinx/mmi_dcdma.c
patching file drivers/dma/xilinx/vdmatest.c
patching file drivers/dma/xilinx/xilinx_frmbuf.c
patching file drivers/dma/xilinx/zynqmp_dma.c
patching file include/linux/dma/xilinx_frmbuf.h
git add --all
git commit -m '[patch] 205_drivers-dma.patch'
[linux-6.12.100-xlnx-v2025.1-1 2bfba0782] [patch] 205_drivers-dma.patch
 12 files changed, 5268 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/amd,mmi-dcdma-1.0.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma-test.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-frmbuf.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-vdma-test.yaml
 create mode 100644 drivers/dma/xilinx/axidmatest.c
 create mode 100644 drivers/dma/xilinx/mmi_dcdma.c
 create mode 100644 drivers/dma/xilinx/vdmatest.c
 create mode 100644 drivers/dma/xilinx/xilinx_frmbuf.c
 create mode 100644 include/linux/dma/xilinx_frmbuf.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/206_drivers-edac.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/206_drivers-edac.patch
patching file Documentation/ABI/testing/sysfs-driver-xilsem-edac
patching file Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
patching file drivers/edac/Kconfig
patching file drivers/edac/Makefile
patching file drivers/edac/versal_edac.c
patching file drivers/edac/xilinx_xilsem_edac.c
git add --all
git commit -m '[patch] 206_drivers-edac.patch'
[linux-6.12.100-xlnx-v2025.1-1 6b801c584] [patch] 206_drivers-edac.patch
 6 files changed, 1671 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/207_drivers-firmware.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/207_drivers-firmware.patch
patching file Documentation/ABI/stable/sysfs-driver-firmware-zynqmp
patching file Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
patching file drivers/firmware/xilinx/Kconfig
patching file drivers/firmware/xilinx/Makefile
patching file drivers/firmware/xilinx/zynqmp-core.c
patching file drivers/firmware/xilinx/zynqmp-crypto.c
patching file drivers/firmware/xilinx/zynqmp-debug.c
patching file drivers/firmware/xilinx/zynqmp-fpga.c
patching file drivers/firmware/xilinx/zynqmp-nvm.c
patching file drivers/firmware/xilinx/zynqmp-pdi.c
patching file drivers/firmware/xilinx/zynqmp-pm.c (renamed from drivers/firmware/xilinx/zynqmp.c)
patching file drivers/firmware/xilinx/zynqmp-secure.c
patching file drivers/firmware/xilinx/zynqmp-sem.c
patching file include/linux/firmware/amd-versal2-error-events.h
patching file include/linux/firmware/xlnx-versal-error-events.h
patching file include/linux/firmware/xlnx-versal-net-error-events.h
patching file include/linux/firmware/xlnx-zynqmp-fpga.h
patching file include/linux/firmware/xlnx-zynqmp-nvm.h
patching file include/linux/firmware/xlnx-zynqmp-pdi.h
patching file include/linux/firmware/xlnx-zynqmp-secure.h
patching file include/linux/firmware/xlnx-zynqmp-sem.h
patching file include/linux/firmware/xlnx-zynqmp.h
git add --all
git commit -m '[patch] 207_drivers-firmware.patch'
[linux-6.12.100-xlnx-v2025.1-1 fb6529679] [patch] 207_drivers-firmware.patch
 22 files changed, 6774 insertions(+), 740 deletions(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp-core.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-crypto.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-fpga.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-nvm.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-pdi.c
 rename drivers/firmware/xilinx/{zynqmp.c => zynqmp-pm.c} (68%)
 create mode 100644 drivers/firmware/xilinx/zynqmp-secure.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-sem.c
 create mode 100644 include/linux/firmware/amd-versal2-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-fpga.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-nvm.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-pdi.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-secure.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-sem.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/208_drivers-fpga.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/208_drivers-fpga.patch
patching file Documentation/ABI/testing/sysfs-class-fpga-bridge
patching file Documentation/devicetree/bindings/fpga/fpga-region.yaml
patching file Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
patching file Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml
patching file drivers/fpga/Kconfig
patching file drivers/fpga/Makefile
patching file drivers/fpga/fpga-bridge.c
patching file drivers/fpga/fpga-mgr.c
patching file drivers/fpga/of-fpga-region.c
patching file drivers/fpga/versal-fpga.c
patching file drivers/fpga/xilinx-afi.c
patching file drivers/fpga/zynq-afi.c
patching file drivers/fpga/zynqmp-fpga.c
patching file include/linux/fpga/fpga-mgr.h
git add --all
git commit -m '[patch] 208_drivers-fpga.patch'
[linux-6.12.100-xlnx-v2025.1-1 367ef2ee7] [patch] 208_drivers-fpga.patch
 14 files changed, 982 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml
 create mode 100644 drivers/fpga/xilinx-afi.c
 create mode 100644 drivers/fpga/zynq-afi.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/210_drivers-gpu-drm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/210_drivers-gpu-drm.patch
patching file Documentation/devicetree/bindings/display/xlnx/amd,mmi-dc.yaml
patching file Documentation/devicetree/bindings/display/xlnx/bridge.txt
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,dp-tx.yaml
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,mixer.txt
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,pl-disp.txt
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,sdi-tx.yaml
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,v-hdmi-txss1.yaml
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-csc.yaml
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-scaler.yaml
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.txt
patching file Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml
patching file Documentation/gpu/drivers.rst
patching file Documentation/gpu/zynqmp.rst
patching file drivers/gpu/drm/display/drm_hdmi_helper.c
patching file drivers/gpu/drm/drm_atomic_state_helper.c
patching file drivers/gpu/drm/drm_atomic_uapi.c
patching file drivers/gpu/drm/drm_connector.c
patching file drivers/gpu/drm/drm_edid.c
patching file drivers/gpu/drm/drm_fb_dma_helper.c
patching file drivers/gpu/drm/drm_fourcc.c
patching file drivers/gpu/drm/drm_framebuffer.c
patching file drivers/gpu/drm/panel/panel-simple.c
patching file drivers/gpu/drm/xlnx/Kconfig
patching file drivers/gpu/drm/xlnx/Makefile
patching file drivers/gpu/drm/xlnx/hdcp/Makefile
patching file drivers/gpu/drm/xlnx/hdcp/xhdcp1x_tx.c
patching file drivers/gpu/drm/xlnx/hdcp/xhdcp1x_tx.h
patching file drivers/gpu/drm/xlnx/hdcp/xhdcp2x_tx.c
patching file drivers/gpu/drm/xlnx/hdcp/xhdcp2x_tx.h
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_keymngt.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_tx.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_tx.h
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_crypt.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_tx.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_tx.h
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_sha1.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_sha1.h
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_tx.c
patching file drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_tx.h
patching file drivers/gpu/drm/xlnx/mmi_dc.c
patching file drivers/gpu/drm/xlnx/mmi_dc.h
patching file drivers/gpu/drm/xlnx/mmi_dc_kms.c
patching file drivers/gpu/drm/xlnx/mmi_dc_plane.c
patching file drivers/gpu/drm/xlnx/xlnx_bridge.c
patching file drivers/gpu/drm/xlnx/xlnx_bridge.h
patching file drivers/gpu/drm/xlnx/xlnx_crtc.c
patching file drivers/gpu/drm/xlnx/xlnx_crtc.h
patching file drivers/gpu/drm/xlnx/xlnx_csc.c
patching file drivers/gpu/drm/xlnx/xlnx_dptx.c
patching file drivers/gpu/drm/xlnx/xlnx_drv.c
patching file drivers/gpu/drm/xlnx/xlnx_drv.h
patching file drivers/gpu/drm/xlnx/xlnx_dsi.c
patching file drivers/gpu/drm/xlnx/xlnx_fb.c
patching file drivers/gpu/drm/xlnx/xlnx_fb.h
patching file drivers/gpu/drm/xlnx/xlnx_gem.c
patching file drivers/gpu/drm/xlnx/xlnx_gem.h
patching file drivers/gpu/drm/xlnx/xlnx_hdmi.c
patching file drivers/gpu/drm/xlnx/xlnx_mixer.c
patching file drivers/gpu/drm/xlnx/xlnx_pl_disp.c
patching file drivers/gpu/drm/xlnx/xlnx_scaler.c
patching file drivers/gpu/drm/xlnx/xlnx_sdi.c
patching file drivers/gpu/drm/xlnx/xlnx_sdi_modes.h
patching file drivers/gpu/drm/xlnx/xlnx_sdi_timing.c
patching file drivers/gpu/drm/xlnx/xlnx_sdi_timing.h
patching file drivers/gpu/drm/xlnx/xlnx_vtc.c
patching file drivers/gpu/drm/xlnx/zynqmp_disp.c
patching file drivers/gpu/drm/xlnx/zynqmp_disp.h
patching file drivers/gpu/drm/xlnx/zynqmp_disp_regs.h
patching file drivers/gpu/drm/xlnx/zynqmp_dp.c
patching file drivers/gpu/drm/xlnx/zynqmp_dp.h
patching file drivers/gpu/drm/xlnx/zynqmp_dp_audio.c
patching file drivers/gpu/drm/xlnx/zynqmp_dpsub.c
patching file drivers/gpu/drm/xlnx/zynqmp_dpsub.h
patching file drivers/gpu/drm/xlnx/zynqmp_kms.c
patching file include/drm/display/drm_dp.h
patching file include/drm/display/drm_hdmi_helper.h
patching file include/drm/drm_connector.h
patching file include/drm/drm_edid.h
patching file include/drm/drm_fourcc.h
patching file include/drm/drm_mode_config.h
patching file include/dt-bindings/drm/mipi-dsi.h
patching file include/uapi/drm/drm_fourcc.h
patching file include/uapi/drm/drm_mode.h
git add --all
git commit -m '[patch] 210_drivers-gpu-drm.patch'
[linux-6.12.100-xlnx-v2025.1-1 65c096d95] [patch] 210_drivers-gpu-drm.patch
 84 files changed, 32628 insertions(+), 168 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/amd,mmi-dc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/bridge.txt
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,dp-tx.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,mixer.txt
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,pl-disp.txt
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,sdi-tx.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,v-hdmi-txss1.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-csc.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-scaler.yaml
 create mode 100644 Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.txt
 create mode 100644 Documentation/gpu/zynqmp.rst
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/Makefile
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xhdcp1x_tx.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xhdcp1x_tx.h
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xhdcp2x_tx.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xhdcp2x_tx.h
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_keymngt.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_tx.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp1x_tx.h
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_crypt.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_tx.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp2x_tx.h
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_sha1.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_sha1.h
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_tx.c
 create mode 100644 drivers/gpu/drm/xlnx/hdcp/xlnx_hdcp_tx.h
 create mode 100644 drivers/gpu/drm/xlnx/mmi_dc.c
 create mode 100644 drivers/gpu/drm/xlnx/mmi_dc.h
 create mode 100644 drivers/gpu/drm/xlnx/mmi_dc_kms.c
 create mode 100644 drivers/gpu/drm/xlnx/mmi_dc_plane.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_bridge.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_bridge.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_crtc.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_crtc.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_csc.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_dptx.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_drv.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_drv.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_dsi.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_fb.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_fb.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_gem.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_gem.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_hdmi.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_mixer.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_pl_disp.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_scaler.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_sdi.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_sdi_modes.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_sdi_timing.c
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_sdi_timing.h
 create mode 100644 drivers/gpu/drm/xlnx/xlnx_vtc.c
 create mode 100644 drivers/gpu/drm/xlnx/zynqmp_dp_audio.c
 create mode 100644 include/dt-bindings/drm/mipi-dsi.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/211_drivers-hwmon.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
patching file Documentation/hwmon/ina2xx.rst
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 2170 (offset 3 lines).
patching file drivers/hwmon/ina2xx.c
git add --all
git commit -m '[patch] 211_drivers-hwmon.patch'
[linux-6.12.100-xlnx-v2025.1-1 b967f01e3] [patch] 211_drivers-hwmon.patch
 5 files changed, 2700 insertions(+), 18 deletions(-)
 create mode 100644 drivers/hwmon/Kconfig.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/212_drivers-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/212_drivers-i2c.patch
patching file drivers/i2c/busses/i2c-cadence.c
patching file drivers/i2c/busses/i2c-xiic.c
patching file drivers/i2c/i2c-atr.c
patching file include/linux/i2c-atr.h
git add --all
git commit -m '[patch] 212_drivers-i2c.patch'
[linux-6.12.100-xlnx-v2025.1-1 8f3e8093b] [patch] 212_drivers-i2c.patch
 4 files changed, 990 insertions(+), 357 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/213_drivers-i3c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/213_drivers-i3c.patch
patching file Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
git add --all
git commit -m '[patch] 213_drivers-i3c.patch'
[linux-6.12.100-xlnx-v2025.1-1 74b012c27] [patch] 213_drivers-i3c.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/214_drivers-iio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
Hunk #1 succeeded at 618 (offset 1 line).
Hunk #2 succeeded at 1661 (offset 1 line).
patching file drivers/iio/adc/Makefile
patching file drivers/iio/adc/ina260-adc.c
patching file drivers/iio/adc/versal-sysmon-core.c
patching file drivers/iio/adc/versal-sysmon-i2c.c
patching file drivers/iio/adc/versal-sysmon.c
patching file drivers/iio/adc/versal-sysmon.h
patching file drivers/iio/adc/xilinx-ams.c
Hunk #19 succeeded at 930 (offset 3 lines).
Hunk #20 succeeded at 968 (offset 3 lines).
Hunk #21 succeeded at 983 (offset 3 lines).
Hunk #22 succeeded at 993 (offset 3 lines).
Hunk #23 succeeded at 1018 (offset 3 lines).
Hunk #24 succeeded at 1045 (offset 3 lines).
Hunk #25 succeeded at 1057 (offset 3 lines).
Hunk #26 succeeded at 1081 (offset 5 lines).
Hunk #27 succeeded at 1147 (offset 5 lines).
Hunk #28 succeeded at 1193 (offset 5 lines).
Hunk #29 succeeded at 1404 (offset 5 lines).
Hunk #30 succeeded at 1420 (offset 5 lines).
patching file drivers/iio/adc/xilinx-xadc-core.c
patching file include/linux/iio/adc/versal-sysmon-events.h
git add --all
git commit -m '[patch] 214_drivers-iio.patch'
[linux-6.12.100-xlnx-v2025.1-1 91c316d23] [patch] 214_drivers-iio.patch
 13 files changed, 6158 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/Kconfig.orig
 create mode 100644 drivers/iio/adc/ina260-adc.c
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 drivers/iio/adc/xilinx-ams.c.orig
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/216_drivers-irqchip.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/216_drivers-irqchip.patch
patching file Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
patching file drivers/irqchip/Kconfig
patching file drivers/irqchip/irq-xilinx-intc.c
patching file drivers/irqchip/irqchip.c
patching file include/linux/irq.h
patching file include/linux/irqchip.h
patching file include/linux/of_irq.h
git add --all
git commit -m '[patch] 216_drivers-irqchip.patch'
[linux-6.12.100-xlnx-v2025.1-1 3a08f7436] [patch] 216_drivers-irqchip.patch
 7 files changed, 286 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/217_drivers-mailbox.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/217_drivers-mailbox.patch
patching file Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
patching file drivers/mailbox/zynqmp-ipi-mailbox.c
git add --all
git commit -m '[patch] 217_drivers-mailbox.patch'
[linux-6.12.100-xlnx-v2025.1-1 d0c8cc4ac] [patch] 217_drivers-mailbox.patch
 2 files changed, 6 insertions(+), 2 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/217_drivers-mailbox.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/218_drivers-media-common.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/218_drivers-media-common.patch
patching file drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
git add --all
git commit -m '[patch] 218_drivers-media-common.patch'
[linux-6.12.100-xlnx-v2025.1-1 2552c89af] [patch] 218_drivers-media-common.patch
 1 file changed, 10 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/219_drivers-media-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/219_drivers-media-i2c.patch
patching file Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
patching file drivers/media/i2c/Kconfig
patching file drivers/media/i2c/Makefile
patching file drivers/media/i2c/ap1302.c
patching file drivers/media/i2c/ds90ub913.c
patching file drivers/media/i2c/ds90ub953.c
patching file drivers/media/i2c/ds90ub960.c
git add --all
git commit -m '[patch] 219_drivers-media-i2c.patch'
[linux-6.12.100-xlnx-v2025.1-1 264eb69dc] [patch] 219_drivers-media-i2c.patch
 7 files changed, 3246 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
 create mode 100644 drivers/media/i2c/ap1302.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/220_drivers-media-mc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/220_drivers-media-mc.patch
patching file drivers/media/mc/mc-entity.c
git add --all
git commit -m '[patch] 220_drivers-media-mc.patch'
[linux-6.12.100-xlnx-v2025.1-1 d1318388a] [patch] 220_drivers-media-mc.patch
 1 file changed, 29 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/221_drivers-media-platform.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/221_drivers-media-platform.patch
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,axis-broadcaster.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,axis-subsetconv.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,isppipeline.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,mem2mem.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,sdirxss.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-axi4s-switch.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-demosaic.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-dprxss.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-gamma-lut.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-hdmi-rxss1.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-hls.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-multi-scaler.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-scd.txt
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.txt
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.txt
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-csc.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-scaler.yaml
patching file Documentation/devicetree/bindings/media/xilinx/xlnx,video.txt
patching file drivers/media/platform/xilinx/Kconfig
patching file drivers/media/platform/xilinx/Makefile
patching file drivers/media/platform/xilinx/xilinx-axis-broadcaster.c
patching file drivers/media/platform/xilinx/xilinx-axis-subsetconv.c
patching file drivers/media/platform/xilinx/xilinx-axis-switch.c
patching file drivers/media/platform/xilinx/xilinx-csi2rxss.c
patching file drivers/media/platform/xilinx/xilinx-demosaic.c
patching file drivers/media/platform/xilinx/xilinx-dma.c
patching file drivers/media/platform/xilinx/xilinx-dma.h
patching file drivers/media/platform/xilinx/xilinx-dprxss.c
patching file drivers/media/platform/xilinx/xilinx-gamma-coeff.h
patching file drivers/media/platform/xilinx/xilinx-gamma-correction.h
patching file drivers/media/platform/xilinx/xilinx-gamma.c
patching file drivers/media/platform/xilinx/xilinx-hdcp1x-rx.c
patching file drivers/media/platform/xilinx/xilinx-hdcp1x-rx.h
patching file drivers/media/platform/xilinx/xilinx-hdcp2x-rx-crypt.c
patching file drivers/media/platform/xilinx/xilinx-hdcp2x-rx.c
patching file drivers/media/platform/xilinx/xilinx-hdcp2x-rx.h
patching file drivers/media/platform/xilinx/xilinx-hdmirx-hw.h
patching file drivers/media/platform/xilinx/xilinx-hdmirxss.c
patching file drivers/media/platform/xilinx/xilinx-hls-common.h
patching file drivers/media/platform/xilinx/xilinx-hls.c
patching file drivers/media/platform/xilinx/xilinx-isp-params.h
patching file drivers/media/platform/xilinx/xilinx-isppipeline.c
patching file drivers/media/platform/xilinx/xilinx-m2m.c
patching file drivers/media/platform/xilinx/xilinx-multi-scaler-coeff.h
patching file drivers/media/platform/xilinx/xilinx-multi-scaler.c
patching file drivers/media/platform/xilinx/xilinx-scenechange-channel.c
patching file drivers/media/platform/xilinx/xilinx-scenechange-dma.c
patching file drivers/media/platform/xilinx/xilinx-scenechange.c
patching file drivers/media/platform/xilinx/xilinx-scenechange.h
patching file drivers/media/platform/xilinx/xilinx-sdirxss.c
patching file drivers/media/platform/xilinx/xilinx-tpg.c
patching file drivers/media/platform/xilinx/xilinx-vip.c
patching file drivers/media/platform/xilinx/xilinx-vip.h
patching file drivers/media/platform/xilinx/xilinx-vipp.c
patching file drivers/media/platform/xilinx/xilinx-vipp.h
patching file drivers/media/platform/xilinx/xilinx-vpss-csc.c
patching file drivers/media/platform/xilinx/xilinx-vpss-scaler.c
patching file drivers/media/platform/xilinx/xilinx-vtc.c
patching file drivers/media/platform/xilinx/xilinx-vtc.h
patching file include/dt-bindings/media/xilinx-vip.h
git add --all
git commit -m '[patch] 221_drivers-media-platform.patch'
[linux-6.12.100-xlnx-v2025.1-1 fc7fb0d12] [patch] 221_drivers-media-platform.patch
 63 files changed, 41638 insertions(+), 411 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,axis-broadcaster.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,axis-subsetconv.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,isppipeline.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,mem2mem.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,sdirxss.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-axi4s-switch.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-demosaic.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-dprxss.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-gamma-lut.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-hdmi-rxss1.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-hls.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-multi-scaler.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-scd.txt
 delete mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.txt
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.txt
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-csc.yaml
 create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-scaler.yaml
 create mode 100644 drivers/media/platform/xilinx/xilinx-axis-broadcaster.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-axis-subsetconv.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-axis-switch.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-demosaic.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-dprxss.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-gamma-coeff.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-gamma-correction.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-gamma.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdcp1x-rx.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdcp1x-rx.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdcp2x-rx-crypt.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdcp2x-rx.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdcp2x-rx.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdmirx-hw.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-hdmirxss.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-hls-common.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-hls.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-isp-params.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-isppipeline.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-m2m.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-multi-scaler-coeff.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-multi-scaler.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-scenechange-channel.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-scenechange-dma.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-scenechange.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-scenechange.h
 create mode 100644 drivers/media/platform/xilinx/xilinx-sdirxss.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-vpss-csc.c
 create mode 100644 drivers/media/platform/xilinx/xilinx-vpss-scaler.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patching file drivers/media/test-drivers/vivid/vivid-vid-common.c
git add --all
git commit -m '[patch] 222_drivers-media-test-drivers.patch'
[linux-6.12.100-xlnx-v2025.1-1 b05e552b7] [patch] 222_drivers-media-test-drivers.patch
 1 file changed, 8 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/224_drivers-media-v4l2.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/224_drivers-media-v4l2.patch
patching file Documentation/userspace-api/media/v4l/biblio.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-defs.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-details.rst
patching file Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
patching file Documentation/userspace-api/media/v4l/subdev-formats.rst
patching file Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
patching file Documentation/userspace-api/media/videodev2.h.rst.exceptions
patching file drivers/media/v4l2-core/v4l2-common.c
Hunk #1 succeeded at 291 (offset 1 line).
Hunk #2 succeeded at 307 (offset 1 line).
patching file drivers/media/v4l2-core/v4l2-ioctl.c
patching file include/media/hdr-ctrls.h
patching file include/media/media-entity.h
patching file include/uapi/linux/media-bus-format.h
patching file include/uapi/linux/v4l2-mediabus.h
patching file include/uapi/linux/videodev2.h
patching file include/uapi/linux/xilinx-dprxss.h
patching file include/uapi/linux/xilinx-hdmirxss.h
patching file include/uapi/linux/xilinx-hls.h
patching file include/uapi/linux/xilinx-sdirxss.h
patching file include/uapi/linux/xilinx-v4l2-controls.h
patching file include/uapi/linux/xilinx-v4l2-events.h
patching file usr/include/Makefile
git add --all
git commit -m '[patch] 224_drivers-media-v4l2.patch'
[linux-6.12.100-xlnx-v2025.1-1 74276b98a] [patch] 224_drivers-media-v4l2.patch
 22 files changed, 2237 insertions(+), 125 deletions(-)
 create mode 100644 drivers/media/v4l2-core/v4l2-common.c.orig
 create mode 100644 include/media/hdr-ctrls.h
 create mode 100644 include/uapi/linux/xilinx-dprxss.h
 create mode 100644 include/uapi/linux/xilinx-hdmirxss.h
 create mode 100644 include/uapi/linux/xilinx-hls.h
 create mode 100644 include/uapi/linux/xilinx-sdirxss.h
 create mode 100644 include/uapi/linux/xilinx-v4l2-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/225_drivers-mfd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
Hunk #1 succeeded at 258 (offset -4 lines).
Hunk #2 succeeded at 298 (offset -4 lines).
Hunk #3 succeeded at 332 (offset -4 lines).
Hunk #4 succeeded at 343 (offset -4 lines).
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
git add --all
git commit -m '[patch] 225_drivers-mfd.patch'
[linux-6.12.100-xlnx-v2025.1-1 5b7914863] [patch] 225_drivers-mfd.patch
 8 files changed, 845 insertions(+), 291 deletions(-)
 create mode 100644 drivers/mfd/rsmu_i2c.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/226_drivers-misc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/226_drivers-misc.patch
patching file Documentation/devicetree/bindings/misc/xlnx,dpu.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
patching file drivers/misc/Kconfig
patching file drivers/misc/Makefile
patching file drivers/misc/rsmu_cdev.c
patching file drivers/misc/rsmu_cdev.h
patching file drivers/misc/rsmu_cm.c
patching file drivers/misc/rsmu_sabre.c
patching file drivers/misc/xilinx-ai-engine/Makefile
patching file drivers/misc/xilinx-ai-engine/ai-engine-aie.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-aie2ps.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-aieml.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-aperture.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-clock.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-dev-v1_0.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-dev.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-dma.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-internal.h
patching file drivers/misc/xilinx-ai-engine/ai-engine-interrupt.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-mem.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-overlay.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-part.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-pm.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-res.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-reset.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-rscmgr.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-status-dump.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-clock.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-core.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-dma.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-error.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-event.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-info.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-lock.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-status.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs-ucstatus.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-sysfs.c
patching file drivers/misc/xilinx-ai-engine/ai-engine-trace.h
patching file drivers/misc/xilinx_puf.c
patching file drivers/misc/xlnx_dpu.c
patching file drivers/misc/xlnx_dpu.h
patching file include/linux/xlnx-ai-engine.h
patching file include/uapi/linux/rsmu.h
patching file include/uapi/linux/xlnx-ai-engine.h
patching file include/uapi/misc/xilinx_puf.h
git add --all
git commit -m '[patch] 226_drivers-misc.patch'
[linux-6.12.100-xlnx-v2025.1-1 73d7a78e1] [patch] 226_drivers-misc.patch
 45 files changed, 30490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,dpu.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml
 create mode 100644 drivers/misc/rsmu_cdev.c
 create mode 100644 drivers/misc/rsmu_cdev.h
 create mode 100644 drivers/misc/rsmu_cm.c
 create mode 100644 drivers/misc/rsmu_sabre.c
 create mode 100644 drivers/misc/xilinx-ai-engine/Makefile
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-aie.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-aie2ps.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-aieml.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-aperture.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-clock.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-dev-v1_0.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-dev.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-dma.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-internal.h
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-interrupt.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-mem.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-overlay.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-part.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-pm.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-res.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-reset.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-rscmgr.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-status-dump.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-clock.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-core.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-dma.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-error.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-event.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-info.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-lock.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-status.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs-ucstatus.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-sysfs.c
 create mode 100644 drivers/misc/xilinx-ai-engine/ai-engine-trace.h
 create mode 100644 drivers/misc/xilinx_puf.c
 create mode 100644 drivers/misc/xlnx_dpu.c
 create mode 100644 drivers/misc/xlnx_dpu.h
 create mode 100644 include/linux/xlnx-ai-engine.h
 create mode 100644 include/uapi/linux/rsmu.h
 create mode 100644 include/uapi/linux/xlnx-ai-engine.h
 create mode 100644 include/uapi/misc/xilinx_puf.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/228_drivers-mtd.patch
patching file Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
patching file drivers/mtd/spi-nor/atmel.c
patching file drivers/mtd/spi-nor/core.c
patching file drivers/mtd/spi-nor/core.h
patching file drivers/mtd/spi-nor/debugfs.c
patching file drivers/mtd/spi-nor/everspin.c
patching file drivers/mtd/spi-nor/gigadevice.c
patching file drivers/mtd/spi-nor/issi.c
patching file drivers/mtd/spi-nor/macronix.c
patching file drivers/mtd/spi-nor/micron-st.c
patching file drivers/mtd/spi-nor/otp.c
patching file drivers/mtd/spi-nor/sfdp.c
patching file drivers/mtd/spi-nor/spansion.c
Hunk #21 succeeded at 734 (offset 2 lines).
Hunk #22 succeeded at 778 (offset 2 lines).
Hunk #23 succeeded at 792 (offset 2 lines).
Hunk #24 succeeded at 874 (offset 2 lines).
Hunk #25 succeeded at 888 (offset 2 lines).
Hunk #26 succeeded at 902 (offset 2 lines).
Hunk #27 succeeded at 927 (offset 2 lines).
Hunk #28 succeeded at 941 (offset 2 lines).
Hunk #29 succeeded at 986 (offset 2 lines).
Hunk #30 succeeded at 1022 (offset 2 lines).
Hunk #31 succeeded at 1043 (offset 2 lines).
Hunk #32 succeeded at 1074 (offset 2 lines).
Hunk #33 succeeded at 1140 (offset 2 lines).
patching file drivers/mtd/spi-nor/sst.c
patching file drivers/mtd/spi-nor/swp.c
Hunk #14 FAILED at 323.
Hunk #15 succeeded at 343 (offset 7 lines).
Hunk #16 succeeded at 358 (offset 7 lines).
Hunk #17 succeeded at 398 (offset 7 lines).
Hunk #18 succeeded at 538 (offset 7 lines).
Hunk #19 succeeded at 579 (offset 7 lines).
1 out of 19 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/swp.c.rej
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
git add --all
git commit -m '[patch] 228_drivers-mtd.patch'
[linux-6.12.100-xlnx-v2025.1-1 86b193670] [patch] 228_drivers-mtd.patch
 20 files changed, 3885 insertions(+), 364 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/spansion.c.orig
 create mode 100644 drivers/mtd/spi-nor/swp.c.orig
 create mode 100644 drivers/mtd/spi-nor/swp.c.rej
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/228_drivers-mtd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
patching file drivers/net/ethernet/xilinx/Kconfig
patching file drivers/net/ethernet/xilinx/Makefile
patching file drivers/net/ethernet/xilinx/xilinx_axienet.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_main.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
patching file drivers/net/ethernet/xilinx/xilinx_emaclite.c
git add --all
git commit -m '[patch] 230_drivers-net-ethernet.patch'
[linux-6.12.100-xlnx-v2025.1-1 c052402a2] [patch] 230_drivers-net-ethernet.patch
 14 files changed, 7153 insertions(+), 865 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/231_drivers-net-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/231_drivers-net-phy.patch
patching file Documentation/devicetree/bindings/net/xilinx-phy.txt
patching file drivers/net/phy/Kconfig
patching file drivers/net/phy/Makefile
patching file drivers/net/phy/phy-core.c
patching file drivers/net/phy/phylink.c
patching file drivers/net/phy/xilinx_phy.c
patching file include/linux/phy.h
patching file include/linux/xilinx_phy.h
git add --all
git commit -m '[patch] 231_drivers-net-phy.patch'
[linux-6.12.100-xlnx-v2025.1-1 8df7e9b9e] [patch] 231_drivers-net-phy.patch
 8 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx-phy.txt
 create mode 100644 drivers/net/phy/xilinx_phy.c
 create mode 100644 include/linux/xilinx_phy.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/234_drivers-nvmem.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/234_drivers-nvmem.patch
patching file Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
patching file drivers/nvmem/Kconfig
patching file drivers/nvmem/Makefile
patching file drivers/nvmem/xlnx_secure_config.c
git add --all
git commit -m '[patch] 234_drivers-nvmem.patch'
[linux-6.12.100-xlnx-v2025.1-1 dd6e68af4] [patch] 234_drivers-nvmem.patch
 4 files changed, 1300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
 create mode 100644 drivers/nvmem/xlnx_secure_config.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/235_drivers-of.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/235_drivers-of.patch
patching file Documentation/devicetree/configfs-overlays.txt
patching file drivers/of/Kconfig
patching file drivers/of/Makefile
patching file drivers/of/configfs.c
patching file drivers/of/overlay.c
git add --all
git commit -m '[patch] 235_drivers-of.patch'
[linux-6.12.100-xlnx-v2025.1-1 7fcd80806] [patch] 235_drivers-of.patch
 5 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/configfs-overlays.txt
 create mode 100644 drivers/of/configfs.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/236_drivers-pci.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/236_drivers-pci.patch
patching file Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
patching file Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
patching file Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
patching file Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
patching file drivers/pci/controller/dwc/Kconfig
patching file drivers/pci/controller/dwc/Makefile
patching file drivers/pci/controller/dwc/pcie-amd-mdb.c
patching file drivers/pci/controller/pcie-xilinx-cpm.c
patching file drivers/pci/controller/pcie-xilinx-nwl.c
git add --all
git commit -m '[patch] 236_drivers-pci.patch'
[linux-6.12.100-xlnx-v2025.1-1 d73a1d4c4] [patch] 236_drivers-pci.patch
 9 files changed, 827 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/237_drivers-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/237_drivers-phy.patch
patching file Documentation/devicetree/bindings/phy/xlnx,gt-quad-base.yaml
patching file Documentation/devicetree/bindings/phy/xlnx,v-hmdi-phy1.yaml
patching file drivers/phy/xilinx/Kconfig
patching file drivers/phy/xilinx/Makefile
patching file drivers/phy/xilinx/xhdmiphy.c
patching file drivers/phy/xilinx/xhdmiphy.h
patching file drivers/phy/xilinx/xhdmiphy_core.c
patching file drivers/phy/xilinx/xhdmiphy_gt_helper.c
patching file drivers/phy/xilinx/xhdmiphy_mmcm.c
patching file drivers/phy/xilinx/xhdmiphy_modules.c
patching file drivers/phy/xilinx/xilinx_dpgtquadphy.c
patching file include/linux/phy/phy-hdmi.h
patching file include/linux/phy/phy.h
git add --all
git commit -m '[patch] 237_drivers-phy.patch'
[linux-6.12.100-xlnx-v2025.1-1 fa74afac4] [patch] 237_drivers-phy.patch
 13 files changed, 9377 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,gt-quad-base.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/xlnx,v-hmdi-phy1.yaml
 create mode 100644 drivers/phy/xilinx/xhdmiphy.c
 create mode 100644 drivers/phy/xilinx/xhdmiphy.h
 create mode 100644 drivers/phy/xilinx/xhdmiphy_core.c
 create mode 100644 drivers/phy/xilinx/xhdmiphy_gt_helper.c
 create mode 100644 drivers/phy/xilinx/xhdmiphy_mmcm.c
 create mode 100644 drivers/phy/xilinx/xhdmiphy_modules.c
 create mode 100644 drivers/phy/xilinx/xilinx_dpgtquadphy.c
 create mode 100644 include/linux/phy/phy-hdmi.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/238_drivers-pinctrl.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/238_drivers-pinctrl.patch
patching file Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
patching file drivers/pinctrl/pinctrl-zynqmp.c
git add --all
git commit -m '[patch] 238_drivers-pinctrl.patch'
[linux-6.12.100-xlnx-v2025.1-1 23984b00c] [patch] 238_drivers-pinctrl.patch
 2 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/240_drivers-ptp.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/240_drivers-ptp.patch
patching file Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml
patching file drivers/ptp/Kconfig
patching file drivers/ptp/Makefile
patching file drivers/ptp/ptp_clockmatrix.c
patching file drivers/ptp/ptp_clockmatrix.h
patching file drivers/ptp/ptp_idt82p33.h
patching file drivers/ptp/ptp_xilinx.c
patching file include/linux/ptp/ptp_xilinx.h
git add --all
git commit -m '[patch] 240_drivers-ptp.patch'
[linux-6.12.100-xlnx-v2025.1-1 f1ba3fbda] [patch] 240_drivers-ptp.patch
 8 files changed, 715 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml
 create mode 100644 drivers/ptp/ptp_xilinx.c
 create mode 100644 include/linux/ptp/ptp_xilinx.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/241_drivers-pwm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/241_drivers-pwm.patch
patching file drivers/pwm/Kconfig
patching file drivers/pwm/Makefile
patching file drivers/pwm/pwm-cadence.c
git add --all
git commit -m '[patch] 241_drivers-pwm.patch'
[linux-6.12.100-xlnx-v2025.1-1 433011145] [patch] 241_drivers-pwm.patch
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/242_drivers-remoteproc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/242_drivers-remoteproc.patch
patching file drivers/remoteproc/xlnx_r5_remoteproc.c
git add --all
git commit -m '[patch] 242_drivers-remoteproc.patch'
[linux-6.12.100-xlnx-v2025.1-1 98634bcf6] [patch] 242_drivers-remoteproc.patch
 1 file changed, 30 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/243_drivers-reset.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/243_drivers-reset.patch
patching file Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
git add --all
git commit -m '[patch] 243_drivers-reset.patch'
[linux-6.12.100-xlnx-v2025.1-1 6506a00ae] [patch] 243_drivers-reset.patch
 1 file changed, 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/243_drivers-reset.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patching file Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
patching file drivers/soc/xilinx/xlnx_event_manager.c
patching file drivers/soc/xilinx/zynqmp_power.c
git add --all
git commit -m '[patch] 246_drivers-soc-xilinx.patch'
[linux-6.12.100-xlnx-v2025.1-1 101b50ab1] [patch] 246_drivers-soc-xilinx.patch
 4 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
Hunk #7 FAILED at 352.
Hunk #8 succeeded at 590 (offset 7 lines).
1 out of 8 hunks FAILED -- saving rejects to file drivers/spi/spi-xilinx.c.rej
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
git add --all
git commit -m '[patch] 247_drivers-spi.patch'
[linux-6.12.100-xlnx-v2025.1-1 672233ef5] [patch] 247_drivers-spi.patch
 15 files changed, 2256 insertions(+), 215 deletions(-)
 create mode 100644 drivers/spi/spi-xilinx.c.orig
 create mode 100644 drivers/spi/spi-xilinx.c.rej
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/247_drivers-spi.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/248_drivers-staging.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/248_drivers-staging.patch
patching file Documentation/devicetree/bindings/staging/display/amd,mmi-dptx.yaml
patching file Documentation/devicetree/bindings/staging/net/xilinx-tsn-ethernet.txt
patching file Documentation/devicetree/bindings/staging/net/xilinx_tsn.txt
patching file Documentation/devicetree/bindings/staging/net/xilinx_tsn_ep.txt
patching file Documentation/devicetree/bindings/staging/net/xilinx_tsn_ep_ex.txt
patching file Documentation/devicetree/bindings/staging/net/xilinx_tsn_switch.txt
patching file drivers/staging/Kconfig
patching file drivers/staging/Makefile
patching file drivers/staging/fclk/Kconfig
patching file drivers/staging/fclk/Makefile
patching file drivers/staging/fclk/TODO
patching file drivers/staging/fclk/xilinx_fclk.c
patching file drivers/staging/uartlite-rs485/Kconfig
patching file drivers/staging/uartlite-rs485/Makefile
patching file drivers/staging/uartlite-rs485/uartlite-rs485.c
patching file drivers/staging/xilinx-tsn/Kconfig
patching file drivers/staging/xilinx-tsn/Makefile
patching file drivers/staging/xilinx-tsn/xilinx_axienet_main_tsn.c
patching file drivers/staging/xilinx-tsn/xilinx_axienet_mcdma_tsn.c
patching file drivers/staging/xilinx-tsn/xilinx_axienet_mdio_tsn.c
patching file drivers/staging/xilinx-tsn/xilinx_axienet_tsn.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_cb.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ep.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ep_ex.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ip.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_preemption.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_preemption.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ptp.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ptp_clock.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_ptp_xmit.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_qci.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_shaper.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_shaper.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_switch.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_switch.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_switchdev.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_tadma.c
patching file drivers/staging/xilinx-tsn/xilinx_tsn_tadma.h
patching file drivers/staging/xilinx-tsn/xilinx_tsn_timer.h
patching file drivers/staging/xilinx_hdcp/Kconfig
patching file drivers/staging/xilinx_hdcp/MAINTAINERS
patching file drivers/staging/xilinx_hdcp/Makefile
patching file drivers/staging/xilinx_hdcp/xlnx_hdcp2x_cipher.c
patching file drivers/staging/xilinx_hdcp/xlnx_hdcp2x_mmult.c
patching file drivers/staging/xilinx_hdcp/xlnx_hdcp_bigdigits.c
patching file drivers/staging/xilinx_hdcp/xlnx_hdcp_rng.c
patching file drivers/staging/xilinx_hdcp/xlnx_timer.c
patching file drivers/staging/xlnx-mmi-dptx/Kconfig
patching file drivers/staging/xlnx-mmi-dptx/Makefile
patching file drivers/staging/xlnx-mmi-dptx/TODO
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp.c
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp.h
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp_config.c
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp_config.h
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp_intr.c
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp_link.c
patching file drivers/staging/xlnx-mmi-dptx/mmi_dp_reg.h
patching file drivers/staging/xlnx_hdcp1x/Kconfig
patching file drivers/staging/xlnx_hdcp1x/MAINTAINERS
patching file drivers/staging/xlnx_hdcp1x/Makefile
patching file drivers/staging/xlnx_hdcp1x/xilinx-hdcp1x-cipher.c
patching file drivers/staging/xlnxsync/Kconfig
patching file drivers/staging/xlnxsync/MAINTAINERS
patching file drivers/staging/xlnxsync/Makefile
patching file drivers/staging/xlnxsync/dt-binding.txt
patching file drivers/staging/xlnxsync/xlnxsync.c
patching file drivers/staging/xroeframer/Kconfig
patching file drivers/staging/xroeframer/Makefile
patching file drivers/staging/xroeframer/README
patching file drivers/staging/xroeframer/dt-binding.txt
patching file drivers/staging/xroeframer/roe_framer_ctrl.h
patching file drivers/staging/xroeframer/sysfs_xroe.c
patching file drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c
patching file drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c
patching file drivers/staging/xroeframer/sysfs_xroe_framer_stats.c
patching file drivers/staging/xroeframer/sysfs_xroe_framer_udp.c
patching file drivers/staging/xroeframer/xroe_framer.c
patching file drivers/staging/xroeframer/xroe_framer.h
patching file drivers/staging/xroetrafficgen/Kconfig
patching file drivers/staging/xroetrafficgen/Makefile
patching file drivers/staging/xroetrafficgen/README
patching file drivers/staging/xroetrafficgen/dt-binding.txt
patching file drivers/staging/xroetrafficgen/roe_radio_ctrl.h
patching file drivers/staging/xroetrafficgen/xroe-traffic-gen-sysfs.c
patching file drivers/staging/xroetrafficgen/xroe-traffic-gen.c
patching file drivers/staging/xroetrafficgen/xroe-traffic-gen.h
patching file include/linux/xlnx/xilinx-hdcp1x-cipher.h
patching file include/linux/xlnx/xlnx_hdcp2x_cipher.h
patching file include/linux/xlnx/xlnx_hdcp2x_mmult.h
patching file include/linux/xlnx/xlnx_hdcp_common.h
patching file include/linux/xlnx/xlnx_hdcp_rng.h
patching file include/linux/xlnx/xlnx_timer.h
patching file include/uapi/linux/xlnxsync.h
git add --all
git commit -m '[patch] 248_drivers-staging.patch'
[linux-6.12.100-xlnx-v2025.1-1 6bed1cf8b] [patch] 248_drivers-staging.patch
 93 files changed, 28719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/staging/display/amd,mmi-dptx.yaml
 create mode 100644 Documentation/devicetree/bindings/staging/net/xilinx-tsn-ethernet.txt
 create mode 100644 Documentation/devicetree/bindings/staging/net/xilinx_tsn.txt
 create mode 100644 Documentation/devicetree/bindings/staging/net/xilinx_tsn_ep.txt
 create mode 100644 Documentation/devicetree/bindings/staging/net/xilinx_tsn_ep_ex.txt
 create mode 100644 Documentation/devicetree/bindings/staging/net/xilinx_tsn_switch.txt
 create mode 100644 drivers/staging/fclk/Kconfig
 create mode 100644 drivers/staging/fclk/Makefile
 create mode 100644 drivers/staging/fclk/TODO
 create mode 100644 drivers/staging/fclk/xilinx_fclk.c
 create mode 100644 drivers/staging/uartlite-rs485/Kconfig
 create mode 100644 drivers/staging/uartlite-rs485/Makefile
 create mode 100644 drivers/staging/uartlite-rs485/uartlite-rs485.c
 create mode 100644 drivers/staging/xilinx-tsn/Kconfig
 create mode 100644 drivers/staging/xilinx-tsn/Makefile
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_axienet_main_tsn.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_axienet_mcdma_tsn.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_axienet_mdio_tsn.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_axienet_tsn.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_cb.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ep.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ep_ex.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ip.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_preemption.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_preemption.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ptp.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ptp_clock.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_ptp_xmit.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_qci.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_shaper.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_shaper.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_switch.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_switch.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_switchdev.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_tadma.c
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_tadma.h
 create mode 100644 drivers/staging/xilinx-tsn/xilinx_tsn_timer.h
 create mode 100644 drivers/staging/xilinx_hdcp/Kconfig
 create mode 100644 drivers/staging/xilinx_hdcp/MAINTAINERS
 create mode 100644 drivers/staging/xilinx_hdcp/Makefile
 create mode 100644 drivers/staging/xilinx_hdcp/xlnx_hdcp2x_cipher.c
 create mode 100644 drivers/staging/xilinx_hdcp/xlnx_hdcp2x_mmult.c
 create mode 100644 drivers/staging/xilinx_hdcp/xlnx_hdcp_bigdigits.c
 create mode 100644 drivers/staging/xilinx_hdcp/xlnx_hdcp_rng.c
 create mode 100644 drivers/staging/xilinx_hdcp/xlnx_timer.c
 create mode 100644 drivers/staging/xlnx-mmi-dptx/Kconfig
 create mode 100644 drivers/staging/xlnx-mmi-dptx/Makefile
 create mode 100644 drivers/staging/xlnx-mmi-dptx/TODO
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp.c
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp.h
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp_config.c
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp_config.h
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp_intr.c
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp_link.c
 create mode 100644 drivers/staging/xlnx-mmi-dptx/mmi_dp_reg.h
 create mode 100644 drivers/staging/xlnx_hdcp1x/Kconfig
 create mode 100644 drivers/staging/xlnx_hdcp1x/MAINTAINERS
 create mode 100644 drivers/staging/xlnx_hdcp1x/Makefile
 create mode 100644 drivers/staging/xlnx_hdcp1x/xilinx-hdcp1x-cipher.c
 create mode 100644 drivers/staging/xlnxsync/Kconfig
 create mode 100644 drivers/staging/xlnxsync/MAINTAINERS
 create mode 100644 drivers/staging/xlnxsync/Makefile
 create mode 100644 drivers/staging/xlnxsync/dt-binding.txt
 create mode 100644 drivers/staging/xlnxsync/xlnxsync.c
 create mode 100644 drivers/staging/xroeframer/Kconfig
 create mode 100644 drivers/staging/xroeframer/Makefile
 create mode 100644 drivers/staging/xroeframer/README
 create mode 100644 drivers/staging/xroeframer/dt-binding.txt
 create mode 100644 drivers/staging/xroeframer/roe_framer_ctrl.h
 create mode 100644 drivers/staging/xroeframer/sysfs_xroe.c
 create mode 100644 drivers/staging/xroeframer/sysfs_xroe_framer_ipv4.c
 create mode 100644 drivers/staging/xroeframer/sysfs_xroe_framer_ipv6.c
 create mode 100644 drivers/staging/xroeframer/sysfs_xroe_framer_stats.c
 create mode 100644 drivers/staging/xroeframer/sysfs_xroe_framer_udp.c
 create mode 100644 drivers/staging/xroeframer/xroe_framer.c
 create mode 100644 drivers/staging/xroeframer/xroe_framer.h
 create mode 100644 drivers/staging/xroetrafficgen/Kconfig
 create mode 100644 drivers/staging/xroetrafficgen/Makefile
 create mode 100644 drivers/staging/xroetrafficgen/README
 create mode 100644 drivers/staging/xroetrafficgen/dt-binding.txt
 create mode 100644 drivers/staging/xroetrafficgen/roe_radio_ctrl.h
 create mode 100644 drivers/staging/xroetrafficgen/xroe-traffic-gen-sysfs.c
 create mode 100644 drivers/staging/xroetrafficgen/xroe-traffic-gen.c
 create mode 100644 drivers/staging/xroetrafficgen/xroe-traffic-gen.h
 create mode 100644 include/linux/xlnx/xilinx-hdcp1x-cipher.h
 create mode 100644 include/linux/xlnx/xlnx_hdcp2x_cipher.h
 create mode 100644 include/linux/xlnx/xlnx_hdcp2x_mmult.h
 create mode 100644 include/linux/xlnx/xlnx_hdcp_common.h
 create mode 100644 include/linux/xlnx/xlnx_hdcp_rng.h
 create mode 100644 include/linux/xlnx/xlnx_timer.h
 create mode 100644 include/uapi/linux/xlnxsync.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/249_drivers-thermal.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/249_drivers-thermal.patch
patching file Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
patching file drivers/thermal/Kconfig
patching file drivers/thermal/Makefile
patching file drivers/thermal/versal_thermal.c
git add --all
git commit -m '[patch] 249_drivers-thermal.patch'
[linux-6.12.100-xlnx-v2025.1-1 b4b986110] [patch] 249_drivers-thermal.patch
 4 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
 create mode 100644 drivers/thermal/versal_thermal.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/250_drivers-tty.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/250_drivers-tty.patch
patching file Documentation/devicetree/bindings/serial/pl011.yaml
patching file Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
git add --all
git commit -m '[patch] 250_drivers-tty.patch'
[linux-6.12.100-xlnx-v2025.1-1 c7c1dce1b] [patch] 250_drivers-tty.patch
 2 files changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/251_drivers-ufs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/251_drivers-ufs.patch
patching file Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
patching file drivers/ufs/core/ufshcd-priv.h
patching file drivers/ufs/core/ufshcd.c
patching file drivers/ufs/host/Kconfig
patching file drivers/ufs/host/Makefile
patching file drivers/ufs/host/ufs-amd-versal2.c
patching file drivers/ufs/host/ufshcd-dwc.h
patching file drivers/ufs/host/ufshci-dwc.h
patching file include/ufs/ufshcd.h
patching file include/ufs/ufshci.h
patching file include/ufs/unipro.h
git add --all
git commit -m '[patch] 251_drivers-ufs.patch'
[linux-6.12.100-xlnx-v2025.1-1 f0f57eda4] [patch] 251_drivers-ufs.patch
 11 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
 create mode 100644 drivers/ufs/host/ufs-amd-versal2.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/252_drivers-uio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/252_drivers-uio.patch
patching file Documentation/devicetree/bindings/perf/xilinx-apm.yaml
patching file drivers/uio/Kconfig
patching file drivers/uio/Makefile
patching file drivers/uio/uio_core.c (renamed from drivers/uio/uio.c)
patching file drivers/uio/uio_dmabuf.c
patching file drivers/uio/uio_dmabuf.h
patching file drivers/uio/uio_xilinx_ai_engine.c
patching file drivers/uio/uio_xilinx_apm.c
patching file include/uapi/linux/uio/uio.h
git add --all
git commit -m '[patch] 252_drivers-uio.patch'
[linux-6.12.100-xlnx-v2025.1-1 fbeb98f49] [patch] 252_drivers-uio.patch
 9 files changed, 1167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xilinx-apm.yaml
 rename drivers/uio/{uio.c => uio_core.c} (96%)
 create mode 100644 drivers/uio/uio_dmabuf.c
 create mode 100644 drivers/uio/uio_dmabuf.h
 create mode 100644 drivers/uio/uio_xilinx_ai_engine.c
 create mode 100644 drivers/uio/uio_xilinx_apm.c
 create mode 100644 include/uapi/linux/uio/uio.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/260_drivers-usb-core.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/260_drivers-usb-core.patch
patching file Documentation/devicetree/bindings/usb/usb-xhci.yaml
git add --all
git commit -m '[patch] 260_drivers-usb-core.patch'
[linux-6.12.100-xlnx-v2025.1-1 8c2f8e622] [patch] 260_drivers-usb-core.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patching file drivers/usb/chipidea/ci_hdrc_usb2.c
git add --all
git commit -m '[patch] 261_drivers-usb-chipidea.patch'
[linux-6.12.100-xlnx-v2025.1-1 8201244e8] [patch] 261_drivers-usb-chipidea.patch
 1 file changed, 10 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
Hunk #28 succeeded at 4063 (offset 33 lines).
Hunk #29 succeeded at 4157 (offset 33 lines).
Hunk #30 succeeded at 4228 (offset 33 lines).
Hunk #31 succeeded at 4282 (offset 33 lines).
Hunk #32 succeeded at 4408 (offset 33 lines).
Hunk #33 succeeded at 4447 (offset 33 lines).
Hunk #34 succeeded at 4460 (offset 33 lines).
Hunk #35 succeeded at 4603 (offset 33 lines).
Hunk #36 succeeded at 4646 (offset 33 lines).
Hunk #37 succeeded at 4688 (offset 33 lines).
Hunk #38 succeeded at 4713 (offset 33 lines).
Hunk #39 succeeded at 4726 (offset 33 lines).
Hunk #40 succeeded at 4783 (offset 33 lines).
Hunk #41 succeeded at 4835 (offset 33 lines).
Hunk #42 succeeded at 4854 (offset 33 lines).
Hunk #43 succeeded at 4897 (offset 33 lines).
Hunk #44 succeeded at 4990 (offset 33 lines).
Hunk #45 succeeded at 5081 (offset 29 lines).
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
git add --all
git commit -m '[patch] 262_drivers-usb-dwc3.patch'
[linux-6.12.100-xlnx-v2025.1-1 e52efe043] [patch] 262_drivers-usb-dwc3.patch
 17 files changed, 9249 insertions(+), 120 deletions(-)
 create mode 100644 drivers/usb/dwc3/gadget.c.orig
 create mode 100644 drivers/usb/dwc3/gadget_hibernation.c
 create mode 100644 drivers/usb/dwc3/otg.c
 create mode 100644 drivers/usb/dwc3/otg.h
 create mode 100644 drivers/usb/dwc3/platform_data.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/262_drivers-usb-dwc3.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/263_drivers-usb-gadget.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/263_drivers-usb-gadget.patch
patching file drivers/usb/gadget/function/f_tcm.c
git add --all
git commit -m '[patch] 263_drivers-usb-gadget.patch'
[linux-6.12.100-xlnx-v2025.1-1 f17ef8c1b] [patch] 263_drivers-usb-gadget.patch
 1 file changed, 28 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
git add --all
git commit -m '[patch] 264_drivers-usb-host.patch'
[linux-6.12.100-xlnx-v2025.1-1 fa357f398] [patch] 264_drivers-usb-host.patch
 4 files changed, 92 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/266_drivers-usb-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/266_drivers-usb-phy.patch
patching file Documentation/devicetree/bindings/usb/ulpi-phy.yaml
patching file drivers/usb/phy/Kconfig
patching file drivers/usb/phy/phy-ulpi.c
git add --all
git commit -m '[patch] 266_drivers-usb-phy.patch'
[linux-6.12.100-xlnx-v2025.1-1 6d00ce9e1] [patch] 266_drivers-usb-phy.patch
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/271_drivers-video.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/271_drivers-video.patch
patching file drivers/video/hdmi.c
git add --all
git commit -m '[patch] 271_drivers-video.patch'
[linux-6.12.100-xlnx-v2025.1-1 70d71efc6] [patch] 271_drivers-video.patch
 1 file changed, 4 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/272_drivers-virtio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/272_drivers-virtio.patch
patching file drivers/virtio/virtio_ring.c
git add --all
git commit -m '[patch] 272_drivers-virtio.patch'
[linux-6.12.100-xlnx-v2025.1-1 3dd58824a] [patch] 272_drivers-virtio.patch
 1 file changed, 1 insertion(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/273_drivers-w1.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/273_drivers-w1.patch
patching file Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
git add --all
git commit -m '[patch] 273_drivers-w1.patch'
[linux-6.12.100-xlnx-v2025.1-1 2ad246490] [patch] 273_drivers-w1.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/275_drivers-xen.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/275_drivers-xen.patch
patching file drivers/xen/Kconfig
patching file drivers/xen/Makefile
patching file drivers/xen/pvcalls.c
patching file include/xen/pvcalls.h
patching file include/xen/xen.h
git add --all
git commit -m '[patch] 275_drivers-xen.patch'
[linux-6.12.100-xlnx-v2025.1-1 24196a810] [patch] 275_drivers-xen.patch
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xen/pvcalls.c
 create mode 100644 include/xen/pvcalls.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/301_sound-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/301_sound-soc-xilinx.patch
patching file Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
patching file Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
patching file Documentation/devicetree/bindings/sound/xlnx,i2s.txt
patching file Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
patching file Documentation/devicetree/bindings/sound/xlnx,spdif.txt
patching file Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
patching file Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml
patching file sound/soc/xilinx/Kconfig
patching file sound/soc/xilinx/Makefile
patching file sound/soc/xilinx/xlnx_formatter_pcm.c
patching file sound/soc/xilinx/xlnx_i2s.c
patching file sound/soc/xilinx/xlnx_pl_snd_card.c
patching file sound/soc/xilinx/xlnx_sdi_audio.c
patching file sound/soc/xilinx/xlnx_snd_common.h
patching file sound/soc/xilinx/xlnx_spdif.c
git add --all
git commit -m '[patch] 301_sound-soc-xilinx.patch'
[linux-6.12.100-xlnx-v2025.1-1 e35c5dea0] [patch] 301_sound-soc-xilinx.patch
 15 files changed, 1966 insertions(+), 284 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml
 create mode 100644 sound/soc/xilinx/xlnx_pl_snd_card.c
 create mode 100644 sound/soc/xilinx/xlnx_sdi_audio.c
 create mode 100644 sound/soc/xilinx/xlnx_snd_common.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/999_other-document.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/../linux-6.12.95-xlnx-v2025.1/999_other-document.patch
patching file MAINTAINERS
git add --all
git commit -m '[patch] 999_other-document.patch'
[linux-6.12.100-xlnx-v2025.1-1 e9d0d0411] [patch] 999_other-document.patch
 1 file changed, 435 insertions(+), 3 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.100-xlnx-v2025.1/999_other-document.patch
```

###### 211_drivers-hwmon.patch

####### drivers/hwmon/Kconfig

```console
shell$ diff -p linux-6.12.95/drivers/hwmon/Kconfig linux-6.12.100/drivers/hwmon/Kconfig
*** linux-6.12.95/drivers/hwmon/Kconfig	2026-07-11 11:11:42.283086719 +0900
--- linux-6.12.100/drivers/hwmon/Kconfig	2026-08-05 10:45:15.378189561 +0900
*************** config SENSORS_LTC2992
*** 1014,1019 ****
--- 1014,1020 ----
  	tristate "Linear Technology LTC2992"
  	depends on I2C
  	depends on GPIOLIB
+ 	select REGMAP_I2C
  	help
  	  If you say yes here you get support for Linear Technology LTC2992
  	  I2C System Monitor. The LTC2992 measures current, voltage, and
*************** config SENSORS_MAX16065
*** 1140,1145 ****
--- 1141,1147 ----
  config SENSORS_MAX1619
  	tristate "Maxim MAX1619 sensor chip"
  	depends on I2C
+ 	select REGMAP
  	help
  	  If you say yes here you get support for MAX1619 sensor chip.
  
*************** config SENSORS_MAX6650
*** 1258,1263 ****
--- 1260,1266 ----
  config SENSORS_MAX6697
  	tristate "Maxim MAX6697 and compatibles"
  	depends on I2C
+ 	select REGMAP_I2C
  	help
  	  If you say yes here you get support for MAX6581, MAX6602, MAX6622,
  	  MAX6636, MAX6689, MAX6693, MAX6694, MAX6697, MAX6698, and MAX6699
```

```console
shell$ diff -p linux-6.12.95/drivers/hwmon/Kconfig linux-6.12.95-xlnx-v2025.1/drivers/hwmon/Kconfig
*** linux-6.12.95/drivers/hwmon/Kconfig	2026-07-11 11:11:42.283086719 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/hwmon/Kconfig	2026-07-11 14:38:01.022035124 +0900
*************** config SENSORS_INA2XX
*** 2167,2177 ****
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, and INA231 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
! 	  Default value for Rshunt is 10 mOhms.
  	  This driver can also be built as a module. If so, the module
  	  will be called ina2xx.
  
--- 2167,2178 ----
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, INA231, and INA260 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
! 	  Default value for Rshunt is 10 mOhms except for INA260 which has an
! 	  internal 2 mOhm shunt resistor.
  	  This driver can also be built as a module. If so, the module
  	  will be called ina2xx.
  
```

####### Make 211_drivers-hwmon.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
patching file Documentation/hwmon/ina2xx.rst
patching file drivers/hwmon/Kconfig
Hunk #1 succeeded at 2170 (offset 3 lines).
patching file drivers/hwmon/ina2xx.c
```

```console
shell$ rm drivers/hwmon/Kconfig.orig
shell$ git add --all
shell$ git commit -m "[patch] 211_drivers-hwmon.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/211_drivers-hwmon.patch
```

###### 214_drivers-iio.patch

####### drivers/iio/adc/Kconfig

```console
shell$ diff -p linux-6.12.95/drivers/iio/adc/Kconfig linux-6.12.100/drivers/iio/adc/Kconfig
*** linux-6.12.95/drivers/iio/adc/Kconfig	2026-07-11 11:11:42.323081725 +0900
--- linux-6.12.100/drivers/iio/adc/Kconfig	2026-08-05 10:45:15.421236945 +0900
*************** config AD7298
*** 188,193 ****
--- 188,194 ----
  config AD7380
  	tristate "Analog Devices AD7380 ADC driver"
  	depends on SPI_MASTER
+ 	select REGMAP
  	select IIO_BUFFER
  	select IIO_TRIGGER
  	select IIO_TRIGGERED_BUFFER
```

```console
shell$ diff -p linux-6.12.95/drivers/iio/adc/Kconfig linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/Kconfig
*** linux-6.12.95/drivers/iio/adc/Kconfig	2026-07-11 11:11:42.323081725 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/Kconfig	2026-07-11 14:38:01.934031485 +0900
*************** config INA2XX_ADC
*** 617,622 ****
--- 617,634 ----
  	  Say yes here to build support for TI INA2xx family of Power Monitors.
  	  This driver is mutually exclusive with the HWMON version.
  
+ config INA260_ADC
+ 	tristate "Texas Instruments INA260 Power Monitors IIO driver"
+ 	depends on I2C && !SENSORS_INA2XX
+ 	select REGMAP_I2C
+ 	select IIO_BUFFER
+ 	select IIO_KFIFO_BUF
+ 	help
+ 	  Say yes here to build support for TI INA260 power monitor.
+ 	  This driver can also be built as a module. It supports software buffer
+ 	  mode and raw reads of ina260 iio channels. Up to 4 channels are
+ 	  supported including timestamp.
+ 
  config INGENIC_ADC
  	tristate "Ingenic JZ47xx SoCs ADC driver"
  	depends on MIPS || COMPILE_TEST
*************** config XILINX_AMS
*** 1648,1651 ****
--- 1660,1693 ----
  	  The driver can also be built as a module. If so, the module will be called
  	  xilinx-ams.
  
+ config VERSAL_SYSMON_CORE
+ 	tristate
+ 
+ config VERSAL_SYSMON
+ 	tristate "Xilinx Sysmon driver for Versal"
+ 	depends on HAS_IOMEM
+ 	select VERSAL_SYSMON_CORE
+ 	help
+ 	  Say yes here to have support for the Xilinx Sysmon.
+ 	  The driver will enable users to monitor temperature and voltage on the
+ 	  Xilinx Versal platform.
+ 
+ 	  The driver can also be build as a module. If so, the module will be called
+ 	  versal-sysmon.
+ 
+ config VERSAL_SYSMON_I2C
+ 	tristate "Xilinx I2C Sysmon driver for Versal"
+ 	depends on I2C
+ 	select VERSAL_SYSMON_CORE
+ 	help
+ 	  Say yes here to have support for the Xilinx Sysmon I2C driver.
+ 	  The driver will enable users to monitor temperature and voltage on the
+ 	  Xilinx Versal platform via I2C.
+ 
+ 	  This will require the Sysmon to be configured to be an I2C device on the
+ 	  target device.
+ 
+ 	  The driver can also be build as a module. If so, the module will be called
+ 	  versal-sysmon-i2c.
+ 
  endmenu
```

####### drivers/iio/adc/xilinx-ams.c

```console
shell$ diff -p linux-6.12.95/drivers/iio/adc/xilinx-ams.c linux-6.12.100/drivers/iio/adc/xilinx-ams.c
*** linux-6.12.95/drivers/iio/adc/xilinx-ams.c	2026-07-11 11:11:42.331080726 +0900
--- linux-6.12.100/drivers/iio/adc/xilinx-ams.c	2026-08-05 10:45:15.429063742 +0900
*************** static const struct iio_chan_spec *ams_e
*** 871,876 ****
--- 871,879 ----
  		if (dev->channels[i].scan_index == scan_index)
  			break;
  
+ 	if (i == dev->num_channels)
+ 		return NULL;
+ 
  	return &dev->channels[i];
  }
  
*************** static void ams_handle_event(struct iio_
*** 1012,1017 ****
--- 1015,1022 ----
  	const struct iio_chan_spec *chan;
  
  	chan = ams_event_to_channel(indio_dev, event);
+ 	if (!chan)
+ 		return;
  
  	if (chan->type == IIO_TEMP) {
  		/*
```

```console
shell$ diff -p linux-6.12.95/drivers/iio/adc/xilinx-ams.c linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/xilinx-ams.c
*** linux-6.12.95/drivers/iio/adc/xilinx-ams.c	2026-07-11 11:11:42.331080726 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/xilinx-ams.c	2026-07-11 14:38:01.938031472 +0900
***************
*** 117,138 ****
  #define AMS_ALARM_TEMP_REMOTE		0x194
  #define AMS_ALARM_THRESHOLD_OFF_10	0x10
  #define AMS_ALARM_THRESHOLD_OFF_20	0x20
  
  #define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
  #define AMS_ALARM_THR_MIN		0x0000
  #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
  
  #define AMS_ALARM_MASK			GENMASK_ULL(63, 0)
! #define AMS_NO_OF_ALARMS		32
  #define AMS_PL_ALARM_START		16
  #define AMS_PL_ALARM_MASK		GENMASK(31, 16)
  #define AMS_ISR0_ALARM_MASK		GENMASK(31, 0)
  #define AMS_ISR1_ALARM_MASK		(GENMASK(31, 29) | GENMASK(4, 0))
  #define AMS_ISR1_EOC_MASK		BIT(3)
  #define AMS_ISR1_INTR_MASK		GENMASK_ULL(63, 32)
  #define AMS_ISR0_ALARM_2_TO_0_MASK	GENMASK(2, 0)
  #define AMS_ISR0_ALARM_6_TO_3_MASK	GENMASK(6, 3)
  #define AMS_ISR0_ALARM_12_TO_7_MASK	GENMASK(13, 8)
  #define AMS_CONF1_ALARM_2_TO_0_MASK	GENMASK(3, 1)
  #define AMS_CONF1_ALARM_6_TO_3_MASK	GENMASK(11, 8)
  #define AMS_CONF1_ALARM_12_TO_7_MASK	GENMASK(5, 0)
--- 117,146 ----
  #define AMS_ALARM_TEMP_REMOTE		0x194
  #define AMS_ALARM_THRESHOLD_OFF_10	0x10
  #define AMS_ALARM_THRESHOLD_OFF_20	0x20
+ #define AMS_ALARM_THRESHOLD_OFF_0C	0x0C
+ #define AMS_ALARM_THRESHOLD_OFF_M48	-0x48
  
  #define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
  #define AMS_ALARM_THR_MIN		0x0000
  #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
  
  #define AMS_ALARM_MASK			GENMASK_ULL(63, 0)
! #define AMS_NO_OF_ALARMS		35
  #define AMS_PL_ALARM_START		16
+ #define AMS_PS_OT_ALARM_START		32
+ #define AMS_PL_OT_ALARM_START		34
  #define AMS_PL_ALARM_MASK		GENMASK(31, 16)
  #define AMS_ISR0_ALARM_MASK		GENMASK(31, 0)
  #define AMS_ISR1_ALARM_MASK		(GENMASK(31, 29) | GENMASK(4, 0))
+ #define AMS_ISR1_ALARM_SHIFT		32
  #define AMS_ISR1_EOC_MASK		BIT(3)
  #define AMS_ISR1_INTR_MASK		GENMASK_ULL(63, 32)
  #define AMS_ISR0_ALARM_2_TO_0_MASK	GENMASK(2, 0)
  #define AMS_ISR0_ALARM_6_TO_3_MASK	GENMASK(6, 3)
  #define AMS_ISR0_ALARM_12_TO_7_MASK	GENMASK(13, 8)
+ #define AMS_ISR1_ALARM_2_MASK		BIT_ULL(34)
+ #define AMS_ISR1_ALARM_1_TO_0_MASK	GENMASK_ULL(33, 32)
+ #define AMS_CONF1_ALARM_OT_MASK	BIT(0)
  #define AMS_CONF1_ALARM_2_TO_0_MASK	GENMASK(3, 1)
  #define AMS_CONF1_ALARM_6_TO_3_MASK	GENMASK(11, 8)
  #define AMS_CONF1_ALARM_12_TO_7_MASK	GENMASK(5, 0)
***************
*** 161,166 ****
--- 169,175 ----
  
  #define AMS_TEMP_SCALE			509314
  #define AMS_TEMP_SCALE_DIV_BIT		16
+ #define AMS_TEMP_SCALE_DIV		BIT(AMS_TEMP_SCALE_DIV_BIT)
  #define AMS_TEMP_OFFSET			-((280230LL << 16) / 509314)
  
  enum ams_alarm_bit {
*************** enum ams_alarm_bit {
*** 178,183 ****
--- 187,195 ----
  	AMS_ALARM_BIT_SUPPLY10 = 11,
  	AMS_ALARM_BIT_VCCAMS = 12,
  	AMS_ALARM_BIT_TEMP_REMOTE = 13,
+ 	AMS_ALARM_BIT_TEMP_OT_REMOTE = 32,
+ 	AMS_ALARM_BIT_PS_TEMP_OT = 33,
+ 	AMS_ALARM_BIT_PL_TEMP_OT = 34,
  };
  
  enum ams_seq {
*************** enum ams_ps_pl_seq {
*** 227,232 ****
--- 239,245 ----
  	.indexed = 1, \
  	.address = (_addr), \
  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+ 		BIT(IIO_CHAN_INFO_PROCESSED) | \
  		BIT(IIO_CHAN_INFO_SCALE) | \
  		BIT(IIO_CHAN_INFO_OFFSET), \
  	.event_spec = ams_temp_events, \
*************** struct ams {
*** 286,293 ****
  	struct device *dev;
  	struct mutex lock;
  	spinlock_t intr_lock;
! 	unsigned int alarm_mask;
! 	unsigned int current_masked_alarm;
  	u64 intr_mask;
  	struct delayed_work ams_unmask_work;
  };
--- 299,306 ----
  	struct device *dev;
  	struct mutex lock;
  	spinlock_t intr_lock;
! 	u64 alarm_mask;
! 	u64 current_masked_alarm;
  	u64 intr_mask;
  	struct delayed_work ams_unmask_work;
  };
*************** static void ams_update_intrmask(struct a
*** 318,333 ****
  
  	ams->intr_mask = (ams->intr_mask & ~mask) | (val & mask);
  
! 	regval = ~(ams->intr_mask | ams->current_masked_alarm);
  	writel(regval, ams->base + AMS_IER_0);
  
! 	regval = ~(FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask));
  	writel(regval, ams->base + AMS_IER_1);
  
! 	regval = ams->intr_mask | ams->current_masked_alarm;
  	writel(regval, ams->base + AMS_IDR_0);
  
! 	regval = FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask);
  	writel(regval, ams->base + AMS_IDR_1);
  }
  
--- 331,350 ----
  
  	ams->intr_mask = (ams->intr_mask & ~mask) | (val & mask);
  
! 	regval = ~((ams->intr_mask | ams->current_masked_alarm) & AMS_ISR0_ALARM_MASK);
  	writel(regval, ams->base + AMS_IER_0);
  
! 	regval = ~(((ams->intr_mask | ams->current_masked_alarm) >>
! 		    AMS_ISR1_ALARM_SHIFT) &
! 		   AMS_ISR1_ALARM_MASK);
  	writel(regval, ams->base + AMS_IER_1);
  
! 	regval = ((ams->intr_mask | ams->current_masked_alarm) & AMS_ISR0_ALARM_MASK);
  	writel(regval, ams->base + AMS_IDR_0);
  
! 	regval = (((ams->intr_mask | ams->current_masked_alarm) >>
! 		   AMS_ISR1_ALARM_SHIFT) &
! 		  AMS_ISR1_ALARM_MASK);
  	writel(regval, ams->base + AMS_IDR_1);
  }
  
*************** static void ams_disable_all_alarms(struc
*** 350,356 ****
  	}
  }
  
! static void ams_update_ps_alarm(struct ams *ams, unsigned long alarm_mask)
  {
  	u32 cfg;
  	u32 val;
--- 367,373 ----
  	}
  }
  
! static void ams_update_ps_alarm(struct ams *ams, u64 alarm_mask)
  {
  	u32 cfg;
  	u32 val;
*************** static void ams_update_ps_alarm(struct a
*** 361,366 ****
--- 378,386 ----
  	val = FIELD_GET(AMS_ISR0_ALARM_6_TO_3_MASK, alarm_mask);
  	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_6_TO_3_MASK, val));
  
+ 	val = FIELD_GET(AMS_ISR1_ALARM_1_TO_0_MASK, alarm_mask);
+ 	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_OT_MASK, !!val));
+ 
  	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK, cfg);
  
  	val = FIELD_GET(AMS_ISR0_ALARM_12_TO_7_MASK, alarm_mask);
*************** static void ams_update_ps_alarm(struct a
*** 368,374 ****
  	ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
  }
  
! static void ams_update_pl_alarm(struct ams *ams, unsigned long alarm_mask)
  {
  	unsigned long pl_alarm_mask;
  	u32 cfg;
--- 388,394 ----
  	ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
  }
  
! static void ams_update_pl_alarm(struct ams *ams, u64 alarm_mask)
  {
  	unsigned long pl_alarm_mask;
  	u32 cfg;
*************** static void ams_update_pl_alarm(struct a
*** 382,387 ****
--- 402,410 ----
  	val = FIELD_GET(AMS_ISR0_ALARM_6_TO_3_MASK, pl_alarm_mask);
  	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_6_TO_3_MASK, val));
  
+ 	val = FIELD_GET(AMS_ISR1_ALARM_2_MASK, alarm_mask);
+ 	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_OT_MASK, val));
+ 
  	ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK, cfg);
  
  	val = FIELD_GET(AMS_ISR0_ALARM_12_TO_7_MASK, pl_alarm_mask);
*************** static void ams_update_pl_alarm(struct a
*** 391,399 ****
  
  static void ams_unmask(struct ams *ams)
  {
! 	unsigned int status, unmask;
  
  	status = readl(ams->base + AMS_ISR_0);
  
  	/* Clear those bits which are not active anymore */
  	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
--- 414,423 ----
  
  static void ams_unmask(struct ams *ams)
  {
! 	u64 status, unmask;
  
  	status = readl(ams->base + AMS_ISR_0);
+ 	status |= ((u64)readl(ams->base + AMS_ISR_1) << AMS_ISR1_ALARM_SHIFT);
  
  	/* Clear those bits which are not active anymore */
  	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
*************** static void ams_unmask(struct ams *ams)
*** 407,413 ****
  	ams->current_masked_alarm &= ~ams->intr_mask;
  
  	/* Clear the interrupts before we unmask them */
! 	writel(unmask, ams->base + AMS_ISR_0);
  
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  }
--- 431,439 ----
  	ams->current_masked_alarm &= ~ams->intr_mask;
  
  	/* Clear the interrupts before we unmask them */
! 	writel((unmask & AMS_ISR0_ALARM_MASK), ams->base + AMS_ISR_0);
! 	writel(((unmask >> AMS_ISR1_ALARM_SHIFT) & AMS_ISR1_ALARM_MASK),
! 	       ams->base + AMS_ISR_1);
  
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  }
*************** static void ams_update_alarm(struct ams
*** 423,429 ****
  		ams_update_pl_alarm(ams, alarm_mask);
  
  	spin_lock_irqsave(&ams->intr_lock, flags);
! 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
  	ams_unmask(ams);
  	spin_unlock_irqrestore(&ams->intr_lock, flags);
  }
--- 449,458 ----
  		ams_update_pl_alarm(ams, alarm_mask);
  
  	spin_lock_irqsave(&ams->intr_lock, flags);
! 	ams_update_intrmask(ams,
! 			    (AMS_ISR0_ALARM_MASK |
! 			     ((u64)AMS_ISR1_ALARM_MASK << AMS_ISR1_ALARM_SHIFT)),
! 			    ~alarm_mask);
  	ams_unmask(ams);
  	spin_unlock_irqrestore(&ams->intr_lock, flags);
  }
*************** static int ams_read_raw(struct iio_dev *
*** 717,725 ****
  			int *val, int *val2, long mask)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	int ret;
  
  	switch (mask) {
  	case IIO_CHAN_INFO_RAW:
  		mutex_lock(&ams->lock);
  		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
--- 746,765 ----
  			int *val, int *val2, long mask)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	int ret, regval;
  
  	switch (mask) {
+ 	case IIO_CHAN_INFO_PROCESSED:
+ 		mutex_lock(&ams->lock);
+ 		if (chan->scan_index >= AMS_PS_SEQ_MAX)
+ 			regval = readl(ams->pl_base + chan->address);
+ 		else
+ 			regval = readl(ams->ps_base + chan->address);
+ 
+ 		*val = ((regval + AMS_TEMP_OFFSET) * AMS_TEMP_SCALE) / AMS_TEMP_SCALE_DIV;
+ 		mutex_unlock(&ams->lock);
+ 		return IIO_VAL_INT;
+ 
  	case IIO_CHAN_INFO_RAW:
  		mutex_lock(&ams->lock);
  		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
*************** unlock_mutex:
*** 765,771 ****
  	}
  }
  
! static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
  {
  	int offset;
  
--- 805,812 ----
  	}
  }
  
! static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir,
! 				enum iio_event_type type)
  {
  	int offset;
  
*************** static int ams_get_alarm_offset(int scan
*** 781,786 ****
--- 822,833 ----
  		offset = 0;
  	}
  
+ 	if (type == IIO_EV_TYPE_MAG) {
+ 		offset += (scan_index == AMS_SEQ_TEMP) ?
+ 				  AMS_ALARM_THRESHOLD_OFF_0C :
+ 				  AMS_ALARM_THRESHOLD_OFF_M48;
+ 	}
+ 
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
  		return AMS_ALARM_TEMP + offset;
*************** static const struct iio_chan_spec *ams_e
*** 818,829 ****
  {
  	int scan_index = 0, i;
  
! 	if (event >= AMS_PL_ALARM_START) {
  		event -= AMS_PL_ALARM_START;
  		scan_index = AMS_PS_SEQ_MAX;
  	}
  
  	switch (event) {
  	case AMS_ALARM_BIT_TEMP:
  		scan_index += AMS_SEQ_TEMP;
  		break;
--- 865,881 ----
  {
  	int scan_index = 0, i;
  
! 	if (event == AMS_PL_OT_ALARM_START) {
! 		scan_index = AMS_PS_SEQ_MAX;
! 	} else if ((event >= AMS_PL_ALARM_START) &&
! 		   (event < AMS_PS_OT_ALARM_START)) {
  		event -= AMS_PL_ALARM_START;
  		scan_index = AMS_PS_SEQ_MAX;
  	}
  
  	switch (event) {
+ 	case AMS_ALARM_BIT_PL_TEMP_OT:
+ 	case AMS_ALARM_BIT_PS_TEMP_OT:
  	case AMS_ALARM_BIT_TEMP:
  		scan_index += AMS_SEQ_TEMP;
  		break;
*************** static const struct iio_chan_spec *ams_e
*** 860,865 ****
--- 912,918 ----
  	case AMS_ALARM_BIT_VCCAMS:
  		scan_index += AMS_SEQ_VCCAMS;
  		break;
+ 	case AMS_ALARM_BIT_TEMP_OT_REMOTE:
  	case AMS_ALARM_BIT_TEMP_REMOTE:
  		scan_index += AMS_SEQ_TEMP_REMOTE;
  		break;
*************** static const struct iio_chan_spec *ams_e
*** 874,891 ****
  	return &dev->channels[i];
  }
  
! static int ams_get_alarm_mask(int scan_index)
  {
! 	int bit = 0;
  
  	if (scan_index >= AMS_PS_SEQ_MAX) {
  		bit = AMS_PL_ALARM_START;
  		scan_index -= AMS_PS_SEQ_MAX;
  	}
  
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
! 		return BIT(AMS_ALARM_BIT_TEMP + bit);
  	case AMS_SEQ_SUPPLY1:
  		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
  	case AMS_SEQ_SUPPLY2:
--- 927,947 ----
  	return &dev->channels[i];
  }
  
! static u64 ams_get_alarm_mask(int scan_index, enum iio_event_type type)
  {
! 	int bit = 0, ot_bit = 0;
  
  	if (scan_index >= AMS_PS_SEQ_MAX) {
  		bit = AMS_PL_ALARM_START;
+ 		ot_bit = 1;
  		scan_index -= AMS_PS_SEQ_MAX;
  	}
  
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
! 		if (type != IIO_EV_TYPE_MAG)
! 			return BIT(AMS_ALARM_BIT_TEMP + bit);
! 		return BIT(AMS_ALARM_BIT_PS_TEMP_OT + ot_bit);
  	case AMS_SEQ_SUPPLY1:
  		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
  	case AMS_SEQ_SUPPLY2:
*************** static int ams_get_alarm_mask(int scan_i
*** 909,915 ****
  	case AMS_SEQ_VCCAMS:
  		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
  	case AMS_SEQ_TEMP_REMOTE:
! 		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
  	default:
  		return 0;
  	}
--- 965,973 ----
  	case AMS_SEQ_VCCAMS:
  		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
  	case AMS_SEQ_TEMP_REMOTE:
! 		if (type != IIO_EV_TYPE_MAG)
! 			return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
! 		return BIT_ULL(AMS_ALARM_BIT_TEMP_OT_REMOTE);
  	default:
  		return 0;
  	}
*************** static int ams_read_event_config(struct
*** 922,928 ****
  {
  	struct ams *ams = iio_priv(indio_dev);
  
! 	return !!(ams->alarm_mask & ams_get_alarm_mask(chan->scan_index));
  }
  
  static int ams_write_event_config(struct iio_dev *indio_dev,
--- 980,986 ----
  {
  	struct ams *ams = iio_priv(indio_dev);
  
! 	return !!(ams->alarm_mask & ams_get_alarm_mask(chan->scan_index, type));
  }
  
  static int ams_write_event_config(struct iio_dev *indio_dev,
*************** static int ams_write_event_config(struct
*** 932,940 ****
  				  int state)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int alarm;
  
! 	alarm = ams_get_alarm_mask(chan->scan_index);
  
  	mutex_lock(&ams->lock);
  
--- 990,998 ----
  				  int state)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	u64 alarm;
  
! 	alarm = ams_get_alarm_mask(chan->scan_index, type);
  
  	mutex_lock(&ams->lock);
  
*************** static int ams_read_event_value(struct i
*** 957,963 ****
  				enum iio_event_info info, int *val, int *val2)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
  
  	mutex_lock(&ams->lock);
  
--- 1015,1021 ----
  				enum iio_event_info info, int *val, int *val2)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir, type);
  
  	mutex_lock(&ams->lock);
  
*************** static int ams_write_event_value(struct
*** 984,990 ****
  
  	/* Set temperature channel threshold to direct threshold */
  	if (chan->type == IIO_TEMP) {
! 		offset = ams_get_alarm_offset(chan->scan_index, IIO_EV_DIR_FALLING);
  
  		if (chan->scan_index >= AMS_PS_SEQ_MAX)
  			ams_pl_update_reg(ams, offset,
--- 1042,1048 ----
  
  	/* Set temperature channel threshold to direct threshold */
  	if (chan->type == IIO_TEMP) {
! 		offset = ams_get_alarm_offset(chan->scan_index, IIO_EV_DIR_FALLING, type);
  
  		if (chan->scan_index >= AMS_PS_SEQ_MAX)
  			ams_pl_update_reg(ams, offset,
*************** static int ams_write_event_value(struct
*** 996,1002 ****
  					  AMS_ALARM_THR_DIRECT_MASK);
  	}
  
! 	offset = ams_get_alarm_offset(chan->scan_index, dir);
  	if (chan->scan_index >= AMS_PS_SEQ_MAX)
  		writel(val, ams->pl_base + offset);
  	else
--- 1054,1060 ----
  					  AMS_ALARM_THR_DIRECT_MASK);
  	}
  
! 	offset = ams_get_alarm_offset(chan->scan_index, dir, type);
  	if (chan->scan_index >= AMS_PS_SEQ_MAX)
  		writel(val, ams->pl_base + offset);
  	else
*************** static void ams_handle_event(struct iio_
*** 1018,1028 ****
  		 * The temperature channel only supports over-temperature
  		 * events.
  		 */
! 		iio_push_event(indio_dev,
! 			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
! 						    IIO_EV_TYPE_THRESH,
! 						    IIO_EV_DIR_RISING),
! 			       iio_get_time_ns(indio_dev));
  	} else {
  		/*
  		 * For other channels we don't know whether it is a upper or
--- 1076,1096 ----
  		 * The temperature channel only supports over-temperature
  		 * events.
  		 */
! 		if (event < AMS_ALARM_BIT_TEMP_OT_REMOTE) {
! 			iio_push_event(indio_dev,
! 				       IIO_UNMOD_EVENT_CODE(chan->type,
! 							    chan->channel,
! 							    IIO_EV_TYPE_THRESH,
! 							    IIO_EV_DIR_RISING),
! 				       iio_get_time_ns(indio_dev));
! 		} else {
! 			iio_push_event(indio_dev,
! 				       IIO_UNMOD_EVENT_CODE(chan->type,
! 							    chan->channel,
! 							    IIO_EV_TYPE_MAG,
! 							    IIO_EV_DIR_RISING),
! 				       iio_get_time_ns(indio_dev));
! 		}
  	} else {
  		/*
  		 * For other channels we don't know whether it is a upper or
*************** static irqreturn_t ams_irq(int irq, void
*** 1074,1100 ****
  {
  	struct iio_dev *indio_dev = data;
  	struct ams *ams = iio_priv(indio_dev);
! 	u32 isr0;
  
  	spin_lock(&ams->intr_lock);
  
  	isr0 = readl(ams->base + AMS_ISR_0);
  
  	/* Only process alarms that are not masked */
! 	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->current_masked_alarm);
! 	if (!isr0) {
  		spin_unlock(&ams->intr_lock);
  		return IRQ_NONE;
  	}
  
  	/* Clear interrupt */
  	writel(isr0, ams->base + AMS_ISR_0);
  
  	/* Mask the alarm interrupts until cleared */
  	ams->current_masked_alarm |= isr0;
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  
! 	ams_handle_events(indio_dev, isr0);
  
  	schedule_delayed_work(&ams->ams_unmask_work,
  			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
--- 1142,1178 ----
  {
  	struct iio_dev *indio_dev = data;
  	struct ams *ams = iio_priv(indio_dev);
! 	u64 isr, isr0, isr1;
  
  	spin_lock(&ams->intr_lock);
  
  	isr0 = readl(ams->base + AMS_ISR_0);
+ 	isr1 = readl(ams->base + AMS_ISR_1);
  
  	/* Only process alarms that are not masked */
! 	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) |
! 		  ams->current_masked_alarm);
! 	isr1 &= ~(((ams->intr_mask &
! 		    ((u64)AMS_ISR1_ALARM_MASK << AMS_ISR1_ALARM_SHIFT)) |
! 		   ams->current_masked_alarm) >>
! 		  AMS_ISR1_ALARM_SHIFT);
! 	isr = (isr0 | (isr1 << AMS_ISR1_ALARM_SHIFT));
! 	if (!isr0 && !isr1) {
  		spin_unlock(&ams->intr_lock);
  		return IRQ_NONE;
  	}
  
  	/* Clear interrupt */
  	writel(isr0, ams->base + AMS_ISR_0);
+ 	writel(isr1, ams->base + AMS_ISR_1);
  
  	/* Mask the alarm interrupts until cleared */
  	ams->current_masked_alarm |= isr0;
+ 	ams->current_masked_alarm |= isr1 << AMS_ISR1_ALARM_SHIFT;
+ 
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  
! 	ams_handle_events(indio_dev, isr);
  
  	schedule_delayed_work(&ams->ams_unmask_work,
  			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
*************** static const struct iio_event_spec ams_t
*** 1110,1115 ****
--- 1188,1198 ----
  		.dir = IIO_EV_DIR_RISING,
  		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
  	},
+ 	{
+ 		.type = IIO_EV_TYPE_MAG,
+ 		.dir = IIO_EV_DIR_RISING,
+ 		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+ 	}
  };
  
  static const struct iio_event_spec ams_voltage_events[] = {
*************** static int ams_parse_firmware(struct iio
*** 1316,1325 ****
  			/* set threshold to max and min for each channel */
  			falling_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_FALLING);
  			rising_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_RISING);
  			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
  				writel(AMS_ALARM_THR_MIN,
  				       ams->pl_base + falling_off);
--- 1399,1409 ----
  			/* set threshold to max and min for each channel */
  			falling_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_FALLING, IIO_EV_TYPE_THRESH);
  			rising_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_RISING, IIO_EV_TYPE_THRESH);
! 
  			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
  				writel(AMS_ALARM_THR_MIN,
  				       ams->pl_base + falling_off);
*************** static int ams_parse_firmware(struct iio
*** 1331,1336 ****
--- 1415,1438 ----
  				writel(AMS_ALARM_THR_MAX,
  				       ams->ps_base + rising_off);
  			}
+ 
+ 			/* also set OT thresholds for temperature channels*/
+ 			if (ams_channels[i].type == IIO_TEMP) {
+ 				falling_off =
+ 					ams_get_alarm_offset(ams_channels[i].scan_index,
+ 							     IIO_EV_DIR_FALLING, IIO_EV_TYPE_MAG);
+ 				rising_off =
+ 					ams_get_alarm_offset(ams_channels[i].scan_index,
+ 							     IIO_EV_DIR_RISING, IIO_EV_TYPE_MAG);
+ 
+ 				if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
+ 					writel(AMS_ALARM_THR_MIN, ams->pl_base + falling_off);
+ 					writel(AMS_ALARM_THR_MAX, ams->pl_base + rising_off);
+ 				} else {
+ 					writel(AMS_ALARM_THR_MIN, ams->ps_base + falling_off);
+ 					writel(AMS_ALARM_THR_MAX, ams->ps_base + rising_off);
+ 				}
+ 			}
  		}
  	}
  
```

####### Make 214_drivers-iio.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
Hunk #1 succeeded at 618 (offset 1 line).
Hunk #2 succeeded at 1661 (offset 1 line).
patching file drivers/iio/adc/Makefile
patching file drivers/iio/adc/ina260-adc.c
patching file drivers/iio/adc/versal-sysmon-core.c
patching file drivers/iio/adc/versal-sysmon-i2c.c
patching file drivers/iio/adc/versal-sysmon.c
patching file drivers/iio/adc/versal-sysmon.h
patching file drivers/iio/adc/xilinx-ams.c
Hunk #19 succeeded at 930 (offset 3 lines).
Hunk #20 succeeded at 968 (offset 3 lines).
Hunk #21 succeeded at 983 (offset 3 lines).
Hunk #22 succeeded at 993 (offset 3 lines).
Hunk #23 succeeded at 1018 (offset 3 lines).
Hunk #24 succeeded at 1045 (offset 3 lines).
Hunk #25 succeeded at 1057 (offset 3 lines).
Hunk #26 succeeded at 1081 (offset 5 lines).
Hunk #27 succeeded at 1147 (offset 5 lines).
Hunk #28 succeeded at 1193 (offset 5 lines).
Hunk #29 succeeded at 1404 (offset 5 lines).
Hunk #30 succeeded at 1420 (offset 5 lines).
patching file drivers/iio/adc/xilinx-xadc-core.c
patching file include/linux/iio/adc/versal-sysmon-events.h
```

```console
shell$ rm drivers/iio/adc/Kconfig.orig
shell$ rm drivers/iio/adc/xilinx-ams.c.orig
shell$ git add --all
shell$ git commit -m "[patch] 214_drivers-iio.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/214_drivers-iio.patch
```

###### 224_drivers-media-v4l2.patch

####### drivers/media/v4l2-core/v4l2-common.c

```console
shell$ 
*** linux-6.12.95/drivers/iio/adc/xilinx-ams.c	2026-07-11 11:11:42.331080726 +0900
--- linux-6.12.100/drivers/iio/adc/xilinx-ams.c	2026-08-05 10:45:15.429063742 +0900
*************** static const struct iio_chan_spec *ams_e
*** 871,876 ****
--- 871,879 ----
  		if (dev->channels[i].scan_index == scan_index)
  			break;
  
+ 	if (i == dev->num_channels)
+ 		return NULL;
+ 
  	return &dev->channels[i];
  }
  
*************** static void ams_handle_event(struct iio_
*** 1012,1017 ****
--- 1015,1022 ----
  	const struct iio_chan_spec *chan;
  
  	chan = ams_event_to_channel(indio_dev, event);
+ 	if (!chan)
+ 		return;
  
  	if (chan->type == IIO_TEMP) {
  		/*
```

```console
shell$ diff -p linux-6.12.95/drivers/iio/adc/xilinx-ams.c linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/xilinx-ams.c
*** linux-6.12.95/drivers/iio/adc/xilinx-ams.c	2026-07-11 11:11:42.331080726 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/iio/adc/xilinx-ams.c	2026-07-11 14:38:01.938031472 +0900
***************
*** 117,138 ****
  #define AMS_ALARM_TEMP_REMOTE		0x194
  #define AMS_ALARM_THRESHOLD_OFF_10	0x10
  #define AMS_ALARM_THRESHOLD_OFF_20	0x20
  
  #define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
  #define AMS_ALARM_THR_MIN		0x0000
  #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
  
  #define AMS_ALARM_MASK			GENMASK_ULL(63, 0)
! #define AMS_NO_OF_ALARMS		32
  #define AMS_PL_ALARM_START		16
  #define AMS_PL_ALARM_MASK		GENMASK(31, 16)
  #define AMS_ISR0_ALARM_MASK		GENMASK(31, 0)
  #define AMS_ISR1_ALARM_MASK		(GENMASK(31, 29) | GENMASK(4, 0))
  #define AMS_ISR1_EOC_MASK		BIT(3)
  #define AMS_ISR1_INTR_MASK		GENMASK_ULL(63, 32)
  #define AMS_ISR0_ALARM_2_TO_0_MASK	GENMASK(2, 0)
  #define AMS_ISR0_ALARM_6_TO_3_MASK	GENMASK(6, 3)
  #define AMS_ISR0_ALARM_12_TO_7_MASK	GENMASK(13, 8)
  #define AMS_CONF1_ALARM_2_TO_0_MASK	GENMASK(3, 1)
  #define AMS_CONF1_ALARM_6_TO_3_MASK	GENMASK(11, 8)
  #define AMS_CONF1_ALARM_12_TO_7_MASK	GENMASK(5, 0)
--- 117,146 ----
  #define AMS_ALARM_TEMP_REMOTE		0x194
  #define AMS_ALARM_THRESHOLD_OFF_10	0x10
  #define AMS_ALARM_THRESHOLD_OFF_20	0x20
+ #define AMS_ALARM_THRESHOLD_OFF_0C	0x0C
+ #define AMS_ALARM_THRESHOLD_OFF_M48	-0x48
  
  #define AMS_ALARM_THR_DIRECT_MASK	BIT(0)
  #define AMS_ALARM_THR_MIN		0x0000
  #define AMS_ALARM_THR_MAX		(BIT(16) - 1)
  
  #define AMS_ALARM_MASK			GENMASK_ULL(63, 0)
! #define AMS_NO_OF_ALARMS		35
  #define AMS_PL_ALARM_START		16
+ #define AMS_PS_OT_ALARM_START		32
+ #define AMS_PL_OT_ALARM_START		34
  #define AMS_PL_ALARM_MASK		GENMASK(31, 16)
  #define AMS_ISR0_ALARM_MASK		GENMASK(31, 0)
  #define AMS_ISR1_ALARM_MASK		(GENMASK(31, 29) | GENMASK(4, 0))
+ #define AMS_ISR1_ALARM_SHIFT		32
  #define AMS_ISR1_EOC_MASK		BIT(3)
  #define AMS_ISR1_INTR_MASK		GENMASK_ULL(63, 32)
  #define AMS_ISR0_ALARM_2_TO_0_MASK	GENMASK(2, 0)
  #define AMS_ISR0_ALARM_6_TO_3_MASK	GENMASK(6, 3)
  #define AMS_ISR0_ALARM_12_TO_7_MASK	GENMASK(13, 8)
+ #define AMS_ISR1_ALARM_2_MASK		BIT_ULL(34)
+ #define AMS_ISR1_ALARM_1_TO_0_MASK	GENMASK_ULL(33, 32)
+ #define AMS_CONF1_ALARM_OT_MASK	BIT(0)
  #define AMS_CONF1_ALARM_2_TO_0_MASK	GENMASK(3, 1)
  #define AMS_CONF1_ALARM_6_TO_3_MASK	GENMASK(11, 8)
  #define AMS_CONF1_ALARM_12_TO_7_MASK	GENMASK(5, 0)
***************
*** 161,166 ****
--- 169,175 ----
  
  #define AMS_TEMP_SCALE			509314
  #define AMS_TEMP_SCALE_DIV_BIT		16
+ #define AMS_TEMP_SCALE_DIV		BIT(AMS_TEMP_SCALE_DIV_BIT)
  #define AMS_TEMP_OFFSET			-((280230LL << 16) / 509314)
  
  enum ams_alarm_bit {
*************** enum ams_alarm_bit {
*** 178,183 ****
--- 187,195 ----
  	AMS_ALARM_BIT_SUPPLY10 = 11,
  	AMS_ALARM_BIT_VCCAMS = 12,
  	AMS_ALARM_BIT_TEMP_REMOTE = 13,
+ 	AMS_ALARM_BIT_TEMP_OT_REMOTE = 32,
+ 	AMS_ALARM_BIT_PS_TEMP_OT = 33,
+ 	AMS_ALARM_BIT_PL_TEMP_OT = 34,
  };
  
  enum ams_seq {
*************** enum ams_ps_pl_seq {
*** 227,232 ****
--- 239,245 ----
  	.indexed = 1, \
  	.address = (_addr), \
  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+ 		BIT(IIO_CHAN_INFO_PROCESSED) | \
  		BIT(IIO_CHAN_INFO_SCALE) | \
  		BIT(IIO_CHAN_INFO_OFFSET), \
  	.event_spec = ams_temp_events, \
*************** struct ams {
*** 286,293 ****
  	struct device *dev;
  	struct mutex lock;
  	spinlock_t intr_lock;
! 	unsigned int alarm_mask;
! 	unsigned int current_masked_alarm;
  	u64 intr_mask;
  	struct delayed_work ams_unmask_work;
  };
--- 299,306 ----
  	struct device *dev;
  	struct mutex lock;
  	spinlock_t intr_lock;
! 	u64 alarm_mask;
! 	u64 current_masked_alarm;
  	u64 intr_mask;
  	struct delayed_work ams_unmask_work;
  };
*************** static void ams_update_intrmask(struct a
*** 318,333 ****
  
  	ams->intr_mask = (ams->intr_mask & ~mask) | (val & mask);
  
! 	regval = ~(ams->intr_mask | ams->current_masked_alarm);
  	writel(regval, ams->base + AMS_IER_0);
  
! 	regval = ~(FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask));
  	writel(regval, ams->base + AMS_IER_1);
  
! 	regval = ams->intr_mask | ams->current_masked_alarm;
  	writel(regval, ams->base + AMS_IDR_0);
  
! 	regval = FIELD_GET(AMS_ISR1_INTR_MASK, ams->intr_mask);
  	writel(regval, ams->base + AMS_IDR_1);
  }
  
--- 331,350 ----
  
  	ams->intr_mask = (ams->intr_mask & ~mask) | (val & mask);
  
! 	regval = ~((ams->intr_mask | ams->current_masked_alarm) & AMS_ISR0_ALARM_MASK);
  	writel(regval, ams->base + AMS_IER_0);
  
! 	regval = ~(((ams->intr_mask | ams->current_masked_alarm) >>
! 		    AMS_ISR1_ALARM_SHIFT) &
! 		   AMS_ISR1_ALARM_MASK);
  	writel(regval, ams->base + AMS_IER_1);
  
! 	regval = ((ams->intr_mask | ams->current_masked_alarm) & AMS_ISR0_ALARM_MASK);
  	writel(regval, ams->base + AMS_IDR_0);
  
! 	regval = (((ams->intr_mask | ams->current_masked_alarm) >>
! 		   AMS_ISR1_ALARM_SHIFT) &
! 		  AMS_ISR1_ALARM_MASK);
  	writel(regval, ams->base + AMS_IDR_1);
  }
  
*************** static void ams_disable_all_alarms(struc
*** 350,356 ****
  	}
  }
  
! static void ams_update_ps_alarm(struct ams *ams, unsigned long alarm_mask)
  {
  	u32 cfg;
  	u32 val;
--- 367,373 ----
  	}
  }
  
! static void ams_update_ps_alarm(struct ams *ams, u64 alarm_mask)
  {
  	u32 cfg;
  	u32 val;
*************** static void ams_update_ps_alarm(struct a
*** 361,366 ****
--- 378,386 ----
  	val = FIELD_GET(AMS_ISR0_ALARM_6_TO_3_MASK, alarm_mask);
  	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_6_TO_3_MASK, val));
  
+ 	val = FIELD_GET(AMS_ISR1_ALARM_1_TO_0_MASK, alarm_mask);
+ 	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_OT_MASK, !!val));
+ 
  	ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK, cfg);
  
  	val = FIELD_GET(AMS_ISR0_ALARM_12_TO_7_MASK, alarm_mask);
*************** static void ams_update_ps_alarm(struct a
*** 368,374 ****
  	ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
  }
  
! static void ams_update_pl_alarm(struct ams *ams, unsigned long alarm_mask)
  {
  	unsigned long pl_alarm_mask;
  	u32 cfg;
--- 388,394 ----
  	ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK, cfg);
  }
  
! static void ams_update_pl_alarm(struct ams *ams, u64 alarm_mask)
  {
  	unsigned long pl_alarm_mask;
  	u32 cfg;
*************** static void ams_update_pl_alarm(struct a
*** 382,387 ****
--- 402,410 ----
  	val = FIELD_GET(AMS_ISR0_ALARM_6_TO_3_MASK, pl_alarm_mask);
  	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_6_TO_3_MASK, val));
  
+ 	val = FIELD_GET(AMS_ISR1_ALARM_2_MASK, alarm_mask);
+ 	cfg &= ~(FIELD_PREP(AMS_CONF1_ALARM_OT_MASK, val));
+ 
  	ams_pl_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK, cfg);
  
  	val = FIELD_GET(AMS_ISR0_ALARM_12_TO_7_MASK, pl_alarm_mask);
*************** static void ams_update_pl_alarm(struct a
*** 391,399 ****
  
  static void ams_unmask(struct ams *ams)
  {
! 	unsigned int status, unmask;
  
  	status = readl(ams->base + AMS_ISR_0);
  
  	/* Clear those bits which are not active anymore */
  	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
--- 414,423 ----
  
  static void ams_unmask(struct ams *ams)
  {
! 	u64 status, unmask;
  
  	status = readl(ams->base + AMS_ISR_0);
+ 	status |= ((u64)readl(ams->base + AMS_ISR_1) << AMS_ISR1_ALARM_SHIFT);
  
  	/* Clear those bits which are not active anymore */
  	unmask = (ams->current_masked_alarm ^ status) & ams->current_masked_alarm;
*************** static void ams_unmask(struct ams *ams)
*** 407,413 ****
  	ams->current_masked_alarm &= ~ams->intr_mask;
  
  	/* Clear the interrupts before we unmask them */
! 	writel(unmask, ams->base + AMS_ISR_0);
  
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  }
--- 431,439 ----
  	ams->current_masked_alarm &= ~ams->intr_mask;
  
  	/* Clear the interrupts before we unmask them */
! 	writel((unmask & AMS_ISR0_ALARM_MASK), ams->base + AMS_ISR_0);
! 	writel(((unmask >> AMS_ISR1_ALARM_SHIFT) & AMS_ISR1_ALARM_MASK),
! 	       ams->base + AMS_ISR_1);
  
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  }
*************** static void ams_update_alarm(struct ams
*** 423,429 ****
  		ams_update_pl_alarm(ams, alarm_mask);
  
  	spin_lock_irqsave(&ams->intr_lock, flags);
! 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
  	ams_unmask(ams);
  	spin_unlock_irqrestore(&ams->intr_lock, flags);
  }
--- 449,458 ----
  		ams_update_pl_alarm(ams, alarm_mask);
  
  	spin_lock_irqsave(&ams->intr_lock, flags);
! 	ams_update_intrmask(ams,
! 			    (AMS_ISR0_ALARM_MASK |
! 			     ((u64)AMS_ISR1_ALARM_MASK << AMS_ISR1_ALARM_SHIFT)),
! 			    ~alarm_mask);
  	ams_unmask(ams);
  	spin_unlock_irqrestore(&ams->intr_lock, flags);
  }
*************** static int ams_read_raw(struct iio_dev *
*** 717,725 ****
  			int *val, int *val2, long mask)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	int ret;
  
  	switch (mask) {
  	case IIO_CHAN_INFO_RAW:
  		mutex_lock(&ams->lock);
  		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
--- 746,765 ----
  			int *val, int *val2, long mask)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	int ret, regval;
  
  	switch (mask) {
+ 	case IIO_CHAN_INFO_PROCESSED:
+ 		mutex_lock(&ams->lock);
+ 		if (chan->scan_index >= AMS_PS_SEQ_MAX)
+ 			regval = readl(ams->pl_base + chan->address);
+ 		else
+ 			regval = readl(ams->ps_base + chan->address);
+ 
+ 		*val = ((regval + AMS_TEMP_OFFSET) * AMS_TEMP_SCALE) / AMS_TEMP_SCALE_DIV;
+ 		mutex_unlock(&ams->lock);
+ 		return IIO_VAL_INT;
+ 
  	case IIO_CHAN_INFO_RAW:
  		mutex_lock(&ams->lock);
  		if (chan->scan_index >= AMS_CTRL_SEQ_BASE) {
*************** unlock_mutex:
*** 765,771 ****
  	}
  }
  
! static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
  {
  	int offset;
  
--- 805,812 ----
  	}
  }
  
! static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir,
! 				enum iio_event_type type)
  {
  	int offset;
  
*************** static int ams_get_alarm_offset(int scan
*** 781,786 ****
--- 822,833 ----
  		offset = 0;
  	}
  
+ 	if (type == IIO_EV_TYPE_MAG) {
+ 		offset += (scan_index == AMS_SEQ_TEMP) ?
+ 				  AMS_ALARM_THRESHOLD_OFF_0C :
+ 				  AMS_ALARM_THRESHOLD_OFF_M48;
+ 	}
+ 
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
  		return AMS_ALARM_TEMP + offset;
*************** static const struct iio_chan_spec *ams_e
*** 818,829 ****
  {
  	int scan_index = 0, i;
  
! 	if (event >= AMS_PL_ALARM_START) {
  		event -= AMS_PL_ALARM_START;
  		scan_index = AMS_PS_SEQ_MAX;
  	}
  
  	switch (event) {
  	case AMS_ALARM_BIT_TEMP:
  		scan_index += AMS_SEQ_TEMP;
  		break;
--- 865,881 ----
  {
  	int scan_index = 0, i;
  
! 	if (event == AMS_PL_OT_ALARM_START) {
! 		scan_index = AMS_PS_SEQ_MAX;
! 	} else if ((event >= AMS_PL_ALARM_START) &&
! 		   (event < AMS_PS_OT_ALARM_START)) {
  		event -= AMS_PL_ALARM_START;
  		scan_index = AMS_PS_SEQ_MAX;
  	}
  
  	switch (event) {
+ 	case AMS_ALARM_BIT_PL_TEMP_OT:
+ 	case AMS_ALARM_BIT_PS_TEMP_OT:
  	case AMS_ALARM_BIT_TEMP:
  		scan_index += AMS_SEQ_TEMP;
  		break;
*************** static const struct iio_chan_spec *ams_e
*** 860,865 ****
--- 912,918 ----
  	case AMS_ALARM_BIT_VCCAMS:
  		scan_index += AMS_SEQ_VCCAMS;
  		break;
+ 	case AMS_ALARM_BIT_TEMP_OT_REMOTE:
  	case AMS_ALARM_BIT_TEMP_REMOTE:
  		scan_index += AMS_SEQ_TEMP_REMOTE;
  		break;
*************** static const struct iio_chan_spec *ams_e
*** 874,891 ****
  	return &dev->channels[i];
  }
  
! static int ams_get_alarm_mask(int scan_index)
  {
! 	int bit = 0;
  
  	if (scan_index >= AMS_PS_SEQ_MAX) {
  		bit = AMS_PL_ALARM_START;
  		scan_index -= AMS_PS_SEQ_MAX;
  	}
  
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
! 		return BIT(AMS_ALARM_BIT_TEMP + bit);
  	case AMS_SEQ_SUPPLY1:
  		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
  	case AMS_SEQ_SUPPLY2:
--- 927,947 ----
  	return &dev->channels[i];
  }
  
! static u64 ams_get_alarm_mask(int scan_index, enum iio_event_type type)
  {
! 	int bit = 0, ot_bit = 0;
  
  	if (scan_index >= AMS_PS_SEQ_MAX) {
  		bit = AMS_PL_ALARM_START;
+ 		ot_bit = 1;
  		scan_index -= AMS_PS_SEQ_MAX;
  	}
  
  	switch (scan_index) {
  	case AMS_SEQ_TEMP:
! 		if (type != IIO_EV_TYPE_MAG)
! 			return BIT(AMS_ALARM_BIT_TEMP + bit);
! 		return BIT(AMS_ALARM_BIT_PS_TEMP_OT + ot_bit);
  	case AMS_SEQ_SUPPLY1:
  		return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
  	case AMS_SEQ_SUPPLY2:
*************** static int ams_get_alarm_mask(int scan_i
*** 909,915 ****
  	case AMS_SEQ_VCCAMS:
  		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
  	case AMS_SEQ_TEMP_REMOTE:
! 		return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
  	default:
  		return 0;
  	}
--- 965,973 ----
  	case AMS_SEQ_VCCAMS:
  		return BIT(AMS_ALARM_BIT_VCCAMS + bit);
  	case AMS_SEQ_TEMP_REMOTE:
! 		if (type != IIO_EV_TYPE_MAG)
! 			return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
! 		return BIT_ULL(AMS_ALARM_BIT_TEMP_OT_REMOTE);
  	default:
  		return 0;
  	}
*************** static int ams_read_event_config(struct
*** 922,928 ****
  {
  	struct ams *ams = iio_priv(indio_dev);
  
! 	return !!(ams->alarm_mask & ams_get_alarm_mask(chan->scan_index));
  }
  
  static int ams_write_event_config(struct iio_dev *indio_dev,
--- 980,986 ----
  {
  	struct ams *ams = iio_priv(indio_dev);
  
! 	return !!(ams->alarm_mask & ams_get_alarm_mask(chan->scan_index, type));
  }
  
  static int ams_write_event_config(struct iio_dev *indio_dev,
*************** static int ams_write_event_config(struct
*** 932,940 ****
  				  int state)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int alarm;
  
! 	alarm = ams_get_alarm_mask(chan->scan_index);
  
  	mutex_lock(&ams->lock);
  
--- 990,998 ----
  				  int state)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	u64 alarm;
  
! 	alarm = ams_get_alarm_mask(chan->scan_index, type);
  
  	mutex_lock(&ams->lock);
  
*************** static int ams_read_event_value(struct i
*** 957,963 ****
  				enum iio_event_info info, int *val, int *val2)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
  
  	mutex_lock(&ams->lock);
  
--- 1015,1021 ----
  				enum iio_event_info info, int *val, int *val2)
  {
  	struct ams *ams = iio_priv(indio_dev);
! 	unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir, type);
  
  	mutex_lock(&ams->lock);
  
*************** static int ams_write_event_value(struct
*** 984,990 ****
  
  	/* Set temperature channel threshold to direct threshold */
  	if (chan->type == IIO_TEMP) {
! 		offset = ams_get_alarm_offset(chan->scan_index, IIO_EV_DIR_FALLING);
  
  		if (chan->scan_index >= AMS_PS_SEQ_MAX)
  			ams_pl_update_reg(ams, offset,
--- 1042,1048 ----
  
  	/* Set temperature channel threshold to direct threshold */
  	if (chan->type == IIO_TEMP) {
! 		offset = ams_get_alarm_offset(chan->scan_index, IIO_EV_DIR_FALLING, type);
  
  		if (chan->scan_index >= AMS_PS_SEQ_MAX)
  			ams_pl_update_reg(ams, offset,
*************** static int ams_write_event_value(struct
*** 996,1002 ****
  					  AMS_ALARM_THR_DIRECT_MASK);
  	}
  
! 	offset = ams_get_alarm_offset(chan->scan_index, dir);
  	if (chan->scan_index >= AMS_PS_SEQ_MAX)
  		writel(val, ams->pl_base + offset);
  	else
--- 1054,1060 ----
  					  AMS_ALARM_THR_DIRECT_MASK);
  	}
  
! 	offset = ams_get_alarm_offset(chan->scan_index, dir, type);
  	if (chan->scan_index >= AMS_PS_SEQ_MAX)
  		writel(val, ams->pl_base + offset);
  	else
*************** static void ams_handle_event(struct iio_
*** 1018,1028 ****
  		 * The temperature channel only supports over-temperature
  		 * events.
  		 */
! 		iio_push_event(indio_dev,
! 			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
! 						    IIO_EV_TYPE_THRESH,
! 						    IIO_EV_DIR_RISING),
! 			       iio_get_time_ns(indio_dev));
  	} else {
  		/*
  		 * For other channels we don't know whether it is a upper or
--- 1076,1096 ----
  		 * The temperature channel only supports over-temperature
  		 * events.
  		 */
! 		if (event < AMS_ALARM_BIT_TEMP_OT_REMOTE) {
! 			iio_push_event(indio_dev,
! 				       IIO_UNMOD_EVENT_CODE(chan->type,
! 							    chan->channel,
! 							    IIO_EV_TYPE_THRESH,
! 							    IIO_EV_DIR_RISING),
! 				       iio_get_time_ns(indio_dev));
! 		} else {
! 			iio_push_event(indio_dev,
! 				       IIO_UNMOD_EVENT_CODE(chan->type,
! 							    chan->channel,
! 							    IIO_EV_TYPE_MAG,
! 							    IIO_EV_DIR_RISING),
! 				       iio_get_time_ns(indio_dev));
! 		}
  	} else {
  		/*
  		 * For other channels we don't know whether it is a upper or
*************** static irqreturn_t ams_irq(int irq, void
*** 1074,1100 ****
  {
  	struct iio_dev *indio_dev = data;
  	struct ams *ams = iio_priv(indio_dev);
! 	u32 isr0;
  
  	spin_lock(&ams->intr_lock);
  
  	isr0 = readl(ams->base + AMS_ISR_0);
  
  	/* Only process alarms that are not masked */
! 	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->current_masked_alarm);
! 	if (!isr0) {
  		spin_unlock(&ams->intr_lock);
  		return IRQ_NONE;
  	}
  
  	/* Clear interrupt */
  	writel(isr0, ams->base + AMS_ISR_0);
  
  	/* Mask the alarm interrupts until cleared */
  	ams->current_masked_alarm |= isr0;
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  
! 	ams_handle_events(indio_dev, isr0);
  
  	schedule_delayed_work(&ams->ams_unmask_work,
  			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
--- 1142,1178 ----
  {
  	struct iio_dev *indio_dev = data;
  	struct ams *ams = iio_priv(indio_dev);
! 	u64 isr, isr0, isr1;
  
  	spin_lock(&ams->intr_lock);
  
  	isr0 = readl(ams->base + AMS_ISR_0);
+ 	isr1 = readl(ams->base + AMS_ISR_1);
  
  	/* Only process alarms that are not masked */
! 	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) |
! 		  ams->current_masked_alarm);
! 	isr1 &= ~(((ams->intr_mask &
! 		    ((u64)AMS_ISR1_ALARM_MASK << AMS_ISR1_ALARM_SHIFT)) |
! 		   ams->current_masked_alarm) >>
! 		  AMS_ISR1_ALARM_SHIFT);
! 	isr = (isr0 | (isr1 << AMS_ISR1_ALARM_SHIFT));
! 	if (!isr0 && !isr1) {
  		spin_unlock(&ams->intr_lock);
  		return IRQ_NONE;
  	}
  
  	/* Clear interrupt */
  	writel(isr0, ams->base + AMS_ISR_0);
+ 	writel(isr1, ams->base + AMS_ISR_1);
  
  	/* Mask the alarm interrupts until cleared */
  	ams->current_masked_alarm |= isr0;
+ 	ams->current_masked_alarm |= isr1 << AMS_ISR1_ALARM_SHIFT;
+ 
  	ams_update_intrmask(ams, ~AMS_ALARM_MASK, ~AMS_ALARM_MASK);
  
! 	ams_handle_events(indio_dev, isr);
  
  	schedule_delayed_work(&ams->ams_unmask_work,
  			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
*************** static const struct iio_event_spec ams_t
*** 1110,1115 ****
--- 1188,1198 ----
  		.dir = IIO_EV_DIR_RISING,
  		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
  	},
+ 	{
+ 		.type = IIO_EV_TYPE_MAG,
+ 		.dir = IIO_EV_DIR_RISING,
+ 		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+ 	}
  };
  
  static const struct iio_event_spec ams_voltage_events[] = {
*************** static int ams_parse_firmware(struct iio
*** 1316,1325 ****
  			/* set threshold to max and min for each channel */
  			falling_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_FALLING);
  			rising_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_RISING);
  			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
  				writel(AMS_ALARM_THR_MIN,
  				       ams->pl_base + falling_off);
--- 1399,1409 ----
  			/* set threshold to max and min for each channel */
  			falling_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_FALLING, IIO_EV_TYPE_THRESH);
  			rising_off =
  				ams_get_alarm_offset(ams_channels[i].scan_index,
! 						     IIO_EV_DIR_RISING, IIO_EV_TYPE_THRESH);
! 
  			if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
  				writel(AMS_ALARM_THR_MIN,
  				       ams->pl_base + falling_off);
*************** static int ams_parse_firmware(struct iio
*** 1331,1336 ****
--- 1415,1438 ----
  				writel(AMS_ALARM_THR_MAX,
  				       ams->ps_base + rising_off);
  			}
+ 
+ 			/* also set OT thresholds for temperature channels*/
+ 			if (ams_channels[i].type == IIO_TEMP) {
+ 				falling_off =
+ 					ams_get_alarm_offset(ams_channels[i].scan_index,
+ 							     IIO_EV_DIR_FALLING, IIO_EV_TYPE_MAG);
+ 				rising_off =
+ 					ams_get_alarm_offset(ams_channels[i].scan_index,
+ 							     IIO_EV_DIR_RISING, IIO_EV_TYPE_MAG);
+ 
+ 				if (ams_channels[i].scan_index >= AMS_PS_SEQ_MAX) {
+ 					writel(AMS_ALARM_THR_MIN, ams->pl_base + falling_off);
+ 					writel(AMS_ALARM_THR_MAX, ams->pl_base + rising_off);
+ 				} else {
+ 					writel(AMS_ALARM_THR_MIN, ams->ps_base + falling_off);
+ 					writel(AMS_ALARM_THR_MAX, ams->ps_base + rising_off);
+ 				}
+ 			}
  		}
  	}
  
```

####### Make 214_drivers-iio.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
Hunk #1 succeeded at 618 (offset 1 line).
Hunk #2 succeeded at 1661 (offset 1 line).
patching file drivers/iio/adc/Makefile
patching file drivers/iio/adc/ina260-adc.c
patching file drivers/iio/adc/versal-sysmon-core.c
patching file drivers/iio/adc/versal-sysmon-i2c.c
patching file drivers/iio/adc/versal-sysmon.c
patching file drivers/iio/adc/versal-sysmon.h
patching file drivers/iio/adc/xilinx-ams.c
Hunk #19 succeeded at 930 (offset 3 lines).
Hunk #20 succeeded at 968 (offset 3 lines).
Hunk #21 succeeded at 983 (offset 3 lines).
Hunk #22 succeeded at 993 (offset 3 lines).
Hunk #23 succeeded at 1018 (offset 3 lines).
Hunk #24 succeeded at 1045 (offset 3 lines).
Hunk #25 succeeded at 1057 (offset 3 lines).
Hunk #26 succeeded at 1081 (offset 5 lines).
Hunk #27 succeeded at 1147 (offset 5 lines).
Hunk #28 succeeded at 1193 (offset 5 lines).
Hunk #29 succeeded at 1404 (offset 5 lines).
Hunk #30 succeeded at 1420 (offset 5 lines).
patching file drivers/iio/adc/xilinx-xadc-core.c
patching file include/linux/iio/adc/versal-sysmon-events.h
```

```console
shell$ rm drivers/iio/adc/Kconfig.orig
shell$ rm drivers/iio/adc/xilinx-ams.c.orig
shell$ git add --all
shell$ git commit -m "[patch] 214_drivers-iio.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/214_drivers-iio.patch
```

###### 224_drivers-media-v4l2.patch

####### drivers/media/v4l2-core/v4l2-common.c

```console
shell$ diff -p linux-6.12.95/drivers/media/v4l2-core/v4l2-common.c linux-6.12.100/drivers/media/v4l2-core/v4l2-common.c
*** linux-6.12.95/drivers/media/v4l2-core/v4l2-common.c	2026-07-11 11:11:42.631043259 +0900
--- linux-6.12.100/drivers/media/v4l2-core/v4l2-common.c	2026-08-05 10:45:15.757789227 +0900
*************** const struct v4l2_format_info *v4l2_form
*** 269,274 ****
--- 269,275 ----
  		{ .format = V4L2_PIX_FMT_Y212,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 1 },
  		{ .format = V4L2_PIX_FMT_Y216,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 4, 0, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 2, .vdiv = 1 },
  		{ .format = V4L2_PIX_FMT_YUV48_12, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 6, 0, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 1 },
+ 		{ .format = V4L2_PIX_FMT_YUV24,   .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 3, 0, 0, 0 }, .bpp_div = { 1, 1, 1, 1 }, .hdiv = 1, .vdiv = 1 },
  		{ .format = V4L2_PIX_FMT_MT2110T, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 2,
  		  .block_w = { 16, 8, 0, 0 }, .block_h = { 32, 16, 0, 0 }},
  		{ .format = V4L2_PIX_FMT_MT2110R, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 2, .comp_planes = 2, .bpp = { 5, 10, 0, 0 }, .bpp_div = { 4, 4, 1, 1 }, .hdiv = 2, .vdiv = 2,
```

####### Make 224_drivers-media-v4l2.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/224_drivers-media-v4l2.patch
patching file Documentation/userspace-api/media/v4l/biblio.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-defs.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-details.rst
patching file Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
patching file Documentation/userspace-api/media/v4l/subdev-formats.rst
patching file Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
patching file Documentation/userspace-api/media/videodev2.h.rst.exceptions
patching file drivers/media/v4l2-core/v4l2-common.c
Hunk #1 succeeded at 291 (offset 1 line).
Hunk #2 succeeded at 307 (offset 1 line).
patching file drivers/media/v4l2-core/v4l2-ioctl.c
patching file include/media/hdr-ctrls.h
patching file include/media/media-entity.h
patching file include/uapi/linux/media-bus-format.h
patching file include/uapi/linux/v4l2-mediabus.h
patching file include/uapi/linux/videodev2.h
patching file include/uapi/linux/xilinx-dprxss.h
patching file include/uapi/linux/xilinx-hdmirxss.h
patching file include/uapi/linux/xilinx-hls.h
patching file include/uapi/linux/xilinx-sdirxss.h
patching file include/uapi/linux/xilinx-v4l2-controls.h
patching file include/uapi/linux/xilinx-v4l2-events.h
patching file usr/include/Makefile
```

```console
shell$ rm drivers/media/v4l2-core/v4l2-common.c.orig
shell$ git add --all
shell$ git commit -m "[atch] 224_drivers-media-v4l2.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/224_drivers-media-v4l2.patch
```

###### 225_drivers-mfd.patch

####### drivers/mfd/rsmu_i2c.c

```console
shell$ diff -p linux-6.12.95/drivers/mfd/rsmu_i2c.c linux-6.12.100/drivers/mfd/rsmu_i2c.c
*** linux-6.12.95/drivers/mfd/rsmu_i2c.c	2026-07-11 11:11:42.651040761 +0900
--- linux-6.12.100/drivers/mfd/rsmu_i2c.c	2026-08-05 10:45:15.777356219 +0900
*************** static int rsmu_i2c_write_device(struct
*** 134,147 ****
  static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg,
  				    rsmu_rw_device rsmu_write_device)
  {
! 	u32 page = reg & RSMU_CM_PAGE_MASK;
  	u8 buf[4];
  	int err;
  
- 	/* Do not modify offset register for none-scsr registers */
- 	if (reg < RSMU_CM_SCSR_BASE)
- 		return 0;
- 
  	/* Simply return if we are on the same page */
  	if (rsmu->page == page)
  		return 0;
--- 134,143 ----
  static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg,
  				    rsmu_rw_device rsmu_write_device)
  {
! 	u32 page = (reg | RSMU_CM_SCSR_BASE) & RSMU_CM_PAGE_MASK;
  	u8 buf[4];
  	int err;
  
  	/* Simply return if we are on the same page */
  	if (rsmu->page == page)
  		return 0;
```

```console
shell$ diff -p linux-6.12.95/drivers/mfd/rsmu_i2c.c linux-6.12.95-xlnx-v2025.1/drivers/mfd/rsmu_i2c.c
*** linux-6.12.95/drivers/mfd/rsmu_i2c.c	2026-07-11 11:11:42.651040761 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/mfd/rsmu_i2c.c	2026-07-11 14:38:04.986030242 +0900
*************** static const struct regmap_config rsmu_s
*** 262,272 ****
  	.can_multi_write = true,
  };
  
! static const struct regmap_config rsmu_sl_regmap_config = {
  	.reg_bits = 16,
  	.val_bits = 8,
  	.reg_format_endian = REGMAP_ENDIAN_BIG,
! 	.max_register = 0x340,
  	.cache_type = REGCACHE_NONE,
  	.can_multi_write = true,
  };
--- 262,272 ----
  	.can_multi_write = true,
  };
  
! static const struct regmap_config rsmu_fc3_regmap_config = {
  	.reg_bits = 16,
  	.val_bits = 8,
  	.reg_format_endian = REGMAP_ENDIAN_BIG,
! 	.max_register = 0xE88,
  	.cache_type = REGCACHE_NONE,
  	.can_multi_write = true,
  };
*************** static int rsmu_i2c_probe(struct i2c_cli
*** 302,309 ****
  	case RSMU_SABRE:
  		cfg = &rsmu_sabre_regmap_config;
  		break;
! 	case RSMU_SL:
! 		cfg = &rsmu_sl_regmap_config;
  		break;
  	default:
  		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
--- 302,309 ----
  	case RSMU_SABRE:
  		cfg = &rsmu_sabre_regmap_config;
  		break;
! 	case RSMU_FC3:
! 		cfg = &rsmu_fc3_regmap_config;
  		break;
  	default:
  		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
*************** static const struct i2c_device_id rsmu_i
*** 336,343 ****
  	{ "8a34001",  RSMU_CM },
  	{ "82p33810", RSMU_SABRE },
  	{ "82p33811", RSMU_SABRE },
! 	{ "8v19n850", RSMU_SL },
! 	{ "8v19n851", RSMU_SL },
  	{}
  };
  MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
--- 336,343 ----
  	{ "8a34001",  RSMU_CM },
  	{ "82p33810", RSMU_SABRE },
  	{ "82p33811", RSMU_SABRE },
! 	{ "rc38xxx0", RSMU_FC3 },
! 	{ "rc38xxx1", RSMU_FC3 },
  	{}
  };
  MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
*************** static const struct of_device_id rsmu_i2
*** 347,354 ****
  	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
  	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
  	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
! 	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
! 	{ .compatible = "idt,8v19n851", .data = (void *)RSMU_SL },
  	{}
  };
  MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
--- 347,354 ----
  	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
  	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
  	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
! 	{ .compatible = "idt,rc38xxx0", .data = (void *)RSMU_FC3 },
! 	{ .compatible = "idt,rc38xxx1", .data = (void *)RSMU_FC3 },
  	{}
  };
  MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
```

####### Make 225_drivers-mfd.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
Hunk #1 succeeded at 258 (offset -4 lines).
Hunk #2 succeeded at 298 (offset -4 lines).
Hunk #3 succeeded at 332 (offset -4 lines).
Hunk #4 succeeded at 343 (offset -4 lines).
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
```

```console
shell$ rm drivers/mfd/rsmu_i2c.c.orig
shell$ git add --all
shell$ git commit -m "patch] 225_drivers-mfd.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/225_drivers-mfd.patch
```

###### 228_drivers-mtd.patch

####### drivers/mtd/spi-nor/spansion.c

```console
shell$ diff -p linux-6.12.95/drivers/mtd/spi-nor/spansion.c linux-6.12.100/drivers/mtd/spi-nor/spansion.c
*** linux-6.12.95/drivers/mtd/spi-nor/spansion.c	2026-07-11 11:11:42.699034768 +0900
--- linux-6.12.100/drivers/mtd/spi-nor/spansion.c	2026-08-05 10:45:15.824317001 +0900
*************** static int s25hx_t_late_init(struct spi_
*** 674,680 ****
  	params->ready = cypress_nor_sr_ready_and_clear;
  	cypress_nor_ecc_init(nor);
  
! 	params->die_erase_opcode = SPINOR_OP_CYPRESS_DIE_ERASE;
  	return 0;
  }
  
--- 674,682 ----
  	params->ready = cypress_nor_sr_ready_and_clear;
  	cypress_nor_ecc_init(nor);
  
! 	if (params->n_dice > 1)
! 		params->die_erase_opcode = SPINOR_OP_CYPRESS_DIE_ERASE;
! 
  	return 0;
  }
  
```

####### drivers/mtd/spi-nor/swp.c

```console
shell$ diff -p linux-6.12.95/drivers/mtd/spi-nor/swp.c linux-6.12.100/drivers/mtd/spi-nor/swp.c
*** linux-6.12.95/drivers/mtd/spi-nor/swp.c	2026-07-11 11:11:42.699034768 +0900
--- linux-6.12.100/drivers/mtd/spi-nor/swp.c	2026-08-05 10:45:15.824317001 +0900
*************** static int spi_nor_sr_unlock(struct spi_
*** 281,288 ****
  	/* Prefer top, if both are valid */
  	use_top = can_be_top;
  
! 	/* lock_len: length of region that should remain locked */
! 	if (use_top)
  		lock_len = nor->params->size - (ofs + len);
  	else
  		lock_len = ofs;
--- 281,295 ----
  	/* Prefer top, if both are valid */
  	use_top = can_be_top;
  
! 	/*
! 	 * lock_len: length of region that should remain locked.
! 	 *
! 	 * When can_be_top and can_be_bottom booleans are true, both adjacent
! 	 * regions are unlocked, thus the entire flash can be unlocked.
! 	 */
! 	if (can_be_top && can_be_bottom)
! 		lock_len = 0;
! 	else if (use_top)
  		lock_len = nor->params->size - (ofs + len);
  	else
  		lock_len = ofs;
```

```console
shell$ diff -p linux-6.12.95/drivers/mtd/spi-nor/swp.c linux-6.12.95-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c
*** linux-6.12.95/drivers/mtd/spi-nor/swp.c	2026-07-11 11:11:42.699034768 +0900
--- linux-6.12.95-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c	2026-07-11 14:38:05.654033072 +0900
***************
*** 7,12 ****
--- 7,13 ----
   */
  #include <linux/mtd/mtd.h>
  #include <linux/mtd/spi-nor.h>
+ #include <linux/mtd/cfi.h>
  
  #include "core.h"
  
*************** static u8 spi_nor_get_sr_bp_mask(struct
*** 16,21 ****
--- 17,24 ----
  
  	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6)
  		return mask | SR_BP3_BIT6;
+ 	else if (nor->flags & SNOR_F_HAS_SR_BP3_BIT5)
+ 		return mask | SR_BP3_BIT5;
  
  	if (nor->flags & SNOR_F_HAS_4BIT_BP)
  		return mask | SR_BP3;
*************** static u8 spi_nor_get_sr_tb_mask(struct
*** 35,49 ****
  
  static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
  {
  	unsigned int bp_slots, bp_slots_needed;
  	/*
  	 * sector_size will eventually be replaced with the max erase size of
  	 * the flash. For now, we need to have that ugly default.
  	 */
  	unsigned int sector_size = nor->info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE;
! 	u64 n_sectors = div_u64(nor->params->size, sector_size);
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
  
  	/* Reserved one for "protect none" and one for "protect all". */
  	bp_slots = (1 << hweight8(mask)) - 2;
  	bp_slots_needed = ilog2(n_sectors);
--- 38,59 ----
  
  static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
  {
+ 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
  	unsigned int bp_slots, bp_slots_needed;
  	/*
  	 * sector_size will eventually be replaced with the max erase size of
  	 * the flash. For now, we need to have that ugly default.
  	 */
  	unsigned int sector_size = nor->info->sector_size ?: SPI_NOR_DEFAULT_SECTOR_SIZE;
! 	u64 n_sectors = div_u64(params->size, sector_size);
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
  
+ 	if (nor->flags & SNOR_F_HAS_STACKED)
+ 		n_sectors <<= 1;
+ 
+ 	if (nor->flags & SNOR_F_HAS_PARALLEL)
+ 		sector_size <<= 1;
+ 
  	/* Reserved one for "protect none" and one for "protect all". */
  	bp_slots = (1 << hweight8(mask)) - 2;
  	bp_slots_needed = ilog2(n_sectors);
*************** static u64 spi_nor_get_min_prot_length_s
*** 57,67 ****
--- 67,81 ----
  static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
  					u64 *len)
  {
+ 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
  	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
  	u8 bp, val = sr & mask;
  
+ 	if (nor->flags & SNOR_F_HAS_CR_TB)
+ 		sr |= tb_mask;
+ 
  	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
  		val = (val & ~SR_BP3_BIT6) | SR_BP3;
  
*************** static void spi_nor_get_locked_range_sr(
*** 77,89 ****
  	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
  	*len = min_prot_len << (bp - 1);
  
! 	if (*len > nor->params->size)
! 		*len = nor->params->size;
  
  	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
  		*ofs = 0;
  	else
! 		*ofs = nor->params->size - *len;
  }
  
  /*
--- 91,103 ----
  	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
  	*len = min_prot_len << (bp - 1);
  
! 	if (*len > mtd->size)
! 		*len = mtd->size;
  
  	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
  		*ofs = 0;
  	else
! 		*ofs = mtd->size - *len;
  }
  
  /*
*************** static bool spi_nor_is_unlocked_sr(struc
*** 158,163 ****
--- 172,178 ----
   */
  static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
  {
+ 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	int ret, status_old, status_new;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
*************** static int spi_nor_sr_lock(struct spi_no
*** 182,188 ****
  		can_be_bottom = false;
  
  	/* If anything above us is unlocked, we can't use 'top' protection */
! 	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
  				  status_old))
  		can_be_top = false;
  
--- 197,203 ----
  		can_be_bottom = false;
  
  	/* If anything above us is unlocked, we can't use 'top' protection */
! 	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
  				  status_old))
  		can_be_top = false;
  
*************** static int spi_nor_sr_lock(struct spi_no
*** 194,204 ****
  
  	/* lock_len: length of region that should end up locked */
  	if (use_top)
! 		lock_len = nor->params->size - ofs;
  	else
  		lock_len = ofs + len;
  
! 	if (lock_len == nor->params->size) {
  		val = mask;
  	} else {
  		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
--- 209,219 ----
  
  	/* lock_len: length of region that should end up locked */
  	if (use_top)
! 		lock_len = mtd->size - ofs;
  	else
  		lock_len = ofs + len;
  
! 	if (lock_len == mtd->size) {
  		val = mask;
  	} else {
  		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
*************** static int spi_nor_sr_lock(struct spi_no
*** 207,212 ****
--- 222,230 ----
  
  		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
  			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+ 		else if (nor->flags & SNOR_F_HAS_SR_BP3_BIT5 &&
+ 			 val & SR_BP3_BIT5)
+ 			val |= SR_BP3_BIT5;
  
  		if (val & ~mask)
  			return -EINVAL;
*************** static int spi_nor_sr_lock(struct spi_no
*** 226,232 ****
  	if (!(nor->flags & SNOR_F_NO_WP))
  		status_new |= SR_SRWD;
  
! 	if (!use_top)
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
--- 244,250 ----
  	if (!(nor->flags & SNOR_F_NO_WP))
  		status_new |= SR_SRWD;
  
! 	if (!use_top && !(nor->flags & SNOR_F_HAS_CR_TB))
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
*************** static int spi_nor_sr_lock(struct spi_no
*** 240,245 ****
--- 258,283 ----
  	return spi_nor_write_sr_and_check(nor, status_new);
  }
  
+ static bool spi_nor_is_lower_area(struct spi_nor *nor, loff_t ofs, uint64_t len)
+ {
+ 	struct mtd_info *mtd = &nor->mtd;
+ 
+ 	if (nor->flags & SNOR_F_HAS_SR_TB)
+ 		return ((ofs + len) <= (mtd->size >> 1));
+ 
+ 	return false;
+ }
+ 
+ static bool spi_nor_is_upper_area(struct spi_nor *nor, loff_t ofs, uint64_t len)
+ {
+ 	struct mtd_info *mtd = &nor->mtd;
+ 
+ 	if ((nor->flags & SNOR_F_HAS_SR_TB))
+ 		return (ofs >= (mtd->size >> 1));
+ 
+ 	return true;
+ }
+ 
  /*
   * Unlock a region of the flash. See spi_nor_sr_lock() for more info
   *
*************** static int spi_nor_sr_lock(struct spi_no
*** 247,252 ****
--- 285,291 ----
   */
  static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
  {
+ 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	int ret, status_old, status_new;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
*************** static int spi_nor_sr_unlock(struct spi_
*** 267,278 ****
  		return 0;
  
  	/* If anything below us is locked, we can't use 'top' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
! 				    status_old))
  		can_be_bottom = false;
  
  	if (!can_be_bottom && !can_be_top)
--- 306,318 ----
  		return 0;
  
  	/* If anything below us is locked, we can't use 'top' protection */
! 	if ((!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old)) ||
! 	    spi_nor_is_lower_area(nor, ofs, len))
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
! 				    status_old) || spi_nor_is_upper_area(nor, ofs, len))
  		can_be_bottom = false;
  
  	if (!can_be_bottom && !can_be_top)
*************** static int spi_nor_sr_unlock(struct spi_
*** 283,289 ****
  
  	/* lock_len: length of region that should remain locked */
  	if (use_top)
! 		lock_len = nor->params->size - (ofs + len);
  	else
  		lock_len = ofs;
  
--- 323,329 ----
  
  	/* lock_len: length of region that should remain locked */
  	if (use_top)
! 		lock_len = mtd->size - (ofs + len);
  	else
  		lock_len = ofs;
  
*************** static int spi_nor_sr_unlock(struct spi_
*** 296,301 ****
--- 336,344 ----
  
  		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
  			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+ 		else if (nor->flags & SNOR_F_HAS_SR_BP3_BIT5 &&
+ 			 val & SR_BP3_BIT5)
+ 			val |= SR_BP3_BIT5;
  
  		/* Some power-of-two sizes are not supported */
  		if (val & ~mask)
*************** static int spi_nor_sr_unlock(struct spi_
*** 308,314 ****
  	if (lock_len == 0)
  		status_new &= ~SR_SRWD;
  
! 	if (!use_top)
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
--- 351,357 ----
  	if (lock_len == 0)
  		status_new &= ~SR_SRWD;
  
! 	if (!use_top && !(nor->flags & SNOR_F_HAS_CR_TB))
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
*************** static const struct spi_nor_locking_ops
*** 348,388 ****
  
  void spi_nor_init_default_locking_ops(struct spi_nor *nor)
  {
! 	nor->params->locking_ops = &spi_nor_sr_locking_ops;
  }
  
! static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, u64 len)
  {
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
  	int ret;
  
  	ret = spi_nor_prep_and_lock(nor);
  	if (ret)
  		return ret;
  
! 	ret = nor->params->locking_ops->lock(nor, ofs, len);
  
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, u64 len)
  {
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
  	int ret;
  
  	ret = spi_nor_prep_and_lock(nor);
  	if (ret)
  		return ret;
  
! 	ret = nor->params->locking_ops->unlock(nor, ofs, len);
  
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, u64 len)
  {
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
  	int ret;
  
--- 391,529 ----
  
  void spi_nor_init_default_locking_ops(struct spi_nor *nor)
  {
! 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
! 
! 	params->locking_ops = &spi_nor_sr_locking_ops;
  }
  
! static inline u16 min_lockable_sectors(struct spi_nor *nor,
! 				       u16 n_sectors)
  {
+ 	u16 lock_granularity;
+ 
+ 	/*
+ 	 * Revisit - SST (not used by us) has the same JEDEC ID as micron but
+ 	 * protected area table is similar to that of spansion.
+ 	 */
+ 	lock_granularity = max(1, n_sectors / M25P_MAX_LOCKABLE_SECTORS);
+ 	if (nor->info->id->bytes[0] == CFI_MFR_ST ||	/* Micron */
+ 	    nor->info->id->bytes[0] == CFI_MFR_PMC ||	/* ISSI */
+ 	    nor->info->id->bytes[0] == CFI_MFR_MACRONIX)	/* Macronix */
+ 		lock_granularity = 1;
+ 
+ 	return lock_granularity;
+ }
+ 
+ static inline uint32_t get_protected_area_start(struct spi_nor *nor,
+ 						u8 lock_bits)
+ {
+ 	struct mtd_info *mtd = &nor->mtd;
+ 	u32 sector_size;
+ 	u16 n_sectors;
+ 	u64 mtd_size;
+ 
+ 	n_sectors = nor->info->size / nor->info->sector_size;
+ 	sector_size = nor->info->sector_size;
+ 	mtd_size = mtd->size;
+ 
+ 	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+ 		sector_size = (nor->info->sector_size >> 1);
+ 		mtd_size = (mtd->size >> 1);
+ 	}
+ 	if (nor->flags & SNOR_F_HAS_STACKED) {
+ 		n_sectors >>= 1;
+ 		mtd_size = (mtd->size >> 1);
+ 	}
+ 
+ 	return mtd_size - (1 << (lock_bits - 1)) *
+ 		min_lockable_sectors(nor, n_sectors) * sector_size;
+ }
+ 
+ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+ {
+ 	struct spi_nor_flash_parameter *params;
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+ 	u32 cur_cs_num = 0;
  	int ret;
+ 	u64 sz;
  
  	ret = spi_nor_prep_and_lock(nor);
  	if (ret)
  		return ret;
  
! 	params = spi_nor_get_params(nor, 0);
! 	sz = params->size;
  
+ 	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+ 		/* Determine the flash from which the operation need to start */
+ 		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (ofs > sz - 1) && params) {
+ 			cur_cs_num++;
+ 			params = spi_nor_get_params(nor, cur_cs_num);
+ 			sz += params->size;
+ 		}
+ 	}
+ 	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+ 		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+ 		ofs /= 2;
+ 	} else {
+ 		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+ 		params = spi_nor_get_params(nor, cur_cs_num);
+ 		ofs -= (sz - params->size);
+ 	}
+ 	ret = params->locking_ops->lock(nor, ofs, len);
+ 	/* Wait until finished previous command */
+ 	ret = spi_nor_wait_till_ready(nor);
+ 	if (ret)
+ 		goto err;
+ err:
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, u64 len)
  {
+ 	struct spi_nor_flash_parameter *params;
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+ 	u32 cur_cs_num = 0;
  	int ret;
+ 	u64 sz;
  
  	ret = spi_nor_prep_and_lock(nor);
  	if (ret)
  		return ret;
  
! 	params = spi_nor_get_params(nor, 0);
! 	sz = params->size;
  
+ 	if (!(nor->flags & SNOR_F_HAS_PARALLEL)) {
+ 		/* Determine the flash from which the operation need to start */
+ 		while ((cur_cs_num < SNOR_FLASH_CNT_MAX) && (ofs > sz - 1) && params) {
+ 			cur_cs_num++;
+ 			params = spi_nor_get_params(nor, cur_cs_num);
+ 			sz += params->size;
+ 		}
+ 	}
+ 	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+ 		nor->spimem->spi->cs_index_mask = SPI_NOR_ENABLE_MULTI_CS;
+ 		ofs /= 2;
+ 	} else {
+ 		nor->spimem->spi->cs_index_mask = 0x01 << cur_cs_num;
+ 		params = spi_nor_get_params(nor, cur_cs_num);
+ 		ofs -= (sz - params->size);
+ 	}
+ 	ret = params->locking_ops->unlock(nor, ofs, len);
+ 	/* Wait until finished previous command */
+ 	ret = spi_nor_wait_till_ready(nor);
+ 	if (ret)
+ 		goto err;
+ err:
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, u64 len)
  {
+ 	struct spi_nor_flash_parameter *params;
  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
  	int ret;
  
*************** static int spi_nor_is_locked(struct mtd_
*** 390,401 ****
  	if (ret)
  		return ret;
  
! 	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
  
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  /**
   * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
   * @nor:	pointer to a 'struct spi_nor'.
--- 531,563 ----
  	if (ret)
  		return ret;
  
! 	params = spi_nor_get_params(nor, 0);
! 	ret = params->locking_ops->is_locked(nor, ofs, len);
  
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
+ static void spi_nor_prot_unlock(struct spi_nor *nor)
+ {
+ 	if (nor->info->flags & SST_GLOBAL_PROT_UNLK) {
+ 		spi_nor_write_enable(nor);
+ 		if (nor->spimem) {
+ 			struct spi_mem_op op =
+ 				SPI_MEM_OP(SPI_MEM_OP_CMD(GLOBAL_BLKPROT_UNLK, 1),
+ 					   SPI_MEM_OP_NO_ADDR,
+ 					   SPI_MEM_OP_NO_DUMMY,
+ 					   SPI_MEM_OP_NO_DATA);
+ 
+ 			spi_mem_exec_op(nor->spimem, &op);
+ 		} else {
+ 			/* Unlock global write protection bits */
+ 			nor->controller_ops->write_reg(nor, GLOBAL_BLKPROT_UNLK, NULL, 0);
+ 		}
+ 	}
+ 	spi_nor_wait_till_ready(nor);
+ }
+ 
  /**
   * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
   * @nor:	pointer to a 'struct spi_nor'.
*************** static int spi_nor_is_locked(struct mtd_
*** 410,432 ****
   */
  void spi_nor_try_unlock_all(struct spi_nor *nor)
  {
  	int ret;
  
  	if (!(nor->flags & SNOR_F_HAS_LOCK))
  		return;
  
  	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
  
! 	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
! 	if (ret)
! 		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
  }
  
  void spi_nor_set_mtd_locking_ops(struct spi_nor *nor)
  {
  	struct mtd_info *mtd = &nor->mtd;
  
! 	if (!nor->params->locking_ops)
  		return;
  
  	mtd->_lock = spi_nor_lock;
--- 572,606 ----
   */
  void spi_nor_try_unlock_all(struct spi_nor *nor)
  {
+ 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
  	int ret;
+ 	const struct flash_info *info = nor->info;
  
  	if (!(nor->flags & SNOR_F_HAS_LOCK))
  		return;
  
  	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
  
! 	if (nor->info->id->bytes[0] == CFI_MFR_ATMEL ||
! 	    nor->info->id->bytes[0] == CFI_MFR_INTEL ||
! 	    nor->info->id->bytes[0] == CFI_MFR_SST ||
! 	    nor->flags & SNOR_F_HAS_LOCK) {
! 		if (info->flags & SST_GLOBAL_PROT_UNLK) {
! 			spi_nor_prot_unlock(nor);
! 		} else {
! 			ret = spi_nor_unlock(&nor->mtd, 0, params->size);
! 			if (ret)
! 				dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
! 		}
! 	}
  }
  
  void spi_nor_set_mtd_locking_ops(struct spi_nor *nor)
  {
+ 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
  	struct mtd_info *mtd = &nor->mtd;
  
! 	if (!params->locking_ops)
  		return;
  
  	mtd->_lock = spi_nor_lock;
```


####### Make 228_drivers-mtd.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/228_drivers-mtd.patch
patching file Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
patching file drivers/mtd/spi-nor/atmel.c
patching file drivers/mtd/spi-nor/core.c
patching file drivers/mtd/spi-nor/core.h
patching file drivers/mtd/spi-nor/debugfs.c
patching file drivers/mtd/spi-nor/everspin.c
patching file drivers/mtd/spi-nor/gigadevice.c
patching file drivers/mtd/spi-nor/issi.c
patching file drivers/mtd/spi-nor/macronix.c
patching file drivers/mtd/spi-nor/micron-st.c
patching file drivers/mtd/spi-nor/otp.c
patching file drivers/mtd/spi-nor/sfdp.c
patching file drivers/mtd/spi-nor/spansion.c
Hunk #21 succeeded at 734 (offset 2 lines).
Hunk #22 succeeded at 778 (offset 2 lines).
Hunk #23 succeeded at 792 (offset 2 lines).
Hunk #24 succeeded at 874 (offset 2 lines).
Hunk #25 succeeded at 888 (offset 2 lines).
Hunk #26 succeeded at 902 (offset 2 lines).
Hunk #27 succeeded at 927 (offset 2 lines).
Hunk #28 succeeded at 941 (offset 2 lines).
Hunk #29 succeeded at 986 (offset 2 lines).
Hunk #30 succeeded at 1022 (offset 2 lines).
Hunk #31 succeeded at 1043 (offset 2 lines).
Hunk #32 succeeded at 1074 (offset 2 lines).
Hunk #33 succeeded at 1140 (offset 2 lines).
patching file drivers/mtd/spi-nor/sst.c
patching file drivers/mtd/spi-nor/swp.c
Hunk #14 FAILED at 323.
Hunk #15 succeeded at 343 (offset 7 lines).
Hunk #16 succeeded at 358 (offset 7 lines).
Hunk #17 succeeded at 398 (offset 7 lines).
Hunk #18 succeeded at 538 (offset 7 lines).
Hunk #19 succeeded at 579 (offset 7 lines).
1 out of 19 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/swp.c.rej
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
```

```console
sehll$ cp ../linux-6.12.95-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c drivers/mtd/spi-nor/swp.c
```

Fix drivers/mtd/spi-nor/swp.c

```console
shell$ diff -p ../linux-6.12.95-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c drivers/mtd/spi-nor/swp.c 
*** ../linux-6.12.95-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c	2026-07-11 14:38:05.654033072 +0900
--- drivers/mtd/spi-nor/swp.c	2026-08-05 12:37:00.203256661 +0900
*************** static int spi_nor_sr_unlock(struct spi_
*** 321,328 ****
  	/* Prefer top, if both are valid */
  	use_top = can_be_top;
  
! 	/* lock_len: length of region that should remain locked */
! 	if (use_top)
  		lock_len = mtd->size - (ofs + len);
  	else
  		lock_len = ofs;
--- 321,335 ----
  	/* Prefer top, if both are valid */
  	use_top = can_be_top;
  
! 	/*
! 	 * lock_len: length of region that should remain locked.
! 	 *
! 	 * When can_be_top and can_be_bottom booleans are true, both adjacent
! 	 * regions are unlocked, thus the entire flash can be unlocked.
! 	 */
! 	if (can_be_top && can_be_bottom)
! 		lock_len = 0;
! 	else if (use_top)
  		lock_len = mtd->size - (ofs + len);
  	else
  		lock_len = ofs;
```

```console
shell$ rm drivers/mtd/spi-nor/spansion.c.orig
shell$ rm drivers/mtd/spi-nor/swp.c.orig
shell$ rm drivers/mtd/spi-nor/swp.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 228_drivers-mtd.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/228_drivers-mtd.patch
```

###### 247_drivers-spi.patch

####### drivers/spi/spi-xilinx.c

```console
shell$ diff -p linux-6.12.95/drivers/spi/spi-xilinx.c linux-6.12.100/drivers/spi/spi-xilinx.c
*** linux-6.12.95/drivers/spi/spi-xilinx.c	2026-07-11 11:11:43.494936064 +0900
--- linux-6.12.100/drivers/spi/spi-xilinx.c	2026-08-05 10:45:16.610910123 +0900
*************** static int xilinx_spi_find_buffer_size(s
*** 370,380 ****
  		xspi->regs + XIPIF_V123B_RESETR_OFFSET);
  
  	/* Fill the Tx FIFO with as many words as possible */
! 	do {
  		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
  		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
  		n_words++;
! 	} while (!(sr & XSPI_SR_TX_FULL_MASK));
  
  	return n_words;
  }
--- 370,387 ----
  		xspi->regs + XIPIF_V123B_RESETR_OFFSET);
  
  	/* Fill the Tx FIFO with as many words as possible */
! 	while (1) {
  		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
  		sr = xspi->read_fn(xspi->regs + XSPI_SR_OFFSET);
+ 		if (sr & XSPI_SR_TX_FULL_MASK)
+ 			break;
+ 
  		n_words++;
! 	}
! 
! 	/* Handle the NO FIFO case separately */
! 	if (!n_words)
! 		return 1;
  
  	return n_words;
  }
```

####### Make 247_drivers-spi.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
Hunk #7 FAILED at 352.
Hunk #8 succeeded at 590 (offset 7 lines).
1 out of 8 hunks FAILED -- saving rejects to file drivers/spi/spi-xilinx.c.rej
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
```

```console
shell$ cp ../linux-6.12.95-xlnx-v2025.1/drivers/spi/spi-xilinx.c drivers/spi/spi-xilinx.c
shell$ rm drivers/spi/spi-xilinx.c.orig
shell$ rm drivers/spi/spi-xilinx.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 247_drivers-spi.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/247_drivers-spi.patch
```

###### 262_drivers-usb-dwc3.patch

####### drivers/usb/dwc3/gadget.c

```console
shell$ diff -p linux-6.12.95/drivers/usb/dwc3/gadget.c linux-6.12.100/drivers/usb/dwc3/gadget.c
*** linux-6.12.95/drivers/usb/dwc3/gadget.c	2026-07-11 11:11:43.602922730 +0900
--- linux-6.12.100/drivers/usb/dwc3/gadget.c	2026-08-05 10:45:16.724398683 +0900
*************** static void dwc3_endpoint_interrupt(stru
*** 3902,3916 ****
  	}
  }
  
  static void dwc3_disconnect_gadget(struct dwc3 *dwc)
  {
! 	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
  		spin_unlock(&dwc->lock);
! 		dwc->gadget_driver->disconnect(dwc->gadget);
  		spin_lock(&dwc->lock);
  	}
  }
  
  static void dwc3_suspend_gadget(struct dwc3 *dwc)
  {
  	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
--- 3902,3949 ----
  	}
  }
  
+ static bool dwc3_prepare_disconnect_gadget(struct dwc3 *dwc,
+ 					   struct usb_gadget_driver **driver,
+ 					   struct usb_gadget **gadget)
+ {
+ 	if (!dwc->async_callbacks || !dwc->gadget_driver ||
+ 	    !dwc->gadget_driver->disconnect)
+ 		return false;
+ 
+ 	*driver = dwc->gadget_driver;
+ 	*gadget = dwc->gadget;
+ 
+ 	return true;
+ }
+ 
  static void dwc3_disconnect_gadget(struct dwc3 *dwc)
  {
! 	struct usb_gadget_driver *driver;
! 	struct usb_gadget *gadget;
! 
! 	if (dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
  		spin_unlock(&dwc->lock);
! 		driver->disconnect(gadget);
  		spin_lock(&dwc->lock);
  	}
  }
  
+ static void dwc3_disconnect_gadget_sleepable(struct dwc3 *dwc)
+ {
+ 	struct usb_gadget_driver *driver;
+ 	struct usb_gadget *gadget;
+ 	unsigned long flags;
+ 
+ 	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (!dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return;
+ 	}
+ 
+ 	spin_unlock_irqrestore(&dwc->lock, flags);
+ 	driver->disconnect(gadget);
+ }
+ 
  static void dwc3_suspend_gadget(struct dwc3 *dwc)
  {
  	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
*************** void dwc3_gadget_exit(struct dwc3 *dwc)
*** 4804,4810 ****
  
  int dwc3_gadget_suspend(struct dwc3 *dwc)
  {
- 	unsigned long flags;
  	int ret;
  
  	ret = dwc3_gadget_soft_disconnect(dwc);
--- 4837,4842 ----
*************** int dwc3_gadget_suspend(struct dwc3 *dwc
*** 4818,4827 ****
  		return -EAGAIN;
  	}
  
! 	spin_lock_irqsave(&dwc->lock, flags);
! 	if (dwc->gadget_driver)
! 		dwc3_disconnect_gadget(dwc);
! 	spin_unlock_irqrestore(&dwc->lock, flags);
  
  	return 0;
  }
--- 4850,4856 ----
  		return -EAGAIN;
  	}
  
! 	dwc3_disconnect_gadget_sleepable(dwc);
  
  	return 0;
  }
```


####### Make 262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout v6.12.100
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1-2
  :
patch -p1 < ../patches/linux-6.12.95-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
Hunk #28 succeeded at 4063 (offset 33 lines).
Hunk #29 succeeded at 4157 (offset 33 lines).
Hunk #30 succeeded at 4228 (offset 33 lines).
Hunk #31 succeeded at 4282 (offset 33 lines).
Hunk #32 succeeded at 4408 (offset 33 lines).
Hunk #33 succeeded at 4447 (offset 33 lines).
Hunk #34 succeeded at 4460 (offset 33 lines).
Hunk #35 succeeded at 4603 (offset 33 lines).
Hunk #36 succeeded at 4646 (offset 33 lines).
Hunk #37 succeeded at 4688 (offset 33 lines).
Hunk #38 succeeded at 4713 (offset 33 lines).
Hunk #39 succeeded at 4726 (offset 33 lines).
Hunk #40 succeeded at 4783 (offset 33 lines).
Hunk #41 succeeded at 4835 (offset 33 lines).
Hunk #42 succeeded at 4854 (offset 33 lines).
Hunk #43 succeeded at 4897 (offset 33 lines).
Hunk #44 succeeded at 4990 (offset 33 lines).
Hunk #45 succeeded at 5081 (offset 29 lines).
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```

```console
shell$ rm drivers/usb/dwc3/gadget.c.orig
shell$ git add --all
shell$ git commit -m "[patch] 262_drivers-usb-dwc3.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.100-xlnx-v2025.1/262_drivers-usb-dwc3.patch
```


