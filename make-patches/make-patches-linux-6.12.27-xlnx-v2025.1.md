Make ./paches/linux-6.12.27-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.19

```console
shell$ git clone --depth 1 -b v6.12.19 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.19
```

### Get linux-6.12.19-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.19 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.19-xlnx-v2025.1
shell$ cd linux-6.12.19-xlnx-v2025.1
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/origin_patch.sh
shell$ cd
```

### Get linux-6.12.27

```console
shell$ git clone --depth 1 -b v6.12.27 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.27
```

### Make diff-linux-xlnx-6.12.19-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.19-xlnx-v2025.1 -A linux-6.12.19 -B linux-6.12.19-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.19-xlnx-v2025.1.txt linux-6.12.19 linux-6.12.19-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.19-xlnx-v2025.1
## A   : {name: linux-6.12.19, path: linux-6.12.19}
## B   : {name: linux-6.12.19-xlnx-v2025.1, path: linux-6.12.19-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.19-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.19-6.12.27.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.19-6.12.27 -A linux-6.12.19 -B linux-6.12.27 -o ./make-patches/diff-linux-6.12.19-6.12.27.txt linux-6.12.19 linux-6.12.27 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.19-6.12.27
## A   : {name: linux-6.12.19, path: linux-6.12.19}
## B   : {name: linux-6.12.27, path: linux-6.12.27}
## OUT : ./make-patches/diff-linux-6.12.19-6.12.27.txt
```

### Compare diff-linux-6.12.19-6.12.27.txt and diff-linux-xlnx-6.12.19-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.19-6.12.27.txt make-patches/diff-linux-6.12.19-xlnx-v2025.1.txt 
contents: 
 - U: drivers/gpu/drm/drm_atomic_uapi.c
 - U: drivers/gpu/drm/drm_connector.c
 - U: drivers/gpu/drm/xlnx/zynqmp_dpsub.c
 - U: drivers/media/i2c/Kconfig
 - U: drivers/pci/controller/pcie-xilinx-cpm.c
 - U: drivers/spi/spi-cadence-quadspi.c
 - U: drivers/ufs/core/ufshcd.c
 - U: drivers/usb/dwc3/dwc3-xilinx.c
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/host/xhci-plat.c
 - U: drivers/usb/host/xhci.c
 - U: drivers/usb/host/xhci.h
 - U: drivers/xen/Kconfig
 - U: fs/nfsd/nfs4recover.c
```

### Make linux-6.12.27-xlnx-v2025.1

#### xxx_update.sh

```console
shell$ git clone --depth 1 -b v6.12.27 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.27-xlnx-v2025.1
shell$ cd linux-6.12.27-xlnx-v2025.1
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-1
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/103_fs-nfsd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/103_fs-nfsd.patch
patching file fs/nfsd/nfs4recover.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file fs/nfsd/nfs4recover.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/206_drivers-edac.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/210_drivers-gpu-drm.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/210_drivers-gpu-drm.patch
  :
patching file drivers/gpu/drm/drm_connector.c
Hunk #1 succeeded at 1531 (offset 4 lines).
Hunk #2 succeeded at 1703 (offset 4 lines).
patching file drivers/gpu/drm/drm_connector.c.orig
  :
patching file drivers/gpu/drm/xlnx/zynqmp_dpsub.c
Hunk #3 succeeded at 209 with fuzz 2 (offset 2 lines).
Hunk #4 succeeded at 244 (offset 2 lines).
Hunk #5 succeeded at 274 (offset 2 lines).
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/219_drivers-media-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/227_drivers-mmc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/228_drivers-mtd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/230_drivers-net-ethernet.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/236_drivers-pci.patch
 :
Hunk #13 FAILED at 636.
Hunk #14 FAILED at 670.
Hunk #15 succeeded at 697 (offset 2 lines).
2 out of 15 hunks FAILED -- saving rejects to file drivers/pci/controller/pcie-xilinx-cpm.c.rej
 :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/247_drivers-spi.patch
  :
