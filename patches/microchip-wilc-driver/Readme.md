patches/microchip-wilc-driver
------------------------------------------------------------------------------------

This directory provides the Linux Kernel Driver for the WiFi module in the Ultra96-V2.

### WiFi Module Details

 * Manufacturer Part Number: ATWILC3000-MR110CA
 * Manufacturer            : MICROCHIP
 * URL                     : https://www.microchip.com/en-us/product/atwilc3000
 
### Linux Kernel Driver

#### Get linux-mchp-2025.10.1

 * https://github.com/linux4microchip/linux

The branch for linux kernel is ```linux-mchp-2025.10.1```.

```Kconfig```, ```Makefile```, and ```wilc1000/``` in this directory were obtained as follows

#### Copy to wilc1000 from linux-mchp-2025.10.1/drivers/net/wireless/microchip/

```console
shell$ git clone --branch 'linux4microchip+fpga-2025.10.1' --depth 1 https://github.com/linux4microchip/linux.git linux-mchp-2025.10.1
shell$ mkdir wilc1000
shell$ cp -r linux-mchp-2025.10.1/drivers/net/wireless/microchip/wilc1000/* wilc1000/
```

#### Patch

##### Fix wilc1000 to not control power when pins are not initialized

```console
shell$ cd wilc1000/
shell$ patch -p1 < ../wilc1000-1-power-pins.patch
shell$ cd ..
```

##### Fix wilc1000 so that wilc_sdio_init() does not fail if pm_runtime is disabled in host controller

```console
shell$ cd wilc1000/
shell$ patch -p1 < ../wilc1000-2-pm-runtime.patch
shell$ cd ..
```

##### Add "out-of-band-interrupt" property to devcie tree

```console
shell$ cd wilc1000/
shell$ patch -p1 < ../wilc1000-3-oob-intr.patch
shell$ cd ..
```

### Thanks

Thanks to Tosainu and microchip.


