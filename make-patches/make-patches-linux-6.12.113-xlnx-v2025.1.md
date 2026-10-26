Make ./paches/linux-6.12.113-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.109

```console
shell$ git clone --depth 1 -b v6.12.109 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.109
```

### Get linux-6.12.109-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.109 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.109-xlnx-v2025.1
shell$ cd linux-6.12.109-xlnx-v2025.1
shell$ git checkout -b linux-6.12.109-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.109-xlnx-v2025.1/origin_patch.sh
shell$ cd ..
```

### Get linux-6.12.113

```console
shell$ git clone --depth 1 -b v6.12.113 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.113
```

### Make diff-linux-6.12.109-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.109-xlnx-v2025.1 -A linux-6.12.109 -B linux-6.12.109-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.109-xlnx-v2025.1.txt linux-6.12.109 linux-6.12.109-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.109-xlnx-v2025.1
## A   : {name: linux-6.12.109, path: linux-6.12.109}
## B   : {name: linux-6.12.109-xlnx-v2025.1, path: linux-6.12.109-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.109-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.109-6.12.113.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.109-6.12.113 -A linux-6.12.109 -B linux-6.12.113 -o ./make-patches/diff-linux-6.12.109-6.12.113.txt linux-6.12.109 linux-6.12.113 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.109-6.12.113
## A   : {name: linux-6.12.109, path: linux-6.12.109}
## B   : {name: linux-6.12.113, path: linux-6.12.113}
## OUT : ./make-patches/diff-linux-6.12.109-6.12.113.txt
```

### Compare diff-linux-6.12.109-6.12.113.txt and diff-linux-6.12.109-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.109-6.12.113.txt make-patches/diff-linux-6.12.109-xlnx-v2025.1.txt
contents: 
 - U: MAINTAINERS
 - U: drivers/gpu/drm/drm_atomic_uapi.c
 - U: drivers/gpu/drm/panel/panel-simple.c
 - U: drivers/i2c/busses/i2c-xiic.c
 - U: drivers/i2c/i2c-atr.c
 - U: drivers/iio/adc/Kconfig
 - U: drivers/iio/adc/xilinx-xadc-core.c
 - U: drivers/mfd/rsmu_i2c.c
 - U: drivers/net/ethernet/cadence/macb.h
 - U: drivers/net/ethernet/cadence/macb_main.c
 - U: drivers/net/phy/Kconfig
 - U: drivers/net/phy/Makefile
 - U: drivers/of/overlay.c
 - U: drivers/spi/spi-xilinx.c
 - U: drivers/spi/spi-zynqmp-gqspi.c
 - U: drivers/spi/spi.c
 - U: drivers/ufs/core/ufshcd.c
 - D: drivers/uio/uio.c
 - U: drivers/usb/dwc3/core.h
 - U: drivers/usb/dwc3/ep0.c
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/host/Kconfig
 - U: drivers/usb/host/xhci.c
 - U: drivers/usb/host/xhci.h
 - U: include/linux/phy.h
 - U: net/ipv4/af_inet.c
 - U: sound/soc/xilinx/xlnx_formatter_pcm.c
```


### Make linux-6.12.113-xlnx-v2025.1

#### Make patches/linux-6.12.113-xlnx-v2025.1

```console
shell$ patches/linux-6.12.113-xlnx-v2025.1
```

#### Make patches/linux-6.12.113-xlnx-v2025.1/xxx_update.sh

```patches/linux-6.12.113-xlnx-v2025.1/xxx_update.sh
PATCH_DIR=$(cd $(dirname $0); pwd)
BASE_PATCH_DIR="$PATCH_DIR/../linux-6.12.109-xlnx-v2025.1"
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

#### Make linux-6.12.113-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.113 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.113-xlnx-v2025.1
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout -b linux-6.12.113-xlnx-v2025.1-1
```

#### Run patches/linux-6.12.113-xlnx-v2025.1/xxx_update.sh

```console
shell$ sh ../patches/linux-6.12.113-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/002_include.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/002_include.patch
patching file include/linux/regmap.h
git add --all
git commit -m '[patch] 002_include.patch'
[linux-6.12.113-xlnx-v2025.1-1 7c0ac1a9a] [patch] 002_include.patch
 1 file changed, 16 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/002_include.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
patching file arch/arm/mach-zynq/Makefile
patching file arch/arm/mach-zynq/common.c
patching file arch/arm/mach-zynq/common.h
patching file arch/arm/mach-zynq/efuse.c
patching file arch/arm/mach-zynq/platsmp.c
git add --all
git commit -m '[patch] 010_arch-arm-mach-zynq.patch'
[linux-6.12.113-xlnx-v2025.1-1 4a473f6cc] [patch] 010_arch-arm-mach-zynq.patch
 5 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-zynq/efuse.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/011_arch-arm-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/011_arch-arm-configs.patch
patching file arch/arm/configs/xilinx_zynq_defconfig
git add --all
git commit -m '[patch] 011_arch-arm-configs.patch'
[linux-6.12.113-xlnx-v2025.1-1 f0c921c4e] [patch] 011_arch-arm-configs.patch
 1 file changed, 222 insertions(+)
 create mode 100644 arch/arm/configs/xilinx_zynq_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/012_arch-arm-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/012_arch-arm-boot-dts.patch
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
[linux-6.12.113-xlnx-v2025.1-1 7a6063633] [patch] 012_arch-arm-boot-dts.patch
 13 files changed, 421 insertions(+), 69 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/020_arch-arm64.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/020_arch-arm64.patch
patching file Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
patching file arch/arm64/kernel/irq.c
git add --all
git commit -m '[patch] 020_arch-arm64.patch'
[linux-6.12.113-xlnx-v2025.1-1 bb1446c0c] [patch] 020_arch-arm64.patch
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/021_arch-arm64-configs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/021_arch-arm64-configs.patch
patching file arch/arm64/configs/defconfig
patching file arch/arm64/configs/xilinx_defconfig
git add --all
git commit -m '[patch] 021_arch-arm64-configs.patch'
[linux-6.12.113-xlnx-v2025.1-1 7b73b230c] [patch] 021_arch-arm64-configs.patch
 2 files changed, 670 insertions(+)
 create mode 100644 arch/arm64/configs/xilinx_defconfig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
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
[linux-6.12.113-xlnx-v2025.1-1 fd9c6b3a8] [patch] 022_arch-arm64-boot-dts.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/030_arch-microblaze.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/030_arch-microblaze.patch
patching file arch/microblaze/configs/mmu_defconfig
patching file arch/microblaze/include/asm/sections.h
patching file arch/microblaze/kernel/head.S
patching file arch/microblaze/kernel/setup.c
patching file arch/microblaze/kernel/vmlinux.lds.S
patching file arch/microblaze/mm/init.c
git add --all
git commit -m '[patch] 030_arch-microblaze.patch'
[linux-6.12.113-xlnx-v2025.1-1 3260b12c2] [patch] 030_arch-microblaze.patch
 6 files changed, 22 insertions(+), 11 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/100_kernel-irq.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/100_kernel-irq.patch
patching file kernel/irq/handle.c
git add --all
git commit -m '[patch] 100_kernel-irq.patch'
[linux-6.12.113-xlnx-v2025.1-1 03400fe1f] [patch] 100_kernel-irq.patch
 1 file changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/101_net-ipv4.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/101_net-ipv4.patch
patching file net/ipv4/af_inet.c
git add --all
git commit -m '[patch] 101_net-ipv4.patch'
[linux-6.12.113-xlnx-v2025.1-1 b79dc3ba0] [patch] 101_net-ipv4.patch
 1 file changed, 6 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/102_crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/102_crypto.patch
patching file crypto/ecdsa.c
git add --all
git commit -m '[patch] 102_crypto.patch'
[linux-6.12.113-xlnx-v2025.1-1 db94179df] [patch] 102_crypto.patch
 1 file changed, 4 insertions(+), 8 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/202_drivers-clk.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/202_drivers-clk.patch
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
[linux-6.12.113-xlnx-v2025.1-1 840cc650b] [patch] 202_drivers-clk.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/203_drivers-clocksource.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/203_drivers-clocksource.patch
patching file drivers/clocksource/timer-cadence-ttc.c
git add --all
git commit -m '[patch] 203_drivers-clocksource.patch'
[linux-6.12.113-xlnx-v2025.1-1 15d130e2d] [patch] 203_drivers-clocksource.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/204_drivers-crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/204_drivers-crypto.patch
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
[linux-6.12.113-xlnx-v2025.1-1 56b548c17] [patch] 204_drivers-crypto.patch
 10 files changed, 2385 insertions(+), 258 deletions(-)
 create mode 100644 drivers/crypto/xilinx/xilinx-ecdsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx_ecdsasig.asn1
 create mode 100644 drivers/crypto/xilinx/zynqmp-rsa.c
 create mode 100644 include/crypto/ecdsa.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/205_drivers-dma.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/205_drivers-dma.patch
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
[linux-6.12.113-xlnx-v2025.1-1 8462c3fd4] [patch] 205_drivers-dma.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/206_drivers-edac.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/206_drivers-edac.patch
patching file Documentation/ABI/testing/sysfs-driver-xilsem-edac
patching file Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
patching file drivers/edac/Kconfig
patching file drivers/edac/Makefile
patching file drivers/edac/versal_edac.c
patching file drivers/edac/xilinx_xilsem_edac.c
git add --all
git commit -m '[patch] 206_drivers-edac.patch'
[linux-6.12.113-xlnx-v2025.1-1 5f0905a32] [patch] 206_drivers-edac.patch
 6 files changed, 1671 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilsem-edac
 create mode 100644 Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml
 create mode 100644 drivers/edac/xilinx_xilsem_edac.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/207_drivers-firmware.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/207_drivers-firmware.patch
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
[linux-6.12.113-xlnx-v2025.1-1 efdcfeff3] [patch] 207_drivers-firmware.patch
 22 files changed, 6774 insertions(+), 741 deletions(-)
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/208_drivers-fpga.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/208_drivers-fpga.patch
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
[linux-6.12.113-xlnx-v2025.1-1 47502f786] [patch] 208_drivers-fpga.patch
 14 files changed, 982 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml
 create mode 100644 drivers/fpga/xilinx-afi.c
 create mode 100644 drivers/fpga/zynq-afi.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/210_drivers-gpu-drm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/210_drivers-gpu-drm.patch
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
Hunk #1 succeeded at 5191 (offset 28 lines).
Hunk #2 succeeded at 5396 (offset 28 lines).
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
[linux-6.12.113-xlnx-v2025.1-1 9594a55f1] [patch] 210_drivers-gpu-drm.patch
 85 files changed, 38112 insertions(+), 168 deletions(-)
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
 create mode 100644 drivers/gpu/drm/panel/panel-simple.c.orig
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/211_drivers-hwmon.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/211_drivers-hwmon.patch
patching file Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
git add --all
git commit -m '[patch] 211_drivers-hwmon.patch'
[linux-6.12.113-xlnx-v2025.1-1 f7927da7f] [patch] 211_drivers-hwmon.patch
 1 file changed, 9 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/212_drivers-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/212_drivers-i2c.patch
patching file drivers/i2c/busses/i2c-cadence.c
patching file drivers/i2c/busses/i2c-xiic.c
Hunk #2 succeeded at 79 with fuzz 1 (offset 3 lines).
Hunk #3 succeeded at 105 with fuzz 1 (offset 4 lines).
Hunk #4 succeeded at 236 (offset 4 lines).
Hunk #5 succeeded at 275 with fuzz 2 (offset 27 lines).
Hunk #6 succeeded at 434 (offset 27 lines).
Hunk #7 succeeded at 528 (offset 27 lines).
Hunk #8 succeeded at 619 (offset 35 lines).
Hunk #9 succeeded at 683 (offset 35 lines).
Hunk #10 succeeded at 716 (offset 35 lines).
Hunk #11 succeeded at 741 (offset 35 lines).
Hunk #12 FAILED at 915.
Hunk #13 succeeded at 1073 (offset 45 lines).
Hunk #14 succeeded at 1086 (offset 45 lines).
Hunk #15 succeeded at 1143 (offset 45 lines).
Hunk #16 succeeded at 1214 (offset 45 lines).
Hunk #17 succeeded at 1251 (offset 45 lines).
Hunk #18 succeeded at 1263 (offset 45 lines).
Hunk #19 succeeded at 1291 (offset 45 lines).
Hunk #20 succeeded at 1328 (offset 45 lines).
Hunk #21 succeeded at 1370 (offset 45 lines).
Hunk #22 succeeded at 1415 (offset 45 lines).
Hunk #23 succeeded at 1479 (offset 45 lines).
Hunk #24 FAILED at 1532.
2 out of 24 hunks FAILED -- saving rejects to file drivers/i2c/busses/i2c-xiic.c.rej
patching file drivers/i2c/i2c-atr.c
Hunk #19 FAILED at 847.
Hunk #20 succeeded at 871 (offset 1 line).
Hunk #21 succeeded at 909 (offset 1 line).
1 out of 21 hunks FAILED -- saving rejects to file drivers/i2c/i2c-atr.c.rej
patching file include/linux/i2c-atr.h
git add --all
git commit -m '[patch] 212_drivers-i2c.patch'
[linux-6.12.113-xlnx-v2025.1-1 4811765cd] [patch] 212_drivers-i2c.patch
 8 files changed, 3205 insertions(+), 329 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xiic.c.orig
 create mode 100644 drivers/i2c/busses/i2c-xiic.c.rej
 create mode 100644 drivers/i2c/i2c-atr.c.orig
 create mode 100644 drivers/i2c/i2c-atr.c.rej
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/213_drivers-i3c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/213_drivers-i3c.patch
patching file Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml
git add --all
git commit -m '[patch] 213_drivers-i3c.patch'
[linux-6.12.113-xlnx-v2025.1-1 6afd32949] [patch] 213_drivers-i3c.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/214_drivers-iio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
Hunk #2 succeeded at 1662 (offset 1 line).
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
[linux-6.12.113-xlnx-v2025.1-1 0f3340587] [patch] 214_drivers-iio.patch
 12 files changed, 4704 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
 create mode 100644 drivers/iio/adc/Kconfig.orig
 create mode 100644 drivers/iio/adc/ina260-adc.c
 create mode 100644 drivers/iio/adc/versal-sysmon-core.c
 create mode 100644 drivers/iio/adc/versal-sysmon-i2c.c
 create mode 100644 drivers/iio/adc/versal-sysmon.c
 create mode 100644 drivers/iio/adc/versal-sysmon.h
 create mode 100644 include/linux/iio/adc/versal-sysmon-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/216_drivers-irqchip.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/216_drivers-irqchip.patch
patching file Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
patching file drivers/irqchip/Kconfig
patching file drivers/irqchip/irq-xilinx-intc.c
patching file drivers/irqchip/irqchip.c
patching file include/linux/irq.h
patching file include/linux/irqchip.h
patching file include/linux/of_irq.h
git add --all
git commit -m '[patch] 216_drivers-irqchip.patch'
[linux-6.12.113-xlnx-v2025.1-1 23461917d] [patch] 216_drivers-irqchip.patch
 7 files changed, 286 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/217_drivers-mailbox.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/217_drivers-mailbox.patch
patching file Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
patching file drivers/mailbox/zynqmp-ipi-mailbox.c
git add --all
git commit -m '[patch] 217_drivers-mailbox.patch'
[linux-6.12.113-xlnx-v2025.1-1 43982aed5] [patch] 217_drivers-mailbox.patch
 2 files changed, 6 insertions(+), 2 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/217_drivers-mailbox.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/218_drivers-media-common.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/218_drivers-media-common.patch
patching file drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
git add --all
git commit -m '[patch] 218_drivers-media-common.patch'
[linux-6.12.113-xlnx-v2025.1-1 a9171612e] [patch] 218_drivers-media-common.patch
 1 file changed, 10 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/219_drivers-media-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/219_drivers-media-i2c.patch
patching file Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
patching file drivers/media/i2c/Kconfig
patching file drivers/media/i2c/Makefile
patching file drivers/media/i2c/ap1302.c
patching file drivers/media/i2c/ds90ub913.c
patching file drivers/media/i2c/ds90ub953.c
patching file drivers/media/i2c/ds90ub960.c
git add --all
git commit -m '[patch] 219_drivers-media-i2c.patch'
[linux-6.12.113-xlnx-v2025.1-1 ab6ada55f] [patch] 219_drivers-media-i2c.patch
 7 files changed, 3246 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
 create mode 100644 drivers/media/i2c/ap1302.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/220_drivers-media-mc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/220_drivers-media-mc.patch
patching file drivers/media/mc/mc-entity.c
git add --all
git commit -m '[patch] 220_drivers-media-mc.patch'
[linux-6.12.113-xlnx-v2025.1-1 76c65c4d7] [patch] 220_drivers-media-mc.patch
 1 file changed, 29 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/221_drivers-media-platform.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/221_drivers-media-platform.patch
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
[linux-6.12.113-xlnx-v2025.1-1 8389dce28] [patch] 221_drivers-media-platform.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/222_drivers-media-test-drivers.patch
patching file drivers/media/test-drivers/vivid/vivid-vid-common.c
git add --all
git commit -m '[patch] 222_drivers-media-test-drivers.patch'
[linux-6.12.113-xlnx-v2025.1-1 ed5a90edf] [patch] 222_drivers-media-test-drivers.patch
 1 file changed, 8 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/224_drivers-media-v4l2.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/224_drivers-media-v4l2.patch
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
[linux-6.12.113-xlnx-v2025.1-1 eaab8f0a6] [patch] 224_drivers-media-v4l2.patch
 21 files changed, 1592 insertions(+), 125 deletions(-)
 create mode 100644 include/media/hdr-ctrls.h
 create mode 100644 include/uapi/linux/xilinx-dprxss.h
 create mode 100644 include/uapi/linux/xilinx-hdmirxss.h
 create mode 100644 include/uapi/linux/xilinx-hls.h
 create mode 100644 include/uapi/linux/xilinx-sdirxss.h
 create mode 100644 include/uapi/linux/xilinx-v4l2-events.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/225_drivers-mfd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
Hunk #3 succeeded at 333 with fuzz 1 (offset 1 line).
Hunk #4 succeeded at 345 with fuzz 1 (offset 2 lines).
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
git add --all
git commit -m '[patch] 225_drivers-mfd.patch'
[linux-6.12.113-xlnx-v2025.1-1 96190be56] [patch] 225_drivers-mfd.patch
 8 files changed, 847 insertions(+), 291 deletions(-)
 create mode 100644 drivers/mfd/rsmu_i2c.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/226_drivers-misc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/226_drivers-misc.patch
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
[linux-6.12.113-xlnx-v2025.1-1 4b3aaaf65] [patch] 226_drivers-misc.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/228_drivers-mtd.patch
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
[linux-6.12.113-xlnx-v2025.1-1 7b7bde17b] [patch] 228_drivers-mtd.patch
 17 files changed, 2308 insertions(+), 365 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/228_drivers-mtd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
Hunk #14 succeeded at 5145 (offset -6 lines).
Hunk #15 succeeded at 5178 (offset -6 lines).
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
[linux-6.12.113-xlnx-v2025.1-1 b305931b1] [patch] 230_drivers-net-ethernet.patch
 15 files changed, 12802 insertions(+), 865 deletions(-)
 create mode 100644 drivers/net/ethernet/cadence/macb_main.c.orig
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/231_drivers-net-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/231_drivers-net-phy.patch
patching file Documentation/devicetree/bindings/net/xilinx-phy.txt
patching file drivers/net/phy/Kconfig
Hunk #1 succeeded at 426 (offset -15 lines).
patching file drivers/net/phy/Makefile
Hunk #1 succeeded at 101 (offset -1 lines).
patching file drivers/net/phy/phy-core.c
patching file drivers/net/phy/phylink.c
patching file drivers/net/phy/xilinx_phy.c
patching file include/linux/phy.h
patching file include/linux/xilinx_phy.h
git add --all
git commit -m '[patch] 231_drivers-net-phy.patch'
[linux-6.12.113-xlnx-v2025.1-1 7e7936c91] [patch] 231_drivers-net-phy.patch
 10 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx-phy.txt
 create mode 100644 drivers/net/phy/Kconfig.orig
 create mode 100644 drivers/net/phy/Makefile.orig
 create mode 100644 drivers/net/phy/xilinx_phy.c
 create mode 100644 include/linux/xilinx_phy.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/234_drivers-nvmem.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/234_drivers-nvmem.patch
patching file Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
patching file drivers/nvmem/Kconfig
patching file drivers/nvmem/Makefile
patching file drivers/nvmem/xlnx_secure_config.c
git add --all
git commit -m '[patch] 234_drivers-nvmem.patch'
[linux-6.12.113-xlnx-v2025.1-1 0cb098b61] [patch] 234_drivers-nvmem.patch
 4 files changed, 1300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml
 create mode 100644 drivers/nvmem/xlnx_secure_config.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/235_drivers-of.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/235_drivers-of.patch
patching file Documentation/devicetree/configfs-overlays.txt
patching file drivers/of/Kconfig
patching file drivers/of/Makefile
patching file drivers/of/configfs.c
patching file drivers/of/overlay.c
Hunk #1 succeeded at 1093 (offset 24 lines).
Hunk #2 succeeded at 1170 (offset 24 lines).
Hunk #3 succeeded at 1226 (offset 24 lines).
git add --all
git commit -m '[patch] 235_drivers-of.patch'
[linux-6.12.113-xlnx-v2025.1-1 f0b90fe0b] [patch] 235_drivers-of.patch
 6 files changed, 1640 insertions(+)
 create mode 100644 Documentation/devicetree/configfs-overlays.txt
 create mode 100644 drivers/of/configfs.c
 create mode 100644 drivers/of/overlay.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/236_drivers-pci.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/236_drivers-pci.patch
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
[linux-6.12.113-xlnx-v2025.1-1 086ccd595] [patch] 236_drivers-pci.patch
 9 files changed, 827 insertions(+), 127 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-amd-mdb.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/237_drivers-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/237_drivers-phy.patch
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
[linux-6.12.113-xlnx-v2025.1-1 8b30ed80e] [patch] 237_drivers-phy.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/238_drivers-pinctrl.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/238_drivers-pinctrl.patch
patching file Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
patching file drivers/pinctrl/pinctrl-zynqmp.c
git add --all
git commit -m '[patch] 238_drivers-pinctrl.patch'
[linux-6.12.113-xlnx-v2025.1-1 a3498ce16] [patch] 238_drivers-pinctrl.patch
 2 files changed, 413 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/240_drivers-ptp.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/240_drivers-ptp.patch
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
[linux-6.12.113-xlnx-v2025.1-1 32b7b28b4] [patch] 240_drivers-ptp.patch
 8 files changed, 715 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml
 create mode 100644 drivers/ptp/ptp_xilinx.c
 create mode 100644 include/linux/ptp/ptp_xilinx.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/241_drivers-pwm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/241_drivers-pwm.patch
patching file drivers/pwm/Kconfig
patching file drivers/pwm/Makefile
patching file drivers/pwm/pwm-cadence.c
git add --all
git commit -m '[patch] 241_drivers-pwm.patch'
[linux-6.12.113-xlnx-v2025.1-1 e6c841be8] [patch] 241_drivers-pwm.patch
 3 files changed, 375 insertions(+)
 create mode 100644 drivers/pwm/pwm-cadence.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/242_drivers-remoteproc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/242_drivers-remoteproc.patch
patching file drivers/remoteproc/xlnx_r5_remoteproc.c
git add --all
git commit -m '[patch] 242_drivers-remoteproc.patch'
[linux-6.12.113-xlnx-v2025.1-1 282e6906b] [patch] 242_drivers-remoteproc.patch
 1 file changed, 30 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/243_drivers-reset.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/243_drivers-reset.patch
patching file Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
git add --all
git commit -m '[patch] 243_drivers-reset.patch'
[linux-6.12.113-xlnx-v2025.1-1 5f687f078] [patch] 243_drivers-reset.patch
 1 file changed, 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/243_drivers-reset.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/246_drivers-soc-xilinx.patch
patching file Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml
patching file Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
patching file drivers/soc/xilinx/xlnx_event_manager.c
patching file drivers/soc/xilinx/zynqmp_power.c
git add --all
git commit -m '[patch] 246_drivers-soc-xilinx.patch'
[linux-6.12.113-xlnx-v2025.1-1 6ae021fb3] [patch] 246_drivers-soc-xilinx.patch
 4 files changed, 88 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
