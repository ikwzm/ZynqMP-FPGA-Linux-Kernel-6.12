Make ./paches/linux-6.12.42-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.27

```console
shell$ git clone --depth 1 -b v6.12.19 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.27
```

### Get linux-6.12.27-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.27 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.27-xlnx-v2025.1
shell$ cd linux-6.12.27-xlnx-v2025.1
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/origin_patch.sh
shell$ cd
```

### Get linux-6.12.42

```console
shell$ git clone --depth 1 -b v6.12.42 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.42
```

### Make diff-linux-xlnx-6.12.27-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.27-xlnx-v2025.1 -A linux-6.12.27 -B linux-6.12.27-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.27-xlnx-v2025.1.txt linux-6.12.27 linux-6.12.27-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.27-xlnx-v2025.1
## A   : {name: linux-6.12.27, path: linux-6.12.27}
## B   : {name: linux-6.12.27-xlnx-v2025.1, path: linux-6.12.27-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.27-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.27-6.12.42.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.27-6.12.42 -A linux-6.12.27 -B linux-6.12.42 -o ./make-patches/diff-linux-6.12.27-6.12.42.txt linux-6.12.27 linux-6.12.42 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.27-6.12.42
## A   : {name: linux-6.12.27, path: linux-6.12.27}
## B   : {name: linux-6.12.42, path: linux-6.12.42}
## OUT : ./make-patches/diff-linux-6.12.27-6.12.42.txt
```

### Compare diff-linux-6.12.27-6.12.42.txt and diff-linux-xlnx-6.12.27-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.27-6.12.42.txt make-patches/diff-linux-6.12.27-xlnx-v2025.1.txt 
contents: 
 - U: MAINTAINERS
 - U: arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
 - U: arch/arm64/configs/defconfig
 - U: arch/arm64/xen/hypercall.S
 - U: drivers/clk/xilinx/xlnx_vcu.c
 - U: drivers/crypto/xilinx/zynqmp-sha.c
 - D: drivers/firmware/xilinx/zynqmp.c
 - U: drivers/gpu/drm/drm_edid.c
 - U: drivers/gpu/drm/drm_fbdev_dma.c
 - U: drivers/gpu/drm/drm_framebuffer.c
 - U: drivers/gpu/drm/panel/panel-simple.c
 - U: drivers/iio/adc/Kconfig
 - U: drivers/irqchip/Kconfig
 - U: drivers/mtd/spi-nor/spansion.c
 - U: drivers/net/ethernet/cadence/macb_main.c
 - U: drivers/net/ethernet/xilinx/xilinx_axienet_main.c
 - U: drivers/net/ethernet/xilinx/xilinx_emaclite.c
 - U: drivers/net/phy/phylink.c
 - U: drivers/remoteproc/xlnx_r5_remoteproc.c
 - U: drivers/spi/spi-cadence-quadspi.c
 - U: drivers/spi/spi-zynqmp-gqspi.c
 - U: drivers/spi/spi.c
 - U: drivers/ufs/core/ufshcd.c
 - U: drivers/usb/dwc3/core.c
 - U: drivers/usb/dwc3/core.h
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/gadget/function/f_tcm.c
 - U: drivers/usb/host/xhci-plat.c
 - U: drivers/usb/host/xhci.c
 - U: drivers/usb/host/xhci.h
 - U: drivers/usb/misc/onboard_usb_dev.c
 - U: drivers/virtio/virtio_ring.c
 - U: include/linux/phy.h
 - U: include/linux/spi/spi.h
```

### Make linux-6.12.42-xlnx-v2025.1

#### xxx_update.sh

```console
shell$ git clone --depth 1 -b v6.12.42 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.42-xlnx-v2025.1
shell$ cd linux-6.12.42-xlnx-v2025.1
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-1
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/020_arch-arm64.patch
  :
patching file arch/arm64/xen/hypercall.S
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/arm64/xen/hypercall.S.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
  :
patching file arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/102_crypto.patch
## not found /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/103_fs-nfsd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/202_drivers-clk.patch
  :
patching file drivers/clk/xilinx/xlnx_vcu.c
Hunk #5 FAILED at 639.
1 out of 8 hunks FAILED -- saving rejects to file drivers/clk/xilinx/xlnx_vcu.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/204_drivers-crypto.patch
  :
patching file drivers/crypto/xilinx/zynqmp-sha.c
Hunk #1 FAILED at 2.
Hunk #2 succeeded at 18 with fuzz 1 (offset 1 line).
Hunk #3 FAILED at 32.
Hunk #4 succeeded at 242 (offset 10 lines).
Hunk #5 succeeded at 293 (offset 10 lines).
2 out of 5 hunks FAILED -- saving rejects to file drivers/crypto/xilinx/zynqmp-sha.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/207_drivers-firmware.patch
  :
patching file drivers/firmware/xilinx/zynqmp-pm.c (renamed from drivers/firmware/xilinx/zynqmp.c)
Hunk #11 FAILED at 584.
Hunk #12 succeeded at 780 (offset -4 lines).
Hunk #13 succeeded at 856 (offset -4 lines).
Hunk #14 succeeded at 985 (offset -4 lines).
Hunk #15 succeeded at 1079 (offset -4 lines).
Hunk #16 succeeded at 1138 (offset -4 lines).
Hunk #17 succeeded at 1579 (offset -4 lines).
Hunk #18 succeeded at 1627 (offset -4 lines).
1 out of 18 hunks FAILED -- saving rejects to file drivers/firmware/xilinx/zynqmp-pm.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/227_drivers-mmc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch
  :
patching file drivers/mtd/spi-nor/spansion.c
Hunk #1 succeeded at 34 (offset 1 line).
Hunk #2 succeeded at 89 (offset 8 lines).
Hunk #3 succeeded at 110 (offset 8 lines).
Hunk #4 succeeded at 153 (offset 8 lines).
Hunk #5 succeeded at 172 (offset 8 lines).
Hunk #6 succeeded at 203 (offset 8 lines).
Hunk #7 succeeded at 218 (offset 8 lines).
Hunk #8 succeeded at 268 (offset 8 lines).
Hunk #9 succeeded at 295 (offset 8 lines).
Hunk #10 succeeded at 355 (offset 8 lines).
Hunk #11 succeeded at 448 (offset 22 lines).
Hunk #12 succeeded at 490 (offset 22 lines).
Hunk #13 succeeded at 508 (offset 22 lines).
Hunk #14 succeeded at 538 (offset 22 lines).
Hunk #15 succeeded at 614 (offset 25 lines).
Hunk #16 succeeded at 630 (offset 25 lines).
Hunk #17 FAILED at 647.
Hunk #18 succeeded at 724 (offset 28 lines).
Hunk #19 succeeded at 759 (offset 28 lines).
Hunk #20 succeeded at 811 (offset 31 lines).
Hunk #21 succeeded at 820 (offset 31 lines).
Hunk #22 succeeded at 902 (offset 31 lines).
Hunk #23 succeeded at 916 (offset 31 lines).
Hunk #24 succeeded at 930 (offset 31 lines).
Hunk #25 succeeded at 955 (offset 31 lines).
Hunk #26 succeeded at 969 (offset 31 lines).
Hunk #27 succeeded at 1014 (offset 31 lines).
Hunk #28 succeeded at 1050 (offset 31 lines).
Hunk #29 succeeded at 1071 (offset 31 lines).
Hunk #30 succeeded at 1102 (offset 31 lines).
Hunk #31 succeeded at 1168 (offset 31 lines).
1 out of 31 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/spansion.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/247_drivers-spi.patch
  :
patching file drivers/spi/spi-zynqmp-gqspi.c
Hunk #8 FAILED at 883.
Hunk #9 succeeded at 915 (offset -4 lines).
Hunk #10 succeeded at 1045 (offset -4 lines).
Hunk #11 succeeded at 1080 (offset -4 lines).
Hunk #12 succeeded at 1099 (offset -4 lines).
Hunk #13 succeeded at 1146 (offset -4 lines).
Hunk #14 succeeded at 1168 (offset -4 lines).
Hunk #15 succeeded at 1196 (offset -4 lines).
Hunk #16 succeeded at 1235 (offset -4 lines).
Hunk #17 succeeded at 1286 (offset -4 lines).
Hunk #18 succeeded at 1321 (offset -4 lines).
Hunk #19 succeeded at 1416 (offset -4 lines).
Hunk #20 succeeded at 1467 (offset -4 lines).
1 out of 20 hunks FAILED -- saving rejects to file drivers/spi/spi-zynqmp-gqspi.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch
  :
patching file drivers/usb/dwc3/core.h
Hunk #11 FAILED at 1186.
Hunk #12 succeeded at 1249 (offset 3 lines).
Hunk #13 succeeded at 1262 (offset 3 lines).
Hunk #14 succeeded at 1340 (offset 3 lines).
Hunk #15 succeeded at 1366 (offset 3 lines).
Hunk #16 succeeded at 1381 (offset 3 lines).
Hunk #17 succeeded at 1407 (offset 3 lines).
Hunk #18 FAILED at 1423.
Hunk #19 succeeded at 1595 (offset 4 lines).
Hunk #20 succeeded at 1643 (offset 4 lines).
Hunk #21 succeeded at 1672 (offset 4 lines).
Hunk #22 succeeded at 1695 (offset 4 lines).
Hunk #23 succeeded at 1721 (offset 4 lines).
Hunk #24 succeeded at 1753 (offset 4 lines).
2 out of 24 hunks FAILED -- saving rejects to file drivers/usb/dwc3/core.h.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch
  :
patching file drivers/usb/host/xhci.c
Hunk #1 succeeded at 189 (offset -23 lines).
Hunk #2 FAILED at 230.
1 out of 2 hunks FAILED -- saving rejects to file drivers/usb/host/xhci.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/265_drivers-usb-misc.patch
  :
patching file drivers/usb/misc/onboard_usb_dev.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
3 out of 3 hunks ignored -- saving rejects to file drivers/usb/misc/onboard_usb_dev.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/999_other-document.patch
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/020_arch-arm64.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-020_arch-arm64
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-020_arch-arm64.sh
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/020_arch-arm64.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/020_arch-arm64.patch
patching file Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
patching file arch/arm64/kernel/irq.c
patching file arch/arm64/xen/hypercall.S
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/arm64/xen/hypercall.S.rej
```

```console
shell$ diff ../linux-6.12.42/arch/arm64/xen/hypercall.S ../linux-6.12.27-xlnx-v2025.1/arch/arm64/xen/hypercall.S
```

```console
shell$ diff ../linux-6.12.27/arch/arm64/xen/hypercall.S ../linux-6.12.27-xlnx-v2025.1/arch/arm64/xen/hypercall.S 
86c86,105
< HYPERCALL3(dm_op);
---
> 
> SYM_FUNC_START(HYPERVISOR_dm_op)
> 	mov x16, #__HYPERVISOR_dm_op;	\
> 	/*
> 	 * dm_op hypercalls are issued by the userspace. The kernel needs to
> 	 * enable access to TTBR0_EL1 as the hypervisor would issue stage 1
> 	 * translations to user memory via AT instructions. Since AT
> 	 * instructions are not affected by the PAN bit (ARMv8.1), we only
> 	 * need the explicit uaccess_enable/disable if the TTBR0 PAN emulation
> 	 * is enabled (it implies that hardware UAO and PAN disabled).
> 	 */
> 	uaccess_ttbr0_enable x6, x7, x8
> 	hvc XEN_IMM
> 
> 	/*
> 	 * Disable userspace access from kernel once the hyp call completed.
> 	 */
> 	uaccess_ttbr0_disable x6, x7
> 	ret
> SYM_FUNC_END(HYPERVISOR_dm_op);

