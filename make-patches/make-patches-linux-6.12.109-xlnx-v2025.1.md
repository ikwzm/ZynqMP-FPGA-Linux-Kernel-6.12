Make ./paches/linux-6.12.109-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.100

```console
shell$ git clone --depth 1 -b v6.12.100 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.100
```

### Get linux-6.12.100-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.100 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.100-xlnx-v2025.1
shell$ cd linux-6.12.100-xlnx-v2025.1
shell$ git checkout -b linux-6.12.100-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.100-xlnx-v2025.1/origin_patch.sh
shell$ cd ..
```

### Get linux-6.12.109

```console
shell$ git clone --depth 1 -b v6.12.109 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.109
```

### Make diff-linux-6.12.100-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.100-xlnx-v2025.1 -A linux-6.12.100 -B linux-6.12.100-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.100-xlnx-v2025.1.txt linux-6.12.100 linux-6.12.100-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.100-xlnx-v2025.1
## A   : {name: linux-6.12.100, path: linux-6.12.100}
## B   : {name: linux-6.12.100-xlnx-v2025.1, path: linux-6.12.100-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.100-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.100-6.12.109.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.100-6.12.109 -A linux-6.12.100 -B linux-6.12.109 -o ./make-patches/diff-linux-6.12.100-6.12.109.txt linux-6.12.100 linux-6.12.109 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.100-6.12.109
## A   : {name: linux-6.12.100, path: linux-6.12.100}
## B   : {name: linux-6.12.109, path: linux-6.12.109}
## OUT : ./make-patches/diff-linux-6.12.100-6.12.109.txt
```

### Compare diff-linux-6.12.100-6.12.109.txt and diff-linux-6.12.100-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.100-6.12.109.txt make-patches/diff-linux-6.12.100-xlnx-v2025.1.txt
contents: 
 - U: Documentation/hwmon/ina2xx.rst
 - U: MAINTAINERS
 - U: drivers/crypto/Kconfig
 - D: drivers/firmware/xilinx/zynqmp.c
 - U: drivers/gpu/drm/drm_connector.c
 - U: drivers/hwmon/Kconfig
 - U: drivers/hwmon/ina2xx.c
 - U: drivers/net/ethernet/cadence/macb_main.c
 - U: drivers/net/phy/phylink.c
 - U: drivers/remoteproc/xlnx_r5_remoteproc.c
 - U: drivers/ufs/core/ufshcd.c
 - U: drivers/usb/gadget/function/f_tcm.c
 - U: drivers/usb/host/xhci.c
 - U: drivers/usb/host/xhci.h
 - U: include/drm/drm_connector.h
 - U: include/linux/firmware/xlnx-zynqmp.h
 - U: sound/soc/xilinx/xlnx_formatter_pcm.c
```

### Make linux-6.12.109-xlnx-v2025.1

#### make patches/linux-6.12.109-xlnx-v2025.1

#### make patches/linux-6.12.109-xlnx-v2025.1/xxx_update.sh

```sh:patches/linux-6.12.100-xlnx-v2025.1/xxx_update.sh
PATCH_DIR=$(cd $(dirname $0); pwd)
BASE_PATCH_DIR="$PATCH_DIR/../linux-6.12.100-xlnx-v2025.1"
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

#### make linux-6.12.109-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.109 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.109-xlnx-v2025.1
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-1
```

#### run patches/linux-6.12.109-xlnx-v2025.1/xxx_update.sh

```console
shell$ sh ../patches/linux-6.12.109-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/002_include.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/002_include.patch
patching file include/linux/regmap.h
git add --all
git commit -m '[patch] 002_include.patch'
[linux-6.12.109-xlnx-v2025.1-1 3e4d0e40d] [patch] 002_include.patch
 1 file changed, 16 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/002_include.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patching file arch/arm/mach-zynq/Makefile
patching file arch/arm/mach-zynq/common.c
patching file arch/arm/mach-zynq/common.h
patching file arch/arm/mach-zynq/efuse.c
patching file arch/arm/mach-zynq/platsmp.c
git add --all
git commit -m '[patch] 010_arch-arm-mach-zynq.patch'
[linux-6.12.109-xlnx-v2025.1-1 d47cdbab8] [patch] 010_arch-arm-mach-zynq.patch
 5 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-zynq/efuse.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/011_arch-arm-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/011_arch-arm-configs.patch
patching file arch/arm/configs/xilinx_zynq_defconfig
git add --all
git commit -m '[patch] 011_arch-arm-configs.patch'
[linux-6.12.109-xlnx-v2025.1-1 0e862f651] [patch] 011_arch-arm-configs.patch
 1 file changed, 222 insertions(+)
 create mode 100644 arch/arm/configs/xilinx_zynq_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/012_arch-arm-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/012_arch-arm-boot-dts.patch
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
[linux-6.12.109-xlnx-v2025.1-1 30d324bdc] [patch] 012_arch-arm-boot-dts.patch
 13 files changed, 421 insertions(+), 69 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/020_arch-arm64.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/020_arch-arm64.patch
patching file Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
patching file arch/arm64/kernel/irq.c
git add --all
git commit -m '[patch] 020_arch-arm64.patch'
[linux-6.12.109-xlnx-v2025.1-1 cdf07f329] [patch] 020_arch-arm64.patch
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/021_arch-arm64-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/021_arch-arm64-configs.patch
patching file arch/arm64/configs/defconfig
patching file arch/arm64/configs/xilinx_defconfig
git add --all
git commit -m '[patch] 021_arch-arm64-configs.patch'
[linux-6.12.109-xlnx-v2025.1-1 58b6d56cb] [patch] 021_arch-arm64-configs.patch
 2 files changed, 670 insertions(+)
 create mode 100644 arch/arm64/configs/xilinx_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
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
[linux-6.12.109-xlnx-v2025.1-1 7f962c851] [patch] 022_arch-arm64-boot-dts.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/030_arch-microblaze.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/030_arch-microblaze.patch
patching file arch/microblaze/configs/mmu_defconfig
patching file arch/microblaze/include/asm/sections.h
patching file arch/microblaze/kernel/head.S
patching file arch/microblaze/kernel/setup.c
patching file arch/microblaze/kernel/vmlinux.lds.S
patching file arch/microblaze/mm/init.c
git add --all
git commit -m '[patch] 030_arch-microblaze.patch'
[linux-6.12.109-xlnx-v2025.1-1 9da84066b] [patch] 030_arch-microblaze.patch
 6 files changed, 22 insertions(+), 11 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/100_kernel-irq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/100_kernel-irq.patch
patching file kernel/irq/handle.c
git add --all
git commit -m '[patch] 100_kernel-irq.patch'
[linux-6.12.109-xlnx-v2025.1-1 21e4b2088] [patch] 100_kernel-irq.patch
 1 file changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/101_net-ipv4.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/101_net-ipv4.patch
patching file net/ipv4/af_inet.c
git add --all
git commit -m '[patch] 101_net-ipv4.patch'
[linux-6.12.109-xlnx-v2025.1-1 b3bf08241] [patch] 101_net-ipv4.patch
 1 file changed, 6 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/102_crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/102_crypto.patch
patching file crypto/ecdsa.c
git add --all
git commit -m '[patch] 102_crypto.patch'
[linux-6.12.109-xlnx-v2025.1-1 3c19702f1] [patch] 102_crypto.patch
 1 file changed, 4 insertions(+), 8 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/202_drivers-clk.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/202_drivers-clk.patch
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
[linux-6.12.109-xlnx-v2025.1-1 85f28305a] [patch] 202_drivers-clk.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/203_drivers-clocksource.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/203_drivers-clocksource.patch
patching file drivers/clocksource/timer-cadence-ttc.c
git add --all
git commit -m '[patch] 203_drivers-clocksource.patch'
[linux-6.12.109-xlnx-v2025.1-1 e52c5f51a] [patch] 203_drivers-clocksource.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/204_drivers-crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/204_drivers-crypto.patch
patching file Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
patching file drivers/crypto/Kconfig
Hunk #1 succeeded at 713 (offset -1 lines).
Hunk #2 succeeded at 759 (offset -1 lines).
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
[linux-6.12.109-xlnx-v2025.1-1 77b7010a1] [patch] 204_drivers-crypto.patch
 11 files changed, 3239 insertions(+), 258 deletions(-)
 create mode 100644 drivers/crypto/Kconfig.orig
 create mode 100644 drivers/crypto/xilinx/xilinx-ecdsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx_ecdsasig.asn1
 create mode 100644 drivers/crypto/xilinx/zynqmp-rsa.c
 create mode 100644 include/crypto/ecdsa.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/205_drivers-dma.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/205_drivers-dma.patch
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
[linux-6.12.109-xlnx-v2025.1-1 946d728d5] [patch] 205_drivers-dma.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/206_drivers-edac.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/206_drivers-edac.patch
patching file Documentation/ABI/testing/sysfs-driver-xilsem-edac
patching file Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
patching file drivers/edac/Kconfig
patching file drivers/edac/Makefile
patching file drivers/edac/versal_edac.c
patching file drivers/edac/xilinx_xilsem_edac.c
git add --all
git commit -m '[patch] 206_drivers-edac.patch'
[linux-6.12.109-xlnx-v2025.1-1 8455d41c4] [patch] 206_drivers-edac.patch
 6 files changed, 1671 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/207_drivers-firmware.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/207_drivers-firmware.patch
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
Hunk #4 FAILED at 37.
Hunk #5 succeeded at 413 (offset 1 line).
Hunk #6 succeeded at 466 (offset 1 line).
Hunk #7 succeeded at 497 (offset 1 line).
Hunk #8 succeeded at 516 (offset 1 line).
Hunk #9 succeeded at 527 (offset 1 line).
Hunk #10 succeeded at 903 (offset 1 line).
Hunk #11 succeeded at 937 (offset 1 line).
Hunk #12 succeeded at 1091 (offset 1 line).
Hunk #13 succeeded at 1167 (offset 1 line).
Hunk #14 succeeded at 1296 (offset 1 line).
Hunk #15 succeeded at 1390 (offset 1 line).
Hunk #16 succeeded at 1449 (offset 1 line).
Hunk #17 succeeded at 1890 (offset 1 line).
Hunk #18 succeeded at 1938 (offset 1 line).
1 out of 18 hunks FAILED -- saving rejects to file drivers/firmware/xilinx/zynqmp-pm.c.rej
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
Hunk #7 FAILED at 161.
Hunk #8 succeeded at 177 (offset 1 line).
Hunk #9 succeeded at 195 (offset 1 line).
Hunk #10 succeeded at 239 (offset 1 line).
Hunk #11 succeeded at 279 (offset 1 line).
Hunk #12 succeeded at 528 (offset 1 line).
Hunk #13 succeeded at 577 with fuzz 1 (offset 13 lines).
Hunk #14 succeeded at 602 (offset 13 lines).
Hunk #15 succeeded at 638 (offset 13 lines).
Hunk #16 succeeded at 651 (offset 13 lines).
Hunk #17 succeeded at 669 (offset 13 lines).
Hunk #18 succeeded at 688 (offset 13 lines).
Hunk #19 succeeded at 713 (offset 13 lines).
Hunk #20 succeeded at 799 (offset 13 lines).
Hunk #21 succeeded at 850 (offset 13 lines).
Hunk #22 succeeded at 927 (offset 13 lines).
Hunk #23 succeeded at 976 (offset 13 lines).
Hunk #24 succeeded at 1002 (offset 13 lines).
Hunk #25 succeeded at 1016 (offset 13 lines).
Hunk #26 succeeded at 1028 (offset 13 lines).
1 out of 26 hunks FAILED -- saving rejects to file include/linux/firmware/xlnx-zynqmp.h.rej
git add --all
git commit -m '[patch] 207_drivers-firmware.patch'
[linux-6.12.109-xlnx-v2025.1-1 7085f3502] [patch] 207_drivers-firmware.patch
 27 files changed, 9778 insertions(+), 92 deletions(-)
 create mode 100644 drivers/firmware/xilinx/zynqmp-core.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-crypto.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-fpga.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-nvm.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-pdi.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-pm.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-pm.c.orig
 create mode 100644 drivers/firmware/xilinx/zynqmp-pm.c.rej
 create mode 100644 drivers/firmware/xilinx/zynqmp-secure.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-sem.c
 rename drivers/firmware/xilinx/{zynqmp.c => zynqmp.c.orig} (100%)
 create mode 100644 include/linux/firmware/amd-versal2-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-error-events.h
 create mode 100644 include/linux/firmware/xlnx-versal-net-error-events.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-fpga.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-nvm.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-pdi.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-secure.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp-sem.h
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h.orig
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h.rej
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/208_drivers-fpga.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/208_drivers-fpga.patch
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
[linux-6.12.109-xlnx-v2025.1-1 a586f918f] [patch] 208_drivers-fpga.patch
 14 files changed, 982 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml
 create mode 100644 drivers/fpga/xilinx-afi.c
 create mode 100644 drivers/fpga/zynq-afi.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/210_drivers-gpu-drm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/210_drivers-gpu-drm.patch
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
[linux-6.12.109-xlnx-v2025.1-1 0e9ac060a] [patch] 210_drivers-gpu-drm.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/211_drivers-hwmon.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
patching file Documentation/hwmon/ina2xx.rst
Hunk #1 succeeded at 84 (offset 31 lines).
Hunk #2 succeeded at 121 with fuzz 2 (offset 39 lines).
Hunk #3 FAILED at 100.
1 out of 3 hunks FAILED -- saving rejects to file Documentation/hwmon/ina2xx.rst.rej
patching file drivers/hwmon/Kconfig
Hunk #1 FAILED at 2170.
1 out of 1 hunk FAILED -- saving rejects to file drivers/hwmon/Kconfig.rej
patching file drivers/hwmon/ina2xx.c
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 155.
Hunk #4 FAILED at 163.
Hunk #5 succeeded at 346 with fuzz 2 (offset 92 lines).
Hunk #6 FAILED at 633.
Hunk #7 FAILED at 642.
Hunk #8 FAILED at 660.
Hunk #9 FAILED at 677.
Hunk #10 FAILED at 691.
Hunk #11 FAILED at 800.
Hunk #12 FAILED at 811.
Hunk #13 succeeded at 980 with fuzz 2 (offset 160 lines).
Hunk #14 FAILED at 868.
Hunk #15 FAILED at 884.
Hunk #16 FAILED at 909.
14 out of 16 hunks FAILED -- saving rejects to file drivers/hwmon/ina2xx.c.rej
git add --all
git commit -m '[patch] 211_drivers-hwmon.patch'
[linux-6.12.109-xlnx-v2025.1-1 cac6c4712] [patch] 211_drivers-hwmon.patch
 9 files changed, 4141 insertions(+)
 create mode 100644 Documentation/hwmon/ina2xx.rst.orig
 create mode 100644 Documentation/hwmon/ina2xx.rst.rej
 create mode 100644 drivers/hwmon/Kconfig.orig
 create mode 100644 drivers/hwmon/Kconfig.rej
 create mode 100644 drivers/hwmon/ina2xx.c.orig
 create mode 100644 drivers/hwmon/ina2xx.c.rej
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/212_drivers-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/212_drivers-i2c.patch
patching file drivers/i2c/busses/i2c-cadence.c
patching file drivers/i2c/busses/i2c-xiic.c
patching file drivers/i2c/i2c-atr.c
patching file include/linux/i2c-atr.h
git add --all
git commit -m '[patch] 212_drivers-i2c.patch'
[linux-6.12.109-xlnx-v2025.1-1 10185d15f] [patch] 212_drivers-i2c.patch
 4 files changed, 990 insertions(+), 357 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/213_drivers-i3c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/213_drivers-i3c.patch
patching file Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
git add --all
git commit -m '[patch] 213_drivers-i3c.patch'
[linux-6.12.109-xlnx-v2025.1-1 839f5b35b] [patch] 213_drivers-i3c.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/214_drivers-iio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/214_drivers-iio.patch
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
[linux-6.12.109-xlnx-v2025.1-1 89321f448] [patch] 214_drivers-iio.patch
 11 files changed, 3051 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/ina260-adc.c
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/216_drivers-irqchip.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/216_drivers-irqchip.patch
patching file Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
patching file drivers/irqchip/Kconfig
patching file drivers/irqchip/irq-xilinx-intc.c
patching file drivers/irqchip/irqchip.c
patching file include/linux/irq.h
patching file include/linux/irqchip.h
patching file include/linux/of_irq.h
git add --all
git commit -m '[patch] 216_drivers-irqchip.patch'
[linux-6.12.109-xlnx-v2025.1-1 918e8d377] [patch] 216_drivers-irqchip.patch
 7 files changed, 286 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/217_drivers-mailbox.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/217_drivers-mailbox.patch
patching file Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
patching file drivers/mailbox/zynqmp-ipi-mailbox.c
git add --all
git commit -m '[patch] 217_drivers-mailbox.patch'
[linux-6.12.109-xlnx-v2025.1-1 2e02bfa95] [patch] 217_drivers-mailbox.patch
 2 files changed, 6 insertions(+), 2 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/217_drivers-mailbox.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/218_drivers-media-common.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/218_drivers-media-common.patch
patching file drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
git add --all
git commit -m '[patch] 218_drivers-media-common.patch'
[linux-6.12.109-xlnx-v2025.1-1 81d6c4375] [patch] 218_drivers-media-common.patch
 1 file changed, 10 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/219_drivers-media-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/219_drivers-media-i2c.patch
patching file Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
patching file drivers/media/i2c/Kconfig
patching file drivers/media/i2c/Makefile
patching file drivers/media/i2c/ap1302.c
patching file drivers/media/i2c/ds90ub913.c
patching file drivers/media/i2c/ds90ub953.c
patching file drivers/media/i2c/ds90ub960.c
git add --all
git commit -m '[patch] 219_drivers-media-i2c.patch'
[linux-6.12.109-xlnx-v2025.1-1 b567d6634] [patch] 219_drivers-media-i2c.patch
 7 files changed, 3246 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
 create mode 100644 drivers/media/i2c/ap1302.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/220_drivers-media-mc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/220_drivers-media-mc.patch
patching file drivers/media/mc/mc-entity.c
git add --all
git commit -m '[patch] 220_drivers-media-mc.patch'
[linux-6.12.109-xlnx-v2025.1-1 5db7d2fe3] [patch] 220_drivers-media-mc.patch
 1 file changed, 29 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/221_drivers-media-platform.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/221_drivers-media-platform.patch
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
[linux-6.12.109-xlnx-v2025.1-1 9cf707d61] [patch] 221_drivers-media-platform.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patching file drivers/media/test-drivers/vivid/vivid-vid-common.c
git add --all
git commit -m '[patch] 222_drivers-media-test-drivers.patch'
[linux-6.12.109-xlnx-v2025.1-1 f333ceb37] [patch] 222_drivers-media-test-drivers.patch
 1 file changed, 8 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/224_drivers-media-v4l2.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/224_drivers-media-v4l2.patch
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
[linux-6.12.109-xlnx-v2025.1-1 d4083546a] [patch] 224_drivers-media-v4l2.patch
 21 files changed, 1592 insertions(+), 125 deletions(-)
 create mode 100644 include/media/hdr-ctrls.h
 create mode 100644 include/uapi/linux/xilinx-dprxss.h
 create mode 100644 include/uapi/linux/xilinx-hdmirxss.h
 create mode 100644 include/uapi/linux/xilinx-hls.h
 create mode 100644 include/uapi/linux/xilinx-sdirxss.h
 create mode 100644 include/uapi/linux/xilinx-v4l2-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/225_drivers-mfd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
git add --all
git commit -m '[patch] 225_drivers-mfd.patch'
[linux-6.12.109-xlnx-v2025.1-1 fa726b250] [patch] 225_drivers-mfd.patch
 7 files changed, 470 insertions(+), 291 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/226_drivers-misc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/226_drivers-misc.patch
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
[linux-6.12.109-xlnx-v2025.1-1 be28fad2b] [patch] 226_drivers-misc.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/228_drivers-mtd.patch
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
[linux-6.12.109-xlnx-v2025.1-1 b640e76a5] [patch] 228_drivers-mtd.patch
 17 files changed, 2308 insertions(+), 365 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/228_drivers-mtd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
Hunk #14 succeeded at 5151 (offset 18 lines).
Hunk #15 succeeded at 5184 (offset 18 lines).
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
[linux-6.12.109-xlnx-v2025.1-1 32ed64030] [patch] 230_drivers-net-ethernet.patch
 15 files changed, 12802 insertions(+), 865 deletions(-)
 create mode 100644 drivers/net/ethernet/cadence/macb_main.c.orig
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/231_drivers-net-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/231_drivers-net-phy.patch
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
[linux-6.12.109-xlnx-v2025.1-1 11d871e60] [patch] 231_drivers-net-phy.patch
 8 files changed, 246 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx-phy.txt
 create mode 100644 drivers/net/phy/xilinx_phy.c
 create mode 100644 include/linux/xilinx_phy.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/234_drivers-nvmem.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/234_drivers-nvmem.patch
patching file Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
patching file drivers/nvmem/Kconfig
patching file drivers/nvmem/Makefile
patching file drivers/nvmem/xlnx_secure_config.c
git add --all
git commit -m '[patch] 234_drivers-nvmem.patch'
[linux-6.12.109-xlnx-v2025.1-1 6b928ac73] [patch] 234_drivers-nvmem.patch
 4 files changed, 1300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
 create mode 100644 drivers/nvmem/xlnx_secure_config.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/235_drivers-of.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/235_drivers-of.patch
patching file Documentation/devicetree/configfs-overlays.txt
patching file drivers/of/Kconfig
patching file drivers/of/Makefile
patching file drivers/of/configfs.c
patching file drivers/of/overlay.c
git add --all
git commit -m '[patch] 235_drivers-of.patch'
[linux-6.12.109-xlnx-v2025.1-1 7e47be49e] [patch] 235_drivers-of.patch
 5 files changed, 341 insertions(+)
 create mode 100644 Documentation/devicetree/configfs-overlays.txt
 create mode 100644 drivers/of/configfs.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/236_drivers-pci.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/236_drivers-pci.patch
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
[linux-6.12.109-xlnx-v2025.1-1 7ab9f63bf] [patch] 236_drivers-pci.patch
 9 files changed, 827 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/237_drivers-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/237_drivers-phy.patch
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
[linux-6.12.109-xlnx-v2025.1-1 fbe90dcd0] [patch] 237_drivers-phy.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/238_drivers-pinctrl.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/238_drivers-pinctrl.patch
patching file Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
patching file drivers/pinctrl/pinctrl-zynqmp.c
git add --all
git commit -m '[patch] 238_drivers-pinctrl.patch'
[linux-6.12.109-xlnx-v2025.1-1 314a5b304] [patch] 238_drivers-pinctrl.patch
 2 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/240_drivers-ptp.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/240_drivers-ptp.patch
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
[linux-6.12.109-xlnx-v2025.1-1 3292a186f] [patch] 240_drivers-ptp.patch
 8 files changed, 715 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml
 create mode 100644 drivers/ptp/ptp_xilinx.c
 create mode 100644 include/linux/ptp/ptp_xilinx.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/241_drivers-pwm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/241_drivers-pwm.patch
patching file drivers/pwm/Kconfig
patching file drivers/pwm/Makefile
patching file drivers/pwm/pwm-cadence.c
git add --all
git commit -m '[patch] 241_drivers-pwm.patch'
[linux-6.12.109-xlnx-v2025.1-1 db3149f22] [patch] 241_drivers-pwm.patch
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/242_drivers-remoteproc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/242_drivers-remoteproc.patch
patching file drivers/remoteproc/xlnx_r5_remoteproc.c
Hunk #4 succeeded at 1370 (offset 30 lines).
git add --all
git commit -m '[patch] 242_drivers-remoteproc.patch'
[linux-6.12.109-xlnx-v2025.1-1 31789760a] [patch] 242_drivers-remoteproc.patch
 2 files changed, 1564 insertions(+), 4 deletions(-)
 create mode 100644 drivers/remoteproc/xlnx_r5_remoteproc.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/243_drivers-reset.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/243_drivers-reset.patch
patching file Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
git add --all
git commit -m '[patch] 243_drivers-reset.patch'
[linux-6.12.109-xlnx-v2025.1-1 6737004c3] [patch] 243_drivers-reset.patch
 1 file changed, 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/243_drivers-reset.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patching file Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
patching file drivers/soc/xilinx/xlnx_event_manager.c
patching file drivers/soc/xilinx/zynqmp_power.c
git add --all
git commit -m '[patch] 246_drivers-soc-xilinx.patch'
[linux-6.12.109-xlnx-v2025.1-1 41327501e] [patch] 246_drivers-soc-xilinx.patch
 4 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
git add --all
git commit -m '[patch] 247_drivers-spi.patch'
[linux-6.12.109-xlnx-v2025.1-1 ba9eca9f7] [patch] 247_drivers-spi.patch
 13 files changed, 1490 insertions(+), 390 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/247_drivers-spi.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/248_drivers-staging.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/248_drivers-staging.patch
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
[linux-6.12.109-xlnx-v2025.1-1 bcd1ca81c] [patch] 248_drivers-staging.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/249_drivers-thermal.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/249_drivers-thermal.patch
patching file Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
patching file drivers/thermal/Kconfig
patching file drivers/thermal/Makefile
patching file drivers/thermal/versal_thermal.c
git add --all
git commit -m '[patch] 249_drivers-thermal.patch'
[linux-6.12.109-xlnx-v2025.1-1 3eb08a471] [patch] 249_drivers-thermal.patch
 4 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
 create mode 100644 drivers/thermal/versal_thermal.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/250_drivers-tty.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/250_drivers-tty.patch
patching file Documentation/devicetree/bindings/serial/pl011.yaml
patching file Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
git add --all
git commit -m '[patch] 250_drivers-tty.patch'
[linux-6.12.109-xlnx-v2025.1-1 b44e1d2bc] [patch] 250_drivers-tty.patch
 2 files changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/251_drivers-ufs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/251_drivers-ufs.patch
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
[linux-6.12.109-xlnx-v2025.1-1 fdaace1e0] [patch] 251_drivers-ufs.patch
 11 files changed, 647 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
 create mode 100644 drivers/ufs/host/ufs-amd-versal2.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/252_drivers-uio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/252_drivers-uio.patch
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
[linux-6.12.109-xlnx-v2025.1-1 53cad50eb] [patch] 252_drivers-uio.patch
 9 files changed, 1167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xilinx-apm.yaml
 rename drivers/uio/{uio.c => uio_core.c} (96%)
 create mode 100644 drivers/uio/uio_dmabuf.c
 create mode 100644 drivers/uio/uio_dmabuf.h
 create mode 100644 drivers/uio/uio_xilinx_ai_engine.c
 create mode 100644 drivers/uio/uio_xilinx_apm.c
 create mode 100644 include/uapi/linux/uio/uio.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/260_drivers-usb-core.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/260_drivers-usb-core.patch
patching file Documentation/devicetree/bindings/usb/usb-xhci.yaml
git add --all
git commit -m '[patch] 260_drivers-usb-core.patch'
[linux-6.12.109-xlnx-v2025.1-1 6a4bf7ad4] [patch] 260_drivers-usb-core.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patching file drivers/usb/chipidea/ci_hdrc_usb2.c
git add --all
git commit -m '[patch] 261_drivers-usb-chipidea.patch'
[linux-6.12.109-xlnx-v2025.1-1 e08538c13] [patch] 261_drivers-usb-chipidea.patch
 1 file changed, 10 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/262_drivers-usb-dwc3.patch
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
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
git add --all
git commit -m '[patch] 262_drivers-usb-dwc3.patch'
[linux-6.12.109-xlnx-v2025.1-1 e68793ebb] [patch] 262_drivers-usb-dwc3.patch
 16 files changed, 4385 insertions(+), 120 deletions(-)
 create mode 100644 drivers/usb/dwc3/gadget_hibernation.c
 create mode 100644 drivers/usb/dwc3/otg.c
 create mode 100644 drivers/usb/dwc3/otg.h
 create mode 100644 drivers/usb/dwc3/platform_data.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/262_drivers-usb-dwc3.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/263_drivers-usb-gadget.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/263_drivers-usb-gadget.patch
patching file drivers/usb/gadget/function/f_tcm.c
Hunk #1 succeeded at 1632 (offset 3 lines).
Hunk #2 succeeded at 1940 (offset 3 lines).
git add --all
git commit -m '[patch] 263_drivers-usb-gadget.patch'
[linux-6.12.109-xlnx-v2025.1-1 afdea8224] [patch] 263_drivers-usb-gadget.patch
 2 files changed, 2471 insertions(+)
 create mode 100644 drivers/usb/gadget/function/f_tcm.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
Hunk #1 succeeded at 1850 (offset 1 line).
git add --all
git commit -m '[patch] 264_drivers-usb-host.patch'
[linux-6.12.109-xlnx-v2025.1-1 9ae2bb7f4] [patch] 264_drivers-usb-host.patch
 5 files changed, 2640 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci.h.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/266_drivers-usb-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/266_drivers-usb-phy.patch
