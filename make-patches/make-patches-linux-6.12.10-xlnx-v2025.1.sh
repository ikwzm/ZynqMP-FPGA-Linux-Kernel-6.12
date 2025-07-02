PATCH_DIR=./patches/linux-6.12.10-xlnx-v2025.1
install -d $PATCH_DIR

PATCH_FILE=$PATCH_DIR/010_arch-arm-mach-zynq.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/arm/mach-zynq/Makefile                                                                   linux-xlnx-2025.1/arch/arm/mach-zynq/Makefile                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/mach-zynq/common.c                                                                   linux-xlnx-2025.1/arch/arm/mach-zynq/common.c                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/mach-zynq/common.h                                                                   linux-xlnx-2025.1/arch/arm/mach-zynq/common.h                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/mach-zynq/efuse.c --label=/dev/null                                                  linux-xlnx-2025.1/arch/arm/mach-zynq/efuse.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/mach-zynq/platsmp.c                                                                  linux-xlnx-2025.1/arch/arm/mach-zynq/platsmp.c                                                >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/011_arch-arm-configs.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/arm/configs/xilinx_zynq_defconfig --label=/dev/null                                      linux-xlnx-2025.1/arch/arm/configs/xilinx_zynq_defconfig                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/012_arch-arm-boot-dts.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-7000.dtsi                                                       linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-7000.dtsi                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-cc108.dts                                                       linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-cc108.dts                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts                                                    linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-ebaz4205.dts                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-parallella.dts                                                  linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-parallella.dts                                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc702.dts                                                       linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc702.dts                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc706.dts                                                       linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc706.dts                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts                                                 linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc770-xm010.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts                                                 linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc770-xm011.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts                                                 linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc770-xm012.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts                                                 linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zc770-xm013.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zed.dts                                                         linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zed.dts                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts                                                     linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zybo-z7.dts                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm/boot/dts/xilinx/zynq-zybo.dts                                                        linux-xlnx-2025.1/arch/arm/boot/dts/xilinx/zynq-zybo.dts                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/020_arch-arm64.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/arm/zynq/ --label=/dev/null                                 linux-xlnx-2025.1/Documentation/devicetree/bindings/arm/zynq/                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/kernel/irq.c                                                                       linux-xlnx-2025.1/arch/arm64/kernel/irq.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/xen/hypercall.S                                                                    linux-xlnx-2025.1/arch/arm64/xen/hypercall.S                                                  >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/021_arch-arm64-configs.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/arm64/configs/defconfig                                                                  linux-xlnx-2025.1/arch/arm64/configs/defconfig                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/configs/xilinx_defconfig --label=/dev/null                                         linux-xlnx-2025.1/arch/arm64/configs/xilinx_defconfig                                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/022_arch-arm64-boot-dts.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/Makefile                                                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/Makefile                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-clk.dtsi --label=/dev/null                                  linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-clk.dtsi                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-emb-plus-ve2302-revA.dts --label=/dev/null                  linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-emb-plus-ve2302-revA.dts                  >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-net-clk-ccf.dtsi --label=/dev/null                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-net-clk-ccf.dtsi                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi --label=/dev/null                              linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-net-clk.dtsi                              >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-net-vn-p-b2197-00-revA.dts --label=/dev/null                linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-net-vn-p-b2197-00-revA.dts                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-revA.dts --label=/dev/null                linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-net-vn-x-b2197-01-revA.dts                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-net.dtsi --label=/dev/null                                  linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-net.dtsi                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-v350-revA.dts --label=/dev/null                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-v350-revA.dts                             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA-ospi.dts --label=/dev/null linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA-ospi.dts >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA.dts --label=/dev/null      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-01-revA.dts      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-02-revA.dts --label=/dev/null      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-02-revA.dts      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-03-revA.dts --label=/dev/null      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-03-revA.dts      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA-ospi.dts --label=/dev/null linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA-ospi.dts >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA.dts --label=/dev/null      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-04-revA.dts      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-05-revA.dts --label=/dev/null      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA-x-prc-05-revA.dts      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA.dts --label=/dev/null                    linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vc-p-a2197-00-revA.dts                    >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-01-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-01-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-02-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-02-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-03-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1-x-ebm-03-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1.dts --label=/dev/null                         linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-rev1.1.dts                         >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-01-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-01-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-02-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-02-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-03-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-revA-x-ebm-03-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck190-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck190-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vck5000-revA.dts --label=/dev/null                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vck5000-revA.dts                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vek280-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vek280-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vek280-revB.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vek280-revB.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vhk158-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vhk158-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-01-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-01-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-02-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-02-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-03-revA.dts --label=/dev/null           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1-x-ebm-03-revA.dts           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1.dts --label=/dev/null                         linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-rev1.1.dts                         >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-01-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-01-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-02-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-02-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-03-revA.dts --label=/dev/null             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-revA-x-ebm-03-revA.dts             >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vmk180-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vmk180-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vp-x-a2785-00-revA.dts --label=/dev/null                    linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vp-x-a2785-00-revA.dts                    >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vpk120-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vpk120-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vpk120-revB.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vpk120-revB.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-vpk180-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-vpk180-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtsi --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtsi                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-01-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtsi --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtsi                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-02-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtsi --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtsi                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal-x-ebm-03-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/versal.dtsi --label=/dev/null                                      linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/versal.dtsi                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/x-prc-07-i3c-revA.dtso --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/x-prc-07-i3c-revA.dtso                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/x-prc-07-revA.dtso --label=/dev/null                               linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/x-prc-07-revA.dtso                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/x-prc-08-revA.dtso --label=/dev/null                               linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/x-prc-08-revA.dtso                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/x-prc-09-i3c-revA.dtso --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/x-prc-09-i3c-revA.dtso                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/x-prc-09-revA.dtso --label=/dev/null                               linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/x-prc-09-revA.dtso                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-a2197-revA.dts --label=/dev/null                            linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-a2197-revA.dts                            >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi                                                linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi                              >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-dlc21-revA.dts --label=/dev/null                            linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-dlc21-revA.dts                            >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revB.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-e-a2197-00-revB.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-g-a2197-00-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-g-a2197-00-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-01-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-01-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-02-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-02-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-03-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-m-a2197-03-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso --label=/dev/null        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-01-revA.dtso        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso --label=/dev/null        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-02-revA.dtso        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso --label=/dev/null        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-03-revA.dtso        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso --label=/dev/null        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-04-revA.dtso        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso --label=/dev/null        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA-x-prc-05-revA.dtso        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA.dts --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-p-a2197-00-revA.dts                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-revB.dts --label=/dev/null                               linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-revB.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-revC.dts --label=/dev/null                               linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-revC.dts                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revA.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revA.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revB.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vek280-revB.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vhk158-revA.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vhk158-revA.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vm-p-m1369-00-revA.dtso --label=/dev/null                linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vm-p-m1369-00-revA.dtso                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vn-p-b2197-00-revA.dtso --label=/dev/null                linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vn-p-b2197-00-revA.dtso                >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk120-revB.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk120-revB.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revA.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revA.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revB.dtso --label=/dev/null                       linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sc-vpk180-revB.dtso                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso --label=/dev/null                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso                                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso                                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts --label=/dev/null                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-vp-x-a2785-00-revA.dts --label=/dev/null                    linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-vp-x-a2785-00-revA.dts                    >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-vpk120-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-vpk120-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts                                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts                                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts                                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts                                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts                                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts                         >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts                                             linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts                                            linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revB.dts --label=/dev/null                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revB.dts                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu1285-revA.dts --label=/dev/null                          linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu1285-revA.dts                          >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu208-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu208-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu216-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu216-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revA.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revA.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revB.dts --label=/dev/null                           linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp-zcu670-revB.dts                           >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/arm64/boot/dts/xilinx/zynqmp.dtsi                                                        linux-xlnx-2025.1/arch/arm64/boot/dts/xilinx/zynqmp.dtsi                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/clock/xlnx-versal-net-clk.h --label=/dev/null                             linux-xlnx-2025.1/include/dt-bindings/clock/xlnx-versal-net-clk.h                             >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/power/xlnx-versal-net-power.h --label=/dev/null                           linux-xlnx-2025.1/include/dt-bindings/power/xlnx-versal-net-power.h                           >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/power/xlnx-versal-power.h --label=/dev/null                               linux-xlnx-2025.1/include/dt-bindings/power/xlnx-versal-power.h                               >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/power/xlnx-versal-regnode.h --label=/dev/null                             linux-xlnx-2025.1/include/dt-bindings/power/xlnx-versal-regnode.h                             >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/reset/xlnx-versal-net-resets.h --label=/dev/null                          linux-xlnx-2025.1/include/dt-bindings/reset/xlnx-versal-net-resets.h                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/030_arch-microblaze.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/arch/microblaze/configs/mmu_defconfig                                                         linux-xlnx-2025.1/arch/microblaze/configs/mmu_defconfig                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/microblaze/include/asm/sections.h                                                        linux-xlnx-2025.1/arch/microblaze/include/asm/sections.h                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/microblaze/kernel/head.S                                                                 linux-xlnx-2025.1/arch/microblaze/kernel/head.S                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/microblaze/kernel/setup.c                                                                linux-xlnx-2025.1/arch/microblaze/kernel/setup.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/microblaze/kernel/vmlinux.lds.S                                                          linux-xlnx-2025.1/arch/microblaze/kernel/vmlinux.lds.S                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/arch/microblaze/mm/init.c                                                                     linux-xlnx-2025.1/arch/microblaze/mm/init.c                                                   >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/100_kernel-irq.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/kernel/irq/handle.c                                                                           linux-xlnx-2025.1/kernel/irq/handle.c                                                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/101_net-ipv4.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/net/ipv4/af_inet.c                                                                            linux-xlnx-2025.1/net/ipv4/af_inet.c                                                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/102_crypto.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/crypto/ecdsa.c                                                                                linux-xlnx-2025.1/crypto/ecdsa.c                                                              >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/103_fs-nfsd.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/fs/nfsd/nfs4recover.c                                                                         linux-xlnx-2025.1/fs/nfsd/nfs4recover.c                                                       >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/202_drivers-clk.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt --label=/dev/null                 linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/idt,idt8t49n24x.txt                 >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/renesas,proxo.yaml --label=/dev/null                  linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/renesas,proxo.yaml                  >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/silabs,si5324.txt --label=/dev/null                   linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/silabs,si5324.txt                   >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/xlnx,fclk.yaml --label=/dev/null                      linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/xlnx,fclk.yaml                      >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/xlnx,vcu.yaml --label=/dev/null                       linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/xlnx,vcu.yaml                       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml                                  linux-xlnx-2025.1/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml                >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt                                     linux-xlnx-2025.1/Documentation/devicetree/bindings/soc/xilinx/xlnx,vcu.txt                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/Kconfig                                                                           linux-xlnx-2025.1/drivers/clk/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/Makefile                                                                          linux-xlnx-2025.1/drivers/clk/Makefile                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/clk-proxo.c --label=/dev/null                                                     linux-xlnx-2025.1/drivers/clk/clk-proxo.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/clk-si5324.c --label=/dev/null                                                    linux-xlnx-2025.1/drivers/clk/clk-si5324.c                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/clk-si5324.h --label=/dev/null                                                    linux-xlnx-2025.1/drivers/clk/clk-si5324.h                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/idt/ --label=/dev/null                                                            linux-xlnx-2025.1/drivers/clk/idt/                                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/si5324.h --label=/dev/null                                                        linux-xlnx-2025.1/drivers/clk/si5324.h                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/si5324drv.c --label=/dev/null                                                     linux-xlnx-2025.1/drivers/clk/si5324drv.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/si5324drv.h --label=/dev/null                                                     linux-xlnx-2025.1/drivers/clk/si5324drv.h                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                                    linux-xlnx-2025.1/drivers/clk/xilinx/clk-xlnx-clock-wizard.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/xilinx/xlnx_vcu.c                                                                 linux-xlnx-2025.1/drivers/clk/xilinx/xlnx_vcu.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/clk/zynqmp/clkc.c                                                                     linux-xlnx-2025.1/drivers/clk/zynqmp/clkc.c                                                   >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/203_drivers-clocksource.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/clocksource/timer-cadence-ttc.c                                                       linux-xlnx-2025.1/drivers/clocksource/timer-cadence-ttc.c                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/204_drivers-crypto.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml                                 linux-xlnx-2025.1/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/Kconfig                                                                        linux-xlnx-2025.1/drivers/crypto/Kconfig                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/Makefile                                                                linux-xlnx-2025.1/drivers/crypto/xilinx/Makefile                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/xilinx-ecdsa.c --label=/dev/null                                        linux-xlnx-2025.1/drivers/crypto/xilinx/xilinx-ecdsa.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/xilinx-rsa.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/crypto/xilinx/xilinx-rsa.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/xilinx_ecdsasig.asn1 --label=/dev/null                                  linux-xlnx-2025.1/drivers/crypto/xilinx/xilinx_ecdsasig.asn1                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/zynqmp-aes-gcm.c                                                        linux-xlnx-2025.1/drivers/crypto/xilinx/zynqmp-aes-gcm.c                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/zynqmp-rsa.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/crypto/xilinx/zynqmp-rsa.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/crypto/xilinx/zynqmp-sha.c                                                            linux-xlnx-2025.1/drivers/crypto/xilinx/zynqmp-sha.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/include/crypto/ecdsa.h --label=/dev/null                                                      linux-xlnx-2025.1/include/crypto/ecdsa.h                                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/205_drivers-dma.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/dma/xilinx/amd,mmi-dcdma-1.0.yaml --label=/dev/null         linux-xlnx-2025.1/Documentation/devicetree/bindings/dma/xilinx/amd,mmi-dcdma-1.0.yaml         >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma-test.yaml --label=/dev/null         linux-xlnx-2025.1/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-dma-test.yaml         >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-frmbuf.yaml --label=/dev/null           linux-xlnx-2025.1/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-frmbuf.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-vdma-test.yaml --label=/dev/null        linux-xlnx-2025.1/Documentation/devicetree/bindings/dma/xilinx/xlnx,axi-vdma-test.yaml        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/Kconfig                                                                           linux-xlnx-2025.1/drivers/dma/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/Makefile                                                                   linux-xlnx-2025.1/drivers/dma/xilinx/Makefile                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/axidmatest.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/dma/xilinx/axidmatest.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/mmi_dcdma.c --label=/dev/null                                              linux-xlnx-2025.1/drivers/dma/xilinx/mmi_dcdma.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/vdmatest.c --label=/dev/null                                               linux-xlnx-2025.1/drivers/dma/xilinx/vdmatest.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/xilinx_frmbuf.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/dma/xilinx/xilinx_frmbuf.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/dma/xilinx/zynqmp_dma.c                                                               linux-xlnx-2025.1/drivers/dma/xilinx/zynqmp_dma.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/dma/xilinx_frmbuf.h --label=/dev/null                                           linux-xlnx-2025.1/include/linux/dma/xilinx_frmbuf.h                                           >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/206_drivers-edac.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/ABI/testing/sysfs-driver-xilsem-edac --label=/dev/null                          linux-xlnx-2025.1/Documentation/ABI/testing/sysfs-driver-xilsem-edac                          >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml --label=/dev/null         linux-xlnx-2025.1/Documentation/devicetree/bindings/edac/xlnx,versal-xilsem-edac.yaml         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/edac/Kconfig                                                                          linux-xlnx-2025.1/drivers/edac/Kconfig                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/edac/Makefile                                                                         linux-xlnx-2025.1/drivers/edac/Makefile                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/edac/versal_edac.c                                                                    linux-xlnx-2025.1/drivers/edac/versal_edac.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/edac/xilinx_xilsem_edac.c --label=/dev/null                                           linux-xlnx-2025.1/drivers/edac/xilinx_xilsem_edac.c                                           >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/207_drivers-firmware.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp                                         linux-xlnx-2025.1/Documentation/ABI/stable/sysfs-driver-firmware-zynqmp                       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml                   linux-xlnx-2025.1/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/Kconfig                                                               linux-xlnx-2025.1/drivers/firmware/xilinx/Kconfig                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/Makefile                                                              linux-xlnx-2025.1/drivers/firmware/xilinx/Makefile                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-core.c --label=/dev/null                                       linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-core.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-crypto.c --label=/dev/null                                     linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-crypto.c                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-debug.c                                                        linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-debug.c                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-fpga.c --label=/dev/null                                       linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-fpga.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-nvm.c --label=/dev/null                                        linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-nvm.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-pdi.c --label=/dev/null                                        linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-pdi.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-pm.c --label=/dev/null                                         linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-pm.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-secure.c --label=/dev/null                                     linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-secure.c                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp-sem.c --label=/dev/null                                        linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp-sem.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/firmware/xilinx/zynqmp.c                                                              linux-xlnx-2025.1/drivers/firmware/xilinx/zynqmp.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/amd-versal2-error-events.h --label=/dev/null                           linux-xlnx-2025.1/include/linux/firmware/amd-versal2-error-events.h                           >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-versal-error-events.h --label=/dev/null                           linux-xlnx-2025.1/include/linux/firmware/xlnx-versal-error-events.h                           >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-versal-net-error-events.h --label=/dev/null                       linux-xlnx-2025.1/include/linux/firmware/xlnx-versal-net-error-events.h                       >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp-fpga.h --label=/dev/null                                   linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp-fpga.h                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp-nvm.h --label=/dev/null                                    linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp-nvm.h                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp-pdi.h --label=/dev/null                                    linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp-pdi.h                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp-secure.h --label=/dev/null                                 linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp-secure.h                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp-sem.h --label=/dev/null                                    linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp-sem.h                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/firmware/xlnx-zynqmp.h                                                          linux-xlnx-2025.1/include/linux/firmware/xlnx-zynqmp.h                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/208_drivers-fpga.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/ABI/testing/sysfs-class-fpga-bridge                                             linux-xlnx-2025.1/Documentation/ABI/testing/sysfs-class-fpga-bridge                           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/fpga/fpga-region.yaml                                       linux-xlnx-2025.1/Documentation/devicetree/bindings/fpga/fpga-region.yaml                     >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt --label=/dev/null                    linux-xlnx-2025.1/Documentation/devicetree/bindings/fpga/xlnx,afi-fpga.txt                    >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml --label=/dev/null              linux-xlnx-2025.1/Documentation/devicetree/bindings/fpga/xlnx,zynq-afi-fpga.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/Kconfig                                                                          linux-xlnx-2025.1/drivers/fpga/Kconfig                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/Makefile                                                                         linux-xlnx-2025.1/drivers/fpga/Makefile                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/fpga-bridge.c                                                                    linux-xlnx-2025.1/drivers/fpga/fpga-bridge.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/fpga-mgr.c                                                                       linux-xlnx-2025.1/drivers/fpga/fpga-mgr.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/of-fpga-region.c                                                                 linux-xlnx-2025.1/drivers/fpga/of-fpga-region.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/versal-fpga.c                                                                    linux-xlnx-2025.1/drivers/fpga/versal-fpga.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/xilinx-afi.c --label=/dev/null                                                   linux-xlnx-2025.1/drivers/fpga/xilinx-afi.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/zynq-afi.c --label=/dev/null                                                     linux-xlnx-2025.1/drivers/fpga/zynq-afi.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/fpga/zynqmp-fpga.c                                                                    linux-xlnx-2025.1/drivers/fpga/zynqmp-fpga.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/fpga/fpga-mgr.h                                                                 linux-xlnx-2025.1/include/linux/fpga/fpga-mgr.h                                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/209_drivers-gpio.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/gpio/gpio-xilinx.c                                                                    linux-xlnx-2025.1/drivers/gpio/gpio-xilinx.c                                                  >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/210_drivers-gpu-drm.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/amd,mmi-dc.yaml --label=/dev/null              linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/amd,mmi-dc.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/bridge.txt --label=/dev/null                   linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/bridge.txt                   >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,dp-tx.yaml --label=/dev/null              linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,dp-tx.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt --label=/dev/null                 linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,dsi.txt                 >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,mixer.txt --label=/dev/null               linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,mixer.txt               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,pl-disp.txt --label=/dev/null             linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,pl-disp.txt             >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,sdi-tx.yaml --label=/dev/null             linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,sdi-tx.yaml             >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,v-hdmi-txss1.yaml --label=/dev/null       linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,v-hdmi-txss1.yaml       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-csc.yaml --label=/dev/null           linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-csc.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-scaler.yaml --label=/dev/null        linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,vpss-scaler.yaml        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.txt --label=/dev/null                 linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,vtc.txt                 >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml                         linux-xlnx-2025.1/Documentation/devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/gpu/drivers.rst                                                                 linux-xlnx-2025.1/Documentation/gpu/drivers.rst                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/gpu/zynqmp.rst --label=/dev/null                                                linux-xlnx-2025.1/Documentation/gpu/zynqmp.rst                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/display/drm_hdmi_helper.c                                                     linux-xlnx-2025.1/drivers/gpu/drm/display/drm_hdmi_helper.c                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_atomic_state_helper.c                                                     linux-xlnx-2025.1/drivers/gpu/drm/drm_atomic_state_helper.c                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_atomic_uapi.c                                                             linux-xlnx-2025.1/drivers/gpu/drm/drm_atomic_uapi.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_connector.c                                                               linux-xlnx-2025.1/drivers/gpu/drm/drm_connector.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_edid.c                                                                    linux-xlnx-2025.1/drivers/gpu/drm/drm_edid.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_fb_dma_helper.c                                                           linux-xlnx-2025.1/drivers/gpu/drm/drm_fb_dma_helper.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_fbdev_dma.c                                                               linux-xlnx-2025.1/drivers/gpu/drm/drm_fbdev_dma.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_fourcc.c                                                                  linux-xlnx-2025.1/drivers/gpu/drm/drm_fourcc.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/drm_framebuffer.c                                                             linux-xlnx-2025.1/drivers/gpu/drm/drm_framebuffer.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/panel/panel-simple.c                                                          linux-xlnx-2025.1/drivers/gpu/drm/panel/panel-simple.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/Kconfig                                                                  linux-xlnx-2025.1/drivers/gpu/drm/xlnx/Kconfig                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/Makefile                                                                 linux-xlnx-2025.1/drivers/gpu/drm/xlnx/Makefile                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/hdcp/ --label=/dev/null                                                  linux-xlnx-2025.1/drivers/gpu/drm/xlnx/hdcp/                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/mmi_dc.c --label=/dev/null                                               linux-xlnx-2025.1/drivers/gpu/drm/xlnx/mmi_dc.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/mmi_dc.h --label=/dev/null                                               linux-xlnx-2025.1/drivers/gpu/drm/xlnx/mmi_dc.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/mmi_dc_kms.c --label=/dev/null                                           linux-xlnx-2025.1/drivers/gpu/drm/xlnx/mmi_dc_kms.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/mmi_dc_plane.c --label=/dev/null                                         linux-xlnx-2025.1/drivers/gpu/drm/xlnx/mmi_dc_plane.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_bridge.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_bridge.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_bridge.h --label=/dev/null                                          linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_bridge.h                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_crtc.c --label=/dev/null                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_crtc.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_crtc.h --label=/dev/null                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_crtc.h                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_csc.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_csc.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_dptx.c --label=/dev/null                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_dptx.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_drv.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_drv.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_drv.h --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_drv.h                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_dsi.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_dsi.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_fb.c --label=/dev/null                                              linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_fb.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_fb.h --label=/dev/null                                              linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_fb.h                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_gem.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_gem.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_gem.h --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_gem.h                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_hdmi.c --label=/dev/null                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_hdmi.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_mixer.c --label=/dev/null                                           linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_mixer.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_pl_disp.c --label=/dev/null                                         linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_pl_disp.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_scaler.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_scaler.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_sdi.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_sdi.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_sdi_modes.h --label=/dev/null                                       linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_sdi_modes.h                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_sdi_timing.c --label=/dev/null                                      linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_sdi_timing.c                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_sdi_timing.h --label=/dev/null                                      linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_sdi_timing.h                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/xlnx_vtc.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/xlnx_vtc.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_disp.c                                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_disp.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_disp.h                                                            linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_disp.h                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h                                                       linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_disp_regs.h                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_dp.c                                                              linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_dp.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_dp.h                                                              linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_dp.h                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_dp_audio.c --label=/dev/null                                      linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_dp_audio.c                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                                           linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_dpsub.h                                                           linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_dpsub.h                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/gpu/drm/xlnx/zynqmp_kms.c                                                             linux-xlnx-2025.1/drivers/gpu/drm/xlnx/zynqmp_kms.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/display/drm_dp.h                                                                  linux-xlnx-2025.1/include/drm/display/drm_dp.h                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/display/drm_hdmi_helper.h                                                         linux-xlnx-2025.1/include/drm/display/drm_hdmi_helper.h                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/drm_connector.h                                                                   linux-xlnx-2025.1/include/drm/drm_connector.h                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/drm_edid.h                                                                        linux-xlnx-2025.1/include/drm/drm_edid.h                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/drm_fourcc.h                                                                      linux-xlnx-2025.1/include/drm/drm_fourcc.h                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/drm/drm_mode_config.h                                                                 linux-xlnx-2025.1/include/drm/drm_mode_config.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/drm/ --label=/dev/null                                                    linux-xlnx-2025.1/include/dt-bindings/drm/                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/drm/drm_fourcc.h                                                                 linux-xlnx-2025.1/include/uapi/drm/drm_fourcc.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/drm/drm_mode.h                                                                   linux-xlnx-2025.1/include/uapi/drm/drm_mode.h                                                 >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/211_drivers-hwmon.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml                                linux-xlnx-2025.1/Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/hwmon/ina2xx.rst                                                                linux-xlnx-2025.1/Documentation/hwmon/ina2xx.rst                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/hwmon/Kconfig                                                                         linux-xlnx-2025.1/drivers/hwmon/Kconfig                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/hwmon/ina2xx.c                                                                        linux-xlnx-2025.1/drivers/hwmon/ina2xx.c                                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/212_drivers-i2c.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/i2c/busses/i2c-cadence.c                                                              linux-xlnx-2025.1/drivers/i2c/busses/i2c-cadence.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/i2c/busses/i2c-xiic.c                                                                 linux-xlnx-2025.1/drivers/i2c/busses/i2c-xiic.c                                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/213_drivers-i3c.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml                                 linux-xlnx-2025.1/Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.yaml               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/214_drivers-iio.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml --label=/dev/null           linux-xlnx-2025.1/Documentation/devicetree/bindings/iio/adc/xlnx,versal-sysmon.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/Kconfig                                                                       linux-xlnx-2025.1/drivers/iio/adc/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/Makefile                                                                      linux-xlnx-2025.1/drivers/iio/adc/Makefile                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/ina260-adc.c --label=/dev/null                                                linux-xlnx-2025.1/drivers/iio/adc/ina260-adc.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/versal-sysmon-core.c --label=/dev/null                                        linux-xlnx-2025.1/drivers/iio/adc/versal-sysmon-core.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/versal-sysmon-i2c.c --label=/dev/null                                         linux-xlnx-2025.1/drivers/iio/adc/versal-sysmon-i2c.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/versal-sysmon.c --label=/dev/null                                             linux-xlnx-2025.1/drivers/iio/adc/versal-sysmon.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/versal-sysmon.h --label=/dev/null                                             linux-xlnx-2025.1/drivers/iio/adc/versal-sysmon.h                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/xilinx-ams.c                                                                  linux-xlnx-2025.1/drivers/iio/adc/xilinx-ams.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/iio/adc/xilinx-xadc-core.c                                                            linux-xlnx-2025.1/drivers/iio/adc/xilinx-xadc-core.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/iio/adc/versal-sysmon-events.h --label=/dev/null                                linux-xlnx-2025.1/include/linux/iio/adc/versal-sysmon-events.h                                >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/216_drivers-irqchip.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt --label=/dev/null      linux-xlnx-2025.1/Documentation/devicetree/bindings/interrupt-controller/xilinx,intc.txt      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/irqchip/Kconfig                                                                       linux-xlnx-2025.1/drivers/irqchip/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/irqchip/irq-xilinx-intc.c                                                             linux-xlnx-2025.1/drivers/irqchip/irq-xilinx-intc.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/irqchip/irqchip.c                                                                     linux-xlnx-2025.1/drivers/irqchip/irqchip.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/irq.h                                                                           linux-xlnx-2025.1/include/linux/irq.h                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/irqchip.h                                                                       linux-xlnx-2025.1/include/linux/irqchip.h                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/of_irq.h                                                                        linux-xlnx-2025.1/include/linux/of_irq.h                                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/217_drivers-mailbox.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml                        linux-xlnx-2025.1/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mailbox/zynqmp-ipi-mailbox.c                                                          linux-xlnx-2025.1/drivers/mailbox/zynqmp-ipi-mailbox.c                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/218_drivers-media-common.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                                                 linux-xlnx-2025.1/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/219_drivers-media-i2c.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml --label=/dev/null                linux-xlnx-2025.1/Documentation/devicetree/bindings/media/i2c/onnn,ap1302.yaml                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/i2c/Kconfig                                                                     linux-xlnx-2025.1/drivers/media/i2c/Kconfig                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/i2c/Makefile                                                                    linux-xlnx-2025.1/drivers/media/i2c/Makefile                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/i2c/ap1302.c --label=/dev/null                                                  linux-xlnx-2025.1/drivers/media/i2c/ap1302.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/i2c/ov5640.c                                                                    linux-xlnx-2025.1/drivers/media/i2c/ov5640.c                                                  >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/220_drivers-media-mc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/media/mc/mc-entity.c                                                                  linux-xlnx-2025.1/drivers/media/mc/mc-entity.c                                                >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/221_drivers-media-platform.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,axis-broadcaster.yaml --label=/dev/null   linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,axis-broadcaster.yaml   >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,axis-subsetconv.yaml --label=/dev/null    linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,axis-subsetconv.yaml    >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.yaml                             linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,isppipeline.yaml --label=/dev/null        linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,isppipeline.yaml        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,mem2mem.yaml --label=/dev/null            linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,mem2mem.yaml            >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,sdirxss.yaml --label=/dev/null            linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,sdirxss.yaml            >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-axi4s-switch.yaml --label=/dev/null     linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-axi4s-switch.yaml     >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-demosaic.yaml --label=/dev/null         linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-demosaic.yaml         >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-dprxss.yaml --label=/dev/null           linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-dprxss.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-gamma-lut.yaml --label=/dev/null        linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-gamma-lut.yaml        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-hdmi-rxss1.yaml --label=/dev/null       linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-hdmi-rxss1.yaml       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-hls.yaml --label=/dev/null              linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-hls.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-multi-scaler.yaml --label=/dev/null     linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-multi-scaler.yaml     >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-scd.txt --label=/dev/null               linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-scd.txt               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.txt                                  linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.txt                >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.yaml --label=/dev/null               linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tc.yaml               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.txt                                 linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.txt               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.yaml --label=/dev/null              linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-tpg.yaml              >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-csc.yaml --label=/dev/null         linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-csc.yaml         >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-scaler.yaml --label=/dev/null      linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,v-vpss-scaler.yaml      >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/media/xilinx/xlnx,video.txt                                 linux-xlnx-2025.1/Documentation/devicetree/bindings/media/xilinx/xlnx,video.txt               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/Kconfig                                                         linux-xlnx-2025.1/drivers/media/platform/xilinx/Kconfig                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/Makefile                                                        linux-xlnx-2025.1/drivers/media/platform/xilinx/Makefile                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-axis-broadcaster.c --label=/dev/null                     linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-axis-broadcaster.c                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-axis-subsetconv.c --label=/dev/null                      linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-axis-subsetconv.c                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-axis-switch.c --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-axis-switch.c                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-csi2rxss.c                                               linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-csi2rxss.c                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-demosaic.c --label=/dev/null                             linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-demosaic.c                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-dma.c                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-dma.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-dma.h                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-dma.h                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-dprxss.c --label=/dev/null                               linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-dprxss.c                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-gamma-coeff.h --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-gamma-coeff.h                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-gamma-correction.h --label=/dev/null                     linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-gamma-correction.h                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-gamma.c --label=/dev/null                                linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-gamma.c                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdcp1x-rx.c --label=/dev/null                            linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdcp1x-rx.c                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdcp1x-rx.h --label=/dev/null                            linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdcp1x-rx.h                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdcp2x-rx-crypt.c --label=/dev/null                      linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdcp2x-rx-crypt.c                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdcp2x-rx.c --label=/dev/null                            linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdcp2x-rx.c                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdcp2x-rx.h --label=/dev/null                            linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdcp2x-rx.h                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdmirx-hw.h --label=/dev/null                            linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdmirx-hw.h                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hdmirxss.c --label=/dev/null                             linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hdmirxss.c                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hls-common.h --label=/dev/null                           linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hls-common.h                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-hls.c --label=/dev/null                                  linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-hls.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-isp-params.h --label=/dev/null                           linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-isp-params.h                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-isppipeline.c --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-isppipeline.c                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-m2m.c --label=/dev/null                                  linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-m2m.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-multi-scaler-coeff.h --label=/dev/null                   linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-multi-scaler-coeff.h                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-multi-scaler.c --label=/dev/null                         linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-multi-scaler.c                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-scenechange-channel.c --label=/dev/null                  linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-scenechange-channel.c                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-scenechange-dma.c --label=/dev/null                      linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-scenechange-dma.c                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-scenechange.c --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-scenechange.c                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-scenechange.h --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-scenechange.h                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-sdirxss.c --label=/dev/null                              linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-sdirxss.c                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-tpg.c                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-tpg.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vip.c                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vip.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vip.h                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vip.h                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vipp.c                                                   linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vipp.c                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vipp.h                                                   linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vipp.h                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vpss-csc.c --label=/dev/null                             linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vpss-csc.c                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vpss-scaler.c --label=/dev/null                          linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vpss-scaler.c                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vtc.c                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vtc.c                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/platform/xilinx/xilinx-vtc.h                                                    linux-xlnx-2025.1/drivers/media/platform/xilinx/xilinx-vtc.h                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/include/dt-bindings/media/xilinx-vip.h                                                        linux-xlnx-2025.1/include/dt-bindings/media/xilinx-vip.h                                      >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/222_drivers-media-test-drivers.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/media/test-drivers/vivid/vivid-vid-common.c                                           linux-xlnx-2025.1/drivers/media/test-drivers/vivid/vivid-vid-common.c                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/224_drivers-media-v4l2.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/biblio.rst                                              linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/biblio.rst                            >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/colorspaces-defs.rst                                    linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/colorspaces-defs.rst                  >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/colorspaces-details.rst                                 linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/colorspaces-details.rst               >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst                                   linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst                 >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/subdev-formats.rst                                      linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/subdev-formats.rst                    >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst                                    linux-xlnx-2025.1/Documentation/userspace-api/media/v4l/vidioc-queryctrl.rst                  >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/userspace-api/media/videodev2.h.rst.exceptions                                  linux-xlnx-2025.1/Documentation/userspace-api/media/videodev2.h.rst.exceptions                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/v4l2-core/v4l2-common.c                                                         linux-xlnx-2025.1/drivers/media/v4l2-core/v4l2-common.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/media/v4l2-core/v4l2-ioctl.c                                                          linux-xlnx-2025.1/drivers/media/v4l2-core/v4l2-ioctl.c                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/include/media/hdr-ctrls.h --label=/dev/null                                                   linux-xlnx-2025.1/include/media/hdr-ctrls.h                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/include/media/media-entity.h                                                                  linux-xlnx-2025.1/include/media/media-entity.h                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/media-bus-format.h                                                         linux-xlnx-2025.1/include/uapi/linux/media-bus-format.h                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/v4l2-mediabus.h                                                            linux-xlnx-2025.1/include/uapi/linux/v4l2-mediabus.h                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/videodev2.h                                                                linux-xlnx-2025.1/include/uapi/linux/videodev2.h                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-dprxss.h --label=/dev/null                                          linux-xlnx-2025.1/include/uapi/linux/xilinx-dprxss.h                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-hdmirxss.h --label=/dev/null                                        linux-xlnx-2025.1/include/uapi/linux/xilinx-hdmirxss.h                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-hls.h --label=/dev/null                                             linux-xlnx-2025.1/include/uapi/linux/xilinx-hls.h                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-sdirxss.h --label=/dev/null                                         linux-xlnx-2025.1/include/uapi/linux/xilinx-sdirxss.h                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-v4l2-controls.h                                                     linux-xlnx-2025.1/include/uapi/linux/xilinx-v4l2-controls.h                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xilinx-v4l2-events.h --label=/dev/null                                     linux-xlnx-2025.1/include/uapi/linux/xilinx-v4l2-events.h                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/usr/include/Makefile                                                                          linux-xlnx-2025.1/usr/include/Makefile                                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/225_drivers-mfd.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/mfd/syscon.yaml                                             linux-xlnx-2025.1/Documentation/devicetree/bindings/mfd/syscon.yaml                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mfd/rsmu_core.c                                                                       linux-xlnx-2025.1/drivers/mfd/rsmu_core.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mfd/rsmu_i2c.c                                                                        linux-xlnx-2025.1/drivers/mfd/rsmu_i2c.c                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/mfd/idt82p33_reg.h                                                              linux-xlnx-2025.1/include/linux/mfd/idt82p33_reg.h                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/mfd/idt8a340_reg.h                                                              linux-xlnx-2025.1/include/linux/mfd/idt8a340_reg.h                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/mfd/rsmu.h                                                                      linux-xlnx-2025.1/include/linux/mfd/rsmu.h                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/mfd/syscon/xlnx-vcu.h                                                           linux-xlnx-2025.1/include/linux/mfd/syscon/xlnx-vcu.h                                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/226_drivers-misc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/misc/xlnx,dpu.yaml --label=/dev/null                        linux-xlnx-2025.1/Documentation/devicetree/bindings/misc/xlnx,dpu.yaml                        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml --label=/dev/null            linux-xlnx-2025.1/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai-engine.yaml            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/Kconfig                                                                          linux-xlnx-2025.1/drivers/misc/Kconfig                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/Makefile                                                                         linux-xlnx-2025.1/drivers/misc/Makefile                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/rsmu_cdev.c --label=/dev/null                                                    linux-xlnx-2025.1/drivers/misc/rsmu_cdev.c                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/rsmu_cdev.h --label=/dev/null                                                    linux-xlnx-2025.1/drivers/misc/rsmu_cdev.h                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/rsmu_cm.c --label=/dev/null                                                      linux-xlnx-2025.1/drivers/misc/rsmu_cm.c                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/rsmu_sabre.c --label=/dev/null                                                   linux-xlnx-2025.1/drivers/misc/rsmu_sabre.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/xilinx-ai-engine/ --label=/dev/null                                              linux-xlnx-2025.1/drivers/misc/xilinx-ai-engine/                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/xilinx_puf.c --label=/dev/null                                                   linux-xlnx-2025.1/drivers/misc/xilinx_puf.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/xlnx_dpu.c --label=/dev/null                                                     linux-xlnx-2025.1/drivers/misc/xlnx_dpu.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/misc/xlnx_dpu.h --label=/dev/null                                                     linux-xlnx-2025.1/drivers/misc/xlnx_dpu.h                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/xlnx-ai-engine.h --label=/dev/null                                              linux-xlnx-2025.1/include/linux/xlnx-ai-engine.h                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/rsmu.h --label=/dev/null                                                   linux-xlnx-2025.1/include/uapi/linux/rsmu.h                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xlnx-ai-engine.h --label=/dev/null                                         linux-xlnx-2025.1/include/uapi/linux/xlnx-ai-engine.h                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/misc/xilinx_puf.h --label=/dev/null                                              linux-xlnx-2025.1/include/uapi/misc/xilinx_puf.h                                              >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/227_drivers-mmc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/mmc/host/sdhci-of-arasan.c                                                            linux-xlnx-2025.1/drivers/mmc/host/sdhci-of-arasan.c                                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/228_drivers-mtd.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml                             linux-xlnx-2025.1/Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/atmel.c                                                                   linux-xlnx-2025.1/drivers/mtd/spi-nor/atmel.c                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/core.c                                                                    linux-xlnx-2025.1/drivers/mtd/spi-nor/core.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/core.h                                                                    linux-xlnx-2025.1/drivers/mtd/spi-nor/core.h                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/debugfs.c                                                                 linux-xlnx-2025.1/drivers/mtd/spi-nor/debugfs.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/everspin.c                                                                linux-xlnx-2025.1/drivers/mtd/spi-nor/everspin.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/gigadevice.c                                                              linux-xlnx-2025.1/drivers/mtd/spi-nor/gigadevice.c                                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/issi.c                                                                    linux-xlnx-2025.1/drivers/mtd/spi-nor/issi.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/macronix.c                                                                linux-xlnx-2025.1/drivers/mtd/spi-nor/macronix.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/micron-st.c                                                               linux-xlnx-2025.1/drivers/mtd/spi-nor/micron-st.c                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/otp.c                                                                     linux-xlnx-2025.1/drivers/mtd/spi-nor/otp.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/sfdp.c                                                                    linux-xlnx-2025.1/drivers/mtd/spi-nor/sfdp.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/spansion.c                                                                linux-xlnx-2025.1/drivers/mtd/spi-nor/spansion.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/sst.c                                                                     linux-xlnx-2025.1/drivers/mtd/spi-nor/sst.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/swp.c                                                                     linux-xlnx-2025.1/drivers/mtd/spi-nor/swp.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/mtd/spi-nor/winbond.c                                                                 linux-xlnx-2025.1/drivers/mtd/spi-nor/winbond.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/mtd/spi-nor.h                                                                   linux-xlnx-2025.1/include/linux/mtd/spi-nor.h                                                 >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/230_drivers-net-ethernet.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/net/cdns,macb.yaml                                          linux-xlnx-2025.1/Documentation/devicetree/bindings/net/cdns,macb.yaml                        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml                                  linux-xlnx-2025.1/Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml                >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml                                      linux-xlnx-2025.1/Documentation/devicetree/bindings/net/xlnx,emaclite.yaml                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/cadence/macb.h                                                           linux-xlnx-2025.1/drivers/net/ethernet/cadence/macb.h                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/cadence/macb_main.c                                                      linux-xlnx-2025.1/drivers/net/ethernet/cadence/macb_main.c                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/Kconfig                                                           linux-xlnx-2025.1/drivers/net/ethernet/xilinx/Kconfig                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/Makefile                                                          linux-xlnx-2025.1/drivers/net/ethernet/xilinx/Makefile                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet.h                                                  linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet.h                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet_dma.c --label=/dev/null                            linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_dma.c                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c --label=/dev/null                            linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_eoe.c                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h --label=/dev/null                            linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_eoe.h                            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet_main.c                                             linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_main.c                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c --label=/dev/null                          linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_axienet_mcdma.c                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/ethernet/xilinx/xilinx_emaclite.c                                                 linux-xlnx-2025.1/drivers/net/ethernet/xilinx/xilinx_emaclite.c                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/231_drivers-net-phy.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/net/xilinx-phy.txt --label=/dev/null                        linux-xlnx-2025.1/Documentation/devicetree/bindings/net/xilinx-phy.txt                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/phy/Kconfig                                                                       linux-xlnx-2025.1/drivers/net/phy/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/phy/Makefile                                                                      linux-xlnx-2025.1/drivers/net/phy/Makefile                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/phy/phy-core.c                                                                    linux-xlnx-2025.1/drivers/net/phy/phy-core.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/phy/phylink.c                                                                     linux-xlnx-2025.1/drivers/net/phy/phylink.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/net/phy/xilinx_phy.c --label=/dev/null                                                linux-xlnx-2025.1/drivers/net/phy/xilinx_phy.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/phy.h                                                                           linux-xlnx-2025.1/include/linux/phy.h                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/xilinx_phy.h --label=/dev/null                                                  linux-xlnx-2025.1/include/linux/xilinx_phy.h                                                  >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/234_drivers-nvmem.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml --label=/dev/null            linux-xlnx-2025.1/Documentation/devicetree/bindings/nvmem/xlnx,versal-sec-cfg.yaml            >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/nvmem/Kconfig                                                                         linux-xlnx-2025.1/drivers/nvmem/Kconfig                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/nvmem/Makefile                                                                        linux-xlnx-2025.1/drivers/nvmem/Makefile                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/nvmem/xlnx_secure_config.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/nvmem/xlnx_secure_config.c                                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/235_drivers-of.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/configfs-overlays.txt --label=/dev/null                              linux-xlnx-2025.1/Documentation/devicetree/configfs-overlays.txt                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/of/Kconfig                                                                            linux-xlnx-2025.1/drivers/of/Kconfig                                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/of/Makefile                                                                           linux-xlnx-2025.1/drivers/of/Makefile                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/of/configfs.c --label=/dev/null                                                       linux-xlnx-2025.1/drivers/of/configfs.c                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/of/overlay.c                                                                          linux-xlnx-2025.1/drivers/of/overlay.c                                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/236_drivers-pci.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml --label=/dev/null             linux-xlnx-2025.1/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml             >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml                                       linux-xlnx-2025.1/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml                     >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml                                  linux-xlnx-2025.1/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml                >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml                                      linux-xlnx-2025.1/Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pci/controller/dwc/Kconfig                                                            linux-xlnx-2025.1/drivers/pci/controller/dwc/Kconfig                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pci/controller/dwc/Makefile                                                           linux-xlnx-2025.1/drivers/pci/controller/dwc/Makefile                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pci/controller/dwc/pcie-amd-mdb.c --label=/dev/null                                   linux-xlnx-2025.1/drivers/pci/controller/dwc/pcie-amd-mdb.c                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pci/controller/pcie-xilinx-cpm.c                                                      linux-xlnx-2025.1/drivers/pci/controller/pcie-xilinx-cpm.c                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pci/controller/pcie-xilinx-nwl.c                                                      linux-xlnx-2025.1/drivers/pci/controller/pcie-xilinx-nwl.c                                    >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/237_drivers-phy.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/phy/xlnx,gt-quad-base.yaml --label=/dev/null                linux-xlnx-2025.1/Documentation/devicetree/bindings/phy/xlnx,gt-quad-base.yaml                >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/phy/xlnx,v-hmdi-phy1.yaml --label=/dev/null                 linux-xlnx-2025.1/Documentation/devicetree/bindings/phy/xlnx,v-hmdi-phy1.yaml                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/Kconfig                                                                    linux-xlnx-2025.1/drivers/phy/xilinx/Kconfig                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/Makefile                                                                   linux-xlnx-2025.1/drivers/phy/xilinx/Makefile                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy.c --label=/dev/null                                               linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy.h --label=/dev/null                                               linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy_core.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy_core.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy_gt_helper.c --label=/dev/null                                     linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy_gt_helper.c                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy_mmcm.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy_mmcm.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xhdmiphy_modules.c --label=/dev/null                                       linux-xlnx-2025.1/drivers/phy/xilinx/xhdmiphy_modules.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/phy/xilinx/xilinx_dpgtquadphy.c --label=/dev/null                                     linux-xlnx-2025.1/drivers/phy/xilinx/xilinx_dpgtquadphy.c                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/phy/phy-hdmi.h --label=/dev/null                                                linux-xlnx-2025.1/include/linux/phy/phy-hdmi.h                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/phy/phy.h                                                                       linux-xlnx-2025.1/include/linux/phy/phy.h                                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/238_drivers-pinctrl.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml --label=/dev/null          linux-xlnx-2025.1/Documentation/devicetree/bindings/pinctrl/xlnx,versal-pinctrl.yaml          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pinctrl/pinctrl-zynqmp.c                                                              linux-xlnx-2025.1/drivers/pinctrl/pinctrl-zynqmp.c                                            >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/240_drivers-ptp.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml --label=/dev/null                       linux-xlnx-2025.1/Documentation/devicetree/bindings/ptp/ptp-xilinx.yaml                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/Kconfig                                                                           linux-xlnx-2025.1/drivers/ptp/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/Makefile                                                                          linux-xlnx-2025.1/drivers/ptp/Makefile                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/ptp_clockmatrix.c                                                                 linux-xlnx-2025.1/drivers/ptp/ptp_clockmatrix.c                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/ptp_clockmatrix.h                                                                 linux-xlnx-2025.1/drivers/ptp/ptp_clockmatrix.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/ptp_idt82p33.h                                                                    linux-xlnx-2025.1/drivers/ptp/ptp_idt82p33.h                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ptp/ptp_xilinx.c --label=/dev/null                                                    linux-xlnx-2025.1/drivers/ptp/ptp_xilinx.c                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/ptp/ --label=/dev/null                                                          linux-xlnx-2025.1/include/linux/ptp/                                                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/241_drivers-pwm.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/pwm/Kconfig                                                                           linux-xlnx-2025.1/drivers/pwm/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pwm/Makefile                                                                          linux-xlnx-2025.1/drivers/pwm/Makefile                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/pwm/pwm-cadence.c --label=/dev/null                                                   linux-xlnx-2025.1/drivers/pwm/pwm-cadence.c                                                   >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/242_drivers-remoteproc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/remoteproc/xlnx_r5_remoteproc.c                                                       linux-xlnx-2025.1/drivers/remoteproc/xlnx_r5_remoteproc.c                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/243_drivers-reset.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml                          linux-xlnx-2025.1/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/245_drivers-rtc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/rtc/rtc-zynqmp.c                                                                      linux-xlnx-2025.1/drivers/rtc/rtc-zynqmp.c                                                    >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/246_drivers-soc-xilinx.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml                                      linux-xlnx-2025.1/Documentation/devicetree/bindings/soc/xilinx/xilinx.yaml                    >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt --label=/dev/null             linux-xlnx-2025.1/Documentation/devicetree/bindings/soc/xilinx/xlnx,ai_engine.txt             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/soc/xilinx/xlnx_event_manager.c                                                       linux-xlnx-2025.1/drivers/soc/xilinx/xlnx_event_manager.c                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/soc/xilinx/zynqmp_power.c                                                             linux-xlnx-2025.1/drivers/soc/xilinx/zynqmp_power.c                                           >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/247_drivers-spi.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml                                      linux-xlnx-2025.1/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml                    >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/spi/spi-controller.yaml                                     linux-xlnx-2025.1/Documentation/devicetree/bindings/spi/spi-controller.yaml                   >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml                               linux-xlnx-2025.1/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml             >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml                                    linux-xlnx-2025.1/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml                  >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/trivial-devices.yaml                                        linux-xlnx-2025.1/Documentation/devicetree/bindings/trivial-devices.yaml                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi-cadence-quadspi.c                                                             linux-xlnx-2025.1/drivers/spi/spi-cadence-quadspi.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi-mem.c                                                                         linux-xlnx-2025.1/drivers/spi/spi-mem.c                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi-xilinx.c                                                                      linux-xlnx-2025.1/drivers/spi/spi-xilinx.c                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi-zynq-qspi.c                                                                   linux-xlnx-2025.1/drivers/spi/spi-zynq-qspi.c                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi-zynqmp-gqspi.c                                                                linux-xlnx-2025.1/drivers/spi/spi-zynqmp-gqspi.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/spi/spi.c                                                                             linux-xlnx-2025.1/drivers/spi/spi.c                                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/spi/spi-mem.h                                                                   linux-xlnx-2025.1/include/linux/spi/spi-mem.h                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/spi/spi.h                                                                       linux-xlnx-2025.1/include/linux/spi/spi.h                                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/248_drivers-staging.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/staging/display/ --label=/dev/null                          linux-xlnx-2025.1/Documentation/devicetree/bindings/staging/display/                          >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/staging/net/ --label=/dev/null                              linux-xlnx-2025.1/Documentation/devicetree/bindings/staging/net/                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/Kconfig                                                                       linux-xlnx-2025.1/drivers/staging/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/Makefile                                                                      linux-xlnx-2025.1/drivers/staging/Makefile                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/fclk/ --label=/dev/null                                                       linux-xlnx-2025.1/drivers/staging/fclk/                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/uartlite-rs485/ --label=/dev/null                                             linux-xlnx-2025.1/drivers/staging/uartlite-rs485/                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xilinx-tsn/ --label=/dev/null                                                 linux-xlnx-2025.1/drivers/staging/xilinx-tsn/                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xilinx_hdcp/ --label=/dev/null                                                linux-xlnx-2025.1/drivers/staging/xilinx_hdcp/                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xlnx-mmi-dptx/ --label=/dev/null                                              linux-xlnx-2025.1/drivers/staging/xlnx-mmi-dptx/                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xlnx_hdcp1x/ --label=/dev/null                                                linux-xlnx-2025.1/drivers/staging/xlnx_hdcp1x/                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xlnxsync/ --label=/dev/null                                                   linux-xlnx-2025.1/drivers/staging/xlnxsync/                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xroeframer/ --label=/dev/null                                                 linux-xlnx-2025.1/drivers/staging/xroeframer/                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/staging/xroetrafficgen/ --label=/dev/null                                             linux-xlnx-2025.1/drivers/staging/xroetrafficgen/                                             >>$PATCH_FILE 
diff -urN linux-6.12.10/include/linux/xlnx/ --label=/dev/null                                                         linux-xlnx-2025.1/include/linux/xlnx/                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/xlnxsync.h --label=/dev/null                                               linux-xlnx-2025.1/include/uapi/linux/xlnxsync.h                                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/249_drivers-thermal.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml --label=/dev/null          linux-xlnx-2025.1/Documentation/devicetree/bindings/thermal/xlnx,versal-thermal.yaml          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/thermal/Kconfig                                                                       linux-xlnx-2025.1/drivers/thermal/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/thermal/Makefile                                                                      linux-xlnx-2025.1/drivers/thermal/Makefile                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/thermal/versal_thermal.c --label=/dev/null                                            linux-xlnx-2025.1/drivers/thermal/versal_thermal.c                                            >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/250_drivers-tty.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/serial/pl011.yaml                                           linux-xlnx-2025.1/Documentation/devicetree/bindings/serial/pl011.yaml                         >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml                               linux-xlnx-2025.1/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml             >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/251_drivers-ufs.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml --label=/dev/null                  linux-xlnx-2025.1/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/core/ufshcd-priv.h                                                                linux-xlnx-2025.1/drivers/ufs/core/ufshcd-priv.h                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/core/ufshcd.c                                                                     linux-xlnx-2025.1/drivers/ufs/core/ufshcd.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/host/Kconfig                                                                      linux-xlnx-2025.1/drivers/ufs/host/Kconfig                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/host/Makefile                                                                     linux-xlnx-2025.1/drivers/ufs/host/Makefile                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/host/ufs-amd-versal2.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/ufs/host/ufs-amd-versal2.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/host/ufshcd-dwc.h                                                                 linux-xlnx-2025.1/drivers/ufs/host/ufshcd-dwc.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/ufs/host/ufshci-dwc.h                                                                 linux-xlnx-2025.1/drivers/ufs/host/ufshci-dwc.h                                               >>$PATCH_FILE 
diff -urN linux-6.12.10/include/ufs/ufshcd.h                                                                          linux-xlnx-2025.1/include/ufs/ufshcd.h                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/include/ufs/ufshci.h                                                                          linux-xlnx-2025.1/include/ufs/ufshci.h                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/include/ufs/unipro.h                                                                          linux-xlnx-2025.1/include/ufs/unipro.h                                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/252_drivers-uio.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/perf/xilinx-apm.yaml --label=/dev/null                      linux-xlnx-2025.1/Documentation/devicetree/bindings/perf/xilinx-apm.yaml                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/Kconfig                                                                           linux-xlnx-2025.1/drivers/uio/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/Makefile                                                                          linux-xlnx-2025.1/drivers/uio/Makefile                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio.c                                                                             linux-xlnx-2025.1/drivers/uio/uio.c                                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio_core.c --label=/dev/null                                                      linux-xlnx-2025.1/drivers/uio/uio_core.c                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio_dmabuf.c --label=/dev/null                                                    linux-xlnx-2025.1/drivers/uio/uio_dmabuf.c                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio_dmabuf.h --label=/dev/null                                                    linux-xlnx-2025.1/drivers/uio/uio_dmabuf.h                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio_xilinx_ai_engine.c --label=/dev/null                                          linux-xlnx-2025.1/drivers/uio/uio_xilinx_ai_engine.c                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/uio/uio_xilinx_apm.c --label=/dev/null                                                linux-xlnx-2025.1/drivers/uio/uio_xilinx_apm.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/include/uapi/linux/uio/ --label=/dev/null                                                     linux-xlnx-2025.1/include/uapi/linux/uio/                                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/260_drivers-usb-core.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/usb/usb-xhci.yaml                                           linux-xlnx-2025.1/Documentation/devicetree/bindings/usb/usb-xhci.yaml                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/261_drivers-usb-chipidea.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/usb/chipidea/ci_hdrc_usb2.c                                                           linux-xlnx-2025.1/drivers/usb/chipidea/ci_hdrc_usb2.c                                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/262_drivers-usb-dwc3.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml                                        linux-xlnx-2025.1/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml                      >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/usb/snps,dwc3.yaml                                          linux-xlnx-2025.1/Documentation/devicetree/bindings/usb/snps,dwc3.yaml                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/Kconfig                                                                      linux-xlnx-2025.1/drivers/usb/dwc3/Kconfig                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/Makefile                                                                     linux-xlnx-2025.1/drivers/usb/dwc3/Makefile                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/core.c                                                                       linux-xlnx-2025.1/drivers/usb/dwc3/core.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/core.h                                                                       linux-xlnx-2025.1/drivers/usb/dwc3/core.h                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/debugfs.c                                                                    linux-xlnx-2025.1/drivers/usb/dwc3/debugfs.c                                                  >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/dwc3-xilinx.c                                                                linux-xlnx-2025.1/drivers/usb/dwc3/dwc3-xilinx.c                                              >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/ep0.c                                                                        linux-xlnx-2025.1/drivers/usb/dwc3/ep0.c                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/gadget.c                                                                     linux-xlnx-2025.1/drivers/usb/dwc3/gadget.c                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/gadget.h                                                                     linux-xlnx-2025.1/drivers/usb/dwc3/gadget.h                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/gadget_hibernation.c --label=/dev/null                                       linux-xlnx-2025.1/drivers/usb/dwc3/gadget_hibernation.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/host.c                                                                       linux-xlnx-2025.1/drivers/usb/dwc3/host.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/otg.c --label=/dev/null                                                      linux-xlnx-2025.1/drivers/usb/dwc3/otg.c                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/otg.h --label=/dev/null                                                      linux-xlnx-2025.1/drivers/usb/dwc3/otg.h                                                      >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/dwc3/platform_data.h --label=/dev/null                                            linux-xlnx-2025.1/drivers/usb/dwc3/platform_data.h                                            >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/263_drivers-usb-gadget.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/usb/gadget/function/f_tcm.c                                                           linux-xlnx-2025.1/drivers/usb/gadget/function/f_tcm.c                                         >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/264_drivers-usb-host.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/usb/host/Kconfig                                                                      linux-xlnx-2025.1/drivers/usb/host/Kconfig                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/host/xhci-plat.c                                                                  linux-xlnx-2025.1/drivers/usb/host/xhci-plat.c                                                >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/host/xhci.c                                                                       linux-xlnx-2025.1/drivers/usb/host/xhci.c                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/host/xhci.h                                                                       linux-xlnx-2025.1/drivers/usb/host/xhci.h                                                     >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/265_drivers-usb-misc.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/usb/misc/onboard_usb_dev.c                                                            linux-xlnx-2025.1/drivers/usb/misc/onboard_usb_dev.c                                          >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/266_drivers-usb-phy.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/usb/ulpi-phy.yaml --label=/dev/null                         linux-xlnx-2025.1/Documentation/devicetree/bindings/usb/ulpi-phy.yaml                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/phy/Kconfig                                                                       linux-xlnx-2025.1/drivers/usb/phy/Kconfig                                                     >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/usb/phy/phy-ulpi.c                                                                    linux-xlnx-2025.1/drivers/usb/phy/phy-ulpi.c                                                  >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/271_drivers-video.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/video/hdmi.c                                                                          linux-xlnx-2025.1/drivers/video/hdmi.c                                                        >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/272_drivers-virtio.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/virtio/virtio_ring.c                                                                  linux-xlnx-2025.1/drivers/virtio/virtio_ring.c                                                >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/273_drivers-w1.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml                              linux-xlnx-2025.1/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml            >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/275_drivers-xen.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/drivers/xen/Kconfig                                                                           linux-xlnx-2025.1/drivers/xen/Kconfig                                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/xen/Makefile                                                                          linux-xlnx-2025.1/drivers/xen/Makefile                                                        >>$PATCH_FILE 
diff -urN linux-6.12.10/drivers/xen/pvcalls.c --label=/dev/null                                                       linux-xlnx-2025.1/drivers/xen/pvcalls.c                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/include/xen/pvcalls.h --label=/dev/null                                                       linux-xlnx-2025.1/include/xen/pvcalls.h                                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/include/xen/xen.h                                                                             linux-xlnx-2025.1/include/xen/xen.h                                                           >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/301_sound-soc-xilinx.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt                              linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.txt            >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml --label=/dev/null           linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,audio-formatter.yaml           >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,i2s.txt                                          linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,i2s.txt                        >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml --label=/dev/null                       linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml                       >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,spdif.txt                                        linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,spdif.txt                      >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml --label=/dev/null                     linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml                     >>$PATCH_FILE 
diff -urN linux-6.12.10/Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml --label=/dev/null            linux-xlnx-2025.1/Documentation/devicetree/bindings/sound/xlnx,v-uhdsdi-audio.yaml            >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/Kconfig                                                                      linux-xlnx-2025.1/sound/soc/xilinx/Kconfig                                                    >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/Makefile                                                                     linux-xlnx-2025.1/sound/soc/xilinx/Makefile                                                   >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_formatter_pcm.c                                                         linux-xlnx-2025.1/sound/soc/xilinx/xlnx_formatter_pcm.c                                       >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_i2s.c                                                                   linux-xlnx-2025.1/sound/soc/xilinx/xlnx_i2s.c                                                 >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_pl_snd_card.c --label=/dev/null                                         linux-xlnx-2025.1/sound/soc/xilinx/xlnx_pl_snd_card.c                                         >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_sdi_audio.c --label=/dev/null                                           linux-xlnx-2025.1/sound/soc/xilinx/xlnx_sdi_audio.c                                           >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_snd_common.h --label=/dev/null                                          linux-xlnx-2025.1/sound/soc/xilinx/xlnx_snd_common.h                                          >>$PATCH_FILE 
diff -urN linux-6.12.10/sound/soc/xilinx/xlnx_spdif.c                                                                 linux-xlnx-2025.1/sound/soc/xilinx/xlnx_spdif.c                                               >>$PATCH_FILE 