patching file drivers/spi/spi-cadence-quadspi.c
Hunk #29 succeeded at 2102 (offset 6 lines).
Hunk #30 succeeded at 2250 (offset 6 lines).
Hunk #31 succeeded at 2333 (offset 6 lines).
Hunk #32 succeeded at 2354 (offset 6 lines).
Hunk #33 succeeded at 2369 (offset 6 lines).
Hunk #34 succeeded at 2431 (offset 6 lines).
Hunk #35 succeeded at 2485 (offset 6 lines).
Hunk #36 succeeded at 2536 (offset 6 lines).
Hunk #37 succeeded at 2604 (offset 6 lines).
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/251_drivers-ufs.patch
  :
patching file drivers/ufs/core/ufshcd.c
Hunk #1 succeeded at 6986 (offset 7 lines).
Hunk #2 succeeded at 8850 (offset 7 lines).
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/261_drivers-usb-chipidea.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/262_drivers-usb-dwc3.patch
  :
patching file drivers/usb/dwc3/dwc3-xilinx.c
Hunk #9 succeeded at 595 (offset -2 lines).
Hunk #10 succeeded at 715 (offset -2 lines).
Hunk #11 succeeded at 804 (offset -2 lines).
Hunk #12 succeeded at 845 (offset -2 lines).
Hunk #13 succeeded at 887 (offset -2 lines).
Hunk #14 succeeded at 907 (offset -2 lines).
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
Hunk #3 succeeded at 658 (offset 6 lines).
Hunk #4 succeeded at 897 (offset 8 lines).
Hunk #5 succeeded at 905 (offset 8 lines).
Hunk #6 succeeded at 921 (offset 8 lines).
Hunk #7 succeeded at 942 (offset 8 lines).
Hunk #8 succeeded at 964 (offset 8 lines).
Hunk #9 succeeded at 1062 (offset 8 lines).
Hunk #10 succeeded at 1660 (offset 8 lines).
Hunk #11 succeeded at 1777 (offset 8 lines).
Hunk #12 succeeded at 2013 (offset 8 lines).
Hunk #13 succeeded at 2034 (offset 8 lines).
Hunk #14 succeeded at 2264 (offset 8 lines).
Hunk #15 succeeded at 2657 (offset 8 lines).
Hunk #16 succeeded at 2732 (offset 8 lines).
Hunk #17 succeeded at 2793 (offset 8 lines).
Hunk #18 succeeded at 2824 (offset 8 lines).
Hunk #19 succeeded at 2869 (offset 8 lines).
Hunk #20 succeeded at 2892 (offset 8 lines).
Hunk #21 succeeded at 2906 (offset 8 lines).
Hunk #22 succeeded at 3008 (offset 8 lines).
Hunk #23 succeeded at 3062 (offset 8 lines).
Hunk #24 succeeded at 3080 (offset 8 lines).
Hunk #25 succeeded at 3719 (offset 8 lines).
Hunk #26 succeeded at 3729 (offset 8 lines).
Hunk #27 succeeded at 3789 (offset 10 lines).
Hunk #28 succeeded at 4042 (offset 14 lines).
Hunk #29 succeeded at 4134 (offset 14 lines).
Hunk #30 succeeded at 4205 (offset 14 lines).
Hunk #31 succeeded at 4259 (offset 14 lines).
Hunk #32 succeeded at 4385 (offset 14 lines).
Hunk #33 succeeded at 4424 (offset 14 lines).
Hunk #34 succeeded at 4437 (offset 14 lines).
Hunk #35 succeeded at 4566 (offset 14 lines).
Hunk #36 succeeded at 4609 (offset 14 lines).
Hunk #37 succeeded at 4651 (offset 14 lines).
Hunk #38 succeeded at 4676 (offset 14 lines).
Hunk #39 succeeded at 4696 (offset 14 lines).
Hunk #40 succeeded at 4746 (offset 14 lines).
Hunk #41 succeeded at 4798 (offset 20 lines).
Hunk #42 succeeded at 4817 (offset 20 lines).
Hunk #43 succeeded at 4860 (offset 20 lines).
Hunk #44 succeeded at 4953 (offset 20 lines).
Hunk #45 succeeded at 5052 (offset 20 lines).
  :
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/265_drivers-usb-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.27-xlnx-v2025.1/999_other-document.patch
```

### Remove patches/linux-6.12.19-xlnx-v2025.1/103_fs-nfsd.patch

```console
shell$ diff linux-6.12.27-xlnx-v2025.1/fs/nfsd/nfs4recover.c linux-6.12.19-xlnx-v2025.1/fs/nfsd/nfs4recover.c
```

```console
shell$ cd ../patches/linux-6.12.27-xlnx-v2025.1/
shell$ rm 103_fs-nfsd.patch
```

### Fix patches/linux-6.12.19-xlnx-v2025.1/210_drivers-gpu-drm.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-210_drivers-gpu-drm
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-210_drivers-gpu-drm.sh
```