Hunk #7 FAILED at 352.
Hunk #8 succeeded at 594 (offset 4 lines).
1 out of 8 hunks FAILED -- saving rejects to file drivers/spi/spi-xilinx.c.rej
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
Hunk #1 succeeded at 2490 (offset 6 lines).
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
git add --all
git commit -m '[patch] 247_drivers-spi.patch'
[linux-6.12.113-xlnx-v2025.1-1 ddd5a6a4f] [patch] 247_drivers-spi.patch
 16 files changed, 7256 insertions(+), 215 deletions(-)
 create mode 100644 drivers/spi/spi-xilinx.c.orig
 create mode 100644 drivers/spi/spi-xilinx.c.rej
 create mode 100644 drivers/spi/spi.c.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/247_drivers-spi.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/248_drivers-staging.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/248_drivers-staging.patch
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
[linux-6.12.113-xlnx-v2025.1-1 488ff0f50] [patch] 248_drivers-staging.patch
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
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/249_drivers-thermal.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/249_drivers-thermal.patch
patching file Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
patching file drivers/thermal/Kconfig
patching file drivers/thermal/Makefile
patching file drivers/thermal/versal_thermal.c
git add --all
git commit -m '[patch] 249_drivers-thermal.patch'
[linux-6.12.113-xlnx-v2025.1-1 594a8abcf] [patch] 249_drivers-thermal.patch
 4 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml
 create mode 100644 drivers/thermal/versal_thermal.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/250_drivers-tty.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/250_drivers-tty.patch
patching file Documentation/devicetree/bindings/serial/pl011.yaml
patching file Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
git add --all
git commit -m '[patch] 250_drivers-tty.patch'
[linux-6.12.113-xlnx-v2025.1-1 96917c782] [patch] 250_drivers-tty.patch
 2 files changed, 4 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/251_drivers-ufs.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/251_drivers-ufs.patch
patching file Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
patching file drivers/ufs/core/ufshcd-priv.h
patching file drivers/ufs/core/ufshcd.c
Hunk #1 succeeded at 7018 (offset -2 lines).
Hunk #2 succeeded at 8911 (offset -1 lines).
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
[linux-6.12.113-xlnx-v2025.1-1 cd246888e] [patch] 251_drivers-ufs.patch
 12 files changed, 11603 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
 create mode 100644 drivers/ufs/core/ufshcd.c.orig
 create mode 100644 drivers/ufs/host/ufs-amd-versal2.c
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/252_drivers-uio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/252_drivers-uio.patch
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
[linux-6.12.113-xlnx-v2025.1-1 7c9f62a28] [patch] 252_drivers-uio.patch
 9 files changed, 1167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/xilinx-apm.yaml
 rename drivers/uio/{uio.c => uio_core.c} (96%)
 create mode 100644 drivers/uio/uio_dmabuf.c
 create mode 100644 drivers/uio/uio_dmabuf.h
 create mode 100644 drivers/uio/uio_xilinx_ai_engine.c
 create mode 100644 drivers/uio/uio_xilinx_apm.c
 create mode 100644 include/uapi/linux/uio/uio.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/260_drivers-usb-core.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/260_drivers-usb-core.patch
patching file Documentation/devicetree/bindings/usb/usb-xhci.yaml
git add --all
git commit -m '[patch] 260_drivers-usb-core.patch'
[linux-6.12.113-xlnx-v2025.1-1 fbc902c0a] [patch] 260_drivers-usb-core.patch
 1 file changed, 7 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/261_drivers-usb-chipidea.patch
patching file drivers/usb/chipidea/ci_hdrc_usb2.c
git add --all
git commit -m '[patch] 261_drivers-usb-chipidea.patch'
[linux-6.12.113-xlnx-v2025.1-1 2e6f2661e] [patch] 261_drivers-usb-chipidea.patch
 1 file changed, 10 insertions(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
Hunk #2 succeeded at 183 (offset 1 line).
Hunk #3 succeeded at 205 (offset 1 line).
Hunk #4 succeeded at 296 (offset 1 line).
Hunk #5 succeeded at 522 (offset 1 line).
Hunk #6 succeeded at 691 (offset 1 line).
Hunk #7 succeeded at 1030 with fuzz 1 (offset 9 lines).
Hunk #8 succeeded at 1059 (offset 10 lines).
Hunk #9 succeeded at 1082 (offset 10 lines).
Hunk #10 succeeded at 1133 (offset 13 lines).
Hunk #11 succeeded at 1151 (offset 13 lines).
Hunk #12 succeeded at 1192 (offset 13 lines).
Hunk #13 succeeded at 1211 (offset 13 lines).
Hunk #14 succeeded at 1228 with fuzz 1 (offset 14 lines).
Hunk #15 succeeded at 1288 (offset 17 lines).
Hunk #16 succeeded at 1303 (offset 17 lines).
Hunk #17 succeeded at 1385 (offset 20 lines).
Hunk #18 succeeded at 1411 (offset 20 lines).
Hunk #19 succeeded at 1426 (offset 20 lines).
Hunk #20 succeeded at 1452 (offset 20 lines).
Hunk #21 succeeded at 1470 (offset 20 lines).
Hunk #22 succeeded at 1645 (offset 20 lines).
Hunk #23 succeeded at 1693 (offset 20 lines).
Hunk #24 succeeded at 1722 (offset 20 lines).
Hunk #25 succeeded at 1745 (offset 20 lines).
Hunk #26 succeeded at 1771 (offset 20 lines).
Hunk #27 succeeded at 1803 (offset 20 lines).
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
Hunk #1 FAILED at 200.
Hunk #2 succeeded at 290 (offset 9 lines).
Hunk #3 FAILED at 290.
Hunk #4 succeeded at 379 (offset 9 lines).
Hunk #5 succeeded at 506 (offset 9 lines).
Hunk #6 succeeded at 524 (offset 9 lines).
Hunk #7 succeeded at 837 (offset 9 lines).
Hunk #8 succeeded at 875 (offset 9 lines).
Hunk #9 succeeded at 1188 (offset 9 lines).
2 out of 9 hunks FAILED -- saving rejects to file drivers/usb/dwc3/ep0.c.rej
patching file drivers/usb/dwc3/gadget.c
Hunk #9 succeeded at 1066 (offset -1 lines).
Hunk #10 succeeded at 1668 (offset 3 lines).
Hunk #11 succeeded at 1794 (offset 8 lines).
Hunk #12 succeeded at 2029 (offset 8 lines).
Hunk #13 succeeded at 2050 (offset 8 lines).
Hunk #14 succeeded at 2284 (offset 12 lines).
Hunk #15 succeeded at 2667 (offset 28 lines).
Hunk #16 succeeded at 2742 (offset 28 lines).
Hunk #17 succeeded at 2803 (offset 28 lines).
Hunk #18 succeeded at 2834 (offset 28 lines).
Hunk #19 FAILED at 2851.
Hunk #20 succeeded at 2903 (offset 31 lines).
Hunk #21 succeeded at 2917 (offset 31 lines).
Hunk #22 succeeded at 3019 (offset 31 lines).
Hunk #23 succeeded at 3073 (offset 31 lines).
Hunk #24 succeeded at 3091 (offset 31 lines).
Hunk #25 succeeded at 3774 (offset 77 lines).
Hunk #26 FAILED at 3707.
Hunk #27 succeeded at 3836 (offset 77 lines).
Hunk #28 succeeded at 4023 (offset 38 lines).
Hunk #29 succeeded at 4184 (offset 38 lines).
Hunk #30 succeeded at 4259 (offset 42 lines).
Hunk #31 succeeded at 4313 (offset 42 lines).
Hunk #32 succeeded at 4439 (offset 42 lines).
Hunk #33 succeeded at 4478 (offset 42 lines).
Hunk #34 succeeded at 4491 (offset 42 lines).
Hunk #35 succeeded at 4634 (offset 42 lines).
Hunk #36 succeeded at 4677 (offset 42 lines).
Hunk #37 succeeded at 4719 (offset 42 lines).
Hunk #38 succeeded at 4744 (offset 42 lines).
Hunk #39 succeeded at 4757 (offset 42 lines).
Hunk #40 succeeded at 4820 (offset 48 lines).
Hunk #41 succeeded at 4884 (offset 60 lines).
Hunk #42 succeeded at 4903 (offset 60 lines).
Hunk #43 succeeded at 4997 (offset 111 lines).
Hunk #44 succeeded at 5092 (offset 113 lines).
Hunk #45 succeeded at 5185 (offset 115 lines).
2 out of 45 hunks FAILED -- saving rejects to file drivers/usb/dwc3/gadget.c.rej
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
git add --all
git commit -m '[patch] 262_drivers-usb-dwc3.patch'
[linux-6.12.113-xlnx-v2025.1-1 94e3731ae] [patch] 262_drivers-usb-dwc3.patch
 21 files changed, 12469 insertions(+), 102 deletions(-)
 create mode 100644 drivers/usb/dwc3/core.h.orig
 create mode 100644 drivers/usb/dwc3/ep0.c.orig
 create mode 100644 drivers/usb/dwc3/ep0.c.rej
 create mode 100644 drivers/usb/dwc3/gadget.c.orig
 create mode 100644 drivers/usb/dwc3/gadget.c.rej
 create mode 100644 drivers/usb/dwc3/gadget_hibernation.c
 create mode 100644 drivers/usb/dwc3/otg.c
 create mode 100644 drivers/usb/dwc3/otg.h
 create mode 100644 drivers/usb/dwc3/platform_data.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/262_drivers-usb-dwc3.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/263_drivers-usb-gadget.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/263_drivers-usb-gadget.patch
patching file drivers/usb/gadget/function/f_tcm.c
git add --all
git commit -m '[patch] 263_drivers-usb-gadget.patch'
[linux-6.12.113-xlnx-v2025.1-1 3de996108] [patch] 263_drivers-usb-gadget.patch
 1 file changed, 28 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
Hunk #1 succeeded at 1847 (offset -3 lines).
git add --all
git commit -m '[patch] 264_drivers-usb-host.patch'
[linux-6.12.113-xlnx-v2025.1-1 84323db2f] [patch] 264_drivers-usb-host.patch
 5 files changed, 2637 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/xhci.h.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/266_drivers-usb-phy.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/266_drivers-usb-phy.patch
patching file Documentation/devicetree/bindings/usb/ulpi-phy.yaml
patching file drivers/usb/phy/Kconfig
patching file drivers/usb/phy/phy-ulpi.c
git add --all
git commit -m '[patch] 266_drivers-usb-phy.patch'
[linux-6.12.113-xlnx-v2025.1-1 74d871641] [patch] 266_drivers-usb-phy.patch
 3 files changed, 147 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/usb/ulpi-phy.yaml
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/271_drivers-video.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/271_drivers-video.patch
patching file drivers/video/hdmi.c
git add --all
git commit -m '[patch] 271_drivers-video.patch'
[linux-6.12.113-xlnx-v2025.1-1 ca9b80b19] [patch] 271_drivers-video.patch
 1 file changed, 4 insertions(+), 4 deletions(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/272_drivers-virtio.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/272_drivers-virtio.patch
patching file drivers/virtio/virtio_ring.c
git add --all
git commit -m '[patch] 272_drivers-virtio.patch'
[linux-6.12.113-xlnx-v2025.1-1 9879a5da6] [patch] 272_drivers-virtio.patch
 1 file changed, 1 insertion(+), 1 deletion(-)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/273_drivers-w1.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/273_drivers-w1.patch
patching file Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
git add --all
git commit -m '[patch] 273_drivers-w1.patch'
[linux-6.12.113-xlnx-v2025.1-1 a5a826952] [patch] 273_drivers-w1.patch
 1 file changed, 3 insertions(+)
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/275_drivers-xen.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/275_drivers-xen.patch
patching file drivers/xen/Kconfig
patching file drivers/xen/Makefile
patching file drivers/xen/pvcalls.c
patching file include/xen/pvcalls.h
patching file include/xen/xen.h
git add --all
git commit -m '[patch] 275_drivers-xen.patch'
[linux-6.12.113-xlnx-v2025.1-1 cb5d162b8] [patch] 275_drivers-xen.patch
 5 files changed, 157 insertions(+), 1 deletion(-)
 create mode 100644 drivers/xen/pvcalls.c
 create mode 100644 include/xen/pvcalls.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/301_sound-soc-xilinx.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/301_sound-soc-xilinx.patch
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
Hunk #11 succeeded at 425 with fuzz 1.
Hunk #12 succeeded at 447 (offset 8 lines).
Hunk #13 succeeded at 470 (offset 8 lines).
Hunk #14 succeeded at 482 (offset 8 lines).
Hunk #15 succeeded at 515 (offset 8 lines).
Hunk #16 succeeded at 536 (offset 8 lines).
Hunk #17 succeeded at 566 (offset 8 lines).
Hunk #18 succeeded at 604 (offset 8 lines).
Hunk #19 succeeded at 623 (offset 8 lines).
Hunk #20 succeeded at 763 (offset 8 lines).
Hunk #21 succeeded at 801 (offset 8 lines).
Hunk #22 succeeded at 825 (offset 8 lines).
Hunk #23 succeeded at 836 (offset 8 lines).
patching file sound/soc/xilinx/xlnx_i2s.c
patching file sound/soc/xilinx/xlnx_pl_snd_card.c
patching file sound/soc/xilinx/xlnx_sdi_audio.c
patching file sound/soc/xilinx/xlnx_snd_common.h
patching file sound/soc/xilinx/xlnx_spdif.c
git add --all
git commit -m '[patch] 301_sound-soc-xilinx.patch'
[linux-6.12.113-xlnx-v2025.1-1 3a62923af] [patch] 301_sound-soc-xilinx.patch
 16 files changed, 2699 insertions(+), 284 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml
 create mode 100644 sound/soc/xilinx/xlnx_formatter_pcm.c.orig
 create mode 100644 sound/soc/xilinx/xlnx_pl_snd_card.c
 create mode 100644 sound/soc/xilinx/xlnx_sdi_audio.c
 create mode 100644 sound/soc/xilinx/xlnx_snd_common.h
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/999_other-document.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/../linux-6.12.109-xlnx-v2025.1/999_other-document.patch
patching file MAINTAINERS
Hunk #6 succeeded at 19816 (offset 1 line).
Hunk #7 succeeded at 21139 (offset 1 line).
Hunk #8 succeeded at 23847 (offset 1 line).
Hunk #9 succeeded at 24243 (offset 1 line).
Hunk #10 succeeded at 24270 (offset 1 line).
Hunk #11 succeeded at 25481 (offset 1 line).
Hunk #12 succeeded at 25543 (offset 1 line).
Hunk #13 succeeded at 25623 (offset 1 line).
Hunk #14 succeeded at 25731 (offset 1 line).
Hunk #15 succeeded at 25844 (offset 1 line).
Hunk #16 succeeded at 25880 (offset 1 line).
Hunk #17 succeeded at 25910 (offset 1 line).
git add --all
git commit -m '[patch] 999_other-document.patch'
[linux-6.12.113-xlnx-v2025.1-1 d6d6179bd] [patch] 999_other-document.patch
 2 files changed, 26152 insertions(+), 3 deletions(-)
 create mode 100644 MAINTAINERS.orig
git diff HEAD^ > /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.113-xlnx-v2025.1/999_other-document.patch
shell$ cd ..
```

#### Prepare linux-6.12.113-xlnx-v2025.1-2

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout v6.12.113
shell$ git checkout -b linux-6.12.113-xlnx-v2025.1-2
```

#### Fix patches/linux-6.12.113-xlnx-v2025.1

##### 210_drivers-gpu-drm.patch

###### drivers/gpu/drm/panel/panel-simple.c

```console
shell$ diff -p linux-6.12.109/drivers/gpu/drm/panel/panel-simple.c linux-6.12.113/drivers/gpu/drm/panel/panel-simple.c
*** linux-6.12.109/drivers/gpu/drm/panel/panel-simple.c	2026-10-09 15:27:31.886881351 +0900
--- linux-6.12.113/drivers/gpu/drm/panel/panel-simple.c	2026-10-23 13:59:44.146755178 +0900
*************** static const struct panel_desc ampire_am
*** 785,790 ****
--- 785,815 ----
  	.connector_type = DRM_MODE_CONNECTOR_LVDS,
  };
  
+ static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+ 	.clock = 72400,
+ 	.hdisplay = 1280,
+ 	.hsync_start = 1280 + 40,
+ 	.hsync_end = 1280 + 40 + 80,
+ 	.htotal = 1280 + 40 + 80 + 40,
+ 	.vdisplay = 800,
+ 	.vsync_start = 800 + 10,
+ 	.vsync_end = 800 + 10 + 18,
+ 	.vtotal = 800 + 10 + 18 + 10,
+ };
+ 
+ static const struct panel_desc ampire_am_1280800w8tzqw_t00h = {
+ 	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+ 	.num_modes = 1,
+ 	.bpc = 8,
+ 	.size = {
+ 		.width = 217,
+ 		.height = 136,
+ 	},
+ 	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+ 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+ 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+ };
+ 
  static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
  	.clock = 9000,
  	.hdisplay = 480,
*************** static const struct of_device_id platfor
*** 4624,4629 ****
--- 4649,4657 ----
  		.compatible = "ampire,am-1280800n3tzqw-t00h",
  		.data = &ampire_am_1280800n3tzqw_t00h,
  	}, {
+ 		.compatible = "ampire,am-1280800w8tzqw-t00h",
+ 		.data = &ampire_am_1280800w8tzqw_t00h,
+ 	}, {
  		.compatible = "ampire,am-480272h3tmqw-t01h",
  		.data = &ampire_am_480272h3tmqw_t01h,
  	}, {
```

###### Make 210_drivers-gpu-drm.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/210_drivers-gpu-drm.patch
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
Hunk #1 succeeded at 5191 (offset 28 lines).
Hunk #2 succeeded at 5396 (offset 28 lines).
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
```

```console
shell$ rm drivers/gpu/drm/panel/panel-simple.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 210_drivers-gpu-drm.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/210_drivers-gpu-drm.patch
```

##### 212_drivers-i2c.patch

###### drivers/i2c/busses/i2c-xiic.c

```console
shell$ diff -p linux-6.12.109/drivers/i2c/busses/i2c-xiic.c linux-6.12.113/drivers/i2c/busses/i2c-xiic.c
*** linux-6.12.109/drivers/i2c/busses/i2c-xiic.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.113/drivers/i2c/busses/i2c-xiic.c	2026-10-23 13:59:44.276702422 +0900
*************** enum i2c_scl_freq {
*** 72,77 ****
--- 72,80 ----
   * @prev_msg_tx: Previous message is Tx
   * @quirks: To hold platform specific bug info
   * @smbus_block_read: Flag to handle block read
+  * @smbus_actual_len: Valid byte count (length + payload + optional PEC) of a
+  *	padded SMBus block read. msg->len is trimmed to this on completion.
+  *	Zero when no trimming is needed.
   * @input_clk: Input clock to I2C controller
   * @i2c_clk: I2C SCL frequency
   */
*************** struct xiic_i2c {
*** 94,99 ****
--- 97,103 ----
  	bool prev_msg_tx;
  	u32 quirks;
  	bool smbus_block_read;
+ 	unsigned int smbus_actual_len;
  	unsigned long input_clk;
  	unsigned int i2c_clk;
  };
*************** static const struct timing_regs timing_r
*** 238,243 ****
--- 242,270 ----
  static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
  static void __xiic_start_xfer(struct xiic_i2c *i2c);
  
+ static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 
+ 	clk_disable(i2c->clk);
+ 
+ 	return 0;
+ }
+ 
+ static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 	int ret;
+ 
+ 	ret = clk_enable(i2c->clk);
+ 	if (ret) {
+ 		dev_err(dev, "Cannot enable clock.\n");
+ 		return ret;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  /*
   * For the register read and write functions, a little-endian and big-endian
   * version are necessary. Endianness is detected during the probe function.
*************** static void xiic_smbus_block_read_setup(
*** 505,534 ****
  
  	/* Check if received length is valid */
  	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
  		/* Set Receive fifo depth */
! 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
  			/*
! 			 * When Rx msg len greater than or equal to Rx fifo capacity
! 			 * Receive fifo depth should set to Rx fifo capacity minus 1
  			 */
  			rfd_set = IIC_RX_FIFO_DEPTH - 1;
! 			i2c->rx_msg->len = rxmsg_len + 1;
! 		} else if ((rxmsg_len == 1) ||
! 			(rxmsg_len == 0)) {
  			/*
! 			 * Minimum of 3 bytes required to exit cleanly. 1 byte
! 			 * already received, Second byte is being received. Have
! 			 * to set NACK in read_rx before receiving the last byte
  			 */
  			rfd_set = 0;
  			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
  		} else {
  			/*
! 			 * When Rx msg len less than Rx fifo capacity
! 			 * Receive fifo depth should set to Rx msg len minus 2
  			 */
! 			rfd_set = rxmsg_len - 2;
! 			i2c->rx_msg->len = rxmsg_len + 1;
  		}
  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
  
--- 532,569 ----
  
  	/* Check if received length is valid */
  	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+ 		unsigned int pec_len = i2c->rx_msg->len - 1;
+ 
  		/* Set Receive fifo depth */
! 		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
  			/*
! 			 * Trailing bytes (payload plus any PEC) exceed Rx FIFO
! 			 * capacity, so drain in chunks. This also keeps the
! 			 * else branch below from pushing rfd_set past the
! 			 * 4-bit XIIC_RFD_REG_OFFSET field.
  			 */
  			rfd_set = IIC_RX_FIFO_DEPTH - 1;
! 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
! 		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
  			/*
! 			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
! 			 * bus to exit cleanly: by the time the ISR reads the
! 			 * length byte the second byte is already being clocked
! 			 * in, too late to NACK. Pad the drain target and record
! 			 * the real length, trimmed back on completion so the
! 			 * PEC check sees the right byte.
  			 */
  			rfd_set = 0;
  			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
+ 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
  		} else {
  			/*
! 			 * All trailing bytes fit in the Rx FIFO. The widened
! 			 * condition above guarantees rxmsg_len + pec_len >= 2,
! 			 * so this cannot underflow.
  			 */
! 			rfd_set = rxmsg_len + pec_len - 2;
! 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
  		}
  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
  
*************** static irqreturn_t xiic_process(int irq,
*** 737,742 ****
--- 772,781 ----
  
  		xiic_read_rx(i2c);
  		if (xiic_rx_space(i2c) == 0) {
+ 			/* Undo padding so the PEC check sees the right byte. */
+ 			if (i2c->smbus_actual_len)
+ 				i2c->rx_msg->len = i2c->smbus_actual_len;
+ 
  			/* this is the last part of the message */
  			i2c->rx_msg = NULL;
  
*************** static irqreturn_t xiic_process(int irq,
*** 805,812 ****
  
  		if (i2c->tx_msg && i2c->smbus_block_read) {
  			i2c->smbus_block_read = false;
! 			/* Set requested message len=1 to indicate STATE_DONE */
! 			i2c->tx_msg->len = 1;
  		}
  
  		if (!i2c->tx_msg)
--- 844,854 ----
  
  		if (i2c->tx_msg && i2c->smbus_block_read) {
  			i2c->smbus_block_read = false;
! 			/*
! 			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
! 			 * without truncating the rx_msg length.
! 			 */
! 			i2c->tx_pos = i2c->tx_msg->len;
  		}
  
  		if (!i2c->tx_msg)
*************** static void xiic_start_recv(struct xiic_
*** 867,872 ****
--- 909,917 ----
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
+ 	/* A stale value from an aborted block read would truncate this msg. */
+ 	i2c->smbus_actual_len = 0;
+ 
  	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
  		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
  		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
*************** static void xiic_i2c_remove(struct platf
*** 1365,1393 ****
  	pm_runtime_dont_use_autosuspend(&pdev->dev);
  }
  
- static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 
- 	clk_disable(i2c->clk);
- 
- 	return 0;
- }
- 
- static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 	int ret;
- 
- 	ret = clk_enable(i2c->clk);
- 	if (ret) {
- 		dev_err(dev, "Cannot enable clock.\n");
- 		return ret;
- 	}
- 
- 	return 0;
- }
- 
  static const struct dev_pm_ops xiic_dev_pm_ops = {
  	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
  			   xiic_i2c_runtime_resume, NULL)
--- 1410,1415 ----
```

```console
shell$ diff -p linux-6.12.109/drivers/i2c/busses/i2c-xiic.c linux-6.12.109-xlnx-v2025.1/drivers/i2c/busses/i2c-xiic.c
*** linux-6.12.109/drivers/i2c/busses/i2c-xiic.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/i2c/busses/i2c-xiic.c	2026-10-22 11:50:15.974160695 +0900
***************
*** 30,35 ****
--- 30,37 ----
  #include <linux/of.h>
  #include <linux/clk.h>
  #include <linux/pm_runtime.h>
+ #include <linux/iopoll.h>
+ #include <linux/spinlock.h>
  
  #define DRIVER_NAME "xiic-i2c"
  #define DYNAMIC_MODE_READ_BROKEN_BIT	BIT(0)
*************** enum i2c_scl_freq {
*** 74,79 ****
--- 76,84 ----
   * @smbus_block_read: Flag to handle block read
   * @input_clk: Input clock to I2C controller
   * @i2c_clk: I2C SCL frequency
+  * @atomic: Mode of transfer
+  * @atomic_lock: Lock for atomic transfer mode
+  * @atomic_xfer_state: See STATE_
   */
  struct xiic_i2c {
  	struct device *dev;
*************** struct xiic_i2c {
*** 96,101 ****
--- 101,109 ----
  	bool smbus_block_read;
  	unsigned long input_clk;
  	unsigned int i2c_clk;
+ 	bool atomic;
+ 	spinlock_t atomic_lock;		/* Lock for atomic transfer mode */
+ 	enum xilinx_i2c_state atomic_xfer_state;
  };
  
  struct xiic_version_data {
*************** static const struct timing_regs timing_r
*** 224,229 ****
--- 232,239 ----
  #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
  /* timeout waiting for the controller finish transfers */
  #define XIIC_XFER_TIMEOUT	(msecs_to_jiffies(10000))
+ /* timeout waiting for the controller finish transfers in micro seconds */
+ #define XIIC_XFER_TIMEOUT_US	10000000
  
  /*
   * The following constant is used for the device global interrupt enable
*************** static const struct timing_regs timing_r
*** 238,243 ****
--- 248,276 ----
  static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
  static void __xiic_start_xfer(struct xiic_i2c *i2c);
  
+ static int xiic_i2c_runtime_suspend(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 
+ 	clk_disable(i2c->clk);
+ 
+ 	return 0;
+ }
+ 
+ static int xiic_i2c_runtime_resume(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 	int ret;
+ 
+ 	ret = clk_enable(i2c->clk);
+ 	if (ret) {
+ 		dev_err(dev, "Cannot enable clock.\n");
+ 		return ret;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  /*
   * For the register read and write functions, a little-endian and big-endian
   * version are necessary. Endianness is detected during the probe function.
*************** static int xiic_setclk(struct xiic_i2c *
*** 374,382 ****
  	unsigned int index = 0;
  	u32 reg_val;
  
! 	dev_dbg(i2c->adap.dev.parent,
! 		"%s entry, i2c->input_clk: %ld, i2c->i2c_clk: %d\n",
! 		__func__, i2c->input_clk, i2c->i2c_clk);
  
  	/* If not specified in DT, do not configure in SW. Rely only on Vivado design */
  	if (!i2c->i2c_clk || !i2c->input_clk)
--- 407,416 ----
  	unsigned int index = 0;
  	u32 reg_val;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent,
! 			"%s entry, i2c->input_clk: %ld, i2c->i2c_clk: %d\n",
! 			__func__, i2c->input_clk, i2c->i2c_clk);
  
  	/* If not specified in DT, do not configure in SW. Rely only on Vivado design */
  	if (!i2c->i2c_clk || !i2c->input_clk)
*************** static int xiic_reinit(struct xiic_i2c *
*** 467,473 ****
  		return ret;
  
  	/* Enable interrupts */
! 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
  	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
  
--- 501,508 ----
  		return ret;
  
  	/* Enable interrupts */
! 	if (!i2c->atomic)
! 		xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
  	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
  
*************** static void xiic_read_rx(struct xiic_i2c
*** 549,559 ****
  
  	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
  
! 	dev_dbg(i2c->adap.dev.parent,
! 		"%s entry, bytes in fifo: %d, rem: %d, SR: 0x%x, CR: 0x%x\n",
! 		__func__, bytes_in_fifo, xiic_rx_space(i2c),
! 		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (bytes_in_fifo > xiic_rx_space(i2c))
  		bytes_in_fifo = xiic_rx_space(i2c);
--- 584,595 ----
  
  	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent,
! 			"%s entry, bytes in fifo: %d, rem: %d, SR: 0x%x, CR: 0x%x\n",
! 			__func__, bytes_in_fifo, xiic_rx_space(i2c),
! 			xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (bytes_in_fifo > xiic_rx_space(i2c))
  		bytes_in_fifo = xiic_rx_space(i2c);
*************** static void xiic_read_rx(struct xiic_i2c
*** 612,617 ****
--- 648,673 ----
  	}
  }
  
+ static bool xiic_error_check(struct xiic_i2c *i2c)
+ {
+ 	bool status = false;
+ 	u32 pend, isr, ier;
+ 
+ 	isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
+ 	ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
+ 	pend = isr & ier;
+ 
+ 	if ((pend & XIIC_INTR_ARB_LOST_MASK) ||
+ 	    ((pend & XIIC_INTR_TX_ERROR_MASK) &&
+ 	    !(pend & XIIC_INTR_RX_FULL_MASK))) {
+ 		xiic_reinit(i2c);
+ 		status = true;
+ 		if (i2c->tx_msg || i2c->rx_msg)
+ 			i2c->atomic_xfer_state = STATE_ERROR;
+ 	}
+ 	return status;
+ }
+ 
  static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
  {
  	/* return the actual space left in the FIFO */
*************** static void xiic_fill_tx_fifo(struct xii
*** 625,632 ****
  
  	len = (len > fifo_space) ? fifo_space : len;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
! 		__func__, len, fifo_space);
  
  	while (len--) {
  		u16 data = i2c->tx_msg->buf[i2c->tx_pos++];
--- 681,689 ----
  
  	len = (len > fifo_space) ? fifo_space : len;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
! 			__func__, len, fifo_space);
  
  	while (len--) {
  		u16 data = i2c->tx_msg->buf[i2c->tx_pos++];
*************** static void xiic_fill_tx_fifo(struct xii
*** 649,657 ****
  				xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
  					     ~XIIC_CR_MSMS_MASK);
  			}
! 			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
  		}
  		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
  	}
  }
  
--- 706,718 ----
  				xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
  					     ~XIIC_CR_MSMS_MASK);
  			}
! 			if (!i2c->atomic)
! 				dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
  		}
  		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
+ 
+ 		if (i2c->atomic && xiic_error_check(i2c))
+ 			return;
  	}
  }
  
