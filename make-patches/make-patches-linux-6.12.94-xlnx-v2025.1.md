Make ./paches/linux-6.12.94-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.92

```console
shell$ git clone --depth 1 -b v6.12.92 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.92
```

### Get linux-6.12.92-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.92 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.92-xlnx-v2025.1
shell$ cd linux-6.12.92-xlnx-v2025.1
shell$ git checkout -b linux-6.12.92-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.92-xlnx-v2025.1/origin_patch.sh
shell$ cd ..
```

### Get linux-6.12.94

```console
shell$ git clone --depth 1 -b v6.12.94 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.94
```

### Make diff-linux-6.12.92-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.92-xlnx-v2025.1 -A linux-6.12.92 -B linux-6.12.92-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.92-xlnx-v2025.1.txt linux-6.12.92 linux-6.12.92-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.92-xlnx-v2025.1
## A   : {name: linux-6.12.92, path: linux-6.12.92}
## B   : {name: linux-6.12.92-xlnx-v2025.1, path: linux-6.12.92-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.92-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.92-6.12.94.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.92-6.12.94 -A linux-6.12.92 -B linux-6.12.94 -o ./make-patches/diff-linux-6.12.92-6.12.94.txt linux-6.12.92 linux-6.12.94 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.92-6.12.94
## A   : {name: linux-6.12.92, path: linux-6.12.92}
## B   : {name: linux-6.12.94, path: linux-6.12.94}
## OUT : ./make-patches/diff-linux-6.12.92-6.12.94.txt
```

### Compare diff-linux-6.12.92-6.12.94.txt and diff-linux-6.12.92-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.92-6.12.94.txt make-patches/diff-linux-6.12.92-xlnx-v2025.1.txt
contents: 
 - U: drivers/iio/adc/xilinx-xadc-core.c
 - U: drivers/spi/spi-cadence-quadspi.c
 - U: drivers/usb/dwc3/dwc3-xilinx.c
 - U: include/drm/display/drm_dp.h
```

### Make linux-6.12.94-xlnx-v2025.1

#### make patches/linux-6.12.94-xlnx-v2025.1

#### make patches/linux-6.12.94-xlnx-v2025.1/xxx_update.sh

```sh:patches/linux-6.12.94-xlnx-v2025.1/xxx_update.sh
PATCH_DIR=$(cd $(dirname $0); pwd)
BASE_PATCH_DIR="$PATCH_DIR/../linux-6.12.92-xlnx-v2025.1"
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

#### make linux-6.12.94-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.94 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.94-xlnx-v2025.1
shell$ cd linux-6.12.94-xlnx-v2025.1
shell$ git checkout -b linux-6.12.94-xlnx-v2025.1-1
```

#### run patches/linux-6.12.94-xlnx-v2025.1/xxx_update.sh

```console
shell$ sh ../patches/linux-6.12.94-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/002_include.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/002_include.patch
patching file include/linux/regmap.h
git add --all
git commit -m '[patch] 002_include.patch'
[linux-6.12.94-xlnx-v2025.1-1 af7ca179c] [patch] 002_include.patch
 1 file changed, 16 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/002_include.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patching file arch/arm/mach-zynq/Makefile
patching file arch/arm/mach-zynq/common.c
patching file arch/arm/mach-zynq/common.h
patching file arch/arm/mach-zynq/efuse.c
patching file arch/arm/mach-zynq/platsmp.c
git add --all
git commit -m '[patch] 010_arch-arm-mach-zynq.patch'
[linux-6.12.94-xlnx-v2025.1-1 d2142e912] [patch] 010_arch-arm-mach-zynq.patch
 5 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-zynq/efuse.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/011_arch-arm-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/011_arch-arm-configs.patch
patching file arch/arm/configs/xilinx_zynq_defconfig
git add --all
git commit -m '[patch] 011_arch-arm-configs.patch'
[linux-6.12.94-xlnx-v2025.1-1 329b2a63a] [patch] 011_arch-arm-configs.patch
 1 file changed, 222 insertions(+)
 create mode 100644 arch/arm/configs/xilinx_zynq_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/012_arch-arm-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/012_arch-arm-boot-dts.patch
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
[linux-6.12.94-xlnx-v2025.1-1 8cf29c719] [patch] 012_arch-arm-boot-dts.patch
 13 files changed, 421 insertions(+), 69 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/020_arch-arm64.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/020_arch-arm64.patch
