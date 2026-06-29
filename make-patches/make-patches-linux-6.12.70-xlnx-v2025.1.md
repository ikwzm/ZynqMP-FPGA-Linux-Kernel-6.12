Make ./paches/linux-6.12.70-xlnx-v2025.1/
------------------------------------------------------------------------------------

### Get linux-6.12.70

```console
shell$ git clone --depth 1 -b v6.12.70 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.70
```

### Get linux-xlnx-2025.1-update(6a46183)

```console
shell$ git clone --filter=blob:none --no-checkout -b xlnx_rebase_v6.12_LTS_2025.1_update https://github.com/Xilinx/linux-xlnx.git linux-xlnx-2025.1-6a46183
shell$ cd linux-xlnx-2025.1-6a46183
shell$ git fetch origin xlnx_rebase_v6.12_LTS_2025.1_update
shell$ git checkout 6a46183
shell$ cd ..
```

### Make diff-linux-6.12.70-xlnx-v2025.1-update.txt

```console
shell$ ruby ./make-patches/source-tree-diff-list.rb -t linux-6.12.70-xlnx-v2025.1-update -A linux-6.12.70 -B linux-xlnx-2025.1-update -o ./make-patches/diff-linux-6.12.70-xlnx-v2025.1-update.txt linux-6.12.70 linux-xlnx-2025.1-6a46183 -v
## source-tree-diff-list.rb 0.1.1
## NAME: linux-6.12.70-xlnx-v2025.1-update
## A   : {name: linux-6.12.70, path: linux-6.12.70}
## B   : {name: linux-xlnx-2025.1-update, path: linux-xlnx-2025.1-6a46183}
## OUT : ./make-patches/diff-linux-6.12.70-xlnx-v2025.1-update.txt
```

### Make make-patches-linux-6.12.70-xlnx-v2025.1-update.sh

```console
shell$ ruby ./make-patches/make-patch-shell.rb -d ./make-patches/diff-linux-6.12.70-xlnx-v2025.1-update.txt -g make-patches/patch-group-linux-6.12.70-xlnx-v2025.1.yml -s ./make-patches/make-patches-linux-6.12.70-xlnx-v2025.1-update.sh
```

### Run make-patches-linux-6.12.70-xlnx-v2025.1-update.sh

```console
shell$ sh ./make-patches/make-patches-linux-6.12.70-xlnx-v2025.1-update.sh
shell$ ls -1 ./patches/linux-6.12.60-xlnx-v2025.1-update/
002_include.patch
010_arch-arm-mach-zynq.patch
011_arch-arm-configs.patch
012_arch-arm-boot-dts.patch
020_arch-arm64.patch
021_arch-arm64-configs.patch
022_arch-arm64-boot-dts.patch
030_arch-microblaze.patch
100_kernel-irq.patch
101_net-ipv4.patch
102_crypto.patch
202_drivers-clk.patch
203_drivers-clocksource.patch
204_drivers-crypto.patch
205_drivers-dma.patch
206_drivers-edac.patch
207_drivers-firmware.patch
208_drivers-fpga.patch
210_drivers-gpu-drm.patch
211_drivers-hwmon.patch
212_drivers-i2c.patch
213_drivers-i3c.patch
214_drivers-iio.patch
216_drivers-irqchip.patch
217_drivers-mailbox.patch
218_drivers-media-common.patch
219_drivers-media-i2c.patch
220_drivers-media-mc.patch
221_drivers-media-platform.patch
222_drivers-media-test-drivers.patch
224_drivers-media-v4l2.patch
225_drivers-mfd.patch
226_drivers-misc.patch
228_drivers-mtd.patch
230_drivers-net-ethernet.patch
231_drivers-net-phy.patch
234_drivers-nvmem.patch
235_drivers-of.patch
236_drivers-pci.patch
237_drivers-phy.patch
238_drivers-pinctrl.patch
240_drivers-ptp.patch
241_drivers-pwm.patch
242_drivers-remoteproc.patch
243_drivers-reset.patch
246_drivers-soc-xilinx.patch
247_drivers-spi.patch
248_drivers-staging.patch
249_drivers-thermal.patch
250_drivers-tty.patch
251_drivers-ufs.patch
252_drivers-uio.patch
260_drivers-usb-core.patch
261_drivers-usb-chipidea.patch
262_drivers-usb-dwc3.patch
263_drivers-usb-gadget.patch
264_drivers-usb-host.patch
266_drivers-usb-phy.patch
271_drivers-video.patch
272_drivers-virtio.patch
273_drivers-w1.patch
275_drivers-xen.patch
301_sound-soc-xilinx.patch
999_other-document.patch
xxx_patch.sh
```