patching file Documentation/devicetree/bindings/usb/ulpi-phy.yaml
patching file drivers/usb/phy/Kconfig
patching file drivers/usb/phy/phy-ulpi.c
git add --all
git commit -m '[patch] 266_drivers-usb-phy.patch'
[linux-6.12.109-xlnx-v2025.1-1 3c4bee6cc] [patch] 266_drivers-usb-phy.patch
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/271_drivers-video.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/271_drivers-video.patch
patching file drivers/video/hdmi.c
git add --all
git commit -m '[patch] 271_drivers-video.patch'
[linux-6.12.109-xlnx-v2025.1-1 51e303ffe] [patch] 271_drivers-video.patch
 1 file changed, 4 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/272_drivers-virtio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/272_drivers-virtio.patch
patching file drivers/virtio/virtio_ring.c
git add --all
git commit -m '[patch] 272_drivers-virtio.patch'
[linux-6.12.109-xlnx-v2025.1-1 a2ad24624] [patch] 272_drivers-virtio.patch
 1 file changed, 1 insertion(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/273_drivers-w1.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/273_drivers-w1.patch
patching file Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
git add --all
git commit -m '[patch] 273_drivers-w1.patch'
[linux-6.12.109-xlnx-v2025.1-1 1da29c919] [patch] 273_drivers-w1.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/275_drivers-xen.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/275_drivers-xen.patch
patching file drivers/xen/Kconfig
patching file drivers/xen/Makefile
patching file drivers/xen/pvcalls.c
patching file include/xen/pvcalls.h
patching file include/xen/xen.h
git add --all
git commit -m '[patch] 275_drivers-xen.patch'
[linux-6.12.109-xlnx-v2025.1-1 b97dbb205] [patch] 275_drivers-xen.patch
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xen/pvcalls.c
 create mode 100644 include/xen/pvcalls.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/301_sound-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/301_sound-soc-xilinx.patch
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
Hunk #7 succeeded at 295 with fuzz 1 (offset -1 lines).
Hunk #8 succeeded at 313 with fuzz 1 (offset -2 lines).
Hunk #9 succeeded at 341 (offset -2 lines).
Hunk #10 succeeded at 378 (offset -2 lines).
Hunk #11 succeeded at 425 (offset -2 lines).
Hunk #12 succeeded at 439 (offset -2 lines).
Hunk #13 succeeded at 462 (offset -2 lines).
Hunk #14 succeeded at 474 (offset -2 lines).
Hunk #15 succeeded at 507 (offset -2 lines).
Hunk #16 succeeded at 528 (offset -2 lines).
Hunk #17 succeeded at 558 (offset -2 lines).
Hunk #18 succeeded at 596 (offset -2 lines).
Hunk #19 succeeded at 615 (offset -2 lines).
Hunk #20 FAILED at 757.
Hunk #21 succeeded at 836 (offset -2 lines).
Hunk #22 succeeded at 860 (offset -2 lines).
Hunk #23 succeeded at 871 (offset -2 lines).
1 out of 23 hunks FAILED -- saving rejects to file sound/soc/xilinx/xlnx_formatter_pcm.c.rej
patching file sound/soc/xilinx/xlnx_i2s.c
patching file sound/soc/xilinx/xlnx_pl_snd_card.c
patching file sound/soc/xilinx/xlnx_sdi_audio.c
patching file sound/soc/xilinx/xlnx_snd_common.h
patching file sound/soc/xilinx/xlnx_spdif.c
git add --all
git commit -m '[patch] 301_sound-soc-xilinx.patch'
[linux-6.12.109-xlnx-v2025.1-1 221941546] [patch] 301_sound-soc-xilinx.patch
 17 files changed, 2773 insertions(+), 225 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c.orig
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c.rej
 create mode 100644 sound/soc/xilinx/xlnx_pl_snd_card.c
 create mode 100644 sound/soc/xilinx/xlnx_sdi_audio.c
 create mode 100644 sound/soc/xilinx/xlnx_snd_common.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/999_other-document.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/../linux-6.12.100-xlnx-v2025.1/999_other-document.patch
patching file MAINTAINERS
Hunk #4 succeeded at 9005 (offset 5 lines).
Hunk #5 succeeded at 11171 (offset 5 lines).
Hunk #6 succeeded at 19815 (offset 5 lines).
Hunk #7 succeeded at 21138 (offset 5 lines).
Hunk #8 succeeded at 23846 (offset 5 lines).
Hunk #9 succeeded at 24242 (offset 5 lines).
Hunk #10 succeeded at 24269 (offset 5 lines).
Hunk #11 succeeded at 25480 (offset 5 lines).
Hunk #12 succeeded at 25542 (offset 5 lines).
Hunk #13 succeeded at 25622 (offset 5 lines).
Hunk #14 succeeded at 25730 (offset 5 lines).
Hunk #15 succeeded at 25843 (offset 5 lines).
Hunk #16 succeeded at 25879 (offset 5 lines).
Hunk #17 succeeded at 25909 (offset 5 lines).
git add --all
git commit -m '[patch] 999_other-document.patch'
[linux-6.12.109-xlnx-v2025.1-1 86a379252] [patch] 999_other-document.patch
 2 files changed, 26151 insertions(+), 3 deletions(-)
 create mode 100644 MAINTAINERS.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.109-xlnx-v2025.1/999_other-document.patch
```

###### 204_drivers-crypto.patch

####### drivers/crypto/Kconfig

```console
shell$ diff -p linux-6.12.100/drivers/crypto/Kconfig linux-6.12.109/drivers/crypto/Kconfig
*** linux-6.12.100/drivers/crypto/Kconfig	2026-08-05 10:45:14.121988605 +0900
--- linux-6.12.109/drivers/crypto/Kconfig	2026-10-09 15:27:30.682717196 +0900
*************** config CRYPTO_DEV_QCOM_RNG
*** 648,654 ****
  	tristate "Qualcomm Random Number Generator Driver"
  	depends on ARCH_QCOM || COMPILE_TEST
  	depends on HW_RANDOM
- 	select CRYPTO_RNG
  	help
  	  This driver provides support for the Random Number
  	  Generator hardware found on Qualcomm SoCs.
--- 648,653 ----
```

```console
shell$ diff -p linux-6.12.100/drivers/crypto/Kconfig linux-6.12.100-xlnx-v2025.1/drivers/crypto/Kconfig
*** linux-6.12.100/drivers/crypto/Kconfig	2026-08-05 10:45:14.121988605 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/crypto/Kconfig	2026-08-05 11:16:14.500886114 +0900
*************** config CRYPTO_DEV_TEGRA
*** 714,725 ****
  	  Select this to enable Tegra Security Engine which accelerates various
  	  AES encryption/decryption and HASH algorithms.
  
  config CRYPTO_DEV_ZYNQMP_AES
  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
! 	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
  	select CRYPTO_AES
  	select CRYPTO_ENGINE
  	select CRYPTO_AEAD
  	help
  	  Xilinx ZynqMP has AES-GCM engine used for symmetric key
  	  encryption and decryption. This driver interfaces with AES hw
--- 714,749 ----
  	  Select this to enable Tegra Security Engine which accelerates various
  	  AES encryption/decryption and HASH algorithms.
  
+ config CRYPTO_DEV_XILINX_ECDSA
+ 	tristate "Support for Xilinx ECDSA hardware accelerator"
+ 	depends on ARCH_ZYNQMP || COMPILE_TEST
+ 	select CRYPTO_ENGINE
+ 	select CRYPTO_AKCIPHER
+ 	select CRYPTO_ECDSA
+ 	help
+ 	  Xilinx processors have ECDSA hardware accelerator used for signature
+ 	  and key generation and verification. This driver interfaces with
+ 	  ECDSA hardware accelerator. Select this if you want to use the Versal
+ 	  module for ECDSA algorithms.
+ 
+ config CRYPTO_DEV_XILINX_RSA
+ 	tristate "Support for Xilinx ZynqMP RSA hw accelerator (DEPRECATED)"
+ 	depends on (ARCH_ZYNQMP || COMPILE_TEST) && (CRYPTO_DEV_XILINX_RSA_AKCIPHER=n)
+ 	select CRYPTO_AES
+ 	select CRYPTO_BLKCIPHER
+ 	help
+ 	  Xilinx processors have RSA hw accelerator used for signature
+ 	  generation and verification. This driver is deprecated.
+ 	  Please migrate to : CRYPTO_DEV_XILINX_RSA_AKCIPHER
+ 
  config CRYPTO_DEV_ZYNQMP_AES
  	tristate "Support for Xilinx ZynqMP AES hw accelerator"
! 	depends on NET && (ZYNQMP_FIRMWARE || COMPILE_TEST)
  	select CRYPTO_AES
  	select CRYPTO_ENGINE
  	select CRYPTO_AEAD
+ 	select CRYPTO_GCM
+ 	select CRYPTO_USER_API_AEAD
  	help
  	  Xilinx ZynqMP has AES-GCM engine used for symmetric key
  	  encryption and decryption. This driver interfaces with AES hw
*************** config CRYPTO_DEV_ZYNQMP_SHA3
*** 736,741 ****
--- 760,777 ----
  	  Select this if you want to use the ZynqMP module
  	  for SHA3 hash computation.
  
+ config CRYPTO_DEV_XILINX_RSA_AKCIPHER
+ 	tristate "Support for Xilinx RSA hw accelerator"
+ 	depends on ARCH_ZYNQMP || COMPILE_TEST
+ 	select CRYPTO_ENGINE
+ 	select CRYPTO_RSA
+ 	select CRYPTO_AKCIPHER
+ 	help
+ 	  Xilinx processors have RSA hw accelerator used for signature
+ 	  generation and verification. This driver interfaces with RSA
+ 	  hw accelerator. Select this if you want to use ZynqMP or Versal
+ 	  module for RSA algorithms.
+ 
  source "drivers/crypto/chelsio/Kconfig"
  
  source "drivers/crypto/virtio/Kconfig"
```

####### Make 204_drivers-crypto.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/204_drivers-crypto.patch
patching file Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
patching file drivers/crypto/Kconfig
Hunk #1 succeeded at 713 (offset -1 lines).
Hunk #2 succeeded at 759 (offset -1 lines).
patching file drivers/crypto/xilinx/Makefile
patching file drivers/crypto/xilinx/xilinx-ecdsa.c
patching file drivers/crypto/xilinx/xilinx-rsa.c
patching file drivers/crypto/xilinx/xilinx_ecdsasig.asn1
patching file drivers/crypto/xilinx/zynqmp-aes-gcm.c
patching file drivers/crypto/xilinx/zynqmp-rsa.c
patching file drivers/crypto/xilinx/zynqmp-sha.c
patching file include/crypto/ecdsa.h
```

```console
shell$ rm drivers/crypto/Kconfig.orig
shell$ git add --all
shell$ git commit -m "[patch] 204_drivers-crypto.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/204_drivers-crypto.patch

###### 207_drivers-firmware.patch

####### drivers/firmware/xilinx/zynqmp-pm.c

```console
shell$ diff -p linux-6.12.100/drivers/firmware/xilinx/zynqmp.c linux-6.12.109/drivers/firmware/xilinx/zynqmp.c
diff -p linux-6.12.100/drivers/firmware/xilinx/zynqmp.c linux-6.12.109/drivers/firmware/xilinx/zynqmp.c
*** linux-6.12.100/drivers/firmware/xilinx/zynqmp.c	2026-08-05 10:45:14.188516382 +0900
--- linux-6.12.109/drivers/firmware/xilinx/zynqmp.c	2026-10-09 15:27:30.754727909 +0900
*************** int zynqmp_pm_invoke_fn(u32 pm_api_id, u
*** 386,391 ****
--- 386,392 ----
  	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
  			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
  }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_invoke_fn);
  
  static u32 pm_api_version;
  static u32 pm_tz_version;
```


```console
shell$ diff -p linux-6.12.100/drivers/firmware/xilinx/zynqmp.c linux-6.12.100-xlnx-v2025.1/drivers/firmware/xilinx/zynqmp-pm.c
*** linux-6.12.100/drivers/firmware/xilinx/zynqmp.c	2026-08-05 10:45:14.188516382 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/firmware/xilinx/zynqmp-pm.c	2026-08-05 11:16:15.229301053 +0900
***************
*** 3,9 ****
   * Xilinx Zynq MPSoC Firmware layer
   *
   *  Copyright (C) 2014-2022 Xilinx, Inc.
!  *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
   *
   *  Michal Simek <michal.simek@amd.com>
   *  Davorin Mista <davorin.mista@aggios.com>
--- 3,9 ----
   * Xilinx Zynq MPSoC Firmware layer
   *
   *  Copyright (C) 2014-2022 Xilinx, Inc.
!  *  Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
   *
   *  Michal Simek <michal.simek@amd.com>
   *  Davorin Mista <davorin.mista@aggios.com>
***************
*** 14,19 ****
--- 14,21 ----
  #include <linux/arm-smccc.h>
  #include <linux/compiler.h>
  #include <linux/device.h>
+ #include <linux/dma-mapping.h>
+ #include <linux/firmware.h>
  #include <linux/init.h>
  #include <linux/mfd/core.h>
  #include <linux/module.h>
***************
*** 28,36 ****
  #include <linux/firmware/xlnx-event-manager.h>
  #include "zynqmp-debug.h"
  
- /* Max HashMap Order for PM API feature check (1<<7 = 128) */
- #define PM_API_FEATURE_CHECK_MAX_ORDER  7
- 
  /* CRL registers and bitfields */
  #define CRL_APB_BASE			0xFF5E0000U
  /* BOOT_PIN_CTRL- Used to control the mode pins after boot */
--- 30,35 ----
***************
*** 38,396 ****
  /* BOOT_PIN_CTRL_MASK- out_val[11:8], out_en[3:0] */
  #define CRL_APB_BOOTPIN_CTRL_MASK	0xF0FU
  