patching file Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
patching file arch/arm64/kernel/irq.c
git add --all
git commit -m '[patch] 020_arch-arm64.patch'
[linux-6.12.94-xlnx-v2025.1-1 4cdf06a81] [patch] 020_arch-arm64.patch
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/021_arch-arm64-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/021_arch-arm64-configs.patch
patching file arch/arm64/configs/defconfig
patching file arch/arm64/configs/xilinx_defconfig
git add --all
git commit -m '[patch] 021_arch-arm64-configs.patch'
[linux-6.12.94-xlnx-v2025.1-1 ab4e5ed81] [patch] 021_arch-arm64-configs.patch
 2 files changed, 670 insertions(+)
 create mode 100644 arch/arm64/configs/xilinx_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
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
[linux-6.12.94-xlnx-v2025.1-1 cc44a1aeb] [patch] 022_arch-arm64-boot-dts.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/030_arch-microblaze.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/030_arch-microblaze.patch
patching file arch/microblaze/configs/mmu_defconfig
patching file arch/microblaze/include/asm/sections.h
patching file arch/microblaze/kernel/head.S
patching file arch/microblaze/kernel/setup.c
patching file arch/microblaze/kernel/vmlinux.lds.S
patching file arch/microblaze/mm/init.c
git add --all
git commit -m '[patch] 030_arch-microblaze.patch'
[linux-6.12.94-xlnx-v2025.1-1 f21c87214] [patch] 030_arch-microblaze.patch
 6 files changed, 22 insertions(+), 11 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/100_kernel-irq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/100_kernel-irq.patch
patching file kernel/irq/handle.c
git add --all
git commit -m '[patch] 100_kernel-irq.patch'
[linux-6.12.94-xlnx-v2025.1-1 31350593b] [patch] 100_kernel-irq.patch
 1 file changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/101_net-ipv4.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/101_net-ipv4.patch
patching file net/ipv4/af_inet.c
git add --all
git commit -m '[patch] 101_net-ipv4.patch'
[linux-6.12.94-xlnx-v2025.1-1 55a38b7a6] [patch] 101_net-ipv4.patch
 1 file changed, 6 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/102_crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/102_crypto.patch
patching file crypto/ecdsa.c
git add --all
git commit -m '[patch] 102_crypto.patch'
[linux-6.12.94-xlnx-v2025.1-1 a961f9b8d] [patch] 102_crypto.patch
 1 file changed, 4 insertions(+), 8 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/202_drivers-clk.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/202_drivers-clk.patch
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
[linux-6.12.94-xlnx-v2025.1-1 29ef20f97] [patch] 202_drivers-clk.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/203_drivers-clocksource.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/203_drivers-clocksource.patch
patching file drivers/clocksource/timer-cadence-ttc.c
git add --all
git commit -m '[patch] 203_drivers-clocksource.patch'
[linux-6.12.94-xlnx-v2025.1-1 f4f172379] [patch] 203_drivers-clocksource.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/204_drivers-crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/204_drivers-crypto.patch
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
[linux-6.12.94-xlnx-v2025.1-1 140d0fc66] [patch] 204_drivers-crypto.patch
 10 files changed, 2385 insertions(+), 258 deletions(-)
 create mode 100644 drivers/crypto/xilinx/xilinx-ecdsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx_ecdsasig.asn1
 create mode 100644 drivers/crypto/xilinx/zynqmp-rsa.c
 create mode 100644 include/crypto/ecdsa.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/205_drivers-dma.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/205_drivers-dma.patch
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
[linux-6.12.94-xlnx-v2025.1-1 34720cfb4] [patch] 205_drivers-dma.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/206_drivers-edac.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/206_drivers-edac.patch
patching file Documentation/ABI/testing/sysfs-driver-xilsem-edac
patching file Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
patching file drivers/edac/Kconfig
patching file drivers/edac/Makefile
patching file drivers/edac/versal_edac.c
patching file drivers/edac/xilinx_xilsem_edac.c
git add --all
git commit -m '[patch] 206_drivers-edac.patch'
[linux-6.12.94-xlnx-v2025.1-1 282617281] [patch] 206_drivers-edac.patch
 6 files changed, 1671 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/207_drivers-firmware.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/207_drivers-firmware.patch
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
[linux-6.12.94-xlnx-v2025.1-1 a5346ae6b] [patch] 207_drivers-firmware.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/208_drivers-fpga.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/208_drivers-fpga.patch
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
[linux-6.12.94-xlnx-v2025.1-1 3187a4ba3] [patch] 208_drivers-fpga.patch
 14 files changed, 982 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml
 create mode 100644 drivers/fpga/xilinx-afi.c
 create mode 100644 drivers/fpga/zynq-afi.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/210_drivers-gpu-drm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/210_drivers-gpu-drm.patch
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
Hunk #1 succeeded at 1159 (offset 1 line).
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
[linux-6.12.94-xlnx-v2025.1-1 e447ee64f] [patch] 210_drivers-gpu-drm.patch
 85 files changed, 34466 insertions(+), 168 deletions(-)
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
 create mode 100644 include/drm/display/drm_dp.h.orig
 create mode 100644 include/dt-bindings/drm/mipi-dsi.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/211_drivers-hwmon.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
patching file Documentation/hwmon/ina2xx.rst
patching file drivers/hwmon/Kconfig
patching file drivers/hwmon/ina2xx.c
git add --all
git commit -m '[patch] 211_drivers-hwmon.patch'
[linux-6.12.94-xlnx-v2025.1-1 a74eb8c09] [patch] 211_drivers-hwmon.patch
 4 files changed, 79 insertions(+), 18 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/212_drivers-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/212_drivers-i2c.patch