```console
shell$ diff -p drivers/gpu/drm/drm_connector.c ../linux-6.12.19-xlnx-v2025.1/drivers/gpu/drm/drm_connector.c
*** drivers/gpu/drm/drm_connector.c	2025-07-19 06:08:44.760867500 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/gpu/drm/drm_connector.c	2025-07-18 13:36:09.824095500 +0900
*************** EXPORT_SYMBOL(drm_hdmi_connector_get_out
*** 1308,1317 ****
   * 	callback. For atomic drivers the remapping to the "ACTIVE" property is
   * 	implemented in the DRM core.
   *
-  * 	On atomic drivers any DPMS setproperty ioctl where the value does not
-  * 	change is completely skipped, otherwise a full atomic commit will occur.
-  * 	On legacy drivers the exact behavior is driver specific.
-  *
   * 	Note that this property cannot be set through the MODE_ATOMIC ioctl,
   * 	userspace must use "ACTIVE" on the CRTC instead.
   *
--- 1308,1313 ----
```

```console
shell$ rm drivers/gpu/drm/drm_connector.c.orig
```

```console
shell$ diff -p drivers/gpu/drm/xlnx/zynqmp_dpsub.c ../linux-6.12.19-xlnx-v2025.1/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
*** drivers/gpu/drm/xlnx/zynqmp_dpsub.c	2025-07-19 06:08:44.862651800 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/gpu/drm/xlnx/zynqmp_dpsub.c	2025-07-18 13:36:09.989789400 +0900
*************** static int zynqmp_dpsub_probe(struct pla
*** 209,216 ****
  
  	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
  
- 	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
- 
  	/* Try the reserved memory. Proceed if there's none. */
  	of_reserved_mem_device_init(&pdev->dev);
  
--- 209,214 ----
```

```console
shell$ cp ../linux-6.12.19-xlnx-v2025.1/drivers/gpu/drm/xlnx/zynqmp_dpsub.c drivers/gpu/drm/xlnx/zynqmp_dpsub.c
shell$ rm drivers/gpu/drm/xlnx/zynqmp_dpsub.c.orig
```

```console
shell$ rm ./drivers/gpu/drm/drm_fourcc.c.orig
shell$ rm ./include/drm/display/drm_dp.h.orig
shell$ rm ./include/drm/drm_fourcc.h.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 210_drivers-gpu-drm.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/210_drivers-gpu-drm.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/236_drivers-pci.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-236_drivers-pci.patch
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-236_drivers-pci.sh
 :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/236_drivers-pci.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/236_drivers-pci.patch
patching file Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
patching file Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
patching file Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
patching file Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
patching file drivers/pci/controller/dwc/Kconfig
patching file drivers/pci/controller/dwc/Makefile
patching file drivers/pci/controller/dwc/pcie-amd-mdb.c
patching file drivers/pci/controller/pcie-xilinx-cpm.c
Hunk #13 FAILED at 636.
Hunk #14 FAILED at 670.
Hunk #15 succeeded at 697 (offset 2 lines).
2 out of 15 hunks FAILED -- saving rejects to file drivers/pci/controller/pcie-xilinx-cpm.c.rej
patching file drivers/pci/controller/pcie-xilinx-nwl.c
```