*************** static int xiic_wait_not_busy(struct xii
*** 854,875 ****
  	 */
  	err = xiic_bus_busy(i2c);
  	while (err && tries--) {
! 		msleep(1);
  		err = xiic_bus_busy(i2c);
  	}
  
  	return err;
  }
  
  static void xiic_start_recv(struct xiic_i2c *i2c)
  {
  	u16 rx_watermark;
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	/* Disable Tx interrupts */
  	xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK | XIIC_INTR_TX_EMPTY_MASK);
--- 915,965 ----
  	 */
  	err = xiic_bus_busy(i2c);
  	while (err && tries--) {
! 		if (i2c->atomic)
! 			udelay(1000);
! 		else
! 			usleep_range(1000, 1100);
  		err = xiic_bus_busy(i2c);
  	}
  
  	return err;
  }
  
+ static void xiic_recv_atomic(struct xiic_i2c *i2c)
+ {
+ 	while (xiic_rx_space(i2c)) {
+ 		if (xiic_getreg32(i2c, XIIC_IISR_OFFSET) & XIIC_INTR_RX_FULL_MASK) {
+ 			xiic_read_rx(i2c);
+ 
+ 			/* Clear Rx full and Tx error interrupts. */
+ 			xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK |
+ 					XIIC_INTR_TX_ERROR_MASK);
+ 		}
+ 		if (xiic_error_check(i2c))
+ 			return;
+ 	}
+ 
+ 	i2c->rx_msg = NULL;
+ 	xiic_irq_clr_en(i2c, XIIC_INTR_TX_ERROR_MASK);
+ 
+ 	/* send next message if this wasn't the last. */
+ 	if (i2c->nmsgs > 1) {
+ 		i2c->nmsgs--;
+ 		i2c->tx_msg++;
+ 		__xiic_start_xfer(i2c);
+ 	}
+ }
+ 
  static void xiic_start_recv(struct xiic_i2c *i2c)
  {
  	u16 rx_watermark;
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	/* Disable Tx interrupts */
  	xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK | XIIC_INTR_TX_EMPTY_MASK);
*************** static void xiic_start_recv(struct xiic_
*** 967,975 ****
  					XIIC_CR_MSMS_MASK)
  					& ~(XIIC_CR_DIR_IS_TX_MASK));
  		}
! 		dev_dbg(i2c->adap.dev.parent, "%s end, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  	}
  
  	if (i2c->nmsgs == 1)
--- 1057,1066 ----
  					XIIC_CR_MSMS_MASK)
  					& ~(XIIC_CR_DIR_IS_TX_MASK));
  		}
! 		if (!i2c->atomic)
! 			dev_dbg(i2c->adap.dev.parent, "%s end, ISR: 0x%x, CR: 0x%x\n",
! 				__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 				xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  	}
  
  	if (i2c->nmsgs == 1)
*************** static void xiic_start_recv(struct xiic_
*** 979,988 ****
  	/* the message is tx:ed */
  	i2c->tx_pos = msg->len;
  
  	/* Enable interrupts */
! 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
! 	i2c->prev_msg_tx = false;
  }
  
  static void xiic_start_send(struct xiic_i2c *i2c)
--- 1070,1124 ----
  	/* the message is tx:ed */
  	i2c->tx_pos = msg->len;
  
+ 	i2c->prev_msg_tx = false;
+ 
  	/* Enable interrupts */
! 	if (!i2c->atomic)
! 		xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
! 	else
! 		xiic_recv_atomic(i2c);
! }
  
! static void xiic_send_rem_atomic(struct xiic_i2c *i2c)
! {
! 	while (xiic_tx_space(i2c)) {
! 		if (xiic_tx_fifo_space(i2c)) {
! 			u16 data;
! 
! 			data = i2c->tx_msg->buf[i2c->tx_pos];
! 			i2c->tx_pos++;
! 			if (!xiic_tx_space(i2c) && i2c->nmsgs == 1) {
! 				/* last message in transfer -> STOP */
! 				if (i2c->dynamic) {
! 					data |= XIIC_TX_DYN_STOP_MASK;
! 				} else {
! 					u8 cr;
! 					int status;
! 
! 					/* Wait till FIFO is empty so STOP is sent last */
! 					status = xiic_wait_tx_empty(i2c);
! 					if (status)
! 						return;
! 
! 					/* Write to CR to stop */
! 					cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
! 					xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
! 						     ~XIIC_CR_MSMS_MASK);
! 				}
! 			}
! 			xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
! 		}
! 		if (xiic_error_check(i2c))
! 			return;
! 	}
! 
! 	if (i2c->nmsgs > 1) {
! 		i2c->nmsgs--;
! 		i2c->tx_msg++;
! 		__xiic_start_xfer(i2c);
! 	} else {
! 		xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
! 	}
  }
  
  static void xiic_start_send(struct xiic_i2c *i2c)
*************** static void xiic_start_send(struct xiic_
*** 991,1001 ****
  	u16 data;
  	struct i2c_msg *msg = i2c->tx_msg;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len: %d",
! 		__func__, msg, msg->len);
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (i2c->dynamic) {
  		/* write the address */
--- 1127,1139 ----
  	u16 data;
  	struct i2c_msg *msg = i2c->tx_msg;
  
! 	if (!i2c->atomic) {
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len: %d",
! 			__func__, msg, msg->len);
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
! 	}
  
  	if (i2c->dynamic) {
  		/* write the address */
*************** static void xiic_start_send(struct xiic_
*** 1060,1078 ****
  				XIIC_INTR_TX_ERROR_MASK |
  				XIIC_INTR_BNB_MASK);
  	}
  	i2c->prev_msg_tx = true;
  }
  
  static void __xiic_start_xfer(struct xiic_i2c *i2c)
  {
  	int fifo_space = xiic_tx_fifo_space(i2c);
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, fifos space: %d\n",
! 		__func__, i2c->tx_msg, fifo_space);
  
  	if (!i2c->tx_msg)
  		return;
  
  	i2c->rx_pos = 0;
  	i2c->tx_pos = 0;
  	i2c->state = STATE_START;
--- 1198,1224 ----
  				XIIC_INTR_TX_ERROR_MASK |
  				XIIC_INTR_BNB_MASK);
  	}
+ 
  	i2c->prev_msg_tx = true;
+ 
+ 	if (i2c->atomic && !i2c->atomic_xfer_state)
+ 		xiic_send_rem_atomic(i2c);
  }
  
  static void __xiic_start_xfer(struct xiic_i2c *i2c)
  {
  	int fifo_space = xiic_tx_fifo_space(i2c);
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, fifos space: %d\n",
! 			__func__, i2c->tx_msg, fifo_space);
  
  	if (!i2c->tx_msg)
  		return;
  
+ 	if (i2c->atomic && xiic_error_check(i2c))
+ 		return;
+ 
  	i2c->rx_pos = 0;
  	i2c->tx_pos = 0;
  	i2c->state = STATE_START;
*************** static int xiic_start_xfer(struct xiic_i
*** 1089,1095 ****
  	bool broken_read, max_read_len, smbus_blk_read;
  	int ret, count;
  
! 	mutex_lock(&i2c->lock);
  
  	if (i2c->tx_msg || i2c->rx_msg) {
  		dev_err(i2c->adap.dev.parent,
--- 1235,1244 ----
  	bool broken_read, max_read_len, smbus_blk_read;
  	int ret, count;
  
! 	if (i2c->atomic)
! 		spin_lock(&i2c->atomic_lock);
! 	else
! 		mutex_lock(&i2c->lock);
  
  	if (i2c->tx_msg || i2c->rx_msg) {
  		dev_err(i2c->adap.dev.parent,
*************** static int xiic_start_xfer(struct xiic_i
*** 1098,1103 ****
--- 1247,1254 ----
  		goto out;
  	}
  
+ 	i2c->atomic_xfer_state = STATE_DONE;
+ 
  	/* In single master mode bus can only be busy, when in use by this
  	 * driver. If the register indicates bus being busy for some reason we
  	 * should ignore it, since bus will never be released and i2c will be
*************** static int xiic_start_xfer(struct xiic_i
*** 1124,1130 ****
  	i2c->tx_msg = msgs;
  	i2c->rx_msg = NULL;
  	i2c->nmsgs = num;
! 	init_completion(&i2c->completion);
  
  	/* Decide standard mode or Dynamic mode */
  	i2c->dynamic = true;
--- 1275,1283 ----
  	i2c->tx_msg = msgs;
  	i2c->rx_msg = NULL;
  	i2c->nmsgs = num;
! 
! 	if (!i2c->atomic)
! 		init_completion(&i2c->completion);
  
  	/* Decide standard mode or Dynamic mode */
  	i2c->dynamic = true;
*************** static int xiic_start_xfer(struct xiic_i
*** 1159,1165 ****
  		__xiic_start_xfer(i2c);
  
  out:
! 	mutex_unlock(&i2c->lock);
  
  	return ret;
  }
--- 1312,1321 ----
  		__xiic_start_xfer(i2c);
  
  out:
! 	if (i2c->atomic)
! 		spin_unlock(&i2c->atomic_lock);
! 	else
! 		mutex_unlock(&i2c->lock);
  
  	return ret;
  }
*************** out:
*** 1198,1203 ****
--- 1354,1397 ----
  	return err;
  }
  
+ static int xiic_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+ {
+ 	struct xiic_i2c *i2c = i2c_get_adapdata(adap);
+ 	u32 status_reg;
+ 	int err;
+ 
+ 	err = xiic_i2c_runtime_resume(i2c->dev);
+ 	if (err)
+ 		return err;
+ 
+ 	i2c->atomic = true;
+ 	err = xiic_start_xfer(i2c, msgs, num);
+ 	if (err < 0)
+ 		return err;
+ 
+ 	err = readl_poll_timeout_atomic(i2c->base + XIIC_SR_REG_OFFSET,
+ 					status_reg, !(status_reg & XIIC_SR_BUS_BUSY_MASK),
+ 					1, XIIC_XFER_TIMEOUT_US);
+ 
+ 	if (err) /* Timeout */
+ 		err = -ETIMEDOUT;
+ 
+ 	spin_lock(&i2c->atomic_lock);
+ 	if (err || i2c->state) {
+ 		i2c->tx_msg = NULL;
+ 		i2c->rx_msg = NULL;
+ 		i2c->nmsgs = 0;
+ 	}
+ 
+ 	err = (i2c->atomic_xfer_state == STATE_DONE) ? num : -EIO;
+ 	spin_unlock(&i2c->atomic_lock);
+ 
+ 	i2c->atomic = false;
+ 	xiic_i2c_runtime_suspend(i2c->dev);
+ 
+ 	return err;
+ }
+ 
  static u32 xiic_func(struct i2c_adapter *adap)
  {
  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
*************** static u32 xiic_func(struct i2c_adapter
*** 1205,1210 ****
--- 1399,1405 ----
  
  static const struct i2c_algorithm xiic_algorithm = {
  	.master_xfer = xiic_xfer,
+ 	.master_xfer_atomic = xiic_xfer_atomic,
  	.functionality = xiic_func,
  };
  
*************** static int xiic_i2c_probe(struct platfor
*** 1268,1273 ****
--- 1463,1469 ----
  		 DRIVER_NAME " %s", pdev->name);
  
  	mutex_init(&i2c->lock);
+ 	spin_lock_init(&i2c->atomic_lock);
  
  	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
  	if (IS_ERR(i2c->clk))
*************** static void xiic_i2c_remove(struct platf
*** 1365,1393 ****
  	pm_runtime_dont_use_autosuspend(&pdev->dev);
  }
  
- static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 
- 	clk_disable(i2c->clk);
- 
- 	return 0;
- }
- 
- static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 	int ret;
- 
- 	ret = clk_enable(i2c->clk);
- 	if (ret) {
- 		dev_err(dev, "Cannot enable clock.\n");
- 		return ret;
- 	}
- 
- 	return 0;
- }
- 
  static const struct dev_pm_ops xiic_dev_pm_ops = {
  	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
  			   xiic_i2c_runtime_resume, NULL)
--- 1561,1566 ----
```

###### drivers/i2c/i2c-atr.c

```console
shell$ diff -p linux-6.12.109/drivers/i2c/i2c-atr.c linux-6.12.113/drivers/i2c/i2c-atr.c
*** linux-6.12.109/drivers/i2c/i2c-atr.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.113/drivers/i2c/i2c-atr.c	2026-10-23 13:59:44.276702422 +0900
*************** int i2c_atr_add_adapter(struct i2c_atr *
*** 632,637 ****
--- 632,638 ----
  
  	ret = i2c_add_adapter(&chan->adap);
  	if (ret) {
+ 		atr->adapter[chan_id] = NULL;
  		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
  			chan_id, ret);
  		goto err_fwnode_put;
```

###### drivers/i2c/busses/i2c-xiic.c

```console
shell$ diff -p linux-6.12.109/drivers/i2c/busses/i2c-xiic.c linux-6.12.113/drivers/i2c/busses/i2c-xiic.c
*** linux-6.12.109/drivers/i2c/busses/i2c-xiic.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.113/drivers/i2c/busses/i2c-xiic.c	2026-10-23 13:59:44.276702422 +0900
*************** enum i2c_scl_freq {
*** 72,77 ****
--- 72,80 ----
   * @prev_msg_tx: Previous message is Tx
   * @quirks: To hold platform specific bug info
   * @smbus_block_read: Flag to handle block read
+  * @smbus_actual_len: Valid byte count (length + payload + optional PEC) of a
+  *	padded SMBus block read. msg->len is trimmed to this on completion.
+  *	Zero when no trimming is needed.
   * @input_clk: Input clock to I2C controller
   * @i2c_clk: I2C SCL frequency
   */
*************** struct xiic_i2c {
*** 94,99 ****
--- 97,103 ----
  	bool prev_msg_tx;
  	u32 quirks;
  	bool smbus_block_read;
+ 	unsigned int smbus_actual_len;
  	unsigned long input_clk;
  	unsigned int i2c_clk;
  };
*************** static const struct timing_regs timing_r
*** 238,243 ****
--- 242,270 ----
  static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
  static void __xiic_start_xfer(struct xiic_i2c *i2c);
  
+ static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 
+ 	clk_disable(i2c->clk);
+ 
+ 	return 0;
+ }
+ 
+ static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 	int ret;
+ 
+ 	ret = clk_enable(i2c->clk);
+ 	if (ret) {
+ 		dev_err(dev, "Cannot enable clock.\n");
+ 		return ret;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  /*
   * For the register read and write functions, a little-endian and big-endian
   * version are necessary. Endianness is detected during the probe function.
*************** static void xiic_smbus_block_read_setup(
*** 505,534 ****
  
  	/* Check if received length is valid */
  	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
  		/* Set Receive fifo depth */
! 		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
  			/*
! 			 * When Rx msg len greater than or equal to Rx fifo capacity
! 			 * Receive fifo depth should set to Rx fifo capacity minus 1
  			 */
  			rfd_set = IIC_RX_FIFO_DEPTH - 1;
! 			i2c->rx_msg->len = rxmsg_len + 1;
! 		} else if ((rxmsg_len == 1) ||
! 			(rxmsg_len == 0)) {
  			/*
! 			 * Minimum of 3 bytes required to exit cleanly. 1 byte
! 			 * already received, Second byte is being received. Have
! 			 * to set NACK in read_rx before receiving the last byte
  			 */
  			rfd_set = 0;
  			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
  		} else {
  			/*
! 			 * When Rx msg len less than Rx fifo capacity
! 			 * Receive fifo depth should set to Rx msg len minus 2
  			 */
! 			rfd_set = rxmsg_len - 2;
! 			i2c->rx_msg->len = rxmsg_len + 1;
  		}
  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
  
--- 532,569 ----
  
  	/* Check if received length is valid */
  	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+ 		unsigned int pec_len = i2c->rx_msg->len - 1;
+ 
  		/* Set Receive fifo depth */
! 		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
  			/*
! 			 * Trailing bytes (payload plus any PEC) exceed Rx FIFO
! 			 * capacity, so drain in chunks. This also keeps the
! 			 * else branch below from pushing rfd_set past the
! 			 * 4-bit XIIC_RFD_REG_OFFSET field.
  			 */
  			rfd_set = IIC_RX_FIFO_DEPTH - 1;
! 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
! 		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
  			/*
! 			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
! 			 * bus to exit cleanly: by the time the ISR reads the
! 			 * length byte the second byte is already being clocked
! 			 * in, too late to NACK. Pad the drain target and record
! 			 * the real length, trimmed back on completion so the
! 			 * PEC check sees the right byte.
  			 */
  			rfd_set = 0;
  			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
+ 			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
  		} else {
  			/*
! 			 * All trailing bytes fit in the Rx FIFO. The widened
! 			 * condition above guarantees rxmsg_len + pec_len >= 2,
! 			 * so this cannot underflow.
  			 */
! 			rfd_set = rxmsg_len + pec_len - 2;
! 			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
  		}
  		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
  
*************** static irqreturn_t xiic_process(int irq,
*** 737,742 ****
--- 772,781 ----
  
  		xiic_read_rx(i2c);
  		if (xiic_rx_space(i2c) == 0) {
+ 			/* Undo padding so the PEC check sees the right byte. */
+ 			if (i2c->smbus_actual_len)
+ 				i2c->rx_msg->len = i2c->smbus_actual_len;
+ 
  			/* this is the last part of the message */
  			i2c->rx_msg = NULL;
  
*************** static irqreturn_t xiic_process(int irq,
*** 805,812 ****
  
  		if (i2c->tx_msg && i2c->smbus_block_read) {
  			i2c->smbus_block_read = false;
! 			/* Set requested message len=1 to indicate STATE_DONE */
! 			i2c->tx_msg->len = 1;
  		}
  
  		if (!i2c->tx_msg)
--- 844,854 ----
  
  		if (i2c->tx_msg && i2c->smbus_block_read) {
  			i2c->smbus_block_read = false;
! 			/*
! 			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
! 			 * without truncating the rx_msg length.
! 			 */
! 			i2c->tx_pos = i2c->tx_msg->len;
  		}
  
  		if (!i2c->tx_msg)
*************** static void xiic_start_recv(struct xiic_
*** 867,872 ****
--- 909,917 ----
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
+ 	/* A stale value from an aborted block read would truncate this msg. */
+ 	i2c->smbus_actual_len = 0;
+ 
  	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
  		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
  		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
*************** static void xiic_i2c_remove(struct platf
*** 1365,1393 ****
  	pm_runtime_dont_use_autosuspend(&pdev->dev);
  }
  
- static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 
- 	clk_disable(i2c->clk);
- 
- 	return 0;
- }
- 
- static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 	int ret;
- 
- 	ret = clk_enable(i2c->clk);
- 	if (ret) {
- 		dev_err(dev, "Cannot enable clock.\n");
- 		return ret;
- 	}
- 
- 	return 0;
- }
- 
  static const struct dev_pm_ops xiic_dev_pm_ops = {
  	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
  			   xiic_i2c_runtime_resume, NULL)
--- 1410,1415 ----
```

```console
shell$ diff -p linux-6.12.109/drivers/i2c/busses/i2c-xiic.c linux-6.12.109-xlnx-v2025.1/drivers/i2c/busses/i2c-xiic.c
*** linux-6.12.109/drivers/i2c/busses/i2c-xiic.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/i2c/busses/i2c-xiic.c	2026-10-22 11:50:15.974160695 +0900
***************
*** 30,35 ****
--- 30,37 ----
  #include <linux/of.h>
  #include <linux/clk.h>
  #include <linux/pm_runtime.h>
+ #include <linux/iopoll.h>
+ #include <linux/spinlock.h>
  
  #define DRIVER_NAME "xiic-i2c"
  #define DYNAMIC_MODE_READ_BROKEN_BIT	BIT(0)
*************** enum i2c_scl_freq {
*** 74,79 ****
--- 76,84 ----
   * @smbus_block_read: Flag to handle block read
   * @input_clk: Input clock to I2C controller
   * @i2c_clk: I2C SCL frequency
+  * @atomic: Mode of transfer
+  * @atomic_lock: Lock for atomic transfer mode
+  * @atomic_xfer_state: See STATE_
   */
  struct xiic_i2c {
  	struct device *dev;
*************** struct xiic_i2c {
*** 96,101 ****
--- 101,109 ----
  	bool smbus_block_read;
  	unsigned long input_clk;
  	unsigned int i2c_clk;
+ 	bool atomic;
+ 	spinlock_t atomic_lock;		/* Lock for atomic transfer mode */
+ 	enum xilinx_i2c_state atomic_xfer_state;
  };
  
  struct xiic_version_data {
*************** static const struct timing_regs timing_r
*** 224,229 ****
--- 232,239 ----
  #define XIIC_I2C_TIMEOUT	(msecs_to_jiffies(1000))
  /* timeout waiting for the controller finish transfers */
  #define XIIC_XFER_TIMEOUT	(msecs_to_jiffies(10000))
+ /* timeout waiting for the controller finish transfers in micro seconds */
+ #define XIIC_XFER_TIMEOUT_US	10000000
  
  /*
   * The following constant is used for the device global interrupt enable
*************** static const struct timing_regs timing_r
*** 238,243 ****
--- 248,276 ----
  static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
  static void __xiic_start_xfer(struct xiic_i2c *i2c);
  
+ static int xiic_i2c_runtime_suspend(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 
+ 	clk_disable(i2c->clk);
+ 
+ 	return 0;
+ }
+ 
+ static int xiic_i2c_runtime_resume(struct device *dev)
+ {
+ 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
+ 	int ret;
+ 
+ 	ret = clk_enable(i2c->clk);
+ 	if (ret) {
+ 		dev_err(dev, "Cannot enable clock.\n");
+ 		return ret;
+ 	}
+ 
+ 	return 0;
+ }
+ 
  /*
   * For the register read and write functions, a little-endian and big-endian
   * version are necessary. Endianness is detected during the probe function.
*************** static int xiic_setclk(struct xiic_i2c *
*** 374,382 ****
  	unsigned int index = 0;
  	u32 reg_val;
  
! 	dev_dbg(i2c->adap.dev.parent,
! 		"%s entry, i2c->input_clk: %ld, i2c->i2c_clk: %d\n",
! 		__func__, i2c->input_clk, i2c->i2c_clk);
  
  	/* If not specified in DT, do not configure in SW. Rely only on Vivado design */
  	if (!i2c->i2c_clk || !i2c->input_clk)
--- 407,416 ----
  	unsigned int index = 0;
  	u32 reg_val;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent,
! 			"%s entry, i2c->input_clk: %ld, i2c->i2c_clk: %d\n",
! 			__func__, i2c->input_clk, i2c->i2c_clk);
  
  	/* If not specified in DT, do not configure in SW. Rely only on Vivado design */
  	if (!i2c->i2c_clk || !i2c->input_clk)
*************** static int xiic_reinit(struct xiic_i2c *
*** 467,473 ****
  		return ret;
  
  	/* Enable interrupts */
! 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
  	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
  
--- 501,508 ----
  		return ret;
  
  	/* Enable interrupts */
! 	if (!i2c->atomic)
! 		xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
  	xiic_irq_clr_en(i2c, XIIC_INTR_ARB_LOST_MASK);
  
*************** static void xiic_read_rx(struct xiic_i2c
*** 549,559 ****
  
  	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
  
! 	dev_dbg(i2c->adap.dev.parent,
! 		"%s entry, bytes in fifo: %d, rem: %d, SR: 0x%x, CR: 0x%x\n",
! 		__func__, bytes_in_fifo, xiic_rx_space(i2c),
! 		xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (bytes_in_fifo > xiic_rx_space(i2c))
  		bytes_in_fifo = xiic_rx_space(i2c);
--- 584,595 ----
  
  	bytes_in_fifo = xiic_getreg8(i2c, XIIC_RFO_REG_OFFSET) + 1;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent,
! 			"%s entry, bytes in fifo: %d, rem: %d, SR: 0x%x, CR: 0x%x\n",
! 			__func__, bytes_in_fifo, xiic_rx_space(i2c),
! 			xiic_getreg8(i2c, XIIC_SR_REG_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (bytes_in_fifo > xiic_rx_space(i2c))
  		bytes_in_fifo = xiic_rx_space(i2c);
*************** static void xiic_read_rx(struct xiic_i2c
*** 612,617 ****
--- 648,673 ----
  	}
  }
  
+ static bool xiic_error_check(struct xiic_i2c *i2c)
+ {
+ 	bool status = false;
+ 	u32 pend, isr, ier;
+ 
+ 	isr = xiic_getreg32(i2c, XIIC_IISR_OFFSET);
+ 	ier = xiic_getreg32(i2c, XIIC_IIER_OFFSET);
+ 	pend = isr & ier;
+ 
+ 	if ((pend & XIIC_INTR_ARB_LOST_MASK) ||
+ 	    ((pend & XIIC_INTR_TX_ERROR_MASK) &&
+ 	    !(pend & XIIC_INTR_RX_FULL_MASK))) {
+ 		xiic_reinit(i2c);
+ 		status = true;
+ 		if (i2c->tx_msg || i2c->rx_msg)
+ 			i2c->atomic_xfer_state = STATE_ERROR;
+ 	}
+ 	return status;
+ }
+ 
  static int xiic_tx_fifo_space(struct xiic_i2c *i2c)
  {
  	/* return the actual space left in the FIFO */
*************** static void xiic_fill_tx_fifo(struct xii
*** 625,632 ****
  
  	len = (len > fifo_space) ? fifo_space : len;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
! 		__func__, len, fifo_space);
  
  	while (len--) {
  		u16 data = i2c->tx_msg->buf[i2c->tx_pos++];
--- 681,689 ----
  
  	len = (len > fifo_space) ? fifo_space : len;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, len: %d, fifo space: %d\n",
! 			__func__, len, fifo_space);
  
  	while (len--) {
  		u16 data = i2c->tx_msg->buf[i2c->tx_pos++];
*************** static void xiic_fill_tx_fifo(struct xii
*** 649,657 ****
  				xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
  					     ~XIIC_CR_MSMS_MASK);
  			}
! 			dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
  		}
  		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
  	}
  }
  
--- 706,718 ----
  				xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
  					     ~XIIC_CR_MSMS_MASK);
  			}
! 			if (!i2c->atomic)
! 				dev_dbg(i2c->adap.dev.parent, "%s TX STOP\n", __func__);
  		}
  		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
+ 
+ 		if (i2c->atomic && xiic_error_check(i2c))
+ 			return;
  	}
  }
  
*************** static int xiic_wait_not_busy(struct xii
*** 854,875 ****
  	 */
  	err = xiic_bus_busy(i2c);
  	while (err && tries--) {
! 		msleep(1);
  		err = xiic_bus_busy(i2c);
  	}
  
  	return err;
  }
  
  static void xiic_start_recv(struct xiic_i2c *i2c)
  {
  	u16 rx_watermark;
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	/* Disable Tx interrupts */
  	xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK | XIIC_INTR_TX_EMPTY_MASK);
--- 915,965 ----
  	 */
  	err = xiic_bus_busy(i2c);
  	while (err && tries--) {
! 		if (i2c->atomic)
! 			udelay(1000);
! 		else
! 			usleep_range(1000, 1100);
  		err = xiic_bus_busy(i2c);
  	}
  
  	return err;
  }
  
+ static void xiic_recv_atomic(struct xiic_i2c *i2c)
+ {
+ 	while (xiic_rx_space(i2c)) {
+ 		if (xiic_getreg32(i2c, XIIC_IISR_OFFSET) & XIIC_INTR_RX_FULL_MASK) {
+ 			xiic_read_rx(i2c);
+ 
+ 			/* Clear Rx full and Tx error interrupts. */
+ 			xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK |
+ 					XIIC_INTR_TX_ERROR_MASK);
+ 		}
+ 		if (xiic_error_check(i2c))
+ 			return;
+ 	}
+ 
+ 	i2c->rx_msg = NULL;
+ 	xiic_irq_clr_en(i2c, XIIC_INTR_TX_ERROR_MASK);
+ 
+ 	/* send next message if this wasn't the last. */
+ 	if (i2c->nmsgs > 1) {
+ 		i2c->nmsgs--;
+ 		i2c->tx_msg++;
+ 		__xiic_start_xfer(i2c);
+ 	}
+ }
+ 
  static void xiic_start_recv(struct xiic_i2c *i2c)
  {
  	u16 rx_watermark;
  	u8 cr = 0, rfd_set = 0;
  	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	/* Disable Tx interrupts */
  	xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK | XIIC_INTR_TX_EMPTY_MASK);
*************** static void xiic_start_recv(struct xiic_
*** 967,975 ****
  					XIIC_CR_MSMS_MASK)
  					& ~(XIIC_CR_DIR_IS_TX_MASK));
  		}