patching file drivers/i2c/busses/i2c-cadence.c
patching file drivers/i2c/busses/i2c-xiic.c
patching file drivers/i2c/i2c-atr.c
patching file include/linux/i2c-atr.h
git add --all
git commit -m '[patch] 212_drivers-i2c.patch'
[linux-6.12.94-xlnx-v2025.1-1 90be07b54] [patch] 212_drivers-i2c.patch
 4 files changed, 990 insertions(+), 357 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/213_drivers-i3c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/213_drivers-i3c.patch
patching file Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
git add --all
git commit -m '[patch] 213_drivers-i3c.patch'
[linux-6.12.94-xlnx-v2025.1-1 b391bbd95] [patch] 213_drivers-i3c.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/214_drivers-iio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
patching file drivers/iio/adc/Makefile
patching file drivers/iio/adc/ina260-adc.c
patching file drivers/iio/adc/versal-sysmon-core.c
patching file drivers/iio/adc/versal-sysmon-i2c.c
patching file drivers/iio/adc/versal-sysmon.c
patching file drivers/iio/adc/versal-sysmon.h
patching file drivers/iio/adc/xilinx-ams.c
patching file drivers/iio/adc/xilinx-xadc-core.c
patching file include/linux/iio/adc/versal-sysmon-events.h
git add --all
git commit -m '[patch] 214_drivers-iio.patch'
[linux-6.12.94-xlnx-v2025.1-1 d17016f05] [patch] 214_drivers-iio.patch
 11 files changed, 3051 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/ina260-adc.c
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/216_drivers-irqchip.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/216_drivers-irqchip.patch
patching file Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
patching file drivers/irqchip/Kconfig
patching file drivers/irqchip/irq-xilinx-intc.c
patching file drivers/irqchip/irqchip.c
patching file include/linux/irq.h
patching file include/linux/irqchip.h
patching file include/linux/of_irq.h
git add --all
git commit -m '[patch] 216_drivers-irqchip.patch'
[linux-6.12.94-xlnx-v2025.1-1 1b9d9cfee] [patch] 216_drivers-irqchip.patch
 7 files changed, 286 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/217_drivers-mailbox.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/217_drivers-mailbox.patch
patching file Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
patching file drivers/mailbox/zynqmp-ipi-mailbox.c
git add --all
git commit -m '[patch] 217_drivers-mailbox.patch'
[linux-6.12.94-xlnx-v2025.1-1 5ef330e32] [patch] 217_drivers-mailbox.patch
 2 files changed, 6 insertions(+), 2 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/217_drivers-mailbox.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/218_drivers-media-common.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/218_drivers-media-common.patch
patching file drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
git add --all
git commit -m '[patch] 218_drivers-media-common.patch'
[linux-6.12.94-xlnx-v2025.1-1 f3486b7f3] [patch] 218_drivers-media-common.patch
 1 file changed, 10 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/219_drivers-media-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/219_drivers-media-i2c.patch
patching file Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
patching file drivers/media/i2c/Kconfig
patching file drivers/media/i2c/Makefile
patching file drivers/media/i2c/ap1302.c
patching file drivers/media/i2c/ds90ub913.c
patching file drivers/media/i2c/ds90ub953.c
patching file drivers/media/i2c/ds90ub960.c
git add --all
git commit -m '[patch] 219_drivers-media-i2c.patch'
[linux-6.12.94-xlnx-v2025.1-1 ec6312bb5] [patch] 219_drivers-media-i2c.patch
 7 files changed, 3246 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
 create mode 100644 drivers/media/i2c/ap1302.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/220_drivers-media-mc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/220_drivers-media-mc.patch
patching file drivers/media/mc/mc-entity.c
git add --all
git commit -m '[patch] 220_drivers-media-mc.patch'
[linux-6.12.94-xlnx-v2025.1-1 d60605f94] [patch] 220_drivers-media-mc.patch
 1 file changed, 29 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/221_drivers-media-platform.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/221_drivers-media-platform.patch
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
[linux-6.12.94-xlnx-v2025.1-1 63333de3b] [patch] 221_drivers-media-platform.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patching file drivers/media/test-drivers/vivid/vivid-vid-common.c
git add --all
git commit -m '[patch] 222_drivers-media-test-drivers.patch'
[linux-6.12.94-xlnx-v2025.1-1 c78caf642] [patch] 222_drivers-media-test-drivers.patch
 1 file changed, 8 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/224_drivers-media-v4l2.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/224_drivers-media-v4l2.patch
patching file Documentation/userspace-api/media/v4l/biblio.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-defs.rst
patching file Documentation/userspace-api/media/v4l/colorspaces-details.rst
patching file Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
patching file Documentation/userspace-api/media/v4l/subdev-formats.rst
patching file Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst
patching file Documentation/userspace-api/media/videodev2.h.rst.exceptions
patching file drivers/media/v4l2-core/v4l2-common.c
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
[linux-6.12.94-xlnx-v2025.1-1 69e1c29ed] [patch] 224_drivers-media-v4l2.patch
 21 files changed, 1592 insertions(+), 125 deletions(-)
 create mode 100644 include/media/hdr-ctrls.h
 create mode 100644 include/uapi/linux/xilinx-dprxss.h
 create mode 100644 include/uapi/linux/xilinx-hdmirxss.h
 create mode 100644 include/uapi/linux/xilinx-hls.h
 create mode 100644 include/uapi/linux/xilinx-sdirxss.h
 create mode 100644 include/uapi/linux/xilinx-v4l2-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/225_drivers-mfd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