```console
shell$ cp ../linux-6.12.19-xlnx-v2025.1/drivers/pci/controller/pcie-xilinx-cpm.c drivers/pci/controller/pcie-xilinx-cpm.c
shell$ rm drivers/pci/controller/pcie-xilinx-cpm.c.orig
shell$ rm drivers/pci/controller/pcie-xilinx-cpm.c.rej
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 236_drivers-pci.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/236_drivers-pci.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/247_drivers-spi.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-247_drivers-spi.patch
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-247_drivers-spi.sh
 :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
Hunk #29 succeeded at 2102 (offset 6 lines).
Hunk #30 succeeded at 2250 (offset 6 lines).
Hunk #31 succeeded at 2333 (offset 6 lines).
Hunk #32 succeeded at 2354 (offset 6 lines).
Hunk #33 succeeded at 2369 (offset 6 lines).
Hunk #34 succeeded at 2431 (offset 6 lines).
Hunk #35 succeeded at 2485 (offset 6 lines).
Hunk #36 succeeded at 2536 (offset 6 lines).
Hunk #37 succeeded at 2604 (offset 6 lines).
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h

```

```console
shell$ diff -p drivers/spi/spi-cadence-quadspi.c ../linux-6.12.19-xlnx-v2025.1/drivers/spi/spi-cadence-quadspi.c
*** drivers/spi/spi-cadence-quadspi.c	2025-07-19 07:15:21.230520500 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/spi/spi-cadence-quadspi.c	2025-07-18 13:38:20.420705100 +0900
*************** static int cqspi_request_mmap_dma(struct
*** 2064,2075 ****
  		int ret = PTR_ERR(cqspi->rx_chan);
  
  		cqspi->rx_chan = NULL;
- 		if (ret == -ENODEV) {
- 			/* DMA support is not mandatory */
- 			dev_info(&cqspi->pdev->dev, "No Rx DMA available\n");
- 			return 0;
- 		}
- 
  		return dev_err_probe(&cqspi->pdev->dev, ret, "No Rx DMA available\n");
  	}
  	init_completion(&cqspi->rx_dma_complete);
--- 2064,2069 ----
```

```console
shell$ rm ./drivers/spi/spi-cadence-quadspi.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 247_drivers-spi.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/247_drivers-spi.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/251_drivers-ufs.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-251_drivers-ufs.patch
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-251_drivers-ufs.sh
 :
```

```console
shell$ diff -p drivers/ufs/core/ufshcd.c ../linux-6.12.19-xlnx-v2025.1/drivers/ufs/core/ufshcd.c
*** drivers/ufs/core/ufshcd.c	2025-07-19 07:28:33.129517700 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/ufs/core/ufshcd.c	2025-07-18 13:38:40.071316700 +0900
*************** ufshcd_dev_cmd_completion(struct ufs_hba
*** 3138,3150 ****
  	case UPIU_TRANSACTION_QUERY_RSP: {
  		u8 response = lrbp->ucd_rsp_ptr->header.response;
  
! 		if (response == 0) {
  			err = ufshcd_copy_query_response(hba, lrbp);
- 		} else {
- 			err = -EINVAL;
- 			dev_err(hba->dev, "%s: unexpected response in Query RSP: %x\n",
- 					__func__, response);
- 		}
  		break;
  	}
  	case UPIU_TRANSACTION_REJECT_UPIU:
--- 3138,3145 ----
  	case UPIU_TRANSACTION_QUERY_RSP: {
  		u8 response = lrbp->ucd_rsp_ptr->header.response;
  
! 		if (response == 0)
  			err = ufshcd_copy_query_response(hba, lrbp);
  		break;
  	}
  	case UPIU_TRANSACTION_REJECT_UPIU:
*************** static void ufshcd_mcq_compl_pending_tra
*** 5689,5696 ****
  			continue;
  
  		hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
- 		if (!hwq)
- 			continue;
  
  		if (force_compl) {
  			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
--- 5684,5689 ----
```

