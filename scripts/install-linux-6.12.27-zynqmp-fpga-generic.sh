#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
REPO_DIR=$(cd $(dirname $0); cd .. ; pwd)
KERNEL_VERSION=6.12.27
EXTRA_VERSION=-zynqmp-fpga
LOCAL_VERSION=-generic
BUILD_VERSION=2

. "$SCRIPT_DIR/install-variables-zynqmp-fpga.sh"
. "$SCRIPT_DIR/install-command.sh"