git add --all
git commit -m '[patch] 225_drivers-mfd.patch'
[linux-6.12.94-xlnx-v2025.1-1 2294732fb] [patch] 225_drivers-mfd.patch
 7 files changed, 470 insertions(+), 291 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/226_drivers-misc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/226_drivers-misc.patch
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
[linux-6.12.94-xlnx-v2025.1-1 2b663d4e3] [patch] 226_drivers-misc.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/228_drivers-mtd.patch
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
patching file drivers/mtd/spi-nor/sst.c
patching file drivers/mtd/spi-nor/swp.c
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
git add --all
git commit -m '[patch] 228_drivers-mtd.patch'
[linux-6.12.94-xlnx-v2025.1-1 f55eaab02] [patch] 228_drivers-mtd.patch
 17 files changed, 2310 insertions(+), 364 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/228_drivers-mtd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/230_drivers-net-ethernet.patch
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
[linux-6.12.94-xlnx-v2025.1-1 2107e22ef] [patch] 230_drivers-net-ethernet.patch
 14 files changed, 7153 insertions(+), 865 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/231_drivers-net-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/231_drivers-net-phy.patch
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
[linux-6.12.94-xlnx-v2025.1-1 7fde0abc9] [patch] 231_drivers-net-phy.patch
 8 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx-phy.txt
 create mode 100644 drivers/net/phy/xilinx_phy.c
 create mode 100644 include/linux/xilinx_phy.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/234_drivers-nvmem.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/234_drivers-nvmem.patch
patching file Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
patching file drivers/nvmem/Kconfig
patching file drivers/nvmem/Makefile
patching file drivers/nvmem/xlnx_secure_config.c
git add --all
git commit -m '[patch] 234_drivers-nvmem.patch'
[linux-6.12.94-xlnx-v2025.1-1 be4d182bd] [patch] 234_drivers-nvmem.patch
 4 files changed, 1300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
 create mode 100644 drivers/nvmem/xlnx_secure_config.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/235_drivers-of.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/235_drivers-of.patch
patching file Documentation/devicetree/configfs-overlays.txt
patching file drivers/of/Kconfig
patching file drivers/of/Makefile
patching file drivers/of/configfs.c
patching file drivers/of/overlay.c
git add --all
git commit -m '[patch] 235_drivers-of.patch'
[linux-6.12.94-xlnx-v2025.1-1 fd27ee7b4] [patch] 235_drivers-of.patch
 5 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/configfs-overlays.txt
 create mode 100644 drivers/of/configfs.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/236_drivers-pci.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/236_drivers-pci.patch
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
[linux-6.12.94-xlnx-v2025.1-1 a2d6dc948] [patch] 236_drivers-pci.patch
 9 files changed, 827 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/237_drivers-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/237_drivers-phy.patch
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
[linux-6.12.94-xlnx-v2025.1-1 3757e3962] [patch] 237_drivers-phy.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/238_drivers-pinctrl.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/238_drivers-pinctrl.patch
patching file Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
patching file drivers/pinctrl/pinctrl-zynqmp.c
git add --all
git commit -m '[patch] 238_drivers-pinctrl.patch'
[linux-6.12.94-xlnx-v2025.1-1 d2bd68022] [patch] 238_drivers-pinctrl.patch
 2 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/240_drivers-ptp.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/240_drivers-ptp.patch
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
[linux-6.12.94-xlnx-v2025.1-1 3bef71bd9] [patch] 240_drivers-ptp.patch
 8 files changed, 715 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml
 create mode 100644 drivers/ptp/ptp_xilinx.c
 create mode 100644 include/linux/ptp/ptp_xilinx.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/241_drivers-pwm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/241_drivers-pwm.patch
patching file drivers/pwm/Kconfig
patching file drivers/pwm/Makefile
patching file drivers/pwm/pwm-cadence.c
git add --all
git commit -m '[patch] 241_drivers-pwm.patch'
[linux-6.12.94-xlnx-v2025.1-1 d6e1a741c] [patch] 241_drivers-pwm.patch
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/242_drivers-remoteproc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/242_drivers-remoteproc.patch
patching file drivers/remoteproc/xlnx_r5_remoteproc.c
git add --all
git commit -m '[patch] 242_drivers-remoteproc.patch'
[linux-6.12.94-xlnx-v2025.1-1 ae9a38b47] [patch] 242_drivers-remoteproc.patch
 1 file changed, 30 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/243_drivers-reset.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/243_drivers-reset.patch
patching file Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
git add --all
git commit -m '[patch] 243_drivers-reset.patch'
[linux-6.12.94-xlnx-v2025.1-1 f68fd1f4f] [patch] 243_drivers-reset.patch
 1 file changed, 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/243_drivers-reset.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patching file Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