PATCH_FILE=$PATCH_DIR/999_other-document.patch
echo -n >| $PATCH_FILE

diff -urN linux-6.12.10/MAINTAINERS                                                                                   linux-xlnx-2025.1/MAINTAINERS                                                                 >>$PATCH_FILE 


cat << 'EOT' > $PATCH_DIR/xxx_patch.sh
PATCH_DIR=$(cd $(dirname $0); pwd)
dry_run=0
verbose=1

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
    run_command "patch -p1 < ${PATCH_DIR}/${1}"
    run_command "git add --all"
    run_command "git commit -m '[patch] ${1}'"
}

run_patch 010_arch-arm-mach-zynq.patch
run_patch 011_arch-arm-configs.patch
run_patch 012_arch-arm-boot-dts.patch
run_patch 020_arch-arm64.patch
run_patch 021_arch-arm64-configs.patch
run_patch 022_arch-arm64-boot-dts.patch
run_patch 030_arch-microblaze.patch
run_patch 100_kernel-irq.patch
run_patch 101_net-ipv4.patch
run_patch 102_crypto.patch
run_patch 103_fs-nfsd.patch
run_patch 202_drivers-clk.patch
run_patch 203_drivers-clocksource.patch
run_patch 204_drivers-crypto.patch
run_patch 205_drivers-dma.patch
run_patch 206_drivers-edac.patch
run_patch 207_drivers-firmware.patch
run_patch 208_drivers-fpga.patch
run_patch 209_drivers-gpio.patch
run_patch 210_drivers-gpu-drm.patch
run_patch 211_drivers-hwmon.patch
run_patch 212_drivers-i2c.patch
run_patch 213_drivers-i3c.patch
run_patch 214_drivers-iio.patch
run_patch 216_drivers-irqchip.patch
run_patch 217_drivers-mailbox.patch
run_patch 218_drivers-media-common.patch
run_patch 219_drivers-media-i2c.patch
run_patch 220_drivers-media-mc.patch
run_patch 221_drivers-media-platform.patch
run_patch 222_drivers-media-test-drivers.patch
run_patch 224_drivers-media-v4l2.patch
run_patch 225_drivers-mfd.patch
run_patch 226_drivers-misc.patch
run_patch 227_drivers-mmc.patch
run_patch 228_drivers-mtd.patch
run_patch 230_drivers-net-ethernet.patch
run_patch 231_drivers-net-phy.patch
run_patch 234_drivers-nvmem.patch
run_patch 235_drivers-of.patch
run_patch 236_drivers-pci.patch
run_patch 237_drivers-phy.patch
run_patch 238_drivers-pinctrl.patch
run_patch 240_drivers-ptp.patch
run_patch 241_drivers-pwm.patch
run_patch 242_drivers-remoteproc.patch
run_patch 243_drivers-reset.patch
run_patch 245_drivers-rtc.patch
run_patch 246_drivers-soc-xilinx.patch
run_patch 247_drivers-spi.patch
run_patch 248_drivers-staging.patch
run_patch 249_drivers-thermal.patch
run_patch 250_drivers-tty.patch
run_patch 251_drivers-ufs.patch
run_patch 252_drivers-uio.patch
run_patch 260_drivers-usb-core.patch
run_patch 261_drivers-usb-chipidea.patch
run_patch 262_drivers-usb-dwc3.patch
run_patch 263_drivers-usb-gadget.patch
run_patch 264_drivers-usb-host.patch
run_patch 265_drivers-usb-misc.patch
run_patch 266_drivers-usb-phy.patch
run_patch 271_drivers-video.patch
run_patch 272_drivers-virtio.patch
run_patch 273_drivers-w1.patch
run_patch 275_drivers-xen.patch
run_patch 301_sound-soc-xilinx.patch
run_patch 999_other-document.patch
EOT
