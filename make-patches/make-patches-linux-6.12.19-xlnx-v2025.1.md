Make ./paches/linux-6.12.19-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.10

```console
shell$ git clone --depth 1 -b v6.12.10 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.10
```

### Get linux-6.12.10-xlnx-v2025.1

```console
shell$ git clone --depth 1 -b v6.12.10 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.10-xlnx-v2025.1
shell$ cd linux-6.12.10-xlnx-v2025.1
shell$ git checkout -b linux-6.12.10-xlnx-v2025.1
shell$ sh ../patches/linux-6.12.10-xlnx-v2025.1/origin_patch.sh
shell$ cd
```

### Get linux-6.12.19

```console
shell$ git clone --depth 1 -b v6.12.19 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.19
```

### Make diff-linux-xlnx-6.12.10-xlnx-v2025.1.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.10-xlnx-v2025.1 -A linux-6.12.10 -B linux-6.12.10-xlnx-v2025.1 -o ./make-patches/diff-linux-6.12.10-xlnx-v2025.1.txt linux-6.12.10 linux-6.12.10-xlnx-v2025.1 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.10-xlnx-v2025.1
## A   : {name: linux-6.12.10, path: linux-6.12.10}
## B   : {name: linux-6.12.10-xlnx-v2025.1, path: linux-6.12.10-xlnx-v2025.1}
## OUT : ./make-patches/diff-linux-6.12.10-xlnx-v2025.1.txt
```

### Make diff-linux-6.12.10-6.12.19.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.10-6.12.19 -A linux-6.12.10 -B linux-6.12.19 -o ./make-patches/diff-linux-6.12.10-6.12.19.txt linux-6.12.10 linux-6.12.19 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.10-6.12.19
## A   : {name: linux-6.12.10, path: linux-6.12.10}
## B   : {name: linux-6.12.19, path: linux-6.12.19}
## OUT : ./make-patches/diff-linux-6.12.10-6.12.19.txt
```

### Compare diff-linux-6.12.10-6.12.19.txt and diff-linux-xlnx-6.12.10-xlnx-v2025.1.txt

```console
shell$ ruby make-patches/compare-diff-list.rb make-patches/diff-linux-6.12.10-6.12.19.txt make-patches/diff-linux-6.12.10-xlnx-v2025.1.txt 
contents: 
 - U: MAINTAINERS
 - U: arch/arm64/configs/defconfig
 - U: drivers/gpio/gpio-xilinx.c
 - U: drivers/gpu/drm/drm_connector.c
 - U: drivers/gpu/drm/drm_edid.c
 - U: drivers/gpu/drm/drm_fourcc.c
 - U: drivers/hwmon/Kconfig
 - U: drivers/irqchip/Kconfig
 - U: drivers/irqchip/irqchip.c
 - U: drivers/mailbox/zynqmp-ipi-mailbox.c
 - U: drivers/media/i2c/ov5640.c
 - U: drivers/mtd/spi-nor/core.c
 - U: drivers/mtd/spi-nor/sst.c
 - U: drivers/net/ethernet/cadence/macb.h
 - U: drivers/net/ethernet/cadence/macb_main.c
 - U: drivers/net/ethernet/xilinx/xilinx_axienet_main.c
 - U: drivers/rtc/rtc-zynqmp.c
 - U: drivers/spi/spi-zynq-qspi.c
 - U: drivers/ufs/core/ufshcd.c
 - U: drivers/usb/dwc3/core.c
 - U: drivers/usb/dwc3/core.h
 - U: drivers/usb/dwc3/gadget.c
 - U: drivers/usb/gadget/function/f_tcm.c
 - U: drivers/usb/host/xhci.h
 - U: include/drm/display/drm_dp.h
 - U: include/drm/drm_connector.h
 - U: include/drm/drm_fourcc.h
 - U: include/linux/phy.h
 - U: include/ufs/ufshcd.h
 - U: usr/include/Makefile
```

### Make linux-6.12.19-xlnx-v2025.1

#### xxx_update.sh

