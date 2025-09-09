Make ./paches/linux-6.12.45-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.42

```console
shell$ git clone --depth 1 -b v6.12.42 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.42
```

### Get linux-6.12.42-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.42 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.42-xlnx-v2025.1
shell$ cd linux-6.12.42-xlnx-v2025.1
shell$ git checkout -b linux-6.12.42-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.42-xlnx-v2025.1/origin_patch.sh
shell$ cd ..
```

### Get linux-6.12.45

```console
shell$ git clone --depth 1 -b v6.12.45 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.45
```

### Make diff-linux-xlnx-6.12.42-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.42-xlnx-v2025.1 -A linux-6.12.42 -B linux-6.12.42-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.42-xlnx-v2025.1.txt linux-6.12.42 linux-6.12.42-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.42-xlnx-v2025.1
## A   : {name: linux-6.12.42, path: linux-6.12.42}
## B   : {name: linux-6.12.42-xlnx-v2025.1, path: linux-6.12.42-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.42-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.42-6.12.45.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.42-6.12.45 -A linux-6.12.42 -B linux-6.12.45 -o ./make-patches/diff-linux-6.12.42-6.12.45.txt linux-6.12.42 linux-6.12.45 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.42-6.12.45
## A   : {name: linux-6.12.42, path: linux-6.12.42}
## B   : {name: linux-6.12.45, path: linux-6.12.45}
## OUT : ./make-patches/diff-linux-6.12.42-6.12.45.txt
```

### Compare diff-linux-6.12.42-6.12.45.txt and diff-linux-xlnx-6.12.42-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.42-6.12.45.txt make-patches/diff-linux-6.12.42-xlnx-v2025.1.txt 
contents: 
 - U: drivers/media/v4l2-core/v4l2-common.c
 - U: drivers/mtd/spi-nor/swp.c
 - U: drivers/net/ethernet/cadence/macb_main.c
 - U: drivers/net/ethernet/xilinx/xilinx_axienet_main.c
 - U: drivers/usb/dwc3/ep0.c
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/host/xhci-mem.c
 - U: drivers/usb/host/xhci-ring.c
 - U: drivers/usb/host/xhci.c
 - U: drivers/usb/host/xhci.h
```

### Make linux-6.12.45-xlnx-v2025.1

#### xxx_update.sh

```console
shell$ git clone --depth 1 -b v6.12.45 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.45-xlnx-v2025.1
shell$ cd linux-6.12.45-xlnx-v2025.1
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-1
shell$ sh ../patches/linux-6.12.45-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/227_drivers-mmc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch
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
Hunk #4 succeeded at 70 (offset -1 lines).
Hunk #5 succeeded at 218 (offset -2 lines).
Hunk #6 succeeded at 240 (offset -2 lines).
Hunk #7 succeeded at 254 (offset -2 lines).
Hunk #8 FAILED at 304.
Hunk #9 succeeded at 330 (offset -3 lines).
Hunk #10 succeeded at 345 (offset -3 lines).
Hunk #11 succeeded at 385 (offset -3 lines).
Hunk #12 succeeded at 525 (offset -3 lines).
Hunk #13 succeeded at 566 (offset -3 lines).
1 out of 13 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/swp.c.rej
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/230_drivers-net-ethernet.patch
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
Hunk #24 succeeded at 2135 (offset 4 lines).
Hunk #25 succeeded at 2200 (offset 4 lines).
Hunk #26 succeeded at 2432 (offset 4 lines).
Hunk #27 succeeded at 2563 (offset 4 lines).
Hunk #28 succeeded at 2633 (offset 4 lines).
Hunk #29 succeeded at 2704 (offset 4 lines).
Hunk #30 succeeded at 2765 (offset 4 lines).
Hunk #31 succeeded at 2777 (offset 4 lines).
Hunk #32 succeeded at 2934 (offset 4 lines).
Hunk #33 succeeded at 2945 (offset 4 lines).
Hunk #34 succeeded at 2967 (offset 4 lines).
Hunk #35 succeeded at 3009 (offset 4 lines).
Hunk #36 succeeded at 3057 (offset 4 lines).
Hunk #37 succeeded at 3080 (offset 4 lines).
Hunk #38 succeeded at 3239 (offset 4 lines).
Hunk #39 succeeded at 3265 (offset 4 lines).
Hunk #40 succeeded at 3325 (offset 4 lines).
Hunk #41 succeeded at 3424 (offset 4 lines).
Hunk #42 succeeded at 3492 (offset 4 lines).
Hunk #43 succeeded at 3514 (offset 4 lines).
Hunk #44 succeeded at 3539 (offset 4 lines).
Hunk #45 succeeded at 3615 (offset 4 lines).
Hunk #46 succeeded at 3627 (offset 4 lines).
Hunk #47 succeeded at 3645 (offset 4 lines).
Hunk #48 succeeded at 3689 (offset 4 lines).
Hunk #49 succeeded at 3719 (offset 4 lines).
Hunk #50 succeeded at 3880 (offset 4 lines).
Hunk #51 succeeded at 4014 (offset 4 lines).
Hunk #52 succeeded at 4271 (offset 4 lines).
Hunk #53 succeeded at 4287 (offset 4 lines).
Hunk #54 succeeded at 4358 (offset 4 lines).
Hunk #55 succeeded at 4387 (offset 4 lines).
Hunk #56 succeeded at 4413 (offset 4 lines).
Hunk #57 succeeded at 4463 (offset 4 lines).
Hunk #58 succeeded at 4841 (offset 4 lines).
Hunk #59 succeeded at 4884 (offset 4 lines).
Hunk #60 succeeded at 4895 (offset 4 lines).
Hunk #61 succeeded at 4934 (offset 4 lines).
Hunk #62 succeeded at 4993 (offset 4 lines).
Hunk #63 succeeded at 5280 (offset 4 lines).
Hunk #64 succeeded at 5406 (offset 4 lines).
Hunk #65 succeeded at 5421 (offset 4 lines).
Hunk #66 succeeded at 5509 (offset 4 lines).
Hunk #67 succeeded at 5536 (offset 4 lines).
Hunk #68 succeeded at 5553 (offset 4 lines).
Hunk #69 succeeded at 5572 (offset 4 lines).
 :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/247_drivers-spi.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
