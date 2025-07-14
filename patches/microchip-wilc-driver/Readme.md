patches/microchip-wilc-driver
------------------------------------------------------------------------------------

This directory provides the Linux Kernel Driver for the WiFi module in the Ultra96-V2.

### WiFi Module Details

 * Manufacturer Part Number: ATWILC3000-MR110CA
 * Manufacturer            : MICROCHIP
 * URL                     : https://www.microchip.com/en-us/product/atwilc3000
 
### Linux Kernel Driver

#### Get linux-6.12-mchp

 * https://github.com/linux4microchip/linux

The branch for linux kernel is ```linux-6.12-mchp```.

```Kconfig```, ```Makefile```, and ```wilc1000/``` in this directory were obtained as follows

```console
shell$ git clone --depth 1 --branch linux-6.12-mchp https://github.com/linux4microchip/linux linux-6.12-mchp
shell$ cp -r linux-6.12-mchp/drivers/net/wireless/microchip/* .
```

#### Patch

##### Fix wilc1000 to not control power when pins are not initialized

```console
shell$ cd wilc1000/
shell$ patch -p1 < ../wilc1000-1-power-pins.patch
shell$ cd
```

##### Fix wilc1000 so that wilc_sdio_init() does not fail if pm_runtime is disabled in host controller

```console
shell$ cd wilc1000/
shell$ patch -p1 < ../wilc1000-2-pm-runtime.patch
shell$ cd
```

### Thanks

Thanks to Tosainu and microchip.