```console
shell$ git clone --depth 1 -b v6.12.19 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.19-xlnx-v2025.1
shell$ cd linux-6.12.19-xlnx-v2025.1
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-1
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update.sh
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/010_arch-arm-mach-zynq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/011_arch-arm-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/012_arch-arm-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/020_arch-arm64.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/021_arch-arm64-configs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/022_arch-arm64-boot-dts.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/030_arch-microblaze.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/100_kernel-irq.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/101_net-ipv4.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/102_crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/103_fs-nfsd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/202_drivers-clk.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/203_drivers-clocksource.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/204_drivers-crypto.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/205_drivers-dma.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/207_drivers-firmware.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/208_drivers-fpga.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/209_drivers-gpio.patch
14 out of 14 hunks ignored -- saving rejects to file drivers/gpio/gpio-xilinx.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/210_drivers-gpu-drm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/211_drivers-hwmon.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/212_drivers-i2c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/213_drivers-i3c.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/214_drivers-iio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/216_drivers-irqchip.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/217_drivers-mailbox.patch
2 out of 2 hunks ignored -- saving rejects to file drivers/mailbox/zynqmp-ipi-mailbox.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/218_drivers-media-common.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/219_drivers-media-i2c.patch
1 out of 1 hunk ignored -- saving rejects to file drivers/media/i2c/ov5640.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/220_drivers-media-mc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/221_drivers-media-platform.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/222_drivers-media-test-drivers.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/224_drivers-media-v4l2.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/225_drivers-mfd.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/226_drivers-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/226_drivers-misc-fix.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/227_drivers-mmc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/228_drivers-mtd.patch
1 out of 74 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/core.c.rej
1 out of 6 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/sst.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/230_drivers-net-ethernet.patch
1 out of 72 hunks FAILED -- saving rejects to file drivers/net/ethernet/xilinx/xilinx_axienet_main.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/231_drivers-net-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/234_drivers-nvmem.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/235_drivers-of.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/236_drivers-pci.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/237_drivers-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/238_drivers-pinctrl.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/240_drivers-ptp.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/241_drivers-pwm.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/242_drivers-remoteproc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/245_drivers-rtc.patch
1 out of 1 hunk ignored -- saving rejects to file drivers/rtc/rtc-zynqmp.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/246_drivers-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/247_drivers-spi.patch
1 out of 20 hunks FAILED -- saving rejects to file drivers/spi/spi-zynq-qspi.c.rej
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/248_drivers-staging.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/249_drivers-thermal.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/250_drivers-tty.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/251_drivers-ufs.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/252_drivers-uio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/260_drivers-usb-core.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/262_drivers-usb-dwc3.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/263_drivers-usb-gadget.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/264_drivers-usb-host.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/265_drivers-usb-misc.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/266_drivers-usb-phy.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/271_drivers-video.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/272_drivers-virtio.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/273_drivers-w1.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/275_drivers-xen.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/301_sound-soc-xilinx.patch
## make patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.19-xlnx-v2025.1/999_other-document.patch
```

#### Remove patches/linux-6.12.19-xlnx-v2025.1/209_drivers-gpio.patch 

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-209_drivers-gpio
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-209_drivers-gpio.sh
  :
## try patch ../patches/linux-6.6.70-xlnx-v2025.1/209_drivers-gpio.patch
patching file drivers/gpio/gpio-xilinx.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
14 out of 14 hunks ignored -- saving rejects to file drivers/gpio/gpio-xilinx.c.rej
```

```console
shell$ cd ..
shell$ diff linux-6.12.10-xlnx-v2025.1/drivers/gpio/gpio-xilinx.c linux-6.12.19-xlnx-v2025.1/drivers/gpio/gpio-xilinx.c
```

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ rm drivers/gpio/gpio-xilinx.c.rej
shell$ git status
On branch linux-6.12.19-xlnx-v2025.1-209_drivers-gpio

It took 3.21 seconds to enumerate untracked files. 'status -uno'
may speed it up, but you have to be careful not to forget to add
new files yourself (see 'git help status').
nothing to commit, working tree clean
````

```console
shell$ cd ../patches/linux-6.12.19-xlnx-v2025.1/
shell$ rm 209_drivers-gpio.patch
```

### Remove patches/linux-6.12.19-xlnx-v2025.1/217_drivers-mailbox.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-217_drivers-mailbox
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-217_drivers-mailbox.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/217_drivers-mailbox.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/217_drivers-mailbox.patch
patching file Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
patching file drivers/mailbox/zynqmp-ipi-mailbox.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
2 out of 2 hunks ignored -- saving rejects to file drivers/mailbox/zynqmp-ipi-mailbox.c.rej
```