! 		dev_dbg(i2c->adap.dev.parent, "%s end, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  	}
  
  	if (i2c->nmsgs == 1)
--- 1057,1066 ----
  					XIIC_CR_MSMS_MASK)
  					& ~(XIIC_CR_DIR_IS_TX_MASK));
  		}
! 		if (!i2c->atomic)
! 			dev_dbg(i2c->adap.dev.parent, "%s end, ISR: 0x%x, CR: 0x%x\n",
! 				__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 				xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  	}
  
  	if (i2c->nmsgs == 1)
*************** static void xiic_start_recv(struct xiic_
*** 979,988 ****
  	/* the message is tx:ed */
  	i2c->tx_pos = msg->len;
  
  	/* Enable interrupts */
! 	xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
  
! 	i2c->prev_msg_tx = false;
  }
  
  static void xiic_start_send(struct xiic_i2c *i2c)
--- 1070,1124 ----
  	/* the message is tx:ed */
  	i2c->tx_pos = msg->len;
  
+ 	i2c->prev_msg_tx = false;
+ 
  	/* Enable interrupts */
! 	if (!i2c->atomic)
! 		xiic_setreg32(i2c, XIIC_DGIER_OFFSET, XIIC_GINTR_ENABLE_MASK);
! 	else
! 		xiic_recv_atomic(i2c);
! }
  
! static void xiic_send_rem_atomic(struct xiic_i2c *i2c)
! {
! 	while (xiic_tx_space(i2c)) {
! 		if (xiic_tx_fifo_space(i2c)) {
! 			u16 data;
! 
! 			data = i2c->tx_msg->buf[i2c->tx_pos];
! 			i2c->tx_pos++;
! 			if (!xiic_tx_space(i2c) && i2c->nmsgs == 1) {
! 				/* last message in transfer -> STOP */
! 				if (i2c->dynamic) {
! 					data |= XIIC_TX_DYN_STOP_MASK;
! 				} else {
! 					u8 cr;
! 					int status;
! 
! 					/* Wait till FIFO is empty so STOP is sent last */
! 					status = xiic_wait_tx_empty(i2c);
! 					if (status)
! 						return;
! 
! 					/* Write to CR to stop */
! 					cr = xiic_getreg8(i2c, XIIC_CR_REG_OFFSET);
! 					xiic_setreg8(i2c, XIIC_CR_REG_OFFSET, cr &
! 						     ~XIIC_CR_MSMS_MASK);
! 				}
! 			}
! 			xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET, data);
! 		}
! 		if (xiic_error_check(i2c))
! 			return;
! 	}
! 
! 	if (i2c->nmsgs > 1) {
! 		i2c->nmsgs--;
! 		i2c->tx_msg++;
! 		__xiic_start_xfer(i2c);
! 	} else {
! 		xiic_irq_dis(i2c, XIIC_INTR_TX_HALF_MASK);
! 	}
  }
  
  static void xiic_start_send(struct xiic_i2c *i2c)
*************** static void xiic_start_send(struct xiic_
*** 991,1001 ****
  	u16 data;
  	struct i2c_msg *msg = i2c->tx_msg;
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len: %d",
! 		__func__, msg, msg->len);
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 		__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 		xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
  
  	if (i2c->dynamic) {
  		/* write the address */
--- 1127,1139 ----
  	u16 data;
  	struct i2c_msg *msg = i2c->tx_msg;
  
! 	if (!i2c->atomic) {
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, len: %d",
! 			__func__, msg, msg->len);
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
! 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
! 			xiic_getreg8(i2c, XIIC_CR_REG_OFFSET));
! 	}
  
  	if (i2c->dynamic) {
  		/* write the address */
*************** static void xiic_start_send(struct xiic_
*** 1060,1078 ****
  				XIIC_INTR_TX_ERROR_MASK |
  				XIIC_INTR_BNB_MASK);
  	}
  	i2c->prev_msg_tx = true;
  }
  
  static void __xiic_start_xfer(struct xiic_i2c *i2c)
  {
  	int fifo_space = xiic_tx_fifo_space(i2c);
  
! 	dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, fifos space: %d\n",
! 		__func__, i2c->tx_msg, fifo_space);
  
  	if (!i2c->tx_msg)
  		return;
  
  	i2c->rx_pos = 0;
  	i2c->tx_pos = 0;
  	i2c->state = STATE_START;
--- 1198,1224 ----
  				XIIC_INTR_TX_ERROR_MASK |
  				XIIC_INTR_BNB_MASK);
  	}
+ 
  	i2c->prev_msg_tx = true;