patching file drivers/soc/xilinx/xlnx_event_manager.c
patching file drivers/soc/xilinx/zynqmp_power.c
git add --all
git commit -m '[patch] 246_drivers-soc-xilinx.patch'
[linux-6.12.94-xlnx-v2025.1-1 8c816fee3] [patch] 246_drivers-soc-xilinx.patch
 4 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
Hunk #34 succeeded at 2486 (offset 1 line).
Hunk #35 succeeded at 2540 (offset 1 line).
Hunk #36 succeeded at 2591 (offset 1 line).
Hunk #37 succeeded at 2659 (offset 1 line).
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
git add --all
git commit -m '[patch] 247_drivers-spi.patch'
[linux-6.12.94-xlnx-v2025.1-1 09407f7ad] [patch] 247_drivers-spi.patch
 14 files changed, 3685 insertions(+), 384 deletions(-)
 create mode 100644 drivers/spi/spi-cadence-quadspi.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/247_drivers-spi.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/248_drivers-staging.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/248_drivers-staging.patch
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
[linux-6.12.94-xlnx-v2025.1-1 9cfba439a] [patch] 248_drivers-staging.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/249_drivers-thermal.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/249_drivers-thermal.patch
patching file Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
patching file drivers/thermal/Kconfig
patching file drivers/thermal/Makefile
patching file drivers/thermal/versal_thermal.c
git add --all
git commit -m '[patch] 249_drivers-thermal.patch'
[linux-6.12.94-xlnx-v2025.1-1 59729510a] [patch] 249_drivers-thermal.patch
 4 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
 create mode 100644 drivers/thermal/versal_thermal.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/250_drivers-tty.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/250_drivers-tty.patch
patching file Documentation/devicetree/bindings/serial/pl011.yaml
patching file Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
git add --all
git commit -m '[patch] 250_drivers-tty.patch'
[linux-6.12.94-xlnx-v2025.1-1 5368b0bee] [patch] 250_drivers-tty.patch
 2 files changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/251_drivers-ufs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/251_drivers-ufs.patch
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
[linux-6.12.94-xlnx-v2025.1-1 a8c42e306] [patch] 251_drivers-ufs.patch
 11 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
 create mode 100644 drivers/ufs/host/ufs-amd-versal2.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/252_drivers-uio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/252_drivers-uio.patch
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
[linux-6.12.94-xlnx-v2025.1-1 303ca8c7a] [patch] 252_drivers-uio.patch
 9 files changed, 1167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xilinx-apm.yaml
 rename drivers/uio/{uio.c => uio_core.c} (96%)
 create mode 100644 drivers/uio/uio_dmabuf.c
 create mode 100644 drivers/uio/uio_dmabuf.h
 create mode 100644 drivers/uio/uio_xilinx_ai_engine.c
 create mode 100644 drivers/uio/uio_xilinx_apm.c
 create mode 100644 include/uapi/linux/uio/uio.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/260_drivers-usb-core.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/260_drivers-usb-core.patch
patching file Documentation/devicetree/bindings/usb/usb-xhci.yaml
git add --all
git commit -m '[patch] 260_drivers-usb-core.patch'
[linux-6.12.94-xlnx-v2025.1-1 88c458ab5] [patch] 260_drivers-usb-core.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patching file drivers/usb/chipidea/ci_hdrc_usb2.c
git add --all
git commit -m '[patch] 261_drivers-usb-chipidea.patch'
[linux-6.12.94-xlnx-v2025.1-1 0d5d0982b] [patch] 261_drivers-usb-chipidea.patch
 1 file changed, 10 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
Hunk #9 FAILED at 595.
Hunk #10 succeeded at 655 (offset 2 lines).
Hunk #11 succeeded at 744 (offset 2 lines).
Hunk #12 succeeded at 785 (offset 2 lines).
Hunk #13 succeeded at 827 (offset 2 lines).
Hunk #14 succeeded at 847 (offset 2 lines).
1 out of 14 hunks FAILED -- saving rejects to file drivers/usb/dwc3/dwc3-xilinx.c.rej
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
git add --all
git commit -m '[patch] 262_drivers-usb-dwc3.patch'
[linux-6.12.94-xlnx-v2025.1-1 49933839b] [patch] 262_drivers-usb-dwc3.patch
 18 files changed, 4854 insertions(+), 107 deletions(-)
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c.orig
 create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c.rej
 create mode 100644 drivers/usb/dwc3/gadget_hibernation.c
 create mode 100644 drivers/usb/dwc3/otg.c
 create mode 100644 drivers/usb/dwc3/otg.h
 create mode 100644 drivers/usb/dwc3/platform_data.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/262_drivers-usb-dwc3.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/263_drivers-usb-gadget.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/263_drivers-usb-gadget.patch
patching file drivers/usb/gadget/function/f_tcm.c
git add --all
git commit -m '[patch] 263_drivers-usb-gadget.patch'
[linux-6.12.94-xlnx-v2025.1-1 3fe5fe4ab] [patch] 263_drivers-usb-gadget.patch
 1 file changed, 28 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