```console
shell$ cd ..
shell$ diff -p linux-6.12.10-xlnx-v2025.1/drivers/mailbox/zynqmp-ipi-mailbox.c linux-6.12.19/drivers/mailbox/zynqmp-ipi-mailbox.c 
*** linux-6.12.10-xlnx-v2025.1/drivers/mailbox/zynqmp-ipi-mailbox.c	2025-07-16 15:12:55.551373200 +0900
--- linux-6.12.19/drivers/mailbox/zynqmp-ipi-mailbox.c	2025-07-16 15:18:15.756933000 +0900
*************** static int zynqmp_ipi_probe(struct platf
*** 940,949 ****
  	pdata->num_mboxes = num_mboxes;
  
  	mbox = pdata->ipi_mboxes;
  	for_each_available_child_of_node(np, nc) {
  		mbox->pdata = pdata;
- 		mbox->setup_ipi_fn = ipi_fn;
- 
  		ret = zynqmp_ipi_mbox_probe(mbox, nc);
  		if (ret) {
  			of_node_put(nc);
--- 940,949 ----
  	pdata->num_mboxes = num_mboxes;
  
  	mbox = pdata->ipi_mboxes;
+ 	mbox->setup_ipi_fn = ipi_fn;
+ 
  	for_each_available_child_of_node(np, nc) {
  		mbox->pdata = pdata;
  		ret = zynqmp_ipi_mbox_probe(mbox, nc);
  		if (ret) {
  			of_node_put(nc);
```


```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ rm drivers/mailbox/zynqmp-ipi-mailbox.c.rej
shell$ git status
Refresh index: 100% (86925/86925), done.
On branch linux-6.12.19-xlnx-v2025.1-217_drivers-mailbox
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml


It took 3.13 seconds to enumerate untracked files. 'status -uno'
may speed it up, but you have to be careful not to forget to add
new files yourself (see 'git help status').
no changes added to commit (use "git add" and/or "git commit -a")
shell$ git diff Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
index fe83b5cb1..65f4dd078 100644
--- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
@@ -61,9 +61,11 @@ properties:
     const: 2
 
   reg:
+    minItems: 1
     maxItems: 2
 
   reg-names:
+    minItems: 1
     maxItems: 2
 
   xlnx,ipi-id:
@@ -167,11 +169,13 @@ allOf:
     else:
       properties:
         reg:
+          minItems: 1
           items:
             - description: Host IPI agent control register region
             - description: Host IPI agent optional message buffers
 
         reg-names:
+          minItems: 1
           items:
             - const: ctrl
             - const: msg
```

```console
shell$ git checkout Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml	     
```

```console
shell$ cd ../patches/linux-6.12.19-xlnx-v2025.1/
shell$ rm 217_drivers-mailbox.patch
```

### Fix patches/linux-6.12.19-xlnx-v2025.1/219_drivers-media-i2c.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-219_drivers-media-i2c
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-219_drivers-media-i2c.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/219_drivers-media-i2c.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/219_drivers-media-i2c.patch
patching file Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
patching file drivers/media/i2c/Kconfig
patching file drivers/media/i2c/Makefile
patching file drivers/media/i2c/ap1302.c
patching file drivers/media/i2c/ov5640.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/media/i2c/ov5640.c.rej
```

```console
shell$ cd ..
shell$ diff linux-6.12.10-xlnx-v2025.1/drivers/media/i2c/ov5640.c linux-6.12.19/drivers/media/i2c/ov5640.c
```

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ rm drivers/media/i2c/ov5640.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 219_drivers-media-i2c.patch"
[linux-6.12.19-xlnx-v2025.1-219_drivers-media-i2c e1f1e1b7f] [patch] 219_drivers-media-i2c.patch
 4 files changed, 3212 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml
 create mode 100644 drivers/media/i2c/ap1302.c
 shell$ git diff HEAD^ > ../patches/linux-6.12.19-xlnx-v2025.1/219_drivers-media-i2c.patch 
```