! /* IOCTL/QUERY feature payload size */
! #define FEATURE_PAYLOAD_SIZE		2
! 
! static bool feature_check_enabled;
! static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
! static u32 ioctl_features[FEATURE_PAYLOAD_SIZE];
! static u32 query_features[FEATURE_PAYLOAD_SIZE];
! 
! static struct platform_device *em_dev;
! 
! /**
!  * struct zynqmp_devinfo - Structure for Zynqmp device instance
!  * @dev:		Device Pointer
!  * @feature_conf_id:	Feature conf id
!  */
! struct zynqmp_devinfo {
! 	struct device *dev;
! 	u32 feature_conf_id;
! };
! 
! /**
!  * struct pm_api_feature_data - PM API Feature data
!  * @pm_api_id:		PM API Id, used as key to index into hashmap
!  * @feature_status:	status of PM API feature: valid, invalid
!  * @hentry:		hlist_node that hooks this entry into hashtable
!  */
! struct pm_api_feature_data {
! 	u32 pm_api_id;
! 	int feature_status;
! 	struct hlist_node hentry;
! };
! 
! static const struct mfd_cell firmware_devs[] = {
! 	{
! 		.name = "zynqmp_power_controller",
! 	},
! };
! 
! /**
!  * zynqmp_pm_ret_code() - Convert PMU-FW error codes to Linux error codes
!  * @ret_status:		PMUFW return code
!  *
!  * Return: corresponding Linux error code
!  */
! static int zynqmp_pm_ret_code(u32 ret_status)
! {
! 	switch (ret_status) {
! 	case XST_PM_SUCCESS:
! 	case XST_PM_DOUBLE_REQ:
! 		return 0;
! 	case XST_PM_NO_FEATURE:
! 		return -ENOTSUPP;
! 	case XST_PM_INVALID_VERSION:
! 		return -EOPNOTSUPP;
! 	case XST_PM_NO_ACCESS:
! 		return -EACCES;
! 	case XST_PM_ABORT_SUSPEND:
! 		return -ECANCELED;
! 	case XST_PM_MULT_USER:
! 		return -EUSERS;
! 	case XST_PM_INTERNAL:
! 	case XST_PM_CONFLICT:
! 	case XST_PM_INVALID_NODE:
! 	case XST_PM_INVALID_CRC:
! 	default:
! 		return -EINVAL;
! 	}
! }
! 
! static noinline int do_fw_call_fail(u32 *ret_payload, u32 num_args, ...)
! {
! 	return -ENODEV;
! }
! 
! /*
!  * PM function call wrapper
!  * Invoke do_fw_call_smc or do_fw_call_hvc, depending on the configuration
!  */
! static int (*do_fw_call)(u32 *ret_payload, u32, ...) = do_fw_call_fail;
! 
! /**
!  * do_fw_call_smc() - Call system-level platform management layer (SMC)
!  * @num_args:		Number of variable arguments should be <= 8
!  * @ret_payload:	Returned value array
!  *
!  * Invoke platform management function via SMC call (no hypervisor present).
!  *
!  * Return: Returns status, either success or error+reason
!  */
! static noinline int do_fw_call_smc(u32 *ret_payload, u32 num_args, ...)
! {
! 	struct arm_smccc_res res;
! 	u64 args[8] = {0};
! 	va_list arg_list;
! 	u8 i;
! 
! 	if (num_args > 8)
! 		return -EINVAL;
! 
! 	va_start(arg_list, num_args);
! 
! 	for (i = 0; i < num_args; i++)
! 		args[i] = va_arg(arg_list, u64);
! 
! 	va_end(arg_list);
! 
! 	arm_smccc_smc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
! 
! 	if (ret_payload) {
! 		ret_payload[0] = lower_32_bits(res.a0);
! 		ret_payload[1] = upper_32_bits(res.a0);
! 		ret_payload[2] = lower_32_bits(res.a1);
! 		ret_payload[3] = upper_32_bits(res.a1);
! 	}
! 
! 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
! }
! 
! /**
!  * do_fw_call_hvc() - Call system-level platform management layer (HVC)
!  * @num_args:		Number of variable arguments should be <= 8
!  * @ret_payload:	Returned value array
!  *
!  * Invoke platform management function via HVC
!  * HVC-based for communication through hypervisor
!  * (no direct communication with ATF).
!  *
!  * Return: Returns status, either success or error+reason
!  */
! static noinline int do_fw_call_hvc(u32 *ret_payload, u32 num_args, ...)
! {
! 	struct arm_smccc_res res;
! 	u64 args[8] = {0};
! 	va_list arg_list;
! 	u8 i;
! 
! 	if (num_args > 8)
! 		return -EINVAL;
! 
! 	va_start(arg_list, num_args);
! 
! 	for (i = 0; i < num_args; i++)
! 		args[i] = va_arg(arg_list, u64);
! 
! 	va_end(arg_list);
! 
! 	arm_smccc_hvc(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], &res);
! 
! 	if (ret_payload) {
! 		ret_payload[0] = lower_32_bits(res.a0);
! 		ret_payload[1] = upper_32_bits(res.a0);
! 		ret_payload[2] = lower_32_bits(res.a1);
! 		ret_payload[3] = upper_32_bits(res.a1);
! 	}
! 
! 	return zynqmp_pm_ret_code((enum pm_ret_status)res.a0);
! }
! 
! static int __do_feature_check_call(const u32 api_id, u32 *ret_payload)
! {
! 	int ret;
! 	u64 smc_arg[2];
! 	u32 module_id;
! 	u32 feature_check_api_id;
! 
! 	module_id = FIELD_GET(MODULE_ID_MASK, api_id);
! 
! 	/*
! 	 * Feature check of APIs belonging to PM, XSEM, and TF-A are handled by calling
! 	 * PM_FEATURE_CHECK API. For other modules, call PM_API_FEATURES API.
! 	 */
! 	if (module_id == PM_MODULE_ID || module_id == XSEM_MODULE_ID || module_id == TF_A_MODULE_ID)
! 		feature_check_api_id = PM_FEATURE_CHECK;
! 	else
! 		feature_check_api_id = PM_API_FEATURES;
! 
! 	/*
! 	 * Feature check of TF-A APIs is done in the TF-A layer and it expects for
! 	 * MODULE_ID_MASK bits of SMC's arg[0] to be the same as PM_MODULE_ID.
! 	 */
! 	if (module_id == TF_A_MODULE_ID)
! 		module_id = PM_MODULE_ID;
! 
! 	smc_arg[0] = PM_SIP_SVC | FIELD_PREP(MODULE_ID_MASK, module_id) | feature_check_api_id;
! 	smc_arg[1] = (api_id & API_ID_MASK);
! 
! 	ret = do_fw_call(ret_payload, 2, smc_arg[0], smc_arg[1]);
! 	if (ret)
! 		ret = -EOPNOTSUPP;
! 	else
! 		ret = ret_payload[1];
! 
! 	return ret;
! }
! 
! static int do_feature_check_call(const u32 api_id)
! {
! 	int ret;
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
! 	struct pm_api_feature_data *feature_data;
! 
! 	/* Check for existing entry in hash table for given api */
! 	hash_for_each_possible(pm_api_features_map, feature_data, hentry,
! 			       api_id) {
! 		if (feature_data->pm_api_id == api_id)
! 			return feature_data->feature_status;
! 	}
! 
! 	/* Add new entry if not present */
! 	feature_data = kmalloc(sizeof(*feature_data), GFP_ATOMIC);
! 	if (!feature_data)
! 		return -ENOMEM;
! 
! 	feature_data->pm_api_id = api_id;
! 	ret = __do_feature_check_call(api_id, ret_payload);
! 
! 	feature_data->feature_status = ret;
! 	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
! 
! 	if (api_id == PM_IOCTL)
! 		/* Store supported IOCTL IDs mask */
! 		memcpy(ioctl_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
! 	else if (api_id == PM_QUERY_DATA)
! 		/* Store supported QUERY IDs mask */
! 		memcpy(query_features, &ret_payload[2], FEATURE_PAYLOAD_SIZE * 4);
! 
! 	return ret;
! }
! 
! /**
!  * zynqmp_pm_feature() - Check whether given feature is supported or not and
!  *			 store supported IOCTL/QUERY ID mask
!  * @api_id:		API ID to check
!  *
!  * Return: Returns status, either success or error+reason
!  */
! int zynqmp_pm_feature(const u32 api_id)
! {
! 	int ret;
! 
! 	if (!feature_check_enabled)
! 		return 0;
! 
! 	ret = do_feature_check_call(api_id);
! 
! 	return ret;
! }
! EXPORT_SYMBOL_GPL(zynqmp_pm_feature);
! 
! /**
!  * zynqmp_pm_is_function_supported() - Check whether given IOCTL/QUERY function
!  *				       is supported or not
!  * @api_id:		PM_IOCTL or PM_QUERY_DATA
!  * @id:			IOCTL or QUERY function IDs
!  *
!  * Return: Returns status, either success or error+reason
!  */
! int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id)
! {
! 	int ret;
! 	u32 *bit_mask;
! 
! 	/* Input arguments validation */
! 	if (id >= 64 || (api_id != PM_IOCTL && api_id != PM_QUERY_DATA))
! 		return -EINVAL;
! 
! 	/* Check feature check API version */
! 	ret = do_feature_check_call(PM_FEATURE_CHECK);
! 	if (ret < 0)
! 		return ret;
! 
! 	/* Check if feature check version 2 is supported or not */
! 	if ((ret & FIRMWARE_VERSION_MASK) == PM_API_VERSION_2) {
! 		/*
! 		 * Call feature check for IOCTL/QUERY API to get IOCTL ID or
! 		 * QUERY ID feature status.
! 		 */
! 		ret = do_feature_check_call(api_id);
! 		if (ret < 0)
! 			return ret;
! 
! 		bit_mask = (api_id == PM_IOCTL) ? ioctl_features : query_features;
! 
! 		if ((bit_mask[(id / 32)] & BIT((id % 32))) == 0U)
! 			return -EOPNOTSUPP;
! 	} else {
! 		return -ENODATA;
! 	}
! 
! 	return 0;
! }
! EXPORT_SYMBOL_GPL(zynqmp_pm_is_function_supported);
! 
! /**
!  * zynqmp_pm_invoke_fn() - Invoke the system-level platform management layer
!  *			   caller function depending on the configuration
!  * @pm_api_id:		Requested PM-API call
!  * @ret_payload:	Returned value array
!  * @num_args:		Number of arguments to requested PM-API call
!  *
!  * Invoke platform management function for SMC or HVC call, depending on
!  * configuration.
!  * Following SMC Calling Convention (SMCCC) for SMC64:
!  * Pm Function Identifier,
!  * PM_SIP_SVC + PM_API_ID =
!  *	((SMC_TYPE_FAST << FUNCID_TYPE_SHIFT)
!  *	((SMC_64) << FUNCID_CC_SHIFT)
!  *	((SIP_START) << FUNCID_OEN_SHIFT)
!  *	((PM_API_ID) & FUNCID_NUM_MASK))
!  *
!  * PM_SIP_SVC	- Registered ZynqMP SIP Service Call.
!  * PM_API_ID	- Platform Management API ID.
!  *
!  * Return: Returns status, either success or error+reason
!  */
! int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
! {
! 	/*
! 	 * Added SIP service call Function Identifier
! 	 * Make sure to stay in x0 register
! 	 */
! 	u64 smc_arg[8];
! 	int ret, i;
! 	va_list arg_list;
! 	u32 args[14] = {0};
! 
! 	if (num_args > 14)
! 		return -EINVAL;
! 
! 	va_start(arg_list, num_args);
! 
! 	/* Check if feature is supported or not */
! 	ret = zynqmp_pm_feature(pm_api_id);
! 	if (ret < 0)
! 		return ret;
! 
! 	for (i = 0; i < num_args; i++)
! 		args[i] = va_arg(arg_list, u32);
! 
! 	va_end(arg_list);
! 
! 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
! 	for (i = 0; i < 7; i++)
! 		smc_arg[i + 1] = ((u64)args[(i * 2) + 1] << 32) | args[i * 2];
! 
! 	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
! 			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
! }
! 
! static u32 pm_api_version;
! static u32 pm_tz_version;
! static u32 pm_family_code;
! static u32 pm_sub_family_code;
  
  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
  {
--- 37,43 ----
  /* BOOT_PIN_CTRL_MASK- out_val[11:8], out_en[3:0] */
  #define CRL_APB_BOOTPIN_CTRL_MASK	0xF0FU
  
! static unsigned long register_address;
  
  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
  {
*************** int zynqmp_pm_register_sgi(u32 sgi_num,
*** 413,418 ****
--- 60,66 ----
  int zynqmp_pm_get_api_version(u32 *version)
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
+ 	static u32 pm_api_version;
  	int ret;
  
  	if (!version)
*************** int zynqmp_pm_get_family_info(u32 *famil
*** 465,470 ****
--- 113,120 ----
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
  	u32 idcode;
+ 	static u32 pm_family_code;
+ 	static u32 pm_sub_family_code;
  	int ret;
  
  	/* Check is family or sub-family code already received */
*************** EXPORT_SYMBOL_GPL(zynqmp_pm_get_family_i
*** 494,502 ****
   *
   * Return: Returns status, either success or error+reason
   */
! static int zynqmp_pm_get_trustzone_version(u32 *version)
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
  	int ret;
  
  	if (!version)
--- 144,153 ----
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_get_trustzone_version(u32 *version)
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
+ 	static u32 pm_tz_version;
  	int ret;
  
  	if (!version)
*************** static int zynqmp_pm_get_trustzone_versi
*** 512,547 ****
  
  	return ret;
  }
! 
! /**
!  * get_set_conduit_method() - Choose SMC or HVC based communication
!  * @np:		Pointer to the device_node structure
!  *
!  * Use SMC or HVC-based functions to communicate with EL2/EL3.
!  *
!  * Return: Returns 0 on success or error code
!  */
! static int get_set_conduit_method(struct device_node *np)
! {
! 	const char *method;
! 
! 	if (of_property_read_string(np, "method", &method)) {
! 		pr_warn("%s missing \"method\" property\n", __func__);
! 		return -ENXIO;
! 	}
! 
! 	if (!strcmp("hvc", method)) {
! 		do_fw_call = do_fw_call_hvc;
! 	} else if (!strcmp("smc", method)) {
! 		do_fw_call = do_fw_call_smc;
! 	} else {
! 		pr_warn("%s Invalid \"method\" property: %s\n",
! 			__func__, method);
! 		return -EINVAL;
! 	}
! 
! 	return 0;
! }
  
  /**
   * zynqmp_pm_query_data() - Get query data from firmware
--- 163,169 ----
  
  	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_get_trustzone_version);
  
  /**
   * zynqmp_pm_query_data() - Get query data from firmware
*************** static int get_set_conduit_method(struct
*** 552,561 ****
   */
  int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
  {
! 	int ret;
  
! 	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid, qdata.arg1, qdata.arg2,
! 				  qdata.arg3);
  
  	/*
  	 * For clock name query, all bytes in SMC response are clock name
--- 174,213 ----
   */
  int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out)
  {
! 	int ret, i = 0;
! 	u32 sip_svc_version;
! 	u32 ret_payload[PAYLOAD_ARG_CNT] = {0};
! 
! 	/* Get SiP SVC version number */
! 	ret = zynqmp_pm_get_sip_svc_version(&sip_svc_version);
! 	if (ret)
! 		return ret;
  
! 	if (sip_svc_version >= SIP_SVC_PASSTHROUGH_VERSION) {
! 		ret = zynqmp_pm_fw_call_extended(PM_QUERY_DATA, ret_payload, 4,
! 						 qdata.qid, qdata.arg1,
! 						 qdata.arg2, qdata.arg3);
! 		/* To support backward compatibility */
! 		if (!ret && !ret_payload[0]) {
! 			/*
! 			 * TF-A passes return status on 0th index but
! 			 * api to get clock name reads data from 0th
! 			 * index so pass data at 0th index instead of
! 			 * return status
! 			 */
! 			if (qdata.qid == PM_QID_CLOCK_GET_NAME ||
! 			    qdata.qid == PM_QID_PINCTRL_GET_FUNCTION_NAME)
! 				i = 1;
! 
! 			for (; i < PAYLOAD_ARG_CNT; i++, out++)
! 				*out = ret_payload[i];
! 
! 			return ret;
! 		}
! 	}
! 
! 	ret = zynqmp_pm_invoke_fn(PM_QUERY_DATA, out, 4, qdata.qid,
! 				  qdata.arg1, qdata.arg2, qdata.arg3);
  
  	/*
  	 * For clock name query, all bytes in SMC response are clock name
*************** int zynqmp_pm_set_tapdelay_bypass(u32 in
*** 898,903 ****
--- 550,574 ----
  }
  EXPORT_SYMBOL_GPL(zynqmp_pm_set_tapdelay_bypass);
  
+ int zynqmp_pm_usb_set_state(u32 node, u32 state, u32 value)
+ {
+ 	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_USB_SET_STATE,
+ 				   state, value);
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_usb_set_state);
+ 
+ int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+ {
+ 	return zynqmp_pm_invoke_fn(PM_IOCTL, reset_reason, 2, 0, IOCTL_GET_LAST_RESET_REASON);
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_get_last_reset_reason);
+ 
+ int zynqmp_pm_afi(u32 index, u32 value)
+ {
+ 	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, 0, IOCTL_AFI, index, value);
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_afi);
+ 
  /**
   * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
   * @value:	Status value to be written
*************** int zynqmp_pm_set_boot_health_status(u32
*** 913,1031 ****
  }
  
  /**
!  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
!  * @reset:		Reset to be configured
!  * @assert_flag:	Flag stating should reset be asserted (1) or
!  *			released (0)
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
! 			   const enum zynqmp_pm_reset_action assert_flag)
  {
! 	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
! }
! EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
  
! /**
!  * zynqmp_pm_reset_get_status - Get status of the reset
!  * @reset:      Reset whose status should be returned
!  * @status:     Returned status
!  *
!  * Return: Returns status, either success or error+reason
!  */
! int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status)
! {
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
! 	int ret;
! 
! 	if (!status)
! 		return -EINVAL;
! 
! 	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, ret_payload, 1, reset);
! 	*status = ret_payload[1];
! 
! 	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
  
  /**
!  * zynqmp_pm_fpga_load - Perform the fpga load
!  * @address:	Address to write to
!  * @size:	pl bitstream size
!  * @flags:	Bitstream type
!  *	-XILINX_ZYNQMP_PM_FPGA_FULL:  FPGA full reconfiguration
!  *	-XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
!  *
!  * This function provides access to pmufw. To transfer
!  * the required bitstream into PL.
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
  {
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
! 	int ret;
! 
! 	ret = zynqmp_pm_invoke_fn(PM_FPGA_LOAD, ret_payload, 4, lower_32_bits(address),
! 				  upper_32_bits(address), size, flags);
! 	if (ret_payload[0])
! 		return -ret_payload[0];
! 
! 	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
  
  /**
!  * zynqmp_pm_fpga_get_status - Read value from PCAP status register
!  * @value: Value to read
!  *
!  * This function provides access to the pmufw to get the PCAP
!  * status
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_fpga_get_status(u32 *value)
  {
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
! 	int ret;
! 
! 	if (!value)
! 		return -EINVAL;
! 
! 	ret = zynqmp_pm_invoke_fn(PM_FPGA_GET_STATUS, ret_payload, 0);
! 	*value = ret_payload[1];
! 
! 	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
  
  /**
!  * zynqmp_pm_fpga_get_config_status - Get the FPGA configuration status.
!  * @value: Buffer to store FPGA configuration status.
!  *
!  * This function provides access to the pmufw to get the FPGA configuration
!  * status
   *
!  * Return: 0 on success, a negative value on error
   */
! int zynqmp_pm_fpga_get_config_status(u32 *value)
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
  	int ret;
  
! 	if (!value)
  		return -EINVAL;
  
! 	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, ret_payload, 4,
! 				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, 0, 0,
! 				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG);
! 
! 	*value = ret_payload[1];
  
  	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
  
  /**
   * zynqmp_pm_pinctrl_request - Request Pin from firmware
--- 584,660 ----
  }
  
  /**
!  * zynqmp_pm_aie_operation - AI engine run time operations
!  * @node:	AI engine node id
!  * @start_col:	Starting column of AI partition
!  * @num_col:	Number of column in AI partition
!  * @operation:	ORed value of operations
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_aie_operation(u32 node, u16 start_col, u16 num_col, u32 operation)
  {
! 	u32 partition;
  
! 	partition = num_col;
! 	partition = ((partition << 16U) | start_col);
! 	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 4, node, IOCTL_AIE_OPS,
! 				   partition, operation);
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_aie_operation);
  
  /**
!  * versal2_pm_aie2ps_operation - AIE2PS run time operations
!  * @node:	AI engine node id
!  * @size:	Size of the DMA addr
!  * @addr_high:	higher 32 bits of DMA addr
!  * @addr_low:	lower 32 bits of DMA addr
   *
   * Return: Returns status, either success or error+reason
   */
! int versal2_pm_aie2ps_operation(u32 node, u32 size, u32 addr_high, u32 addr_low)
  {
! 	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 5, node, IOCTL_AIE2PS_OPS,
! 				   size, addr_high, addr_low);
  }
! EXPORT_SYMBOL_GPL(versal2_pm_aie2ps_operation);
  
  /**
!  * zynqmp_pm_reset_assert - Request setting of reset (1 - assert, 0 - release)
!  * @reset:		Reset to be configured
!  * @assert_flag:	Flag stating should reset be asserted (1) or
!  *			released (0)
   *
   * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_reset_assert(const u32 reset,
! 			   const enum zynqmp_pm_reset_action assert_flag)
  {
! 	return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset, assert_flag);
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
  
  /**
!  * zynqmp_pm_reset_get_status - Get status of the reset
!  * @reset:      Reset whose status should be returned
!  * @status:     Returned status
   *
!  * Return: Returns status, either success or error+reason
   */
! int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
  {
  	u32 ret_payload[PAYLOAD_ARG_CNT];
  	int ret;
  
! 	if (!status)
  		return -EINVAL;
  
! 	ret = zynqmp_pm_invoke_fn(PM_RESET_GET_STATUS, ret_payload, 1, reset);
! 	*status = ret_payload[1];
  
  	return ret;
  }
! EXPORT_SYMBOL_GPL(zynqmp_pm_reset_get_status);
  
  /**
   * zynqmp_pm_pinctrl_request - Request Pin from firmware
*************** EXPORT_SYMBOL_GPL(zynqmp_pm_pinctrl_get_
*** 1109,1121 ****
  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
  				 u32 value)
  {
  	int ret;
  
  	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
  	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
  		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
! 		if (ret < PM_PINCTRL_PARAM_SET_VERSION)
  			return -EOPNOTSUPP;
  	}
  
  	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);
--- 738,760 ----
  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
  				 u32 value)
  {
+ 	u32 pm_family_code;
+ 	u32 pm_sub_family_code;
  	int ret;
  
+ 	/* Get the Family code and sub family code of platform */
+ 	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
+ 	if (ret < 0)
+ 		return ret;
+ 
  	if (pm_family_code == ZYNQMP_FAMILY_CODE &&
  	    param == PM_PINCTRL_CONFIG_TRI_STATE) {
  		ret = zynqmp_pm_feature(PM_PINCTRL_CONFIG_PARAM_SET);
! 		if (ret < PM_PINCTRL_PARAM_SET_VERSION) {
! 			pr_warn("The requested pinctrl feature is not supported in the current firmware.\n"
! 				"Expected firmware version is 2023.1 and above for this feature to work.\r\n");
  			return -EOPNOTSUPP;
+ 		}
  	}
  
  	return zynqmp_pm_invoke_fn(PM_PINCTRL_CONFIG_PARAM_SET, NULL, 3, pin, param, value);
*************** int zynqmp_pm_init_finalize(void)
*** 1176,1181 ****
--- 815,841 ----
  EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
  
  /**
+  * zynqmp_pm_config_reg_access - PM Config API for Config register access
+  * @register_access_id:	ID of the requested REGISTER_ACCESS
+  * @address:		Address of the register to be accessed
+  * @mask:		Mask to be written to the register
+  * @value:		Value to be written to the register
+  * @out:		Returned output value
+  *
+  * This function calls REGISTER_ACCESS to configure CSU/PMU registers.
+  *
+  * Return:	Returns status, either success or error+reason
+  */
+ int zynqmp_pm_config_reg_access(u32 register_access_id, u32 address,
+ 				u32 mask, u32 value, u32 *out)
+ {
+ 	return zynqmp_pm_invoke_fn(PM_REGISTER_ACCESS, out, 4,
+ 				   register_access_id,
+ 				   address, mask, value);
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_config_reg_access);
+ 
+ /**
   * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
   * @mode:	Mode to set for system suspend
   *
*************** int zynqmp_pm_set_tcm_config(u32 node_id
*** 1284,1289 ****
--- 944,988 ----
  EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
  
  /**
+  * zynqmp_pm_get_node_status - PM call to request a node's current power state
+  * @node:		ID of the component or sub-system in question
+  * @status:		Current operating state of the requested node
+  * @requirements:	Current requirements asserted on the node,
+  *			used for slave nodes only.
+  * @usage:		Usage information, used for slave nodes only:
+  *			PM_USAGE_NO_MASTER	- No master is currently using
+  *						  the node
+  *			PM_USAGE_CURRENT_MASTER	- Only requesting master is
+  *						  currently using the node
+  *			PM_USAGE_OTHER_MASTER	- Only other masters are
+  *						  currently using the node
+  *			PM_USAGE_BOTH_MASTERS	- Both the current and at least
+  *						  one other master is currently
+  *						  using the node
+  *
+  * Return:		Returns status, either success or error+reason
+  */
+ int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
+ 			      u32 *const requirements, u32 *const usage)
+ {
+ 	u32 ret_payload[PAYLOAD_ARG_CNT];
+ 	int ret;
+ 
+ 	if (!status || !requirements || !usage)
+ 		return -EINVAL;
+ 
+ 	ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, ret_payload, 1, node);
+ 	if (ret_payload[0] == XST_PM_SUCCESS) {
+ 		*status = ret_payload[1];
+ 		*requirements = ret_payload[2];
+ 		*usage = ret_payload[3];
+ 	}
+ 
+ 	return ret;
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_get_node_status);
+ 
+ /**
   * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
   *             be powered down forcefully
   * @node:  Node ID of the targeted PU or subsystem
*************** int zynqmp_pm_set_requirement(const u32
*** 1339,1433 ****
  EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
  
  /**
-  * zynqmp_pm_load_pdi - Load and process PDI
-  * @src:	Source device where PDI is located
-  * @address:	PDI src address
-  *
-  * This function provides support to load PDI from linux
-  *
-  * Return: Returns status, either success or error+reason
-  */
- int zynqmp_pm_load_pdi(const u32 src, const u64 address)
- {
- 	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, NULL, 3, src, lower_32_bits(address),
- 				   upper_32_bits(address));
- }
- EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
- 
- /**
-  * zynqmp_pm_aes_engine - Access AES hardware to encrypt/decrypt the data using
-  * AES-GCM core.
-  * @address:	Address of the AesParams structure.
-  * @out:	Returned output value
-  *
-  * Return:	Returns status, either success or error code.
-  */
- int zynqmp_pm_aes_engine(const u64 address, u32 *out)
- {
- 	u32 ret_payload[PAYLOAD_ARG_CNT];
- 	int ret;
- 
- 	if (!out)
- 		return -EINVAL;
- 
- 	ret = zynqmp_pm_invoke_fn(PM_SECURE_AES, ret_payload, 2, upper_32_bits(address),
- 				  lower_32_bits(address));
- 	*out = ret_payload[1];
- 
- 	return ret;
- }
- EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
- 
- /**
-  * zynqmp_pm_efuse_access - Provides access to efuse memory.
-  * @address:	Address of the efuse params structure
-  * @out:		Returned output value
-  *
-  * Return:	Returns status, either success or error code.
-  */
- int zynqmp_pm_efuse_access(const u64 address, u32 *out)
- {
- 	u32 ret_payload[PAYLOAD_ARG_CNT];
- 	int ret;
- 
- 	if (!out)
- 		return -EINVAL;
- 
- 	ret = zynqmp_pm_invoke_fn(PM_EFUSE_ACCESS, ret_payload, 2,
- 				  upper_32_bits(address),
- 				  lower_32_bits(address));
- 	*out = ret_payload[1];
- 
- 	return ret;
- }
- EXPORT_SYMBOL_GPL(zynqmp_pm_efuse_access);
- 
- /**
-  * zynqmp_pm_sha_hash - Access the SHA engine to calculate the hash
-  * @address:	Address of the data/ Address of output buffer where
-  *		hash should be stored.
-  * @size:	Size of the data.
-  * @flags:
-  *	BIT(0) - for initializing csudma driver and SHA3(Here address
-  *		 and size inputs can be NULL).
-  *	BIT(1) - to call Sha3_Update API which can be called multiple
-  *		 times when data is not contiguous.
-  *	BIT(2) - to get final hash of the whole updated data.
-  *		 Hash will be overwritten at provided address with
-  *		 48 bytes.
-  *
-  * Return:	Returns status, either success or error code.
-  */
- int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags)
- {
- 	u32 lower_addr = lower_32_bits(address);
- 	u32 upper_addr = upper_32_bits(address);
- 
- 	return zynqmp_pm_invoke_fn(PM_SECURE_SHA, NULL, 4, upper_addr, lower_addr, size, flags);
- }
- EXPORT_SYMBOL_GPL(zynqmp_pm_sha_hash);
- 
- /**
   * zynqmp_pm_register_notifier() - PM API for register a subsystem
   *                                to be notified about specific
   *                                event/error.
--- 1038,1043 ----
*************** int zynqmp_pm_get_feature_config(enum pm
*** 1487,1492 ****
--- 1097,1174 ----
  }
  
  /**
+  * zynqmp_pm_sec_read_reg - PM call to securely read from given offset
+  *		of the node
+  * @node_id:	Node Id of the device
+  * @offset:	Offset to be used (20-bit)
+  * @ret_value:	Output data read from the given offset after
+  *		firmware access policy is successfully enforced
+  *
+  * Return:	Returns 0 on success or error value on failure
+  */
+ int zynqmp_pm_sec_read_reg(u32 node_id, u32 offset, u32 *ret_value)
+ {
+ 	u32 ret_payload[PAYLOAD_ARG_CNT];
+ 	u32 count = 1;
+ 	int ret;
+ 
+ 	if (!ret_value)
+ 		return -EINVAL;
+ 
+ 	ret = zynqmp_pm_invoke_fn(PM_IOCTL, ret_payload, 4, node_id, IOCTL_READ_REG,
+ 				  offset, count);
+ 
+ 	*ret_value = ret_payload[1];
+ 
+ 	return ret;
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_sec_read_reg);
+ 
+ /**
+  * zynqmp_pm_sec_mask_write_reg - PM call to securely write to given offset
+  *		of the node
+  * @node_id:	Node Id of the device
+  * @offset:	Offset to be used (20-bit)
+  * @mask:	Mask to be used
+  * @value:	Value to be written
+  *
+  * Return:	Returns 0 on success or error value on failure
+  */
+ int zynqmp_pm_sec_mask_write_reg(const u32 node_id, const u32 offset, u32 mask,
+ 				 u32 value)
+ {
+ 	return zynqmp_pm_invoke_fn(PM_IOCTL, NULL, 5, node_id, IOCTL_MASK_WRITE_REG,
+ 				   offset, mask, value);
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_sec_mask_write_reg);
+ 
+ /**
+  * zynqmp_pm_get_qos - PM call to query default and current QoS of the node
+  * @node:	Node Id of the device
+  * @def_qos:	Default QoS value
+  * @qos:	Current QoS value
+  *
+  * Return:	Returns 0 on success and the default and current QoS registers in
+  *		@def_qos and @qos or error value on failure
+  */
+ int zynqmp_pm_get_qos(u32 node, u32 *const def_qos, u32 *const qos)
+ {
+ 	u32 ret_payload[PAYLOAD_ARG_CNT];
+ 	int ret;
+ 
+ 	if (!def_qos || !qos)
+ 		return -EINVAL;
+ 
+ 	ret = zynqmp_pm_invoke_fn(PM_IOCTL, ret_payload, 2, node, IOCTL_GET_QOS);
+ 
+ 	*def_qos = ret_payload[1];
+ 	*qos = ret_payload[2];
+ 
+ 	return ret;
+ }
+ EXPORT_SYMBOL_GPL(zynqmp_pm_get_qos);
+ 
+ /**
   * zynqmp_pm_set_sd_config - PM call to set value of SD config registers
   * @node:	SD node ID
   * @config:	The config type of SD registers
*************** static ssize_t feature_config_value_stor
*** 1855,1861 ****
  
  static DEVICE_ATTR_RW(feature_config_value);
  
! static struct attribute *zynqmp_firmware_attrs[] = {
  	&dev_attr_ggs0.attr,
  	&dev_attr_ggs1.attr,
  	&dev_attr_ggs2.attr,
--- 1537,1578 ----
  
  static DEVICE_ATTR_RW(feature_config_value);
  
! static ssize_t last_reset_reason_show(struct device *device,
! 				      struct device_attribute *attr,
! 				      char *buf)
! {
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
! 	int ret;
! 
! 	ret = zynqmp_pm_get_last_reset_reason(ret_payload);
! 	if (ret)
! 		return ret;
! 
! 	switch (ret_payload[1]) {
! 	case PM_RESET_REASON_EXT_POR:
! 		return sprintf(buf, "ext_por\n");
! 	case PM_RESET_REASON_SW_POR:
! 		return sprintf(buf, "sw_por\n");
! 	case PM_RESET_REASON_SLR_POR:
! 		return sprintf(buf, "slr_por\n");
! 	case PM_RESET_REASON_ERR_POR:
! 		return sprintf(buf, "err_por\n");
! 	case PM_RESET_REASON_DAP_SRST:
! 		return sprintf(buf, "dap_srst\n");
! 	case PM_RESET_REASON_ERR_SRST:
! 		return sprintf(buf, "err_srst\n");
! 	case PM_RESET_REASON_SW_SRST:
! 		return sprintf(buf, "sw_srst\n");
! 	case PM_RESET_REASON_SLR_SRST:
! 		return sprintf(buf, "slr_srst\n");
! 	default:
! 		return sprintf(buf, "unknown reset\n");
! 	}
! }
! 
! static DEVICE_ATTR_RO(last_reset_reason);
! 
! static const struct attribute *zynqmp_firmware_attrs[] = {
  	&dev_attr_ggs0.attr,
  	&dev_attr_ggs1.attr,
  	&dev_attr_ggs2.attr,
*************** static struct attribute *zynqmp_firmware
*** 1868,1984 ****
  	&dev_attr_health_status.attr,
  	&dev_attr_feature_config_id.attr,
  	&dev_attr_feature_config_value.attr,
  	NULL,
  };
  
! ATTRIBUTE_GROUPS(zynqmp_firmware);
! 
! static int zynqmp_firmware_probe(struct platform_device *pdev)
  {
! 	struct device *dev = &pdev->dev;
! 	struct zynqmp_devinfo *devinfo;
  	int ret;
  
! 	ret = get_set_conduit_method(dev->of_node);
! 	if (ret)
! 		return ret;
! 
! 	ret = do_feature_check_call(PM_FEATURE_CHECK);
! 	if (ret >= 0 && ((ret & FIRMWARE_VERSION_MASK) >= PM_API_VERSION_1))
! 		feature_check_enabled = true;
! 
! 	devinfo = devm_kzalloc(dev, sizeof(*devinfo), GFP_KERNEL);
! 	if (!devinfo)
  		return -ENOMEM;
  
! 	devinfo->dev = dev;
  
! 	platform_set_drvdata(pdev, devinfo);
  
! 	/* Check PM API version number */
! 	ret = zynqmp_pm_get_api_version(&pm_api_version);
! 	if (ret)
! 		return ret;
  
! 	if (pm_api_version < ZYNQMP_PM_VERSION) {
! 		panic("%s Platform Management API version error. Expected: v%d.%d - Found: v%d.%d\n",
! 		      __func__,
! 		      ZYNQMP_PM_VERSION_MAJOR, ZYNQMP_PM_VERSION_MINOR,
! 		      pm_api_version >> 16, pm_api_version & 0xFFFF);
  	}
  
! 	pr_info("%s Platform Management API v%d.%d\n", __func__,
! 		pm_api_version >> 16, pm_api_version & 0xFFFF);
  
! 	/* Get the Family code and sub family code of platform */
! 	ret = zynqmp_pm_get_family_info(&pm_family_code, &pm_sub_family_code);
! 	if (ret < 0)
  		return ret;
  
! 	/* Check trustzone version number */
! 	ret = zynqmp_pm_get_trustzone_version(&pm_tz_version);
! 	if (ret)
! 		panic("Legacy trustzone found without version support\n");
  
! 	if (pm_tz_version < ZYNQMP_TZ_VERSION)
! 		panic("%s Trustzone version error. Expected: v%d.%d - Found: v%d.%d\n",
! 		      __func__,
! 		      ZYNQMP_TZ_VERSION_MAJOR, ZYNQMP_TZ_VERSION_MINOR,
! 		      pm_tz_version >> 16, pm_tz_version & 0xFFFF);
  
! 	pr_info("%s Trustzone version v%d.%d\n", __func__,
! 		pm_tz_version >> 16, pm_tz_version & 0xFFFF);
  
! 	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, firmware_devs,
! 			      ARRAY_SIZE(firmware_devs), NULL, 0, NULL);
! 	if (ret) {
! 		dev_err(&pdev->dev, "failed to add MFD devices %d\n", ret);
! 		return ret;
! 	}
  
! 	zynqmp_pm_api_debugfs_init();
  
! 	if (pm_family_code == VERSAL_FAMILY_CODE) {
! 		em_dev = platform_device_register_data(&pdev->dev, "xlnx_event_manager",
! 						       -1, NULL, 0);
! 		if (IS_ERR(em_dev))
! 			dev_err_probe(&pdev->dev, PTR_ERR(em_dev), "EM register fail with error\n");
  	}
  
! 	return of_platform_populate(dev->of_node, NULL, NULL, dev);
! }
! 
! static void zynqmp_firmware_remove(struct platform_device *pdev)
! {
! 	struct pm_api_feature_data *feature_data;
! 	struct hlist_node *tmp;
! 	int i;
  
- 	mfd_remove_devices(&pdev->dev);
- 	zynqmp_pm_api_debugfs_exit();
  
! 	hash_for_each_safe(pm_api_features_map, i, tmp, feature_data, hentry) {
! 		hash_del(&feature_data->hentry);
! 		kfree(feature_data);
  	}
  
! 	platform_device_unregister(em_dev);
  }
- 
- static const struct of_device_id zynqmp_firmware_of_match[] = {
- 	{.compatible = "xlnx,zynqmp-firmware"},
- 	{.compatible = "xlnx,versal-firmware"},
- 	{},
- };
- MODULE_DEVICE_TABLE(of, zynqmp_firmware_of_match);
- 
- static struct platform_driver zynqmp_firmware_driver = {
- 	.driver = {
- 		.name = "zynqmp_firmware",
- 		.of_match_table = zynqmp_firmware_of_match,
- 		.dev_groups = zynqmp_firmware_groups,
- 	},
- 	.probe = zynqmp_firmware_probe,
- 	.remove_new = zynqmp_firmware_remove,
- };
- module_platform_driver(zynqmp_firmware_driver);
--- 1585,1752 ----
  	&dev_attr_health_status.attr,
  	&dev_attr_feature_config_id.attr,
  	&dev_attr_feature_config_value.attr,
+ 	&dev_attr_last_reset_reason.attr,
  	NULL,
  };
  
! /**
!  * config_reg_store - Write config_reg sysfs attribute
!  * @kobj:	Kobject structure
!  * @attr:	Kobject attribute structure
!  * @buf:	User entered health_status attribute string
!  * @count:	Buffer size
!  *
!  * User-space interface for setting the config register.
!  *
!  * To write any CSU/PMU register
!  * echo <address> <mask> <values> > /sys/firmware/zynqmp/config_reg
!  * Usage:
!  * echo 0x345AB234 0xFFFFFFFF 0x1234ABCD > /sys/firmware/zynqmp/config_reg
!  *
!  * To Read any CSU/PMU register, write address to the variable like below
!  * echo <address> > /sys/firmware/zynqmp/config_reg
!  *
!  * Return:	count argument if request succeeds, the corresponding error
!  *		code otherwise
!  */
! static ssize_t config_reg_store(struct kobject *kobj,
! 				struct kobj_attribute *attr,
! 				const char *buf, size_t count)
  {
! 	char *kern_buff, *inbuf, *tok;
! 	unsigned long address, value, mask;
  	int ret;
  
! 	kern_buff = kzalloc(count + 1, GFP_KERNEL);
! 	if (!kern_buff)
  		return -ENOMEM;
  
! 	ret = strscpy(kern_buff, buf, count + 1);
! 	if (ret < 0) {
! 		ret = -EFAULT;
! 		goto err;
! 	}
  
! 	inbuf = kern_buff;
  
! 	/* Read the addess */
! 	tok = strsep(&inbuf, " ");
! 	if (!tok) {
! 		ret = -EFAULT;
! 		goto err;
! 	}
! 	ret = kstrtol(tok, 16, &address);
! 	if (ret) {
! 		ret = -EFAULT;
! 		goto err;
! 	}
! 	/* Read the write value */
! 	tok = strsep(&inbuf, " ");
! 	/*
! 	 * If parameter provided is only address, then its a read operation.
! 	 * Store the address in a global variable and retrieve whenever
! 	 * required.
! 	 */
! 	if (!tok) {
! 		register_address = address;
! 		goto err;
! 	}
! 	register_address = address;
  
! 	ret = kstrtol(tok, 16, &mask);
! 	if (ret) {
! 		ret = -EFAULT;
! 		goto err;
! 	}
! 	tok = strsep(&inbuf, " ");
! 	if (!tok) {
! 		ret = -EFAULT;
! 		goto err;
! 	}
! 	ret = kstrtol(tok, 16, &value);
! 	if (ret) {
! 		ret = -EFAULT;
! 		goto err;
  	}
+ 	ret = zynqmp_pm_config_reg_access(CONFIG_REG_WRITE, address,
+ 					  mask, value, NULL);
+ 	if (ret)
+ 		pr_err("unable to write value to %lx\n", value);
+ err:
+ 	kfree(kern_buff);
+ 	if (ret)
+ 		return ret;
+ 	return count;
+ }
  
! /**
!  * config_reg_show - Read config_reg sysfs attribute
!  * @kobj:	Kobject structure
!  * @attr:	Kobject attribute structure
!  * @buf:	User entered health_status attribute string
!  *
!  * User-space interface for getting the config register.
!  *
!  * To Read any CSU/PMU register, write address to the variable like below
!  * echo <address> > /sys/firmware/zynqmp/config_reg
!  *
!  * Then Read the address using below command
!  * cat /sys/firmware/zynqmp/config_reg
!  *
!  * Return: number of chars written to buf.
!  */
! static ssize_t config_reg_show(struct kobject *kobj,
! 			       struct kobj_attribute *attr,
! 			       char *buf)
! {
! 	int ret;
! 	u32 ret_payload[PAYLOAD_ARG_CNT];
  
! 	ret = zynqmp_pm_config_reg_access(CONFIG_REG_READ, register_address,
! 					  0, 0, ret_payload);
! 	if (ret)
  		return ret;
  
! 	return sprintf(buf, "0x%x\n", ret_payload[1]);
! }
  
! static struct kobj_attribute zynqmp_attr_config_reg =
! 					__ATTR_RW(config_reg);
  
! static struct attribute *attrs[] = {
! 	&zynqmp_attr_config_reg.attr,
! 	NULL,
! };
  
! static const struct attribute_group attr_group = {
! 	.attrs = attrs,
! 	NULL,
! };
  
! int zynqmp_firmware_pm_sysfs_entry(struct platform_device *pdev)
! {
! 	struct kobject *zynqmp_kobj;
! 	int ret;
  
! 	zynqmp_kobj = kobject_create_and_add("zynqmp", firmware_kobj);
! 	if (!zynqmp_kobj) {
! 		pr_err("zynqmp: Firmware kobj add failed.\n");
! 		return -ENOMEM;
  	}
  
! 	ret = sysfs_create_group(zynqmp_kobj, &attr_group);
! 	if (ret) {
! 		pr_err("%s() sysfs creation fail with error %d\n",
! 		       __func__, ret);
! 		return ret;
! 	}
  
  
! 	ret = sysfs_create_files(&pdev->dev.kobj, zynqmp_firmware_attrs);
! 	if (ret) {
! 		pr_err("%s() Failed to create PM firmware attrs, err=%d\n",
! 		       __func__, ret);
  	}
  
! 	return ret;
  }