+ 
+ 	if (i2c->atomic && !i2c->atomic_xfer_state)
+ 		xiic_send_rem_atomic(i2c);
  }
  
  static void __xiic_start_xfer(struct xiic_i2c *i2c)
  {
  	int fifo_space = xiic_tx_fifo_space(i2c);
  
! 	if (!i2c->atomic)
! 		dev_dbg(i2c->adap.dev.parent, "%s entry, msg: %p, fifos space: %d\n",
! 			__func__, i2c->tx_msg, fifo_space);
  
  	if (!i2c->tx_msg)
  		return;
  
+ 	if (i2c->atomic && xiic_error_check(i2c))
+ 		return;
+ 
  	i2c->rx_pos = 0;
  	i2c->tx_pos = 0;
  	i2c->state = STATE_START;
*************** static int xiic_start_xfer(struct xiic_i
*** 1089,1095 ****
  	bool broken_read, max_read_len, smbus_blk_read;
  	int ret, count;
  
! 	mutex_lock(&i2c->lock);
  
  	if (i2c->tx_msg || i2c->rx_msg) {
  		dev_err(i2c->adap.dev.parent,
--- 1235,1244 ----
  	bool broken_read, max_read_len, smbus_blk_read;
  	int ret, count;
  
! 	if (i2c->atomic)
! 		spin_lock(&i2c->atomic_lock);
! 	else
! 		mutex_lock(&i2c->lock);
  
  	if (i2c->tx_msg || i2c->rx_msg) {
  		dev_err(i2c->adap.dev.parent,
*************** static int xiic_start_xfer(struct xiic_i
*** 1098,1103 ****
--- 1247,1254 ----
  		goto out;
  	}
  
+ 	i2c->atomic_xfer_state = STATE_DONE;
+ 
  	/* In single master mode bus can only be busy, when in use by this
  	 * driver. If the register indicates bus being busy for some reason we
  	 * should ignore it, since bus will never be released and i2c will be
*************** static int xiic_start_xfer(struct xiic_i
*** 1124,1130 ****
  	i2c->tx_msg = msgs;
  	i2c->rx_msg = NULL;
  	i2c->nmsgs = num;
! 	init_completion(&i2c->completion);
  
  	/* Decide standard mode or Dynamic mode */
  	i2c->dynamic = true;
--- 1275,1283 ----
  	i2c->tx_msg = msgs;
  	i2c->rx_msg = NULL;
  	i2c->nmsgs = num;
! 
! 	if (!i2c->atomic)
! 		init_completion(&i2c->completion);
  
  	/* Decide standard mode or Dynamic mode */
  	i2c->dynamic = true;
*************** static int xiic_start_xfer(struct xiic_i
*** 1159,1165 ****
  		__xiic_start_xfer(i2c);
  
  out:
! 	mutex_unlock(&i2c->lock);
  
  	return ret;
  }
--- 1312,1321 ----
  		__xiic_start_xfer(i2c);
  
  out:
! 	if (i2c->atomic)
! 		spin_unlock(&i2c->atomic_lock);
! 	else
! 		mutex_unlock(&i2c->lock);
  
  	return ret;
  }
*************** out:
*** 1198,1203 ****
--- 1354,1397 ----
  	return err;
  }
  
+ static int xiic_xfer_atomic(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
+ {
+ 	struct xiic_i2c *i2c = i2c_get_adapdata(adap);
+ 	u32 status_reg;
+ 	int err;
+ 
+ 	err = xiic_i2c_runtime_resume(i2c->dev);
+ 	if (err)
+ 		return err;
+ 
+ 	i2c->atomic = true;
+ 	err = xiic_start_xfer(i2c, msgs, num);
+ 	if (err < 0)
+ 		return err;
+ 
+ 	err = readl_poll_timeout_atomic(i2c->base + XIIC_SR_REG_OFFSET,
+ 					status_reg, !(status_reg & XIIC_SR_BUS_BUSY_MASK),
+ 					1, XIIC_XFER_TIMEOUT_US);
+ 
+ 	if (err) /* Timeout */
+ 		err = -ETIMEDOUT;
+ 
+ 	spin_lock(&i2c->atomic_lock);
+ 	if (err || i2c->state) {
+ 		i2c->tx_msg = NULL;
+ 		i2c->rx_msg = NULL;
+ 		i2c->nmsgs = 0;
+ 	}
+ 
+ 	err = (i2c->atomic_xfer_state == STATE_DONE) ? num : -EIO;
+ 	spin_unlock(&i2c->atomic_lock);
+ 
+ 	i2c->atomic = false;
+ 	xiic_i2c_runtime_suspend(i2c->dev);
+ 
+ 	return err;
+ }
+ 
  static u32 xiic_func(struct i2c_adapter *adap)
  {
  	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;
*************** static u32 xiic_func(struct i2c_adapter
*** 1205,1210 ****
--- 1399,1405 ----
  
  static const struct i2c_algorithm xiic_algorithm = {
  	.master_xfer = xiic_xfer,
+ 	.master_xfer_atomic = xiic_xfer_atomic,
  	.functionality = xiic_func,
  };
  
*************** static int xiic_i2c_probe(struct platfor
*** 1268,1273 ****
--- 1463,1469 ----
  		 DRIVER_NAME " %s", pdev->name);
  
  	mutex_init(&i2c->lock);
+ 	spin_lock_init(&i2c->atomic_lock);
  
  	i2c->clk = devm_clk_get_enabled(&pdev->dev, NULL);
  	if (IS_ERR(i2c->clk))
*************** static void xiic_i2c_remove(struct platf
*** 1365,1393 ****
  	pm_runtime_dont_use_autosuspend(&pdev->dev);
  }
  
- static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 
- 	clk_disable(i2c->clk);
- 
- 	return 0;
- }
- 
- static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
- {
- 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
- 	int ret;
- 
- 	ret = clk_enable(i2c->clk);
- 	if (ret) {
- 		dev_err(dev, "Cannot enable clock.\n");
- 		return ret;
- 	}
- 
- 	return 0;
- }
- 
  static const struct dev_pm_ops xiic_dev_pm_ops = {
  	SET_RUNTIME_PM_OPS(xiic_i2c_runtime_suspend,
  			   xiic_i2c_runtime_resume, NULL)
--- 1561,1566 ----
```

###### drivers/i2c/i2c-atr.c

```console
shell$ diff -p linux-6.12.109/drivers/i2c/i2c-atr.c linux-6.12.113/drivers/i2c/i2c-atr.c
*** linux-6.12.109/drivers/i2c/i2c-atr.c	2026-10-09 15:27:32.010897591 +0900
--- linux-6.12.113/drivers/i2c/i2c-atr.c	2026-10-23 13:59:44.276702422 +0900
*************** int i2c_atr_add_adapter(struct i2c_atr *
*** 632,637 ****
--- 632,638 ----
  
  	ret = i2c_add_adapter(&chan->adap);
  	if (ret) {
+ 		atr->adapter[chan_id] = NULL;
  		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
  			chan_id, ret);
  		goto err_fwnode_put;
```

###### Make 212_drivers-i2c.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/212_drivers-i2c.patch
patching file drivers/i2c/busses/i2c-cadence.c
patching file drivers/i2c/busses/i2c-xiic.c
Hunk #2 succeeded at 79 with fuzz 1 (offset 3 lines).
Hunk #3 succeeded at 105 with fuzz 1 (offset 4 lines).
Hunk #4 succeeded at 236 (offset 4 lines).
Hunk #5 succeeded at 275 with fuzz 2 (offset 27 lines).
Hunk #6 succeeded at 434 (offset 27 lines).
Hunk #7 succeeded at 528 (offset 27 lines).
Hunk #8 succeeded at 619 (offset 35 lines).
Hunk #9 succeeded at 683 (offset 35 lines).
Hunk #10 succeeded at 716 (offset 35 lines).
Hunk #11 succeeded at 741 (offset 35 lines).
Hunk #12 FAILED at 915.
Hunk #13 succeeded at 1073 (offset 45 lines).
Hunk #14 succeeded at 1086 (offset 45 lines).
Hunk #15 succeeded at 1143 (offset 45 lines).
Hunk #16 succeeded at 1214 (offset 45 lines).
Hunk #17 succeeded at 1251 (offset 45 lines).
Hunk #18 succeeded at 1263 (offset 45 lines).
Hunk #19 succeeded at 1291 (offset 45 lines).
Hunk #20 succeeded at 1328 (offset 45 lines).
Hunk #21 succeeded at 1370 (offset 45 lines).
Hunk #22 succeeded at 1415 (offset 45 lines).
Hunk #23 succeeded at 1479 (offset 45 lines).
Hunk #24 FAILED at 1532.
2 out of 24 hunks FAILED -- saving rejects to file drivers/i2c/busses/i2c-xiic.c.rej
patching file drivers/i2c/i2c-atr.c
Hunk #19 FAILED at 847.
Hunk #20 succeeded at 871 (offset 1 line).
Hunk #21 succeeded at 909 (offset 1 line).
1 out of 21 hunks FAILED -- saving rejects to file drivers/i2c/i2c-atr.c.rej
patching file include/linux/i2c-atr.h
```

```console
shell$ rm drivers/i2c/busses/i2c-xiic.c.rej
shell$ rm drivers/i2c/busses/i2c-xiic.c.orig
shell$ cp ../linux-6.12.109-xlnx-v2025.1/drivers/i2c/busses/i2c-xiic.c drivers/i2c/busses/i2c-xiic.c
shell$ patch drivers/i2c/busses/i2c-xiic.c << 'EOT'
--- drivers/i2c/busses/i2c-xiic.c	2026-10-23 15:06:23.523186021 +0900
+++ drivers/i2c/busses/i2c-xiic.c	2026-10-23 15:16:42.788874930 +0900
@@ -74,6 +74,9 @@
  * @prev_msg_tx: Previous message is Tx
  * @quirks: To hold platform specific bug info
  * @smbus_block_read: Flag to handle block read
+ * @smbus_actual_len: Valid byte count (length + payload + optional PEC) of a
+ *	padded SMBus block read. msg->len is trimmed to this on completion.
+ *	Zero when no trimming is needed.
  * @input_clk: Input clock to I2C controller
  * @i2c_clk: I2C SCL frequency
  * @atomic: Mode of transfer
@@ -99,6 +102,7 @@
 	bool prev_msg_tx;
 	u32 quirks;
 	bool smbus_block_read;
+	unsigned int smbus_actual_len;
 	unsigned long input_clk;
 	unsigned int i2c_clk;
 	bool atomic;
@@ -248,7 +252,7 @@
 static int xiic_start_xfer(struct xiic_i2c *i2c, struct i2c_msg *msgs, int num);
 static void __xiic_start_xfer(struct xiic_i2c *i2c);
 
-static int xiic_i2c_runtime_suspend(struct device *dev)
+static int __maybe_unused xiic_i2c_runtime_suspend(struct device *dev)
 {
 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 
@@ -257,7 +261,7 @@
 	return 0;
 }
 
-static int xiic_i2c_runtime_resume(struct device *dev)
+static int __maybe_unused xiic_i2c_runtime_resume(struct device *dev)
 {
 	struct xiic_i2c *i2c = dev_get_drvdata(dev);
 	int ret;
@@ -540,30 +544,38 @@
 
 	/* Check if received length is valid */
 	if (rxmsg_len <= I2C_SMBUS_BLOCK_MAX) {
+		unsigned int pec_len = i2c->rx_msg->len - 1;
+
 		/* Set Receive fifo depth */
-		if (rxmsg_len > IIC_RX_FIFO_DEPTH) {
+		if (rxmsg_len + pec_len > IIC_RX_FIFO_DEPTH) {
 			/*
-			 * When Rx msg len greater than or equal to Rx fifo capacity
-			 * Receive fifo depth should set to Rx fifo capacity minus 1
+			 * Trailing bytes (payload plus any PEC) exceed Rx FIFO
+			 * capacity, so drain in chunks. This also keeps the
+			 * else branch below from pushing rfd_set past the
+			 * 4-bit XIIC_RFD_REG_OFFSET field.
 			 */
 			rfd_set = IIC_RX_FIFO_DEPTH - 1;
-			i2c->rx_msg->len = rxmsg_len + 1;
-		} else if ((rxmsg_len == 1) ||
-			(rxmsg_len == 0)) {
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
+		} else if (1 + rxmsg_len + pec_len < SMBUS_BLOCK_READ_MIN_LEN) {
 			/*
-			 * Minimum of 3 bytes required to exit cleanly. 1 byte
-			 * already received, Second byte is being received. Have
-			 * to set NACK in read_rx before receiving the last byte
+			 * The HW needs SMBUS_BLOCK_READ_MIN_LEN bytes on the
+			 * bus to exit cleanly: by the time the ISR reads the
+			 * length byte the second byte is already being clocked
+			 * in, too late to NACK. Pad the drain target and record
+			 * the real length, trimmed back on completion so the
+			 * PEC check sees the right byte.
 			 */
 			rfd_set = 0;
 			i2c->rx_msg->len = SMBUS_BLOCK_READ_MIN_LEN;
+			i2c->smbus_actual_len = 1 + rxmsg_len + pec_len;
 		} else {
 			/*
-			 * When Rx msg len less than Rx fifo capacity
-			 * Receive fifo depth should set to Rx msg len minus 2
+			 * All trailing bytes fit in the Rx FIFO. The widened
+			 * condition above guarantees rxmsg_len + pec_len >= 2,
+			 * so this cannot underflow.
 			 */
-			rfd_set = rxmsg_len - 2;
-			i2c->rx_msg->len = rxmsg_len + 1;
+			rfd_set = rxmsg_len + pec_len - 2;
+			i2c->rx_msg->len = rxmsg_len + 1 + pec_len;
 		}
 		xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rfd_set);
 
@@ -798,6 +810,10 @@
 
 		xiic_read_rx(i2c);
 		if (xiic_rx_space(i2c) == 0) {
+			/* Undo padding so the PEC check sees the right byte. */
+			if (i2c->smbus_actual_len)
+				i2c->rx_msg->len = i2c->smbus_actual_len;
+
 			/* this is the last part of the message */
 			i2c->rx_msg = NULL;
 
@@ -866,8 +882,11 @@
 
 		if (i2c->tx_msg && i2c->smbus_block_read) {
 			i2c->smbus_block_read = false;
-			/* Set requested message len=1 to indicate STATE_DONE */
-			i2c->tx_msg->len = 1;
+			/*
+			 * Drive xiic_tx_space() to 0 to signal STATE_DONE
+			 * without truncating the rx_msg length.
+			 */
+			i2c->tx_pos = i2c->tx_msg->len;
 		}
 
 		if (!i2c->tx_msg)
@@ -956,6 +975,9 @@
 	u8 cr = 0, rfd_set = 0;
 	struct i2c_msg *msg = i2c->rx_msg = i2c->tx_msg;
 
+	/* A stale value from an aborted block read would truncate this msg. */
+	i2c->smbus_actual_len = 0;
+
 	if (!i2c->atomic)
 		dev_dbg(i2c->adap.dev.parent, "%s entry, ISR: 0x%x, CR: 0x%x\n",
 			__func__, xiic_getreg32(i2c, XIIC_IISR_OFFSET),
EOT
```

```console
shell$ rm drivers/i2c/i2c-atr.c.rej
shell$ rm drivers/i2c/i2c-atr.c.orig
shell$ cp ../linux-6.12.109-xlnx-v2025.1/drivers/i2c/i2c-atr.c drivers/i2c/i2c-atr.c
shell$ patch drivers/i2c/i2c-atr.c << 'EOT'
--- drivers/i2c/i2c-atr.c
+++ drivers/i2c/i2c-atr.c
@@ -864,6 +864,7 @@
 
 	ret = i2c_add_adapter(&chan->adap);
 	if (ret) {
+		atr->adapter[chan_id] = NULL;
 		dev_err(dev, "failed to add atr-adapter %u (error=%d)\n",
 			chan_id, ret);
 		goto err_free_alias_pool;
EOT
```

```console
shell$ git add --all
shell$ git commit -m '[patch] 212_drivers-i2c.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/212_drivers-i2c.patch
```

##### 214_drivers-iio.patch

###### drivers/iio/adc/Kconfig

```console
shell$ diff -p linux-6.12.109/drivers/iio/adc/Kconfig linux-6.12.113/drivers/iio/adc/Kconfig
*** linux-6.12.109/drivers/iio/adc/Kconfig	2026-10-09 15:27:32.018898526 +0900
--- linux-6.12.113/drivers/iio/adc/Kconfig	2026-10-23 13:59:44.284824122 +0900
*************** config MAX1363
*** 841,846 ****
--- 841,847 ----
  config MAX34408
  	tristate "Maxim max34408/max344089 ADC driver"
  	depends on I2C
+ 	select REGMAP_I2C
  	help
  	  Say yes here to build support for Maxim max34408/max34409 current sense
  	  monitor with 8-bits ADC interface with overcurrent delay/threshold and
```

###### Make 214_drivers-iio.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/214_drivers-iio.patch
patching file Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml
patching file drivers/iio/adc/Kconfig
Hunk #2 succeeded at 1662 (offset 1 line).
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
shell$ rm drivers/iio/adc/Kconfig.orig
shell$ git add --all
shell$ git commit -m '[patch] 214_drivers-iio.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/214_drivers-iio.patch
```

##### 225_drivers-mfd.patch

###### drivers/mfd/rsmu_i2c.c

```console
shell$ diff -p linux-6.12.109/drivers/mfd/rsmu_i2c.c linux-6.12.113/drivers/mfd/rsmu_i2c.c
*** linux-6.12.109/drivers/mfd/rsmu_i2c.c	2026-10-09 15:27:32.358938301 +0900
--- linux-6.12.113/drivers/mfd/rsmu_i2c.c	2026-10-23 13:59:44.658422442 +0900
*************** static void rsmu_i2c_remove(struct i2c_c
*** 330,335 ****
--- 330,336 ----
  static const struct i2c_device_id rsmu_i2c_id[] = {
  	{ "8a34000",  RSMU_CM },
  	{ "8a34001",  RSMU_CM },
+ 	{ "8a34002",  RSMU_CM },
  	{ "82p33810", RSMU_SABRE },
  	{ "82p33811", RSMU_SABRE },
  	{ "8v19n850", RSMU_SL },
*************** MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
*** 341,346 ****
--- 342,348 ----
  static const struct of_device_id rsmu_i2c_of_match[] = {
  	{ .compatible = "idt,8a34000",  .data = (void *)RSMU_CM },
  	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
+ 	{ .compatible = "idt,8a34002",  .data = (void *)RSMU_CM },
  	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
  	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
  	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
```

###### Make 225_drivers-mfd.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/225_drivers-mfd.patch
patching file Documentation/devicetree/bindings/mfd/syscon.yaml
patching file drivers/mfd/rsmu_core.c
patching file drivers/mfd/rsmu_i2c.c
Hunk #3 succeeded at 333 with fuzz 1 (offset 1 line).
Hunk #4 succeeded at 345 with fuzz 1 (offset 2 lines).
patching file include/linux/mfd/idt82p33_reg.h
patching file include/linux/mfd/idt8a340_reg.h
patching file include/linux/mfd/rsmu.h
patching file include/linux/mfd/syscon/xlnx-vcu.h
```

```console
shell$ rm drivers/mfd/rsmu_i2c.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 225_drivers-mfd.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/225_drivers-mfd.patch
```

##### 230_drivers-net-ethernet.patch

###### drivers/net/ethernet/cadence/macb_main.c

```console
shell$ diff -p linux-6.12.109/drivers/net/ethernet/cadence/macb_main.c linux-6.12.113/drivers/net/ethernet/cadence/macb_main.c
*** linux-6.12.109/drivers/net/ethernet/cadence/macb_main.c	2026-10-09 15:27:32.494954211 +0900
--- linux-6.12.113/drivers/net/ethernet/cadence/macb_main.c	2026-10-23 13:59:44.788369682 +0900
*************** static irqreturn_t macb_interrupt(int ir
*** 2020,2029 ****
  			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
  				queue_writel(queue, ISR, MACB_BIT(RCOMP));
  
! 			if (napi_schedule_prep(&queue->napi_rx)) {
! 				netdev_vdbg(bp->dev, "scheduling RX softirq\n");
! 				__napi_schedule(&queue->napi_rx);
! 			}
  		}
  
  		if (status & (MACB_BIT(TCOMP) |
--- 2020,2026 ----
  			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
  				queue_writel(queue, ISR, MACB_BIT(RCOMP));
  
! 			napi_schedule(&queue->napi_rx);
  		}
  
  		if (status & (MACB_BIT(TCOMP) |
*************** static irqreturn_t macb_interrupt(int ir
*** 2038,2047 ****
  				wmb(); // ensure softirq can see update
  			}
  
! 			if (napi_schedule_prep(&queue->napi_tx)) {
! 				netdev_vdbg(bp->dev, "scheduling TX softirq\n");
! 				__napi_schedule(&queue->napi_tx);
! 			}
  		}
  
  		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
--- 2035,2041 ----
  				wmb(); // ensure softirq can see update
  			}
  
! 			napi_schedule(&queue->napi_tx);
  		}
  
  		if (unlikely(status & (MACB_TX_ERR_FLAGS))) {
*************** static int macb_open(struct net_device *
*** 3107,3113 ****
  
  	macb_init_hw(bp);
  
! 	err = phy_power_on(bp->sgmii_phy);
  	if (err)
  		goto reset_hw;
  
--- 3101,3107 ----
  
  	macb_init_hw(bp);
  
! 	err = phy_power_on(bp->phy);
  	if (err)
  		goto reset_hw;
  
*************** static int macb_open(struct net_device *
*** 3123,3129 ****
  	return 0;
  
  phy_off:
! 	phy_power_off(bp->sgmii_phy);
  
  reset_hw:
  	macb_reset_hw(bp);
--- 3117,3123 ----
  	return 0;
  
  phy_off:
! 	phy_power_off(bp->phy);
  
  reset_hw:
  	macb_reset_hw(bp);
*************** static int macb_close(struct net_device
*** 3154,3160 ****
  	phylink_stop(bp->phylink);
  	phylink_disconnect_phy(bp->phylink);
  
! 	phy_power_off(bp->sgmii_phy);
  
  	spin_lock_irqsave(&bp->lock, flags);
  	macb_reset_hw(bp);
--- 3148,3154 ----
  	phylink_stop(bp->phylink);
  	phylink_disconnect_phy(bp->phylink);
  
! 	phy_power_off(bp->phy);
  
  	spin_lock_irqsave(&bp->lock, flags);
  	macb_reset_hw(bp);
*************** static int macb_init(struct platform_dev
*** 4246,4252 ****
  		queue->bp = bp;
  		spin_lock_init(&queue->tx_ptr_lock);
  		netif_napi_add(dev, &queue->napi_rx, macb_rx_poll);
! 		netif_napi_add(dev, &queue->napi_tx, macb_tx_poll);
  		if (hw_q) {
  			queue->ISR  = GEM_ISR(hw_q - 1);
  			queue->IER  = GEM_IER(hw_q - 1);
--- 4240,4246 ----
  		queue->bp = bp;
  		spin_lock_init(&queue->tx_ptr_lock);
  		netif_napi_add(dev, &queue->napi_rx, macb_rx_poll);
! 		netif_napi_add_tx(dev, &queue->napi_tx, macb_tx_poll);
  		if (hw_q) {
  			queue->ISR  = GEM_ISR(hw_q - 1);
  			queue->IER  = GEM_IER(hw_q - 1);
*************** static int init_reset_optional(struct pl
*** 4881,4893 ****
  
  	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
  		/* Ensure PHY device used in SGMII mode is ready */
! 		bp->sgmii_phy = devm_phy_optional_get(&pdev->dev, NULL);
  
! 		if (IS_ERR(bp->sgmii_phy))
! 			return dev_err_probe(&pdev->dev, PTR_ERR(bp->sgmii_phy),
  					     "failed to get SGMII PHY\n");
  
! 		ret = phy_init(bp->sgmii_phy);
  		if (ret)
  			return dev_err_probe(&pdev->dev, ret,
  					     "failed to init SGMII PHY\n");
--- 4875,4887 ----
  
  	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
  		/* Ensure PHY device used in SGMII mode is ready */
! 		bp->phy = devm_phy_optional_get(&pdev->dev, NULL);
  
! 		if (IS_ERR(bp->phy))
! 			return dev_err_probe(&pdev->dev, PTR_ERR(bp->phy),
  					     "failed to get SGMII PHY\n");
  
! 		ret = phy_init(bp->phy);
  		if (ret)
  			return dev_err_probe(&pdev->dev, ret,
  					     "failed to init SGMII PHY\n");
*************** static int init_reset_optional(struct pl
*** 4916,4922 ****
  	/* Fully reset controller at hardware level if mapped in device tree */
  	ret = device_reset_optional(&pdev->dev);
  	if (ret) {
! 		phy_exit(bp->sgmii_phy);
  		return dev_err_probe(&pdev->dev, ret, "failed to reset controller");
  	}
  
--- 4910,4916 ----
  	/* Fully reset controller at hardware level if mapped in device tree */
  	ret = device_reset_optional(&pdev->dev);
  	if (ret) {
! 		phy_exit(bp->phy);
  		return dev_err_probe(&pdev->dev, ret, "failed to reset controller");
  	}
  
*************** static int init_reset_optional(struct pl
*** 4924,4930 ****
  
  err_out_phy_exit:
  	if (ret)
! 		phy_exit(bp->sgmii_phy);
  
  	return ret;
  }
--- 4918,4924 ----
  
  err_out_phy_exit:
  	if (ret)
! 		phy_exit(bp->phy);
  
  	return ret;
  }
*************** static int macb_probe(struct platform_de
*** 5233,5238 ****
--- 5227,5233 ----
  	}
  	spin_lock_init(&bp->lock);
  	spin_lock_init(&bp->stats_lock);
+ 	spin_lock_init(&bp->tsu_clk_lock);
  
  	/* setup capabilities */
  	macb_configure_caps(bp, macb_config);
*************** static int macb_probe(struct platform_de
*** 5320,5330 ****
  	return 0;
  
  err_out_unregister_mdio:
! 	mdiobus_unregister(bp->mii_bus);
! 	mdiobus_free(bp->mii_bus);
  
  err_out_phy_exit:
! 	phy_exit(bp->sgmii_phy);
  
  err_out_free_netdev:
  	free_netdev(dev);
--- 5315,5328 ----
  	return 0;
  
  err_out_unregister_mdio:
! 	if (bp->mii_bus) {
! 		mdiobus_unregister(bp->mii_bus);
! 		mdiobus_free(bp->mii_bus);
! 	}
! 	phylink_destroy(bp->phylink);
  
  err_out_phy_exit:
! 	phy_exit(bp->phy);
  
  err_out_free_netdev:
  	free_netdev(dev);
*************** static void macb_remove(struct platform_
*** 5348,5356 ****
  	if (dev) {
  		bp = netdev_priv(dev);
  		unregister_netdev(dev);
! 		phy_exit(bp->sgmii_phy);
! 		mdiobus_unregister(bp->mii_bus);
! 		mdiobus_free(bp->mii_bus);
  
  		device_set_wakeup_enable(&bp->pdev->dev, 0);
  		cancel_work_sync(&bp->hresp_err_bh_work);
--- 5346,5356 ----
  	if (dev) {
  		bp = netdev_priv(dev);
  		unregister_netdev(dev);
! 		phy_exit(bp->phy);
! 		if (bp->mii_bus) {
! 			mdiobus_unregister(bp->mii_bus);
! 			mdiobus_free(bp->mii_bus);
! 		}
  
  		device_set_wakeup_enable(&bp->pdev->dev, 0);
  		cancel_work_sync(&bp->hresp_err_bh_work);
*************** static int __maybe_unused macb_suspend(s
*** 5375,5381 ****
  	int err;
  
  	if (!device_may_wakeup(&bp->dev->dev))
! 		phy_exit(bp->sgmii_phy);
  
  	if (!netif_running(netdev))
  		return 0;
--- 5375,5381 ----
  	int err;
  
  	if (!device_may_wakeup(&bp->dev->dev))
! 		phy_exit(bp->phy);
  
  	if (!netif_running(netdev))
  		return 0;
*************** static int __maybe_unused macb_resume(st
*** 5512,5518 ****
  	int err;
  
  	if (!device_may_wakeup(&bp->dev->dev))
! 		phy_init(bp->sgmii_phy);
  
  	if (!netif_running(netdev))
  		return 0;
--- 5512,5518 ----
  	int err;
  
  	if (!device_may_wakeup(&bp->dev->dev))
! 		phy_init(bp->phy);
  
  	if (!netif_running(netdev))
  		return 0;
```

###### Make 230_drivers-net-ethernet.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
Hunk #14 succeeded at 5145 (offset -6 lines).
Hunk #15 succeeded at 5178 (offset -6 lines).
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
shell$ rm drivers/net/ethernet/cadence/macb_main.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 230_drivers-net-ethernet.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/230_drivers-net-ethernet.patch
```

##### 231_drivers-net-phy.patch

###### drivers/net/phy/Kconfig

```console
shell$ diff -p linux-6.12.109/drivers/net/phy/Kconfig linux-6.12.113/drivers/net/phy/Kconfig
*** linux-6.12.109/drivers/net/phy/Kconfig	2026-10-09 15:27:32.722980884 +0900
--- linux-6.12.113/drivers/net/phy/Kconfig	2026-10-23 13:59:45.064507570 +0900
*************** config MAXLINEAR_GPHY
*** 266,287 ****
  	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
  	  GPY241, GPY245 PHYs.
  
! config MEDIATEK_GE_PHY
! 	tristate "MediaTek Gigabit Ethernet PHYs"
! 	help
! 	  Supports the MediaTek Gigabit Ethernet PHYs.
! 
! config MEDIATEK_GE_SOC_PHY
! 	tristate "MediaTek SoC Ethernet PHYs"
! 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
! 	depends on NVMEM_MTK_EFUSE
! 	help
! 	  Supports MediaTek SoC built-in Gigabit Ethernet PHYs.
! 
! 	  Include support for built-in Ethernet PHYs which are present in
! 	  the MT7981 and MT7988 SoCs. These PHYs need calibration data
! 	  present in the SoCs efuse and will dynamically calibrate VCM
! 	  (common-mode voltage) during startup.
  
  config MICREL_PHY
  	tristate "Micrel PHYs"
--- 266,272 ----
  	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
  	  GPY241, GPY245 PHYs.
  
! source "drivers/net/phy/mediatek/Kconfig"
  
  config MICREL_PHY
  	tristate "Micrel PHYs"
```

```console
shell$ diff -p linux-6.12.109/drivers/net/phy/Kconfig linux-6.12.109-xlnx-v2025.1/drivers/net/phy/Kconfig
*** linux-6.12.109/drivers/net/phy/Kconfig	2026-10-09 15:27:32.722980884 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/net/phy/Kconfig	2026-10-22 11:50:20.208868039 +0900
*************** config VITESSE_PHY
*** 441,446 ****
--- 441,454 ----
  	help
  	  Currently supports the vsc8244
  
+ config XILINX_PHY
+ 	tristate "Drivers for xilinx PHYs"
+ 	help
+ 	  This module provides a driver for the Xilinx PCS/PMA Core.
+ 	  The supported PHY modes include SGMII and 1000BaseX.
+ 	  This can be used an Ethernet controller, for example Xilinx
+ 	  Axi Ethernet or Cadence GEM in Xilinx devices.
+ 
  config XILINX_GMII2RGMII
  	tristate "Xilinx GMII2RGMII converter driver"
  	help
```

###### drivers/net/phy/Makefile

```console
shell$ diff -p linux-6.12.109/drivers/net/phy/Makefile linux-6.12.113/drivers/net/phy/Makefile
*** linux-6.12.109/drivers/net/phy/Makefile	2026-10-09 15:27:32.722980884 +0900
--- linux-6.12.113/drivers/net/phy/Makefile	2026-10-23 13:59:45.064507570 +0900
*************** obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
*** 74,81 ****
  obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
  obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
  obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
! obj-$(CONFIG_MEDIATEK_GE_PHY)	+= mediatek-ge.o
! obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mediatek-ge-soc.o
  obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
  obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
  obj-$(CONFIG_MICREL_PHY)	+= micrel.o
--- 74,80 ----
  obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
  obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
  obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
! obj-y				+= mediatek/
  obj-$(CONFIG_MESON_GXL_PHY)	+= meson-gxl.o
  obj-$(CONFIG_MICREL_KS8995MA)	+= spi_ks8995.o
  obj-$(CONFIG_MICREL_PHY)	+= micrel.o
```

```console
shell$ diff -p linux-6.12.109/drivers/net/phy/Makefile linux-6.12.109-xlnx-v2025.1/drivers/net/phy/Makefile
*** linux-6.12.109/drivers/net/phy/Makefile	2026-10-09 15:27:32.722980884 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/net/phy/Makefile	2026-10-11 09:39:47.280271585 +0900
*************** obj-$(CONFIG_SMSC_PHY)		+= smsc.o
*** 102,105 ****
--- 102,106 ----
  obj-$(CONFIG_STE10XP)		+= ste10Xp.o
  obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
  obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
+ obj-$(CONFIG_XILINX_PHY)	+= xilinx_phy.o
  obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
```

###### Make 231_drivers-net-phy.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/231_drivers-net-phy.patch
patching file Documentation/devicetree/bindings/net/xilinx-phy.txt
patching file drivers/net/phy/Kconfig
Hunk #1 succeeded at 426 (offset -15 lines).
patching file drivers/net/phy/Makefile
Hunk #1 succeeded at 101 (offset -1 lines).
patching file drivers/net/phy/phy-core.c
patching file drivers/net/phy/phylink.c
patching file drivers/net/phy/xilinx_phy.c
patching file include/linux/phy.h
patching file include/linux/xilinx_phy.h
```

```console
shell$ rm drivers/net/phy/Kconfig.orig
shell$ rm drivers/net/phy/Makefile.orig
shell$ git add --all
shell$ git commit -m '[patch] 231_drivers-net-phy.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/231_drivers-net-phy.patch
```

##### 235_drivers-of.patch

###### drivers/of/overlay.c

```console
shell$ diff -p linux-6.12.109/drivers/of/overlay.c linux-6.12.113/drivers/of/overlay.c
*** linux-6.12.109/drivers/of/overlay.c	2026-10-09 15:27:32.931005218 +0900
--- linux-6.12.113/drivers/of/overlay.c	2026-10-23 13:59:45.304097793 +0900
*************** static int overlay_notify(struct overlay
*** 179,184 ****
--- 179,193 ----
  	return 0;
  }
  
+ static void overlay_fw_devlink_refresh(struct overlay_changeset *ovcs)
+ {
+ 	for (int i = 0; i < ovcs->count; i++) {
+ 		struct device_node *np = ovcs->fragments[i].target;
+ 
+ 		fw_devlink_refresh_fwnode(of_fwnode_handle(np));
+ 	}
+ }
+ 
  /*
   * The values of properties in the "/__symbols__" node are paths in
   * the ovcs->overlay_root.  When duplicating the properties, the paths
*************** static struct property *dup_and_fixup_sy
*** 241,246 ****
--- 250,258 ----
  	if (!target_path)
  		return NULL;
  	target_path_len = strlen(target_path);
+ 	/* a root target renders as "/"; drop it to avoid "//" results */
+ 	if (target_path_len == 1 && target_path[0] == '/' && path_tail_len)
+ 		target_path_len = 0;
  
  	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
  	if (!new_prop)
*************** static int add_changeset_property(struct
*** 344,355 ****
  		return -ENOMEM;
  
  	if (!prop) {
! 		if (!target->in_livetree) {
  			new_prop->next = target->np->deadprops;
  			target->np->deadprops = new_prop;
  		}
- 		ret = of_changeset_add_property(&ovcs->cset, target->np,
- 						new_prop);
  	} else {
  		ret = of_changeset_update_property(&ovcs->cset, target->np,
  						   new_prop);
--- 356,368 ----
  		return -ENOMEM;
  
  	if (!prop) {
! 		ret = of_changeset_add_property(&ovcs->cset, target->np,
! 						new_prop);
! 		/* the detached node owns the property until the apply */
! 		if (!ret && !target->in_livetree) {
  			new_prop->next = target->np->deadprops;
  			target->np->deadprops = new_prop;
  		}
  	} else {
  		ret = of_changeset_update_property(&ovcs->cset, target->np,
  						   new_prop);
*************** static int init_overlay_changeset(struct
*** 839,844 ****
--- 852,861 ----
  err_out:
  	pr_err("%s() failed, ret = %d\n", __func__, ret);
  
+ 	/* let free_overlay_changeset() put the fragments set up so far */
+ 	if (ovcs->fragments)
+ 		ovcs->count = cnt;
+ 
  	return ret;
  }
  
*************** static void free_overlay_changeset(struc
*** 849,855 ****
  	if (ovcs->cset.entries.next)
  		of_changeset_destroy(&ovcs->cset);
  
! 	if (ovcs->id) {
  		idr_remove(&ovcs_idr, ovcs->id);
  		list_del(&ovcs->ovcs_list);
  		ovcs->id = 0;
--- 866,873 ----
  	if (ovcs->cset.entries.next)
  		of_changeset_destroy(&ovcs->cset);
  
! 	/* a failed idr_alloc() leaves its negative error in ovcs->id */
! 	if (ovcs->id > 0) {
  		idr_remove(&ovcs_idr, ovcs->id);
  		list_del(&ovcs->ovcs_list);
  		ovcs->id = 0;
*************** static int of_overlay_apply(struct overl
*** 946,951 ****
--- 964,975 ----
  		pr_err("overlay apply changeset entry notify error %d\n", ret);
  	/* notify failure is not fatal, continue */
  
+ 	/*
+ 	 * Needs to happen after changeset notify to give the listeners a chance
+ 	 * to finish creating all the devices they need to create.
+ 	 */
+ 	overlay_fw_devlink_refresh(ovcs);
+ 
  	ret_tmp = overlay_notify(ovcs, OF_OVERLAY_POST_APPLY);
  	if (ret_tmp)
  		if (!ret)
```

```console
shell$ diff -p linux-6.12.109/drivers/of/overlay.c linux-6.12.109-xlnx-v2025.1/drivers/of/overlay.c
*** linux-6.12.109/drivers/of/overlay.c	2026-10-09 15:27:32.931005218 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/of/overlay.c	2026-10-22 11:50:20.759859096 +0900
*************** out_unlock:
*** 1069,1074 ****
--- 1069,1075 ----
  }
  EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
  
+ #ifndef CONFIG_OF_FPGA_REGION
  /*
   * Find @np in @tree.
   *
*************** static int overlay_removal_is_ok(struct
*** 1145,1150 ****
--- 1146,1152 ----
  
  	return 1;
  }
+ #endif
  
  /**
   * of_overlay_remove() - Revert and free an overlay changeset
*************** int of_overlay_remove(int *ovcs_id)
*** 1200,1209 ****
--- 1202,1213 ----
  		goto err_unlock;
  	}
  
+ #ifndef CONFIG_OF_FPGA_REGION
  	if (!overlay_removal_is_ok(ovcs)) {
  		ret = -EBUSY;
  		goto err_unlock;
  	}
+ #endif
  
  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_REMOVE);
  	if (ret)
```

###### Make 235_drivers-of.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/235_drivers-of.patch
patching file Documentation/devicetree/configfs-overlays.txt
patching file drivers/of/Kconfig
patching file drivers/of/Makefile
patching file drivers/of/configfs.c
patching file drivers/of/overlay.c
Hunk #1 succeeded at 1093 (offset 24 lines).
Hunk #2 succeeded at 1170 (offset 24 lines).
Hunk #3 succeeded at 1226 (offset 24 lines).
```

```console
shell$ rm drivers/of/overlay.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 235_drivers-of.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/235_drivers-of.patch
```

##### 247_drivers-spi.patch

###### drivers/spi/spi-xilinx.c

```console
shell$ diff -p linux-6.12.109/drivers/spi/spi-xilinx.c linux-6.12.113/drivers/spi/spi-xilinx.c
*** linux-6.12.109/drivers/spi/spi-xilinx.c	2026-10-09 15:27:33.231037366 +0900
--- linux-6.12.113/drivers/spi/spi-xilinx.c	2026-10-23 13:59:45.888860377 +0900
*************** static int xilinx_spi_txrx_bufs(struct s
*** 284,290 ****
  
  		if (use_irq) {
  			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
! 			wait_for_completion(&xspi->done);
  			/* A transmit has just completed. Process received data
  			 * and check for more data to transmit. Always inhibit
  			 * the transmitter while the Isr refills the transmit
--- 284,294 ----
  
  		if (use_irq) {
  			xspi->write_fn(cr, xspi->regs + XSPI_CR_OFFSET);
! 			if (!wait_for_completion_timeout(&xspi->done, secs_to_jiffies(1))) {
! 				dev_err(&spi->dev, "SPI transfer timed out\n");
! 				xspi_init_hw(xspi);
! 				return -ETIMEDOUT;
! 			}
  			/* A transmit has just completed. Process received data
  			 * and check for more data to transmit. Always inhibit
  			 * the transmitter while the Isr refills the transmit
```

###### drivers/spi/spi.c

```console
shell$ diff -p linux-6.12.109/drivers/spi/spi.c linux-6.12.113/drivers/spi/spi.c
*** linux-6.12.109/drivers/spi/spi.c	2026-10-09 15:27:33.231037366 +0900
--- linux-6.12.113/drivers/spi/spi.c	2026-10-23 13:59:45.892921229 +0900
*************** EXPORT_SYMBOL_GPL(spi_get_device_id);
*** 357,368 ****
  const void *spi_get_device_match_data(const struct spi_device *sdev)
  {
  	const void *match;
  
  	match = device_get_match_data(&sdev->dev);
  	if (match)
  		return match;
  
! 	return (const void *)spi_get_device_id(sdev)->driver_data;
  }
  EXPORT_SYMBOL_GPL(spi_get_device_match_data);
  
--- 357,372 ----
  const void *spi_get_device_match_data(const struct spi_device *sdev)
  {
  	const void *match;
+ 	const struct spi_device_id *id;
  
  	match = device_get_match_data(&sdev->dev);
  	if (match)
  		return match;
  
! 	id = spi_get_device_id(sdev);
! 	if (!id)
! 		return NULL;
! 	return (const void *)id->driver_data;
  }
  EXPORT_SYMBOL_GPL(spi_get_device_match_data);
  
*************** void spi_unmap_buf(struct spi_controller
*** 1229,1234 ****
--- 1233,1240 ----
  	spi_unmap_buf_attrs(ctlr, dev, sgt, dir, 0);
  }
  
+ static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg);
+ 
  static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
  {
  	struct device *tx_dev, *rx_dev;
*************** static int __spi_map_msg(struct spi_cont
*** 1252,1258 ****
  	else
  		rx_dev = ctlr->dev.parent;
  
! 	ret = -ENOMSG;
  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
  		/* The sync is done before each transfer. */
  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
--- 1258,1270 ----
  	else
  		rx_dev = ctlr->dev.parent;
  
! 	/*
! 	 * Store the devices before mapping so partial failures can be unwound
! 	 * with the device that created each mapping.
! 	 */
! 	ctlr->cur_tx_dma_dev = tx_dev;
! 	ctlr->cur_rx_dma_dev = rx_dev;
! 
  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
  		/* The sync is done before each transfer. */
  		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
*************** static int __spi_map_msg(struct spi_cont
*** 1265,1272 ****
  						(void *)xfer->tx_buf,
  						xfer->len, DMA_TO_DEVICE,
  						attrs);
! 			if (ret != 0)
! 				return ret;
  
  			xfer->tx_sg_mapped = true;
  		}
--- 1277,1284 ----
  						(void *)xfer->tx_buf,
  						xfer->len, DMA_TO_DEVICE,
  						attrs);
! 			if (ret)
! 				goto unwind;
  
  			xfer->tx_sg_mapped = true;
  		}
*************** static int __spi_map_msg(struct spi_cont
*** 1275,1299 ****
  			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
  						xfer->rx_buf, xfer->len,
  						DMA_FROM_DEVICE, attrs);
! 			if (ret != 0) {
! 				spi_unmap_buf_attrs(ctlr, tx_dev,
! 						&xfer->tx_sg, DMA_TO_DEVICE,
! 						attrs);
! 
! 				return ret;
! 			}
  
  			xfer->rx_sg_mapped = true;
  		}
  	}
- 	/* No transfer has been mapped, bail out with success */
- 	if (ret)
- 		return 0;
- 
- 	ctlr->cur_rx_dma_dev = rx_dev;
- 	ctlr->cur_tx_dma_dev = tx_dev;
  
  	return 0;
  }
  
  static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
--- 1287,1305 ----
  			ret = spi_map_buf_attrs(ctlr, rx_dev, &xfer->rx_sg,
  						xfer->rx_buf, xfer->len,
  						DMA_FROM_DEVICE, attrs);
! 			if (ret)
! 				goto unwind;
  
  			xfer->rx_sg_mapped = true;
  		}
  	}
  
  	return 0;
+ 
+ unwind:
+ 	__spi_unmap_msg(ctlr, msg);
+ 
+ 	return ret;
  }
  
  static int __spi_unmap_msg(struct spi_controller *ctlr, struct spi_message *msg)
*************** int spi_controller_suspend(struct spi_co
*** 3521,3526 ****
--- 3527,3535 ----
  {
  	int ret = 0;
  
+ 	if (ctlr->cur_msg && spi_controller_is_target(ctlr) && ctlr->target_abort)
+ 		ctlr->target_abort(ctlr);
+ 
  	/* Basically no-ops for non-queued controllers */
  	if (ctlr->queued) {
  		ret = spi_stop_queue(ctlr);
```

###### Make 247_drivers-spi.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
Hunk #7 FAILED at 352.
Hunk #8 succeeded at 594 (offset 4 lines).
1 out of 8 hunks FAILED -- saving rejects to file drivers/spi/spi-xilinx.c.rej
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
Hunk #1 succeeded at 2490 (offset 6 lines).
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
```

```console
shell$ rm drivers/spi/spi-xilinx.c.rej
shell$ rm drivers/spi/spi-xilinx.c.orig
shell$ cp ../linux-6.12.109-xlnx-v2025.1/drivers/spi/spi-xilinx.c drivers/spi/spi-xilinx.c
shell$ rm drivers/spi/spi.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 247_drivers-spi.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/247_drivers-spi.patch
```

##### 251_drivers-ufs.patch

###### drivers/ufs/core/ufshcd.c

```console
shell$ diff -p linux-6.12.109/drivers/ufs/core/ufshcd.c linux-6.12.113/drivers/ufs/core/ufshcd.c
*** linux-6.12.109/drivers/ufs/core/ufshcd.c	2026-10-09 15:27:33.327047350 +0900
--- linux-6.12.113/drivers/ufs/core/ufshcd.c	2026-10-23 13:59:45.856702657 +0900
*************** static bool ufshcd_is_devfreq_scaling_re
*** 1264,1274 ****
  static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
  {
  	const struct scsi_device *sdev;
  	u32 pending = 0;
  
! 	lockdep_assert_held(hba->host->host_lock);
  	__shost_for_each_device(sdev, hba->host)
  		pending += sbitmap_weight(&sdev->budget_map);
  
  	return pending;
  }
--- 1264,1276 ----
  static u32 ufshcd_pending_cmds(struct ufs_hba *hba)
  {
  	const struct scsi_device *sdev;
+ 	unsigned long flags;
  	u32 pending = 0;
  
! 	spin_lock_irqsave(hba->host->host_lock, flags);
  	__shost_for_each_device(sdev, hba->host)
  		pending += sbitmap_weight(&sdev->budget_map);
+ 	spin_unlock_irqrestore(hba->host->host_lock, flags);
  
  	return pending;
  }
*************** static u32 ufshcd_pending_cmds(struct uf
*** 1282,1288 ****
  static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
  					u64 wait_timeout_us)
  {
- 	unsigned long flags;
  	int ret = 0;
  	u32 tm_doorbell;
  	u32 tr_pending;
--- 1284,1289 ----
*************** static int ufshcd_wait_for_doorbell_clr(
*** 1290,1296 ****
  	ktime_t start;
  
  	ufshcd_hold(hba);
- 	spin_lock_irqsave(hba->host->host_lock, flags);
  	/*
  	 * Wait for all the outstanding tasks/transfer requests.
  	 * Verify by checking the doorbell registers are clear.
--- 1291,1296 ----
*************** static int ufshcd_wait_for_doorbell_clr(
*** 1311,1317 ****
  			break;
  		}
  
! 		spin_unlock_irqrestore(hba->host->host_lock, flags);
  		io_schedule_timeout(msecs_to_jiffies(20));
  		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
  		    wait_timeout_us) {
--- 1311,1317 ----
  			break;
  		}
  
! 		__set_current_state(TASK_UNINTERRUPTIBLE);
  		io_schedule_timeout(msecs_to_jiffies(20));
  		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
  		    wait_timeout_us) {
*************** static int ufshcd_wait_for_doorbell_clr(
*** 1323,1329 ****
  			 */
  			do_last_check = true;
  		}
- 		spin_lock_irqsave(hba->host->host_lock, flags);
  	} while (tm_doorbell || tr_pending);
  
  	if (timeout) {
--- 1323,1328 ----
*************** static int ufshcd_wait_for_doorbell_clr(
*** 1333,1339 ****
  		ret = -EBUSY;
  	}
  out:
- 	spin_unlock_irqrestore(hba->host->host_lock, flags);
  	ufshcd_release(hba);
  	return ret;
  }
--- 1332,1337 ----
*************** static int __ufshcd_issue_tm_cmd(struct
*** 7127,7138 ****
  	memcpy(hba->utmrdl_base_addr + task_tag, treq, sizeof(*treq));
  	ufshcd_vops_setup_task_mgmt(hba, task_tag, tm_function);
  
- 	/* send command to the controller */
  	__set_bit(task_tag, &hba->outstanding_tasks);
- 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
  
  	spin_unlock_irqrestore(host->host_lock, flags);
  
  	ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_SEND);
  
  	/* wait until the task management command is completed */
--- 7125,7137 ----
  	memcpy(hba->utmrdl_base_addr + task_tag, treq, sizeof(*treq));
  	ufshcd_vops_setup_task_mgmt(hba, task_tag, tm_function);
  
  	__set_bit(task_tag, &hba->outstanding_tasks);
  
  	spin_unlock_irqrestore(host->host_lock, flags);
  
+ 	/* send command to the controller */
+ 	ufshcd_writel(hba, 1 << task_tag, REG_UTP_TASK_REQ_DOOR_BELL);
+ 
  	ufshcd_add_tm_upiu_trace(hba, task_tag, UFS_TM_SEND);
  
  	/* wait until the task management command is completed */
```

```console
shell$ diff -p linux-6.12.109/drivers/ufs/core/ufshcd.c linux-6.12.109-xlnx-v2025.1/drivers/ufs/core/ufshcd.c
*** linux-6.12.109/drivers/ufs/core/ufshcd.c	2026-10-09 15:27:33.327047350 +0900
--- linux-6.12.109-xlnx-v2025.1/drivers/ufs/core/ufshcd.c	2026-10-11 09:39:51.297422214 +0900
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

###### Make 251_drivers-ufs.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/251_drivers-ufs.patch
patching file Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml
patching file drivers/ufs/core/ufshcd-priv.h
patching file drivers/ufs/core/ufshcd.c
Hunk #1 succeeded at 7018 (offset -2 lines).
Hunk #2 succeeded at 8911 (offset -1 lines).
patching file drivers/ufs/host/Kconfig
patching file drivers/ufs/host/Makefile
patching file drivers/ufs/host/ufs-amd-versal2.c
patching file drivers/ufs/host/ufshcd-dwc.h
patching file drivers/ufs/host/ufshci-dwc.h
patching file include/ufs/ufshcd.h
patching file include/ufs/ufshci.h
patching file include/ufs/unipro.h
```

```console
shell$ rm drivers/ufs/core/ufshcd.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 251_drivers-ufs.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/251_drivers-ufs.patch
```

##### 262_drivers-usb-dwc3.patch

###### drivers/usb/dwc3/core.h

```console
shell$ diff -p linux-6.12.109/drivers/usb/dwc3/core.h linux-6.12.113/drivers/usb/dwc3/core.h
*** linux-6.12.109/drivers/usb/dwc3/core.h	2026-10-09 15:27:33.343049014 +0900
--- linux-6.12.113/drivers/usb/dwc3/core.h	2026-10-23 13:59:45.868885211 +0900
***************
*** 49,54 ****
--- 49,55 ----
  #define DWC3_ENDPOINTS_NUM	32
  #define DWC3_XHCI_RESOURCES_NUM	2
  #define DWC3_ISOC_MAX_RETRIES	5
+ #define DWC3_ERR_RECOVERY_MAX	3
  
  #define DWC3_SCRATCHBUF_SIZE	4096	/* each buffer is assumed to be 4KiB */
  #define DWC3_EVENT_BUFFERS_SIZE	4096
*************** struct dwc3_event_buffer {
*** 742,747 ****
--- 743,749 ----
   */
  struct dwc3_ep {
  	struct usb_ep		endpoint;
+ 	struct delayed_work	nostream_work;
  	struct list_head	cancelled_list;
  	struct list_head	pending_list;
  	struct list_head	started_list;
*************** struct dwc3_ep {
*** 764,770 ****
  #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
  #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
  #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
! #define DWC3_EP_FIRST_STREAM_PRIMED	BIT(10)
  #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
  #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
  #define DWC3_EP_DELAY_STOP             BIT(13)
--- 766,772 ----
  #define DWC3_EP_WAIT_TRANSFER_COMPLETE	BIT(7)
  #define DWC3_EP_IGNORE_NEXT_NOSTREAM	BIT(8)
  #define DWC3_EP_FORCE_RESTART_STREAM	BIT(9)
! #define DWC3_EP_STREAM_PRIMED		BIT(10)
  #define DWC3_EP_PENDING_CLEAR_STALL	BIT(11)
  #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
  #define DWC3_EP_DELAY_STOP             BIT(13)
*************** enum dwc3_link_state {
*** 840,845 ****
--- 842,853 ----
  	DWC3_LINK_STATE_MASK		= 0x0f,
  };
  
+ enum dwc3_err_state {
+ 	DWC3_ERR_NONE = 0,
+ 	DWC3_ERR_RECOVERY,
+ 	DWC3_ERR_UNRECOVERABLE,
+ };
+ 
  /* TRB Length, PCM and Status */
  #define DWC3_TRB_SIZE_MASK	(0x00ffffff)
  #define DWC3_TRB_SIZE_LENGTH(n)	((n) & DWC3_TRB_SIZE_MASK)
*************** struct dwc3_scratchpad_array {
*** 999,1004 ****
--- 1007,1013 ----
  /**
   * struct dwc3 - representation of our controller
   * @drd_work: workqueue used for role swapping
+  * @err_recovery_work: workqueue used for controller error recovery
   * @ep0_trb: trb which is used for the ctrl_req
   * @bounce: address of bounce buffer
   * @setup_buf: used while precessing STD USB requests
*************** struct dwc3_scratchpad_array {
*** 1008,1013 ****
--- 1017,1023 ----
   * @ep0_in_setup: one control transfer is completed and enter setup phase
   * @lock: for synchronizing
   * @mutex: for mode switching
+  * @connect_mutex: for the pull-up and err_recovery_work
   * @dev: pointer to our struct device
   * @sysdev: pointer to the DMA-capable device
   * @xhci: pointer to our xHCI child
*************** struct dwc3_scratchpad_array {
*** 1071,1076 ****
--- 1081,1089 ----
   * @ep0_next_event: hold the next expected event
   * @ep0state: state of endpoint zero
   * @link_state: link state
+  * @err_state: current error recovery state.
+  * @err_recovery_count: number of consecutive error recovery attempts until
+  *		confirmed healthy and reset to 0 on reset event.
   * @speed: device speed (super, high, full, low)
   * @hwparams: copy of hwparams registers
   * @regset: debugfs pointer to regdump file
*************** struct dwc3_scratchpad_array {
*** 1176,1181 ****
--- 1189,1195 ----
   */
  struct dwc3 {
  	struct work_struct	drd_work;
+ 	struct work_struct	err_recovery_work;
  	struct dwc3_trb		*ep0_trb;
  	void			*bounce;
  	u8			*setup_buf;
*************** struct dwc3 {
*** 1190,1195 ****
--- 1204,1212 ----
  	/* mode switching lock */
  	struct mutex		mutex;
  
+ 	/* serializes pull-up run/stop vs error recovery */
+ 	struct mutex		connect_mutex;
+ 
  	struct device		*dev;
  	struct device		*sysdev;
  
*************** struct dwc3 {
*** 1313,1318 ****
--- 1330,1338 ----
  	enum dwc3_ep0_next	ep0_next_event;
  	enum dwc3_ep0_state	ep0state;
  	enum dwc3_link_state	link_state;
+ 	enum dwc3_err_state	err_state;
+ 
+ 	u32			err_recovery_count;
  
  	u16			u2sel;
  	u16			u2pel;
```

###### drivers/usb/dwc3/ep0.c

```console
shell$ diff -p linux-6.12.109/drivers/usb/dwc3/ep0.c linux-6.12.113/drivers/usb/dwc3/ep0.c
*** linux-6.12.109/drivers/usb/dwc3/ep0.c	2026-10-09 15:27:33.343049014 +0900
--- linux-6.12.113/drivers/usb/dwc3/ep0.c	2026-10-23 13:59:45.868885211 +0900
*************** int dwc3_gadget_ep0_queue(struct usb_ep
*** 200,205 ****
--- 200,210 ----
  	int				ret;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		ret = -ESHUTDOWN;
+ 		goto out;
+ 	}
+ 
  	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
  		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
  				dep->name);
*************** int dwc3_gadget_ep0_set_halt(struct usb_
*** 271,276 ****
--- 276,285 ----
  	int				ret;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	ret = __dwc3_gadget_ep0_set_halt(ep, value);
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
*************** void dwc3_ep0_out_start(struct dwc3 *dwc
*** 304,310 ****
  
  		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
  		if (dwc->connected)
! 			dwc3_stop_active_transfer(dwc3_ep, true, true);
  		else
  			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
  	}
--- 313,319 ----
  
  		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
  		if (dwc->connected)
! 			dwc3_stop_active_transfer(dwc3_ep, false, true);
  		else
  			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
  	}
```

###### drivers/usb/dwc3/gadget.c

```console
shell$ diff -p linux-6.12.109/drivers/usb/dwc3/gadget.c linux-6.12.113/drivers/usb/dwc3/gadget.c
*** linux-6.12.109/drivers/usb/dwc3/gadget.c	2026-10-09 15:27:33.343049014 +0900
--- linux-6.12.113/drivers/usb/dwc3/gadget.c	2026-10-23 13:59:45.868885211 +0900
*************** static int __dwc3_gadget_ep_enable(struc
*** 991,1002 ****
  			 * controller to generate an ERDY to initiate the
  			 * stream.
  			 */
! 			dwc3_stop_active_transfer(dep, true, true);
  
  			/*
  			 * All stream eps will reinitiate stream on NoStream
! 			 * rejection until we can determine that the host can
! 			 * prime after the first transfer.
  			 *
  			 * However, if the controller is capable of
  			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
--- 991,1001 ----
  			 * controller to generate an ERDY to initiate the
  			 * stream.
  			 */
! 			dwc3_stop_active_transfer(dep, false, true);
  
  			/*
  			 * All stream eps will reinitiate stream on NoStream
! 			 * rejection.
  			 *
  			 * However, if the controller is capable of
  			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
*************** void dwc3_remove_requests(struct dwc3 *d
*** 1020,1026 ****
  {
  	struct dwc3_request		*req;
  
! 	dwc3_stop_active_transfer(dep, true, false);
  
  	/* If endxfer is delayed, avoid unmapping requests */
  	if (dep->flags & DWC3_EP_DELAY_STOP)
--- 1019,1025 ----
  {
  	struct dwc3_request		*req;
  
! 	dwc3_stop_active_transfer(dep, false, false);
  
  	/* If endxfer is delayed, avoid unmapping requests */
  	if (dep->flags & DWC3_EP_DELAY_STOP)
*************** static int dwc3_gadget_ep_enable(struct
*** 1137,1142 ****
--- 1136,1145 ----
  		return 0;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
*************** static int __dwc3_gadget_kick_transfer(s
*** 1710,1716 ****
  		if (ret == -EAGAIN)
  			return ret;
  
! 		dwc3_stop_active_transfer(dep, true, true);
  
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
--- 1713,1719 ----
  		if (ret == -EAGAIN)
  			return ret;
  
! 		dwc3_stop_active_transfer(dep, false, true);
  
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
*************** static int __dwc3_gadget_get_frame(struc
*** 1747,1752 ****
--- 1750,1760 ----
   * the controller won't update the TRB progress on command
   * completion. It also won't clear the HWO bit in the TRB.
   * The command will also not complete immediately in that case.
+  *
+  * Older programming guide revisions recommended setting ForceRM to 1
+  * when ending a transfer. Newer programming guide revisions now
+  * recommend keeping ForceRM cleared, and TRBs are properly updated
+  * on command completion.
   */
  static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
  {
*************** static int dwc3_gadget_start_isoc_quirk(
*** 1872,1878 ****
  		 * to wait for the next XferNotReady to test the command again
  		 */
  		if (cmd_status == 0) {
! 			dwc3_stop_active_transfer(dep, true, true);
  			return 0;
  		}
  	}
--- 1880,1886 ----
  		 * to wait for the next XferNotReady to test the command again
  		 */
  		if (cmd_status == 0) {
! 			dwc3_stop_active_transfer(dep, false, true);
  			return 0;
  		}
  	}
*************** static int dwc3_gadget_ep_queue(struct u
*** 2045,2050 ****
--- 2053,2062 ----
  	int				ret;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	ret = __dwc3_gadget_ep_queue(dep, req);
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
*************** static int dwc3_gadget_ep_dequeue(struct
*** 2155,2161 ****
  			struct dwc3_request *t;
  
  			/* wait until it is processed */
! 			dwc3_stop_active_transfer(dep, true, true);
  
  			/*
  			 * Remove any started request if the transfer is
--- 2167,2173 ----
  			struct dwc3_request *t;
  
  			/* wait until it is processed */
! 			dwc3_stop_active_transfer(dep, false, true);
  
  			/*
  			 * Remove any started request if the transfer is
*************** int __dwc3_gadget_ep_set_halt(struct dwc
*** 2232,2238 ****
  			return 0;
  		}
  
! 		dwc3_stop_active_transfer(dep, true, true);
  
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
--- 2244,2250 ----
  			return 0;
  		}
  
! 		dwc3_stop_active_transfer(dep, false, true);
  
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
*************** static int dwc3_gadget_ep_set_halt(struc
*** 2277,2282 ****
--- 2289,2298 ----
  	int				ret;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
*************** static int dwc3_gadget_ep_set_wedge(stru
*** 2291,2296 ****
--- 2307,2316 ----
  	int				ret;
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	dep->flags |= DWC3_EP_WEDGE;
  
  	if (dep->number == 0 || dep->number == 1)
*************** static int dwc3_gadget_wakeup(struct usb
*** 2422,2427 ****
--- 2442,2451 ----
  	}
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	if (!dwc->gadget->wakeup_armed) {
  		dev_err(dwc->dev, "not armed for remote wakeup\n");
  		spin_unlock_irqrestore(&dwc->lock, flags);
*************** static int dwc3_gadget_func_wakeup(struc
*** 2449,2454 ****
--- 2473,2482 ----
  	}
  
  	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dwc->err_state != DWC3_ERR_NONE) {
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return -ESHUTDOWN;
+ 	}
  	/*
  	 * If the link is in U3, signal for remote wakeup and wait for the
  	 * link to transition to U0 before sending device notification.
*************** static int dwc3_gadget_pullup(struct usb
*** 2815,2824 ****
--- 2843,2855 ----
  
  	synchronize_irq(dwc->irq_gadget);
  
+ 	/* Serialize against dwc3_err_recovery_work() */
+ 	mutex_lock(&dwc->connect_mutex);
  	if (!is_on)
  		ret = dwc3_gadget_soft_disconnect(dwc);
  	else
  		ret = dwc3_gadget_soft_connect(dwc);
+ 	mutex_unlock(&dwc->connect_mutex);
  
  	pm_runtime_put(dwc->dev);
  
*************** static int dwc3_gadget_init_out_endpoint
*** 3309,3314 ****
--- 3340,3389 ----
  	return dwc3_alloc_trb_pool(dep);
  }
  
+ #define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
+ static void dwc3_nostream_work(struct work_struct *work)
+ {
+ 	struct dwc3_ep	*dep = nostream_work_to_dep(work);
+ 	struct dwc3	*dwc = dep->dwc;
+ 	unsigned long   flags;
+ 
+ 	spin_lock_irqsave(&dwc->lock, flags);
+ 	if (dep->flags & DWC3_EP_STREAM_PRIMED)
+ 		goto out;
+ 
+ 	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+ 	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+ 	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
+ 		goto out;
+ 	/*
+ 	 * If the host rejects a stream due to no active stream, by the
+ 	 * USB and xHCI spec, the endpoint will be put back to idle
+ 	 * state. When the host is ready (buffer added/updated), it will
+ 	 * prime the endpoint to inform the usb device controller. This
+ 	 * triggers the device controller to issue ERDY to restart the
+ 	 * stream. However, some hosts don't follow this and keep the
+ 	 * endpoint in the idle state. No prime will come despite host
+ 	 * streams are updated, and the device controller will not be
+ 	 * triggered to generate ERDY to move the next stream data. To
+ 	 * workaround this and maintain compatibility with various
+ 	 * hosts, force to reinitiate the stream until the host is ready
+ 	 * instead of waiting for the host to prime the endpoint.
+ 	 */
+ 	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+ 		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+ 
+ 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+ 	} else {
+ 		dep->flags |= DWC3_EP_DELAY_START;
+ 		dwc3_stop_active_transfer(dep, false, true);
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 		return;
+ 	}
+ out:
+ 	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+ 	spin_unlock_irqrestore(&dwc->lock, flags);
+ }
+ 
  static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
  {
  	struct dwc3_ep			*dep;
*************** static int dwc3_gadget_init_endpoint(str
*** 3354,3359 ****
--- 3429,3435 ----
  	INIT_LIST_HEAD(&dep->pending_list);
  	INIT_LIST_HEAD(&dep->started_list);
  	INIT_LIST_HEAD(&dep->cancelled_list);
+ 	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
  
  	dwc3_debugfs_create_endpoint_dir(dep);
  
*************** static void dwc3_gadget_free_endpoints(s
*** 3401,3406 ****
--- 3477,3483 ----
  		}
  
  		dwc3_debugfs_remove_endpoint_dir(dep);
+ 		cancel_delayed_work_sync(&dep->nostream_work);
  		kfree(dep);
  	}
  }
*************** static bool dwc3_gadget_endpoint_trbs_co
*** 3643,3649 ****
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
  		list_empty(&dep->started_list) &&
  		(list_empty(&dep->pending_list) || status == -EXDEV))
! 		dwc3_stop_active_transfer(dep, true, true);
  	else if (dwc3_gadget_ep_should_continue(dep))
  		if (__dwc3_gadget_kick_transfer(dep) == 0)
  			no_started_trb = false;
--- 3720,3726 ----
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
  		list_empty(&dep->started_list) &&
  		(list_empty(&dep->pending_list) || status == -EXDEV))
! 		dwc3_stop_active_transfer(dep, false, true);
  	else if (dwc3_gadget_ep_should_continue(dep))
  		if (__dwc3_gadget_kick_transfer(dep) == 0)
  			no_started_trb = false;
*************** static void dwc3_gadget_endpoint_command
*** 3789,3854 ****
  static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
  		const struct dwc3_event_depevt *event)
  {
- 	struct dwc3 *dwc = dep->dwc;
- 
  	if (event->status == DEPEVT_STREAMEVT_FOUND) {
! 		dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
! 		goto out;
  	}
  
  	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
  	switch (event->parameters) {
  	case DEPEVT_STREAM_PRIME:
! 		/*
! 		 * If the host can properly transition the endpoint state from
! 		 * idle to prime after a NoStream rejection, there's no need to
! 		 * force restarting the endpoint to reinitiate the stream. To
! 		 * simplify the check, assume the host follows the USB spec if
! 		 * it primed the endpoint more than once.
! 		 */
! 		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM) {
! 			if (dep->flags & DWC3_EP_FIRST_STREAM_PRIMED)
! 				dep->flags &= ~DWC3_EP_FORCE_RESTART_STREAM;
! 			else
! 				dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
! 		}
! 
  		break;
  	case DEPEVT_STREAM_NOSTREAM:
! 		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
! 		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
! 		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
! 		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
! 			break;
! 
! 		/*
! 		 * If the host rejects a stream due to no active stream, by the
! 		 * USB and xHCI spec, the endpoint will be put back to idle
! 		 * state. When the host is ready (buffer added/updated), it will
! 		 * prime the endpoint to inform the usb device controller. This
! 		 * triggers the device controller to issue ERDY to restart the
! 		 * stream. However, some hosts don't follow this and keep the
! 		 * endpoint in the idle state. No prime will come despite host
! 		 * streams are updated, and the device controller will not be
! 		 * triggered to generate ERDY to move the next stream data. To
! 		 * workaround this and maintain compatibility with various
! 		 * hosts, force to reinitiate the stream until the host is ready
! 		 * instead of waiting for the host to prime the endpoint.
! 		 */
! 		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
! 			unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
! 
! 			dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
! 		} else {
! 			dep->flags |= DWC3_EP_DELAY_START;
! 			dwc3_stop_active_transfer(dep, true, true);
! 			return;
! 		}
  		break;
  	}
- 
- out:
- 	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
  }
  
  static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
--- 3866,3892 ----
  static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
  		const struct dwc3_event_depevt *event)
  {
  	if (event->status == DEPEVT_STREAMEVT_FOUND) {
! 		cancel_delayed_work(&dep->nostream_work);
! 		dep->flags |= DWC3_EP_STREAM_PRIMED;
! 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
! 		return;
  	}
  
  	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
  	switch (event->parameters) {
  	case DEPEVT_STREAM_PRIME:
! 		cancel_delayed_work(&dep->nostream_work);
! 		dep->flags |= DWC3_EP_STREAM_PRIMED;
! 		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
  		break;
  	case DEPEVT_STREAM_NOSTREAM:
! 		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
! 		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
! 			queue_delayed_work(system_wq, &dep->nostream_work,
! 					   msecs_to_jiffies(100));
  		break;
  	}
  }
  
  static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
*************** static void dwc3_gadget_reset_interrupt(
*** 4104,4109 ****
--- 4142,4151 ----
  
  	dwc->suspended = false;
  
+ 	/* The controller is recovered. */
+ 	if (dwc->err_state == DWC3_ERR_NONE)
+ 		dwc->err_recovery_count = 0;
+ 
  	/*
  	 * Ideally, dwc3_reset_gadget() would trigger the function
  	 * drivers to stop any active transfers through ep disable.
*************** static irqreturn_t dwc3_thread_interrupt
*** 4591,4596 ****
--- 4633,4644 ----
  	return ret;
  }
  
+ static void dwc3_schedule_err_recovery(struct dwc3 *dwc)
+ {
+ 	dwc->err_state = DWC3_ERR_RECOVERY;
+ 	schedule_work(&dwc->err_recovery_work);
+ }
+ 
  static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
  {
  	struct dwc3 *dwc = evt->dwc;
*************** static irqreturn_t dwc3_check_event_buf(
*** 4624,4632 ****
  		return IRQ_NONE;
  
  	if (count > evt->length) {
! 		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
  			count, evt->length);
! 		return IRQ_NONE;
  	}
  
  	evt->count = count;
--- 4672,4692 ----
  		return IRQ_NONE;
  
  	if (count > evt->length) {
! 		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
  			count, evt->length);
! 		/*
! 		 * This is a fatal error - the driver and controller are out of
! 		 * sync on which event has been consumed. Reinitializing the
! 		 * controller is required to recover. Write the bogus count back
! 		 * to GEVNTCOUNT to clear the IRQ source, consistent with the
! 		 * stale event clearing in dwc3_event_buffers_setup(), then
! 		 * schedule error recovery.
! 		 */
! 		spin_lock(&dwc->lock);
! 		dwc3_schedule_err_recovery(dwc);
! 		spin_unlock(&dwc->lock);
! 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
! 		return IRQ_HANDLED;
  	}
  
  	evt->count = count;
*************** static void dwc_gadget_release(struct de
*** 4686,4691 ****
--- 4746,4802 ----
  	kfree(gadget);
  }
  
+ static void dwc3_err_recovery_work(struct work_struct *work)
+ {
+ 	struct dwc3 *dwc = container_of(work, struct dwc3, err_recovery_work);
+ 	unsigned long flags;
+ 	int ret;
+ 
+ 	/* serializes against dwc3_gadget_pullup() */
+ 	mutex_lock(&dwc->connect_mutex);
+ 
+ 	ret = dwc3_gadget_soft_disconnect(dwc);
+ 
+ 	dwc3_disconnect_gadget_sleepable(dwc);
+ 
+ 	if (ret)
+ 		goto err_unrecoverable;
+ 
+ 	if (dwc->softconnect) {
+ 		u32 count;
+ 		/*
+ 		 * Wait irq to finish before soft_connect resets evt->lpos and
+ 		 * the event buffer registers to avoid racing with
+ 		 * dwc3_process_event_buf().
+ 		 */
+ 		synchronize_irq(dwc->irq_gadget);
+ 
+ 		spin_lock_irqsave(&dwc->lock, flags);
+ 		count = ++dwc->err_recovery_count;
+ 		spin_unlock_irqrestore(&dwc->lock, flags);
+ 
+ 		if (count > DWC3_ERR_RECOVERY_MAX)
+ 			goto err_unrecoverable;
+ 
+ 		ret = dwc3_gadget_soft_connect(dwc);
+ 		if (ret)
+ 			goto err_unrecoverable;
+ 	}
+ 	mutex_unlock(&dwc->connect_mutex);
+ 
+ 	spin_lock_irqsave(&dwc->lock, flags);
+ 	dwc->err_state = DWC3_ERR_NONE;
+ 	spin_unlock_irqrestore(&dwc->lock, flags);
+ 	return;
+ 
+ err_unrecoverable:
+ 	dev_err(dwc->dev, "Unable to recover the controller\n");
+ 	mutex_unlock(&dwc->connect_mutex);
+ 	spin_lock_irqsave(&dwc->lock, flags);
+ 	dwc->err_state = DWC3_ERR_UNRECOVERABLE;
+ 	spin_unlock_irqrestore(&dwc->lock, flags);
+ }
+ 
  /**
   * dwc3_gadget_init - initializes gadget related registers
   * @dwc: pointer to our controller context structure
*************** int dwc3_gadget_init(struct dwc3 *dwc)
*** 4729,4734 ****
--- 4840,4847 ----
  	}
  
  	init_completion(&dwc->ep0_in_setup);
+ 	INIT_WORK(&dwc->err_recovery_work, dwc3_err_recovery_work);
+ 	mutex_init(&dwc->connect_mutex);
  	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
  	if (!dwc->gadget) {
  		ret = -ENOMEM;
*************** void dwc3_gadget_exit(struct dwc3 *dwc)
*** 4824,4829 ****
--- 4937,4944 ----
  	if (!dwc->gadget)
  		return;
  
+ 	cancel_work_sync(&dwc->err_recovery_work);
+ 	mutex_destroy(&dwc->connect_mutex);
  	dwc3_enable_susphy(dwc, true);
  	usb_del_gadget(dwc->gadget);
  	dwc3_gadget_free_endpoints(dwc);
```

###### Make 262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
Hunk #2 succeeded at 183 (offset 1 line).
Hunk #3 succeeded at 205 (offset 1 line).
Hunk #4 succeeded at 296 (offset 1 line).
Hunk #5 succeeded at 522 (offset 1 line).
Hunk #6 succeeded at 691 (offset 1 line).
Hunk #7 succeeded at 1030 with fuzz 1 (offset 9 lines).
Hunk #8 succeeded at 1059 (offset 10 lines).
Hunk #9 succeeded at 1082 (offset 10 lines).
Hunk #10 succeeded at 1133 (offset 13 lines).
Hunk #11 succeeded at 1151 (offset 13 lines).
Hunk #12 succeeded at 1192 (offset 13 lines).
Hunk #13 succeeded at 1211 (offset 13 lines).
Hunk #14 succeeded at 1228 with fuzz 1 (offset 14 lines).
Hunk #15 succeeded at 1288 (offset 17 lines).
Hunk #16 succeeded at 1303 (offset 17 lines).
Hunk #17 succeeded at 1385 (offset 20 lines).
Hunk #18 succeeded at 1411 (offset 20 lines).
Hunk #19 succeeded at 1426 (offset 20 lines).
Hunk #20 succeeded at 1452 (offset 20 lines).
Hunk #21 succeeded at 1470 (offset 20 lines).
Hunk #22 succeeded at 1645 (offset 20 lines).
Hunk #23 succeeded at 1693 (offset 20 lines).
Hunk #24 succeeded at 1722 (offset 20 lines).
Hunk #25 succeeded at 1745 (offset 20 lines).
Hunk #26 succeeded at 1771 (offset 20 lines).
Hunk #27 succeeded at 1803 (offset 20 lines).
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
Hunk #1 FAILED at 200.
Hunk #2 succeeded at 290 (offset 9 lines).
Hunk #3 FAILED at 290.
Hunk #4 succeeded at 379 (offset 9 lines).
Hunk #5 succeeded at 506 (offset 9 lines).
Hunk #6 succeeded at 524 (offset 9 lines).
Hunk #7 succeeded at 837 (offset 9 lines).
Hunk #8 succeeded at 875 (offset 9 lines).
Hunk #9 succeeded at 1188 (offset 9 lines).
2 out of 9 hunks FAILED -- saving rejects to file drivers/usb/dwc3/ep0.c.rej
patching file drivers/usb/dwc3/gadget.c
Hunk #9 succeeded at 1066 (offset -1 lines).
Hunk #10 succeeded at 1668 (offset 3 lines).
Hunk #11 succeeded at 1794 (offset 8 lines).
Hunk #12 succeeded at 2029 (offset 8 lines).
Hunk #13 succeeded at 2050 (offset 8 lines).
Hunk #14 succeeded at 2284 (offset 12 lines).
Hunk #15 succeeded at 2667 (offset 28 lines).
Hunk #16 succeeded at 2742 (offset 28 lines).
Hunk #17 succeeded at 2803 (offset 28 lines).
Hunk #18 succeeded at 2834 (offset 28 lines).
Hunk #19 FAILED at 2851.
Hunk #20 succeeded at 2903 (offset 31 lines).
Hunk #21 succeeded at 2917 (offset 31 lines).
Hunk #22 succeeded at 3019 (offset 31 lines).
Hunk #23 succeeded at 3073 (offset 31 lines).
Hunk #24 succeeded at 3091 (offset 31 lines).
Hunk #25 succeeded at 3774 (offset 77 lines).
Hunk #26 FAILED at 3707.
Hunk #27 succeeded at 3836 (offset 77 lines).
Hunk #28 succeeded at 4023 (offset 38 lines).
Hunk #29 succeeded at 4184 (offset 38 lines).
Hunk #30 succeeded at 4259 (offset 42 lines).
Hunk #31 succeeded at 4313 (offset 42 lines).
Hunk #32 succeeded at 4439 (offset 42 lines).
Hunk #33 succeeded at 4478 (offset 42 lines).
Hunk #34 succeeded at 4491 (offset 42 lines).
Hunk #35 succeeded at 4634 (offset 42 lines).
Hunk #36 succeeded at 4677 (offset 42 lines).
Hunk #37 succeeded at 4719 (offset 42 lines).
Hunk #38 succeeded at 4744 (offset 42 lines).
Hunk #39 succeeded at 4757 (offset 42 lines).
Hunk #40 succeeded at 4820 (offset 48 lines).
Hunk #41 succeeded at 4884 (offset 60 lines).
Hunk #42 succeeded at 4903 (offset 60 lines).
Hunk #43 succeeded at 4997 (offset 111 lines).
Hunk #44 succeeded at 5092 (offset 113 lines).
Hunk #45 succeeded at 5185 (offset 115 lines).
2 out of 45 hunks FAILED -- saving rejects to file drivers/usb/dwc3/gadget.c.rej
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```

```console
shell$ rm drivers/usb/dwc3/core.h.orig
```

```console
shell$ rm drivers/usb/dwc3/ep0.c.orig
shell$ rm drivers/usb/dwc3/ep0.c.rej
shell$ cp ../linux-6.12.109-xlnx-v2025.1/drivers/usb/dwc3/ep0.c drivers/usb/dwc3/ep0.c
shell$ patch drivers/usb/dwc3/ep0.c << 'EOT'
--- drivers/usb/dwc3/ep0.c	2026-10-24 06:21:45.823953514 +0900
+++ drivers/usb/dwc3/ep0.c	2026-10-24 06:24:04.488903072 +0900
@@ -200,6 +200,11 @@
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		ret = -ESHUTDOWN;
+		goto out;
+	}
+
 	if (!dep->endpoint.desc || !dwc->pullups_connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
@@ -271,6 +276,10 @@
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep0_set_halt(ep, value);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
EOT
```

```console
shell$ patch drivers/usb/dwc3/gadget.h << 'EOT'
--- drivers/usb/dwc3/gadget.h	2026-10-24 06:13:57.467442247 +0900
+++ drivers/usb/dwc3/gadget-new.h	2026-10-24 07:25:35.441113768 +0900
@@ -134,7 +134,7 @@
 int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend);
 dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep, struct dwc3_trb *trb);
 void dwc3_ep0_send_delayed_status(struct dwc3 *dwc);
-void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt);
+void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool clear_index, bool interrupt);
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index);
 
 /**
EOT
```

```console
shell$ rm drivers/usb/dwc3/gadget.c.orig
shell$ rm drivers/usb/dwc3/gadget.c.rej
shell$ cp ../linux-6.12.109-xlnx-v2025.1/drivers/usb/dwc3/gadget.c drivers/usb/dwc3/gadget.c 
shell$ patch drivers/usb/dwc3/gadget.c << 'EOT'
--- drivers/usb/dwc3/gadget.c	2026-10-24 06:29:56.006131110 +0900
+++ drivers/usb/dwc3/gadget.c	2026-10-24 07:21:20.827301009 +0900
@@ -663,9 +663,6 @@
 	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
 }
 
-void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-			       bool interrupt);
-
 /**
  * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
  * @dwc: pointer to the DWC3 context
@@ -1002,12 +999,11 @@
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
-			 * rejection until we can determine that the host can
-			 * prime after the first transfer.
+			 * rejection.
 			 *
 			 * However, if the controller is capable of
 			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
@@ -1031,7 +1027,7 @@
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, true, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1148,6 +1144,10 @@
 		return 0;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_enable(dep, DWC3_DEPCFG_ACTION_INIT);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -1721,7 +1721,7 @@
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1752,14 +1752,20 @@
  * __dwc3_stop_active_transfer - stop the current active transfer
  * @dep: isoc endpoint
  * @force: set forcerm bit in the command
+ * @clear_index: clear dep->resource_index
  * @interrupt: command complete interrupt after End Transfer command
  *
  * When setting force, the ForceRM bit will be set. In that case
  * the controller won't update the TRB progress on command
  * completion. It also won't clear the HWO bit in the TRB.
  * The command will also not complete immediately in that case.
+ *
+ * Older programming guide revisions recommended setting ForceRM to 1
+ * when ending a transfer. Newer programming guide revisions now
+ * recommend keeping ForceRM cleared, and TRBs are properly updated
+ * on command completion.
  */
-static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
+static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool clear_index, bool interrupt)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
@@ -1790,7 +1796,7 @@
 	 * when transfer is stopped with force rm bit false, it can be
 	 * restarted by passing resource_index in params; don't loose it
 	 */
-	if (force)
+	if (clear_index)
 		dep->resource_index = 0;
 
 	if (!interrupt)
@@ -1888,7 +1894,7 @@
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true, true);
 			return 0;
 		}
 	}