git add --all
git commit -m '[patch] 264_drivers-usb-host.patch'
[linux-6.12.94-xlnx-v2025.1-1 d06758f64] [patch] 264_drivers-usb-host.patch
 4 files changed, 92 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/266_drivers-usb-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/266_drivers-usb-phy.patch
patching file Documentation/devicetree/bindings/usb/ulpi-phy.yaml
patching file drivers/usb/phy/Kconfig
patching file drivers/usb/phy/phy-ulpi.c
git add --all
git commit -m '[patch] 266_drivers-usb-phy.patch'
[linux-6.12.94-xlnx-v2025.1-1 dc7bb11a1] [patch] 266_drivers-usb-phy.patch
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/271_drivers-video.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/271_drivers-video.patch
patching file drivers/video/hdmi.c
git add --all
git commit -m '[patch] 271_drivers-video.patch'
[linux-6.12.94-xlnx-v2025.1-1 401a30c47] [patch] 271_drivers-video.patch
 1 file changed, 4 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/272_drivers-virtio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/272_drivers-virtio.patch
patching file drivers/virtio/virtio_ring.c
git add --all
git commit -m '[patch] 272_drivers-virtio.patch'
[linux-6.12.94-xlnx-v2025.1-1 b6436481c] [patch] 272_drivers-virtio.patch
 1 file changed, 1 insertion(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/273_drivers-w1.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/273_drivers-w1.patch
patching file Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
git add --all
git commit -m '[patch] 273_drivers-w1.patch'
[linux-6.12.94-xlnx-v2025.1-1 988333216] [patch] 273_drivers-w1.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/275_drivers-xen.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/275_drivers-xen.patch
patching file drivers/xen/Kconfig
patching file drivers/xen/Makefile
patching file drivers/xen/pvcalls.c
patching file include/xen/pvcalls.h
patching file include/xen/xen.h
git add --all
git commit -m '[patch] 275_drivers-xen.patch'
[linux-6.12.94-xlnx-v2025.1-1 a4f91d489] [patch] 275_drivers-xen.patch
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xen/pvcalls.c
 create mode 100644 include/xen/pvcalls.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/301_sound-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/301_sound-soc-xilinx.patch
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
[linux-6.12.94-xlnx-v2025.1-1 9023af79a] [patch] 301_sound-soc-xilinx.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/999_other-document.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/../linux-6.12.92-xlnx-v2025.1/999_other-document.patch
patching file MAINTAINERS
git add --all
git commit -m '[patch] 999_other-document.patch'
[linux-6.12.94-xlnx-v2025.1-1 61a019d58] [patch] 999_other-document.patch
 1 file changed, 435 insertions(+), 3 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.94-xlnx-v2025.1/999_other-document.patch
```

###### 210_drivers-gpu-drm.patch

####### include/drm/display/drm_dp.h

```console
shell$ diff -p linux-6.12.92/include/drm/display/drm_dp.h linux-6.12.94/include/drm/display/drm_dp.h
*** linux-6.12.92/include/drm/display/drm_dp.h	2026-07-09 05:15:42.423899711 +0900
--- linux-6.12.94/include/drm/display/drm_dp.h	2026-07-09 11:24:04.147389390 +0900
***************
*** 997,1002 ****
--- 997,1003 ----
  # define DP_EDP_14			    0x03
  # define DP_EDP_14a                         0x04    /* eDP 1.4a */
  # define DP_EDP_14b                         0x05    /* eDP 1.4b */
+ # define DP_EDP_15			    0x06    /* eDP 1.5 */
  
  #define DP_EDP_GENERAL_CAP_1		    0x701
  # define DP_EDP_TCON_BACKLIGHT_ADJUSTMENT_CAP		(1 << 0)
```

####### Make 210_drivers-gpu-drm.patch

```console
shell$ cd linux-6.12.94-xlnx-v2025.1
shell$ git checkout v6.12.94
shell$ git checkout -b linux-6.12.94-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.92-xlnx-v2025.1/210_drivers-gpu-drm.patch
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
Hunk #1 succeeded at 1159 (offset 1 line).
patching file include/drm/display/drm_hdmi_helper.h
patching file include/drm/drm_connector.h
patching file include/drm/drm_edid.h
patching file include/drm/drm_fourcc.h
patching file include/drm/drm_mode_config.h
patching file include/dt-bindings/drm/mipi-dsi.h
patching file include/uapi/drm/drm_fourcc.h
patching file include/uapi/drm/drm_mode.h
```

```console
shell$ rm include/drm/display/drm_dp.h.orig
shell$ git add --all
shell$ git commit -m '[patch] 210_drivers-gpu-drm.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.94-xlnx-v2025.1/210_drivers-gpu-drm.patch
```

###### 214_drivers-iio.patch

####### drivers/iio/adc/xilinx-xadc-core.c

```console
shell$ diff -p linux-6.12.92/drivers/iio/adc/xilinx-xadc-core.c linux-6.12.94/drivers/iio/adc/xilinx-xadc-core.c
*** linux-6.12.92/drivers/iio/adc/xilinx-xadc-core.c	2026-07-09 05:15:40.943677754 +0900
--- linux-6.12.94/drivers/iio/adc/xilinx-xadc-core.c	2026-07-09 11:24:02.432191833 +0900
*************** static int xadc_postdisable(struct iio_d
*** 817,822 ****
--- 817,823 ----
  {
  	struct xadc *xadc = iio_priv(indio_dev);
  	unsigned long scan_mask;
+ 	int seq_mode;
  	int ret;
  	int i;
  
*************** static int xadc_postdisable(struct iio_d
*** 824,829 ****
--- 825,836 ----
  	for (i = 0; i < indio_dev->num_channels; i++)
  		scan_mask |= BIT(indio_dev->channels[i].scan_index);
  
+ 	/*
+ 	 * Use the correct sequencer mode for the idle state: simultaneous
+ 	 * mode for dual external mux configurations, continuous otherwise.
+ 	 */
+ 	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
+ 
  	/* Enable all channels and calibration */
  	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
  	if (ret)
*************** static int xadc_postdisable(struct iio_d
*** 834,844 ****
  		return ret;
  
  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
! 		XADC_CONF1_SEQ_CONTINUOUS);
  	if (ret)
  		return ret;
  
! 	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
  }
  
  static int xadc_preenable(struct iio_dev *indio_dev)
--- 841,851 ----
  		return ret;
  
  	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
! 				  seq_mode);
  	if (ret)
  		return ret;
  
! 	return xadc_power_adc_b(xadc, seq_mode);
  }
  
  static int xadc_preenable(struct iio_dev *indio_dev)
```

####### Make 214_drivers-iio.patch

```console
shell$ cd linux-6.12.94-xlnx-v2025.1
shell$ git checkout v6.12.94
shell$ git checkout -b linux-6.12.94-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.92-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
patching file drivers/iio/adc/Makefile
patching file drivers/iio/adc/ina260-adc.c
patching file drivers/iio/adc/versal-sysmon-core.c
patching file drivers/iio/adc/versal-sysmon-i2c.c
patching file drivers/iio/adc/versal-sysmon.c
patching file drivers/iio/adc/versal-sysmon.h
patching file drivers/iio/adc/xilinx-ams.c
patching file drivers/iio/adc/xilinx-xadc-core.c
patching file include/linux/iio/adc/versal-sysmon-events.h
```

```console
shell$ git add --all
shell$ git commit -m '[patch] 214_drivers-iio.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.94-xlnx-v2025.1/214_drivers-iio.patch
```

###### 247_drivers-spi.patch

####### drivers/spi/spi-cadence-quadspi.c

```console
shell$ diff -p linux-6.12.92/drivers/spi/spi-cadence-quadspi.c linux-6.12.94/drivers/spi/spi-cadence-quadspi.c
*** linux-6.12.92/drivers/spi/spi-cadence-quadspi.c	2026-07-09 05:15:42.080790583 +0900
--- linux-6.12.94/drivers/spi/spi-cadence-quadspi.c	2026-07-09 11:24:03.683939544 +0900
*************** static void cqspi_remove(struct platform
*** 2013,2025 ****
  		cqspi_wait_idle(cqspi);
  
  	spi_unregister_controller(cqspi->host);
- 	cqspi_controller_enable(cqspi, 0);
  
  	if (cqspi->rx_chan)
  		dma_release_channel(cqspi->rx_chan);
  
! 	if (pm_runtime_get_sync(&pdev->dev) >= 0)
  		clk_disable(cqspi->clk);
  
  	if (cqspi->is_jh7110)
  		cqspi_jh7110_disable_clk(pdev, cqspi);
--- 2013,2026 ----
  		cqspi_wait_idle(cqspi);
  
  	spi_unregister_controller(cqspi->host);
  
  	if (cqspi->rx_chan)
  		dma_release_channel(cqspi->rx_chan);
  
! 	if (pm_runtime_get_sync(&pdev->dev) >= 0) {
! 		cqspi_controller_enable(cqspi, 0);
  		clk_disable(cqspi->clk);
+ 	}
  
  	if (cqspi->is_jh7110)
  		cqspi_jh7110_disable_clk(pdev, cqspi);
```

####### Make 247_drivers-spi.patch


```console
shell$ cd linux-6.12.94-xlnx-v2025.1
shell$ git checkout v6.12.94
shell$ git checkout -b linux-6.12.94-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.92-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
Hunk #34 succeeded at 2486 (offset 1 line).
Hunk #35 succeeded at 2540 (offset 1 line).
Hunk #36 succeeded at 2591 (offset 1 line).
Hunk #37 succeeded at 2659 (offset 1 line).
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
```

```console
shell$ rm drivers/spi/spi-cadence-quadspi.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 247_drivers-spi.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.94-xlnx-v2025.1/247_drivers-spi.patch
```

###### 262_drivers-usb-dwc3.patch

####### drivers/usb/dwc3/dwc3-xilinx.c

```console
shell$ diff -p linux-6.12.92/drivers/usb/dwc3/dwc3-xilinx.c linux-6.12.94/drivers/usb/dwc3/dwc3-xilinx.c
*** linux-6.12.92/drivers/usb/dwc3/dwc3-xilinx.c	2026-07-09 05:15:42.196490174 +0900
--- linux-6.12.94/drivers/usb/dwc3/dwc3-xilinx.c	2026-07-09 11:24:03.809547446 +0900
*************** static int dwc3_xlnx_init_zynqmp(struct
*** 170,184 ****
  	}
  
  	ret = phy_init(priv_data->usb3_phy);
! 	if (ret < 0) {
! 		phy_exit(priv_data->usb3_phy);
  		goto err;
- 	}
  
  	ret = reset_control_deassert(apbrst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release APB reset\n");
! 		goto err;
  	}
  
  	/* Set PIPE Power Present signal in FPD Power Present Register*/
--- 170,182 ----
  	}
  
  	ret = phy_init(priv_data->usb3_phy);
! 	if (ret < 0)
  		goto err;
  
  	ret = reset_control_deassert(apbrst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release APB reset\n");
! 		goto err_phy_exit;
  	}
  
  	/* Set PIPE Power Present signal in FPD Power Present Register*/
*************** static int dwc3_xlnx_init_zynqmp(struct
*** 190,216 ****
  	ret = reset_control_deassert(crst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release core reset\n");
! 		goto err;
  	}
  
  	ret = reset_control_deassert(hibrst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release hibernation reset\n");
! 		goto err;
  	}
  
  	ret = phy_power_on(priv_data->usb3_phy);
! 	if (ret < 0) {
! 		phy_exit(priv_data->usb3_phy);
! 		goto err;
! 	}
  
  skip_usb3_phy:
  	/* ulpi reset via gpio-modepin or gpio-framework driver */
  	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
  	if (IS_ERR(reset_gpio)) {
! 		return dev_err_probe(dev, PTR_ERR(reset_gpio),
! 				     "Failed to request reset GPIO\n");
  	}
  
  	if (reset_gpio) {
--- 188,212 ----
  	ret = reset_control_deassert(crst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release core reset\n");
! 		goto err_phy_exit;
  	}
  
  	ret = reset_control_deassert(hibrst);
  	if (ret < 0) {
  		dev_err(dev, "Failed to release hibernation reset\n");
! 		goto err_phy_exit;
  	}
  
  	ret = phy_power_on(priv_data->usb3_phy);
! 	if (ret < 0)
! 		goto err_phy_exit;
  
  skip_usb3_phy:
  	/* ulpi reset via gpio-modepin or gpio-framework driver */
  	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
  	if (IS_ERR(reset_gpio)) {
! 		ret = PTR_ERR(reset_gpio);
! 		goto err_phy_power_off;
  	}
  
  	if (reset_gpio) {
*************** skip_usb3_phy:
*** 230,235 ****
--- 226,237 ----
  		writel(reg, priv_data->regs + XLNX_USB_TRAFFIC_ROUTE_CONFIG);
  	}
  
+ 	return 0;
+ 
+ err_phy_power_off:
+ 	phy_power_off(priv_data->usb3_phy);
+ err_phy_exit:
+ 	phy_exit(priv_data->usb3_phy);
  err:
  	return ret;
  }
```

####### Make 262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.94-xlnx-v2025.1
shell$ git checkout v6.12.94
shell$ git checkout -b linux-6.12.94-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.92-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
Hunk #9 FAILED at 595.
Hunk #10 succeeded at 655 (offset 2 lines).
Hunk #11 succeeded at 744 (offset 2 lines).
Hunk #12 succeeded at 785 (offset 2 lines).
Hunk #13 succeeded at 827 (offset 2 lines).
Hunk #14 succeeded at 847 (offset 2 lines).
1 out of 14 hunks FAILED -- saving rejects to file drivers/usb/dwc3/dwc3-xilinx.c.rej
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```

```console
shell$ rm drivers/usb/dwc3/dwc3-xilinx.c.orig
shell$ rm drivers/usb/dwc3/dwc3-xilinx.c.rej
shell$ cp ../linux-6.12.92-xlnx-v2025.1/drivers/usb/dwc3/dwc3-xilinx.c drivers/usb/dwc3/dwc3-xilinx.c
shell$ git add --all
shell$ git commit -m "[patch] 262_drivers-usb-dwc3.patch"
```

Update drivers/usb/dwc3/dwc3-xilinx.c

```console
shell$ git diff
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index ed1df80b5..3bd88e969 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -546,15 +546,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	/* Set PIPE Power Present signal in FPD Power Present Register*/
@@ -566,27 +564,26 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 skip_usb3_phy:
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+		ret = dev_err_probe(dev, PTR_ERR(reset_gpio),
 				     "Failed to request reset GPIO\n");
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -596,6 +593,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }
```


```console
shell$ git add --update
shell$ git commit -m "[update] 262_drivers-usb-dwc3.patch"
shell$ git diff HEAD^^ > ../patches/linux-6.12.94-xlnx-v2025.1/262_drivers-usb-dwc3.patch
```