```

####### include/linux/firmware/xlnx-zynqmp.h

```console
shell$ diff -p linux-6.12.100/include/linux/firmware/xlnx-zynqmp.h linux-6.12.109/include/linux/firmware/xlnx-zynqmp.h
*** linux-6.12.100/include/linux/firmware/xlnx-zynqmp.h	2026-08-05 10:45:17.060950960 +0900
--- linux-6.12.109/include/linux/firmware/xlnx-zynqmp.h	2026-10-09 15:27:33.686861639 +0900
*************** enum pm_api_cb_id {
*** 143,148 ****
--- 143,149 ----
  enum pm_api_id {
  	PM_API_FEATURES = 0,
  	PM_GET_API_VERSION = 1,
+ 	PM_GET_NODE_STATUS = 3,
  	PM_REGISTER_NOTIFIER = 5,
  	PM_FORCE_POWERDOWN = 8,
  	PM_REQUEST_WAKEUP = 10,
*************** enum pm_gem_config_type {
*** 519,524 ****
--- 520,537 ----
  };
  
  /**
+  * enum pm_node_status - Device node status provided by xilpm fw
+  * @PM_NODE_UNUSED: Device is not used
+  * @PM_NODE_RUNNING: Device is power-on and out of reset
+  * @PM_NODE_HALT: Device is power-on but in the reset state
+  */
+ enum pm_node_status {
+ 	PM_NODE_UNUSED = 0,
+ 	PM_NODE_RUNNING = 1,
+ 	PM_NODE_HALT = 12,
+ };
+ 
+ /**
   * struct zynqmp_pm_query_data - PM query data
   * @qid:	query ID
   * @arg1:	Argument 1 of query data
```

```console
shell$ diff -p linux-6.12.100/include/linux/firmware/xlnx-zynqmp.h linux-6.12.100-xlnx-v2025.1/include/linux/firmware/xlnx-zynqmp.h
*** linux-6.12.100/include/linux/firmware/xlnx-zynqmp.h	2026-08-05 10:45:17.060950960 +0900
--- linux-6.12.100-xlnx-v2025.1/include/linux/firmware/xlnx-zynqmp.h	2026-08-05 11:16:15.229301053 +0900
***************
*** 3,9 ****
   * Xilinx Zynq MPSoC Firmware layer
   *
   *  Copyright (C) 2014-2021 Xilinx
!  *  Copyright (C) 2022 - 2023, Advanced Micro Devices, Inc.
   *
   *  Michal Simek <michal.simek@amd.com>
   *  Davorin Mista <davorin.mista@aggios.com>
--- 3,9 ----
   * Xilinx Zynq MPSoC Firmware layer
   *
   *  Copyright (C) 2014-2021 Xilinx
!  *  Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
   *
   *  Michal Simek <michal.simek@amd.com>
   *  Davorin Mista <davorin.mista@aggios.com>
***************
*** 16,21 ****
--- 16,26 ----
  #include <linux/types.h>
  
  #include <linux/err.h>
+ #include <linux/firmware/xlnx-zynqmp-fpga.h>
+ #include <linux/firmware/xlnx-zynqmp-nvm.h>
+ #include <linux/firmware/xlnx-zynqmp-pdi.h>
+ #include <linux/firmware/xlnx-zynqmp-secure.h>
+ #include <linux/firmware/xlnx-zynqmp-sem.h>
  
  #define ZYNQMP_PM_VERSION_MAJOR	1
  #define ZYNQMP_PM_VERSION_MINOR	0
***************
*** 32,40 ****
--- 37,59 ----
  /* SMC SIP service Call Function Identifier Prefix */
  #define PM_SIP_SVC			0xC2000000
  
+ /* SMC function ID to get SiP SVC version */
+ #define GET_SIP_SVC_VERSION	(0x8200ff03U)
+ 
+ /* SiP Service Calls version numbers */
+ #define SIP_SVC_VERSION_MAJOR		(0U)
+ #define SIP_SVC_VERSION_MINOR		(2U)
+ 
+ #define SIP_SVC_PASSTHROUGH_VERSION	((SIP_SVC_VERSION_MAJOR << 16) | \
+ 					 SIP_SVC_VERSION_MINOR)
+ 
+ /* Fixed ID for FW specific APIs */
+ #define PASS_THROUGH_FW_CMD_ID	GENMASK(11, 0)
+ 
  /* PM API versions */
  #define PM_API_VERSION_1	1
  #define PM_API_VERSION_2	2
+ #define PM_API_VERSION_3	3
  
  #define PM_PINCTRL_PARAM_SET_VERSION	2
  
***************
*** 44,56 ****
  /* When all subfamily of platform need to support */
  #define ALL_SUB_FAMILY_CODE		0x00
  #define VERSAL_SUB_FAMILY_CODE		0x01
! #define VERSALNET_SUB_FAMILY_CODE	0x03
  
  #define FAMILY_CODE_MASK	GENMASK(27, 21)
! #define SUB_FAMILY_CODE_MASK	GENMASK(20, 19)
  
  #define API_ID_MASK		GENMASK(7, 0)
  #define MODULE_ID_MASK		GENMASK(11, 8)
  
  /* Firmware feature check version mask */
  #define FIRMWARE_VERSION_MASK		0xFFFFU
--- 63,77 ----
  /* When all subfamily of platform need to support */
  #define ALL_SUB_FAMILY_CODE		0x00
  #define VERSAL_SUB_FAMILY_CODE		0x01
! #define VERSAL_SUB_FAMILY_CODE_MAX	0x04
! #define VERSALNET_OR_VERSAL2_SUB_FAMILY_CODE	0x06
  
  #define FAMILY_CODE_MASK	GENMASK(27, 21)
! #define SUB_FAMILY_CODE_MASK	GENMASK(20, 18)
  
  #define API_ID_MASK		GENMASK(7, 0)
  #define MODULE_ID_MASK		GENMASK(11, 8)
+ #define PLM_MODULE_ID_MASK	GENMASK(15, 8)
  
  /* Firmware feature check version mask */
  #define FIRMWARE_VERSION_MASK		0xFFFFU
***************
*** 62,68 ****
  #define GET_CALLBACK_DATA		0xa01
  
  /* Number of 32bits values in payload */
! #define PAYLOAD_ARG_CNT	4U
  
  /* Number of arguments for a callback */
  #define CB_ARG_CNT     4
--- 83,98 ----
  #define GET_CALLBACK_DATA		0xa01
  
  /* Number of 32bits values in payload */
! #define PAYLOAD_ARG_CNT	7U
! 
! /* Number of 64bits arguments for SMC call */
! #define SMC_ARG_CNT_64	8U
! 
! /* Number of 32bits arguments for SMC call */
! #define SMC_ARG_CNT_32	13U
! 
! /* Number of 32bits arguments for Basic SMC call */
! #define SMC_ARG_CNT_BASIC_32	14U
  
  /* Number of arguments for a callback */
  #define CB_ARG_CNT     4
***************
*** 80,139 ****
  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
  #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
  
- /* Loader commands */
- #define PM_LOAD_PDI	0x701
- #define PDI_SRC_DDR	0xF
- 
- /*
-  * Firmware FPGA Manager flags
-  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
-  * XILINX_ZYNQMP_PM_FPGA_PARTIAL: FPGA partial reconfiguration
-  */
- #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
- #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
- 
- /* FPGA Status Reg */
- #define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
- #define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
- 
- /*
-  * Node IDs for the Error Events.
-  */
- #define VERSAL_EVENT_ERROR_PMC_ERR1	(0x28100000U)
- #define VERSAL_EVENT_ERROR_PMC_ERR2	(0x28104000U)
- #define VERSAL_EVENT_ERROR_PSM_ERR1	(0x28108000U)
- #define VERSAL_EVENT_ERROR_PSM_ERR2	(0x2810C000U)
- 
- #define VERSAL_NET_EVENT_ERROR_PMC_ERR1	(0x28100000U)
- #define VERSAL_NET_EVENT_ERROR_PMC_ERR2	(0x28104000U)
- #define VERSAL_NET_EVENT_ERROR_PMC_ERR3	(0x28108000U)
- #define VERSAL_NET_EVENT_ERROR_PSM_ERR1	(0x2810C000U)
- #define VERSAL_NET_EVENT_ERROR_PSM_ERR2	(0x28110000U)
- #define VERSAL_NET_EVENT_ERROR_PSM_ERR3	(0x28114000U)
- #define VERSAL_NET_EVENT_ERROR_PSM_ERR4	(0x28118000U)
- 
  /* ZynqMP SD tap delay tuning */
  #define SD_ITAPDLY	0xFF180314
  #define SD_OTAPDLYSEL	0xFF180318
  
- /**
-  * XPM_EVENT_ERROR_MASK_DDRMC_CR: Error event mask for DDRMC MC Correctable ECC Error.
-  */
- #define XPM_EVENT_ERROR_MASK_DDRMC_CR		BIT(18)
- 
- /**
-  * XPM_EVENT_ERROR_MASK_DDRMC_NCR: Error event mask for DDRMC MC Non-Correctable ECC Error.
-  */
- #define XPM_EVENT_ERROR_MASK_DDRMC_NCR		BIT(19)
- #define XPM_EVENT_ERROR_MASK_NOC_NCR		BIT(13)
- #define XPM_EVENT_ERROR_MASK_NOC_CR		BIT(12)
- 
  enum pm_module_id {
  	PM_MODULE_ID = 0x0,
  	XSEM_MODULE_ID = 0x3,
  	TF_A_MODULE_ID = 0xa,
  };
  
  enum pm_api_cb_id {
  	PM_INIT_SUSPEND_CB = 30,
  	PM_ACKNOWLEDGE_CB = 31,
--- 110,157 ----
  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
  #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
  
  /* ZynqMP SD tap delay tuning */
  #define SD_ITAPDLY	0xFF180314
  #define SD_OTAPDLYSEL	0xFF180318
  
  enum pm_module_id {
  	PM_MODULE_ID = 0x0,
+ 	XPM_MODULE_ID = 0x2,
  	XSEM_MODULE_ID = 0x3,
  	TF_A_MODULE_ID = 0xa,
  };
  
+ /* AIE Operation */
+ enum pm_aie_operations {
+ 	XILINX_AIE_OPS_MIN = 0U,
+ 	XILINX_AIE_OPS_COL_RST = 1U,
+ 	XILINX_AIE_OPS_SHIM_RST = 2U,
+ 	XILINX_AIE_OPS_UC_ZEROIZATION = 3U,
+ 	XILINX_AIE_OPS_ENB_COL_CLK_BUFF = 4U,
+ 	XILINX_AIE_OPS_HANDSHAKE = 5U,
+ 	XILINX_AIE_OPS_CLR_HW_ERR_STS = 6U,
+ 	XILINX_AIE_OPS_START_NUM_COL = 7U,
+ 	XILINX_AIE_OPS_ZEROISATION = 8U,
+ 	XILINX_AIE_OPS_AXIMM_ISOLATION = 9U,
+ 	XILINX_AIE_OPS_NMU_CONFIG = 10U,
+ 	XILINX_AIE_OPS_DIS_MEM_PRIV = 11U,
+ 	XILINX_AIE_OPS_DIS_MEM_INTERLEAVE = 12U,
+ 	XILINX_AIE_OPS_ENB_UC_DMA_PAUSE = 13U,
+ 	XILINX_AIE_OPS_ENB_NOC_DMA_PAUSE = 14U,
+ 	XILINX_AIE_OPS_SET_ECC_SCRUB_PERIOD = 15U,
+ 	XILINX_AIE_OPS_DIS_COL_CLK_BUFF = 16U,
+ 	XILINX_AIE_OPS_HW_ERR_INT = 17U,
+ 	XILINX_AIE_OPS_HW_ERR_MASK = 18U,
+ 	XILINX_AIE_OPS_ENB_MEM_PRIV = 19U,
+ 	XILINX_AIE_OPS_CTRL_PKT_TLAST_ERR = 20U,
+ 	XILINX_AIE_OPS_ENB_AXI_MM_ERR_EVENT = 32U,     /* Backward compatibility for AIE1/AIE2 */
+ 	XILINX_AIE_OPS_SET_L2_CTRL_NPI_INTR = 64U,     /* Backward compatibility for AIE1/AIE2 */
+ 	XILINX_AIE_OPS_PROG_MEM_ZEROIZATION = 128U,    /* Backward compatibility for AIE1/AIE2 */
+ 	XILINX_AIE_OPS_DATA_MEM_ZEROIZATION = 256U,    /* Backward compatibility for AIE1/AIE2 */
+ 	XILINX_AIE_OPS_MEM_TILE_ZEROIZATION = 512U,    /* Backward compatibility for AIE1/AIE2 */
+ 	XILINX_AIE_OPS_MAX = 1023U,                    /* Backward compatibility for AIE1/AIE2 */
+ };
+ 
  enum pm_api_cb_id {
  	PM_INIT_SUSPEND_CB = 30,
  	PM_ACKNOWLEDGE_CB = 31,
*************** enum pm_api_cb_id {
*** 143,148 ****
--- 161,167 ----
  enum pm_api_id {
  	PM_API_FEATURES = 0,
  	PM_GET_API_VERSION = 1,
+ 	PM_GET_NODE_STATUS = 3,
  	PM_REGISTER_NOTIFIER = 5,
  	PM_FORCE_POWERDOWN = 8,
  	PM_REQUEST_WAKEUP = 10,
*************** enum pm_api_id {
*** 158,164 ****
--- 177,186 ----
  	PM_FPGA_LOAD = 22,
  	PM_FPGA_GET_STATUS = 23,
  	PM_GET_CHIPID = 24,
+ 	/* ID 25 is been used by U-boot to process secure boot images */
+ 	/* Secure library generic API functions */
  	PM_SECURE_SHA = 26,
+ 	PM_SECURE_RSA = 27,
  	PM_PINCTRL_REQUEST = 28,
  	PM_PINCTRL_RELEASE = 29,
  	PM_PINCTRL_SET_FUNCTION = 31,
*************** enum pm_api_id {
*** 173,182 ****
--- 195,209 ----
  	PM_CLOCK_GETDIVIDER = 40,
  	PM_CLOCK_SETPARENT = 43,
  	PM_CLOCK_GETPARENT = 44,
+ 	PM_SECURE_IMAGE = 45,
  	PM_FPGA_READ = 46,
  	PM_SECURE_AES = 47,
+ 	/* PM_REGISTER_ACCESS API */
+ 	PM_REGISTER_ACCESS = 52,
  	PM_EFUSE_ACCESS = 53,
  	PM_FEATURE_CHECK = 63,
+ 	PM_FPGA_GET_VERSION = 72,
+ 	PM_FPGA_GET_FEATURE_LIST = 73,
  };
  
  /* PMU-FW return status codes */
*************** enum pm_ioctl_id {
*** 212,226 ****
--- 239,267 ----
  	IOCTL_READ_PGGS = 15,
  	/* Set healthy bit value */
  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+ 	IOCTL_AFI = 18,
  	IOCTL_OSPI_MUX_SELECT = 21,
+ 	/* IOCTL for USB power request */
+ 	IOCTL_USB_SET_STATE = 22,
+ 	/* IOCTL to get last reset reason */
+ 	IOCTL_GET_LAST_RESET_REASON = 23,
  	/* Register SGI to ATF */
  	IOCTL_REGISTER_SGI = 25,
  	/* Runtime feature configuration */
  	IOCTL_SET_FEATURE_CONFIG = 26,
  	IOCTL_GET_FEATURE_CONFIG = 27,
+ 	/* IOCTL for Secure Read/Write Interface */
+ 	IOCTL_READ_REG = 28,
+ 	IOCTL_MASK_WRITE_REG = 29,
  	/* Dynamic SD/GEM configuration */
  	IOCTL_SET_SD_CONFIG = 30,
  	IOCTL_SET_GEM_CONFIG = 31,
+ 	/* AIE/AIEML Operations */
+ 	IOCTL_AIE_OPS = 33,
+ 	/* IOCTL to get default/current QoS */
+ 	IOCTL_GET_QOS = 34,
+ 	/* AIE2PS Operations */
+ 	IOCTL_AIE2PS_OPS = 39,
  };
  
  enum pm_query_id {
*************** enum pm_query_id {
*** 238,243 ****
--- 279,285 ----
  	PM_QID_PINCTRL_GET_PIN_GROUPS = 11,
  	PM_QID_CLOCK_GET_NUM_CLOCKS = 12,
  	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
+ 	PM_QID_PINCTRL_GET_ATTRIBUTES = 15,
  };
  
  enum rpu_oper_mode {
*************** enum ospi_mux_select_type {
*** 486,491 ****
--- 528,538 ----
  	PM_OSPI_MUX_SEL_LINEAR = 1,
  };
  
+ enum pm_register_access_id {
+ 	CONFIG_REG_WRITE = 0,
+ 	CONFIG_REG_READ = 1,
+ };
+ 
  enum pm_feature_config_id {
  	PM_FEATURE_INVALID = 0,
  	PM_FEATURE_OVERTEMP_STATUS = 1,
*************** enum pm_gem_config_type {
*** 518,523 ****
--- 565,581 ----
  	GEM_CONFIG_FIXED = 2,
  };
  
+ enum pm_reset_reason {
+ 	PM_RESET_REASON_EXT_POR = 0,
+ 	PM_RESET_REASON_SW_POR = 1,
+ 	PM_RESET_REASON_SLR_POR = 2,
+ 	PM_RESET_REASON_ERR_POR = 3,
+ 	PM_RESET_REASON_DAP_SRST = 7,
+ 	PM_RESET_REASON_ERR_SRST = 8,
+ 	PM_RESET_REASON_SW_SRST = 9,
+ 	PM_RESET_REASON_SLR_SRST = 10,
+ };
+ 
  /**
   * struct zynqmp_pm_query_data - PM query data
   * @qid:	query ID
*************** struct zynqmp_pm_query_data {
*** 532,543 ****
--- 590,616 ----
  	u32 arg3;
  };
  
+ /**
+  * struct zynqmp_devinfo - Structure for Zynqmp device instance
+  * @dev:		Device Pointer
+  * @feature_conf_id:	Feature conf id
+  */
+ struct zynqmp_devinfo {
+ 	struct device *dev;
+ 	u32 feature_conf_id;
+ };
+ 
  int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
+ int zynqmp_pm_fw_call_extended(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...);
+ int zynqmp_firmware_pm_sysfs_entry(struct platform_device *pdev);
  
  #if IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
  int zynqmp_pm_get_api_version(u32 *version);
  int zynqmp_pm_get_chipid(u32 *idcode, u32 *version);
  int zynqmp_pm_get_family_info(u32 *family, u32 *subfamily);
+ int zynqmp_pm_get_trustzone_version(u32 *version);
+ int zynqmp_pm_get_sip_svc_version(u32 *version);
+ int zynqmp_pm_load_pdi_word_swap(const u64 address, u64 *swapped_address);
  int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata, u32 *out);
  int zynqmp_pm_clock_enable(u32 clock_id);
  int zynqmp_pm_clock_disable(u32 clock_id);
*************** int zynqmp_pm_get_pll_frac_data(u32 clk_
*** 553,561 ****
  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
  int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select);
! int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
  			   const enum zynqmp_pm_reset_action assert_flag);
! int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
  unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);
  int zynqmp_pm_bootmode_write(u32 ps_mode);
  int zynqmp_pm_init_finalize(void);
--- 626,634 ----
  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
  int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select);
! int zynqmp_pm_reset_assert(const u32 reset,
  			   const enum zynqmp_pm_reset_action assert_flag);
! int zynqmp_pm_reset_get_status(const u32 reset, u32 *status);
  unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);
  int zynqmp_pm_bootmode_write(u32 ps_mode);
  int zynqmp_pm_init_finalize(void);
*************** int zynqmp_pm_release_node(const u32 nod
*** 566,582 ****
  int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
  			      const u32 qos,
  			      const enum zynqmp_pm_request_ack ack);
! int zynqmp_pm_aes_engine(const u64 address, u32 *out);
! int zynqmp_pm_efuse_access(const u64 address, u32 *out);
! int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
! int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
! int zynqmp_pm_fpga_get_status(u32 *value);
! int zynqmp_pm_fpga_get_config_status(u32 *value);
  int zynqmp_pm_write_ggs(u32 index, u32 value);
  int zynqmp_pm_read_ggs(u32 index, u32 *value);
  int zynqmp_pm_write_pggs(u32 index, u32 value);
  int zynqmp_pm_read_pggs(u32 index, u32 *value);
  int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value);
  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
  int zynqmp_pm_set_boot_health_status(u32 value);
  int zynqmp_pm_pinctrl_request(const u32 pin);
--- 639,653 ----
  int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
  			      const u32 qos,
  			      const enum zynqmp_pm_request_ack ack);
! int zynqmp_pm_config_reg_access(u32 register_access_id, u32 address, u32 mask,
! 				u32 value, u32 *out);
  int zynqmp_pm_write_ggs(u32 index, u32 value);
  int zynqmp_pm_read_ggs(u32 index, u32 *value);
  int zynqmp_pm_write_pggs(u32 index, u32 value);
  int zynqmp_pm_read_pggs(u32 index, u32 *value);
  int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value);
+ int zynqmp_pm_afi(u32 index, u32 value);
+ int zynqmp_pm_usb_set_state(u32 node, u32 state, u32 value);
  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
  int zynqmp_pm_set_boot_health_status(u32 value);
  int zynqmp_pm_pinctrl_request(const u32 pin);
*************** int zynqmp_pm_pinctrl_get_config(const u
*** 586,598 ****
  				 u32 *value);
  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
  				 u32 value);
- int zynqmp_pm_load_pdi(const u32 src, const u64 address);
  int zynqmp_pm_register_notifier(const u32 node, const u32 event,
  				const u32 wake, const u32 enable);
  int zynqmp_pm_feature(const u32 api_id);
  int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
  int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
  int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
  int zynqmp_pm_force_pwrdwn(const u32 target,
  			   const enum zynqmp_pm_request_ack ack);
--- 657,671 ----
  				 u32 *value);
  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
  				 u32 value);
  int zynqmp_pm_register_notifier(const u32 node, const u32 event,
  				const u32 wake, const u32 enable);
  int zynqmp_pm_feature(const u32 api_id);
  int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
  int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
  int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+ int zynqmp_pm_sec_read_reg(u32 node_id, u32 offset, u32 *ret_value);
+ int zynqmp_pm_sec_mask_write_reg(const u32 node_id, const u32 offset,
+ 				 u32 mask, u32 value);
  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
  int zynqmp_pm_force_pwrdwn(const u32 target,
  			   const enum zynqmp_pm_request_ack ack);
*************** int zynqmp_pm_request_wake(const u32 nod
*** 603,611 ****
--- 676,690 ----
  int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
  int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode);
  int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode);
+ int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
+ 			      u32 *const requirements, u32 *const usage);
  int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
  int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
  			     u32 value);
+ int zynqmp_pm_get_last_reset_reason(u32 *reset_reason);
+ int zynqmp_pm_aie_operation(u32 node, u16 start_col, u16 num_col, u32 operation);
+ int zynqmp_pm_get_qos(u32 node, u32 *const def_qos, u32 *const qos);
+ int versal2_pm_aie2ps_operation(u32 node, u32 size, u32 addr_high, u32 addr_low);
  #else
  static inline int zynqmp_pm_get_api_version(u32 *version)
  {
*************** static inline int zynqmp_pm_get_family_i
*** 622,627 ****
--- 701,716 ----
  	return -ENODEV;
  }
  
+ static inline int zynqmp_pm_get_trustzone_version(u32 *version)
+ {
+ 	return -ENODEV;
+ }
+ 
+ static inline int zynqmp_pm_get_sip_svc_version(u32 *version)
+ {
+ 	return -ENODEV;
+ }
+ 
  static inline int zynqmp_pm_query_data(struct zynqmp_pm_query_data qdata,
  				       u32 *out)
  {
*************** static inline int zynqmp_pm_ospi_mux_sel
*** 698,711 ****
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
  					 const enum zynqmp_pm_reset_action assert_flag)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
! 					     u32 *status)
  {
  	return -ENODEV;
  }
--- 787,799 ----
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_reset_assert(const u32 reset,
  					 const enum zynqmp_pm_reset_action assert_flag)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
  {
  	return -ENODEV;
  }