@@ -1978,7 +1984,7 @@
 	 * event.
 	 */
 	if (ret == -EAGAIN)
-		ret = __dwc3_stop_active_transfer(dep, false, true);
+		ret = __dwc3_stop_active_transfer(dep, false, true, true);
 
 	return ret;
 }
@@ -2054,7 +2060,7 @@
 				 * TRANSFER is issued when an entry is added
 				 * into request list.
 				 */
-				dwc3_stop_active_transfer(dep, true, true);
+				dwc3_stop_active_transfer(dep, true, true, true);
 				dep->flags = DWC3_EP_ENABLED;
 			}
 
@@ -2080,6 +2086,10 @@
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_queue(dep, req);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2190,7 +2200,7 @@
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2267,7 +2277,7 @@
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -2311,6 +2321,10 @@
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	ret = __dwc3_gadget_ep_set_halt(dep, value, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2325,6 +2339,10 @@
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	dep->flags |= DWC3_EP_WEDGE;
 
 	if (dep->number == 0 || dep->number == 1)
@@ -2483,6 +2501,10 @@
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	if (dwc->err_state != DWC3_ERR_NONE) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return -ESHUTDOWN;
+	}
 	/*
 	 * If the link is in U3, signal for remote wakeup and wait for the
 	 * link to transition to U0 before sending device notification.
@@ -2849,12 +2871,15 @@
 
 	synchronize_irq(dwc->irq_gadget);
 
+	/* Serialize against dwc3_err_recovery_work() */
+	mutex_lock(&dwc->connect_mutex);
 	if (!is_on)
 		ret = dwc3_gadget_soft_disconnect(dwc);
 	else {
 		__dwc3_gadget_start(dwc);
 		ret = dwc3_gadget_run_stop(dwc, true, false);
 	}