Hunk #3 FAILED at 288.
Hunk #4 succeeded at 369 (offset 2 lines).
Hunk #5 succeeded at 496 (offset 2 lines).
Hunk #6 succeeded at 514 (offset 2 lines).
Hunk #7 succeeded at 827 (offset 2 lines).
Hunk #8 succeeded at 865 (offset 2 lines).
Hunk #9 succeeded at 1178 (offset 12 lines).
1 out of 9 hunks FAILED -- saving rejects to file drivers/usb/dwc3/ep0.c.rej
patching file drivers/usb/dwc3/gadget.c
Hunk #11 FAILED at 1775.
Hunk #12 succeeded at 2009 (offset 4 lines).
Hunk #13 succeeded at 2030 (offset 4 lines).
Hunk #14 succeeded at 2260 (offset 4 lines).
Hunk #15 succeeded at 2627 (offset 4 lines).
Hunk #16 succeeded at 2702 (offset 4 lines).
Hunk #17 succeeded at 2763 (offset 4 lines).
Hunk #18 succeeded at 2794 (offset 4 lines).
Hunk #19 succeeded at 2839 (offset 4 lines).
Hunk #20 succeeded at 2862 (offset 4 lines).
Hunk #21 succeeded at 2876 (offset 4 lines).
Hunk #22 succeeded at 2978 (offset 4 lines).
Hunk #23 succeeded at 3032 (offset 4 lines).
Hunk #24 succeeded at 3050 (offset 4 lines).
Hunk #25 succeeded at 3689 (offset 4 lines).
Hunk #26 succeeded at 3699 (offset 4 lines).
Hunk #27 succeeded at 3759 (offset 4 lines).
Hunk #28 succeeded at 4116 (offset 15 lines).
Hunk #29 succeeded at 4187 (offset 15 lines).
Hunk #30 succeeded at 4241 (offset 15 lines).
Hunk #31 succeeded at 4367 (offset 15 lines).
Hunk #32 succeeded at 4406 (offset 15 lines).
Hunk #33 succeeded at 4419 (offset 15 lines).
Hunk #34 succeeded at 4562 (offset 15 lines).
Hunk #35 succeeded at 4605 (offset 15 lines).
Hunk #36 succeeded at 4647 (offset 15 lines).
Hunk #37 succeeded at 4672 (offset 15 lines).
Hunk #38 succeeded at 4692 (offset 15 lines).
Hunk #39 succeeded at 4742 (offset 15 lines).
Hunk #40 succeeded at 4794 (offset 15 lines).
Hunk #41 succeeded at 4813 (offset 15 lines).
Hunk #42 succeeded at 4856 (offset 15 lines).
Hunk #43 succeeded at 4949 (offset 15 lines).
Hunk #44 succeeded at 5044 (offset 15 lines).
1 out of 44 hunks FAILED -- saving rejects to file drivers/usb/dwc3/gadget.c.rej
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/uhci-platform.c
patching file drivers/usb/host/xhci-dbgcap.c
patching file drivers/usb/host/xhci-dbgcap.h
patching file drivers/usb/host/xhci-dbgtty.c
patching file drivers/usb/host/xhci-mem.c
Hunk #1 succeeded at 1428 (offset 2 lines).
Hunk #2 succeeded at 1961 (offset 2 lines).
Hunk #3 succeeded at 2380 (offset 2 lines).
Hunk #4 succeeded at 2387 (offset 2 lines).
Hunk #5 succeeded at 2396 (offset 2 lines).
patching file drivers/usb/host/xhci-pci.c
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci-ring.c
patching file drivers/usb/host/xhci-tegra.c
patching file drivers/usb/host/xhci.c
Hunk #2 succeeded at 214 (offset 2 lines).
Hunk #3 succeeded at 231 (offset 2 lines).
Hunk #4 succeeded at 1105 (offset 2 lines).
patching file drivers/usb/host/xhci.h
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.45-xlnx-v2025.1/999_other-document.patch
```

### Fix patches/linux-6.12.45-xlnx-v2025.1/228_drivers-mtd.patch

```console
shell$ cd linux-6.12.45-xlnx-v2025.1/
shell$ git checkout v6.12.45
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-228_drivers-mtd
shell$ sh ../patches/linux-6.12.45-xlnx-v2025.1/xxx_update-228_drivers-mtd.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/228_drivers-mtd.patch
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
Hunk #4 succeeded at 70 (offset -1 lines).
Hunk #5 succeeded at 218 (offset -2 lines).
Hunk #6 succeeded at 240 (offset -2 lines).
Hunk #7 succeeded at 254 (offset -2 lines).
Hunk #8 FAILED at 304.
Hunk #9 succeeded at 330 (offset -3 lines).
Hunk #10 succeeded at 345 (offset -3 lines).
Hunk #11 succeeded at 385 (offset -3 lines).
Hunk #12 succeeded at 525 (offset -3 lines).
Hunk #13 succeeded at 566 (offset -3 lines).
1 out of 13 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/swp.c.rej
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
```

#### Check drivers/mtd/spi-nor/swp.c

```console
shell$ diff -p ../linux-6.12.42/drivers/mtd/spi-nor/swp.c ../linux-6.12.45/drivers/mtd/spi-nor/swp.c 
*** ../linux-6.12.42/drivers/mtd/spi-nor/swp.c	2025-09-09 10:40:54.747731848 +0900
--- ../linux-6.12.45/drivers/mtd/spi-nor/swp.c	2025-09-09 10:45:54.624486917 +0900
*************** static u64 spi_nor_get_min_prot_length_s
*** 55,61 ****
  static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
  					u64 *len)
  {
- 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
  	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
--- 55,60 ----
*************** static void spi_nor_get_locked_range_sr(
*** 76,88 ****
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
--- 75,87 ----
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
*************** static bool spi_nor_is_unlocked_sr(struc
*** 157,163 ****
   */
  static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
  {
- 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	int ret, status_old, status_new;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
--- 156,161 ----
*************** static int spi_nor_sr_lock(struct spi_no
*** 182,188 ****
  		can_be_bottom = false;
  
  	/* If anything above us is unlocked, we can't use 'top' protection */
! 	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
  				  status_old))
  		can_be_top = false;
  
--- 180,186 ----
  		can_be_bottom = false;
  
  	/* If anything above us is unlocked, we can't use 'top' protection */
! 	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
  				  status_old))
  		can_be_top = false;
  
*************** static int spi_nor_sr_lock(struct spi_no
*** 194,204 ****
  
  	/* lock_len: length of region that should end up locked */
  	if (use_top)
! 		lock_len = mtd->size - ofs;
  	else
  		lock_len = ofs + len;
  
! 	if (lock_len == mtd->size) {
  		val = mask;
  	} else {
  		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
--- 192,202 ----
  
  	/* lock_len: length of region that should end up locked */
  	if (use_top)
! 		lock_len = nor->params->size - ofs;
  	else
  		lock_len = ofs + len;
  
! 	if (lock_len == nor->params->size) {
  		val = mask;
  	} else {
  		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
*************** static int spi_nor_sr_lock(struct spi_no
*** 247,253 ****
   */
  static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
  {
- 	struct mtd_info *mtd = &nor->mtd;
  	u64 min_prot_len;
  	int ret, status_old, status_new;
  	u8 mask = spi_nor_get_sr_bp_mask(nor);
--- 245,250 ----
*************** static int spi_nor_sr_unlock(struct spi_
*** 272,278 ****
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
  				    status_old))
  		can_be_bottom = false;
  
--- 269,275 ----
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
  				    status_old))
  		can_be_bottom = false;
  
*************** static int spi_nor_sr_unlock(struct spi_
*** 284,290 ****
  
  	/* lock_len: length of region that should remain locked */
  	if (use_top)
! 		lock_len = mtd->size - (ofs + len);
  	else
  		lock_len = ofs;
  
--- 281,287 ----
  
  	/* lock_len: length of region that should remain locked */
  	if (use_top)
! 		lock_len = nor->params->size - (ofs + len);
  	else
  		lock_len = ofs;
```

```console
shell$ diff -p ../linux-6.12.42/drivers/mtd/spi-nor/swp.c ../linux-6.12.42-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c 
*** ../linux-6.12.42/drivers/mtd/spi-nor/swp.c	2025-09-09 10:40:54.747731848 +0900
--- ../linux-6.12.42-xlnx-v2025.1/drivers/mtd/spi-nor/swp.c	2025-09-09 10:44:09.782730270 +0900
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
*** 33,47 ****
  
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
--- 36,57 ----
  
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
*************** static void spi_nor_get_locked_range_sr(
*** 61,66 ****
--- 71,79 ----
  	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
  	u8 bp, val = sr & mask;
  
+ 	if (nor->flags & SNOR_F_HAS_CR_TB)
+ 		sr |= tb_mask;
+ 
  	if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3_BIT6)
  		val = (val & ~SR_BP3_BIT6) | SR_BP3;
  
*************** static int spi_nor_sr_lock(struct spi_no
*** 207,212 ****
--- 220,228 ----
  
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
--- 242,248 ----
  	if (!(nor->flags & SNOR_F_NO_WP))
  		status_new |= SR_SRWD;
  
! 	if (!use_top && !(nor->flags & SNOR_F_HAS_CR_TB))
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
*************** static int spi_nor_sr_lock(struct spi_no
*** 240,245 ****
--- 256,281 ----
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
*************** static int spi_nor_sr_unlock(struct spi_
*** 268,279 ****
  		return 0;
  
  	/* If anything below us is locked, we can't use 'top' protection */
! 	if (!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old))
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
  	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
! 				    status_old))
  		can_be_bottom = false;
  
  	if (!can_be_bottom && !can_be_top)
--- 304,316 ----
  		return 0;
  
  	/* If anything below us is locked, we can't use 'top' protection */
! 	if ((!spi_nor_is_unlocked_sr(nor, 0, ofs, status_old)) ||
! 	    spi_nor_is_lower_area(nor, ofs, len))
  		can_be_top = false;
  
  	/* If anything above us is locked, we can't use 'bottom' protection */
  	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
! 				    status_old) || spi_nor_is_upper_area(nor, ofs, len))
  		can_be_bottom = false;
  
  	if (!can_be_bottom && !can_be_top)
*************** static int spi_nor_sr_unlock(struct spi_
*** 297,302 ****
--- 334,342 ----
  
  		if (nor->flags & SNOR_F_HAS_SR_BP3_BIT6 && val & SR_BP3)
  			val = (val & ~SR_BP3) | SR_BP3_BIT6;
+ 		else if (nor->flags & SNOR_F_HAS_SR_BP3_BIT5 &&
+ 			 val & SR_BP3_BIT5)
+ 			val |= SR_BP3_BIT5;
  
  		/* Some power-of-two sizes are not supported */
  		if (val & ~mask)
*************** static int spi_nor_sr_unlock(struct spi_
*** 309,315 ****
  	if (lock_len == 0)
  		status_new &= ~SR_SRWD;
  
! 	if (!use_top)
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
--- 349,355 ----
  	if (lock_len == 0)
  		status_new &= ~SR_SRWD;
  
! 	if (!use_top && !(nor->flags & SNOR_F_HAS_CR_TB))
  		status_new |= tb_mask;
  
  	/* Don't bother if they're the same */
*************** static const struct spi_nor_locking_ops
*** 349,389 ****
  
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
  
--- 389,527 ----
  
  void spi_nor_init_default_locking_ops(struct spi_nor *nor)
  {
! 	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
! 
! 	params->locking_ops = &spi_nor_sr_locking_ops;
! }
! 
! static inline u16 min_lockable_sectors(struct spi_nor *nor,
! 				       u16 n_sectors)
! {
! 	u16 lock_granularity;
! 
! 	/*
! 	 * Revisit - SST (not used by us) has the same JEDEC ID as micron but
! 	 * protected area table is similar to that of spansion.
! 	 */
! 	lock_granularity = max(1, n_sectors / M25P_MAX_LOCKABLE_SECTORS);
! 	if (nor->info->id->bytes[0] == CFI_MFR_ST ||	/* Micron */
! 	    nor->info->id->bytes[0] == CFI_MFR_PMC ||	/* ISSI */
! 	    nor->info->id->bytes[0] == CFI_MFR_MACRONIX)	/* Macronix */
! 		lock_granularity = 1;
! 
! 	return lock_granularity;
! }
! 
! static inline uint32_t get_protected_area_start(struct spi_nor *nor,
! 						u8 lock_bits)
! {
! 	struct mtd_info *mtd = &nor->mtd;
! 	u32 sector_size;
! 	u16 n_sectors;
! 	u64 mtd_size;
! 
! 	n_sectors = nor->info->size / nor->info->sector_size;
! 	sector_size = nor->info->sector_size;
! 	mtd_size = mtd->size;
! 
! 	if (nor->flags & SNOR_F_HAS_PARALLEL) {
! 		sector_size = (nor->info->sector_size >> 1);
! 		mtd_size = (mtd->size >> 1);
! 	}
! 	if (nor->flags & SNOR_F_HAS_STACKED) {
! 		n_sectors >>= 1;
! 		mtd_size = (mtd->size >> 1);
! 	}
! 
! 	return mtd_size - (1 << (lock_bits - 1)) *
! 		min_lockable_sectors(nor, n_sectors) * sector_size;
  }
  
! static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
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
*** 391,402 ****
  	if (ret)
  		return ret;
  
! 	ret = nor->params->locking_ops->is_locked(nor, ofs, len);
  
  	spi_nor_unlock_and_unprep(nor);
  	return ret;
  }
  
  /**
   * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
   * @nor:	pointer to a 'struct spi_nor'.
--- 529,561 ----
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
*** 411,433 ****
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
--- 570,604 ----
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

#### Fix drivers/mtd/spi-nor/swp.c


#### Update patches/linux-6.12.45-xlnx-v2025.1/228_drivers-mtd.patch

```console
shell$ rm drivers/mtd/spi-nor/swp.c.orig
shell$ rm drivers/mtd/spi-nor/swp.c.rej
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 228_drivers-mtd.patch"
[linux-6.12.45-xlnx-v2025.1-228_drivers-mtd 1a20cc740] [patch] 228_drivers-mtd.patch
 17 files changed, 2265 insertions(+), 311 deletions(-)
shell$ git diff HEAD^ > ../patches/linux-6.12.45-xlnx-v2025.1/228_drivers-mtd.patch
```

### Fix patches/linux-6.12.45-xlnx-v2025.1/230_drivers-net-ethernet.patch

```console
shell$ cd linux-6.12.45-xlnx-v2025.1/
shell$ git checkout v6.12.45
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-230_drivers-net-ethernet
shell$ sh ../patches/linux-6.12.45-xlnx-v2025.1/xxx_update-230_drivers-net-ethernet.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/230_drivers-net-ethernet.patch
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
Hunk #24 succeeded at 2135 (offset 4 lines).
Hunk #25 succeeded at 2200 (offset 4 lines).
Hunk #26 succeeded at 2432 (offset 4 lines).
Hunk #27 succeeded at 2563 (offset 4 lines).
Hunk #28 succeeded at 2633 (offset 4 lines).
Hunk #29 succeeded at 2704 (offset 4 lines).
Hunk #30 succeeded at 2765 (offset 4 lines).
Hunk #31 succeeded at 2777 (offset 4 lines).
Hunk #32 succeeded at 2934 (offset 4 lines).
Hunk #33 succeeded at 2945 (offset 4 lines).
Hunk #34 succeeded at 2967 (offset 4 lines).
Hunk #35 succeeded at 3009 (offset 4 lines).
Hunk #36 succeeded at 3057 (offset 4 lines).
Hunk #37 succeeded at 3080 (offset 4 lines).
Hunk #38 succeeded at 3239 (offset 4 lines).
Hunk #39 succeeded at 3265 (offset 4 lines).
Hunk #40 succeeded at 3325 (offset 4 lines).
Hunk #41 succeeded at 3424 (offset 4 lines).
Hunk #42 succeeded at 3492 (offset 4 lines).
Hunk #43 succeeded at 3514 (offset 4 lines).
Hunk #44 succeeded at 3539 (offset 4 lines).
Hunk #45 succeeded at 3615 (offset 4 lines).
Hunk #46 succeeded at 3627 (offset 4 lines).
Hunk #47 succeeded at 3645 (offset 4 lines).
Hunk #48 succeeded at 3689 (offset 4 lines).
Hunk #49 succeeded at 3719 (offset 4 lines).
Hunk #50 succeeded at 3880 (offset 4 lines).
Hunk #51 succeeded at 4014 (offset 4 lines).
Hunk #52 succeeded at 4271 (offset 4 lines).
Hunk #53 succeeded at 4287 (offset 4 lines).
Hunk #54 succeeded at 4358 (offset 4 lines).
Hunk #55 succeeded at 4387 (offset 4 lines).
Hunk #56 succeeded at 4413 (offset 4 lines).
Hunk #57 succeeded at 4463 (offset 4 lines).
Hunk #58 succeeded at 4841 (offset 4 lines).
Hunk #59 succeeded at 4884 (offset 4 lines).
Hunk #60 succeeded at 4895 (offset 4 lines).
Hunk #61 succeeded at 4934 (offset 4 lines).
Hunk #62 succeeded at 4993 (offset 4 lines).
Hunk #63 succeeded at 5280 (offset 4 lines).
Hunk #64 succeeded at 5406 (offset 4 lines).
Hunk #65 succeeded at 5421 (offset 4 lines).
Hunk #66 succeeded at 5509 (offset 4 lines).
Hunk #67 succeeded at 5536 (offset 4 lines).
Hunk #68 succeeded at 5553 (offset 4 lines).
Hunk #69 succeeded at 5572 (offset 4 lines).
patching file drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
patching file drivers/net/ethernet/xilinx/xilinx_emaclite.c
```

#### Check drivers/net/ethernet/xilinx/xilinx_axienet_main.c

```console
shell$ diff -p ../linux-6.12.42/drivers/net/ethernet/xilinx/xilinx_axienet_main.c ../linux-6.12.45/drivers/net/ethernet/xilinx/xilinx_axienet_main.c 
*** ../linux-6.12.42/drivers/net/ethernet/xilinx/xilinx_axienet_main.c	2025-09-09 10:40:55.243093522 +0900
--- ../linux-6.12.45/drivers/net/ethernet/xilinx/xilinx_axienet_main.c	2025-09-09 10:45:55.127343560 +0900
*************** static void axienet_dma_rx_cb(void *data
*** 1119,1124 ****
--- 1119,1125 ----
  	struct axienet_local *lp = data;
  	struct sk_buff *skb;
  	u32 *app_metadata;
+ 	int i;
  
  	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
  	skb = skbuf_dma->skb;
*************** static void axienet_dma_rx_cb(void *data
*** 1137,1143 ****
  	u64_stats_add(&lp->rx_packets, 1);
  	u64_stats_add(&lp->rx_bytes, rx_len);
  	u64_stats_update_end(&lp->rx_stat_sync);
! 	axienet_rx_submit_desc(lp->ndev);
  	dma_async_issue_pending(lp->rx_chan);
  }
  
--- 1138,1147 ----
  	u64_stats_add(&lp->rx_packets, 1);
  	u64_stats_add(&lp->rx_bytes, rx_len);
  	u64_stats_update_end(&lp->rx_stat_sync);
! 
! 	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
! 				   RX_BUF_NUM_DEFAULT); i++)
! 		axienet_rx_submit_desc(lp->ndev);
  	dma_async_issue_pending(lp->rx_chan);
  }
  
*************** static void axienet_rx_submit_desc(struc
*** 1394,1400 ****
  	if (!skbuf_dma)
  		return;
  
- 	lp->rx_ring_head++;
  	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
  	if (!skb)
  		return;
--- 1398,1403 ----
*************** static void axienet_rx_submit_desc(struc
*** 1419,1424 ****
--- 1422,1428 ----
  	skbuf_dma->desc = dma_rx_desc;
  	dma_rx_desc->callback_param = lp;
  	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+ 	lp->rx_ring_head++;
  	dmaengine_submit(dma_rx_desc);
  
  	return;
```

#### Update patches/linux-6.12.45-xlnx-v2025.1/230_drivers-net-ethernet.patch

```console
shell$ rm drivers/net/ethernet/xilinx/xilinx_axienet_main.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 230_drivers-net-ethernet.patch"
[linux-6.12.45-xlnx-v2025.1-230_drivers-net-ethernet e026fd8dd] [patch] 230_drivers-net-ethernet.patch
 14 files changed, 7058 insertions(+), 851 deletions(-)
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
shell$ git diff HEAD^ > ../patches/linux-6.12.45-xlnx-v2025.1/230_drivers-net-ethernet.patch
```

### Fix patches/linux-6.12.45-xlnx-v2025.1/262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.45-xlnx-v2025.1/
shell$ git checkout v6.12.45
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-262_drivers-usb-dwc3
shell$ sh ../patches/linux-6.12.45-xlnx-v2025.1/xxx_update-262_drivers-usb-dwc3.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
patching file drivers/usb/dwc3/ep0.c
Hunk #3 FAILED at 288.
Hunk #4 succeeded at 369 (offset 2 lines).
Hunk #5 succeeded at 496 (offset 2 lines).
Hunk #6 succeeded at 514 (offset 2 lines).
Hunk #7 succeeded at 827 (offset 2 lines).
Hunk #8 succeeded at 865 (offset 2 lines).
Hunk #9 succeeded at 1178 (offset 12 lines).
1 out of 9 hunks FAILED -- saving rejects to file drivers/usb/dwc3/ep0.c.rej
patching file drivers/usb/dwc3/gadget.c
Hunk #11 FAILED at 1775.
Hunk #12 succeeded at 2009 (offset 4 lines).
Hunk #13 succeeded at 2030 (offset 4 lines).
Hunk #14 succeeded at 2260 (offset 4 lines).
Hunk #15 succeeded at 2627 (offset 4 lines).
Hunk #16 succeeded at 2702 (offset 4 lines).
Hunk #17 succeeded at 2763 (offset 4 lines).
Hunk #18 succeeded at 2794 (offset 4 lines).
Hunk #19 succeeded at 2839 (offset 4 lines).
Hunk #20 succeeded at 2862 (offset 4 lines).
Hunk #21 succeeded at 2876 (offset 4 lines).
Hunk #22 succeeded at 2978 (offset 4 lines).
Hunk #23 succeeded at 3032 (offset 4 lines).
Hunk #24 succeeded at 3050 (offset 4 lines).
Hunk #25 succeeded at 3689 (offset 4 lines).
Hunk #26 succeeded at 3699 (offset 4 lines).
Hunk #27 succeeded at 3759 (offset 4 lines).
Hunk #28 succeeded at 4116 (offset 15 lines).
Hunk #29 succeeded at 4187 (offset 15 lines).
Hunk #30 succeeded at 4241 (offset 15 lines).
Hunk #31 succeeded at 4367 (offset 15 lines).
Hunk #32 succeeded at 4406 (offset 15 lines).
Hunk #33 succeeded at 4419 (offset 15 lines).
Hunk #34 succeeded at 4562 (offset 15 lines).
Hunk #35 succeeded at 4605 (offset 15 lines).
Hunk #36 succeeded at 4647 (offset 15 lines).
Hunk #37 succeeded at 4672 (offset 15 lines).
Hunk #38 succeeded at 4692 (offset 15 lines).
Hunk #39 succeeded at 4742 (offset 15 lines).
Hunk #40 succeeded at 4794 (offset 15 lines).
Hunk #41 succeeded at 4813 (offset 15 lines).
Hunk #42 succeeded at 4856 (offset 15 lines).
Hunk #43 succeeded at 4949 (offset 15 lines).
Hunk #44 succeeded at 5044 (offset 15 lines).
1 out of 44 hunks FAILED -- saving rejects to file drivers/usb/dwc3/gadget.c.rej
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```

#### Modify drivers/usb/dwc3/ep0.c

```console
shell$ diff -p ../linux-6.12.42/drivers/usb/dwc3/ep0.c ../linux-6.12.45/drivers/usb/dwc3/ep0.c 
*** ../linux-6.12.42/drivers/usb/dwc3/ep0.c	2025-09-09 10:40:56.457326638 +0900
--- ../linux-6.12.45/drivers/usb/dwc3/ep0.c	2025-09-09 10:45:56.380427259 +0900
*************** void dwc3_ep0_out_start(struct dwc3 *dwc
*** 288,294 ****
  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
  			DWC3_TRBCTL_CONTROL_SETUP, false);
  	ret = dwc3_ep0_start_trans(dep);
! 	WARN_ON(ret < 0);
  	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
  		struct dwc3_ep *dwc3_ep;
  
--- 288,296 ----
  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
  			DWC3_TRBCTL_CONTROL_SETUP, false);
  	ret = dwc3_ep0_start_trans(dep);
! 	if (ret < 0)
! 		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
! 
  	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
  		struct dwc3_ep *dwc3_ep;
  
*************** static void __dwc3_ep0_do_control_data(s
*** 1061,1067 ****
  		ret = dwc3_ep0_start_trans(dep);
  	}
  
! 	WARN_ON(ret < 0);
  }
  
  static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
--- 1063,1071 ----
  		ret = dwc3_ep0_start_trans(dep);
  	}
  
! 	if (ret < 0)
! 		dev_err(dwc->dev,
! 			"ep0 data phase start transfer failed: %d\n", ret);
  }
  
  static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
*************** static int dwc3_ep0_start_control_status
*** 1078,1084 ****
  
  static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
  {
! 	WARN_ON(dwc3_ep0_start_control_status(dep));
  }
  
  static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
--- 1082,1093 ----
  
  static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
  {
! 	int	ret;
! 
! 	ret = dwc3_ep0_start_control_status(dep);
! 	if (ret)
! 		dev_err(dwc->dev,
! 			"ep0 status phase start transfer failed: %d\n", ret);
  }
  
  static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
*************** void dwc3_ep0_end_control_data(struct dw
*** 1121,1127 ****
  	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
  	memset(&params, 0, sizeof(params));
  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
! 	WARN_ON_ONCE(ret);
  	dep->resource_index = 0;
  }
  
--- 1130,1139 ----
  	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
  	memset(&params, 0, sizeof(params));
  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
! 	if (ret)
! 		dev_err_ratelimited(dwc->dev,
! 			"ep0 data phase end transfer failed: %d\n", ret);
! 
  	dep->resource_index = 0;
  }
  
```

```console
shell$ cp ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/ep0.c drivers/usb/dwc3/ep0.c
```

modify drivers/usb/dwc3/ep0.c

```console
shell$ diff -p ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/ep0.c drivers/usb/dwc3/ep0.c 
*** ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/ep0.c	2025-09-09 10:44:15.800961973 +0900
--- drivers/usb/dwc3/ep0.c	2025-09-09 15:41:18.038139868 +0900
*************** void dwc3_ep0_out_start(struct dwc3 *dwc
*** 287,293 ****
  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
  			DWC3_TRBCTL_CONTROL_SETUP, false);
  	ret = dwc3_ep0_start_trans(dep);
! 	WARN_ON(ret < 0);
  }
  
  static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
--- 287,294 ----
  	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
  			DWC3_TRBCTL_CONTROL_SETUP, false);
  	ret = dwc3_ep0_start_trans(dep);
! 	if (ret < 0)
! 		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
  }
  
  static struct dwc3_ep *dwc3_wIndex_to_dep(struct dwc3 *dwc, __le16 wIndex_le)
*************** static void __dwc3_ep0_do_control_data(s
*** 1081,1087 ****
  		ret = dwc3_ep0_start_trans(dep);
  	}
  
! 	WARN_ON(ret < 0);
  }
  
  static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
--- 1082,1090 ----
  		ret = dwc3_ep0_start_trans(dep);
  	}
  
! 	if (ret < 0)
! 		dev_err(dwc->dev,
! 			"ep0 data phase start transfer failed: %d\n", ret);
  }
  
  static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
*************** static int dwc3_ep0_start_control_status
*** 1098,1104 ****
  
  static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
  {
! 	WARN_ON(dwc3_ep0_start_control_status(dep));
  }
  
  static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
--- 1101,1112 ----
  
  static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
  {
! 	int	ret;
! 
! 	ret = dwc3_ep0_start_control_status(dep);
! 	if (ret)
! 		dev_err(dwc->dev,
! 			"ep0 status phase start transfer failed: %d\n", ret);
  }
  
  static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
*************** void dwc3_ep0_end_control_data(struct dw
*** 1141,1147 ****
  	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
  	memset(&params, 0, sizeof(params));
  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
! 	WARN_ON_ONCE(ret);
  	dep->resource_index = 0;
  }
  
--- 1149,1158 ----
  	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
  	memset(&params, 0, sizeof(params));
  	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
! 	if (ret)
! 		dev_err_ratelimited(dwc->dev,
! 			"ep0 data phase end transfer failed: %d\n", ret);
! 
  	dep->resource_index = 0;
  }
  
```

#### Modify drivers/usb/dwc3/gadget.c

```console
shell$ diff -p ../linux-6.12.42/drivers/usb/dwc3/gadget.c ../linux-6.12.45/drivers/usb/dwc3/gadget.c 
*** ../linux-6.12.42/drivers/usb/dwc3/gadget.c	2025-09-09 10:40:56.457326638 +0900
--- ../linux-6.12.45/drivers/usb/dwc3/gadget.c	2025-09-09 10:45:56.380427259 +0900
*************** static int __dwc3_stop_active_transfer(s
*** 1763,1769 ****
  		dep->flags |= DWC3_EP_DELAY_STOP;
  		return 0;
  	}
! 	WARN_ON_ONCE(ret);
  	dep->resource_index = 0;
  
  	if (!interrupt)
--- 1763,1773 ----
  		dep->flags |= DWC3_EP_DELAY_STOP;
  		return 0;
  	}
! 
! 	if (ret)
! 		dev_err_ratelimited(dep->dwc->dev,
! 				"end transfer failed: %d\n", ret);
! 
  	dep->resource_index = 0;
  
  	if (!interrupt)
*************** static void dwc3_gadget_endpoint_transfe
*** 3707,3712 ****
--- 3711,3725 ----
  static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
  		const struct dwc3_event_depevt *event)
  {
+ 	/*
+ 	 * During a device-initiated disconnect, a late xferNotReady event can
+ 	 * be generated after the End Transfer command resets the event filter,
+ 	 * but before the controller is halted. Ignore it to prevent a new
+ 	 * transfer from starting.
+ 	 */
+ 	if (!dep->dwc->connected)
+ 		return;
+ 
  	dwc3_gadget_endpoint_frame_from_event(dep, event);
  
  	/*
*************** static void dwc3_clear_stall_all_ep(stru
*** 4008,4014 ****
  		dep->flags &= ~DWC3_EP_STALL;
  
  		ret = dwc3_send_clear_stall_ep_cmd(dep);
! 		WARN_ON_ONCE(ret);
  	}
  }
  
--- 4021,4029 ----
  		dep->flags &= ~DWC3_EP_STALL;
  
  		ret = dwc3_send_clear_stall_ep_cmd(dep);
! 		if (ret)
! 			dev_err_ratelimited(dwc->dev,
! 				"failed to clear STALL on %s\n", dep->name);
  	}
  }
  
```

```console
shell$ cp ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/gadget.c drivers/usb/dwc3/gadget.c
```

modify drivers/usb/dwc3/gadget.c

```console
shell$ diff -p ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/gadget.c drivers/usb/dwc3/gadget.c
*** ../linux-6.12.42-xlnx-v2025.1/drivers/usb/dwc3/gadget.c	2025-09-09 10:44:15.800961973 +0900
--- drivers/usb/dwc3/gadget.c	2025-09-09 16:03:00.680703573 +0900
*************** static int __dwc3_stop_active_transfer(s
*** 1774,1780 ****
  		dep->flags |= DWC3_EP_DELAY_STOP;
  		return 0;
  	}
! 	WARN_ON_ONCE(ret);
  
  	/*
  	 * when transfer is stopped with force rm bit false, it can be
--- 1774,1783 ----
  		dep->flags |= DWC3_EP_DELAY_STOP;
  		return 0;
  	}
! 
! 	if (ret)
! 		dev_err_ratelimited(dep->dwc->dev,
! 				"end transfer failed: %d\n", ret);
  
  	/*
  	 * when transfer is stopped with force rm bit false, it can be
*************** static void dwc3_gadget_endpoint_transfe
*** 3785,3790 ****
--- 3788,3802 ----
  static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
  		const struct dwc3_event_depevt *event)
  {
+ 	/*
+ 	 * During a device-initiated disconnect, a late xferNotReady event can
+ 	 * be generated after the End Transfer command resets the event filter,
+ 	 * but before the controller is halted. Ignore it to prevent a new
+ 	 * transfer from starting.
+ 	 */
+ 	if (!dep->dwc->connected)
+ 		return;
+ 
  	dwc3_gadget_endpoint_frame_from_event(dep, event);
  
  	/*
*************** static void dwc3_clear_stall_all_ep(stru
*** 4086,4092 ****
  		dep->flags &= ~DWC3_EP_STALL;
  
  		ret = dwc3_send_clear_stall_ep_cmd(dep);
! 		WARN_ON_ONCE(ret);
  	}
  }
  
--- 4098,4106 ----
  		dep->flags &= ~DWC3_EP_STALL;
  
  		ret = dwc3_send_clear_stall_ep_cmd(dep);
! 		if (ret)
! 			dev_err_ratelimited(dwc->dev,
! 				"failed to clear STALL on %s\n", dep->name);
  	}
  }
  
```

#### Update patches/linux-6.12.45-xlnx-v2025.1/262_drivers-usb-dwc3.patch

```console
shell$ rm drivers/usb/dwc3/ep0.c.orig
shell$ rm drivers/usb/dwc3/ep0.c.rej
shell$ rm drivers/usb/dwc3/gadget.c.orig
shell$ rm drivers/usb/dwc3/gadget.c.rej
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 262_drivers-usb-dwc3.patch"
[linux-6.12.45-xlnx-v2025.1-262_drivers-usb-dwc3 2e3be7328] [patch] 262_drivers-usb-dwc3.patch
 16 files changed, 4383 insertions(+), 119 deletions(-)
 create mode 100644 drivers/usb/dwc3/gadget_hibernation.c
 create mode 100644 drivers/usb/dwc3/otg.c
 create mode 100644 drivers/usb/dwc3/otg.h
 create mode 100644 drivers/usb/dwc3/platform_data.h
shell$ git diff HEAD^ > ../patches/linux-6.12.45-xlnx-v2025.1/262_drivers-usb-dwc3.patch
```


### Fix patches/linux-6.12.45-xlnx-v2025.1/264_drivers-usb-host.patch

```console
shell$ cd linux-6.12.45-xlnx-v2025.1/
shell$ git checkout v6.12.45
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-264_drivers-usb-host
shell$ sh ../patches/linux-6.12.45-xlnx-v2025.1/xxx_update-264_drivers-usb-host.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.42-xlnx-v2025.1/264_drivers-usb-host.patch
patching file drivers/usb/host/Kconfig
patching file drivers/usb/host/uhci-platform.c
patching file drivers/usb/host/xhci-dbgcap.c
patching file drivers/usb/host/xhci-dbgcap.h
patching file drivers/usb/host/xhci-dbgtty.c
patching file drivers/usb/host/xhci-mem.c
Hunk #1 succeeded at 1428 (offset 2 lines).
Hunk #2 succeeded at 1961 (offset 2 lines).
Hunk #3 succeeded at 2380 (offset 2 lines).
Hunk #4 succeeded at 2387 (offset 2 lines).
Hunk #5 succeeded at 2396 (offset 2 lines).
patching file drivers/usb/host/xhci-pci.c
patching file drivers/usb/host/xhci-plat.c
patching file drivers/usb/host/xhci-ring.c
patching file drivers/usb/host/xhci-tegra.c
patching file drivers/usb/host/xhci.c
Hunk #2 succeeded at 214 (offset 2 lines).
Hunk #3 succeeded at 231 (offset 2 lines).
Hunk #4 succeeded at 1105 (offset 2 lines).
patching file drivers/usb/host/xhci.h
```

#### Check drivers/usb/host/xhci-mem.c

```console
shell$ diff -p ../linux-6.12.42/drivers/usb/host/xhci-mem.c ../linux-6.12.45/drivers/usb/host/xhci-mem.c 
*** ../linux-6.12.42/drivers/usb/host/xhci-mem.c	2025-09-09 10:40:56.505251762 +0900
--- ../linux-6.12.45/drivers/usb/host/xhci-mem.c	2025-09-09 10:45:56.416342525 +0900
*************** free_tts:
*** 842,862 ****
   * will be manipulated by the configure endpoint, allocate device, or update
   * hub functions while this function is removing the TT entries from the list.
   */
! void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
  {
- 	struct xhci_virt_device *dev;
  	int i;
  	int old_active_eps = 0;
  
  	/* Slot ID 0 is reserved */
! 	if (slot_id == 0 || !xhci->devs[slot_id])
  		return;
  
! 	dev = xhci->devs[slot_id];
! 
! 	xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
! 	if (!dev)
! 		return;
  
  	trace_xhci_free_virt_device(dev);
  
--- 842,861 ----
   * will be manipulated by the configure endpoint, allocate device, or update
   * hub functions while this function is removing the TT entries from the list.
   */
! void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
! 		int slot_id)
  {
  	int i;
  	int old_active_eps = 0;
  
  	/* Slot ID 0 is reserved */
! 	if (slot_id == 0 || !dev)
  		return;
  
! 	/* If device ctx array still points to _this_ device, clear it */
! 	if (dev->out_ctx &&
! 	    xhci->dcbaa->dev_context_ptrs[slot_id] == cpu_to_le64(dev->out_ctx->dma))
! 		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
  
  	trace_xhci_free_virt_device(dev);
  
*************** void xhci_free_virt_device(struct xhci_h
*** 897,904 ****
  		dev->udev->slot_id = 0;
  	if (dev->rhub_port && dev->rhub_port->slot_id == slot_id)
  		dev->rhub_port->slot_id = 0;
! 	kfree(xhci->devs[slot_id]);
! 	xhci->devs[slot_id] = NULL;
  }
  
  /*
--- 896,904 ----
  		dev->udev->slot_id = 0;
  	if (dev->rhub_port && dev->rhub_port->slot_id == slot_id)
  		dev->rhub_port->slot_id = 0;
! 	if (xhci->devs[slot_id] == dev)
! 		xhci->devs[slot_id] = NULL;
! 	kfree(dev);
  }
  
  /*
*************** static void xhci_free_virt_devices_depth
*** 939,945 ****
  out:
  	/* we are now at a leaf device */
  	xhci_debugfs_remove_slot(xhci, slot_id);
! 	xhci_free_virt_device(xhci, slot_id);
  }
  
  int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
--- 939,945 ----
  out:
  	/* we are now at a leaf device */
  	xhci_debugfs_remove_slot(xhci, slot_id);
! 	xhci_free_virt_device(xhci, vdev, slot_id);
  }
  
  int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
*************** int xhci_setup_addressable_virt_dev(stru
*** 1172,1177 ****
--- 1172,1179 ----
  	ep0_ctx->deq = cpu_to_le64(dev->eps[0].ring->first_seg->dma |
  				   dev->eps[0].ring->cycle_state);
  
+ 	ep0_ctx->tx_info = cpu_to_le32(EP_AVG_TRB_LENGTH(8));
+ 
  	trace_xhci_setup_addressable_virt_device(dev);
  
  	/* Steps 7 and 8 were done in xhci_alloc_virt_device() */
```


#### Check drivers/usb/host/xhci.c

```console
shell$ diff -p ../linux-6.12.42/drivers/usb/host/xhci.c ../linux-6.12.45/drivers/usb/host/xhci.c 
*** ../linux-6.12.42/drivers/usb/host/xhci.c	2025-09-09 10:40:56.505251762 +0900
--- ../linux-6.12.45/drivers/usb/host/xhci.c	2025-09-09 10:45:56.420333111 +0900
*************** int xhci_halt(struct xhci_hcd *xhci)
*** 119,125 ****
  	ret = xhci_handshake(&xhci->op_regs->status,
  			STS_HALT, STS_HALT, XHCI_MAX_HALT_USEC);
  	if (ret) {
! 		xhci_warn(xhci, "Host halt failed, %d\n", ret);
  		return ret;
  	}
  
--- 119,126 ----
  	ret = xhci_handshake(&xhci->op_regs->status,
  			STS_HALT, STS_HALT, XHCI_MAX_HALT_USEC);
  	if (ret) {
! 		if (!(xhci->xhc_state & XHCI_STATE_DYING))
! 			xhci_warn(xhci, "Host halt failed, %d\n", ret);
  		return ret;
  	}
  
*************** int xhci_reset(struct xhci_hcd *xhci, u6
*** 178,184 ****
  	state = readl(&xhci->op_regs->status);
  
  	if (state == ~(u32)0) {
! 		xhci_warn(xhci, "Host not accessible, reset failed.\n");
  		return -ENODEV;
  	}
  
--- 179,186 ----
  	state = readl(&xhci->op_regs->status);
  
  	if (state == ~(u32)0) {
! 		if (!(xhci->xhc_state & XHCI_STATE_DYING))
! 			xhci_warn(xhci, "Host not accessible, reset failed.\n");
  		return -ENODEV;
  	}
  
*************** static int xhci_discover_or_reset_device
*** 3761,3768 ****
  		 * Obtaining a new device slot to inform the xHCI host that
  		 * the USB device has been reset.
  		 */
! 		ret = xhci_disable_slot(xhci, udev->slot_id);
! 		xhci_free_virt_device(xhci, udev->slot_id);
  		if (!ret) {
  			ret = xhci_alloc_dev(hcd, udev);
  			if (ret == 1)
--- 3763,3769 ----
  		 * Obtaining a new device slot to inform the xHCI host that
  		 * the USB device has been reset.
  		 */
! 		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
  		if (!ret) {
  			ret = xhci_alloc_dev(hcd, udev);
  			if (ret == 1)
*************** static void xhci_free_dev(struct usb_hcd
*** 3917,3923 ****
  	xhci_disable_slot(xhci, udev->slot_id);
  
  	spin_lock_irqsave(&xhci->lock, flags);
! 	xhci_free_virt_device(xhci, udev->slot_id);
  	spin_unlock_irqrestore(&xhci->lock, flags);
  
  }
--- 3918,3924 ----
  	xhci_disable_slot(xhci, udev->slot_id);
  
  	spin_lock_irqsave(&xhci->lock, flags);
! 	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
  	spin_unlock_irqrestore(&xhci->lock, flags);
  
  }
*************** int xhci_disable_slot(struct xhci_hcd *x
*** 3966,3971 ****
--- 3967,3982 ----
  	return 0;
  }
  
+ int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id)
+ {
+ 	struct xhci_virt_device *vdev = xhci->devs[slot_id];
+ 	int ret;
+ 
+ 	ret = xhci_disable_slot(xhci, slot_id);
+ 	xhci_free_virt_device(xhci, vdev, slot_id);
+ 	return ret;
+ }
+ 
  /*
   * Checks if we have enough host controller resources for the default control
   * endpoint.
*************** int xhci_alloc_dev(struct usb_hcd *hcd,
*** 4072,4079 ****
  	return 1;
  
  disable_slot:
! 	xhci_disable_slot(xhci, udev->slot_id);
! 	xhci_free_virt_device(xhci, udev->slot_id);
  
  	return 0;
  }
--- 4083,4089 ----
  	return 1;
  
  disable_slot:
! 	xhci_disable_and_free_slot(xhci, udev->slot_id);
  
  	return 0;
  }
*************** static int xhci_setup_device(struct usb_
*** 4209,4216 ****
  		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
  
  		mutex_unlock(&xhci->mutex);
! 		ret = xhci_disable_slot(xhci, udev->slot_id);
! 		xhci_free_virt_device(xhci, udev->slot_id);
  		if (!ret) {
  			if (xhci_alloc_dev(hcd, udev) == 1)
  				xhci_setup_addressable_virt_dev(xhci, udev);
--- 4219,4225 ----
  		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
  
  		mutex_unlock(&xhci->mutex);
! 		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
  		if (!ret) {
  			if (xhci_alloc_dev(hcd, udev) == 1)
  				xhci_setup_addressable_virt_dev(xhci, udev);
```

#### Update patches/linux-6.12.45-xlnx-v2025.1/264_drivers-usb-host.patch

```console
shell$ rm drivers/usb/host/xhci-mem.c.orig
shell$ rm drivers/usb/host/xhci.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 264_drivers-usb-host.patch"
[linux-6.12.45-xlnx-v2025.1-264_drivers-usb-host 008771262] [patch] 264_drivers-usb-host.patch
 12 files changed, 149 insertions(+), 102 deletions(-)
shell$ git diff HEAD^ > ../patches/linux-6.12.45-xlnx-v2025.1/264_drivers-usb-host.patch
```

### Add patches/linux-6.12.45-xlnx-v2025.1/001_Makefile.patch

```console
shell$ cd linux-6.12.45-xlnx-v2025.1/
shell$ git checkout v6.12.45
shell$ git checkout -b linux-6.12.45-xlnx-v2025.1-001_Makefile
```

#### Update Makefile 

```console
shell$ git diff Makefile
diff --git a/Makefile b/Makefile
index cc59990e3..2ee3a8847 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 12
 SUBLEVEL = 45
-EXTRAVERSION =
+EXTRAVERSION = -zynqmp-fpga
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
```

#### Add patches/linux-6.12.45-xlnx-v2025.1/001_Makefile.patch

```console
shell$ git add Makefile 
shell$ git commit -m "[patch] 001_Makefile.patch"
[linux-6.12.45-xlnx-v2025.1-001_Makefile.patch 0b16a2813] [patch] 001_Makefile.patch
 1 file changed, 1 insertion(+), 1 deletion(-)
shell$ git diff HEAD^ > ../patches/linux-6.12.45-xlnx-v2025.1/001_Makefile.patch
```