*************** static inline int zynqmp_pm_set_requirem
*** 750,808 ****
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_aes_engine(const u64 address, u32 *out)
! {
! 	return -ENODEV;
! }
! 
! static inline int zynqmp_pm_efuse_access(const u64 address, u32 *out)
! {
! 	return -ENODEV;
! }
! 
! static inline int zynqmp_pm_sha_hash(const u64 address, const u32 size,
! 				     const u32 flags)
! {
! 	return -ENODEV;
! }
! 
! static inline int zynqmp_pm_fpga_load(const u64 address, const u32 size,
! 				      const u32 flags)
! {
! 	return -ENODEV;
! }
! 
! static inline int zynqmp_pm_fpga_get_status(u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_fpga_get_config_status(u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_write_ggs(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_read_ggs(u32 index, u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_write_pggs(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
  {
  	return -ENODEV;
  }
--- 838,874 ----
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_write_ggs(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_read_ggs(u32 index, u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_write_pggs(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_read_pggs(u32 index, u32 *value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_set_tapdelay_bypass(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_afi(u32 index, u32 value)
  {
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_usb_set_state(u32 node, u32 state, u32 value)
  {
  	return -ENODEV;
  }
*************** static inline int zynqmp_pm_pinctrl_set_
*** 849,855 ****
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
  {
  	return -ENODEV;
  }
--- 915,923 ----
  	return -ENODEV;
  }
  
! static inline int zynqmp_pm_config_reg_access(u32 register_access_id,
! 					      u32 address, u32 mask, u32 value,
! 					      u32 *out)
  {
  	return -ENODEV;
  }
*************** static inline int zynqmp_pm_request_wake
*** 896,901 ****
--- 964,980 ----
  	return -ENODEV;
  }
  
+ static inline int zynqmp_pm_sec_read_reg(u32 node_id, u32 offset, u32 *ret_value)
+ {
+ 	return -ENODEV;
+ }
+ 
+ static inline int zynqmp_pm_sec_mask_write_reg(const u32 node_id, const u32 offset,
+ 					       u32 mask, u32 value)
+ {
+ 	return -ENODEV;
+ }
+ 
  static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
  {
  	return -ENODEV;
*************** static inline int zynqmp_pm_set_tcm_conf
*** 911,916 ****
--- 990,1002 ----
  	return -ENODEV;
  }
  
+ static inline int zynqmp_pm_get_node_status(const u32 node, u32 *const status,
+ 					    u32 *const requirements,
+ 					    u32 *const usage)
+ {
+ 	return -ENODEV;
+ }
+ 
  static inline int zynqmp_pm_set_sd_config(u32 node,
  					  enum pm_sd_config_type config,
  					  u32 value)
*************** static inline int zynqmp_pm_set_sd_confi
*** 918,923 ****
--- 1004,1014 ----
  	return -ENODEV;
  }
  
+ static inline int zynqmp_pm_get_qos(u32 node, u32 *const def_qos, u32 *const qos)
+ {
+ 	return -ENODEV;
+ }
+ 
  static inline int zynqmp_pm_set_gem_config(u32 node,
  					   enum pm_gem_config_type config,
  					   u32 value)
*************** static inline int zynqmp_pm_set_gem_conf
*** 925,930 ****
--- 1016,1037 ----
  	return -ENODEV;
  }
  
+ static inline int zynqmp_pm_get_last_reset_reason(u32 *reset_reason)
+ {
+ 	return -ENODEV;
+ }
+ 
+ static inline int zynqmp_pm_aie_operation(u32 node, u16 start_col,
+ 					  u16 num_col, u32 operation)
+ {
+ 	return -ENODEV;
+ }
+ 
+ static inline int versal2_pm_aie2ps_operation(u32 node, u32 size, u32 addr_high,
+ 					      u32 addr_low)
+ {
+ 	return -ENODEV;
+ }
  #endif
  
  #endif /* __FIRMWARE_ZYNQMP_H__ */
```

####### Make 207_drivers-firmware.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/207_drivers-firmware.patch
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
Hunk #4 FAILED at 37.
Hunk #5 succeeded at 413 (offset 1 line).
Hunk #6 succeeded at 466 (offset 1 line).
Hunk #7 succeeded at 497 (offset 1 line).
Hunk #8 succeeded at 516 (offset 1 line).
Hunk #9 succeeded at 527 (offset 1 line).
Hunk #10 succeeded at 903 (offset 1 line).
Hunk #11 succeeded at 937 (offset 1 line).
Hunk #12 succeeded at 1091 (offset 1 line).
Hunk #13 succeeded at 1167 (offset 1 line).
Hunk #14 succeeded at 1296 (offset 1 line).
Hunk #15 succeeded at 1390 (offset 1 line).
Hunk #16 succeeded at 1449 (offset 1 line).
Hunk #17 succeeded at 1890 (offset 1 line).
Hunk #18 succeeded at 1938 (offset 1 line).
1 out of 18 hunks FAILED -- saving rejects to file drivers/firmware/xilinx/zynqmp-pm.c.rej
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
Hunk #7 FAILED at 161.
Hunk #8 succeeded at 177 (offset 1 line).
Hunk #9 succeeded at 195 (offset 1 line).
Hunk #10 succeeded at 239 (offset 1 line).
Hunk #11 succeeded at 279 (offset 1 line).
Hunk #12 succeeded at 528 (offset 1 line).
Hunk #13 succeeded at 577 with fuzz 1 (offset 13 lines).
Hunk #14 succeeded at 602 (offset 13 lines).
Hunk #15 succeeded at 638 (offset 13 lines).
Hunk #16 succeeded at 651 (offset 13 lines).
Hunk #17 succeeded at 669 (offset 13 lines).
Hunk #18 succeeded at 688 (offset 13 lines).
Hunk #19 succeeded at 713 (offset 13 lines).
Hunk #20 succeeded at 799 (offset 13 lines).
Hunk #21 succeeded at 850 (offset 13 lines).
Hunk #22 succeeded at 927 (offset 13 lines).
Hunk #23 succeeded at 976 (offset 13 lines).
Hunk #24 succeeded at 1002 (offset 13 lines).
Hunk #25 succeeded at 1016 (offset 13 lines).
Hunk #26 succeeded at 1028 (offset 13 lines).
1 out of 26 hunks FAILED -- saving rejects to file include/linux/firmware/xlnx-zynqmp.h.rej
```

```console
shell$ rm include/linux/firmware/xlnx-zynqmp.h.rej
shell$ rm include/linux/firmware/xlnx-zynqmp.h.orig
shell$ rm drivers/firmware/xilinx/zynqmp-pm.c.rej
shell$ rm drivers/firmware/xilinx/zynqmp-pm.c.orig
shell$ cp ../linux-6.12.100-xlnx-v2025.1/include/linux/firmware/xlnx-zynqmp.h include/linux/firmware/xlnx-zynqmp.h 
shell$ cp ../linux-6.12.100-xlnx-v2025.1/drivers/firmware/xilinx/zynqmp-pm.c drivers/firmware/xilinx/zynqmp-pm.c
shell$ patch include/linux/firmware/xlnx-zynqmp.h << 'EOT'
@@ -565,6 +565,18 @@
 	GEM_CONFIG_FIXED = 2,
 };
 
+/**
+ * enum pm_node_status - Device node status provided by xilpm fw
+ * @PM_NODE_UNUSED: Device is not used
+ * @PM_NODE_RUNNING: Device is power-on and out of reset
+ * @PM_NODE_HALT: Device is power-on but in the reset state
+ */
+enum pm_node_status {
+	PM_NODE_UNUSED = 0,
+	PM_NODE_RUNNING = 1,
+	PM_NODE_HALT = 12,
+};
+
 enum pm_reset_reason {
 	PM_RESET_REASON_EXT_POR = 0,
 	PM_RESET_REASON_SW_POR = 1,

EOT
shell$ patch drivers/firmware/xilinx/zynqmp-core.c << 'EOT'
--- drivers/firmware/xilinx/zynqmp-core.c
+++ drivers/firmware/xilinx/zynqmp-core.c
@@ -677,6 +677,7 @@
 	va_end(arg_list);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_invoke_fn);
 
 /**
  * zynqmp_pm_load_pdi_word_swap - Perform word swapping on a memory address.
EOT
shell$ git add --all
shell$ git commit -m "[patch] 207_drivers-firmware.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/207_drivers-firmware.patch

###### 211_drivers-hwmon.patch

####### drivers/hwmon/Kconfig

####### Documentation/hwmon/ina2xx.rst

```console
shell$ diff -p linux-6.12.100/Documentation/hwmon/ina2xx.rst linux-6.12.109/Documentation/hwmon/ina2xx.rst
*** linux-6.12.100/Documentation/hwmon/ina2xx.rst	2026-08-05 10:45:13.288434701 +0900
--- linux-6.12.109/Documentation/hwmon/ina2xx.rst	2026-10-09 15:27:29.722568924 +0900
*************** Supported chips:
*** 53,58 ****
--- 53,89 ----
  
  	       https://www.ti.com/
  
+   * Texas Instruments INA260
+ 
+     Prefix: 'ina260'
+ 
+     Addresses: I2C 0x40 - 0x4f
+ 
+     Datasheet: Publicly available at the Texas Instruments website
+ 
+ 	       https://www.ti.com/
+ 
+   * Silergy SY24655
+ 
+     Prefix: 'sy24655'
+ 
+     Addresses: I2C 0x40 - 0x4f
+ 
+     Datasheet: Publicly available at the Silergy website
+ 
+ 	       https://us1.silergy.com/
+ 
+ 
+   * Texas Instruments INA234
+ 
+     Prefix: 'ina234'
+ 
+     Addresses: I2C 0x40 - 0x43
+ 
+     Datasheet: Publicly available at the Texas Instruments website
+ 
+ 	       https://www.ti.com/
+ 
  Author: Lothar Felten <lothar.felten@gmail.com>
  
  Description
*************** interface. The INA220 monitors both shun
*** 68,77 ****
  The INA226 is a current shunt and power monitor with an I2C interface.
  The INA226 monitors both a shunt voltage drop and bus supply voltage.
  
! INA230 and INA231 are high or low side current shunt and power monitors
  with an I2C interface. The chips monitor both a shunt voltage drop and
  bus supply voltage.
  
  The shunt value in micro-ohms can be set via platform data or device tree at
  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
  refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
--- 99,116 ----
  The INA226 is a current shunt and power monitor with an I2C interface.
  The INA226 monitors both a shunt voltage drop and bus supply voltage.
  
! INA230, INA231, and INA234 are high or low side current shunt and power monitors
  with an I2C interface. The chips monitor both a shunt voltage drop and
  bus supply voltage.
  
+ INA260 is a high or low side current and power monitor with integrated shunt
+ resistor.
+ 
+ The SY24655 is a high- and low-side current shunt and power monitor with an I2C
+ interface. The SY24655 supports both shunt drop and supply voltage, with
+ programmable calibration value and conversion times. The SY24655 can also
+ calculate average power for use in energy conversion.
+ 
  The shunt value in micro-ohms can be set via platform data or device tree at
  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
  refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
*************** The actual programmed interval may vary
*** 87,102 ****
  General sysfs entries
  ---------------------
  
! ======================= ===============================
  in0_input		Shunt voltage(mV) channel
  in1_input		Bus voltage(mV) channel
  curr1_input		Current(mA) measurement channel
  power1_input		Power(uW) measurement channel
! shunt_resistor		Shunt resistance(uOhm) channel
! ======================= ===============================
  
! Sysfs entries for ina226, ina230 and ina231 only
! ------------------------------------------------
  
  ======================= ====================================================
  curr1_lcrit		Critical low current
--- 126,150 ----
  General sysfs entries
  ---------------------
  
! ======================= ===============================================
  in0_input		Shunt voltage(mV) channel
  in1_input		Bus voltage(mV) channel
  curr1_input		Current(mA) measurement channel
  power1_input		Power(uW) measurement channel
! shunt_resistor		Shunt resistance(uOhm) channel (not for ina260)
! ======================= ===============================================
  
! Additional sysfs entries
! ------------------------
! 
! Additional entries are available for the following chips:
! 
!   * ina226
!   * ina230
!   * ina231
!   * ina234
!   * ina260
!   * sy24655
  
  ======================= ====================================================
  curr1_lcrit		Critical low current
*************** update_interval		data conversion time; a
*** 117,122 ****
--- 165,177 ----
  			to average results for shunt and bus voltages.
  ======================= ====================================================
  
+ Sysfs entries for sy24655 only
+ ------------------------------
+ 
+ ======================= ====================================================
+ power1_average		average power from last reading to the present.
+ ======================= ====================================================
+ 
  .. note::
  
     - Configure `shunt_resistor` before configure `power1_crit`, because power

```

```console
shell$ diff -p linux-6.12.100/Documentation/hwmon/ina2xx.rst linux-6.12.100-xlnx-v2025.1/Documentation/hwmon/ina2xx.rst
*** linux-6.12.100/Documentation/hwmon/ina2xx.rst	2026-08-05 10:45:13.288434701 +0900
--- linux-6.12.100-xlnx-v2025.1/Documentation/hwmon/ina2xx.rst	2026-08-05 11:16:16.079774717 +0900
*************** Supported chips:
*** 53,58 ****
--- 53,68 ----
  
  	       https://www.ti.com/
  
+   * Texas Instruments INA260
+ 
+     Prefix: 'ina260'
+ 
+     Addresses: I2C 0x40 - 0x4f
+ 
+     Datasheet: Publicly available at the Texas Instruments website
+ 
+ 	       https://www.ti.com/
+ 
  Author: Lothar Felten <lothar.felten@gmail.com>
  
  Description
*************** INA230 and INA231 are high or low side c
*** 72,77 ****
--- 82,90 ----
  with an I2C interface. The chips monitor both a shunt voltage drop and
  bus supply voltage.
  
+ INA260 is a high or low side current and power monitor with integrated shunt
+ resistor.
+ 
  The shunt value in micro-ohms can be set via platform data or device tree at
  compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
  refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
*************** The actual programmed interval may vary
*** 87,102 ****
  General sysfs entries
  ---------------------
  
! ======================= ===============================
  in0_input		Shunt voltage(mV) channel
  in1_input		Bus voltage(mV) channel
  curr1_input		Current(mA) measurement channel
  power1_input		Power(uW) measurement channel
! shunt_resistor		Shunt resistance(uOhm) channel
! ======================= ===============================
  
! Sysfs entries for ina226, ina230 and ina231 only
! ------------------------------------------------
  
  ======================= ====================================================
  curr1_lcrit		Critical low current
--- 100,115 ----
  General sysfs entries
  ---------------------
  
! ======================= ===============================================
  in0_input		Shunt voltage(mV) channel
  in1_input		Bus voltage(mV) channel
  curr1_input		Current(mA) measurement channel
  power1_input		Power(uW) measurement channel
! shunt_resistor		Shunt resistance(uOhm) channel (not for ina260)
! ======================= ===============================================
  
! Additional sysfs entries for ina226, ina230, ina231, and ina260
! ---------------------------------------------------------------
  
  ======================= ====================================================
  curr1_lcrit		Critical low current
```

```console
shell$ diff -p linux-6.12.109/Documentation/hwmon/ina2xx.rst linux-6.12.100-xlnx-v2025.1/Documentation/hwmon/ina2xx.rst

####### drivers/hwmon/Kconfig

```console
shell$ diff -p linux-6.12.100/drivers/hwmon/Kconfig linux-6.12.109/drivers/hwmon/Kconfig 
*** linux-6.12.100/drivers/hwmon/Kconfig	2026-08-05 10:45:15.378189561 +0900
--- linux-6.12.109/drivers/hwmon/Kconfig	2026-10-09 15:27:31.974892949 +0900
*************** config SENSORS_INA2XX
*** 2170,2180 ****
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, and INA231 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
! 	  Default value for Rshunt is 10 mOhms.
  	  This driver can also be built as a module. If so, the module
  	  will be called ina2xx.
  
--- 2170,2181 ----
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, INA231, INA234, INA260, and SY24655 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
! 	  Default value for Rshunt is 10 mOhms except for INA260 which has an
! 	  internal 2 mOhm shunt resistor.
  	  This driver can also be built as a module. If so, the module
  	  will be called ina2xx.
  
```

```console
shell$ diff -p linux-6.12.100/drivers/hwmon/Kconfig linux-6.12.100-xlnx-v2025.1/drivers/hwmon/Kconfig
*** linux-6.12.100/drivers/hwmon/Kconfig	2026-08-05 10:45:15.378189561 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/hwmon/Kconfig	2026-08-05 11:16:16.079774717 +0900
*************** config SENSORS_INA2XX
*** 2170,2180 ****
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, and INA231 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
! 	  Default value for Rshunt is 10 mOhms.
  	  This driver can also be built as a module. If so, the module
  	  will be called ina2xx.
  
--- 2170,2181 ----
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

```console
shell$ diff -p linux-6.12.109/drivers/hwmon/Kconfig linux-6.12.100-xlnx-v2025.1/drivers/hwmon/Kconfig
*** linux-6.12.109/drivers/hwmon/Kconfig	2026-10-09 15:27:31.974892949 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/hwmon/Kconfig	2026-08-05 11:16:16.079774717 +0900
*************** config SENSORS_INA2XX
*** 2170,2176 ****
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, INA231, INA234, INA260, and SY24655 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
--- 2170,2176 ----
  	select REGMAP_I2C
  	help
  	  If you say yes here you get support for INA219, INA220, INA226,
! 	  INA230, INA231, and INA260 power monitor chips.
  
  	  The INA2xx driver is configured for the default configuration of
  	  the part as described in the datasheet.
```

####### drivers/hwmon/ina2xx.c

```console
shell$ diff -p linux-6.12.100/drivers/hwmon/ina2xx.c linux-6.12.109/drivers/hwmon/ina2xx.c
*** linux-6.12.100/drivers/hwmon/ina2xx.c	2026-08-05 10:45:15.386016358 +0900
--- linux-6.12.109/drivers/hwmon/ina2xx.c	2026-10-09 15:27:31.982894004 +0900
***************
*** 31,36 ****
--- 31,37 ----
  #include <linux/i2c.h>
  #include <linux/init.h>
  #include <linux/kernel.h>
+ #include <linux/limits.h>
  #include <linux/module.h>
  #include <linux/property.h>
  #include <linux/regmap.h>
***************
*** 51,67 ****
  #define INA226_ALERT_LIMIT		0x07
  #define INA226_DIE_ID			0xFF
  
! #define INA2XX_MAX_REGISTERS		8
  
  /* settings - depend on use case */
  #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
  #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
  
  /* worst case is 68.10 ms (~14.6Hz, ina219) */
  #define INA2XX_CONVERSION_RATE		15
  #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
  
  #define INA2XX_RSHUNT_DEFAULT		10000
  
  /* bit mask for reading the averaging setting in the configuration register */
  #define INA226_AVG_RD_MASK		GENMASK(11, 9)
--- 52,77 ----
  #define INA226_ALERT_LIMIT		0x07
  #define INA226_DIE_ID			0xFF
  
! /* SY24655 register definitions */
! #define SY24655_EIN				0x0A
! #define SY24655_ACCUM_CONFIG	0x0D
! #define INA2XX_MAX_REGISTERS		0x0D
  
  /* settings - depend on use case */
  #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
  #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
+ #define INA260_CONFIG_DEFAULT		0x6527	/* averages=16 */
+ #define SY24655_CONFIG_DEFAULT		0x4527	/* averages=16 */
+ 
+ /* (only for sy24655) */
+ #define SY24655_ACCUM_CONFIG_DEFAULT	0x044C	/* continuous mode, clear after read*/
  
  /* worst case is 68.10 ms (~14.6Hz, ina219) */
  #define INA2XX_CONVERSION_RATE		15
  #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
  
  #define INA2XX_RSHUNT_DEFAULT		10000
+ #define INA260_RSHUNT			2000
  
  /* bit mask for reading the averaging setting in the configuration register */
  #define INA226_AVG_RD_MASK		GENMASK(11, 9)
*************** static bool ina2xx_writeable_reg(struct
*** 95,100 ****
--- 105,111 ----
  	case INA2XX_CALIBRATION:
  	case INA226_MASK_ENABLE:
  	case INA226_ALERT_LIMIT:
+ 	case SY24655_ACCUM_CONFIG:
  		return true;
  	default:
  		return false;
*************** static const struct regmap_config ina2xx
*** 125,139 ****
  	.writeable_reg = ina2xx_writeable_reg,
  };
  
! enum ina2xx_ids { ina219, ina226 };
  
  struct ina2xx_config {
  	u16 config_default;
  	int calibration_value;
  	int shunt_div;
  	int bus_voltage_shift;
  	int bus_voltage_lsb;	/* uV */
  	int power_lsb_factor;
  };
  
  struct ina2xx_data {
--- 136,162 ----
  	.writeable_reg = ina2xx_writeable_reg,
  };
  
! enum ina2xx_ids {
! 	ina219,
! 	ina226,
! 	ina234,
! 	ina260,
! 	sy24655
! };
  
  struct ina2xx_config {
  	u16 config_default;
+ 	bool has_alerts;	/* chip supports alerts and limits */
+ 	bool has_ishunt;	/* chip has internal shunt resistor */
+ 	bool has_power_average;	/* chip supports average power */
+ 	bool has_update_interval;
  	int calibration_value;
  	int shunt_div;
+ 	int shunt_voltage_shift;
  	int bus_voltage_shift;
  	int bus_voltage_lsb;	/* uV */
  	int power_lsb_factor;
+ 	int current_shift;
  };
  
  struct ina2xx_data {
*************** struct ina2xx_data {
*** 145,150 ****
--- 168,174 ----
  	long power_lsb_uW;
  	struct mutex config_lock;
  	struct regmap *regmap;
+ 	struct i2c_client *client;
  };
  
  static const struct ina2xx_config ina2xx_config[] = {
*************** static const struct ina2xx_config ina2xx
*** 152,168 ****
--- 176,245 ----
  		.config_default = INA219_CONFIG_DEFAULT,
  		.calibration_value = 4096,
  		.shunt_div = 100,
+ 		.shunt_voltage_shift = 0,
  		.bus_voltage_shift = 3,
  		.bus_voltage_lsb = 4000,
  		.power_lsb_factor = 20,
+ 		.has_alerts = false,
+ 		.has_ishunt = false,
+ 		.has_power_average = false,
+ 		.current_shift = 0,
+ 		.has_update_interval = false,
  	},
  	[ina226] = {
  		.config_default = INA226_CONFIG_DEFAULT,
  		.calibration_value = 2048,
  		.shunt_div = 400,
+ 		.shunt_voltage_shift = 0,
  		.bus_voltage_shift = 0,
  		.bus_voltage_lsb = 1250,
  		.power_lsb_factor = 25,
+ 		.has_alerts = true,
+ 		.has_ishunt = false,
+ 		.has_power_average = false,
+ 		.current_shift = 0,
+ 		.has_update_interval = true,
+ 	},
+ 	[ina234] = {
+ 		.config_default = INA226_CONFIG_DEFAULT,
+ 		.calibration_value = 2048,
+ 		.shunt_div = 25, /* 2.5 µV/LSB raw ADC reading from INA2XX_SHUNT_VOLTAGE */
+ 		.shunt_voltage_shift = 4,
+ 		.bus_voltage_shift = 4,
+ 		.bus_voltage_lsb = 25600,
+ 		.power_lsb_factor = 32,
+ 		.has_alerts = true,
+ 		.has_ishunt = false,
+ 		.has_power_average = false,
+ 		.current_shift = 4,
+ 		.has_update_interval = true,
+ 	},
+ 	[ina260] = {
+ 		.config_default = INA260_CONFIG_DEFAULT,
+ 		.shunt_div = 400,
+ 		.shunt_voltage_shift = 0,
+ 		.bus_voltage_shift = 0,
+ 		.bus_voltage_lsb = 1250,
+ 		.power_lsb_factor = 8,
+ 		.has_alerts = true,
+ 		.has_ishunt = true,
+ 		.has_power_average = false,
+ 		.current_shift = 0,
+ 		.has_update_interval = true,
+ 	},
+ 	[sy24655] = {
+ 		.config_default = SY24655_CONFIG_DEFAULT,
+ 		.calibration_value = 4096,
+ 		.shunt_div = 400,
+ 		.shunt_voltage_shift = 0,
+ 		.bus_voltage_shift = 0,
+ 		.bus_voltage_lsb = 1250,
+ 		.power_lsb_factor = 25,
+ 		.has_alerts = true,
+ 		.has_ishunt = false,
+ 		.has_power_average = true,
+ 		.current_shift = 0,
+ 		.has_update_interval = false,
  	},
  };
  
*************** static u16 ina226_interval_to_reg(long i
*** 207,234 ****
  	return FIELD_PREP(INA226_AVG_RD_MASK, avg_bits);
  }
  
! static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
! 			    unsigned int regval)
  {
! 	int val;
  
  	switch (reg) {
  	case INA2XX_SHUNT_VOLTAGE:
  		/* signed register */
! 		val = DIV_ROUND_CLOSEST((s16)regval, data->config->shunt_div);
  		break;
  	case INA2XX_BUS_VOLTAGE:
! 		val = (regval >> data->config->bus_voltage_shift) *
! 		  data->config->bus_voltage_lsb;
! 		val = DIV_ROUND_CLOSEST(val, 1000);
  		break;
  	case INA2XX_POWER:
! 		val = regval * data->power_lsb_uW;
  		break;
  	case INA2XX_CURRENT:
  		/* signed register, result in mA */
! 		val = (s16)regval * data->current_lsb_uA;
! 		val = DIV_ROUND_CLOSEST(val, 1000);
  		break;
  	case INA2XX_CALIBRATION:
  		val = regval;
--- 284,317 ----
  	return FIELD_PREP(INA226_AVG_RD_MASK, avg_bits);
  }
  
! static long ina2xx_get_value(struct ina2xx_data *data, u8 reg,
! 			     unsigned int regval)
  {
! 	s64 val64;
! 	long val;
  
  	switch (reg) {
  	case INA2XX_SHUNT_VOLTAGE:
  		/* signed register */
! 		val = DIV_ROUND_CLOSEST((s16)regval >> data->config->shunt_voltage_shift,
! 					data->config->shunt_div);
  		break;
  	case INA2XX_BUS_VOLTAGE:
! 		val = DIV_ROUND_CLOSEST((regval >> data->config->bus_voltage_shift) *
! 					data->config->bus_voltage_lsb, 1000);
  		break;
  	case INA2XX_POWER:
! 		val = min_t(u64, (u64)regval * data->power_lsb_uW, LONG_MAX);
  		break;
  	case INA2XX_CURRENT:
  		/* signed register, result in mA */
! 		val64 = (s64)((s16)regval >> data->config->current_shift) *
! 		  data->current_lsb_uA;
! 		if (val64 < 0)
! 			val64 = -DIV_ROUND_CLOSEST_ULL(-val64, 1000);
! 		else
! 			val64 = DIV_ROUND_CLOSEST_ULL(val64, 1000);
! 		val = clamp_val(val64, LONG_MIN, LONG_MAX);
  		break;
  	case INA2XX_CALIBRATION:
  		val = regval;
*************** static int ina2xx_read_init(struct devic
*** 254,259 ****
--- 337,351 ----
  	unsigned int regval;
  	int ret, retry;
  
+ 	if (data->config->has_ishunt) {
+ 		/* No calibration needed */
+ 		ret = regmap_read(regmap, reg, &regval);
+ 		if (ret < 0)
+ 			return ret;
+ 		*val = ina2xx_get_value(data, reg, regval);
+ 		return 0;
+ 	}
+ 
  	for (retry = 5; retry; retry--) {
  		ret = regmap_read(regmap, reg, &regval);
  		if (ret < 0)
*************** static int ina2xx_read_init(struct devic
*** 308,332 ****
   */
  static u16 ina226_alert_to_reg(struct ina2xx_data *data, int reg, long val)
  {
  	switch (reg) {
  	case INA2XX_SHUNT_VOLTAGE:
! 		val = clamp_val(val, 0, SHRT_MAX * data->config->shunt_div);
! 		val *= data->config->shunt_div;
! 		return clamp_val(val, 0, SHRT_MAX);
  	case INA2XX_BUS_VOLTAGE:
! 		val = clamp_val(val, 0, 200000);
! 		val = (val * 1000) << data->config->bus_voltage_shift;
! 		val = DIV_ROUND_CLOSEST(val, data->config->bus_voltage_lsb);
! 		return clamp_val(val, 0, USHRT_MAX);
  	case INA2XX_POWER:
! 		val = clamp_val(val, 0, UINT_MAX - data->power_lsb_uW);
! 		val = DIV_ROUND_CLOSEST(val, data->power_lsb_uW);
! 		return clamp_val(val, 0, USHRT_MAX);
  	case INA2XX_CURRENT:
! 		val = clamp_val(val, INT_MIN / 1000, INT_MAX / 1000);
  		/* signed register, result in mA */
  		val = DIV_ROUND_CLOSEST(val * 1000, data->current_lsb_uA);
! 		return clamp_val(val, SHRT_MIN, SHRT_MAX);
  	default:
  		/* programmer goofed */
  		WARN_ON_ONCE(1);
--- 400,428 ----
   */
  static u16 ina226_alert_to_reg(struct ina2xx_data *data, int reg, long val)
  {
+ 	long limit;
+ 
  	switch (reg) {
  	case INA2XX_SHUNT_VOLTAGE:
! 		val = min_t(long, val, DIV_ROUND_CLOSEST(SHRT_MAX, data->config->shunt_div));
! 		return min_t(long, (val * data->config->shunt_div) << data->config->shunt_voltage_shift,
! 			     SHRT_MAX);
  	case INA2XX_BUS_VOLTAGE:
! 		val = min_t(long, val, 130000);
! 		return min_t(long,
! 			     DIV_ROUND_CLOSEST((val * 1000) << data->config->bus_voltage_shift,
! 					       data->config->bus_voltage_lsb),
! 			     USHRT_MAX);
  	case INA2XX_POWER:
! 		val = min_t(long, val, LONG_MAX - data->power_lsb_uW);
! 		return min_t(long, DIV_ROUND_CLOSEST(val, data->power_lsb_uW), USHRT_MAX);
  	case INA2XX_CURRENT:
! 		limit = (LONG_MAX - (data->current_lsb_uA / 2)) / 1000;
! 		val = min_t(long, val, limit);
  		/* signed register, result in mA */
  		val = DIV_ROUND_CLOSEST(val * 1000, data->current_lsb_uA);
! 		limit = SHRT_MAX >> data->config->current_shift;
! 		return (u16)(min_t(long, val, limit) << data->config->current_shift);
  	default:
  		/* programmer goofed */
  		WARN_ON_ONCE(1);
*************** static int ina2xx_in_read(struct device
*** 459,464 ****
--- 555,597 ----
  	return 0;
  }
  
+ /*
+  * Configuring the READ_EIN (bit 10) of the ACCUM_CONFIG register to 1
+  * can clear accumulator and sample_count after reading the EIN register.
+  * This way, the average power between the last read and the current
+  * read can be obtained. By combining with accurate time data from
+  * outside, the energy consumption during that period can be calculated.
+  */
+ static int sy24655_average_power_read(struct ina2xx_data *data, u8 reg, long *val)
+ {
+ 	u8 template[6];
+ 	int ret;
+ 	long accumulator_24, sample_count;
+ 	u64 val64;
+ 
+ 	/* 48-bit register read */
+ 	ret = i2c_smbus_read_i2c_block_data(data->client, reg, 6, template);
+ 	if (ret < 0)
+ 		return ret;
+ 	if (ret != 6)
+ 		return -EIO;
+ 	accumulator_24 = ((template[3] << 16) |
+ 				(template[4] << 8) |
+ 				template[5]);
+ 	sample_count = ((template[0] << 16) |
+ 				(template[1] << 8) |
+ 				template[2]);
+ 	if (sample_count <= 0) {
+ 		*val = 0;
+ 		return 0;
+ 	}
+ 
+ 	val64 = (u64)DIV_ROUND_CLOSEST(accumulator_24, sample_count) * data->power_lsb_uW;
+ 	*val = min_t(u64, val64, LONG_MAX);
+ 
+ 	return 0;
+ }
+ 
  static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
  {
  	struct ina2xx_data *data = dev_get_drvdata(dev);
*************** static int ina2xx_power_read(struct devi
*** 466,471 ****
--- 599,606 ----
  	switch (attr) {
  	case hwmon_power_input:
  		return ina2xx_read_init(dev, INA2XX_POWER, val);
+ 	case hwmon_power_average:
+ 		return sy24655_average_power_read(data, SY24655_EIN, val);
  	case hwmon_power_crit:
  		return ina226_alert_limit_read(data, INA226_POWER_OVER_LIMIT_MASK,
  					       INA2XX_POWER, val);
*************** static umode_t ina2xx_is_visible(const v
*** 624,630 ****
  				 u32 attr, int channel)
  {
  	const struct ina2xx_data *data = _data;
! 	enum ina2xx_ids chip = data->chip;
  
  	switch (type) {
  	case hwmon_in:
--- 759,767 ----
  				 u32 attr, int channel)
  {
  	const struct ina2xx_data *data = _data;
! 	bool has_alerts = data->config->has_alerts;
! 	bool has_power_average = data->config->has_power_average;
! 	bool has_update_interval = data->config->has_update_interval;
  
  	switch (type) {
  	case hwmon_in:
*************** static umode_t ina2xx_is_visible(const v
*** 633,644 ****
  			return 0444;
  		case hwmon_in_lcrit:
  		case hwmon_in_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_in_lcrit_alarm:
  		case hwmon_in_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 770,781 ----
  			return 0444;
  		case hwmon_in_lcrit:
  		case hwmon_in_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_in_lcrit_alarm:
  		case hwmon_in_crit_alarm:
! 			if (has_alerts)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 651,662 ****
  			return 0444;
  		case hwmon_curr_lcrit:
  		case hwmon_curr_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_curr_lcrit_alarm:
  		case hwmon_curr_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 788,799 ----
  			return 0444;
  		case hwmon_curr_lcrit:
  		case hwmon_curr_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_curr_lcrit_alarm:
  		case hwmon_curr_crit_alarm:
! 			if (has_alerts)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 668,678 ****
  		case hwmon_power_input:
  			return 0444;
  		case hwmon_power_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_power_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 805,819 ----
  		case hwmon_power_input:
  			return 0444;
  		case hwmon_power_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_power_crit_alarm:
! 			if (has_alerts)
! 				return 0444;
! 			break;
! 		case hwmon_power_average:
! 			if (has_power_average)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 682,688 ****
  	case hwmon_chip:
  		switch (attr) {
  		case hwmon_chip_update_interval:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		default:
--- 823,829 ----
  	case hwmon_chip:
  		switch (attr) {
  		case hwmon_chip_update_interval:
! 			if (has_update_interval)
  				return 0644;
  			break;
  		default:
*************** static const struct hwmon_channel_info *
*** 707,713 ****
  	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
  			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
  	HWMON_CHANNEL_INFO(power,
! 			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
  	NULL
  };
  
--- 848,855 ----
  	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
  			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
  	HWMON_CHANNEL_INFO(power,
! 			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM |
! 			   HWMON_P_AVERAGE),
  	NULL
  };
  
*************** static int ina2xx_init(struct device *de
*** 791,797 ****
  	u32 shunt;
  	int ret;
  
! 	if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0)
  		shunt = INA2XX_RSHUNT_DEFAULT;
  
  	ret = ina2xx_set_shunt(data, shunt);
--- 933,941 ----
  	u32 shunt;
  	int ret;
  
! 	if (data->config->has_ishunt)
! 		shunt = INA260_RSHUNT;
! 	else if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0)
  		shunt = INA2XX_RSHUNT_DEFAULT;
  
  	ret = ina2xx_set_shunt(data, shunt);
*************** static int ina2xx_init(struct device *de
*** 802,808 ****
  	if (ret < 0)
  		return ret;
  
! 	if (data->chip == ina226) {
  		bool active_high = device_property_read_bool(dev, "ti,alert-polarity-active-high");
  
  		regmap_update_bits(regmap, INA226_MASK_ENABLE,
--- 946,952 ----
  	if (ret < 0)
  		return ret;
  
! 	if (data->config->has_alerts) {
  		bool active_high = device_property_read_bool(dev, "ti,alert-polarity-active-high");
  
  		regmap_update_bits(regmap, INA226_MASK_ENABLE,
*************** static int ina2xx_init(struct device *de
*** 810,815 ****
--- 954,975 ----
  				   INA226_ALERT_LATCH_ENABLE |
  						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
  	}
+ 	if (data->config->has_power_average) {
+ 		if (data->chip == sy24655) {
+ 			/*
+ 			 * Initialize the power accumulation method to continuous
+ 			 * mode and clear the EIN register after each read of the
+ 			 * EIN register
+ 			 */
+ 			ret = regmap_write(regmap, SY24655_ACCUM_CONFIG,
+ 					   SY24655_ACCUM_CONFIG_DEFAULT);
+ 			if (ret < 0)
+ 				return ret;
+ 		}
+ 	}
+ 
+ 	if (data->config->has_ishunt)
+ 		return 0;
  
  	/*
  	 * Calibration register is set to the best value, which eliminates
*************** static int ina2xx_probe(struct i2c_clien
*** 836,841 ****
--- 996,1002 ----
  		return -ENOMEM;
  
  	/* set the device type */
+ 	data->client = client;
  	data->config = &ina2xx_config[chip];
  	data->chip = chip;
  	mutex_init(&data->config_lock);
*************** static int ina2xx_probe(struct i2c_clien
*** 856,862 ****
  
  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
  							 data, &ina2xx_chip_info,
! 							 ina2xx_groups);
  	if (IS_ERR(hwmon_dev))
  		return PTR_ERR(hwmon_dev);
  
--- 1017,1024 ----
  
  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
  							 data, &ina2xx_chip_info,
! 							 data->config->has_ishunt ?
! 								NULL : ina2xx_groups);
  	if (IS_ERR(hwmon_dev))
  		return PTR_ERR(hwmon_dev);
  
*************** static const struct i2c_device_id ina2xx
*** 872,883 ****
--- 1034,1052 ----
  	{ "ina226", ina226 },
  	{ "ina230", ina226 },
  	{ "ina231", ina226 },
+ 	{ "ina234", ina234 },
+ 	{ "ina260", ina260 },
+ 	{ "sy24655", sy24655 },
  	{ }
  };
  MODULE_DEVICE_TABLE(i2c, ina2xx_id);
  
  static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
  	{
+ 		.compatible = "silergy,sy24655",
+ 		.data = (void *)sy24655
+ 	},
+ 	{
  		.compatible = "ti,ina219",
  		.data = (void *)ina219
  	},
*************** static const struct of_device_id __maybe
*** 897,903 ****
  		.compatible = "ti,ina231",
  		.data = (void *)ina226
  	},
! 	{ },
  };
  MODULE_DEVICE_TABLE(of, ina2xx_of_match);
  
--- 1066,1080 ----
  		.compatible = "ti,ina231",
  		.data = (void *)ina226
  	},
! 	{
! 		.compatible = "ti,ina234",
! 		.data = (void *)ina234
! 	},
! 	{
! 		.compatible = "ti,ina260",
! 		.data = (void *)ina260
! 	},
! 	{ }
  };
  MODULE_DEVICE_TABLE(of, ina2xx_of_match);
  
```

```console
shell$ diff -p linux-6.12.100/drivers/hwmon/ina2xx.c linux-6.12.100-xlnx-v2025.1/drivers/hwmon/ina2xx.c
*** linux-6.12.100/drivers/hwmon/ina2xx.c	2026-08-05 10:45:15.386016358 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/hwmon/ina2xx.c	2026-08-05 11:16:16.079774717 +0900
***************
*** 56,67 ****
--- 56,69 ----
  /* settings - depend on use case */
  #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
  #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
+ #define INA260_CONFIG_DEFAULT		0x6527	/* averages=16 */
  
  /* worst case is 68.10 ms (~14.6Hz, ina219) */
  #define INA2XX_CONVERSION_RATE		15
  #define INA2XX_MAX_DELAY		69 /* worst case delay in ms */
  
  #define INA2XX_RSHUNT_DEFAULT		10000
+ #define INA260_RSHUNT			2000
  
  /* bit mask for reading the averaging setting in the configuration register */
  #define INA226_AVG_RD_MASK		GENMASK(11, 9)
*************** static const struct regmap_config ina2xx
*** 125,134 ****
  	.writeable_reg = ina2xx_writeable_reg,
  };
  
! enum ina2xx_ids { ina219, ina226 };
  
  struct ina2xx_config {
  	u16 config_default;
  	int calibration_value;
  	int shunt_div;
  	int bus_voltage_shift;
--- 127,138 ----
  	.writeable_reg = ina2xx_writeable_reg,
  };
  
! enum ina2xx_ids { ina219, ina226, ina260 };
  
  struct ina2xx_config {
  	u16 config_default;
+ 	bool has_alerts;	/* chip supports alerts and limits */
+ 	bool has_ishunt;	/* chip has internal shunt resistor */
  	int calibration_value;
  	int shunt_div;
  	int bus_voltage_shift;
*************** static const struct ina2xx_config ina2xx
*** 155,160 ****
--- 159,166 ----
  		.bus_voltage_shift = 3,
  		.bus_voltage_lsb = 4000,
  		.power_lsb_factor = 20,
+ 		.has_alerts = false,
+ 		.has_ishunt = false,
  	},
  	[ina226] = {
  		.config_default = INA226_CONFIG_DEFAULT,
*************** static const struct ina2xx_config ina2xx
*** 163,168 ****
--- 169,185 ----
  		.bus_voltage_shift = 0,
  		.bus_voltage_lsb = 1250,
  		.power_lsb_factor = 25,
+ 		.has_alerts = true,
+ 		.has_ishunt = false,
+ 	},
+ 	[ina260] = {
+ 		.config_default = INA260_CONFIG_DEFAULT,
+ 		.shunt_div = 400,
+ 		.bus_voltage_shift = 0,
+ 		.bus_voltage_lsb = 1250,
+ 		.power_lsb_factor = 8,
+ 		.has_alerts = true,
+ 		.has_ishunt = true,
  	},
  };
  
*************** static int ina2xx_read_init(struct devic
*** 254,259 ****
--- 271,285 ----
  	unsigned int regval;
  	int ret, retry;
  
+ 	if (data->config->has_ishunt) {
+ 		/* No calibration needed */
+ 		ret = regmap_read(regmap, reg, &regval);
+ 		if (ret < 0)
+ 			return ret;
+ 		*val = ina2xx_get_value(data, reg, regval);
+ 		return 0;
+ 	}
+ 
  	for (retry = 5; retry; retry--) {
  		ret = regmap_read(regmap, reg, &regval);
  		if (ret < 0)
*************** static umode_t ina2xx_is_visible(const v
*** 624,629 ****
--- 650,656 ----
  				 u32 attr, int channel)
  {
  	const struct ina2xx_data *data = _data;
+ 	bool has_alerts = data->config->has_alerts;
  	enum ina2xx_ids chip = data->chip;
  
  	switch (type) {
*************** static umode_t ina2xx_is_visible(const v
*** 633,644 ****
  			return 0444;
  		case hwmon_in_lcrit:
  		case hwmon_in_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_in_lcrit_alarm:
  		case hwmon_in_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 660,671 ----
  			return 0444;
  		case hwmon_in_lcrit:
  		case hwmon_in_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_in_lcrit_alarm:
  		case hwmon_in_crit_alarm:
! 			if (has_alerts)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 651,662 ****
  			return 0444;
  		case hwmon_curr_lcrit:
  		case hwmon_curr_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_curr_lcrit_alarm:
  		case hwmon_curr_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 678,689 ----
  			return 0444;
  		case hwmon_curr_lcrit:
  		case hwmon_curr_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_curr_lcrit_alarm:
  		case hwmon_curr_crit_alarm:
! 			if (has_alerts)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 668,678 ****
  		case hwmon_power_input:
  			return 0444;
  		case hwmon_power_crit:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		case hwmon_power_crit_alarm:
! 			if (chip == ina226)
  				return 0444;
  			break;
  		default:
--- 695,705 ----
  		case hwmon_power_input:
  			return 0444;
  		case hwmon_power_crit:
! 			if (has_alerts)
  				return 0644;
  			break;
  		case hwmon_power_crit_alarm:
! 			if (has_alerts)
  				return 0444;
  			break;
  		default:
*************** static umode_t ina2xx_is_visible(const v
*** 682,688 ****
  	case hwmon_chip:
  		switch (attr) {
  		case hwmon_chip_update_interval:
! 			if (chip == ina226)
  				return 0644;
  			break;
  		default:
--- 709,715 ----
  	case hwmon_chip:
  		switch (attr) {
  		case hwmon_chip_update_interval:
! 			if (chip == ina226 || chip == ina260)
  				return 0644;
  			break;
  		default:
*************** static int ina2xx_init(struct device *de
*** 791,797 ****
  	u32 shunt;
  	int ret;
  
! 	if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0)
  		shunt = INA2XX_RSHUNT_DEFAULT;
  
  	ret = ina2xx_set_shunt(data, shunt);
--- 818,826 ----
  	u32 shunt;
  	int ret;
  
! 	if (data->config->has_ishunt)
! 		shunt = INA260_RSHUNT;
! 	else if (device_property_read_u32(dev, "shunt-resistor", &shunt) < 0)
  		shunt = INA2XX_RSHUNT_DEFAULT;
  
  	ret = ina2xx_set_shunt(data, shunt);
*************** static int ina2xx_init(struct device *de
*** 802,808 ****
  	if (ret < 0)
  		return ret;
  
! 	if (data->chip == ina226) {
  		bool active_high = device_property_read_bool(dev, "ti,alert-polarity-active-high");
  
  		regmap_update_bits(regmap, INA226_MASK_ENABLE,
--- 831,837 ----
  	if (ret < 0)
  		return ret;
  
! 	if (data->config->has_alerts) {
  		bool active_high = device_property_read_bool(dev, "ti,alert-polarity-active-high");
  
  		regmap_update_bits(regmap, INA226_MASK_ENABLE,
*************** static int ina2xx_init(struct device *de
*** 811,816 ****
--- 840,848 ----
  						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
  	}
  
+ 	if (data->config->has_ishunt)
+ 		return 0;
+ 
  	/*
  	 * Calibration register is set to the best value, which eliminates
  	 * truncation errors on calculating current register in hardware.
*************** static int ina2xx_probe(struct i2c_clien
*** 856,862 ****
  
  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
  							 data, &ina2xx_chip_info,
! 							 ina2xx_groups);
  	if (IS_ERR(hwmon_dev))
  		return PTR_ERR(hwmon_dev);
  
--- 888,895 ----
  
  	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
  							 data, &ina2xx_chip_info,
! 							 data->config->has_ishunt ?
! 								NULL : ina2xx_groups);
  	if (IS_ERR(hwmon_dev))
  		return PTR_ERR(hwmon_dev);
  
*************** static const struct i2c_device_id ina2xx
*** 872,877 ****
--- 905,911 ----
  	{ "ina226", ina226 },
  	{ "ina230", ina226 },
  	{ "ina231", ina226 },
+ 	{ "ina260", ina260 },
  	{ }
  };
  MODULE_DEVICE_TABLE(i2c, ina2xx_id);
*************** static const struct of_device_id __maybe
*** 897,902 ****
--- 931,940 ----
  		.compatible = "ti,ina231",
  		.data = (void *)ina226
  	},
+ 	{
+ 		.compatible = "ti,ina260",
+ 		.data = (void *)ina260
+ 	},
  	{ },
  };
  MODULE_DEVICE_TABLE(of, ina2xx_of_match);
```


####### Make 211_drivers-hwmon.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
patching file Documentation/hwmon/ina2xx.rst
Hunk #1 succeeded at 84 (offset 31 lines).
Hunk #2 succeeded at 121 with fuzz 2 (offset 39 lines).
Hunk #3 FAILED at 100.
1 out of 3 hunks FAILED -- saving rejects to file Documentation/hwmon/ina2xx.rst.rej
patching file drivers/hwmon/Kconfig
Hunk #1 FAILED at 2170.
1 out of 1 hunk FAILED -- saving rejects to file drivers/hwmon/Kconfig.rej
patching file drivers/hwmon/ina2xx.c
Hunk #1 FAILED at 56.
Hunk #2 FAILED at 125.
Hunk #3 FAILED at 155.
Hunk #4 FAILED at 163.
Hunk #5 succeeded at 346 with fuzz 2 (offset 92 lines).
Hunk #6 FAILED at 633.
Hunk #7 FAILED at 642.
Hunk #8 FAILED at 660.
Hunk #9 FAILED at 677.
Hunk #10 FAILED at 691.
Hunk #11 FAILED at 800.
Hunk #12 FAILED at 811.
Hunk #13 succeeded at 980 with fuzz 2 (offset 160 lines).
Hunk #14 FAILED at 868.
Hunk #15 FAILED at 884.
Hunk #16 FAILED at 909.
14 out of 16 hunks FAILED -- saving rejects to file drivers/hwmon/ina2xx.c.rej
```

```console
shell$ rm Documentation/hwmon/ina2xx.rst.orig
shell$ rm Documentation/hwmon/ina2xx.rst.rej
shell$ rm drivers/hwmon/Kconfig.orig
shell$ rm drivers/hwmon/Kconfig.rej
shell$ rm drivers/hwmon/ina2xx.c.orig
shell$ rm drivers/hwmon/ina2xx.c.rej
```

```console
shell$ git checkout Documentation/hwmon/ina2xx.rst
shell$ git checkout drivers/hwmon/Kconfig
shell$ git checkout drivers/hwmon/ina2xx.c
shell$ git status
On branch linux-6.12.109-xlnx-v2025.1-2
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml


It took 2.58 seconds to enumerate untracked files.
See 'git help status' for information on how to improve this.

no changes added to commit (use "git add" and/or "git commit -a")
shell$ git add --all
shell$ git commit -m '[patch] 211_drivers-hwmon.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/211_drivers-hwmon.patch
```

###### 230_drivers-net-ethernet.patch

####### drivers/net/ethernet/cadence/macb_main.c

```console
shell$ diff -p linux-6.12.100/drivers/net/ethernet/cadence/macb_main.c linux-6.12.100/drivers/net/ethernet/cadence/macb_main.c
*** linux-6.12.100/drivers/net/ethernet/cadence/macb_main.c	2026-08-05 10:45:15.886931380 +0900
--- linux-6.12.109/drivers/net/ethernet/cadence/macb_main.c	2026-10-09 15:27:32.494954211 +0900
*************** static void macb_free_consistent(struct
*** 2582,2589 ****
  	bp->macbgem_ops.mog_free_rx_buffers(bp);
  
  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
! 		kfree(queue->tx_skb);
! 		queue->tx_skb = NULL;
  		if (queue->tx_ring) {
  			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
  			dma_free_coherent(&bp->pdev->dev, size,
--- 2582,2607 ----
  	bp->macbgem_ops.mog_free_rx_buffers(bp);
  
  	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
! 		if (queue->tx_skb) {
! 			unsigned int dropped = 0, tail;
! 
! 			for (tail = queue->tx_tail; tail != queue->tx_head;
! 			     tail++) {
! 				if (macb_tx_skb(queue, tail)->skb)
! 					dropped++;
! 				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
! 			}
! 
! 			queue->stats.tx_dropped += dropped;
! 			bp->dev->stats.tx_dropped += dropped;
! 
! 			kfree(queue->tx_skb);
! 			queue->tx_skb = NULL;
! 		}
! 
! 		queue->tx_head = 0;
! 		queue->tx_tail = 0;
! 
  		if (queue->tx_ring) {
  			size = TX_RING_BYTES(bp) + bp->tx_bd_rd_prefetch;
  			dma_free_coherent(&bp->pdev->dev, size,
```

####### Make 230_drivers-net-ethernet.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
Hunk #14 succeeded at 5151 (offset 18 lines).
Hunk #15 succeeded at 5184 (offset 18 lines).
patching file drivers/net/ethernet/xilinx/Kconfig
patching file drivers/net/ethernet/xilinx/Makefile
patching file drivers/net/ethernet/xilinx/xilinx_axienet.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_main.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
patching file drivers/net/ethernet/xilinx/xilinx_emaclite.c
```

```console
shell$ git status
On branch linux-6.12.109-xlnx-v2025.1-2
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   Documentation/devicetree/bindings/net/cdns,macb.yaml
	modified:   Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
	modified:   Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
	modified:   drivers/net/ethernet/cadence/macb.h
	modified:   drivers/net/ethernet/cadence/macb_main.c
	modified:   drivers/net/ethernet/xilinx/Kconfig
	modified:   drivers/net/ethernet/xilinx/Makefile
	modified:   drivers/net/ethernet/xilinx/xilinx_axienet.h
	modified:   drivers/net/ethernet/xilinx/xilinx_axienet_main.c
	modified:   drivers/net/ethernet/xilinx/xilinx_emaclite.c

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	drivers/net/ethernet/cadence/macb_main.c.orig
	drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
	drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
	drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
	drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c


It took 2.62 seconds to enumerate untracked files.
See 'git help status' for information on how to improve this.

no changes added to commit (use "git add" and/or "git commit -a")
```

```console
shell$ rm drivers/net/ethernet/cadence/macb_main.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 230_drivers-net-ethernet.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/230_drivers-net-ethernet.patch
```

###### 231_drivers-net-phy.patch

###### Make 231_drivers-net-phy.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patcheslinux-6.12.100-xlnx-v2025.1/231_drivers-net-phy.patch
patching file Documentation/devicetree/bindings/net/xilinx-phy.txt
patching file drivers/net/phy/Kconfig
patching file drivers/net/phy/Makefile
patching file drivers/net/phy/phy-core.c
patching file drivers/net/phy/phylink.c
patching file drivers/net/phy/xilinx_phy.c
patching file include/linux/phy.h
patching file include/linux/xilinx_phy.h
```

```console
shell$ git status
On branch linux-6.12.109-xlnx-v2025.1-2
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   drivers/net/phy/Kconfig
	modified:   drivers/net/phy/Makefile
	modified:   drivers/net/phy/phy-core.c
	modified:   drivers/net/phy/phylink.c
	modified:   include/linux/phy.h

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	Documentation/devicetree/bindings/net/xilinx-phy.txt
	drivers/net/phy/xilinx_phy.c
	include/linux/xilinx_phy.h

no changes added to commit (use "git add" and/or "git commit -a")
shell$ git add --all
shell$ git commit -m '[update] 231_drivers-net-phy.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/231_drivers-net-phy.patch'
```

###### 242_drivers-remoteproc.patch

####### drivers/remoteproc/xlnx_r5_remoteproc.c

```console
shell$ diff -p linux-6.12.100/drivers/remoteproc/xlnx_r5_remoteproc.c linux-6.12.109/drivers/remoteproc/xlnx_r5_remoteproc.c
*** linux-6.12.100/drivers/remoteproc/xlnx_r5_remoteproc.c	2026-08-05 10:45:16.470027774 +0900
--- linux-6.12.109/drivers/remoteproc/xlnx_r5_remoteproc.c	2026-10-09 15:27:33.083021974 +0900
*************** static struct zynqmp_r5_core *zynqmp_r5_
*** 927,942 ****
  		goto free_rproc;
  	}
  
- 	/*
- 	 * If firmware is already available in the memory then move rproc state
- 	 * to DETACHED. Firmware can be preloaded via debugger or by any other
- 	 * agent (processors) in the system.
- 	 * If firmware isn't available in the memory and resource table isn't
- 	 * found, then rproc state remains OFFLINE.
- 	 */
- 	if (!zynqmp_r5_get_rsc_table_va(r5_core))
- 		r5_rproc->state = RPROC_DETACHED;
- 
  	r5_core->rproc = r5_rproc;
  	return r5_core;
  
--- 927,932 ----
*************** static int zynqmp_r5_core_init(struct zy
*** 1189,1194 ****
--- 1179,1185 ----
  {
  	struct device *dev = cluster->dev;
  	struct zynqmp_r5_core *r5_core;
+ 	u32 payload[PAYLOAD_ARG_CNT];
  	int ret = -EINVAL, i;
  
  	r5_core = cluster->r5_cores[0];
*************** static int zynqmp_r5_core_init(struct zy
*** 1234,1239 ****
--- 1225,1269 ----
  		ret = zynqmp_r5_get_sram_banks(r5_core);
  		if (ret)
  			return ret;
+ 
+ 		/*
+ 		 * It is possible that firmware is loaded into the memory, but
+ 		 * RPU (remote) is not running. In such case, RPU state will be
+ 		 * moved to RPROC_DETACHED wrongfully. To avoid it first make
+ 		 * sure RPU is power-on and out of reset before parsing for the
+ 		 * resource table.
+ 		 */
+ 		ret = zynqmp_pm_feature(PM_GET_NODE_STATUS);
+ 		if (ret < PM_API_VERSION_2)
+ 			ret = -EOPNOTSUPP;
+ 		else
+ 			ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, payload, 1,
+ 						  r5_core->pm_domain_id);
+ 		if (ret) {
+ 			dev_warn(r5_core->dev,
+ 				 "failed to get rpu node status, err %d\n", ret);
+ 			continue;
+ 		}
+ 
+ 		/*
+ 		 * If RPU state is power on and out of reset i.e. running, then
+ 		 * assign RPROC_DETACHED state. If the RPU is not out of reset
+ 		 * then do not attempt to attach to the remote processor.
+ 		 */
+ 		if (payload[1] == PM_NODE_RUNNING) {
+ 			/*
+ 			 * Not all the firmware that is running on the remote
+ 			 * core is expected to have the resource table. The
+ 			 * firmware might not use RPMsg at all, and in that case
+ 			 * resource table becomes irrelevant. However, we still
+ 			 * need to make sure that running core is not reported
+ 			 * as offline. so do not decide remote core state based
+ 			 * on the resource table availability
+ 			 */
+ 			if (zynqmp_r5_get_rsc_table_va(r5_core))
+ 				dev_dbg(r5_core->dev, "rsc tbl not found\n");
+ 			r5_core->rproc->state = RPROC_DETACHED;
+ 		}
  	}
  
  	return 0;
```

####### Make 242_drivers-remoteproc.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/242_drivers-remoteproc.patch
patching file drivers/remoteproc/xlnx_r5_remoteproc.c
Hunk #4 succeeded at 1370 (offset 30 lines).
```

```console
shell$ rm drivers/remoteproc/xlnx_r5_remoteproc.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 242_drivers-remoteproc.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/242_drivers-remoteproc.patch
```

###### 251_drivers-ufs.patch

####### drivers/ufs/core/ufshcd.c

```console
shell$ diff -p linux-6.12.100/drivers/ufs/core/ufshcd.c linux-6.12.109/drivers/ufs/core/ufshcd.c 
*** linux-6.12.100/drivers/ufs/core/ufshcd.c	2026-08-05 10:45:16.712658485 +0900
--- linux-6.12.109/drivers/ufs/core/ufshcd.c	2026-10-09 15:27:33.327047350 +0900
*************** static int __ufshcd_wl_suspend(struct uf
*** 9761,9766 ****
--- 9761,9767 ----
  			req_link_state == UIC_LINK_ACTIVE_STATE) {
  		ufshcd_disable_auto_bkops(hba);
  		flush_work(&hba->eeh_work);
+ 		cancel_delayed_work_sync(&hba->ufs_rtc_update_work);
  		goto vops_suspend;
  	}
  
*************** static int __ufshcd_wl_resume(struct ufs
*** 9970,9979 ****
  		if (ret)
  			goto set_old_link_state;
  		ufshcd_set_timestamp_attr(hba);
- 		schedule_delayed_work(&hba->ufs_rtc_update_work,
- 				      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
  	}
  
  	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
  		ufshcd_enable_auto_bkops(hba);
  	else
--- 9971,9981 ----
  		if (ret)
  			goto set_old_link_state;
  		ufshcd_set_timestamp_attr(hba);
  	}
  
+ 	schedule_delayed_work(&hba->ufs_rtc_update_work,
+ 			      msecs_to_jiffies(UFS_RTC_UPDATE_INTERVAL_MS));
+ 
  	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
  		ufshcd_enable_auto_bkops(hba);
  	else
```

```console
shell$ diff -p linux-6.12.100/drivers/ufs/core/ufshcd.c linux-6.12.100-xlnx-v2025.1/drivers/ufs/core/ufshcd.c 
*** linux-6.12.100/drivers/ufs/core/ufshcd.c	2026-08-05 10:45:16.712658485 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/ufs/core/ufshcd.c	2026-08-05 13:04:55.815861423 +0900
*************** static irqreturn_t ufshcd_sl_intr(struct
*** 7020,7025 ****
--- 7020,7028 ----
  	if (intr_status & MCQ_CQ_EVENT_STATUS)
  		retval |= ufshcd_handle_mcq_cq_events(hba);
  
+ 	if (intr_status & UFSHCD_VENDOR_IS_MASK)
+ 		retval |= ufshcd_vops_isr(hba, intr_status);
+ 
  	return retval;
  }
  
*************** static int ufshcd_device_init(struct ufs
*** 8909,8914 ****
--- 8912,8919 ----
  
  	ufshcd_set_timestamp_attr(hba);
  
+ 	hba->max_pwr_info.is_valid = false;
+ 
  	/* Gear up to HS gear if supported */
  	if (hba->max_pwr_info.is_valid) {
  		/*
```

####### Make 251_drivers-ufs.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/251_drivers-ufs.patch
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
shell$ git add --all
shell$ git commit -m '[patch] 251_drivers-ufs.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/251_drivers-ufs.patch
```

###### 263_drivers-usb-gadget.patch

####### drivers/usb/gadget/function/f_tcm.c

```console
shell$ diff -p linux-6.12.100/drivers/usb/gadget/function/f_tcm.c linux-6.12.109/drivers/usb/gadget/function/f_tcm.c
*** linux-6.12.100/drivers/usb/gadget/function/f_tcm.c	2026-08-05 10:45:16.728312081 +0900
--- linux-6.12.109/drivers/usb/gadget/function/f_tcm.c	2026-10-09 15:27:33.347049432 +0900
*************** static struct se_portal_group *usbg_make
*** 1330,1348 ****
  
  	opts = container_of(tpg_instances[i].func_inst, struct f_tcm_opts,
  		func_inst);
! 	mutex_lock(&opts->dep_lock);
! 	if (!opts->ready)
! 		goto unlock_dep;
  
  	if (opts->has_dep) {
  		if (!try_module_get(opts->dependent))
! 			goto unlock_dep;
  	} else {
  		ret = configfs_depend_item_unlocked(
  			wwn->wwn_group.cg_subsys,
  			&opts->func_inst.group.cg_item);
  		if (ret)
! 			goto unlock_dep;
  	}
  
  	tpg = kzalloc(sizeof(struct usbg_tpg), GFP_KERNEL);
--- 1330,1354 ----
  
  	opts = container_of(tpg_instances[i].func_inst, struct f_tcm_opts,
  		func_inst);
! 	if (!READ_ONCE(opts->ready))
! 		goto unlock_inst;
  
  	if (opts->has_dep) {
  		if (!try_module_get(opts->dependent))
! 			goto unlock_inst;
  	} else {
+ 		/*
+ 		 * configfs_depend_item_unlocked() may acquire the configfs
+ 		 * root inode lock when the target belongs to a different
+ 		 * subsystem. Calling it under dep_lock would create a
+ 		 * circular dependency:
+ 		 *   dep_lock -> configfs inode lock -> su_mutex -> dep_lock
+ 		 */
  		ret = configfs_depend_item_unlocked(
  			wwn->wwn_group.cg_subsys,
  			&opts->func_inst.group.cg_item);
  		if (ret)
! 			goto unlock_inst;
  	}
  
  	tpg = kzalloc(sizeof(struct usbg_tpg), GFP_KERNEL);
*************** static struct se_portal_group *usbg_make
*** 1368,1374 ****
  
  	tpg_instances[i].tpg = tpg;
  	tpg->fi = tpg_instances[i].func_inst;
- 	mutex_unlock(&opts->dep_lock);
  	mutex_unlock(&tpg_instances_lock);
  	return &tpg->se_tpg;
  
--- 1374,1379 ----
*************** unref_dep:
*** 1381,1388 ****
  		module_put(opts->dependent);
  	else
  		configfs_undepend_item_unlocked(&opts->func_inst.group.cg_item);
- unlock_dep:
- 	mutex_unlock(&opts->dep_lock);
  unlock_inst:
  	mutex_unlock(&tpg_instances_lock);
  
--- 1386,1391 ----
*************** static const struct target_core_fabric_o
*** 1678,1684 ****
  	.fabric_enable_tpg		= usbg_enable_tpg,
  	.fabric_drop_tpg		= usbg_drop_tpg,
  	.fabric_post_link		= usbg_port_link,
! 	.fabric_pre_unlink		= usbg_port_unlink,
  	.fabric_init_nodeacl		= usbg_init_nodeacl,
  
  	.tfc_wwn_attrs			= usbg_wwn_attrs,
--- 1681,1687 ----
  	.fabric_enable_tpg		= usbg_enable_tpg,
  	.fabric_drop_tpg		= usbg_drop_tpg,
  	.fabric_post_link		= usbg_port_link,
! 	.fabric_post_unlink		= usbg_port_unlink,
  	.fabric_init_nodeacl		= usbg_init_nodeacl,
  
  	.tfc_wwn_attrs			= usbg_wwn_attrs,
*************** ep_fail:
*** 2014,2044 ****
  	return -ENOTSUPP;
  }
  
! struct guas_setup_wq {
! 	struct work_struct work;
! 	struct f_uas *fu;
! 	unsigned int alt;
! };
  
  static void tcm_delayed_set_alt(struct work_struct *wq)
  {
! 	struct guas_setup_wq *work = container_of(wq, struct guas_setup_wq,
! 			work);
! 	struct f_uas *fu = work->fu;
! 	int alt = work->alt;
  
! 	kfree(work);
  
! 	if (fu->flags & USBG_IS_BOT)
! 		bot_cleanup_old_alt(fu);
! 	if (fu->flags & USBG_IS_UAS)
! 		uasp_cleanup_old_alt(fu);
  
  	if (alt == USB_G_ALT_INT_BBB)
  		bot_set_alt(fu);
  	else if (alt == USB_G_ALT_INT_UAS)
  		uasp_set_alt(fu);
! 	usb_composite_setup_continue(fu->function.config->cdev);
  }
  
  static int tcm_get_alt(struct usb_function *f, unsigned intf)
--- 2017,2174 ----
  	return -ENOTSUPP;
  }
  
! static void tcm_cleanup_old_alt(struct f_uas *fu)
! {
! 	if (fu->flags & USBG_IS_UAS)
! 		uasp_cleanup_old_alt(fu);
! 	else if (fu->flags & USBG_IS_BOT)
! 		bot_cleanup_old_alt(fu);
! 	fu->flags = 0;
! }
! 
! static void tcm_delayed_set_alt_done(struct f_uas *fu)
! {
! 	unsigned long flags;
! 
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
! 	fu->delayed_set_alt_cancel = false;
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! }
! 
! static bool tcm_delayed_set_alt_cancelled(struct f_uas *fu)
! {
! 	bool cancelled;
! 	unsigned long flags;
! 
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	cancelled = fu->delayed_set_alt_cancel;
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 
! 	return cancelled;
! }
! 
! static bool tcm_complete_delayed_status(struct f_uas *fu)
! {
! 	struct usb_composite_dev *cdev = fu->function.config->cdev;
! 	struct usb_request *req = cdev->req;
! 	unsigned long cdev_flags;
! 	bool cancelled;
! 	int ret;
! 
! 	spin_lock_irqsave(&cdev->lock, cdev_flags);
! 	spin_lock(&fu->delayed_set_alt_lock);
! 	cancelled = fu->delayed_set_alt_cancel;
! 	if (!cancelled) {
! 		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
! 		fu->delayed_set_alt_cancel = false;
! 	}
! 	spin_unlock(&fu->delayed_set_alt_lock);
! 
! 	if (cancelled) {
! 		spin_unlock_irqrestore(&cdev->lock, cdev_flags);
! 		return false;
! 	}
! 
! 	if (cdev->delayed_status == 0) {
! 		WARN(cdev, "%s: Unexpected call\n", __func__);
! 	} else if (--cdev->delayed_status == 0) {
! 		req->length = 0;
! 		req->context = cdev;
! 		ret = usb_ep_queue(cdev->gadget->ep0, req, GFP_ATOMIC);
! 		if (ret == 0) {
! 			cdev->setup_pending = true;
! 		} else {
! 			req->status = 0;
! 			req->complete(cdev->gadget->ep0, req);
! 		}
! 	}
! 
! 	spin_unlock_irqrestore(&cdev->lock, cdev_flags);
! 
! 	return true;
! }
! 
! static bool tcm_cancel_delayed_set_alt(struct f_uas *fu)
! {
! 	bool cleanup = false;
! 	bool cancel = false;
! 	unsigned long flags;
! 
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	switch (fu->delayed_set_alt_state) {
! 	case USBG_DELAYED_SET_ALT_IDLE:
! 		cleanup = true;
! 		break;
! 	case USBG_DELAYED_SET_ALT_QUEUED:
! 	case USBG_DELAYED_SET_ALT_RUNNING:
! 		fu->delayed_set_alt_cancel = true;
! 		cancel = true;
! 		break;
! 	}
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 
! 	if (cancel && cancel_work(&fu->delayed_set_alt)) {
! 		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 		if (fu->delayed_set_alt_state == USBG_DELAYED_SET_ALT_QUEUED) {
! 			fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
! 			fu->delayed_set_alt_cancel = false;
! 			cleanup = true;
! 		}
! 		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 	}
! 
! 	return cleanup;
! }
! 
! static void tcm_cancel_delayed_set_alt_sync(struct f_uas *fu)
! {
! 	unsigned long flags;
! 
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE)
! 		fu->delayed_set_alt_cancel = true;
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 
! 	cancel_work_sync(&fu->delayed_set_alt);
! 
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_IDLE;
! 	fu->delayed_set_alt_cancel = false;
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! }
  
  static void tcm_delayed_set_alt(struct work_struct *wq)
  {
! 	struct f_uas *fu = container_of(wq, struct f_uas, delayed_set_alt);
! 	unsigned long flags;
! 	unsigned int alt;
  
! 	spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 	if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_QUEUED) {
! 		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 		return;
! 	}
! 	fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_RUNNING;
! 	alt = fu->delayed_alt;
! 	spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
  
! 	tcm_cleanup_old_alt(fu);
! 
! 	if (tcm_delayed_set_alt_cancelled(fu))
! 		goto out_done;
  
  	if (alt == USB_G_ALT_INT_BBB)
  		bot_set_alt(fu);
  	else if (alt == USB_G_ALT_INT_UAS)
  		uasp_set_alt(fu);
! 
! 	if (tcm_complete_delayed_status(fu))
! 		return;
! 
! 	tcm_cleanup_old_alt(fu);
! out_done:
! 	tcm_delayed_set_alt_done(fu);
  }
  
  static int tcm_get_alt(struct usb_function *f, unsigned intf)
*************** static int tcm_set_alt(struct usb_functi
*** 2064,2078 ****
  		return -EOPNOTSUPP;
  
  	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
! 		struct guas_setup_wq *work;
  
! 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
! 		if (!work)
! 			return -ENOMEM;
! 		INIT_WORK(&work->work, tcm_delayed_set_alt);
! 		work->fu = fu;
! 		work->alt = alt;
! 		schedule_work(&work->work);
  		return USB_GADGET_DELAYED_STATUS;
  	}
  	return -EOPNOTSUPP;
--- 2194,2213 ----
  		return -EOPNOTSUPP;
  
  	if ((alt == USB_G_ALT_INT_BBB) || (alt == USB_G_ALT_INT_UAS)) {
! 		unsigned long flags;
  
! 		spin_lock_irqsave(&fu->delayed_set_alt_lock, flags);
! 		if (fu->delayed_set_alt_state != USBG_DELAYED_SET_ALT_IDLE) {
! 			spin_unlock_irqrestore(&fu->delayed_set_alt_lock,
! 					       flags);
! 			return -EBUSY;
! 		}
! 		fu->delayed_alt = alt;
! 		fu->delayed_set_alt_cancel = false;
! 		fu->delayed_set_alt_state = USBG_DELAYED_SET_ALT_QUEUED;
! 		spin_unlock_irqrestore(&fu->delayed_set_alt_lock, flags);
! 
! 		schedule_work(&fu->delayed_set_alt);
  		return USB_GADGET_DELAYED_STATUS;
  	}
  	return -EOPNOTSUPP;
*************** static void tcm_disable(struct usb_funct
*** 2082,2092 ****
  {
  	struct f_uas *fu = to_f_uas(f);
  
! 	if (fu->flags & USBG_IS_UAS)
! 		uasp_cleanup_old_alt(fu);
! 	else if (fu->flags & USBG_IS_BOT)
! 		bot_cleanup_old_alt(fu);
! 	fu->flags = 0;
  }
  
  static int tcm_setup(struct usb_function *f,
--- 2217,2224 ----
  {
  	struct f_uas *fu = to_f_uas(f);
  
! 	if (tcm_cancel_delayed_set_alt(fu))
! 		tcm_cleanup_old_alt(fu);
  }
  
  static int tcm_setup(struct usb_function *f,
*************** static int tcm_set_name(struct usb_funct
*** 2188,2196 ****
  
  	pr_debug("tcm: Activating %s\n", name);
  
! 	mutex_lock(&opts->dep_lock);
! 	opts->ready = true;
! 	mutex_unlock(&opts->dep_lock);
  
  	return 0;
  }
--- 2320,2326 ----
  
  	pr_debug("tcm: Activating %s\n", name);
  
! 	WRITE_ONCE(opts->ready, true);
  
  	return 0;
  }
*************** static void tcm_free(struct usb_function
*** 2234,2244 ****
--- 2364,2379 ----
  {
  	struct f_uas *tcm = to_f_uas(f);
  
+ 	tcm_cancel_delayed_set_alt_sync(tcm);
  	kfree(tcm);
  }
  
  static void tcm_unbind(struct usb_configuration *c, struct usb_function *f)
  {
+ 	struct f_uas *fu = to_f_uas(f);
+ 
+ 	tcm_cancel_delayed_set_alt_sync(fu);
+ 	tcm_cleanup_old_alt(fu);
  	usb_free_all_descriptors(f);
  }
  
*************** static struct usb_function *tcm_alloc(st
*** 2271,2276 ****
--- 2406,2413 ----
  	fu->function.disable = tcm_disable;
  	fu->function.free_func = tcm_free;
  	fu->tpg = tpg_instances[i].tpg;
+ 	INIT_WORK(&fu->delayed_set_alt, tcm_delayed_set_alt);
+ 	spin_lock_init(&fu->delayed_set_alt_lock);
  	mutex_unlock(&tpg_instances_lock);
  
  	return &fu->function;
```

```console
shell$ diff -p linux-6.12.100/drivers/usb/gadget/function/f_tcm.c linux-6.12.100-xlnx-v2025.1/drivers/usb/gadget/function/f_tcm.c
diff -p linux-6.12.100/drivers/usb/gadget/function/f_tcm.c linux-6.12.100-xlnx-v2025.1/drivers/usb/gadget/function/f_tcm.c
*** linux-6.12.100/drivers/usb/gadget/function/f_tcm.c	2026-08-05 10:45:16.728312081 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/usb/gadget/function/f_tcm.c	2026-10-11 08:40:50.897395938 +0900
*************** static ssize_t tcm_usbg_tpg_nexus_store(
*** 1629,1636 ****
--- 1629,1638 ----
  
  CONFIGFS_ATTR(tcm_usbg_tpg_, nexus);
  
+ static struct configfs_attribute tcm_usbg_tpg_attr_maxburst;
  static struct configfs_attribute *usbg_base_attrs[] = {
  	&tcm_usbg_tpg_attr_nexus,
+ 	&tcm_usbg_tpg_attr_maxburst,
  	NULL,
  };
  
*************** static struct usb_gadget_strings *tcm_st
*** 1935,1940 ****
--- 1937,1968 ----
  	NULL,
  };
  
+ static ssize_t tcm_usbg_tpg_maxburst_show(struct config_item *item, char *page)
+ {
+ 	return snprintf(page, PAGE_SIZE, "%u\n", uasp_cmd_comp_desc.bMaxBurst);
+ }
+ 
+ static ssize_t tcm_usbg_tpg_maxburst_store(struct config_item *item,
+ 					   const char *page, size_t count)
+ {
+ 	int value;
+ 	int ret;
+ 
+ 	ret = kstrtouint(page, 10, &value);
+ 	if (ret)
+ 		return ret;
+ 
+ 	uasp_bi_ep_comp_desc.bMaxBurst = value;
+ 	uasp_bo_ep_comp_desc.bMaxBurst = value;
+ 	uasp_status_in_ep_comp_desc.bMaxBurst = value;
+ 	uasp_cmd_comp_desc.bMaxBurst = value;
+ 	bot_bi_ep_comp_desc.bMaxBurst = value;
+ 	bot_bo_ep_comp_desc.bMaxBurst = value;
+ 
+ 	return count;
+ }
+ CONFIGFS_ATTR(tcm_usbg_tpg_, maxburst);
+ 
  static int tcm_bind(struct usb_configuration *c, struct usb_function *f)
  {
  	struct f_uas		*fu = to_f_uas(f);
```

####### Make 263_drivers-usb-gadget.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/263_drivers-usb-gadget.patch
patching file drivers/usb/gadget/function/f_tcm.c
Hunk #1 succeeded at 1632 (offset 3 lines).
Hunk #2 succeeded at 1940 (offset 3 lines).
```

```console
shell$ rm drivers/usb/gadget/function/f_tcm.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 263_drivers-usb-gadget.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/263_drivers-usb-gadget.patch
```

###### 264_drivers-usb-host.patch

####### drivers/usb/host/xhci.h

```console
shell$ diff -p linux-6.12.100/drivers/usb/host/xhci.h linux-6.12.109/drivers/usb/host/xhci.h 
*** linux-6.12.100/drivers/usb/host/xhci.h	2026-08-05 10:45:16.747879073 +0900
--- linux-6.12.109/drivers/usb/host/xhci.h	2026-10-09 15:27:33.367051511 +0900
*************** struct xhci_hcd {
*** 1510,1515 ****
--- 1510,1516 ----
  	/* imod_interval in ns (I * 250ns) */
  	u32		imod_interval;
  	u32		page_size;
+ 	unsigned int	dma_mask_bits;
  	/* MSI-X/MSI vectors */
  	int		nvecs;
  	/* optional clocks */
```

```console
shell$ diff -p linux-6.12.100/drivers/usb/host/xhci.h linux-6.12.100-xlnx-v2025.1/drivers/usb/host/xhci.h
*** linux-6.12.100/drivers/usb/host/xhci.h	2026-08-05 10:45:16.747879073 +0900
--- linux-6.12.100-xlnx-v2025.1/drivers/usb/host/xhci.h	2026-10-11 08:40:51.236698348 +0900
*************** void xhci_remove_secondary_interrupter(s
*** 1849,1854 ****
--- 1849,1862 ----
  
  /* xHCI host controller glue */
  typedef void (*xhci_get_quirks_t)(struct device *, struct xhci_hcd *);
+ typedef void (*host_wakeup_t)(struct device *dev, bool wakeup);
+ #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE) || \
+ 	IS_ENABLED(CONFIG_USB_DWC3_OTG)
+ void dwc3_host_wakeup_capable(struct device *dev, bool wakeup);
+ #else
+ static inline void dwc3_host_wakeup_capable(struct device *dev, bool wakeup)
+ { }
+ #endif
  int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, u64 timeout_us);
  void xhci_quiesce(struct xhci_hcd *xhci);
  int xhci_halt(struct xhci_hcd *xhci);
```

####### Make 264_drivers-usb-host.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
Hunk #1 succeeded at 1850 (offset 1 line).
```

```console
shell$ rm drivers/usb/host/xhci.h.orig
shell$ git add --all
shell$ git commit -m '[patch] 264_drivers-usb-host.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/264_drivers-usb-host.patch
```

###### 301_sound-soc-xilinx.patch

####### sound/soc/xilinx/xlnx_formatter_pcm.c

```console
shell$ diff -p linux-6.12.100/sound/soc/xilinx/xlnx_formatter_pcm.c linux-6.12.109/sound/soc/xilinx/xlnx_formatter_pcm.c
*** linux-6.12.100/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-08-05 10:45:17.663614348 +0900
--- linux-6.12.109/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-09 15:27:34.279525563 +0900
*************** static irqreturn_t xlnx_mm2s_irq_handler
*** 281,288 ****
  {
  	u32 val;
  	void __iomem *reg;
! 	struct device *dev = arg;
! 	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
  	val = readl(reg);
--- 281,287 ----
  {
  	u32 val;
  	void __iomem *reg;
! 	struct xlnx_pcm_drv_data *adata = arg;
  
  	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
  	val = readl(reg);
*************** static irqreturn_t xlnx_s2mm_irq_handler
*** 300,307 ****
  {
  	u32 val;
  	void __iomem *reg;
! 	struct device *dev = arg;
! 	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
  	val = readl(reg);
--- 299,305 ----
  {
  	u32 val;
  	void __iomem *reg;
! 	struct xlnx_pcm_drv_data *adata = arg;
  
  	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
  	val = readl(reg);
*************** static int xlnx_formatter_pcm_probe(stru
*** 637,643 ****
  		}
  		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
  				       xlnx_mm2s_irq_handler, 0,
! 				       "xlnx_formatter_pcm_mm2s_irq", dev);
  		if (ret) {
  			dev_err(dev, "xlnx audio mm2s irq request failed\n");
  			goto clk_err;
--- 635,641 ----
  		}
  		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
  				       xlnx_mm2s_irq_handler, 0,
! 				       "xlnx_formatter_pcm_mm2s_irq", aud_drv_data);
  		if (ret) {
  			dev_err(dev, "xlnx audio mm2s irq request failed\n");
  			goto clk_err;
*************** static int xlnx_formatter_pcm_probe(stru
*** 664,670 ****
  		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
  				       xlnx_s2mm_irq_handler, 0,
  				       "xlnx_formatter_pcm_s2mm_irq",
! 				       dev);
  		if (ret) {
  			dev_err(dev, "xlnx audio s2mm irq request failed\n");
  			goto clk_err;
--- 662,668 ----
  		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
  				       xlnx_s2mm_irq_handler, 0,
  				       "xlnx_formatter_pcm_s2mm_irq",
! 				       aud_drv_data);
  		if (ret) {
  			dev_err(dev, "xlnx audio s2mm irq request failed\n");
  			goto clk_err;
```

```console
shell$ diff -p linux-6.12.100/sound/soc/xilinx/xlnx_formatter_pcm.c linux-6.12.100-xlnx-v2025.1/sound/soc/xilinx/xlnx_formatter_pcm.c
*** linux-6.12.100/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-08-05 10:45:17.663614348 +0900
--- linux-6.12.100-xlnx-v2025.1/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-11 08:40:52.678694815 +0900
***************
*** 1,22 ****
  // SPDX-License-Identifier: GPL-2.0
! //
! // Xilinx ASoC audio formatter support
! //
! // Copyright (C) 2018 Xilinx, Inc.
! //
! // Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
  
  #include <linux/clk.h>
  #include <linux/io.h>
  #include <linux/module.h>
  #include <linux/of_address.h>
  #include <linux/of_irq.h>
  #include <linux/sizes.h>
  
  #include <sound/asoundef.h>
  #include <sound/soc.h>
  #include <sound/pcm_params.h>
  
  #define DRV_NAME "xlnx_formatter_pcm"
  
  #define XLNX_S2MM_OFFSET	0
--- 1,26 ----
  // SPDX-License-Identifier: GPL-2.0
! /*
!  * Xilinx ASoC audio formatter support
!  *
!  * Copyright (C) 2018 Xilinx, Inc.
!  *
!  */
  
  #include <linux/clk.h>
+ #include <linux/dma-mapping.h>
  #include <linux/io.h>
  #include <linux/module.h>
  #include <linux/of_address.h>
  #include <linux/of_irq.h>
+ #include <linux/platform_device.h>
  #include <linux/sizes.h>
  
  #include <sound/asoundef.h>
  #include <sound/soc.h>
  #include <sound/pcm_params.h>
  
+ #include "xlnx_snd_common.h"
+ 
  #define DRV_NAME "xlnx_formatter_pcm"
  
  #define XLNX_S2MM_OFFSET	0
***************
*** 57,63 ****
--- 61,69 ----
  #define CFG_S2MM_XFER_SHIFT	29
  #define CFG_S2MM_PKG_MASK	BIT(28)
  
+ #define AUD_CTRL_DATA_WIDTH_MASK	GENMASK(18, 16)
  #define AUD_CTRL_DATA_WIDTH_SHIFT	16
+ #define AUD_CTRL_ACTIVE_CH_MASK		GENMASK(22, 19)
  #define AUD_CTRL_ACTIVE_CH_SHIFT	19
  #define PERIOD_CFG_PERIODS_SHIFT	16
  
*************** struct xlnx_pcm_drv_data {
*** 83,89 ****
--- 89,100 ----
  	int mm2s_irq;
  	struct snd_pcm_substream *play_stream;
  	struct snd_pcm_substream *capture_stream;
+ 	struct platform_device *pdev;
+ 	struct device_node *nodes[XLNX_MAX_PATHS];
  	struct clk *axi_clk;
+ 	struct clk *mm2s_axis_clk;
+ 	struct clk *s2mm_axis_clk;
+ 	struct clk *aud_mclk;
  	unsigned int sysclk;
  };
  
*************** static const struct snd_pcm_hardware xln
*** 110,116 ****
  	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
  		   SNDRV_PCM_FMTBIT_S24_LE,
  	.channels_min = 2,
! 	.channels_max = 2,
  	.rates = SNDRV_PCM_RATE_8000_192000,
  	.rate_min = 8000,
  	.rate_max = 192000,
--- 121,127 ----
  	.formats = SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
  		   SNDRV_PCM_FMTBIT_S24_LE,
  	.channels_min = 2,
! 	.channels_max = 8,
  	.rates = SNDRV_PCM_RATE_8000_192000,
  	.rate_min = 8000,
  	.rate_max = 192000,
*************** static int xlnx_formatter_pcm_reset(void
*** 248,263 ****
  {
  	u32 val, retries = 0;
  
! 	val = readl(mmio_base + XLNX_AUD_CTRL);
  	val |= AUD_CTRL_RESET_MASK;
! 	writel(val, mmio_base + XLNX_AUD_CTRL);
  
! 	val = readl(mmio_base + XLNX_AUD_CTRL);
  	/* Poll for maximum timeout of approximately 100ms (1 * 100)*/
  	while ((val & AUD_CTRL_RESET_MASK) && (retries < 100)) {
  		mdelay(1);
  		retries++;
! 		val = readl(mmio_base + XLNX_AUD_CTRL);
  	}
  	if (val & AUD_CTRL_RESET_MASK)
  		return -ENODEV;
--- 259,274 ----
  {
  	u32 val, retries = 0;
  
! 	val = ioread32(mmio_base + XLNX_AUD_CTRL);
  	val |= AUD_CTRL_RESET_MASK;
! 	iowrite32(val, mmio_base + XLNX_AUD_CTRL);
  
! 	val = ioread32(mmio_base + XLNX_AUD_CTRL);
  	/* Poll for maximum timeout of approximately 100ms (1 * 100)*/
  	while ((val & AUD_CTRL_RESET_MASK) && (retries < 100)) {
  		mdelay(1);
  		retries++;
! 		val = ioread32(mmio_base + XLNX_AUD_CTRL);
  	}
  	if (val & AUD_CTRL_RESET_MASK)
  		return -ENODEV;
*************** static void xlnx_formatter_disable_irqs(
*** 269,280 ****
  {
  	u32 val;
  
! 	val = readl(mmio_base + XLNX_AUD_CTRL);
  	val &= ~AUD_CTRL_IOC_IRQ_MASK;
  	if (stream == SNDRV_PCM_STREAM_CAPTURE)
  		val &= ~AUD_CTRL_TOUT_IRQ_MASK;
  
! 	writel(val, mmio_base + XLNX_AUD_CTRL);
  }
  
  static irqreturn_t xlnx_mm2s_irq_handler(int irq, void *arg)
--- 280,291 ----
  {
  	u32 val;
  
! 	val = ioread32(mmio_base + XLNX_AUD_CTRL);
  	val &= ~AUD_CTRL_IOC_IRQ_MASK;
  	if (stream == SNDRV_PCM_STREAM_CAPTURE)
  		val &= ~AUD_CTRL_TOUT_IRQ_MASK;
  
! 	iowrite32(val, mmio_base + XLNX_AUD_CTRL);
  }
  
  static irqreturn_t xlnx_mm2s_irq_handler(int irq, void *arg)
*************** static irqreturn_t xlnx_mm2s_irq_handler
*** 285,293 ****
  	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
! 	val = readl(reg);
  	if (val & AUD_STS_IOC_IRQ_MASK) {
! 		writel(val & AUD_STS_IOC_IRQ_MASK, reg);
  		if (adata->play_stream)
  			snd_pcm_period_elapsed(adata->play_stream);
  		return IRQ_HANDLED;
--- 296,304 ----
  	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
! 	val = ioread32(reg);
  	if (val & AUD_STS_IOC_IRQ_MASK) {
! 		iowrite32(val & AUD_STS_IOC_IRQ_MASK, reg);
  		if (adata->play_stream)
  			snd_pcm_period_elapsed(adata->play_stream);
  		return IRQ_HANDLED;
*************** static irqreturn_t xlnx_s2mm_irq_handler
*** 304,312 ****
  	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
! 	val = readl(reg);
  	if (val & AUD_STS_IOC_IRQ_MASK) {
! 		writel(val & AUD_STS_IOC_IRQ_MASK, reg);
  		if (adata->capture_stream)
  			snd_pcm_period_elapsed(adata->capture_stream);
  		return IRQ_HANDLED;
--- 315,323 ----
  	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
  
  	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
! 	val = ioread32(reg);
  	if (val & AUD_STS_IOC_IRQ_MASK) {
! 		iowrite32(val & AUD_STS_IOC_IRQ_MASK, reg);
  		if (adata->capture_stream)
  			snd_pcm_period_elapsed(adata->capture_stream);
  		return IRQ_HANDLED;
*************** static int xlnx_formatter_pcm_open(struc
*** 332,338 ****
  	u32 ch_count_mask, ch_count_shift, data_xfer_mode, data_xfer_shift;
  	struct xlnx_pcm_stream_param *stream_data;
  	struct snd_pcm_runtime *runtime = substream->runtime;
! 	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(component->dev);
  
  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
  	    !adata->mm2s_presence)
--- 343,354 ----
  	u32 ch_count_mask, ch_count_shift, data_xfer_mode, data_xfer_shift;
  	struct xlnx_pcm_stream_param *stream_data;
  	struct snd_pcm_runtime *runtime = substream->runtime;
! 	struct xlnx_pcm_drv_data *adata;
! 
! 	if (!component)
! 		return -ENODEV;
! 
! 	adata = dev_get_drvdata(component->dev);
  
  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
  	    !adata->mm2s_presence)
*************** static int xlnx_formatter_pcm_open(struc
*** 364,373 ****
  		adata->capture_stream = substream;
  	}
  
! 	val = readl(adata->mmio + XLNX_AUD_CORE_CONFIG);
  
  	if (!(val & data_format_mode))
  		stream_data->interleaved = true;
  
  	stream_data->xfer_mode = (val & data_xfer_mode) >> data_xfer_shift;
  	stream_data->ch_limit = (val & ch_count_mask) >> ch_count_shift;
--- 380,391 ----
  		adata->capture_stream = substream;
  	}
  
! 	val = ioread32(adata->mmio + XLNX_AUD_CORE_CONFIG);
  
  	if (!(val & data_format_mode))
  		stream_data->interleaved = true;
+ 	else
+ 		stream_data->interleaved = false;
  
  	stream_data->xfer_mode = (val & data_xfer_mode) >> data_xfer_shift;
  	stream_data->ch_limit = (val & ch_count_mask) >> ch_count_shift;
*************** static int xlnx_formatter_pcm_open(struc
*** 409,417 ****
  	}
  
  	/* enable DMA IOC irq */
! 	val = readl(stream_data->mmio + XLNX_AUD_CTRL);
  	val |= AUD_CTRL_IOC_IRQ_MASK;
! 	writel(val, stream_data->mmio + XLNX_AUD_CTRL);
  
  	return 0;
  }
--- 427,435 ----
  	}
  
  	/* enable DMA IOC irq */
! 	val = ioread32(stream_data->mmio + XLNX_AUD_CTRL);
  	val |= AUD_CTRL_IOC_IRQ_MASK;
! 	iowrite32(val, stream_data->mmio + XLNX_AUD_CTRL);
  
  	return 0;
  }
*************** static int xlnx_formatter_pcm_close(stru
*** 423,428 ****
--- 441,449 ----
  	struct xlnx_pcm_stream_param *stream_data =
  			substream->runtime->private_data;
  
+ 	if (!component)
+ 		return -ENODEV;
+ 
  	ret = xlnx_formatter_pcm_reset(stream_data->mmio);
  	if (ret) {
  		dev_err(component->dev, "audio formatter reset failed\n");
*************** xlnx_formatter_pcm_pointer(struct snd_so
*** 443,449 ****
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
  
! 	pos = readl(stream_data->mmio + XLNX_AUD_XFER_COUNT);
  
  	if (pos >= stream_data->buffer_size)
  		pos = 0;
--- 464,470 ----
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
  
! 	pos = ioread32(stream_data->mmio + XLNX_AUD_XFER_COUNT);
  
  	if (pos >= stream_data->buffer_size)
  		pos = 0;
*************** static int xlnx_formatter_pcm_hw_params(
*** 455,466 ****
  					struct snd_pcm_substream *substream,
  					struct snd_pcm_hw_params *params)
  {
! 	u32 low, high, active_ch, val, bytes_per_ch, bits_per_sample;
  	u32 aes_reg1_val, aes_reg2_val;
  	u64 size;
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
! 	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(component->dev);
  
  	active_ch = params_channels(params);
  	if (active_ch > stream_data->ch_limit)
--- 476,495 ----
  					struct snd_pcm_substream *substream,
  					struct snd_pcm_hw_params *params)
  {
! 	u32 low, high, active_ch, val, bits_per_sample, bytes_per_ch;
  	u32 aes_reg1_val, aes_reg2_val;
+ 	int status;
  	u64 size;
+ 	struct pl_card_data *prv;
  	struct snd_pcm_runtime *runtime = substream->runtime;
  	struct xlnx_pcm_stream_param *stream_data = runtime->private_data;
! 	struct xlnx_pcm_drv_data *adata;
! 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
! 
! 	if (!component)
! 		return -ENODEV;
! 
! 	adata = dev_get_drvdata(component->dev);
  
  	active_ch = params_channels(params);
  	if (active_ch > stream_data->ch_limit)
*************** static int xlnx_formatter_pcm_hw_params(
*** 480,492 ****
  	}
  
  	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
! 	    stream_data->xfer_mode == AES_TO_PCM) {
! 		val = readl(stream_data->mmio + XLNX_AUD_STS);
  		if (val & AUD_STS_CH_STS_MASK) {
! 			aes_reg1_val = readl(stream_data->mmio +
! 					     XLNX_AUD_CH_STS_START);
! 			aes_reg2_val = readl(stream_data->mmio +
! 					     XLNX_AUD_CH_STS_START + 0x4);
  
  			xlnx_parse_aes_params(aes_reg1_val, aes_reg2_val,
  					      component->dev);
--- 509,528 ----
  	}
  
  	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
! 	    stream_data->xfer_mode == AES_TO_PCM &&
! 	    ((strstr(adata->nodes[XLNX_CAPTURE]->name, "hdmi")) ||
! 	    (strstr(adata->nodes[XLNX_CAPTURE]->name, "sdi")) ||
! 	    (strstr(adata->nodes[XLNX_CAPTURE]->name, "dp")))) {
! 		/*
! 		 * If formatter is in AES_PCM mode for HDMI/SDI capture path,
! 		 * parse AES header
! 		 */
! 		val = ioread32(stream_data->mmio + XLNX_AUD_STS);
  		if (val & AUD_STS_CH_STS_MASK) {
! 			aes_reg1_val = ioread32(stream_data->mmio +
! 					 XLNX_AUD_CH_STS_START);
! 			aes_reg2_val = ioread32(stream_data->mmio +
! 					 XLNX_AUD_CH_STS_START + 0x4);
  
  			xlnx_parse_aes_params(aes_reg1_val, aes_reg2_val,
  					      component->dev);
*************** static int xlnx_formatter_pcm_hw_params(
*** 494,508 ****
  	}
  
  	size = params_buffer_bytes(params);
  
  	stream_data->buffer_size = size;
  
  	low = lower_32_bits(runtime->dma_addr);
  	high = upper_32_bits(runtime->dma_addr);
! 	writel(low, stream_data->mmio + XLNX_AUD_BUFF_ADDR_LSB);
! 	writel(high, stream_data->mmio + XLNX_AUD_BUFF_ADDR_MSB);
  
! 	val = readl(stream_data->mmio + XLNX_AUD_CTRL);
  	bits_per_sample = params_width(params);
  	switch (bits_per_sample) {
  	case 8:
--- 530,548 ----
  	}
  
  	size = params_buffer_bytes(params);
+ 	status = snd_pcm_lib_malloc_pages(substream, size);
+ 	if (status < 0)
+ 		return status;
  
  	stream_data->buffer_size = size;
  
  	low = lower_32_bits(runtime->dma_addr);
  	high = upper_32_bits(runtime->dma_addr);
! 	iowrite32(low, stream_data->mmio + XLNX_AUD_BUFF_ADDR_LSB);
! 	iowrite32(high, stream_data->mmio + XLNX_AUD_BUFF_ADDR_MSB);
  
! 	val = ioread32(stream_data->mmio + XLNX_AUD_CTRL);
! 	val &= ~AUD_CTRL_DATA_WIDTH_MASK;
  	bits_per_sample = params_width(params);
  	switch (bits_per_sample) {
  	case 8:
*************** static int xlnx_formatter_pcm_hw_params(
*** 520,544 ****
  	case 32:
  		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
  		break;
- 	default:
- 		return -EINVAL;
  	}
  
  	val |= active_ch << AUD_CTRL_ACTIVE_CH_SHIFT;
! 	writel(val, stream_data->mmio + XLNX_AUD_CTRL);
  
  	val = (params_periods(params) << PERIOD_CFG_PERIODS_SHIFT)
  		| params_period_bytes(params);
! 	writel(val, stream_data->mmio + XLNX_AUD_PERIOD_CONFIG);
  	bytes_per_ch = DIV_ROUND_UP(params_period_bytes(params), active_ch);
! 	writel(bytes_per_ch, stream_data->mmio + XLNX_BYTES_PER_CH);
  
  	return 0;
  }
  
  static int xlnx_formatter_pcm_trigger(struct snd_soc_component *component,
! 				      struct snd_pcm_substream *substream,
! 				      int cmd)
  {
  	u32 val;
  	struct xlnx_pcm_stream_param *stream_data =
--- 560,594 ----
  	case 32:
  		val |= (BIT_DEPTH_32 << AUD_CTRL_DATA_WIDTH_SHIFT);
  		break;
  	}
  
+ 	val &= ~AUD_CTRL_ACTIVE_CH_MASK;
  	val |= active_ch << AUD_CTRL_ACTIVE_CH_SHIFT;
! 	iowrite32(val, stream_data->mmio + XLNX_AUD_CTRL);
  
  	val = (params_periods(params) << PERIOD_CFG_PERIODS_SHIFT)
  		| params_period_bytes(params);
! 	iowrite32(val, stream_data->mmio + XLNX_AUD_PERIOD_CONFIG);
  	bytes_per_ch = DIV_ROUND_UP(params_period_bytes(params), active_ch);
! 	iowrite32(bytes_per_ch, stream_data->mmio + XLNX_BYTES_PER_CH);
! 
! 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
! 		prv = snd_soc_card_get_drvdata(rtd->card);
! 		iowrite32(prv->mclk_ratio,
! 			  stream_data->mmio + XLNX_AUD_FS_MULTIPLIER);
! 	}
  
  	return 0;
  }
  
+ static int xlnx_formatter_pcm_hw_free(struct snd_soc_component *component,
+ 				      struct snd_pcm_substream *substream)
+ {
+ 	return snd_pcm_lib_free_pages(substream);
+ }
+ 
  static int xlnx_formatter_pcm_trigger(struct snd_soc_component *component,
! 				      struct snd_pcm_substream *substream, int cmd)
  {
  	u32 val;
  	struct xlnx_pcm_stream_param *stream_data =
*************** static int xlnx_formatter_pcm_trigger(st
*** 548,563 ****
  	case SNDRV_PCM_TRIGGER_START:
  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
  	case SNDRV_PCM_TRIGGER_RESUME:
! 		val = readl(stream_data->mmio + XLNX_AUD_CTRL);
  		val |= AUD_CTRL_DMA_EN_MASK;
! 		writel(val, stream_data->mmio + XLNX_AUD_CTRL);
  		break;
  	case SNDRV_PCM_TRIGGER_STOP:
  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
  	case SNDRV_PCM_TRIGGER_SUSPEND:
! 		val = readl(stream_data->mmio + XLNX_AUD_CTRL);
  		val &= ~AUD_CTRL_DMA_EN_MASK;
! 		writel(val, stream_data->mmio + XLNX_AUD_CTRL);
  		break;
  	}
  
--- 598,613 ----
  	case SNDRV_PCM_TRIGGER_START:
  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
  	case SNDRV_PCM_TRIGGER_RESUME:
! 		val = ioread32(stream_data->mmio + XLNX_AUD_CTRL);
  		val |= AUD_CTRL_DMA_EN_MASK;
! 		iowrite32(val, stream_data->mmio + XLNX_AUD_CTRL);
  		break;
  	case SNDRV_PCM_TRIGGER_STOP:
  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
  	case SNDRV_PCM_TRIGGER_SUSPEND:
! 		val = ioread32(stream_data->mmio + XLNX_AUD_CTRL);
  		val &= ~AUD_CTRL_DMA_EN_MASK;
! 		iowrite32(val, stream_data->mmio + XLNX_AUD_CTRL);
  		break;
  	}
  
*************** static int xlnx_formatter_pcm_trigger(st
*** 567,594 ****
  static int xlnx_formatter_pcm_new(struct snd_soc_component *component,
  				  struct snd_soc_pcm_runtime *rtd)
  {
! 	snd_pcm_set_managed_buffer_all(rtd->pcm,
! 			SNDRV_DMA_TYPE_DEV, component->dev,
! 			xlnx_pcm_hardware.buffer_bytes_max,
! 			xlnx_pcm_hardware.buffer_bytes_max);
  	return 0;
  }
  
  static const struct snd_soc_component_driver xlnx_asoc_component = {
! 	.name			= DRV_NAME,
! 	.set_sysclk		= xlnx_formatter_set_sysclk,
! 	.open			= xlnx_formatter_pcm_open,
! 	.close			= xlnx_formatter_pcm_close,
! 	.hw_params		= xlnx_formatter_pcm_hw_params,
! 	.trigger		= xlnx_formatter_pcm_trigger,
! 	.pointer		= xlnx_formatter_pcm_pointer,
! 	.pcm_construct		= xlnx_formatter_pcm_new,
  };
  
  static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
  {
  	int ret;
  	u32 val;
  	struct xlnx_pcm_drv_data *aud_drv_data;
  	struct device *dev = &pdev->dev;
  
--- 617,755 ----
  static int xlnx_formatter_pcm_new(struct snd_soc_component *component,
  				  struct snd_soc_pcm_runtime *rtd)
  {
! 	if (!component)
! 		return -ENODEV;
! 
! 	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
! 					      SNDRV_DMA_TYPE_DEV,
! 					      component->dev,
! 					      xlnx_pcm_hardware.buffer_bytes_max,
! 					      xlnx_pcm_hardware.buffer_bytes_max);
  	return 0;
  }
  
  static const struct snd_soc_component_driver xlnx_asoc_component = {
! 	.name		= DRV_NAME,
! 	.set_sysclk	= xlnx_formatter_set_sysclk,
! 	.open		= xlnx_formatter_pcm_open,
! 	.close		= xlnx_formatter_pcm_close,
! 	.hw_params	= xlnx_formatter_pcm_hw_params,
! 	.hw_free	= xlnx_formatter_pcm_hw_free,
! 	.trigger	= xlnx_formatter_pcm_trigger,
! 	.pointer	= xlnx_formatter_pcm_pointer,
! 	.pcm_construct	= xlnx_formatter_pcm_new,
  };
  
+ static int configure_mm2s(struct xlnx_pcm_drv_data *aud_drv_data,
+ 			  struct platform_device *pdev)
+ {
+ 	int ret;
+ 	struct device *dev = &pdev->dev;
+ 
+ 	aud_drv_data->mm2s_axis_clk = devm_clk_get_enabled(dev, "m_axis_mm2s_aclk");
+ 	if (IS_ERR(aud_drv_data->mm2s_axis_clk)) {
+ 		ret = PTR_ERR(aud_drv_data->mm2s_axis_clk);
+ 		dev_err(dev, "failed to get m_axis_mm2s_aclk(%d)\n", ret);
+ 		return ret;
+ 	}
+ 
+ 	aud_drv_data->aud_mclk = devm_clk_get_enabled(dev, "aud_mclk");
+ 	if (IS_ERR(aud_drv_data->aud_mclk)) {
+ 		ret = PTR_ERR(aud_drv_data->aud_mclk);
+ 		dev_err(dev, "failed to get aud_mclk(%d)\n", ret);
+ 		return ret;
+ 	}
+ 
+ 	aud_drv_data->mm2s_irq = platform_get_irq_byname(pdev,
+ 							 "irq_mm2s");
+ 	if (aud_drv_data->mm2s_irq < 0)
+ 		return aud_drv_data->mm2s_irq;
+ 
+ 	ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
+ 			       xlnx_mm2s_irq_handler, 0,
+ 			       "xlnx_formatter_pcm_mm2s_irq", dev);
+ 	if (ret) {
+ 		dev_err(dev, "xlnx audio mm2s irq request failed\n");
+ 		return ret;
+ 	}
+ 	ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
+ 				       XLNX_MM2S_OFFSET);
+ 	if (ret) {
+ 		dev_err(dev, "audio formatter reset failed\n");
+ 		return ret;
+ 	}
+ 	xlnx_formatter_disable_irqs(aud_drv_data->mmio +
+ 				    XLNX_MM2S_OFFSET,
+ 				    SNDRV_PCM_STREAM_PLAYBACK);
+ 
+ 	aud_drv_data->nodes[XLNX_PLAYBACK] =
+ 		of_parse_phandle(dev->of_node, "xlnx,tx", 0);
+ 	if (!aud_drv_data->nodes[XLNX_PLAYBACK])
+ 		dev_err(dev, "tx node not found\n");
+ 	else
+ 		dev_info(dev,
+ 			 "sound card device will use DAI link: %s\n",
+ 			 (aud_drv_data->nodes[XLNX_PLAYBACK])->name);
+ 	of_node_put(aud_drv_data->nodes[XLNX_PLAYBACK]);
+ 
+ 	aud_drv_data->mm2s_presence = true;
+ 	return 0;
+ }
+ 
+ static int configure_s2mm(struct xlnx_pcm_drv_data *aud_drv_data,
+ 			  struct platform_device *pdev)
+ {
+ 	int ret;
+ 	struct device *dev = &pdev->dev;
+ 
+ 	aud_drv_data->s2mm_axis_clk = devm_clk_get_enabled(dev, "s_axis_s2mm_aclk");
+ 	if (IS_ERR(aud_drv_data->s2mm_axis_clk)) {
+ 		ret = PTR_ERR(aud_drv_data->s2mm_axis_clk);
+ 		dev_err(dev, "failed to get s_axis_s2mm_aclk(%d)\n", ret);
+ 		return ret;
+ 	}
+ 
+ 	aud_drv_data->s2mm_irq = platform_get_irq_byname(pdev,
+ 							 "irq_s2mm");
+ 	if (aud_drv_data->s2mm_irq < 0)
+ 		return aud_drv_data->s2mm_irq;
+ 
+ 	ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
+ 			       xlnx_s2mm_irq_handler, 0,
+ 			       "xlnx_formatter_pcm_s2mm_irq",
+ 			       dev);
+ 	if (ret) {
+ 		dev_err(dev, "xlnx audio s2mm irq request failed\n");
+ 		return ret;
+ 	}
+ 	ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
+ 				       XLNX_S2MM_OFFSET);
+ 	if (ret) {
+ 		dev_err(dev, "audio formatter reset failed\n");
+ 		return ret;
+ 	}
+ 	xlnx_formatter_disable_irqs(aud_drv_data->mmio +
+ 				    XLNX_S2MM_OFFSET,
+ 				    SNDRV_PCM_STREAM_CAPTURE);
+ 
+ 	aud_drv_data->nodes[XLNX_CAPTURE] =
+ 		of_parse_phandle(dev->of_node, "xlnx,rx", 0);
+ 	if (!aud_drv_data->nodes[XLNX_CAPTURE])
+ 		dev_err(dev, "rx node not found\n");
+ 	else
+ 		dev_info(dev, "sound card device will use DAI link: %s\n",
+ 			 (aud_drv_data->nodes[XLNX_CAPTURE])->name);
+ 	of_node_put(aud_drv_data->nodes[XLNX_CAPTURE]);
+ 
+ 	aud_drv_data->s2mm_presence = true;
+ 	return 0;
+ }
+ 
  static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
  {
  	int ret;
  	u32 val;
+ 	size_t pdata_size;
  	struct xlnx_pcm_drv_data *aud_drv_data;
  	struct device *dev = &pdev->dev;
  
*************** static int xlnx_formatter_pcm_probe(stru
*** 596,674 ****
  	if (!aud_drv_data)
  		return -ENOMEM;
  
! 	aud_drv_data->axi_clk = devm_clk_get(dev, "s_axi_lite_aclk");
  	if (IS_ERR(aud_drv_data->axi_clk)) {
  		ret = PTR_ERR(aud_drv_data->axi_clk);
  		dev_err(dev, "failed to get s_axi_lite_aclk(%d)\n", ret);
  		return ret;
  	}
- 	ret = clk_prepare_enable(aud_drv_data->axi_clk);
- 	if (ret) {
- 		dev_err(dev,
- 			"failed to enable s_axi_lite_aclk(%d)\n", ret);
- 		return ret;
- 	}
  
  	aud_drv_data->mmio = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(aud_drv_data->mmio)) {
  		dev_err(dev, "audio formatter ioremap failed\n");
! 		ret = PTR_ERR(aud_drv_data->mmio);
! 		goto clk_err;
  	}
  
! 	val = readl(aud_drv_data->mmio + XLNX_AUD_CORE_CONFIG);
  	if (val & AUD_CFG_MM2S_MASK) {
! 		aud_drv_data->mm2s_presence = true;
! 		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
! 					       XLNX_MM2S_OFFSET);
! 		if (ret) {
! 			dev_err(dev, "audio formatter reset failed\n");
! 			goto clk_err;
! 		}
! 		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
! 					    XLNX_MM2S_OFFSET,
! 					    SNDRV_PCM_STREAM_PLAYBACK);
! 
! 		aud_drv_data->mm2s_irq = platform_get_irq_byname(pdev,
! 								 "irq_mm2s");
! 		if (aud_drv_data->mm2s_irq < 0) {
! 			ret = aud_drv_data->mm2s_irq;
! 			goto clk_err;
! 		}
! 		ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
! 				       xlnx_mm2s_irq_handler, 0,
! 				       "xlnx_formatter_pcm_mm2s_irq", dev);
! 		if (ret) {
! 			dev_err(dev, "xlnx audio mm2s irq request failed\n");
! 			goto clk_err;
! 		}
  	}
  	if (val & AUD_CFG_S2MM_MASK) {
! 		aud_drv_data->s2mm_presence = true;
! 		ret = xlnx_formatter_pcm_reset(aud_drv_data->mmio +
! 					       XLNX_S2MM_OFFSET);
! 		if (ret) {
! 			dev_err(dev, "audio formatter reset failed\n");
! 			goto clk_err;
! 		}
! 		xlnx_formatter_disable_irqs(aud_drv_data->mmio +
! 					    XLNX_S2MM_OFFSET,
! 					    SNDRV_PCM_STREAM_CAPTURE);
! 
! 		aud_drv_data->s2mm_irq = platform_get_irq_byname(pdev,
! 								 "irq_s2mm");
! 		if (aud_drv_data->s2mm_irq < 0) {
! 			ret = aud_drv_data->s2mm_irq;
! 			goto clk_err;
! 		}
! 		ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
! 				       xlnx_s2mm_irq_handler, 0,
! 				       "xlnx_formatter_pcm_s2mm_irq",
! 				       dev);
! 		if (ret) {
! 			dev_err(dev, "xlnx audio s2mm irq request failed\n");
! 			goto clk_err;
! 		}
  	}
  
  	dev_set_drvdata(dev, aud_drv_data);
--- 757,792 ----
  	if (!aud_drv_data)
  		return -ENOMEM;
  
! 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
! 	if (ret) {
! 		dev_err(dev, "higher dma address mapping failed %d\n", ret);
! 		return ret;
! 	}
! 
! 	aud_drv_data->axi_clk = devm_clk_get_enabled(dev, "s_axi_lite_aclk");
  	if (IS_ERR(aud_drv_data->axi_clk)) {
  		ret = PTR_ERR(aud_drv_data->axi_clk);
  		dev_err(dev, "failed to get s_axi_lite_aclk(%d)\n", ret);
  		return ret;
  	}
  
  	aud_drv_data->mmio = devm_platform_ioremap_resource(pdev, 0);
  	if (IS_ERR(aud_drv_data->mmio)) {
  		dev_err(dev, "audio formatter ioremap failed\n");
! 		return PTR_ERR(aud_drv_data->mmio);
  	}
  
! 	val = ioread32(aud_drv_data->mmio + XLNX_AUD_CORE_CONFIG);
  	if (val & AUD_CFG_MM2S_MASK) {
! 		ret = configure_mm2s(aud_drv_data, pdev);
! 		if (ret)
! 			return ret;
  	}
+ 
  	if (val & AUD_CFG_S2MM_MASK) {
! 		ret = configure_s2mm(aud_drv_data, pdev);
! 		if (ret)
! 			return ret;
  	}
  
  	dev_set_drvdata(dev, aud_drv_data);
*************** static int xlnx_formatter_pcm_probe(stru
*** 677,690 ****
  					      NULL, 0);
  	if (ret) {
  		dev_err(dev, "pcm platform device register failed\n");
! 		goto clk_err;
  	}
  
! 	return 0;
  
! clk_err:
! 	clk_disable_unprepare(aud_drv_data->axi_clk);
! 	return ret;
  }
  
  static void xlnx_formatter_pcm_remove(struct platform_device *pdev)
--- 795,817 ----
  					      NULL, 0);
  	if (ret) {
  		dev_err(dev, "pcm platform device register failed\n");
! 		return ret;
  	}
  
! 	pdata_size = sizeof(aud_drv_data->nodes);
! 	if (aud_drv_data->nodes[XLNX_PLAYBACK] ||
! 	    aud_drv_data->nodes[XLNX_CAPTURE])
! 		aud_drv_data->pdev =
! 			platform_device_register_resndata(dev, "xlnx_snd_card",
! 							  PLATFORM_DEVID_AUTO,
! 							  NULL, 0,
! 							  &aud_drv_data->nodes,
! 							  pdata_size);
! 	if (!aud_drv_data->pdev)
! 		dev_err(dev, "sound card device creation failed\n");
  
! 	dev_info(dev, "pcm platform device registered\n");
! 	return 0;
  }
  
  static void xlnx_formatter_pcm_remove(struct platform_device *pdev)
*************** static void xlnx_formatter_pcm_remove(st
*** 692,697 ****
--- 819,826 ----
  	int ret = 0;
  	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(&pdev->dev);
  
+ 	platform_device_unregister(adata->pdev);
+ 
  	if (adata->s2mm_presence)
  		ret = xlnx_formatter_pcm_reset(adata->mmio + XLNX_S2MM_OFFSET);
  
*************** static void xlnx_formatter_pcm_remove(st
*** 701,708 ****
  
  	if (ret)
  		dev_err(&pdev->dev, "audio formatter reset failed\n");
- 
- 	clk_disable_unprepare(adata->axi_clk);
  }
  
  static const struct of_device_id xlnx_formatter_pcm_of_match[] = {
--- 830,835 ----
```



####### Make 301_sound-soc-xilinx.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/301_sound-soc-xilinx.patch
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
Hunk #7 succeeded at 295 with fuzz 1 (offset -1 lines).
Hunk #8 succeeded at 313 with fuzz 1 (offset -2 lines).
Hunk #9 succeeded at 341 (offset -2 lines).
Hunk #10 succeeded at 378 (offset -2 lines).
Hunk #11 succeeded at 425 (offset -2 lines).
Hunk #12 succeeded at 439 (offset -2 lines).
Hunk #13 succeeded at 462 (offset -2 lines).
Hunk #14 succeeded at 474 (offset -2 lines).
Hunk #15 succeeded at 507 (offset -2 lines).
Hunk #16 succeeded at 528 (offset -2 lines).
Hunk #17 succeeded at 558 (offset -2 lines).
Hunk #18 succeeded at 596 (offset -2 lines).
Hunk #19 succeeded at 615 (offset -2 lines).
Hunk #20 FAILED at 757.
Hunk #21 succeeded at 836 (offset -2 lines).
Hunk #22 succeeded at 860 (offset -2 lines).
Hunk #23 succeeded at 871 (offset -2 lines).
1 out of 23 hunks FAILED -- saving rejects to file sound/soc/xilinx/xlnx_formatter_pcm.c.rej
patching file sound/soc/xilinx/xlnx_i2s.c
patching file sound/soc/xilinx/xlnx_pl_snd_card.c
patching file sound/soc/xilinx/xlnx_sdi_audio.c
patching file sound/soc/xilinx/xlnx_snd_common.h
patching file sound/soc/xilinx/xlnx_spdif.c
```

```console
shell$ rm sound/soc/xilinx/xlnx_formatter_pcm.c.orig
shell$ rm sound/soc/xilinx/xlnx_formatter_pcm.c.rej
shell$ cp ../linux-6.12.100-xlnx-v2025.1/sound/soc/xilinx/xlnx_formatter_pcm.c sound/soc/xilinx/xlnx_formatter_pcm.c
shell$ patch sound/soc/xilinx/xlnx_formatter_pcm.c << 'EOT'
--- sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-11 09:09:38.876906588 +0900
+++ sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-11 09:26:26.420077229 +0900
@@ -292,8 +292,7 @@
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_MM2S_OFFSET + XLNX_AUD_STS;
 	val = ioread32(reg);
@@ -311,8 +310,7 @@
 {
 	u32 val;
 	void __iomem *reg;
-	struct device *dev = arg;
-	struct xlnx_pcm_drv_data *adata = dev_get_drvdata(dev);
+	struct xlnx_pcm_drv_data *adata = arg;
 
 	reg = adata->mmio + XLNX_S2MM_OFFSET + XLNX_AUD_STS;
 	val = ioread32(reg);
@@ -667,7 +665,7 @@
 
 	ret = devm_request_irq(dev, aud_drv_data->mm2s_irq,
 			       xlnx_mm2s_irq_handler, 0,
-			       "xlnx_formatter_pcm_mm2s_irq", dev);
+			       "xlnx_formatter_pcm_mm2s_irq", aud_drv_data);
 	if (ret) {
 		dev_err(dev, "xlnx audio mm2s irq request failed\n");
 		return ret;
@@ -717,7 +715,7 @@
 	ret = devm_request_irq(dev, aud_drv_data->s2mm_irq,
 			       xlnx_s2mm_irq_handler, 0,
 			       "xlnx_formatter_pcm_s2mm_irq",
-			       dev);
+			       aud_drv_data);
 	if (ret) {
 		dev_err(dev, "xlnx audio s2mm irq request failed\n");
 		return ret;
EOT
shell$ git add --all
shell$ git commit -m '[patch] 301_sound-soc-xilinx.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/301_sound-soc-xilinx.patch
```

###### 999_other-document.patch

####### Make 999_other-document.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/999_other-document.patch
patching file MAINTAINERS
Hunk #4 succeeded at 9005 (offset 5 lines).
Hunk #5 succeeded at 11171 (offset 5 lines).
Hunk #6 succeeded at 19815 (offset 5 lines).
Hunk #7 succeeded at 21138 (offset 5 lines).
Hunk #8 succeeded at 23846 (offset 5 lines).
Hunk #9 succeeded at 24242 (offset 5 lines).
Hunk #10 succeeded at 24269 (offset 5 lines).
Hunk #11 succeeded at 25480 (offset 5 lines).
Hunk #12 succeeded at 25542 (offset 5 lines).
Hunk #13 succeeded at 25622 (offset 5 lines).
Hunk #14 succeeded at 25730 (offset 5 lines).
Hunk #15 succeeded at 25843 (offset 5 lines).
Hunk #16 succeeded at 25879 (offset 5 lines).
Hunk #17 succeeded at 25909 (offset 5 lines).
shell$ rm MAINTAINERS.orig
shell$ git add --all
shell$ git commit -m '[patch] 999_other-document.patch'
shell$ git diff  HEAD^ > ../patches/linux-6.12.109-xlnx-v2025.1/999_other-document.patch
```

###### 226_drivers-misc-fix.patch

####### Make 226_drivers-misc-fix.patch

```console
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout v6.12.109
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1-2
  :
shell$ patch -p1 < ../patches/linux-6.12.100-xlnx-v2025.1/226_drivers-misc-fix.patch 
patching file include/linux/xlnx-ai-engine.h
patching file include/uapi/linux/xlnx-ai-engine.h