### Fix patches/linux-6.12.19-xlnx-v2025.1/228_drivers-mtd.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-228_drivers-mtd
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-228_drivers-mtd.sh
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/228_drivers-mtd.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/228_drivers-mtd.patch
patching file Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
patching file drivers/mtd/spi-nor/atmel.c
patching file drivers/mtd/spi-nor/core.c
Hunk #3 FAILED at 93.
1 out of 74 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/core.c.rej
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
Hunk #6 FAILED at 181.
1 out of 6 hunks FAILED -- saving rejects to file drivers/mtd/spi-nor/sst.c.rej
patching file drivers/mtd/spi-nor/swp.c
patching file drivers/mtd/spi-nor/winbond.c
patching file include/linux/mtd/spi-nor.h
```

```console
shell$ diff ../linux-6.12.19-xlnx-v2025.1/drivers/mtd/spi-nor/core.c drivers/mtd/spi-nor/core.c
shell$ diff ../linux-6.12.19-xlnx-v2025.1/drivers/mtd/spi-nor/sst.c  drivers/mtd/spi-nor/sst.c
```

```console
shell$ rm drivers/mtd/spi-nor/core.c.orig drivers/mtd/spi-nor/core.c.rej
shell$ rm drivers/mtd/spi-nor/sst.c.orig  drivers/mtd/spi-nor/sst.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 228_drivers-mtd.patch"
[linux-6.12.19-xlnx-v2025.1-228_drivers-mtd 7fd537043] [patch] 228_drivers-mtd.patch
 17 files changed, 2292 insertions(+), 300 deletions(-)
shell$ git diff HEAD^ > ../patches/linux-6.12.19-xlnx-v2025.1/228_drivers-mtd.patch
```

### Fix patches/linux-6.12.19-xlnx-v2025.1/230_drivers-net-ethernet.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-230_drivers-net-ethernet
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-230_drivers-net-ethernet.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/230_drivers-net-ethernet.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/230_drivers-net-ethernet.patch
patching file Documentation/devicetree/bindings/net/cdns,macb.yaml
patching file Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
patching file Documentation/devicetree/bindings/net/xlnx,emaclite.yaml
patching file drivers/net/ethernet/cadence/macb.h
patching file drivers/net/ethernet/cadence/macb_main.c
Hunk #14 succeeded at 5036 (offset 7 lines).
Hunk #15 succeeded at 5069 (offset 7 lines).
patching file drivers/net/ethernet/xilinx/Kconfig
patching file drivers/net/ethernet/xilinx/Makefile
patching file drivers/net/ethernet/xilinx/xilinx_axienet.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
patching file drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
patching file drivers/net/ethernet/xilinx/xilinx_axienet_main.c
Hunk #46 succeeded at 3611 (offset 6 lines).
Hunk #47 succeeded at 3623 (offset 6 lines).
Hunk #48 succeeded at 3641 (offset 6 lines).
Hunk #49 succeeded at 3685 (offset 6 lines).
Hunk #50 succeeded at 3715 (offset 6 lines).
Hunk #51 succeeded at 3876 (offset 6 lines).
Hunk #52 succeeded at 3997 (offset 6 lines).
Hunk #53 succeeded at 4010 (offset 6 lines).
Hunk #54 succeeded at 4267 (offset 6 lines).
Hunk #55 succeeded at 4283 (offset 6 lines).
Hunk #56 succeeded at 4354 (offset 6 lines).
Hunk #57 succeeded at 4383 (offset 6 lines).
Hunk #58 succeeded at 4409 (offset 6 lines).
Hunk #59 succeeded at 4459 (offset 6 lines).
Hunk #60 succeeded at 4837 (offset 6 lines).
Hunk #61 succeeded at 4880 (offset 6 lines).
Hunk #62 succeeded at 4891 (offset 6 lines).
Hunk #63 succeeded at 4930 (offset 6 lines).
Hunk #64 succeeded at 4989 (offset 6 lines).
Hunk #65 succeeded at 5276 (offset 6 lines).
Hunk #66 succeeded at 5402 (offset 6 lines).
Hunk #67 succeeded at 5417 (offset 6 lines).
Hunk #68 FAILED at 5465.
Hunk #69 succeeded at 5505 (offset 7 lines).
Hunk #70 succeeded at 5532 (offset 7 lines).
Hunk #71 succeeded at 5549 (offset 7 lines).
Hunk #72 succeeded at 5568 (offset 7 lines).
1 out of 72 hunks FAILED -- saving rejects to file drivers/net/ethernet/xilinx/xilinx_axienet_main.c.rej
patching file drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
patching file drivers/net/ethernet/xilinx/xilinx_emaclite.c
```

```console
shell$ diff ../linux-6.12.19-xlnx-v2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_main.c drivers/net/ethernet/xilinx/xilinx_axienet_main.c
```