+	mutex_unlock(&dwc->connect_mutex);
 
 	pm_runtime_put(dwc->dev);
 
@@ -3374,6 +3399,50 @@
 	return dwc3_alloc_trb_pool(dep);
 }
 
+#define nostream_work_to_dep(w) (container_of(to_delayed_work(w), struct dwc3_ep, nostream_work))
+static void dwc3_nostream_work(struct work_struct *work)
+{
+	struct dwc3_ep	*dep = nostream_work_to_dep(work);
+	struct dwc3	*dwc = dep->dwc;
+	unsigned long   flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (dep->flags & DWC3_EP_STREAM_PRIMED)
+		goto out;
+
+	if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
+	    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
+	     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
+		goto out;
+	/*
+	 * If the host rejects a stream due to no active stream, by the
+	 * USB and xHCI spec, the endpoint will be put back to idle
+	 * state. When the host is ready (buffer added/updated), it will
+	 * prime the endpoint to inform the usb device controller. This
+	 * triggers the device controller to issue ERDY to restart the
+	 * stream. However, some hosts don't follow this and keep the
+	 * endpoint in the idle state. No prime will come despite host
+	 * streams are updated, and the device controller will not be
+	 * triggered to generate ERDY to move the next stream data. To
+	 * workaround this and maintain compatibility with various
+	 * hosts, force to reinitiate the stream until the host is ready
+	 * instead of waiting for the host to prime the endpoint.
+	 */
+	if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
+		unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
+
+		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
+	} else {
+		dep->flags |= DWC3_EP_DELAY_START;
+		dwc3_stop_active_transfer(dep, false, true, true);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+out:
+	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 {
 	struct dwc3_ep			*dep;
@@ -3419,6 +3488,7 @@
 	INIT_LIST_HEAD(&dep->pending_list);
 	INIT_LIST_HEAD(&dep->started_list);
 	INIT_LIST_HEAD(&dep->cancelled_list);
+	INIT_DELAYED_WORK(&dep->nostream_work, dwc3_nostream_work);
 
 	dwc3_debugfs_create_endpoint_dir(dep);
 
@@ -3719,7 +3789,7 @@
 			 */
 			dep->flags |= DWC3_EP_PENDING_REQUEST;
 		else if (status == -EXDEV)
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, true, true, true);
 	} else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
 			no_started_trb = false;