```console
shell$ rm drivers/ufs/core/ufshcd.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 251_drivers-ufs.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/251_drivers-ufs.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/262_drivers-usb-dwc3.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-262_drivers-usb-dwc3
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-262_drivers-usb-dwc3.sh
 :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/262_drivers-usb-dwc3.patch
patching file Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
patching file Documentation/devicetree/bindings/usb/snps,dwc3.yaml
patching file drivers/usb/dwc3/Kconfig
patching file drivers/usb/dwc3/Makefile
patching file drivers/usb/dwc3/core.c
patching file drivers/usb/dwc3/core.c.orig
patching file drivers/usb/dwc3/core.h
patching file drivers/usb/dwc3/debugfs.c
patching file drivers/usb/dwc3/dwc3-xilinx.c
Hunk #9 succeeded at 595 (offset -2 lines).
Hunk #10 succeeded at 715 (offset -2 lines).
Hunk #11 succeeded at 804 (offset -2 lines).
Hunk #12 succeeded at 845 (offset -2 lines).
Hunk #13 succeeded at 887 (offset -2 lines).
Hunk #14 succeeded at 907 (offset -2 lines).
patching file drivers/usb/dwc3/ep0.c
patching file drivers/usb/dwc3/gadget.c
Hunk #3 succeeded at 658 (offset 6 lines).
Hunk #4 succeeded at 897 (offset 8 lines).
Hunk #5 succeeded at 905 (offset 8 lines).
Hunk #6 succeeded at 921 (offset 8 lines).
Hunk #7 succeeded at 942 (offset 8 lines).
Hunk #8 succeeded at 964 (offset 8 lines).
Hunk #9 succeeded at 1062 (offset 8 lines).
Hunk #10 succeeded at 1660 (offset 8 lines).
Hunk #11 succeeded at 1777 (offset 8 lines).
Hunk #12 succeeded at 2013 (offset 8 lines).
Hunk #13 succeeded at 2034 (offset 8 lines).
Hunk #14 succeeded at 2264 (offset 8 lines).
Hunk #15 succeeded at 2657 (offset 8 lines).
Hunk #16 succeeded at 2732 (offset 8 lines).
Hunk #17 succeeded at 2793 (offset 8 lines).
Hunk #18 succeeded at 2824 (offset 8 lines).
Hunk #19 succeeded at 2869 (offset 8 lines).
Hunk #20 succeeded at 2892 (offset 8 lines).
Hunk #21 succeeded at 2906 (offset 8 lines).
Hunk #22 succeeded at 3008 (offset 8 lines).
Hunk #23 succeeded at 3062 (offset 8 lines).
Hunk #24 succeeded at 3080 (offset 8 lines).
Hunk #25 succeeded at 3719 (offset 8 lines).
Hunk #26 succeeded at 3729 (offset 8 lines).
Hunk #27 succeeded at 3789 (offset 10 lines).
Hunk #28 succeeded at 4042 (offset 14 lines).
Hunk #29 succeeded at 4134 (offset 14 lines).
Hunk #30 succeeded at 4205 (offset 14 lines).
Hunk #31 succeeded at 4259 (offset 14 lines).
Hunk #32 succeeded at 4385 (offset 14 lines).
Hunk #33 succeeded at 4424 (offset 14 lines).
Hunk #34 succeeded at 4437 (offset 14 lines).
Hunk #35 succeeded at 4566 (offset 14 lines).
Hunk #36 succeeded at 4609 (offset 14 lines).
Hunk #37 succeeded at 4651 (offset 14 lines).
Hunk #38 succeeded at 4676 (offset 14 lines).
Hunk #39 succeeded at 4696 (offset 14 lines).
Hunk #40 succeeded at 4746 (offset 14 lines).
Hunk #41 succeeded at 4798 (offset 20 lines).
Hunk #42 succeeded at 4817 (offset 20 lines).
Hunk #43 succeeded at 4860 (offset 20 lines).
Hunk #44 succeeded at 4953 (offset 20 lines).
Hunk #45 succeeded at 5052 (offset 20 lines).
patching file drivers/usb/dwc3/gadget.c.orig
patching file drivers/usb/dwc3/gadget.h
patching file drivers/usb/dwc3/gadget_hibernation.c
patching file drivers/usb/dwc3/host.c
patching file drivers/usb/dwc3/otg.c
patching file drivers/usb/dwc3/otg.h
patching file drivers/usb/dwc3/platform_data.h
```