```

```console
shell$ rm arch/arm64/xen/hypercall.S.rej
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 020_arch-arm64.patch"
[linux-6.12.42-xlnx-v2025.1-020_arch-arm64 22b0de165] [patch] 020_arch-arm64.patch
 2 files changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/zynq/zynq-efuse.txt
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/020_arch-arm64.patch
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/022_arch-arm64-boot-dts.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-022_arch-arm64-boot-dts
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-022_arch-arm64-boot-dts.sh
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
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
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi.rej
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
```

```console
shell$	diff ../linux-6.12.42/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi ../linux-6.12.27-xlnx-v2025.1/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
205a206,221
> &perf_monitor_ocm {
> 	clocks = <&zynqmp_clk LPD_LSBUS>;
> };
> 
> &perf_monitor_ddr {
> 	clocks = <&zynqmp_clk TOPSW_LSBUS>;
> };
> 
> &perf_monitor_cci {
> 	clocks = <&zynqmp_clk TOPSW_LSBUS>;
> };
> 
> &perf_monitor_lpd {
> 	clocks = <&zynqmp_clk LPD_LSBUS>;
> };
> 
```

```console
shell$ diff ../linux-6.12.27/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi ../linux-6.12.27-xlnx-v2025.1/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
13c13
< 	pss_ref_clk: pss_ref_clk {
---
> 	pss_ref_clk: pss-ref-clk {
17a18
> 		clock-output-names = "pss_ref_clk";
20c21
< 	video_clk: video_clk {
---
> 	video_clk: video-clk {
24a26
> 		clock-output-names = "video_clk";
27c29
< 	pss_alt_ref_clk: pss_alt_ref_clk {
---
> 	pss_alt_ref_clk: pss-alt-ref-clk {
31a34
> 		clock-output-names = "pss_alt_ref_clk";
34c37
< 	gt_crx_ref_clk: gt_crx_ref_clk {
---
> 	gt_crx_ref_clk: gt-crx-ref-clk {
38a42
> 		clock-output-names = "gt_crx_ref_clk";
41c45
< 	aux_ref_clk: aux_ref_clk {
---
> 	aux_ref_clk: aux-ref-clk {
45a50
> 		clock-output-names = "aux_ref_clk";
198a204,219
> };
> 
> &perf_monitor_ocm {
> 	clocks = <&zynqmp_clk LPD_LSBUS>;
> };
> 
> &perf_monitor_ddr {
> 	clocks = <&zynqmp_clk TOPSW_LSBUS>;
> };
> 
> &perf_monitor_cci {
> 	clocks = <&zynqmp_clk TOPSW_LSBUS>;
> };
> 
> &perf_monitor_lpd {
> 	clocks = <&zynqmp_clk LPD_LSBUS>;
```

```console
shell$ diff ../linux-6.12.27/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi ../linux-6.12.42/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
13c13
< 	pss_ref_clk: pss_ref_clk {
---
> 	pss_ref_clk: pss-ref-clk {
17a18
> 		clock-output-names = "pss_ref_clk";
20c21
< 	video_clk: video_clk {
---
> 	video_clk: video-clk {
24a26
> 		clock-output-names = "video_clk";
27c29
< 	pss_alt_ref_clk: pss_alt_ref_clk {
---
> 	pss_alt_ref_clk: pss-alt-ref-clk {
31a34
> 		clock-output-names = "pss_alt_ref_clk";
34c37
< 	gt_crx_ref_clk: gt_crx_ref_clk {
---
> 	gt_crx_ref_clk: gt-crx-ref-clk {
38a42
> 		clock-output-names = "gt_crx_ref_clk";
41c45
< 	aux_ref_clk: aux_ref_clk {
---
> 	aux_ref_clk: aux-ref-clk {
45a50
> 		clock-output-names = "aux_ref_clk";
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
shell$ rm arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi.rej
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 022_arch-arm64-boot-dts.patch 
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/022_arch-arm64-boot-dts.patch 
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/202_drivers-clk.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-202_drivers-clk.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-202_drivers-clk.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/202_drivers-clk.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/202_drivers-clk.patch
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
Hunk #5 FAILED at 639.
1 out of 8 hunks FAILED -- saving rejects to file drivers/clk/xilinx/xlnx_vcu.c.rej
patching file drivers/clk/zynqmp/clkc.c
```

```console
shell$ diff ../linux-6.12.27/drivers/clk/xilinx/xlnx_vcu.c ../linux-6.12.27-xlnx-v2025.1/drivers/clk/xilinx/xlnx_vcu.c
13a14
> #include <linux/gpio/consumer.h>
18a20
> #include <linux/of_platform.h>
49,70d50
< /**
<  * struct xvcu_device - Xilinx VCU init device structure
<  * @dev: Platform device
<  * @pll_ref: pll ref clock source
<  * @aclk: axi clock source
<  * @logicore_reg_ba: logicore reg base address
<  * @vcu_slcr_ba: vcu_slcr Register base address
<  * @pll: handle for the VCU PLL
<  * @pll_post: handle for the VCU PLL post divider
<  * @clk_data: clocks provided by the vcu clock provider
<  */
< struct xvcu_device {
< 	struct device *dev;
< 	struct clk *pll_ref;
< 	struct clk *aclk;
< 	struct regmap *logicore_reg_ba;
< 	void __iomem *vcu_slcr_ba;
< 	struct clk_hw *pll;
< 	struct clk_hw *pll_post;
< 	struct clk_hw_onecell_data *clk_data;
< };
< 
225a206,277
> /**
>  * xvcu_get_color_depth - read the color depth register
>  * @xvcu:	Pointer to the xvcu_device structure
>  *
>  * Return:	Returns 32bit value
>  *
>  */
> u32 xvcu_get_color_depth(struct xvcu_device *xvcu)
> {
> 	u32 value;
> 
> 	if (!regmap_read(xvcu->logicore_reg_ba, VCU_ENC_COLOR_DEPTH, &value))
> 		return value;
> 	else
> 		return 0;
> }
> EXPORT_SYMBOL_GPL(xvcu_get_color_depth);
> 
> /**
>  * xvcu_get_memory_depth - read the memory depth register
>  * @xvcu:	Pointer to the xvcu_device structure
>  *
>  * Return:	Returns 32bit value
>  *
>  */
> u32 xvcu_get_memory_depth(struct xvcu_device *xvcu)
> {
> 	u32 value;
> 
> 	if (!regmap_read(xvcu->logicore_reg_ba, VCU_MEMORY_DEPTH, &value))
> 		return value;
> 	else
> 		return 0;
> }
> EXPORT_SYMBOL_GPL(xvcu_get_memory_depth);
> 
> /**
>  * xvcu_get_clock_frequency - provide the core clock frequency
>  * @xvcu:	Pointer to the xvcu_device structure
>  *
>  * Return:	Returns 32bit value
>  *
>  */
> u32 xvcu_get_clock_frequency(struct xvcu_device *xvcu)
> {
> 	u32 value;
> 
> 	if (!regmap_read(xvcu->logicore_reg_ba, VCU_CORE_CLK, &value))
> 		return value * MHZ;
> 	else
> 		return 0;
> }
> EXPORT_SYMBOL_GPL(xvcu_get_clock_frequency);
> 
> /**
>  * xvcu_get_num_cores - read the number of core register
>  * @xvcu:	Pointer to the xvcu_device structure
>  *
>  * Return:	Returns 32bit value
>  *
>  */
> u32 xvcu_get_num_cores(struct xvcu_device *xvcu)
> {
> 	u32 value;
> 
> 	if (!regmap_read(xvcu->logicore_reg_ba, VCU_NUM_CORE, &value))
> 		return value;
> 	else
> 		return 0;
> }
> EXPORT_SYMBOL_GPL(xvcu_get_num_cores);
> 
550c602
< 	parent_data[0].fw_name = "pll_ref";
---
> 	parent_data[0].fw_name = "dummy_name";
590,591c642,643
< 
< 	clk_hw_unregister_fixed_factor(xvcu->pll_post);
---
> 	if (!IS_ERR_OR_NULL(xvcu->pll_post))
> 		clk_hw_unregister_fixed_factor(xvcu->pll_post);
678a731,748
> 	xvcu->reset_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> 						   GPIOD_OUT_LOW);
> 	if (IS_ERR(xvcu->reset_gpio)) {
> 		ret = PTR_ERR(xvcu->reset_gpio);
> 		dev_err(&pdev->dev, "failed to get reset gpio for vcu.\n");
> 		goto error_get_gpio;
> 	}
> 
> 	if (xvcu->reset_gpio) {
> 		gpiod_set_value(xvcu->reset_gpio, 0);
> 		/* min 2 clock cycle of vcu pll_ref, slowest freq is 33.33KHz */
> 		usleep_range(60, 120);
> 		gpiod_set_value(xvcu->reset_gpio, 1);
> 		usleep_range(60, 120);
> 	} else {
> 		dev_warn(&pdev->dev, "No reset gpio info from dts for vcu. This may lead to incorrect functionality if VCU isolation is removed post initialization.\n");
> 	}
> 
688a759,764
> 	ret = devm_of_platform_populate(&pdev->dev);
> 	if (ret) {
> 		dev_err(&pdev->dev, "Failed to register allegro codecs\n");
> 		goto error_clk_provider;
> 	}
> 
692a769
> error_get_gpio:
713a791,797
> 	if (xvcu->reset_gpio) {
> 		gpiod_set_value(xvcu->reset_gpio, 0);
> 		/* min 2 clock cycle of vcu pll_ref, slowest freq is 33.33KHz */
> 		usleep_range(60, 120);
> 		gpiod_set_value(xvcu->reset_gpio, 1);
> 		usleep_range(60, 120);
> 	}
```

```console
shell$ diff ../linux-6.12.27/drivers/clk/xilinx/xlnx_vcu.c ../linux-6.12.42/drivers/clk/xilinx/xlnx_vcu.c
590,591c590,591
< 
< 	clk_hw_unregister_fixed_factor(xvcu->pll_post);
---
> 	if (!IS_ERR_OR_NULL(xvcu->pll_post))
> 		clk_hw_unregister_fixed_factor(xvcu->pll_post);
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/clk/xilinx/xlnx_vcu.c drivers/clk/xilinx/xlnx_vcu.c 
shell$ rm drivers/clk/xilinx/xlnx_vcu.c.rej
shell$ rm drivers/clk/xilinx/xlnx_vcu.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 202_drivers-clk"
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/202_drivers-clk.patch 
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/204_drivers-crypto.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-204_drivers-crypto.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-204_drivers-crypto.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/204_drivers-crypto.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/204_drivers-crypto.patch
patching file Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
patching file drivers/crypto/Kconfig
patching file drivers/crypto/xilinx/Makefile
patching file drivers/crypto/xilinx/xilinx-ecdsa.c
patching file drivers/crypto/xilinx/xilinx-rsa.c
patching file drivers/crypto/xilinx/xilinx_ecdsasig.asn1
patching file drivers/crypto/xilinx/zynqmp-aes-gcm.c
patching file drivers/crypto/xilinx/zynqmp-rsa.c
patching file drivers/crypto/xilinx/zynqmp-sha.c
Hunk #1 FAILED at 2.
Hunk #2 succeeded at 18 with fuzz 1 (offset 1 line).
Hunk #3 FAILED at 32.
Hunk #4 succeeded at 242 (offset 10 lines).
Hunk #5 succeeded at 293 (offset 10 lines).
2 out of 5 hunks FAILED -- saving rejects to file drivers/crypto/xilinx/zynqmp-sha.c.rej
patching file include/crypto/ecdsa.h
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/crypto/xilinx/zynqmp-sha.c drivers/crypto/xilinx/zynqmp-sha.c
shell$ rm drivers/crypto/xilinx/zynqmp-sha.c.rej 
shell$ rm drivers/crypto/xilinx/zynqmp-sha.c.orig 
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 204_drivers-crypto"
[linux-6.12.42-xlnx-v2025.1-204_drivers-crypto.patch 305298e8f] [patch] 204_drivers-crypto
 10 files changed, 2554 insertions(+), 429 deletions(-)
 create mode 100644 drivers/crypto/xilinx/xilinx-ecdsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx-rsa.c
 create mode 100644 drivers/crypto/xilinx/xilinx_ecdsasig.asn1
 create mode 100644 drivers/crypto/xilinx/zynqmp-rsa.c
 rewrite drivers/crypto/xilinx/zynqmp-sha.c (60%)
 create mode 100644 include/crypto/ecdsa.h
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/204_drivers-crypto.patch 
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/207_drivers-firmware.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-207_drivers-firmware.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-207_drivers-firmware.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/207_drivers-firmware.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/207_drivers-firmware.patch
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
Hunk #11 FAILED at 584.
Hunk #12 succeeded at 780 (offset -4 lines).
Hunk #13 succeeded at 856 (offset -4 lines).
Hunk #14 succeeded at 985 (offset -4 lines).
Hunk #15 succeeded at 1079 (offset -4 lines).
Hunk #16 succeeded at 1138 (offset -4 lines).
Hunk #17 succeeded at 1579 (offset -4 lines).
Hunk #18 succeeded at 1627 (offset -4 lines).
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
```

```console
shell$ diff ../linux-6.12.27/drivers/firmware/xilinx/zynqmp.c ../linux-6.12.42/drivers/firmware/xilinx/zynqmp.c 
1015d1014
< 	u32 buf, lower_addr, upper_addr;
1021,1023d1019
< 	lower_addr = lower_32_bits((u64)&buf);
< 	upper_addr = upper_32_bits((u64)&buf);
< 
1025c1021
< 				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, lower_addr, upper_addr,
---
> 				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET, 0, 0,
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/firmware/xilinx/zynqmp-pm.c   drivers/firmware/xilinx/zynqmp-pm.c 
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/firmware/xilinx/zynqmp-fpga.c drivers/firmware/xilinx/zynqmp-fpga.c 
shell$ rm drivers/firmware/xilinx/zynqmp-pm.c.rej
shell$ rm drivers/firmware/xilinx/zynqmp-pm.c.orig
shell$ rm drivers/firmware/xilinx/zynqmp.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 207_drivers-firmware"
[linux-6.12.42-xlnx-v2025.1-207_drivers-firmware.patch 8f8205cd4] [patch] 207_drivers-firmware
 22 files changed, 6777 insertions(+), 740 deletions(-)
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
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/207_drivers-firmware.patch 
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-228_drivers-mtd.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-228_drivers-mtd.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/228_drivers-mtd.patch
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
Hunk #1 succeeded at 34 (offset 1 line).
Hunk #2 succeeded at 89 (offset 8 lines).
Hunk #3 succeeded at 110 (offset 8 lines).
Hunk #4 succeeded at 153 (offset 8 lines).
Hunk #5 succeeded at 172 (offset 8 lines).
Hunk #6 succeeded at 203 (offset 8 lines).
Hunk #7 succeeded at 218 (offset 8 lines).
Hunk #8 succeeded at 268 (offset 8 lines).
Hunk #9 succeeded at 295 (offset 8 lines).
Hunk #10 succeeded at 355 (offset 8 lines).
Hunk #11 succeeded at 448 (offset 22 lines).
Hunk #12 succeeded at 490 (offset 22 lines).
Hunk #13 succeeded at 508 (offset 22 lines).
Hunk #14 succeeded at 538 (offset 22 lines).
Hunk #15 succeeded at 614 (offset 25 lines).
Hunk #16 succeeded at 630 (offset 25 lines).
Hunk #17 FAILED at 647.
Hunk #18 succeeded at 724 (offset 28 lines).
Hunk #19 succeeded at 759 (offset 28 lines).
Hunk #20 succeeded at 811 (offset 31 lines).
Hunk #21 succeeded at 820 (offset 31 lines).
Hunk #22 succeeded at 902 (offset 31 lines).
Hunk #23 succeeded at 916 (offset 31 lines).
Hunk #24 succeeded at 930 (offset 31 lines).
Hunk #25 succeeded at 955 (offset 31 lines).
Hunk #26 succeeded at 969 (offset 31 lines).
Hunk #27 succeeded at 1014 (offset 31 lines).
Hunk #28 succeeded at 1050 (offset 31 lines).
Hunk #29 succeeded at 1071 (offset 31 lines).
Hunk #30 succeeded at 1102 (offset 31 lines).
Hunk #31 succeeded at 1168 (offset 31 lines).
1 out of 31 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/spansion.c.rej
patching file drivers/mtd/spi-nor/sst.c
patching file drivers/mtd/spi-nor/swp.c
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
```

```console
shell$ diff -p ../linux-6.12.27/drivers/mtd/spi-nor/spansion.c ../linux-6.12.42/drivers/mtd/spi-nor/spansion.c
*** ../linux-6.12.27/drivers/mtd/spi-nor/spansion.c	2025-07-19 14:12:42.728143400 +0900
--- ../linux-6.12.42/drivers/mtd/spi-nor/spansion.c	2025-08-21 10:43:06.581991600 +0900
***************
*** 17,22 ****
--- 17,23 ----
  
  #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
  #define SPINOR_OP_CLPEF		0x82	/* Clear program/erase failure flags */
+ #define SPINOR_OP_CYPRESS_EX4B	0xB8	/* Exit 4-byte address mode */
  #define SPINOR_OP_CYPRESS_DIE_ERASE		0x61	/* Chip (die) erase */
  #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
  #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
***************
*** 58,63 ****
--- 59,71 ----
  		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
  		   SPI_MEM_OP_DATA_IN(1, buf, 0))
  
+ #define CYPRESS_NOR_EN4B_EX4B_OP(enable)				\
+ 	SPI_MEM_OP(SPI_MEM_OP_CMD(enable ? SPINOR_OP_EN4B :		\
+ 					   SPINOR_OP_CYPRESS_EX4B, 0),	\
+ 		   SPI_MEM_OP_NO_ADDR,					\
+ 		   SPI_MEM_OP_NO_DUMMY,					\
+ 		   SPI_MEM_OP_NO_DATA)
+ 
  #define SPANSION_OP(opcode)						\
  	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
  		   SPI_MEM_OP_NO_ADDR,					\
*************** static int cypress_nor_quad_enable_volat
*** 356,361 ****
--- 364,383 ----
  	return 0;
  }
  
+ static int cypress_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+ {
+ 	int ret;
+ 	struct spi_mem_op op = CYPRESS_NOR_EN4B_EX4B_OP(enable);
+ 
+ 	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+ 
+ 	ret = spi_mem_exec_op(nor->spimem, &op);
+ 	if (ret)
+ 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
+ 
+ 	return ret;
+ }
+ 
  /**
   * cypress_nor_determine_addr_mode_by_sr1() - Determine current address mode
   *                                            (3 or 4-byte) by querying status
*************** s25fs256t_post_bfpt_fixup(struct spi_nor
*** 526,531 ****
--- 548,556 ----
  	struct spi_mem_op op;
  	int ret;
  
+ 	/* Assign 4-byte address mode method that is not determined in BFPT */
+ 	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+ 
  	ret = cypress_nor_set_addr_mode_nbytes(nor);
  	if (ret)
  		return ret;
*************** s25hx_t_post_bfpt_fixup(struct spi_nor *
*** 591,596 ****
--- 616,624 ----
  {
  	int ret;
  
+ 	/* Assign 4-byte address mode method that is not determined in BFPT */
+ 	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+ 
  	ret = cypress_nor_set_addr_mode_nbytes(nor);
  	if (ret)
  		return ret;
*************** static int s28hx_t_post_bfpt_fixup(struc
*** 718,723 ****
--- 746,754 ----
  				   const struct sfdp_parameter_header *bfpt_header,
  				   const struct sfdp_bfpt *bfpt)
  {
+ 	/* Assign 4-byte address mode method that is not determined in BFPT */
+ 	nor->params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+ 
  	return cypress_nor_set_addr_mode_nbytes(nor);
  }
```

```console
shell$ rm drivers/mtd/spi-nor/spansion.c.orig
shell$ rm drivers/mtd/spi-nor/spansion.c.rej
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/mtd/spi-nor/spansion.c drivers/mtd/spi-nor/spansion.c
```

#### Modify drivers/mtd/spi-nor/spansion.c

```console
shell$ git diff
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 69ba7fd80..f1c8b4497 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -17,6 +17,7 @@
 
 #define SPINOR_OP_CLSR		0x30	/* Clear status register 1 */
 #define SPINOR_OP_CLPEF		0x82	/* Clear program/erase failure flags */
+#define SPINOR_OP_CYPRESS_EX4B	0xB8	/* Exit 4-byte address mode */
 #define SPINOR_OP_CYPRESS_DIE_ERASE		0x61	/* Chip (die) erase */
 #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
 #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */
@@ -60,6 +61,13 @@
 		   SPI_MEM_OP_DUMMY(ndummy, 0),				\
 		   SPI_MEM_OP_DATA_IN(1, buf, 0))
 
+#define CYPRESS_NOR_EN4B_EX4B_OP(enable)				\
+	SPI_MEM_OP(SPI_MEM_OP_CMD(enable ? SPINOR_OP_EN4B :		\
+					   SPINOR_OP_CYPRESS_EX4B, 0),	\
+		   SPI_MEM_OP_NO_ADDR,					\
+		   SPI_MEM_OP_NO_DUMMY,					\
+		   SPI_MEM_OP_NO_DATA)
+
 #define SPANSION_OP(opcode)						\
 	SPI_MEM_OP(SPI_MEM_OP_CMD(opcode, 0),				\
 		   SPI_MEM_OP_NO_ADDR,					\
@@ -362,6 +370,20 @@ static int cypress_nor_quad_enable_volatile(struct spi_nor *nor)
 	return 0;
 }
 
+static int cypress_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
+{
+	int ret;
+	struct spi_mem_op op = CYPRESS_NOR_EN4B_EX4B_OP(enable);
+
+	spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
+
+	return ret;
+}
+
 /**
  * cypress_nor_determine_addr_mode_by_sr1() - Determine current address mode
  *                                            (3 or 4-byte) by querying status
@@ -583,6 +605,9 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	struct spi_mem_op op;
 	int ret;
 
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
 	if (ret)
 		return ret;
@@ -646,8 +671,11 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 			const struct sfdp_parameter_header *bfpt_header,
 			const struct sfdp_bfpt *bfpt)
 {
-	int ret;
 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+	int ret;
+
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
 
 	ret = cypress_nor_set_addr_mode_nbytes(nor);
 	if (ret)
@@ -776,6 +804,11 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 				   const struct sfdp_parameter_header *bfpt_header,
 				   const struct sfdp_bfpt *bfpt)
 {
+	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
+
+	/* Assign 4-byte address mode method that is not determined in BFPT */
+	params->set_4byte_addr_mode = cypress_nor_set_4byte_addr_mode;
+
 	return cypress_nor_set_addr_mode_nbytes(nor);
 }
``` 

```console
shell$ git add --all
shell$ git commit -m "[patch] 228_drivers-mtd"
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch 
```  

### Fix patches/linux-6.12.42-xlnx-v2025.1/247_drivers-spi.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-247_drivers-spi.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-247_drivers-spi.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
Hunk #34 succeeded at 2428 (offset -3 lines).
Hunk #35 succeeded at 2482 (offset -3 lines).
Hunk #36 succeeded at 2533 (offset -3 lines).
Hunk #37 succeeded at 2601 (offset -3 lines).
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
Hunk #8 FAILED at 883.
Hunk #9 succeeded at 915 (offset -4 lines).
Hunk #10 succeeded at 1045 (offset -4 lines).
Hunk #11 succeeded at 1080 (offset -4 lines).
Hunk #12 succeeded at 1099 (offset -4 lines).
Hunk #13 succeeded at 1146 (offset -4 lines).
Hunk #14 succeeded at 1168 (offset -4 lines).
Hunk #15 succeeded at 1196 (offset -4 lines).
Hunk #16 succeeded at 1235 (offset -4 lines).
Hunk #17 succeeded at 1286 (offset -4 lines).
Hunk #18 succeeded at 1321 (offset -4 lines).
Hunk #19 succeeded at 1416 (offset -4 lines).
Hunk #20 succeeded at 1467 (offset -4 lines).
1 out of 20 hunks FAILED -- saving rejects to file drivers/spi/spi-zynqmp-gqspi.c.rej
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
Hunk #3 succeeded at 597 (offset -3 lines).
Hunk #4 succeeded at 973 (offset -3 lines).
Hunk #5 succeeded at 1111 (offset -3 lines).
```

```console
shell$ diff -p ../linux-6.12.27/drivers/spi/spi-zynqmp-gqspi.c ../linux-6.12.42/drivers/spi/spi-zynqmp-gqspi.c 
*** ../linux-6.12.27/drivers/spi/spi-zynqmp-gqspi.c	2025-07-19 14:12:47.740961300 +0900
--- ../linux-6.12.42/drivers/spi/spi-zynqmp-gqspi.c	2025-08-21 10:43:11.949468400 +0900
*************** static void zynqmp_process_dma_irq(struc
*** 799,805 ****
  static irqreturn_t zynqmp_qspi_irq(int irq, void *dev_id)
  {
  	struct zynqmp_qspi *xqspi = (struct zynqmp_qspi *)dev_id;
- 	irqreturn_t ret = IRQ_NONE;
  	u32 status, mask, dma_status = 0;
  
  	status = zynqmp_gqspi_read(xqspi, GQSPI_ISR_OFST);
--- 799,804 ----
*************** static irqreturn_t zynqmp_qspi_irq(int i
*** 814,840 ****
  				   dma_status);
  	}
  
! 	if (mask & GQSPI_ISR_TXNOT_FULL_MASK) {
  		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
- 		ret = IRQ_HANDLED;
- 	}
  
! 	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK) {
  		zynqmp_process_dma_irq(xqspi);
! 		ret = IRQ_HANDLED;
! 	} else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
! 			(mask & GQSPI_IER_GENFIFOEMPTY_MASK)) {
  		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
- 		ret = IRQ_HANDLED;
- 	}
  
  	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
  	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
  		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
  		complete(&xqspi->data_completion);
- 		ret = IRQ_HANDLED;
  	}
! 	return ret;
  }
  
  /**
--- 813,836 ----
  				   dma_status);
  	}
  
! 	if (!mask && !dma_status)
! 		return IRQ_NONE;
! 
! 	if (mask & GQSPI_ISR_TXNOT_FULL_MASK)
  		zynqmp_qspi_filltxfifo(xqspi, GQSPI_TX_FIFO_FILL);
  
! 	if (dma_status & GQSPI_QSPIDMA_DST_I_STS_DONE_MASK)
  		zynqmp_process_dma_irq(xqspi);
! 	else if (!(mask & GQSPI_IER_RXEMPTY_MASK) &&
! 			(mask & GQSPI_IER_GENFIFOEMPTY_MASK))
  		zynqmp_qspi_readrxfifo(xqspi, GQSPI_RX_FIFO_FILL);
  
  	if (xqspi->bytes_to_receive == 0 && xqspi->bytes_to_transfer == 0 &&
  	    ((status & GQSPI_IRQ_MASK) == GQSPI_IRQ_MASK)) {
  		zynqmp_gqspi_write(xqspi, GQSPI_IDR_OFST, GQSPI_ISR_IDR_MASK);
  		complete(&xqspi->data_completion);
  	}
! 	return IRQ_HANDLED;
  }
  
  /**
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/spi/spi-zynqmp-gqspi.c drivers/spi/spi-zynqmp-gqspi.c
shell$ rm drivers/spi/spi-zynqmp-gqspi.c.orig
shell$ rm drivers/spi/spi-zynqmp-gqspi.c.rej
shell$ rm drivers/spi/spi-cadence-quadspi.c.orig
shell$ rm include/linux/spi/spi.h.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 247_drivers-spi.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/247_drivers-spi.patch 
```

### Fix patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-262_drivers-usb-dwc3.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-262_drivers-usb-dwc3.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
Hunk #18 succeeded at 2576 (offset 3 lines).
Hunk #19 succeeded at 2625 (offset 5 lines).
Hunk #20 succeeded at 2646 (offset 5 lines).
Hunk #21 succeeded at 2665 (offset 5 lines).
Hunk #22 succeeded at 2813 (offset 5 lines).
patching file drivers/usb/dwc3/core.h
Hunk #11 FAILED at 1186.
Hunk #12 succeeded at 1249 (offset 3 lines).
Hunk #13 succeeded at 1262 (offset 3 lines).
Hunk #14 succeeded at 1340 (offset 3 lines).
Hunk #15 succeeded at 1366 (offset 3 lines).
Hunk #16 succeeded at 1381 (offset 3 lines).
Hunk #17 succeeded at 1407 (offset 3 lines).
Hunk #18 FAILED at 1423.
Hunk #19 succeeded at 1595 (offset 4 lines).
Hunk #20 succeeded at 1643 (offset 4 lines).
Hunk #21 succeeded at 1672 (offset 4 lines).
Hunk #22 succeeded at 1695 (offset 4 lines).
Hunk #23 succeeded at 1721 (offset 4 lines).
Hunk #24 succeeded at 1753 (offset 4 lines).
2 out of 24 hunks FAILED -- saving rejects to file drivers/usb/dwc3/core.h.rej
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
Hunk #1 succeeded at 308 (offset -2 lines).
Hunk #2 succeeded at 473 (offset -2 lines).
Hunk #3 succeeded at 656 (offset -2 lines).
Hunk #4 succeeded at 895 (offset -2 lines).
Hunk #5 succeeded at 903 (offset -2 lines).
Hunk #6 succeeded at 919 (offset -2 lines).
Hunk #7 succeeded at 940 (offset -2 lines).
Hunk #8 succeeded at 962 (offset -2 lines).
Hunk #9 succeeded at 1060 (offset -2 lines).
Hunk #10 succeeded at 1658 (offset -2 lines).
Hunk #11 succeeded at 1775 (offset -2 lines).
Hunk #12 succeeded at 2011 (offset -2 lines).
Hunk #13 succeeded at 2032 (offset -2 lines).
Hunk #14 succeeded at 2262 (offset -2 lines).
Hunk #15 succeeded at 2629 (offset -28 lines).
Hunk #16 succeeded at 2704 (offset -28 lines).
Hunk #17 succeeded at 2765 (offset -28 lines).
Hunk #18 succeeded at 2796 (offset -28 lines).
Hunk #19 succeeded at 2841 (offset -28 lines).
Hunk #20 succeeded at 2864 (offset -28 lines).
Hunk #21 succeeded at 2878 (offset -28 lines).
Hunk #22 succeeded at 2980 (offset -28 lines).
Hunk #23 succeeded at 3034 (offset -28 lines).
Hunk #24 succeeded at 3052 (offset -28 lines).
Hunk #25 succeeded at 3691 (offset -28 lines).
Hunk #26 succeeded at 3701 (offset -28 lines).
Hunk #27 succeeded at 3761 (offset -28 lines).
Hunk #28 succeeded at 4014 (offset -28 lines).
Hunk #29 succeeded at 4106 (offset -28 lines).
Hunk #30 succeeded at 4177 (offset -28 lines).
Hunk #31 succeeded at 4231 (offset -28 lines).
Hunk #32 succeeded at 4357 (offset -28 lines).
Hunk #33 succeeded at 4396 (offset -28 lines).
Hunk #34 succeeded at 4409 (offset -28 lines).
Hunk #35 succeeded at 4552 (offset -14 lines).
Hunk #36 succeeded at 4595 (offset -14 lines).
Hunk #37 succeeded at 4637 (offset -14 lines).
Hunk #38 succeeded at 4662 (offset -14 lines).
Hunk #39 succeeded at 4682 (offset -14 lines).
Hunk #40 succeeded at 4732 (offset -14 lines).
Hunk #41 succeeded at 4784 (offset -14 lines).
Hunk #42 succeeded at 4803 (offset -14 lines).
Hunk #43 succeeded at 4846 (offset -14 lines).
Hunk #44 succeeded at 4939 (offset -14 lines).
Hunk #45 succeeded at 5034 (offset -18 lines).
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```

#### Check drivers/usb/dwc3/core.c

```console
shell$ diff -p ../linux-6.12.27/drivers/usb/dwc3/core.c ../linux-6.12.42/drivers/usb/dwc3/core.c
*** ../linux-6.12.27/drivers/usb/dwc3/core.c	2025-07-19 14:12:48.680464000 +0900
--- ../linux-6.12.42/drivers/usb/dwc3/core.c	2025-08-21 10:43:13.056571100 +0900
*************** static int dwc3_suspend_common(struct dw
*** 2364,2369 ****
--- 2364,2370 ----
  {
  	u32 reg;
  	int i;
+ 	int ret;
  
  	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
  		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
*************** static int dwc3_suspend_common(struct dw
*** 2382,2388 ****
  	case DWC3_GCTL_PRTCAP_DEVICE:
  		if (pm_runtime_suspended(dwc->dev))
  			break;
! 		dwc3_gadget_suspend(dwc);
  		synchronize_irq(dwc->irq_gadget);
  		dwc3_core_exit(dwc);
  		break;
--- 2383,2391 ----
  	case DWC3_GCTL_PRTCAP_DEVICE:
  		if (pm_runtime_suspended(dwc->dev))
  			break;
! 		ret = dwc3_gadget_suspend(dwc);
! 		if (ret)
! 			return ret;
  		synchronize_irq(dwc->irq_gadget);
  		dwc3_core_exit(dwc);
  		break;
*************** static int dwc3_suspend_common(struct dw
*** 2417,2423 ****
  			break;
  
  		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
! 			dwc3_gadget_suspend(dwc);
  			synchronize_irq(dwc->irq_gadget);
  		}
  
--- 2420,2428 ----
  			break;
  
  		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
! 			ret = dwc3_gadget_suspend(dwc);
! 			if (ret)
! 				return ret;
  			synchronize_irq(dwc->irq_gadget);
  		}
  
```

```console
shell$ diff -p ../linux-6.12.27-xlnx-v2025.1/drivers/usb/dwc3/core.c ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/core.c
*** ../linux-6.12.27-xlnx-v2025.1/drivers/usb/dwc3/core.c	2025-07-19 11:15:03.080481200 +0900
--- ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/core.c	2025-08-22 12:42:41.962128600 +0900
*************** static int dwc3_suspend_common(struct dw
*** 2550,2555 ****
--- 2550,2556 ----
  {
  	u32 reg;
  	int i;
+ 	int ret;
  
  	if (!pm_runtime_suspended(dwc->dev) && !PMSG_IS_AUTO(msg)) {
  		dwc->susphy_state = (dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0)) &
*************** static int dwc3_suspend_common(struct dw
*** 2568,2574 ****
  	case DWC3_GCTL_PRTCAP_DEVICE:
  		if (pm_runtime_suspended(dwc->dev))
  			break;
! 		dwc3_gadget_suspend(dwc);
  		synchronize_irq(dwc->irq_gadget);
  		dwc3_core_exit(dwc);
  		break;
--- 2569,2577 ----
  	case DWC3_GCTL_PRTCAP_DEVICE:
  		if (pm_runtime_suspended(dwc->dev))
  			break;
! 		ret = dwc3_gadget_suspend(dwc);
! 		if (ret)
! 			return ret;
  		synchronize_irq(dwc->irq_gadget);
  		dwc3_core_exit(dwc);
  		break;
*************** static int dwc3_suspend_common(struct dw
*** 2608,2614 ****
  			break;
  
  		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
! 			dwc3_gadget_suspend(dwc);
  			synchronize_irq(dwc->irq_gadget);
  		}
  
--- 2611,2619 ----
  			break;
  
  		if (dwc->current_otg_role == DWC3_OTG_ROLE_DEVICE) {
! 			ret = dwc3_gadget_suspend(dwc);
! 			if (ret)
! 				return ret;
  			synchronize_irq(dwc->irq_gadget);
  		}
```
  
```console
shell$ rm drivers/usb/dwc3/core.c.orig
```

#### Check drivers/usb/dwc3/gadget.c

```console
shell$ diff -p ../linux-6.12.27/drivers/usb/dwc3/gadget.c ../linux-6.12.42/drivers/usb/dwc3/gadget.c
*** ../linux-6.12.27/drivers/usb/dwc3/gadget.c	2025-07-19 14:12:48.688441800 +0900
--- ../linux-6.12.42/drivers/usb/dwc3/gadget.c	2025-08-21 10:43:13.074948600 +0900
*************** int dwc3_send_gadget_generic_command(str
*** 277,284 ****
  	return ret;
  }
  
- static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
- 
  /**
   * dwc3_send_gadget_ep_cmd - issue an endpoint command
   * @dep: the endpoint to which the command is going to be issued
--- 277,282 ----
*************** static int dwc3_gadget_get_frame(struct
*** 2348,2357 ****
  	return __dwc3_gadget_get_frame(dwc);
  }
  
! static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
  {
- 	int			retries;
- 
  	int			ret;
  	u32			reg;
  
--- 2346,2353 ----
  	return __dwc3_gadget_get_frame(dwc);
  }
  
! static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
  {
  	int			ret;
  	u32			reg;
  
*************** static int __dwc3_gadget_wakeup(struct d
*** 2379,2386 ****
  		return -EINVAL;
  	}
  
! 	if (async)
! 		dwc3_gadget_enable_linksts_evts(dwc, true);
  
  	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
  	if (ret < 0) {
--- 2375,2381 ----
  		return -EINVAL;
  	}
  
! 	dwc3_gadget_enable_linksts_evts(dwc, true);
  
  	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
  	if (ret < 0) {
*************** static int __dwc3_gadget_wakeup(struct d
*** 2399,2425 ****
  
  	/*
  	 * Since link status change events are enabled we will receive
! 	 * an U0 event when wakeup is successful. So bail out.
  	 */
- 	if (async)
- 		return 0;
- 
- 	/* poll until Link State changes to ON */
- 	retries = 20000;
- 
- 	while (retries--) {
- 		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
- 
- 		/* in HS, means ON */
- 		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
- 			break;
- 	}
- 
- 	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
- 		dev_err(dwc->dev, "failed to send remote wakeup\n");
- 		return -EINVAL;
- 	}
- 
  	return 0;
  }
  
--- 2394,2401 ----
  
  	/*
  	 * Since link status change events are enabled we will receive
! 	 * an U0 event when wakeup is successful.
  	 */
  	return 0;
  }
  
*************** static int dwc3_gadget_wakeup(struct usb
*** 2440,2446 ****
  		spin_unlock_irqrestore(&dwc->lock, flags);
  		return -EINVAL;
  	}
! 	ret = __dwc3_gadget_wakeup(dwc, true);
  
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
--- 2416,2422 ----
  		spin_unlock_irqrestore(&dwc->lock, flags);
  		return -EINVAL;
  	}
! 	ret = __dwc3_gadget_wakeup(dwc);
  
  	spin_unlock_irqrestore(&dwc->lock, flags);
  
*************** static int dwc3_gadget_func_wakeup(struc
*** 2468,2481 ****
  	 */
  	link_state = dwc3_gadget_get_link_state(dwc);
  	if (link_state == DWC3_LINK_STATE_U3) {
! 		ret = __dwc3_gadget_wakeup(dwc, false);
! 		if (ret) {
! 			spin_unlock_irqrestore(&dwc->lock, flags);
! 			return -EINVAL;
! 		}
! 		dwc3_resume_gadget(dwc);
! 		dwc->suspended = false;
! 		dwc->link_state = DWC3_LINK_STATE_U0;
  	}
  
  	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
--- 2444,2453 ----
  	 */
  	link_state = dwc3_gadget_get_link_state(dwc);
  	if (link_state == DWC3_LINK_STATE_U3) {
! 		dwc->wakeup_pending_funcs |= BIT(intf_id);
! 		ret = __dwc3_gadget_wakeup(dwc);
! 		spin_unlock_irqrestore(&dwc->lock, flags);
! 		return ret;
  	}
  
  	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
*************** static void dwc3_gadget_linksts_change_i
*** 4320,4325 ****
--- 4292,4299 ----
  {
  	enum dwc3_link_state	next = evtinfo & DWC3_LINK_STATE_MASK;
  	unsigned int		pwropt;
+ 	int			ret;
+ 	int			intf_id;
  
  	/*
  	 * WORKAROUND: DWC3 < 2.50a have an issue when configured without
*************** static void dwc3_gadget_linksts_change_i
*** 4395,4401 ****
  
  	switch (next) {
  	case DWC3_LINK_STATE_U0:
! 		if (dwc->gadget->wakeup_armed) {
  			dwc3_gadget_enable_linksts_evts(dwc, false);
  			dwc3_resume_gadget(dwc);
  			dwc->suspended = false;
--- 4369,4375 ----
  
  	switch (next) {
  	case DWC3_LINK_STATE_U0:
! 		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
  			dwc3_gadget_enable_linksts_evts(dwc, false);
  			dwc3_resume_gadget(dwc);
  			dwc->suspended = false;
*************** static void dwc3_gadget_linksts_change_i
*** 4418,4423 ****
--- 4392,4409 ----
  	}
  
  	dwc->link_state = next;
+ 
+ 	/* Proceed with func wakeup if any interfaces that has requested */
+ 	while (dwc->wakeup_pending_funcs && (next == DWC3_LINK_STATE_U0)) {
+ 		intf_id = ffs(dwc->wakeup_pending_funcs) - 1;
+ 		ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+ 						       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+ 						       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+ 		if (ret)
+ 			dev_err(dwc->dev, "Failed to send DN wake for intf %d\n", intf_id);
+ 
+ 		dwc->wakeup_pending_funcs &= ~BIT(intf_id);
+ 	}
  }
  
  static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
*************** int dwc3_gadget_suspend(struct dwc3 *dwc
*** 4802,4827 ****
  	int ret;
  
  	ret = dwc3_gadget_soft_disconnect(dwc);
- 	if (ret)
- 		goto err;
- 
- 	spin_lock_irqsave(&dwc->lock, flags);
- 	if (dwc->gadget_driver)
- 		dwc3_disconnect_gadget(dwc);
- 	spin_unlock_irqrestore(&dwc->lock, flags);
- 
- 	return 0;
- 
- err:
  	/*
  	 * Attempt to reset the controller's state. Likely no
  	 * communication can be established until the host
  	 * performs a port reset.
  	 */
! 	if (dwc->softconnect)
  		dwc3_gadget_soft_connect(dwc);
  
! 	return ret;
  }
  
  int dwc3_gadget_resume(struct dwc3 *dwc)
--- 4788,4809 ----
  	int ret;
  
  	ret = dwc3_gadget_soft_disconnect(dwc);
  	/*
  	 * Attempt to reset the controller's state. Likely no
  	 * communication can be established until the host
  	 * performs a port reset.
  	 */
! 	if (ret && dwc->softconnect) {
  		dwc3_gadget_soft_connect(dwc);
+ 		return -EAGAIN;
+ 	}
  
! 	spin_lock_irqsave(&dwc->lock, flags);
! 	if (dwc->gadget_driver)
! 		dwc3_disconnect_gadget(dwc);
! 	spin_unlock_irqrestore(&dwc->lock, flags);
! 
! 	return 0;
  }
  
  int dwc3_gadget_resume(struct dwc3 *dwc)
```

```console
shell$ diff -p ../linux-6.12.27/drivers/usb/dwc3/gadget.c ../linux-6.12.27-xlnx-v2025.1/drivers/usb/dwc3/gadget.c
*** ../linux-6.12.27/drivers/usb/dwc3/gadget.c	2025-07-19 14:12:48.688441800 +0900
--- ../linux-6.12.27-xlnx-v2025.1/drivers/usb/dwc3/gadget.c	2025-07-19 11:15:03.088460200 +0900
*************** int dwc3_send_gadget_ep_cmd(struct dwc3_
*** 310,316 ****
  {
  	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
  	struct dwc3		*dwc = dep->dwc;
! 	u32			timeout = 5000;
  	u32			saved_config = 0;
  	u32			reg;
  
--- 310,316 ----
  {
  	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
  	struct dwc3		*dwc = dep->dwc;
! 	u32			timeout = 10000;
  	u32			saved_config = 0;
  	u32			reg;
  
*************** static int dwc3_send_clear_stall_ep_cmd(
*** 475,481 ****
  	return dwc3_send_gadget_ep_cmd(dep, cmd, &params);
  }
  
! static dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
  		struct dwc3_trb *trb)
  {
  	u32		offset = (char *) trb - (char *) dep->trb_pool;
--- 475,481 ----
  	return dwc3_send_gadget_ep_cmd(dep, cmd, &params);
  }
  
! dma_addr_t dwc3_trb_dma_offset(struct dwc3_ep *dep,
  		struct dwc3_trb *trb)
  {
  	u32		offset = (char *) trb - (char *) dep->trb_pool;
*************** static int dwc3_gadget_set_ep_config(str
*** 658,663 ****
--- 658,666 ----
  	return dwc3_send_gadget_ep_cmd(dep, DWC3_DEPCMD_SETEPCONFIG, &params);
  }
  
+ void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force,
+ 			       bool interrupt);
+ 
  /**
   * dwc3_gadget_calc_tx_fifo_size - calculates the txfifo size value
   * @dwc: pointer to the DWC3 context
*************** static int dwc3_gadget_resize_tx_fifos(s
*** 894,900 ****
   * Caller should take care of locking. Execute all necessary commands to
   * initialize a HW endpoint so it can be used by a gadget driver.
   */
! static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
  {
  	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
  	struct dwc3		*dwc = dep->dwc;
--- 897,903 ----
   * Caller should take care of locking. Execute all necessary commands to
   * initialize a HW endpoint so it can be used by a gadget driver.
   */
! int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
  {
  	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
  	struct dwc3		*dwc = dep->dwc;
*************** static int __dwc3_gadget_ep_enable(struc
*** 902,908 ****
  	u32			reg;
  	int			ret;
  
! 	if (!(dep->flags & DWC3_EP_ENABLED)) {
  		ret = dwc3_gadget_resize_tx_fifos(dep);
  		if (ret)
  			return ret;
--- 905,911 ----
  	u32			reg;
  	int			ret;
  
! 	if (!(dep->flags & DWC3_EP_ENABLED) || dwc->is_hibernated) {
  		ret = dwc3_gadget_resize_tx_fifos(dep);
  		if (ret)
  			return ret;
*************** static int __dwc3_gadget_ep_enable(struc
*** 918,924 ****
  			return ret;
  	}
  
! 	if (!(dep->flags & DWC3_EP_ENABLED)) {
  		struct dwc3_trb	*trb_st_hw;
  		struct dwc3_trb	*trb_link;
  
--- 921,927 ----
  			return ret;
  	}
  
! 	if (!(dep->flags & DWC3_EP_ENABLED) || dwc->is_hibernated) {
  		struct dwc3_trb	*trb_st_hw;
  		struct dwc3_trb	*trb_link;
  
*************** static int __dwc3_gadget_ep_enable(struc
*** 939,944 ****
--- 942,955 ----
  		memset(dep->trb_pool, 0,
  		       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
  
+ 		if (!dwc->is_hibernated) {
+ 			/* Initialize the TRB ring */
+ 			dep->trb_dequeue = 0;
+ 			dep->trb_enqueue = 0;
+ 			memset(dep->trb_pool, 0,
+ 			       sizeof(struct dwc3_trb) * DWC3_TRB_NUM);
+ 		}
+ 
  		/* Link TRB. The HWO bit is never reset */
  		trb_st_hw = &dep->trb_pool[0];
  
*************** static int __dwc3_gadget_ep_enable(struc
*** 953,960 ****
  	 * Issue StartTransfer here with no-op TRB so we can always rely on No
  	 * Response Update Transfer command.
  	 */
! 	if (usb_endpoint_xfer_bulk(desc) ||
! 			usb_endpoint_xfer_int(desc)) {
  		struct dwc3_gadget_ep_cmd_params params;
  		struct dwc3_trb	*trb;
  		dma_addr_t trb_dma;
--- 964,971 ----
  	 * Issue StartTransfer here with no-op TRB so we can always rely on No
  	 * Response Update Transfer command.
  	 */
! 	if ((usb_endpoint_xfer_bulk(desc) || usb_endpoint_xfer_int(desc)) &&
! 	     !dwc->is_hibernated) {
  		struct dwc3_gadget_ep_cmd_params params;
  		struct dwc3_trb	*trb;
  		dma_addr_t trb_dma;
*************** void dwc3_remove_requests(struct dwc3 *d
*** 1051,1057 ****
   *
   * Caller should take care of locking.
   */
! static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
  {
  	struct dwc3		*dwc = dep->dwc;
  	u32			reg;
--- 1062,1068 ----
   *
   * Caller should take care of locking.
   */
! int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
  {
  	struct dwc3		*dwc = dep->dwc;
  	u32			reg;
*************** static int dwc3_prepare_trbs(struct dwc3
*** 1649,1655 ****
  
  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
  
! static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
  {
  	struct dwc3_gadget_ep_cmd_params params;
  	struct dwc3_request		*req;
--- 1660,1666 ----
  
  static void dwc3_gadget_ep_cleanup_cancelled_requests(struct dwc3_ep *dep);
  
! int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
  {
  	struct dwc3_gadget_ep_cmd_params params;
  	struct dwc3_request		*req;
*************** static int __dwc3_stop_active_transfer(s
*** 1766,1772 ****
  		return 0;
  	}
  	WARN_ON_ONCE(ret);
! 	dep->resource_index = 0;
  
  	if (!interrupt)
  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
--- 1777,1789 ----
  		return 0;
  	}
  	WARN_ON_ONCE(ret);
! 
! 	/*
! 	 * when transfer is stopped with force rm bit false, it can be
! 	 * restarted by passing resource_index in params; don't loose it
! 	 */
! 	if (force)
! 		dep->resource_index = 0;
  
  	if (!interrupt)
  		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
*************** static int __dwc3_gadget_ep_queue(struct
*** 1996,2007 ****
  	 */
  	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
  	    (dep->flags & DWC3_EP_WEDGE) ||
- 	    (dep->flags & DWC3_EP_DELAY_STOP) ||
  	    (dep->flags & DWC3_EP_STALL)) {
  		dep->flags |= DWC3_EP_DELAY_START;
  		return 0;
  	}
  
  	/*
  	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
  	 * wait for a XferNotReady event so we will know what's the current
--- 2013,2030 ----
  	 */
  	if ((dep->flags & DWC3_EP_END_TRANSFER_PENDING) ||
  	    (dep->flags & DWC3_EP_WEDGE) ||
  	    (dep->flags & DWC3_EP_STALL)) {
  		dep->flags |= DWC3_EP_DELAY_START;
  		return 0;
  	}
  
+ 	/* If core is hibernated, need to wakeup (remote wakeup) */
+ 	if (dwc->is_hibernated) {
+ 		dwc->force_hiber_wake = true;
+ 		dwc3_gadget_exit_hibernation(dwc);
+ 		dwc->force_hiber_wake = false;
+ 	}
+ 
  	/*
  	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
  	 * wait for a XferNotReady event so we will know what's the current
*************** static int __dwc3_gadget_ep_queue(struct
*** 2011,2020 ****
  	 * errors which will force us issue EndTransfer command.
  	 */
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
! 		if (!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
! 			if ((dep->flags & DWC3_EP_PENDING_REQUEST))
! 				return __dwc3_gadget_start_isoc(dep);
  
  			return 0;
  		}
  	}
--- 2034,2056 ----
  	 * errors which will force us issue EndTransfer command.
  	 */
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
! 		if (!(dep->flags & DWC3_EP_PENDING_REQUEST) &&
! 				!(dep->flags & DWC3_EP_TRANSFER_STARTED))
! 			return 0;
! 
! 		if (dep->flags & DWC3_EP_PENDING_REQUEST) {
! 			if (dep->flags & DWC3_EP_TRANSFER_STARTED) {
! 				/*
! 				 * If there are not entries in request list
! 				 * then PENDING flag would be set, so that END
! 				 * TRANSFER is issued when an entry is added
! 				 * into request list.
! 				 */
! 				dwc3_stop_active_transfer(dep, true, true);
! 				dep->flags = DWC3_EP_ENABLED;
! 			}
  
+ 			/* Rest is taken care by DWC3_DEPEVT_XFERNOTREADY */
  			return 0;
  		}
  	}
*************** int __dwc3_gadget_ep_set_halt(struct dwc
*** 2228,2235 ****
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
  
! 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING ||
! 		    (dep->flags & DWC3_EP_DELAY_STOP)) {
  			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
  			if (protocol)
  				dwc->clear_stall_protocol = dep->number;
--- 2264,2270 ----
  		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
  			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
  
! 		if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) {
  			dep->flags |= DWC3_EP_PENDING_CLEAR_STALL;
  			if (protocol)
  				dwc->clear_stall_protocol = dep->number;
*************** static void __dwc3_gadget_set_speed(stru
*** 2622,2628 ****
  	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
  }
  
! static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on)
  {
  	u32			reg;
  	u32			timeout = 2000;
--- 2657,2663 ----
  	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
  }
  
! int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
  {
  	u32			reg;
  	u32			timeout = 2000;
*************** static int dwc3_gadget_run_stop(struct d
*** 2697,2703 ****
  	return 0;
  }
  
! static void dwc3_gadget_disable_irq(struct dwc3 *dwc);
  static void __dwc3_gadget_stop(struct dwc3 *dwc);
  static int __dwc3_gadget_start(struct dwc3 *dwc);
  
--- 2732,2738 ----
  	return 0;
  }
  
! void dwc3_gadget_disable_irq(struct dwc3 *dwc);
  static void __dwc3_gadget_stop(struct dwc3 *dwc);
  static int __dwc3_gadget_start(struct dwc3 *dwc);
  
*************** static int dwc3_gadget_soft_disconnect(s
*** 2758,2764 ****
  	 * remaining event generated by the controller while polling for
  	 * DSTS.DEVCTLHLT.
  	 */
! 	ret = dwc3_gadget_run_stop(dwc, false);
  
  	/*
  	 * Stop the gadget after controller is halted, so that if needed, the
--- 2793,2799 ----
  	 * remaining event generated by the controller while polling for
  	 * DSTS.DEVCTLHLT.
  	 */
! 	ret = dwc3_gadget_run_stop(dwc, false, false);
  
  	/*
  	 * Stop the gadget after controller is halted, so that if needed, the
*************** static int dwc3_gadget_soft_connect(stru
*** 2789,2795 ****
  
  	dwc3_event_buffers_setup(dwc);
  	__dwc3_gadget_start(dwc);
! 	return dwc3_gadget_run_stop(dwc, true);
  }
  
  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
--- 2824,2830 ----
  
  	dwc3_event_buffers_setup(dwc);
  	__dwc3_gadget_start(dwc);
! 	return dwc3_gadget_run_stop(dwc, true, false);
  }
  
  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
*************** static int dwc3_gadget_pullup(struct usb
*** 2834,2848 ****
  
  	if (!is_on)
  		ret = dwc3_gadget_soft_disconnect(dwc);
! 	else
! 		ret = dwc3_gadget_soft_connect(dwc);
  
  	pm_runtime_put(dwc->dev);
  
  	return ret;
  }
  
! static void dwc3_gadget_enable_irq(struct dwc3 *dwc)
  {
  	u32			reg;
  
--- 2869,2885 ----
  
  	if (!is_on)
  		ret = dwc3_gadget_soft_disconnect(dwc);
! 	else {
! 		__dwc3_gadget_start(dwc);
! 		ret = dwc3_gadget_run_stop(dwc, true, false);
! 	}
  
  	pm_runtime_put(dwc->dev);
  
  	return ret;
  }
  
! void dwc3_gadget_enable_irq(struct dwc3 *dwc)
  {
  	u32			reg;
  
*************** static void dwc3_gadget_enable_irq(struc
*** 2855,2860 ****
--- 2892,2901 ----
  			DWC3_DEVTEN_USBRSTEN |
  			DWC3_DEVTEN_DISCONNEVTEN);
  
+ 	/* Enable hibernation IRQ */
+ 	if (dwc->has_hibernation)
+ 		reg |= DWC3_DEVTEN_HIBERNATIONREQEVTEN;
+ 
  	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
  		reg |= DWC3_DEVTEN_ULSTCNGEN;
  
*************** static void dwc3_gadget_enable_irq(struc
*** 2865,2871 ****
  	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
  }
  
! static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
  {
  	/* mask all interrupts */
  	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
--- 2906,2912 ----
  	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
  }
  
! void dwc3_gadget_disable_irq(struct dwc3 *dwc)
  {
  	/* mask all interrupts */
  	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
*************** static int __dwc3_gadget_start(struct dw
*** 2967,2972 ****
--- 3008,3023 ----
  		dwc3_writel(dwc->regs, DWC3_DCFG1, reg);
  	}
  
+ 	/* For OTG mode, check if the core is currently in Host mode.
+ 	 * This is not an error condition as there are times when the core is
+ 	 * working as host and kernel is told to initiate bind operation with
+ 	 * gadget class driver module.
+ 	 * The below remaining operations are handled in OTG driver whenever
+ 	 * required.
+ 	 */
+ 	if (dwc3_readl(dwc->regs, DWC3_GSTS) & DWC3_GSTS_CUR_MODE)
+ 		return 0;
+ 
  	/* Start with SuperSpeed Default */
  	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
  
*************** err0:
*** 3011,3016 ****
--- 3062,3068 ----
  	return ret;
  }
  
+ static irqreturn_t dwc3_wakeup_interrupt(int irq, void *_dwc);
  static int dwc3_gadget_start(struct usb_gadget *g,
  		struct usb_gadget_driver *driver)
  {
*************** static int dwc3_gadget_start(struct usb_
*** 3028,3033 ****
--- 3080,3099 ----
  		return ret;
  	}
  
+ 	/* Look for wakeup interrupt if hibernation is supported */
+ 	if (dwc->has_hibernation) {
+ 		irq = dwc->irq_wakeup;
+ 		ret = devm_request_irq(dwc->dev, irq, dwc3_wakeup_interrupt,
+ 				       IRQF_SHARED, "usb-wakeup", dwc);
+ 
+ 		if (ret) {
+ 			dev_err(dwc->dev, "failed to request wakeup irq #%d --> %d\n",
+ 				irq, ret);
+ 			free_irq(dwc->irq_gadget, dwc);
+ 			return ret;
+ 		}
+ 	}
+ 
  	spin_lock_irqsave(&dwc->lock, flags);
  	dwc->gadget_driver	= driver;
  	spin_unlock_irqrestore(&dwc->lock, flags);
*************** static bool dwc3_gadget_endpoint_trbs_co
*** 3653,3658 ****
--- 3719,3727 ----
  
  	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
  
+ 	if (dep->stream_capable && !list_empty(&dep->started_list))
+ 		__dwc3_gadget_kick_transfer(dep);
+ 
  	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
  		goto out;
  
*************** static bool dwc3_gadget_endpoint_trbs_co
*** 3660,3669 ****
  		return no_started_trb;
  
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
! 		list_empty(&dep->started_list) &&
! 		(list_empty(&dep->pending_list) || status == -EXDEV))
! 		dwc3_stop_active_transfer(dep, true, true);
! 	else if (dwc3_gadget_ep_should_continue(dep))
  		if (__dwc3_gadget_kick_transfer(dep) == 0)
  			no_started_trb = false;
  
--- 3729,3746 ----
  		return no_started_trb;
  
  	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
! 	    list_empty(&dep->started_list)) {
! 		if (list_empty(&dep->pending_list))
! 			/*
! 			 * If there is no entry in request list then do
! 			 * not issue END TRANSFER now. Just set PENDING
! 			 * flag, so that END TRANSFER is issued when an
! 			 * entry is added into request list.
! 			 */
! 			dep->flags |= DWC3_EP_PENDING_REQUEST;
! 		else if (status == -EXDEV)
! 			dwc3_stop_active_transfer(dep, true, true);
! 	} else if (dwc3_gadget_ep_should_continue(dep))
  		if (__dwc3_gadget_kick_transfer(dep) == 0)
  			no_started_trb = false;
  
*************** static void dwc3_gadget_endpoint_transfe
*** 3712,3718 ****
  	if (event->status & DEPEVT_STATUS_BUSERR)
  		status = -ECONNRESET;
  
! 	if (event->status & DEPEVT_STATUS_MISSED_ISOC)
  		status = -EXDEV;
  
  	dwc3_gadget_endpoint_trbs_complete(dep, event, status);
--- 3789,3796 ----
  	if (event->status & DEPEVT_STATUS_BUSERR)
  		status = -ECONNRESET;
  
! 	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
! 	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
  		status = -EXDEV;
  
  	dwc3_gadget_endpoint_trbs_complete(dep, event, status);
*************** void dwc3_stop_active_transfer(struct dw
*** 3964,3970 ****
  	 */
  	if (dep->number <= 1 && dwc->ep0state != EP0_DATA_PHASE)
  		return;
- 
  	if (interrupt && (dep->flags & DWC3_EP_DELAY_STOP))
  		return;
  
--- 4042,4047 ----
*************** static void dwc3_gadget_disconnect_inter
*** 4057,4062 ****
--- 4134,4148 ----
  
  	dwc3_disconnect_gadget(dwc);
  
+ 	/* In USB 2.0, to avoid hibernation interrupt at the time of connection
+ 	 * clear DWC3_DCTL_KEEP_CONNECT bit.
+ 	 */
+ 	if (dwc->has_hibernation) {
+ 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+ 		reg &= ~DWC3_DCTL_KEEP_CONNECT;
+ 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+ 	}
+ 
  	dwc->gadget->speed = USB_SPEED_UNKNOWN;
  	dwc->setup_packet_pending = false;
  	dwc->gadget->wakeup_armed = false;
*************** static void dwc3_gadget_reset_interrupt(
*** 4119,4124 ****
--- 4205,4224 ----
  			dwc3_gadget_disconnect_interrupt(dwc);
  	}
  
+ 	/*
+ 	 * To avoid hibernation interrupt at the time of connection on hot-plug
+ 	 * clear DWC3_DCTL_KEEP_CONNECT bit on gadget enumeration and disable
+ 	 * DWC3_GCTL_GBLHIBERNATIONEN hibernation interrupt.
+ 	 */
+ 	if (dwc->has_hibernation) {
+ 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+ 		reg &= ~DWC3_DCTL_KEEP_CONNECT;
+ 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+ 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+ 		reg &= ~DWC3_GCTL_GBLHIBERNATIONEN;
+ 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+ 	}
+ 
  	dwc3_reset_gadget(dwc);
  
  	/*
*************** static void dwc3_gadget_conndone_interru
*** 4159,4167 ****
  	u8			lanes = 1;
  	u8			speed;
  
- 	if (!dwc->softconnect)
- 		return;
- 
  	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
  	speed = reg & DWC3_DSTS_CONNECTSPD;
  	dwc->speed = speed;
--- 4259,4264 ----
*************** static void dwc3_gadget_conndone_interru
*** 4289,4294 ****
--- 4386,4412 ----
  	}
  
  	/*
+ 	 * In USB 2.0, to avoid hibernation interrupt at the time of connection
+ 	 * set DWC3_DCTL_KEEP_CONNECT bit here
+ 	 */
+ 	if (dwc->has_hibernation) {
+ 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+ 		reg |= DWC3_DCTL_KEEP_CONNECT;
+ 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+ 
+ 		/*
+ 		 * WORKAROUND: In USB 2.0, before connection done early
+ 		 * hibernation interrupt occurred. To avoid early hibernation
+ 		 * event for gadget mode set DWC3_GCTL_GBLHIBERNATIONEN bit
+ 		 * after connection done instead of global core setup in
+ 		 * dwc3 core.
+ 		 */
+ 		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+ 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
+ 		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+ 	}
+ 
+ 	/*
  	 * Configure PHY via GUSB3PIPECTLn if required.
  	 *
  	 * Update GTXFIFOSIZn
*************** static void dwc3_gadget_wakeup_interrupt
*** 4306,4311 ****
--- 4424,4433 ----
  	 * implemented.
  	 */
  
+ 	/* Take core out of low power mode. */
+ 	if (dwc->is_hibernated)
+ 		dwc3_gadget_exit_hibernation(dwc);
+ 
  	if (dwc->async_callbacks && dwc->gadget_driver->resume) {
  		spin_unlock(&dwc->lock);
  		dwc->gadget_driver->resume(dwc->gadget);
*************** static void dwc3_gadget_wakeup_interrupt
*** 4315,4320 ****
--- 4437,4453 ----
  	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
  }
  
+ static irqreturn_t dwc3_wakeup_interrupt(int irq, void *_dwc)
+ {
+ 	struct dwc3 *dwc = (struct dwc3 *)_dwc;
+ 
+ 	spin_lock(&dwc->lock);
+ 	dwc3_gadget_wakeup_interrupt(dwc, DWC3_DEVICE_EVENT_WAKEUP);
+ 	spin_unlock(&dwc->lock);
+ 
+ 	return IRQ_HANDLED;
+ }
+ 
  static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
  		unsigned int evtinfo)
  {
*************** static void dwc3_gadget_suspend_interrup
*** 4433,4438 ****
--- 4566,4597 ----
  	dwc->link_state = next;
  }
  
+ static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
+ 		unsigned int evtinfo)
+ {
+ 	unsigned int is_ss = evtinfo & BIT(4);
+ 
+ 	/*
+ 	 * WORKAROUND: DWC3 revision 2.20a with hibernation support
+ 	 * have a known issue which can cause USB CV TD.9.23 to fail
+ 	 * randomly.
+ 	 *
+ 	 * Because of this issue, core could generate bogus hibernation
+ 	 * events which SW needs to ignore.
+ 	 *
+ 	 * Refers to:
+ 	 *
+ 	 * STAR#9000546576: Device Mode Hibernation: Issue in USB 2.0
+ 	 * Device Fallback from SuperSpeed
+ 	 */
+ 	if ((!!is_ss ^ (dwc->speed == USB_SPEED_SUPER)) &&
+ 	    (!(dwc->has_hibernation)))
+ 		return;
+ 
+ 	/* enter hibernation here */
+ 	dwc3_gadget_enter_hibernation(dwc);
+ }
+ 
  static void dwc3_gadget_interrupt(struct dwc3 *dwc,
  		const struct dwc3_event_devt *event)
  {
*************** static void dwc3_gadget_interrupt(struct
*** 4450,4456 ****
  		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
  		break;
  	case DWC3_DEVICE_EVENT_HIBER_REQ:
! 		dev_WARN_ONCE(dwc->dev, true, "unexpected hibernation event\n");
  		break;
  	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
  		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
--- 4609,4619 ----
  		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
  		break;
  	case DWC3_DEVICE_EVENT_HIBER_REQ:
! 		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
! 					"unexpected hibernation event\n"))
! 			break;
! 
! 		dwc3_gadget_hibernation_interrupt(dwc, event->event_info);
  		break;
  	case DWC3_DEVICE_EVENT_LINK_STATUS_CHANGE:
  		dwc3_gadget_linksts_change_interrupt(dwc, event->event_info);
*************** static irqreturn_t dwc3_process_event_bu
*** 4488,4493 ****
--- 4651,4657 ----
  	struct dwc3 *dwc = evt->dwc;
  	irqreturn_t ret = IRQ_NONE;
  	int left;
+ 	u32 reg;
  
  	left = evt->count;
  
*************** static irqreturn_t dwc3_process_event_bu
*** 4512,4517 ****
--- 4676,4685 ----
  		 */
  		evt->lpos = (evt->lpos + 4) % evt->length;
  		left -= 4;
+ 
+ 		/* Stop processing any events after core is hibernated */
+ 		if (dwc->is_hibernated)
+ 			break;
  	}
  
  	evt->count = 0;
*************** static irqreturn_t dwc3_process_event_bu
*** 4528,4533 ****
--- 4696,4709 ----
  	 */
  	wmb();
  
+ 	/* Prevent interrupt generation when hibernated */
+ 	if (!dwc->is_hibernated) {
+ 		/* Unmask interrupt */
+ 		reg = dwc3_readl(dwc->regs, DWC3_GEVNTSIZ(0));
+ 		reg &= ~DWC3_GEVNTSIZ_INTMASK;
+ 		dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0), reg);
+ 	}
+ 
  	if (dwc->imod_interval) {
  		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
  		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
*************** static irqreturn_t dwc3_check_event_buf(
*** 4570,4575 ****
--- 4746,4755 ----
  		return IRQ_HANDLED;
  	}
  
+ 	/* Stop processing events after hibernated */
+ 	if (dwc->is_hibernated)
+ 		return IRQ_HANDLED;
+ 
  	/*
  	 * With PCIe legacy interrupt, test shows that top-half irq handler can
  	 * be called again after HW interrupt deassertion. Check if bottom-half
*************** static irqreturn_t dwc3_interrupt(int ir
*** 4618,4624 ****
  static int dwc3_gadget_get_irq(struct dwc3 *dwc)
  {
  	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
! 	int irq;
  
  	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
  	if (irq > 0)
--- 4798,4804 ----
  static int dwc3_gadget_get_irq(struct dwc3 *dwc)
  {
  	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
! 	int irq, irq_hiber;
  
  	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
  	if (irq > 0)
*************** static int dwc3_gadget_get_irq(struct dw
*** 4637,4642 ****
--- 4817,4835 ----
  	irq = platform_get_irq(dwc3_pdev, 0);
  
  out:
+ 	/* look for wakeup interrupt if hibernation is supported */
+ 	if (dwc->has_hibernation) {
+ 		irq_hiber = platform_get_irq_byname_optional(dwc3_pdev,
+ 							     "wakeup");
+ 		if (irq_hiber > 0) {
+ 			dwc->irq_wakeup = irq_hiber;
+ 		} else {
+ 			irq_hiber = platform_get_irq(dwc3_pdev, 2);
+ 			if (irq_hiber > 0)
+ 				dwc->irq_wakeup = irq_hiber;
+ 		}
+ 	}
+ 
  	return irq;
  }
  
*************** int dwc3_gadget_init(struct dwc3 *dwc)
*** 4667,4672 ****
--- 4860,4878 ----
  
  	dwc->irq_gadget = irq;
  
+ 	if (dwc->dr_mode == USB_DR_MODE_OTG) {
+ 		struct usb_phy *phy;
+ 
+ 		/* Switch otg to peripheral mode */
+ 		phy = usb_get_phy(USB_PHY_TYPE_USB3);
+ 		if (!IS_ERR(phy)) {
+ 			if (phy && phy->otg)
+ 				otg_set_peripheral(phy->otg,
+ 						(struct usb_gadget *)1);
+ 			usb_put_phy(phy);
+ 		}
+ 	}
+ 
  	dwc->ep0_trb = dma_alloc_coherent(dwc->sysdev,
  					  sizeof(*dwc->ep0_trb) * 2,
  					  &dwc->ep0_trb_addr, GFP_KERNEL);
*************** int dwc3_gadget_init(struct dwc3 *dwc)
*** 4747,4752 ****
--- 4953,4978 ----
  		goto err5;
  	}
  
+ 	if (dwc->dr_mode == USB_DR_MODE_OTG) {
+ 		struct usb_phy *phy;
+ 
+ 		phy = usb_get_phy(USB_PHY_TYPE_USB3);
+ 		if (!IS_ERR(phy)) {
+ 			if (phy && phy->otg) {
+ 				ret = otg_set_peripheral(phy->otg,
+ 						dwc->gadget);
+ 				if (ret) {
+ 					dev_err(dwc->dev,
+ 					"otg_set_peripheral failed\n");
+ 					usb_put_phy(phy);
+ 					goto err5;
+ 				}
+ 			} else {
+ 				usb_put_phy(phy);
+ 			}
+ 		}
+ 	}
+ 
  	if (DWC3_IP_IS(DWC32) && dwc->maximum_speed == USB_SPEED_SUPER_PLUS)
  		dwc3_gadget_set_ssp_rate(dwc->gadget, dwc->max_ssp_rate);
  	else
*************** err:
*** 4826,4833 ****
--- 5052,5072 ----
  
  int dwc3_gadget_resume(struct dwc3 *dwc)
  {
+ 	int reg;
+ 
  	if (!dwc->gadget_driver || !dwc->softconnect)
  		return 0;
  
+ 
+ 	/*
+ 	 * In USB 2.0, to avoid hibernation interrupt at the time of connection
+ 	 * set DWC3_DCTL_KEEP_CONNECT bit.
+ 	 */
+ 	if (dwc->has_hibernation) {
+ 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+ 		reg |= DWC3_DCTL_KEEP_CONNECT;
+ 		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+ 	}
+ 
  	return dwc3_gadget_soft_connect(dwc);
  }
```

```console
shell$ rm drivers/usb/dwc3/gadget.c.orig
```

#### Check drivers/usb/dwc3/core.h

```console
shell$ diff -p ../linux-6.12.27/drivers/usb/dwc3/core.h ../linux-6.12.42/drivers/usb/dwc3/core.h 
*** ../linux-6.12.27/drivers/usb/dwc3/core.h	2025-07-19 14:12:48.680464000 +0900
--- ../linux-6.12.42/drivers/usb/dwc3/core.h	2025-08-21 10:43:13.061569900 +0900
*************** struct dwc3_scratchpad_array {
*** 1168,1173 ****
--- 1168,1176 ----
   * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
   *		       DATWRREQINFO, and DESWRREQINFO value passed from
   *		       glue driver.
+  * @wakeup_pending_funcs: Indicates whether any interface has requested for
+  *			 function wakeup in bitmap format where bit position
+  *			 represents interface_id.
   */
  struct dwc3 {
  	struct work_struct	drd_work;
*************** struct dwc3 {
*** 1398,1403 ****
--- 1401,1407 ----
  	int			num_ep_resized;
  	struct dentry		*debug_root;
  	u32			gsbuscfg0_reqinfo;
+ 	u32			wakeup_pending_funcs;
  };
  
  #define INCRX_BURST_MODE 0
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/usb/dwc3/core.h drivers/usb/dwc3/core.h
```

Add ```wakeup_pending_funcs``` field to ```struct dwc3``` in drivers/usb/dwc3/core.h

```console
shell$ rm drivers/usb/dwc3/core.h.orig 
shell$ rm drivers/usb/dwc3/core.h.rej 
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 262_drivers-usb-dwc3.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch 
```

###  patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-264_drivers-usb-host.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-264_drivers-usb-host.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/xhci-plat.c
Hunk #8 succeeded at 386 (offset 1 line).
Hunk #9 succeeded at 488 (offset 1 line).
Hunk #10 succeeded at 520 (offset 1 line).
Hunk #11 succeeded at 616 (offset 1 line).
patching file drivers/usb/host/xhci.c
Hunk #1 succeeded at 189 (offset -23 lines).
Hunk #2 FAILED at 230.
1 out of 2 hunks FAILED -- saving rejects to file drivers/usb/host/xhci.c.rej
patching file drivers/usb/host/xhci.h
Hunk #1 succeeded at 1846 with fuzz 2 (offset 1 line).
patching file drivers/usb/host/xhci.h.orig
```

```console
shell$ diff -p ../linux-6.12.27/drivers/usb/host/xhci.c ../linux-6.12.42/drivers/usb/host/xhci.c 
*** ../linux-6.12.27/drivers/usb/host/xhci.c	2025-07-19 14:12:48.892721900 +0900
--- ../linux-6.12.42/drivers/usb/host/xhci.c	2025-08-21 10:43:13.226060000 +0900
*************** int xhci_handshake(void __iomem *ptr, u3
*** 83,111 ****
  }
  
  /*
-  * xhci_handshake_check_state - same as xhci_handshake but takes an additional
-  * exit_state parameter, and bails out with an error immediately when xhc_state
-  * has exit_state flag set.
-  */
- int xhci_handshake_check_state(struct xhci_hcd *xhci, void __iomem *ptr,
- 		u32 mask, u32 done, int usec, unsigned int exit_state)
- {
- 	u32	result;
- 	int	ret;
- 
- 	ret = readl_poll_timeout_atomic(ptr, result,
- 				(result & mask) == done ||
- 				result == U32_MAX ||
- 				xhci->xhc_state & exit_state,
- 				1, usec);
- 
- 	if (result == U32_MAX || xhci->xhc_state & exit_state)
- 		return -ENODEV;
- 
- 	return ret;
- }
- 
- /*
   * Disable interrupts and begin the xHCI halting process.
   */
  void xhci_quiesce(struct xhci_hcd *xhci)
--- 83,88 ----
*************** int xhci_reset(struct xhci_hcd *xhci, u6
*** 225,232 ****
  	if (xhci->quirks & XHCI_INTEL_HOST)
  		udelay(1000);
  
! 	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->command,
! 				CMD_RESET, 0, timeout_us, XHCI_STATE_REMOVING);
  	if (ret)
  		return ret;
  
--- 202,208 ----
  	if (xhci->quirks & XHCI_INTEL_HOST)
  		udelay(1000);
  
! 	ret = xhci_handshake(&xhci->op_regs->command, CMD_RESET, 0, timeout_us);
  	if (ret)
  		return ret;
  
*************** int xhci_resume(struct xhci_hcd *xhci, p
*** 1094,1100 ****
  		xhci_dbg(xhci, "Stop HCD\n");
  		xhci_halt(xhci);
  		xhci_zero_64b_regs(xhci);
! 		retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
  		spin_unlock_irq(&xhci->lock);
  		if (retval)
  			return retval;
--- 1070,1079 ----
  		xhci_dbg(xhci, "Stop HCD\n");
  		xhci_halt(xhci);
  		xhci_zero_64b_regs(xhci);
! 		if (xhci->xhc_state & XHCI_STATE_REMOVING)
! 			retval = -ENODEV;
! 		else
! 			retval = xhci_reset(xhci, XHCI_RESET_LONG_USEC);
  		spin_unlock_irq(&xhci->lock);
  		if (retval)
  			return retval;
```

```console
shell$ cp ../linux-6.12.27-xlnx-v2025.1/drivers/usb/host/* drivers/usb/host/
shell$ rm drivers/usb/host/xhci-plat.c.orig
shell$ rm drivers/usb/host/xhci.c.orig
shell$ rm drivers/usb/host/xhci.c.rej
shell$ rm drivers/usb/host/xhci.h.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 264_drivers-usb-host.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch 
```

### Remove patches/linux-6.12.42-xlnx-v2025.1/265_drivers-usb-misc.patch

```console
shell$ cd linux-6.12.42-xlnx-v2025.1/
shell$ git checkout v6.12.42
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1-265_drivers-usb-misc.patch
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/xxx_update-265_drivers-usb-misc.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/265_drivers-usb-misc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/265_drivers-usb-misc.patch
patching file drivers/usb/misc/onboard_usb_dev.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
3 out of 3 hunks ignored -- saving rejects to file drivers/usb/misc/onboard_usb_dev.c.rej
```

```console
shell$ cp ../linux-6.12.42/drivers/usb/misc/onboard_usb_dev.c drivers/usb/misc/onboard_usb_dev.c
shell$ rm drivers/usb/misc/onboard_usb_dev.c.rej
```

