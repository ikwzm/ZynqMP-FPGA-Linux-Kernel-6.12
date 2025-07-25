ZynqMP-FPGA-Linux-Kernel-6.12
====================================================================================

Overview
------------------------------------------------------------------------------------

### Introduction

This Repository provides a Linux Kernel (v6.12.x) Image and Device Trees for Zynq MPSoC.

### Note

**The Linux Kernel Image provided in this repository is not official.**
**I modified it to my liking. Please handle with care.**

### Features

  * Linux Kernel Version v6.12.x
  * Enable Device Tree Overlay with Configuration File System
  * Enable FPGA Manager
  * Enable FPGA Bridge
  * Enable FPGA Reagion
  * Enable ATWILC3000 Linux Driver for Ultra96-V2

Release
------------------------------------------------------------------------------------

The main branch contains only Readme.md.     
For Linux Kernel image and Debian Packages, please refer to the respective release tag listed below.

| Version  | Local Name          | Build Version | Release Tag |
|:---------|:--------------------|:--------------|:------------|
| 6.12.27  | zynqmp-fpga-generic | 3             | [6.12.27-zynqmp-fpga-generic-3](https://github.com/ikwzm/ZynqMP-FPGA-Linux-Kernel-6.12/tree/6.12.27-zynqmp-fpga-generic-3) |
| 6.12.19  | zynqmp-fpga-generic | 1             | [6.12.19-zynqmp-fpga-generic-1](https://github.com/ikwzm/ZynqMP-FPGA-Linux-Kernel-6.12/tree/6.12.19-zynqmp-fpga-generic-1) |
| 6.12.10  | zynqmp-fpga-generic | 6             | [6.12.10-zynqmp-fpga-generic-6](https://github.com/ikwzm/ZynqMP-FPGA-Linux-Kernel-6.12/tree/6.12.10-zynqmp-fpga-generic-6) |

Download
------------------------------------------------------------------------------------

```console
shell$ export RELEASE_TAG=6.12.27-zynqmp-fpga-generic-3
shell$ wget https://github.com/ikwzm/ZynqMP-FPGA-Linux-Kernel-6.12/archive/refs/tags/$RELEASE_TAG.tar.gz
shell$ tar xfz $RELEASE_TAG.tar.gz
shell$ mv ZynqMP-FPGA-Linux-Kernel-6.12-$RELEASE_TAG ZynqMP-FPGA-Linux-Kernel-$RELEASE_TAG
shell$ cd ZynqMP-FPGA-Linux-Kernel-$RELEASE_TAG
```