```console
shell$ diff -p drivers/usb/dwc3/dwc3-xilinx.c ../linux-6.12.19-xlnx-v2025.1/drivers/usb/dwc3/dwc3-xilinx.c
*** drivers/usb/dwc3/dwc3-xilinx.c	2025-07-19 07:44:59.586039700 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/usb/dwc3/dwc3-xilinx.c	2025-07-18 13:38:59.693430800 +0900
*************** static int dwc3_xlnx_init_zynqmp(struct
*** 583,595 ****
  
  skip_usb3_phy:
  	/* ulpi reset via gpio-modepin or gpio-framework driver */
! 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
  	if (IS_ERR(reset_gpio)) {
  		return dev_err_probe(dev, PTR_ERR(reset_gpio),
  				     "Failed to request reset GPIO\n");
  	}
  
  	if (reset_gpio) {
  		usleep_range(5000, 10000);
  		gpiod_set_value_cansleep(reset_gpio, 0);
  		usleep_range(5000, 10000);
--- 583,597 ----
  
  skip_usb3_phy:
  	/* ulpi reset via gpio-modepin or gpio-framework driver */
! 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
  	if (IS_ERR(reset_gpio)) {
  		return dev_err_probe(dev, PTR_ERR(reset_gpio),
  				     "Failed to request reset GPIO\n");
  	}
  
  	if (reset_gpio) {
+ 		/* Toggle ulpi to reset the phy. */
+ 		gpiod_set_value_cansleep(reset_gpio, 1);
  		usleep_range(5000, 10000);
  		gpiod_set_value_cansleep(reset_gpio, 0);
  		usleep_range(5000, 10000);
```

```console
shell$ diff -p drivers/usb/dwc3/gadget.c ../linux-6.12.19-xlnx-v2025.1/drivers/usb/dwc3/gadget.c
*** drivers/usb/dwc3/gadget.c	2025-07-19 07:44:59.605438900 +0900
--- ../linux-6.12.19-xlnx-v2025.1/drivers/usb/dwc3/gadget.c	2025-07-18 13:38:59.707745100 +0900
*************** static int dwc3_gadget_set_xfer_resource
*** 548,554 ****
  int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
  {
  	struct dwc3_gadget_ep_cmd_params params;
- 	struct dwc3_ep		*dep;
  	u32			cmd;
  	int			i;
  	int			ret;
--- 548,553 ----
*************** int dwc3_gadget_start_config(struct dwc3
*** 565,577 ****
  		return ret;
  
  	/* Reset resource allocation flags */
! 	for (i = resource_index; i < dwc->num_eps; i++) {
! 		dep = dwc->eps[i];
! 		if (!dep)
! 			continue;
! 
! 		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
! 	}
  
  	return 0;
  }
--- 564,571 ----
  		return ret;
  
  	/* Reset resource allocation flags */
! 	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
! 		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
  
  	return 0;
  }
*************** void dwc3_gadget_clear_tx_fifos(struct d
*** 761,771 ****
  
  	dwc->last_fifo_depth = fifo_depth;
  	/* Clear existing TXFIFO for all IN eps except ep0 */
! 	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
  		dep = dwc->eps[num];
- 		if (!dep)
- 			continue;
- 
  		/* Don't change TXFRAMNUM on usb31 version */
  		size = DWC3_IP_IS(DWC3) ? 0 :
  			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
--- 755,763 ----
  
  	dwc->last_fifo_depth = fifo_depth;
  	/* Clear existing TXFIFO for all IN eps except ep0 */
! 	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
! 	     num += 2) {
  		dep = dwc->eps[num];
  		/* Don't change TXFRAMNUM on usb31 version */
  		size = DWC3_IP_IS(DWC3) ? 0 :
  			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
*************** out:
*** 3755,3762 ****
  
  		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
  			dep = dwc->eps[i];
- 			if (!dep)
- 				continue;
  
  			if (!(dep->flags & DWC3_EP_ENABLED))
  				continue;
--- 3747,3752 ----
*************** static void dwc3_endpoint_interrupt(stru
*** 3946,3955 ****
  	u8			epnum = event->endpoint_number;
  
  	dep = dwc->eps[epnum];
- 	if (!dep) {
- 		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
- 		return;
- 	}
  
  	if (!(dep->flags & DWC3_EP_ENABLED)) {
  		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
--- 3936,3941 ----
*************** static irqreturn_t dwc3_check_event_buf(
*** 4764,4775 ****
  	if (!count)
  		return IRQ_NONE;
  
- 	if (count > evt->length) {
- 		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
- 			count, evt->length);
- 		return IRQ_NONE;
- 	}
- 
  	evt->count = count;
  	evt->flags |= DWC3_EVENT_PENDING;
  
--- 4750,4755 ----
```