@@ -3866,66 +3936,27 @@
 static void dwc3_gadget_endpoint_stream_event(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
-	struct dwc3 *dwc = dep->dwc;
-
 	if (event->status == DEPEVT_STREAMEVT_FOUND) {
-		dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		goto out;
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
+		return;
 	}
 
 	/* Note: NoStream rejection event param value is 0 and not 0xFFFF */
 	switch (event->parameters) {
 	case DEPEVT_STREAM_PRIME:
-		/*
-		 * If the host can properly transition the endpoint state from
-		 * idle to prime after a NoStream rejection, there's no need to
-		 * force restarting the endpoint to reinitiate the stream. To
-		 * simplify the check, assume the host follows the USB spec if
-		 * it primed the endpoint more than once.
-		 */
-		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM) {
-			if (dep->flags & DWC3_EP_FIRST_STREAM_PRIMED)
-				dep->flags &= ~DWC3_EP_FORCE_RESTART_STREAM;
-			else
-				dep->flags |= DWC3_EP_FIRST_STREAM_PRIMED;
-		}
-
+		cancel_delayed_work(&dep->nostream_work);
+		dep->flags |= DWC3_EP_STREAM_PRIMED;
+		dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 		break;
 	case DEPEVT_STREAM_NOSTREAM:
-		if ((dep->flags & DWC3_EP_IGNORE_NEXT_NOSTREAM) ||
-		    !(dep->flags & DWC3_EP_FORCE_RESTART_STREAM) ||
-		    (!DWC3_MST_CAPABLE(&dwc->hwparams) &&
-		     !(dep->flags & DWC3_EP_WAIT_TRANSFER_COMPLETE)))
-			break;
-
-		/*
-		 * If the host rejects a stream due to no active stream, by the
-		 * USB and xHCI spec, the endpoint will be put back to idle
-		 * state. When the host is ready (buffer added/updated), it will
-		 * prime the endpoint to inform the usb device controller. This
-		 * triggers the device controller to issue ERDY to restart the
-		 * stream. However, some hosts don't follow this and keep the
-		 * endpoint in the idle state. No prime will come despite host
-		 * streams are updated, and the device controller will not be
-		 * triggered to generate ERDY to move the next stream data. To
-		 * workaround this and maintain compatibility with various
-		 * hosts, force to reinitiate the stream until the host is ready
-		 * instead of waiting for the host to prime the endpoint.
-		 */
-		if (DWC3_VER_IS_WITHIN(DWC32, 100A, ANY)) {
-			unsigned int cmd = DWC3_DGCMD_SET_ENDPOINT_PRIME;
-
-			dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
-		} else {
-			dep->flags |= DWC3_EP_DELAY_START;
-			dwc3_stop_active_transfer(dep, true, true);
-			return;
-		}
+		dep->flags &= ~DWC3_EP_STREAM_PRIMED;
+		if (dep->flags & DWC3_EP_FORCE_RESTART_STREAM)
+			queue_delayed_work(system_wq, &dep->nostream_work,
+					   msecs_to_jiffies(100));
 		break;
 	}
-
-out:
-	dep->flags &= ~DWC3_EP_IGNORE_NEXT_NOSTREAM;
 }
 
 static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
@@ -4049,7 +4080,7 @@
 }
 
 void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
-	bool interrupt)
+	bool clear_index, bool interrupt)
 {
 	struct dwc3 *dwc = dep->dwc;
 
@@ -4112,7 +4143,7 @@
 	 * remove requests attempts to unmap USB request buffers.
 	 */
 
-	__dwc3_stop_active_transfer(dep, force, interrupt);
+	__dwc3_stop_active_transfer(dep, force, clear_index, interrupt);
 }
 
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
@@ -4187,6 +4218,10 @@
 
 	dwc->suspended = false;
 
+	/* The controller is recovered. */
+	if (dwc->err_state == DWC3_ERR_NONE)
+		dwc->err_recovery_count = 0;
+
 	/*
 	 * Ideally, dwc3_reset_gadget() would trigger the function
 	 * drivers to stop any active transfers through ep disable.
@@ -4764,6 +4799,12 @@
 	return ret;
 }
 
+static void dwc3_schedule_err_recovery(struct dwc3 *dwc)
+{
+	dwc->err_state = DWC3_ERR_RECOVERY;
+	schedule_work(&dwc->err_recovery_work);
+}
+
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
@@ -4801,9 +4842,21 @@
 		return IRQ_NONE;
 
 	if (count > evt->length) {
-		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+		dev_err(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
 			count, evt->length);
-		return IRQ_NONE;
+		/*
+		 * This is a fatal error - the driver and controller are out of
+		 * sync on which event has been consumed. Reinitializing the
+		 * controller is required to recover. Write the bogus count back
+		 * to GEVNTCOUNT to clear the IRQ source, consistent with the
+		 * stale event clearing in dwc3_event_buffers_setup(), then
+		 * schedule error recovery.
+		 */
+		spin_lock(&dwc->lock);
+		dwc3_schedule_err_recovery(dwc);
+		spin_unlock(&dwc->lock);
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+		return IRQ_HANDLED;
 	}
 
 	evt->count = count;
@@ -4876,6 +4929,57 @@
 	kfree(gadget);
 }
 
+static void dwc3_err_recovery_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, err_recovery_work);
+	unsigned long flags;
+	int ret;
+
+	/* serializes against dwc3_gadget_pullup() */
+	mutex_lock(&dwc->connect_mutex);
+
+	ret = dwc3_gadget_soft_disconnect(dwc);
+
+	dwc3_disconnect_gadget_sleepable(dwc);
+
+	if (ret)
+		goto err_unrecoverable;
+
+	if (dwc->softconnect) {
+		u32 count;
+		/*
+		 * Wait irq to finish before soft_connect resets evt->lpos and
+		 * the event buffer registers to avoid racing with
+		 * dwc3_process_event_buf().
+		 */
+		synchronize_irq(dwc->irq_gadget);
+
+		spin_lock_irqsave(&dwc->lock, flags);
+		count = ++dwc->err_recovery_count;
+		spin_unlock_irqrestore(&dwc->lock, flags);
+
+		if (count > DWC3_ERR_RECOVERY_MAX)
+			goto err_unrecoverable;
+
+		ret = dwc3_gadget_soft_connect(dwc);
+		if (ret)
+			goto err_unrecoverable;
+	}
+	mutex_unlock(&dwc->connect_mutex);
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_NONE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	return;
+
+err_unrecoverable:
+	dev_err(dwc->dev, "Unable to recover the controller\n");
+	mutex_unlock(&dwc->connect_mutex);
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->err_state = DWC3_ERR_UNRECOVERABLE;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4932,6 +5036,8 @@
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	INIT_WORK(&dwc->err_recovery_work, dwc3_err_recovery_work);
+	mutex_init(&dwc->connect_mutex);
 	dwc->gadget = kzalloc(sizeof(struct usb_gadget), GFP_KERNEL);
 	if (!dwc->gadget) {
 		ret = -ENOMEM;
@@ -5047,6 +5153,8 @@
 	if (!dwc->gadget)
 		return;
 
+	cancel_work_sync(&dwc->err_recovery_work);
+	mutex_destroy(&dwc->connect_mutex);
 	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
EOT
```

```console
shell$ patch drivers/usb/dwc3/gadget_hibernation.c << 'EOT'
--- drivers/usb/dwc3/gadget_hibernation.c	2026-10-24 06:13:57.467442247 +0900
+++ drivers/usb/dwc3/gadget_hibernation.c	2026-10-24 07:29:18.808468406 +0900
@@ -319,7 +319,7 @@
 			continue;
 
 		if (dep->flags & DWC3_EP_TRANSFER_STARTED)
-			dwc3_stop_active_transfer(dep, false, true);
+			dwc3_stop_active_transfer(dep, false, false, true);
 
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 
EOT
```

```console
shell$ git add --all
shell$ git commit -m '[patch] 262_drivers-usb-dwc3.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/262_drivers-usb-dwc3.patch
```

##### 264_drivers-usb-host.patch

###### drivers/usb/host/xhci.h

```console
shell$ diff -p linux-6.12.109/drivers/usb/host/xhci.h linux-6.12.113/drivers/usb/host/xhci.h
*** linux-6.12.109/drivers/usb/host/xhci.h	2026-10-09 15:27:33.367051511 +0900
--- linux-6.12.113/drivers/usb/host/xhci.h	2026-10-23 13:59:45.897311170 +0900
*************** struct xhci_cap_regs {
*** 66,79 ****
  	/* Reserved up to (CAPLENGTH - 0x1C) */
  };
  
- /* Number of registers per port */
- #define	NUM_PORT_REGS	4
- 
  #define PORTSC		0
  #define PORTPMSC	1
  #define PORTLI		2
  #define PORTHLPMC	3
  
  /**
   * struct xhci_op_regs - xHCI Host Controller Operational Registers.
   * @command:		USBCMD - xHC command register
--- 66,90 ----
  	/* Reserved up to (CAPLENGTH - 0x1C) */
  };
  
  #define PORTSC		0
  #define PORTPMSC	1
  #define PORTLI		2
  #define PORTHLPMC	3
  
+ /*
+  * struct xhci_port_regs - Host Controller USB Port Register Set. xHCI spec 5.4.8
+  * @portsc:	Port Status and Control
+  * @portpmsc:	Port Power Management Status and Control
+  * @portli:	Port Link Info
+  * @porthlmpc:	Port Hardware LPM Control
+  */
+ struct xhci_port_regs {
+ 	__le32	portsc;
+ 	__le32	portpmsc;
+ 	__le32	portli;
+ 	__le32	porthlmpc;
+ };
+ 
  /**
   * struct xhci_op_regs - xHCI Host Controller Operational Registers.
   * @command:		USBCMD - xHC command register
*************** struct xhci_cap_regs {
*** 85,100 ****
   * @cmd_ring:		CRP - 64-bit Command Ring Pointer
   * @dcbaa_ptr:		DCBAAP - 64-bit Device Context Base Address Array Pointer
   * @config_reg:		CONFIG - Configure Register
!  * @port_status_base:	PORTSCn - base address for Port Status and Control
!  * 			Each port has a Port Status and Control register,
!  * 			followed by a Port Power Management Status and Control
!  * 			register, a Port Link Info register, and a reserved
!  * 			register.
!  * @port_power_base:	PORTPMSCn - base address for
!  * 			Port Power Management Status and Control
!  * @port_link_base:	PORTLIn - base address for Port Link Info (current
!  * 			Link PM state and control) for USB 2.1 and USB 3.0
!  * 			devices.
   */
  struct xhci_op_regs {
  	__le32	command;
--- 96,102 ----
   * @cmd_ring:		CRP - 64-bit Command Ring Pointer
   * @dcbaa_ptr:		DCBAAP - 64-bit Device Context Base Address Array Pointer
   * @config_reg:		CONFIG - Configure Register
!  * @port_regs:		Port Register Sets, from 1 to MaxPorts (defined by HCSPARAMS1).
   */
  struct xhci_op_regs {
  	__le32	command;
*************** struct xhci_op_regs {
*** 110,122 ****
  	__le32	config_reg;
  	/* rsvd: offset 0x3C-3FF */
  	__le32	reserved4[241];
! 	/* port 1 registers, which serve as a base address for other ports */
! 	__le32	port_status_base;
! 	__le32	port_power_base;
! 	__le32	port_link_base;
! 	__le32	reserved5;
! 	/* registers for ports 2-255 */
! 	__le32	reserved6[NUM_PORT_REGS*254];
  };
  
  /* USBCMD - USB command - command bitmasks */
--- 112,118 ----
  	__le32	config_reg;
  	/* rsvd: offset 0x3C-3FF */
  	__le32	reserved4[241];
! 	struct xhci_port_regs port_regs[];
  };
  
  /* USBCMD - USB command - command bitmasks */
*************** struct xhci_hcd {
*** 1496,1502 ****
  	struct xhci_doorbell_array __iomem *dba;
  
  	/* Cached register copies of read-only HC data */
- 	__u32		hcs_params1;
  	__u32		hcs_params2;
  	__u32		hcs_params3;
  	__u32		hcc_params;
--- 1492,1497 ----
*************** struct xhci_hcd {
*** 1507,1512 ****
--- 1502,1509 ----
  	/* packed release number */
  	u16		hci_version;
  	u16		max_interrupters;
+ 	u8		max_slots;
+ 	u8		max_ports;
  	/* imod_interval in ns (I * 250ns) */
  	u32		imod_interval;
  	u32		page_size;
```

###### Make 264_drivers-usb-host.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci.c
patching file drivers/usb/host/xhci.h
Hunk #1 succeeded at 1847 (offset -3 lines).
```

```console
shell$ rm drivers/usb/host/xhci.h.orig
shell$ git add --all
shell$ git commit -m '[patch] 264_drivers-usb-host.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/264_drivers-usb-host.patch
```

##### 301_sound-soc-xilinx.patch

###### sound/soc/xilinx/xlnx_formatter_pcm.c

```console
shell$ diff -p linux-6.12.109/sound/soc/xilinx/xlnx_formatter_pcm.c linux-6.12.113/sound/soc/xilinx/xlnx_formatter_pcm.c
*** linux-6.12.109/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-09 15:27:34.279525563 +0900
--- linux-6.12.113/sound/soc/xilinx/xlnx_formatter_pcm.c	2026-10-23 13:59:47.001862719 +0900
*************** static int xlnx_formatter_pcm_open(struc
*** 384,390 ****
  	if (err) {
  		dev_err(component->dev,
  			"Unable to set constraint on period bytes\n");
! 		return err;
  	}
  
  	/* Resize the buffer bytes as divisible by 64 */
--- 384,390 ----
  	if (err) {
  		dev_err(component->dev,
  			"Unable to set constraint on period bytes\n");
! 		goto error;
  	}
  
  	/* Resize the buffer bytes as divisible by 64 */
*************** static int xlnx_formatter_pcm_open(struc
*** 394,400 ****
  	if (err) {
  		dev_err(component->dev,
  			"Unable to set constraint on buffer bytes\n");
! 		return err;
  	}
  
  	/* Set periods as integer multiple */
--- 394,400 ----
  	if (err) {
  		dev_err(component->dev,
  			"Unable to set constraint on buffer bytes\n");
! 		goto error;
  	}
  
  	/* Set periods as integer multiple */
*************** static int xlnx_formatter_pcm_open(struc
*** 403,409 ****
  	if (err < 0) {
  		dev_err(component->dev,
  			"Unable to set constraint on periods to be integer\n");
! 		return err;
  	}
  
  	/* enable DMA IOC irq */
--- 403,409 ----
  	if (err < 0) {
  		dev_err(component->dev,
  			"Unable to set constraint on periods to be integer\n");
! 		goto error;
  	}
  
  	/* enable DMA IOC irq */
*************** static int xlnx_formatter_pcm_open(struc
*** 412,417 ****
--- 412,425 ----
  	writel(val, stream_data->mmio + XLNX_AUD_CTRL);
  
  	return 0;
+ 
+ error:
+ 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+ 		adata->play_stream = NULL;
+ 	else
+ 		adata->capture_stream = NULL;
+ 	kfree(stream_data);
+ 	return err;
  }
  
  static int xlnx_formatter_pcm_close(struct snd_soc_component *component,
```

###### Make 301_sound-soc-xilinx.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/301_sound-soc-xilinx.patch
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
Hunk #11 succeeded at 425 with fuzz 1.
Hunk #12 succeeded at 447 (offset 8 lines).
Hunk #13 succeeded at 470 (offset 8 lines).
Hunk #14 succeeded at 482 (offset 8 lines).
Hunk #15 succeeded at 515 (offset 8 lines).
Hunk #16 succeeded at 536 (offset 8 lines).
Hunk #17 succeeded at 566 (offset 8 lines).
Hunk #18 succeeded at 604 (offset 8 lines).
Hunk #19 succeeded at 623 (offset 8 lines).
Hunk #20 succeeded at 763 (offset 8 lines).
Hunk #21 succeeded at 801 (offset 8 lines).
Hunk #22 succeeded at 825 (offset 8 lines).
Hunk #23 succeeded at 836 (offset 8 lines).
patching file sound/soc/xilinx/xlnx_i2s.c
patching file sound/soc/xilinx/xlnx_pl_snd_card.c
patching file sound/soc/xilinx/xlnx_sdi_audio.c
patching file sound/soc/xilinx/xlnx_snd_common.h
patching file sound/soc/xilinx/xlnx_spdif.c
```

```console
shell$ rm sound/soc/xilinx/xlnx_formatter_pcm.c.orig
shell$ git add --all
shell$ git commit -m '[patch] 301_sound-soc-xilinx.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/301_sound-soc-xilinx.patch
```

##### 999_other-document.patch

###### MAINTAINERS

###### Make 999_other-document.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/999_other-document.patch
Hunk #6 succeeded at 19816 (offset 1 line).
Hunk #7 succeeded at 21139 (offset 1 line).
Hunk #8 succeeded at 23847 (offset 1 line).
Hunk #9 succeeded at 24243 (offset 1 line).
Hunk #10 succeeded at 24270 (offset 1 line).
Hunk #11 succeeded at 25481 (offset 1 line).
Hunk #12 succeeded at 25543 (offset 1 line).
Hunk #13 succeeded at 25623 (offset 1 line).
Hunk #14 succeeded at 25731 (offset 1 line).
Hunk #15 succeeded at 25844 (offset 1 line).
Hunk #16 succeeded at 25880 (offset 1 line).
Hunk #17 succeeded at 25910 (offset 1 line).
```

```console
shell$ rm MAINTAINERS.orig
shell$ git add --all
shell$ git commit -m '[patch] 999_other-document.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/999_other-document.patch
```

##### 226_drivers-misc-fix.patch

###### Make 226_drivers-misc-fix.patch

```console
shell$ cd linux-6.12.113-xlnx-v2025.1
shell$ git checkout linux-6.12.113-xlnx-v2025.1-2
shell$ patch -p1 < ../patches/linux-6.12.109-xlnx-v2025.1/226_drivers-misc-fix.patch
patching file include/linux/xlnx-ai-engine.h
patching file include/uapi/linux/xlnx-ai-engine.h
```

```console
shell$ git add --all
shell$ git commit -m '[patch] 226_drivers-misc-fix.patch'
shell$ git diff HEAD^ > ../patches/linux-6.12.113-xlnx-v2025.1/226_drivers-misc-fix.patch
```