```console
shell$ rm drivers/net/ethernet/xilinx/xilinx_axienet_main.c.orig
shell$ rm drivers/net/ethernet/xilinx/xilinx_axienet_main.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 230_drivers-net-ethernet.patch"
[linux-6.12.19-xlnx-v2025.1-230_drivers-net-ethernet 8a883aeb2] [patch] 230_drivers-net-ethernet.patch
 15 files changed, 12572 insertions(+), 851 deletions(-)
 create mode 100644 drivers/net/ethernet/cadence/macb_main.c.orig
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_dma.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h
 create mode 100644 drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c
shell$ git diff HEAD^ > ../patches/linux-6.12.19-xlnx-v2025.1/230_drivers-net-ethernet.patch 
 ```

### Remove patches/linux-6.12.19-xlnx-v2025.1/243_drivers-reset.patch

```console
shell$ cd ./patches/linux-6.12.19-xlnx-v2025.1/
shell$ rm 243_drivers-reset.patch
```

### Remove patches/linux-6.12.19-xlnx-v2025.1/245_drivers-rtc.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-245_drivers-rtc
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-245_drivers-rtc.sh
 :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/245_drivers-rtc.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/245_drivers-rtc.patch
patching file drivers/rtc/rtc-zynqmp.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/rtc/rtc-zynqmp.c.rej
```

```console
shell$ diff ../linux-6.12.19-xlnx-v2025.1/drivers/rtc/rtc-zynqmp.c drivers/rtc/rtc-zynqmp.c
shell$ diff ../linux-6.12.10-xlnx-v2025.1/drivers/rtc/rtc-zynqmp.c ../linux-6.12.19/drivers/rtc/rtc-zynqmp.c 
```

```console
shell$ cd ../patches/linux-6.12.19-xlnx-v2025.1/
shell$ rm 245_drivers-rtc.patch
```

### Fix patches/linux-6.12.19-xlnx-v2025.1/247_drivers-spi.patch

```console
shell$ cd linux-6.12.19-xlnx-v2025.1/
shell$ git checkout v6.12.19
shell$ git checkout -b linux-6.12.19-xlnx-v2025.1-247_drivers-spi
shell$ sh ../patches/linux-6.12.19-xlnx-v2025.1/xxx_update-247_drivers-spi.sh
  :
## try patch /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/247_drivers-spi.patch
patch -p1 < /home/ichiro/work/ZynqMP-FPGA-Linux-Kernel-6.12/patches/linux-6.12.10-xlnx-v2025.1/247_drivers-spi.patch
patching file Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
patching file Documentation/devicetree/bindings/spi/spi-controller.yaml
patching file Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
patching file Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
patching file Documentation/devicetree/bindings/trivial-devices.yaml
patching file drivers/spi/spi-cadence-quadspi.c
patching file drivers/spi/spi-mem.c
patching file drivers/spi/spi-xilinx.c
patching file drivers/spi/spi-zynq-qspi.c
Hunk #13 FAILED at 435.
Hunk #14 succeeded at 591 (offset 9 lines).
Hunk #15 succeeded at 599 (offset 9 lines).
Hunk #16 succeeded at 620 (offset 9 lines).
Hunk #17 succeeded at 660 (offset 9 lines).
Hunk #18 succeeded at 682 (offset 9 lines).
Hunk #19 succeeded at 718 (offset 9 lines).
Hunk #20 succeeded at 779 (offset 9 lines).
1 out of 20 hunks FAILED -- saving rejects to file drivers/spi/spi-zynq-qspi.c.rej
patching file drivers/spi/spi-zynqmp-gqspi.c
patching file drivers/spi/spi.c
patching file include/linux/spi/spi-mem.h
patching file include/linux/spi/spi.h
```

```console
shell$ diff ../linux-6.12.10-xlnx-v2025.1/drivers/spi/spi-zynqmp-gqspi.c drivers/spi/spi-zynqmp-gqspi.c
```

```console
shell$ rm drivers/spi/spi-zynq-qspi.c.orig drivers/spi/spi-zynq-qspi.c.rej
shell$ git add --all
shell$ git commit -m "[patch] 247_drivers-spi.patch"
[detached HEAD 41cf0a98d] [patch] 247_drivers-spi.patch
 13 files changed, 1445 insertions(+), 371 deletions(-)
shell$ git diff HEAD^ > ../patches/linux-6.12.19-xlnx-v2025.1/247_drivers-spi.patch
```