```console
shell$ rm drivers/usb/dwc3/dwc3-xilinx.c.orig
shell$ rm drivers/usb/dwc3/gadget.c.orig
shell$ rm drivers/usb/dwc3/core.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 262_drivers-usb-dwc3.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/262_drivers-usb-dwc3.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/230_drivers-net-ethernet.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-230_drivers-net-ethernet
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-230_drivers-net-ethernet.sh
 :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
patching file drivers/net/ethernet/cadence/macb_main.c.orig
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
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 230_drivers-net-ethernet"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/230_drivers-net-ethernet.patch
```

### Fix patches/linux-6.12.27-xlnx-v2025.1/216_drivers-irqchip.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-216_drivers-irqchip
shell$ sh ../patches/linux-6.12.27-xlnx-v2025.1/xxx_update-216_drivers-irqchip.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/216_drivers-irqchip.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/216_drivers-irqchip.patch
patching file Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt
patching file drivers/irqchip/Kconfig
patching file drivers/irqchip/Kconfig.orig
patching file drivers/irqchip/irq-xilinx-intc.c
patching file drivers/irqchip/irqchip.c
patching file drivers/irqchip/irqchip.c.orig
patching file include/linux/irq.h
patching file include/linux/irqchip.h
patching file include/linux/of_irq.h
```

```console
shell$ diff drivers/irqchip/Kconfig ../linux-6.12.19-xlnx-v2025.1/drivers/irqchip/Kconfig
shell$ diff drivers/irqchip/irqchip.c ../linux-6.12.19-xlnx-v2025.1/drivers/irqchip/irqchip.c
```

```console
shell$ rm drivers/irqchip/Kconfig.orig
shell$ rm drivers/irqchip/irqchip.c.orig
```

```console
shell$ git add --all
shell$ git commit -m "[patch] 216_drivers-irqchip.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/216_drivers-irqchip.patch
```

### Add patches/linux-6.12.27-xlnx-v2025.1/001_Makefile.patch

```console
shell$ cd linux-6.12.27-xlnx-v2025.1/
shell$ git checkout v6.12.27
shell$ git checkout -b linux-6.12.27-xlnx-v2025.1-001_Makefile
```

```console
shell$ git diff Makefile
diff --git a/Makefile b/Makefile
index 77f5d1809..4d8369a01 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 12
 SUBLEVEL = 27
-EXTRAVERSION =
+EXTRAVERSION = -zynqmp-fpga
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
```

```console
shell$ git add Makefile
shell$ git commit -m "[patch] 001_Makefile.patch"
shell$ git diff HEAD^ > ../patches/linux-6.12.27-xlnx-v2025.1/001_Makefile.patch
```

