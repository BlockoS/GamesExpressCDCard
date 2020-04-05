	.code
	.bank $000
	.org $e179
gx_write_cd_fade_timer:
          and     #$0f
          sta     cd_fade_timer
          rts     
gx_unknown_e17f:
          stz     <$20
          lda     #$35
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     gx_unknown_e1a0
          tax     
          bne     le19f_00
          lda     #$01
          sta     <$20
          lda     #$37
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     gx_unknown_e1a0
          tax     
le19f_00:
          rts     
gx_unknown_e1a0:
          tii     $2020, $2207, $0008
le1a7_00:
          jsr     gx_unknown_e25c
          lda     #$de
          sta     $2210
          lda     <$20
          sta     $2211
          lda     <$23
          sta     $2212
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le1e6_00
          lda     #$04
          sta     <$23
          stz     <$24
          jsr     gx_unknown_e1e7
          jsr     gx_unknown_e4cd
          tii     $2207, $2020, $0008
          cmp     #$00
          beq     le1e6_00
          jsr     gx_unknown_e532
          bcs     le1e6_00
          tii     $2207, $2020, $0008
          jmp     le1a7_00
le1e6_00:
          rts     
gx_unknown_e1e7:
          lda     cd_status
          and     #$f8
          sta     $222f
          cmp     #$d8
          beq     le21a_00
          cmp     #$c8
          beq     le1fa_00
          jmp     gx_unknown_e1e7
le1fa_00:
          cly     
          lda     cd_command
          sta     [$21], Y
          jsr     gx_unknown_e279
          inc     <$21
          bne     le209_00
          inc     <$22
le209_00:
          sec     
          lda     <$23
          sbc     #$01
          sta     <$23
          lda     <$24
          sbc     #$00
          sta     <$24
          ora     <$23
          bne     gx_unknown_e1e7
le21a_00:
          lda     cd_status
          and     #$f8
          sta     $222f
          and     #$b8
          cmp     #$88
          jsr     le4ea_00
          rts     
gx_cd_reset:
          lda     cd_reset                  ; setting bit 2 will reset CDROM hardware
          ora     #$02
          sta     cd_reset
          lda     #$01
          jsr     gx_cd_wait
          lda     cd_reset                  ; reset bit 2
          and     #$fd
          sta     cd_reset
          ldx     #$80                      ; wait a little longer
@loop:
          dex     
          bne     @loop
          rts     
gx_unknown_e245:
          jsr     gx_unknown_e25c
          stz     $2210
          jsr     gx_unknown_e28b
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le25a_00
          jsr     gx_unknown_e532
          sec     
          rts     
le25a_00:
          clc     
          rts     
gx_unknown_e25c:
          stz     $2211
          tii     $2211, $2212, $0008
          rts     
gx_cd_wait:                                 ; A is the input parameter
          phx                               ; it will wait for A*(loop cycles)
          phy     
@l0:                                        ; loop cycles cycles:
          ldx     #$28                      ; 2
@l1:
          ldy     #$21                      ; 2
@l2:
          dey                               ; 2
          bne     @l2                       ; 4 (2 if the branch is not taken)
          dex                               ; 2
          bne     @l1                       ; 4 (2 if the branch is not taken)
          dec     A                         ; = 7962 cycles
          bne     @l0
          ply     
          plx     
          rts     
gx_unknown_e279:
          lda     #$80
          tsb     cd_control
le27e_00:
          lda     cd_status                 ; poll cd status while bit 4 is set
          and     #$40
          bne     le27e_00
          lda     #$80
          trb     cd_control
          rts     
gx_unknown_e28b:
          stz     $220f
le28e_00:
          lda     #$81
          sta     cd_command
          tst     #$80, cd_status
          beq     le2c2_00
          lda     #$60
          trb     cd_control
          sta     cd_status
          lda     #$19
          jsr     gx_cd_wait
          lda     #$ff
          sta     cd_command
          tst     #$40, cd_status
          beq     le28e_00
le2b1_00:
          jsr     gx_unknown_e279
le2b4_00:
          tst     #$40, $cd_status
          bne     le2b1_00
          tst     #$80, $cd_status
          bne     le2b4_00
          bra     le28e_00
le2c2_00:
          sta     cd_status
          clx     
le2c6_00:
          lda     cd_status
          and     #$40
          bne     le2d8_00
          lda     #$5a
le2cf_00:
          dec     A
          bne     le2cf_00
          nop     
          dex     
          bne     le2c6_00
          bra     le28e_00
le2d8_00:
          stz     $222f
          clx     
le2dc_00:
          lda     cd_status
          and     #$f8
          sta     $222f
          cmp     #$d0
          beq     le2f8_00
          and     #$b8
          cmp     #$98
          beq     le308_00
          cmp     #$88
          beq     le308_00
          cmp     #$80
          beq     le308_00
          bra     le2dc_00
le2f8_00:
          lda     $2210, X
          inx     
          sta     cd_command
          nop     
          nop     
          nop     
          nop     
          jsr     gx_unknown_e279
          bra     le2dc_00
le308_00:
          lda     $2206
          bne     le339_00
          lda     $2210
          cmp     #$d9
          bne     le31b_00
          lda     $2211
          cmp     #$01
          beq     le339_00
le31b_00:
          ldx     <$33
le31d_00:
          lda     cd_status
          and     #$f8
          sta     $222f
          bit     #$40
          bne     le339_00
          txa     
          sec     
          sbc     <$33
          eor     #$ff
          inc     A
          cmp     #$fe
          bcc     le31d_00
          lda     #$01
          sta     $220f
le339_00:
          rts     

	.code
	.bank $000
	.org $e4cd
gx_unknown_e4cd:
          lda     $220f
          beq     le4db_00
          stz     $220f
          jsr     gx_cd_reset
          lda     #$06
          rts     
le4db_00:
          jsr     le4ea_00                          ; what the hell?
          jsr     gx_unknown_e513
          lda     $2232
          bne     le4e9_00
          stz     $2233
le4e9_00:
          rts     

	.code
	.bank $000
	.org $e513
gx_unknown_e513:
          php     
          sei     
le515_00:
          lda     cd_status
          and     #$f8
          cmp     #$f8
          beq     le520_00
          bra     le515_00
le520_00:
          lda     cd_command
          sta     $222f
          jsr     gx_unknown_e279
          plp     
le52a_00:
          lda     cd_status
          and     #$80
          bmi     le52a_00
          rts     
gx_unknown_e532:
          cmp     #$06
          beq     le582_00
          cmp     #$02
          beq     le582_00
          tii     $2210, $221b, $000a
          jsr     gx_unknown_e586
          lda     $2233
          beq     le582_00
          cmp     #$04
          beq     le57f_00
          cmp     #$11
          beq     le582_00
          cmp     #$15
          beq     le582_00
          cmp     #$16
          beq     le582_00
          cmp     #$0b
          beq     le584_00
          cmp     #$0d
          beq     le584_00
          cmp     #$1c
          beq     le584_00
          cmp     #$1d
          beq     le584_00
          cmp     #$20
          bcc     le582_00
          cmp     #$23
          bcc     le584_00
          cmp     #$25
          beq     le584_00
          cmp     #$2a
          beq     le584_00
          cmp     #$2c
          beq     le584_00
          bra     le582_00
le57f_00:
          sta     $2231
le582_00:
          clc     
          rts     
le584_00:
          sec     
          rts     
gx_unknown_e586:
          stz     $2225
          tii     $2225, $2226, $0009
          jsr     gx_unknown_e25c
          lda     #$00
          sta     $2210
          lda     #$0a
          sta     $2214
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le5b7_00
          lda     #$25
          sta     <$15
          lda     #$22
          sta     <$16
          lda     #$0a
          sta     <$17
          lda     #$00
          sta     <$18
          jsr     le48f_00
le5b7_00:
          jsr     gx_unknown_e4cd
          pha     
          cmp     #$00
          bne     le5cb_00
          lda     $2227
          sta     $2230
          lda     $222e
          sta     $2233
le5cb_00:
          pla     
          rts     

	.code
	.bank $000
	.org $e794
gx_adpcm_reset:
          lda     #$80
          sta     adpcm_addr_ctrl
          stz     adpcm_addr_ctrl
          stz     adpcm_dma_ctrl
          lda     #$6f
          trb     cd_control                ; clear all bits except bits 4 and 7
          stz     adpcm_playback_rate
          rts     

	.code
	.bank $000
	.org $e865
gx_irq_2_unknown:
          lda     cd_control
          and     bram_lock 
          ora     <$19
          sta     <$19
          bbr2    <$19, le87c_00
          lda     #$04
          trb     cd_control 
          lda     #$04
          trb     <$19
          cli     
le87c_00:
          bbr5    <$19, le8d9_00
          lda     #$20
          trb     cd_control
          lda     #$20
          trb     <$19
          cli     
          lda     $2206
          beq     le891_00
          stz     adpcm_dma_ctrl
le891_00:
          lda     cd_command
          sta     $2232
          lda     #$80
          tsb     cd_control
le89c_00:
          tst     #$40, $1800
          bne     le89c_00
          php     
          sei     
          lda     #$80
          trb     cd_control
le8a9_00:
          lda     cd_status
          and     #$f8
          cmp     #$f8
          bne     le8a9_00
          lda     cd_command
          lda     #$80
          tsb     cd_control
          plp     
le8bb_00:
          tst     #$40, $1800
          bne     le8bb_00
          lda     #$80
          trb     cd_control
le8c6_00:
          tst     #$80, $1800
          bne     le8c6_00
          lda     $2206
          beq     le8d9_00
          stz     $2206
          lda     #$04
          tsb     cd_control
le8d9_00:
          bbr4    <$19, le8f1_00
          lda     #$10
          trb     cd_control
          lda     #$10
          trb     <$19
          cli     
          lda     bram_unlock
          sta     $2234
          lda     #$10
          tsb     cd_control
le8f1_00:
          bbr3    <$19, le902_00
          lda     #$0c
          trb     cd_control
          lda     #$08
          trb     <$19
          lda     #$60
          trb     adpcm_addr_ctrl
le902_00:
          rts     

gx_unknown_e903:
          php     
          sei     
          stz     $22be
          ldx     #$04
          lda     #$68
          sta     $22ae, X
          lda     #$ea
          sta     $22b3, X
          lda     #$20
          sta     $22a4, X
          lda     #$04
          sta     $228b, X
          stz     $22b8, X
          dex     
le922_00:
          lda     #$00
          sta     $228b, X
          stz     $2290, X
          stz     $22b8, X
          dex     
          bne     le922_00
          stz     $22bd
          lda     #$80
          sta     $22b8, X
          lda     #$81
          sta     $228b
          plp     
          rts     

	.code
	.bank $000
	.org $e98c
gx_unknown_e98c:                            ; parameters: X, Y => source pointer
          lda     #$01                      ; set bit #1
          tsb     $22be
          stx     <$29                      ; set data pointer
          sty     <$28
          clx     
le996_00:
          lda     $228b, X                  ; what's inside 228b and onwards?
          cmp     #$00
          beq     le9a3_00
          inx     
          cmp     #$05
          bne     le996_00
          brk                               ; trigger IRQ2
le9a3_00:
          lda     #$04
          sta     $228b, X
          ldy     #$01
          lda     [$28]
          sta     $22ae, X
          lda     [$28], Y
          sta     $22b3, X
          iny     
          lda     [$28], Y
          sta     $22a4, X
          iny     
          lda     [$28], Y
          sta     $22b8, X
          lda     #$00
          sta     $22a9, X
          lda     #$01                      ; reset bit #1
          trb     $22be                     ; does this mean that 22be is some kind of lock?
          txa     
          rts     

	.code
	.bank $000
	.org $e9d7
gx_unknown_e9d7:
          cpx     $22bd
          beq     le9cc_00
          lda     #$00
          sta     $228b, X
          rts     

gx_unknown_e9e2:
          lda     #$01
gx_unknown_e9e4:
          pha     
          lda     #$01
          tsb     $22be
          txa     
          ldx     $22bd
          sta     $229a, X
          tya     
          sta     $229f, X
          pla     
          php     
          sta     $2290, X
          pla     
          sta     $22a9, X
          pla     
          clc     
          adc     #$01
          sta     $22ae, X
          pla     
          adc     #$00
          sta     $22b3, X
          sax     
          tsx     
          sax     
          sta     $22a4, X
          lda     #$02
          sta     $228b, X
          jmp     lea5a_00
gx_unknown_ea19:
          phx     
          ldx     $22bd
          sta     $2295, X
          pla     
          sta     $229a, X
          tya     
          sta     $229f, X
          pla     
          sta     $22a9, X
          pla     
          sta     $22ae, X
          pla     
          sta     $22b3, X
          sax     
          tsx     
          sax     
          sta     $22a4, X
          lda     #$04
          sta     $228b, X
          ldx     #$04
lea41_00:
          lda     $228b, X
          cmp     #$02
          bne     lea52_00
          dec     $2290, X
          bne     lea52_00
          lda     #$04
          sta     $228b, X
lea52_00:
          dex     
          bpl     lea41_00
          lda     #$01
          tsb     $22be
lea5a_00:
          clx     
lea5b_00:
          lda     $228b, X
          cmp     #$04
          beq     lea6b_00
          inx     
          cpx     #$05
          bne     lea5b_00
          brk     
          cli     
lea69_00:
          bra     lea69_00
lea6b_00:
          stx     $22bd
          lda     #$01
          ora     $22b8, X
          sta     $228b, X
          lda     $229f, X
          tay     
          lda     $22a4, X
          sax     
          txs     
          sax     
          lda     $22b3, X
          pha     
          lda     $22ae, X
          pha     
          lda     $22a9, X
          pha     
          lda     $229a, X
          pha     
          sei     
          lda     #$01
          trb     $22be
          lda     $2295, X
          plx     
          rti     

gx_irq_nmi:
          rti     

          bbr2    <irq_m, leaa2_00
          jmp     [$2263]
leaa2_00:
          rti     

gx_irq_2:
          bbr1    <irq_m, leaa9_00
          jmp     [irq2_user_hook]
leaa9_00:
          pha     
          phx     
          phy     
          jsr     gx_irq_2_unknown
          ply     
          plx     
          pla     
          rti     

gx_irq_reset:
          csh                           ; switch CPU to high speed mode
          sei                           ; disable interrupts
          cld                           ; clear decimal flag
          lda     #$ff                  ; map I/O to the 1st memory page
          tam     #$00
          lda     #$f8                  ; map RAM to the 2nd memory page
          tam     #$01
          stz     <$00                  ; clear zero page
          tii     $2000, $2001, $00ff
          stz     $2200                 ; clear bss
          tii     $2200, $2201, $1dff
lead1_00:
          sei                           ; disable interrupts
          stz     timer_ctrl            ; disable CPU timer
          csh                           ; switch CPU to high speed mode
          ldx     #$ff                  ; reset stack pointer
          txs     
          lda     $22bf
          bne     leae1_00
          inc     $22bf
leae1_00:
          lda     #$01                  ; map 1st ROM bank to the 6th memory page
          tam     #$06
          jsr     gx_unknown_e903
          jmp     gx_main
gx_update_scroll:
          stz     <$35                  ; ??
          stz     <$38                  ; ??
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          rts     
gx_unknown_eb00:
          lda     $24c0
          sta     <$39
          lda     $24bf
          sta     $24c0
          lda     #$20
          bit     $24c1
          bne     leb59_00
          bmi     leb34_00
          lda     <$39
          cmp     $24bf
          beq     leb1f_00
          lda     #$c0
          tsb     <vdc_control
leb1f_00:
          lda     $24c1
          and     #$0f
          eor     #$ff
          sec     
          adc     $24bf
          sta     $24bf
          bpl     leb6a_00
          stz     $24bf
          bra     leb52_00
leb34_00:
          lda     $24c1
          and     #$0f
          clc     
          adc     $24bf
          bcs     leb48_00
          sta     $24bf
          asl     A
          cmp     $24c2
          bcc     leb6a_00
leb48_00:
          lda     $24c2
          sta     $24bf
          lda     #$c0
          trb     <vdc_control
leb52_00:
          lda     #$20
          tsb     $24c1
          bra     leb6a_00
leb59_00:
          lda     #$10
          bit     $24c1
          bne     leb65_00
          tsb     $24c1
          bra     leb6a_00
leb65_00:
          lda     #$40
          trb     $24c1
leb6a_00:
          st0     #$08
          lda     <vdc_scroll_y
          clc     
          adc     <$39
          sta     video_data_l
          lda     <vdc_scroll_y+1
          bcc     leb79_00
          inc     A
leb79_00:
          sta     video_data_h
          st0     #$0c
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          clc     
          adc     <$39
          sta     video_data_h
          st0     #$0d
          lda     $24c2
          lsr     A
          sbc     <$39
          asl     A
          sta     video_data_l
          st0     #$0e
          lda     $24c4
          clc     
          adc     <$39
          sta     video_data_l
          rts     
gx_irq_1:
          bbr0    <irq_m, @gx_irq1
          jmp     [irq1_user_hook]
@gx_irq1:
          pha     
          phx     
          phy     
          lda     video_reg_l
          sta     <vdc_status
          bit     #$08                          ; test for VRAM to SATB transfer end
          beq     @check_spr_or
          lda     $204a
          and     #$01
          clc     
          adc     #$08
          st0     #$13                          ; set VRAM SATB source address
          st1     #$00
          sta     video_data_h
          lda     <vdc_status
@check_spr_or:
          bit     #$02                          ; test for sprites overflow 
          beq     @check_vsync
          inc     $2049                         ; ?!
          lda     <vdc_control
          and     #$fd                          ; disable sprite overflow interrupt
          sta     <vdc_control
          st0     #$05
          sta     video_data_l
          lda     <vdc_status
@check_vsync:
          bit     #$20                          ; test for vsync
          bne     @vsync
          jmp     lec5a_00
@vsync:
          lda     <$35
          sta     <$37
          bne     lec24_00
          st0     #$06                          ; set raster counter to 0 (no hsync?)
          st1     #$00
          st2     #$00
          st0     #$07                          ; set X scroll
          lda     <vdc_scroll_x
          sta     video_data_l
          lda     <vdc_scroll_x+1
          sta     video_data_h
          bit     $24c1                         ; ??
          bvc     @scroll_y
          jsr     gx_unknown_eb00
          bra     @update_scroll
@scroll_y:
          st0     #$08                          ; set Y scroll
          lda     <vdc_scroll_y
          sta     video_data_l
          lda     <vdc_scroll_y+1
          sta     video_data_h
@update_scroll:
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          jmp     lec2d_00
lec24_00:
          lda     <$34
          sta     <$36
          stz     <$38
          jsr     gx_unknown_ec6f
lec2d_00:
          st0     #$05
          lda     <vdc_control
          ora     #$02                          ; enable sprite overflow interrupt
          sta     video_data_l
          inc     <$33
          lda     <vdc_reg
          sta     video_reg_l
          jsr     gx_unknown_f27a
          jsr     gx_unknown_ef41
          ldx     $22bd
          lda     $228b, X
          bit     #$80
          bne     lec6b_00
          lda     $22be
          bit     #$01
          bne     lec6b_00
          ply     
          plx     
          pla     
          jmp     gx_unknown_ea19
lec5a_00:
          lda     <$37
          beq     lec66_00
          ldx     #$0f
lec60_00:
          dex     
          bpl     lec60_00
          jsr     gx_unknown_ec6f
lec66_00:
          lda     <vdc_reg
          sta     video_reg_l
lec6b_00:
          ply     
          plx     
          pla     
          rti     
gx_unknown_ec6f:
          ldy     <$38
          lda     [$36], Y
          bmi     lec90_00
          beq     lece1_00
          dec     A
          beq     leccf_00
          dec     A
          beq     lecbd_00
          dec     A
          beq     lec91_00
          iny     
          lda     <vdc_control
          and     [$36], Y
          iny     
          ora     [$36], Y
          st0     #$05
          sta     video_data_l
          jmp     lece1_00
lec90_00:
          rts     
lec91_00:
          iny     
          st0     #$07
          lda     <vdc_scroll_x
          sta     video_data_l
          lda     <vdc_scroll_x+1
          sta     video_data_h
          st0     #$08
          lda     <vdc_scroll_y
          sta     video_data_l
          lda     <vdc_scroll_y+1
          sta     video_data_h
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          jmp     lecf2_00
lecbd_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$08
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          jmp     lecf2_00
leccf_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$07
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          jmp     lecf2_00
lece1_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$07
          sta     video_data_l
          lda     [$36], Y
          sta     video_data_h
          jmp     lecbd_00
lecf2_00:
          lda     [$36], Y
          iny     
          st0     #$06
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          sty     <$38
          rts     
gx_unknown_ed03:
          stz     $22c6
          rts     
          lda     $22c6
          rts     
          lda     $22c6
          bne     led11_00
          rts     
led11_00:
          jsr     gx_unknown_e9e4
          rts     
gx_vdc_load_vram:
          lda     <$3b
led17_00:
          cmp     #$60
          bcc     led22_00
          sbc     #$20
          inc     $22c7
          bra     led17_00
led22_00:
          sta     <$3b
          stz     $22c0
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7
          sta     <vdc_control+1
          sta     video_data_h
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          sta     video_data_l
          lda     $22c2
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          asl     A
          sta     $22c3
          lda     $22c2
          rol     A
          sta     $22c4
          tma     #$02
          sta     $22c8
          tma     #$03
          sta     $22c9
          lda     $22c7
          tam     #$02
          inc     A
          tam     #$03
          lda     [$3a]
          sta     $22c6
          inc     <$3a
          bne     led7c_00
          inc     <$3b
led7c_00:
          clx     
          bra     ledcb_00
          lda     $22c6
          bne     led85_00
          rts     
led85_00:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7
          sta     <vdc_control+1
          sta     video_data_h
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          sta     video_data_l
          lda     $22c2
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          tma     #$02
          sta     $22c8
          tma     #$03
          sta     $22c9
          lda     $22c7
          tam     #$02
          inc     A
          tam     #$03
          ldx     $22c0
          beq     ledcb_00
          lda     <$3f
          sta     video_data_l
ledcb_00:
          lda     <$3b
          cmp     #$60
          bcc     leddc_00
          sbc     #$20
          sta     <$3b
          tma     #$03
          tam     #$02
          inc     A
          tam     #$03
leddc_00:
          lda     [$3a]
          cmp     #$ff
          beq     leded_00
          bit     #$80
          beq     lee1e_00
          bit     #$40
          beq     lee51_00
          jmp     gx_vdc_write
leded_00:
          dec     $22c6
          lda     $22c4
          lsr     A
          sta     $22c2
          lda     $22c3
          ror     A
          sta     $22c1
          stx     $22c0
          clc     
          lda     <$3a
          adc     #$01
          sta     <$3a
          lda     <$3b
          adc     #$00
          sta     <$3b
          tma     #$02
          sta     $22c7
          lda     $22c8
          tam     #$02
          lda     $22c9
          tam     #$03
          rts     
lee1e_00:
          bit     #$40
          bne     lee80_00
          and     #$3f
          sta     <$3e
          ldy     #$01
          adc     $22c3
          sta     $22c3
          bcc     lee33_00
          inc     $22c4
lee33_00:
          lda     [$3a], Y
          sta     video_data_l, X
          iny     
          sax     
          eor     #$01
          sax     
          dec     <$3e
          bne     lee33_00
          sta     <$3f
          clc     
          tya     
          adc     <$3a
          sta     <$3a
          cla     
          adc     <$3b
          sta     <$3b
          jmp     ledcb_00
lee51_00:
          and     #$3f
          sta     <$3e
          ldy     #$01
          adc     $22c3
          sta     $22c3
          bcc     lee62_00
          inc     $22c4
lee62_00:
          lda     [$3a], Y
          sta     <$3f
lee66_00:
          sta     video_data_l, X
          sax     
          eor     #$01
          sax     
          dec     <$3e
          bne     lee66_00
          clc     
          lda     #$02
          adc     <$3a
          sta     <$3a
          cla     
          adc     <$3b
          sta     <$3b
          jmp     ledcb_00
lee80_00:
          and     #$3f
          sta     <$3e
          asl     A
          adc     $22c3
          sta     $22c3
          bcc     lee90_00
          inc     $22c4
lee90_00:
          ldy     #$01
          lda     [$3a], Y
          sta     <$3c
          iny     
          lda     [$3a], Y
          sta     <$3d
          sec     
          tya     
          adc     <$3a
          sta     <$3a
          bcc     leea5_00
          inc     <$3b
leea5_00:
          lda     <$3c
          sta     video_data_l, X
          txa     
          eor     #$01
          tax     
          iny     
          lda     <$3d
          sta     video_data_l, X
          sax     
          eor     #$01
          sax     
          inc     <$3c
          bne     leebe_00
          inc     <$3d
leebe_00:
          dec     <$3e
          bne     leea5_00
          sta     <$3f
          jmp     ledcb_00
gx_vdc_write:
          and     #$3f
          sta     <$3e
          asl     A
          adc     $22c3
          sta     $22c3
          bcc     @loop
          inc     $22c4
@loop:
          ldy     #$01
          lda     [$3a], Y
          sta     video_data_l, X
          txa     
          eor     #$01
          tax     
          iny     
          lda     [$3a], Y
          sta     video_data_l, X
          sax     
          eor     #$01
          sax     
          dec     <$3e
          bne     @loop
          sta     <$3f
          clc     
          lda     <$3a
          adc     #$03
          sta     <$3a
          lda     <$3b
          adc     #$00
          sta     <$3b
          jmp     ledcb_00
          lda     #$40
          sta     $22ca
          lda     #$5e
          sta     $22cb
          lda     #$80
          sta     $22cc
          rts     
          lda     $22ca
          eor     $22cb
          and     #$02
          clc     
          beq     lef1e_00
          sec     
lef1e_00:
          ror     $22ca
          ror     $22cb
          ror     $22cc
          clc     
          lda     $22ca
          adc     #$47
          ror     A
          ror     A
          eor     $22cb
          adc     $22cc
          sta     $22cb
          rts     
          eor     #$80
          asl     A
          lda     #$00
          adc     #$ff
          rts     
gx_unknown_ef41:
          cly     
          lda     #$01
          sta     joyport
          lda     #$03
          sta     joyport
lef4c_00:
          lda     #$01
          sta     joyport
          pha     
          pla     
          nop     
          lda     $22d3, Y
          sta     $22ce, Y
          lda     joyport
          pha     
          and     #$0f
          eor     #$0f
          tax     
          lda     lefb9_00, X
          stz     joyport
          pla     
          asl     A
          asl     A
          asl     A
          asl     A
          sta     $22d3, Y
          lda     joyport
          and     #$0f
          ora     $22d3, Y
          eor     #$ff
          sta     $22d3, Y
          eor     $22ce, Y
          pha     
          and     $22d3, Y
          sta     $22d8, Y
          pla     
          and     $22ce, Y
          sta     $22dd, Y
          iny     
          cpy     #$05
          bcc     lef4c_00
          cly     
lef95_00:
          lda     $22cd
          and     $efb4, Y
          beq     lefae_00
          lda     $22d8, Y
          cmp     #$04
          bne     lefae_00
          lda     $22d3, Y
          cmp     #$0c
          bne     lefae_00
          jmp     lead1_00
lefae_00:
          iny     
          cpy     #$05
          bcc     lef95_00
          rts     
          ora     [$02, X]
          tsb     <$08
          bpl     lefb9_00
          brk     
          sxy     
          ora     [$04, X]
          bbs7    <$03, lefc0_00
          asl     <$07
          bbs7    <$ff, lefcb_00
          bbs7    <$ff, lefc8_00
gx_display_init:
          stz     <gx_scroll_x
lefcb_00:
          stz     <gx_scroll_x+1
          stz     <gx_scroll_y
          stz     <gx_scroll_y+1
          sta     <$42
          lsr     A
          lsr     A
          lsr     A
          sta     <$43
          stz     <$11
          stz     $2303
          stz     $2302
          jsr     gx_vce_init
          jsr     gx_vdc_init
          stz     $24bf
          stz     $24c0
          rts     
gx_vdc_init:
          lda     $f031
          sta     <vdc_control
          lda     $f032
          sta     <vdc_control+1
          lda     #$30
          sta     <$00
          lda     #$f0
          sta     <$01
          php     
          sei     
          ldy     #$00
@vdc_set_reg:
          lda     [$00], Y
          iny     
          sta     video_reg_l
          lda     [$00], Y
          iny     
          sta     video_data_l
          lda     [$00], Y
          iny     
          sta     video_data_h
          cpy     #$1b
          bne     @vdc_set_reg
          lda     <$42
          beq     @skip
@vdc_xres_341:
          st0     #$0a
          st1     #$02
          st2     #$05
          st0     #$0b
          st1     #$27
          st2     #$04
@skip:
          lda     #$e8
          jsr     gx_vdc_set_yres
          plp     
          rts     
gx_vdc_init_table:
          ora     <$8e
          st0     #$06
          brk     
          brk     
          rmb0    <$00
          brk     
          php     
          brk     
          brk     
          ora     #$40
          brk     
          asl     A
          sxy     
          sxy     
          .db     $0b
          bbr1    <$04, @vce_clear
          ora     [$00, X]
          st1     #$00
          php     
gx_vce_init:
          lda     <$42
          bne     @vce_next_mode
          lda     #$04
          bra     @vce_clear
@vce_next_mode:
          lda     #$05
@vce_clear:
          sta     color_ctrl
          stz     color_reg_l
          stz     color_reg_h
          ldx     #$04
          cly     
@loop:
          stz     color_data_l
          stz     color_data_h
          dey     
          bne     @loop
          dex     
          bne     @loop
          rts     
gx_vdc_enable_display:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$c0
          sta     <vdc_control
          sta     video_data_l
          rts     
gx_vdc_disable_display:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          and     #$3f
          sta     <vdc_control
          sta     video_data_l
          rts     
gx_vdc_set_ctrl_hi:
          tax     
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7
          ora     gx_vdc_vram_auto_inc, X
          sta     <vdc_control+1
          sta     video_data_h
          rts     
gx_vdc_vram_auto_inc:
          brk     
          php     
          bpl     lf0c1_00
          tax     
          lda     $f0bb, X
          php     
          sei     
          st0     #$09
          sta     video_data_l
          lda     <vdc_reg
          sta     video_reg_l
          plp     
          rts     
          brk     
          bpl     lf0de_00
          bmi     lf100_00
          bvc     lf122_00
          bvs     lf0cc_00
          sei     
          ora     #$40
          and     #$cf
          sta     $24c1
lf0cc_00:
          bpl     lf0d6_00
          stz     $24bf
          stz     $24c0
          plp     
          rts     
lf0d6_00:
          jsr     gx_vdc_disable_display
          lda     $24c2
          lsr     A
          sta     $24bf
          sta     $24c0
          plp     
          rts     
gx_vdc_set_yres:
          bit     #$01
          beq     @l0
          inc     A
@l0:
          sta     $24c2
          stz     $24c3
          eor     #$ff
          inc     A
          lsr     A
          sta     $24c4
          stz     $24c5
          adc     #$08
          sta     $24c7
          lda     #$02
          sta     $24c6
          lda     #$0d
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c2
          sta     video_data_l
          lda     $24c3
          sta     video_data_h
          lda     #$0c
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          sta     video_data_h
          lda     #$0e
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c4
          sta     video_data_l
          lda     $24c5
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          rts     
          cla     
          jsr     gx_vdc_set_ctrl_hi
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          st1     #$00
          st2     #$00
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          ldx     #$08
          ldy     #$00
lf15f_00:
          st1     #$f0
          st2     #$00
          dey     
          bne     lf15f_00
          dex     
          bne     lf15f_00
          rts     
gx_vdc_enable_interrupts:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$0c
          sta     <vdc_control
          sta     video_data_l
          stz     irq_disable
          rts     
          lda     #$03
          sta     irq_disable
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          and     #$f3
          sta     <vdc_control
          sta     video_data_l
          rts     
          cly     
lf195_00:
          lda     [$04], Y
          cmp     #$ff
          beq     lf1b0_00
          phy     
          jsr     lf1db_00
          ply     
          iny     
          clc     
          lda     <$00
          adc     #$20
          sta     <$00
          lda     <$01
          adc     #$00
          sta     <$01
          bra     lf195_00
lf1b0_00:
          rts     
          cly     
          ldx     <$06
          beq     lf1c4_00
lf1b6_00:
          lda     [$00], Y
          sta     [$02], Y
          iny     
          bne     lf1c1_00
          inc     <$01
          inc     <$03
lf1c1_00:
          dex     
          bne     lf1b6_00
lf1c4_00:
          lda     <$07
          beq     lf1cc_00
          dec     <$07
          bra     lf1b6_00
lf1cc_00:
          rts     
lf1cd_00:
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          rts     
lf1db_00:
          sta     <$02
          lda     #$01
          sta     <$03
          lda     $2303
          clx     
lf1e5_00:
          lsr     A
          bcc     lf208_00
          asl     <$03
          inx     
          cpx     #$04
          bcc     lf1e5_00
          php     
          sei     
          lda     <$02
          bsr     lf1cd_00
          cly     
lf1f6_00:
          lda     [$00], Y
          sta     color_data_l
          iny     
          lda     [$00], Y
          sta     color_data_h
          iny     
          cpy     #$20
          bne     lf1f6_00
          plp     
          rts     
lf208_00:
          lda     <$02
          sta     $2314, X
          txa     
          asl     A
          asl     A
          asl     A
          asl     A
          asl     A
          tax     
          cly     
lf215_00:
          lda     [$00], Y
          sta     $2318, X
          inx     
          iny     
          cpy     #$20
          bne     lf215_00
          php     
          sei     
          lda     #$10
          tsb     <$11
          lda     <$03
          tsb     $2303
          plp     
          rts     
          lda     #$01
          sta     <$04
          lda     $2302
          clx     
lf235_00:
          lsr     A
          bcc     lf240_00
          asl     <$04
          inx     
          cpx     #$04
          bcc     lf235_00
          rts     
lf240_00:
          lda     <$02
          sta     $2304, X
          lda     <$03
          sta     $2308, X
          lda     <$00
          sta     $230c, X
          lda     <$01
          sta     $2310, X
          php     
          sei     
          lda     #$20
          tsb     <$11
          lda     <$04
          tsb     $2302
          plp     
          rts     
lf261_00:
          lda     $2304, X
          sta     color_reg_l
          lda     $2308, X
          sta     color_reg_h
          lda     $230c, X
          sta     color_data_l
          lda     $2310, X
          sta     color_data_h
          rts     
gx_unknown_f27a:
          ldx     #$ff
          lda     $2302
lf27f_00:
          beq     lf28b_00
          inx     
          lsr     A
          bcc     lf27f_00
          tay     
          bsr     lf261_00
          tya     
          bra     lf27f_00
lf28b_00:
          lda     #$20
          trb     <$11
          stz     $2302
          ldx     #$ff
          lda     $2303
lf297_00:
          beq     lf2df_00
          inx     
          lsr     A
          bcc     lf297_00
          pha     
          phx     
          lda     $2314, X
          jsr     lf1cd_00
          txa     
          asl     A
          tax     
          jmp     [$f2ab, X]
          tst     #$f2, $f2be, X
          cmp     #$f2
          csh     
          sbc     [$e3]
          clc     
          st2     #$04
          tsb     <$20
          brk     
          plx     
          pla     
          bra     lf297_00
          tia     $2338, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
          tia     $2358, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
          tia     $2378, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
lf2df_00:
          lda     #$10
          trb     <$11
          stz     $2303
          jsr     lf3c4_00
          bbs0    <$11, lf2ed_00
          rts     
lf2ed_00:
          bbs1    <$11, lf334_00
          ldy     $239d
          clc     
          ldx     #$03
lf2f6_00:
          lda     $245f, Y
          adc     $239f, Y
          sta     $245f, Y
          lda     $23ff, Y
          adc     #$00
          sta     $23ff, Y
          lda     $247f, Y
          adc     $23bf, Y
          sta     $247f, Y
          lda     $241f, Y
          adc     #$00
          sta     $241f, Y
          lda     $249f, Y
          adc     $23df, Y
          sta     $249f, Y
          lda     $243f, Y
          adc     #$00
          sta     $243f, Y
          dey     
          dex     
          bpl     lf2f6_00
          tya     
          sty     $239d
          bmi     lf378_00
          rts     
lf334_00:
          ldy     $239d
          sec     
          ldx     #$03
lf33a_00:
          lda     $245f, Y
          sbc     $239f, Y
          sta     $245f, Y
          lda     $23ff, Y
          sbc     #$00
          sta     $23ff, Y
          lda     $247f, Y
          sbc     $23bf, Y
          sta     $247f, Y
          lda     $241f, Y
          sbc     #$00
          sta     $241f, Y
          lda     $249f, Y
          sbc     $23df, Y
          sta     $249f, Y
          lda     $243f, Y
          sbc     #$00
          sta     $243f, Y
          dey     
          dex     
          bpl     lf33a_00
          tya     
          sty     $239d
          bmi     lf378_00
          rts     
lf378_00:
          lda     #$0f
          sta     $239d
          jsr     lf3a2_00
          lda     $239b
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          tia     $22e2, color_data_l, $0020
          dec     $2399
          beq     lf39d_00
          rts     
lf39d_00:
          lda     #$03
          trb     <$11
          rts     
lf3a2_00:
          clx     
          cly     
lf3a4_00:
          lda     $241f, Y
          asl     A
          asl     A
          asl     A
          ora     $23ff, Y
          asl     A
          asl     A
          asl     A
          ora     $243f, Y
          sta     $22e2, X
          lda     #$00
          rol     A
          sta     $22e3, X
          inx     
          inx     
          iny     
          cpy     #$10
          bne     lf3a4_00
          rts     
lf3c4_00:
          bbs2    <$11, lf3c8_00
          rts     
lf3c8_00:
          bbs3    <$11, lf40f_00
          ldy     $239e
          clc     
          ldx     #$03
lf3d1_00:
          lda     $246f, Y
          adc     $23af, Y
          sta     $246f, Y
          lda     $240f, Y
          adc     #$00
          sta     $240f, Y
          lda     $248f, Y
          adc     $23cf, Y
          sta     $248f, Y
          lda     $242f, Y
          adc     #$00
          sta     $242f, Y
          lda     $24af, Y
          adc     $23ef, Y
          sta     $24af, Y
          lda     $244f, Y
          adc     #$00
          sta     $244f, Y
          dey     
          dex     
          bpl     lf3d1_00
          tya     
          sty     $239e
          bmi     lf453_00
          rts     
lf40f_00:
          ldy     $239e
          sec     
          ldx     #$03
lf415_00:
          lda     $246f, Y
          sbc     $23af, Y
          sta     $246f, Y
          lda     $240f, Y
          sbc     #$00
          sta     $240f, Y
          lda     $248f, Y
          sbc     $23cf, Y
          sta     $248f, Y
          lda     $242f, Y
          sbc     #$00
          sta     $242f, Y
          lda     $24af, Y
          sbc     $23ef, Y
          sta     $24af, Y
          lda     $244f, Y
          sbc     #$00
          sta     $244f, Y
          dey     
          dex     
          bpl     lf415_00
          tya     
          sty     $239e
          bmi     lf453_00
          rts     
lf453_00:
          lda     #$0f
          sta     $239e
          jsr     lf47d_00
          lda     $239c
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          tia     $22e2, color_data_l, $0020
          dec     $239a
          beq     lf478_00
          rts     
lf478_00:
          lda     #$0c
          trb     <$11
          rts     
lf47d_00:
          clx     
          cly     
lf47f_00:
          lda     $242f, Y
          asl     A
          asl     A
          asl     A
          ora     $240f, Y
          asl     A
          asl     A
          asl     A
          ora     $244f, Y
          sta     $22e2, X
          lda     #$00
          rol     A
          sta     $22e3, X
          inx     
          inx     
          iny     
          cpy     #$10
          bne     lf47f_00
          rts     
          lda     #$0f
          trb     <$11
          rts     
          pha     
          lda     #$03
          trb     <$11
          pla     
          sta     $239b
          stz     $2398
          jsr     lf537_00
          ldx     #$0f
          stx     $239d
lf4b8_00:
          stz     $241f, X
          stz     $243f, X
          stz     $23ff, X
          dex     
          bpl     lf4b8_00
          lda     #$10
          sta     $2399
          lda     #$01
          tsb     <$11
          rts     
          pha     
          lda     #$0c
          trb     <$11
          pla     
          sta     $239c
          lda     #$10
          sta     $2398
          jsr     lf537_00
          ldx     #$0f
          stx     $239e
lf4e4_00:
          stz     $242f, X
          stz     $244f, X
          stz     $240f, X
          dex     
          bpl     lf4e4_00
          lda     #$10
          sta     $239a
          lda     #$04
          tsb     <$11
          rts     
          pha     
          lda     #$03
          trb     <$11
          pla     
          sta     $239b
          stz     $2398
          jsr     lf537_00
          ldy     #$0f
          sty     $239d
          lda     #$10
          sta     $2399
          lda     #$03
          tsb     <$11
          rts     
          pha     
          lda     #$0c
          trb     <$11
          pla     
          sta     $239c
          lda     #$10
          sta     $2398
          jsr     lf537_00
          ldy     #$0f
          sty     $239e
          iny     
          sty     $239a
          lda     #$0c
          tsb     <$11
          rts     
lf537_00:
          ldy     #$1f
lf539_00:
          lda     [$00], Y
          sta     $22e2, Y
          dey     
          bpl     lf539_00
          cly     
          lda     $2398
          and     #$10
          tax     
          clc     
          adc     #$10
          sta     $2398
lf54e_00:
          clc     
          lda     $22e2, Y
          and     #$07
          sta     $243f, X
          asl     A
          asl     A
          asl     A
          asl     A
          sta     $23df, X
          lda     $22e2, Y
          and     #$38
          asl     A
          sta     $239f, X
          lsr     A
          lsr     A
          lsr     A
          lsr     A
          sta     $23ff, X
          lda     $22e3, Y
          lsr     A
          lda     $22e2, Y
          ror     A
          and     #$e0
          lsr     A
          sta     $23bf, X
          clc     
          lsr     A
          lsr     A
          lsr     A
          lsr     A
          sta     $241f, X
          stz     $247f, X
          stz     $249f, X
          stz     $245f, X
          iny     
          iny     
          inx     
          cpx     $2398
          bne     lf54e_00
          rts     
lf596_00:
          ora     #$80
          sta     video_data_l
          st2     #$f0
          rts     
          cly     
lf59f_00:
          lda     [$00], Y
          beq     lf5a9_00
          jsr     lf596_00
          iny     
          bpl     lf59f_00
lf5a9_00:
          rts     
          pha     
          lsr     A
          lsr     A
          lsr     A
          lsr     A
          tay     
          lda     $f5ea, Y
          jsr     lf596_00
          pla     
          and     #$0f
          tay     
          lda     $f5ea, Y
          jmp     lf596_00
          cly     
lf5c1_00:
          cmp     #$64
          bcc     lf5ca_00
          iny     
          sbc     #$64
          bra     lf5c1_00
lf5ca_00:
          pha     
          lda     $f5ea, Y
          jsr     lf596_00
          pla     
          cly     
lf5d3_00:
          cmp     #$0a
          bcc     lf5dc_00
          iny     
          sbc     #$0a
          bra     lf5d3_00
lf5dc_00:
          pha     
          lda     $f5ea, Y
          jsr     lf596_00
          ply     
          lda     $f5ea, Y
          jmp     lf596_00
          bmi     lf61d_00
          and     [$33]
          bit     <$35, X
          rol     <$37
          sec     
          and     $4241, Y
          tma     #$02
          eor     <$46
          stz     <$00
          lsr     A
          ror     <$00
          lsr     A
          ror     <$00
          sta     <$01
          txa     
          ora     <$00
          sta     <$00
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          lda     <$00
          sta     video_data_l
          lda     <$01
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          rts     
          lda     [$00]
          sta     <$06
          ldy     #$01
          lda     [$00], Y
          sta     <$08
          clc     
          lda     <$00
          adc     #$02
          sta     <$00
          lda     <$01
          adc     #$00
          sta     <$01
lf639_00:
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          lda     <$02
          sta     video_data_l
          lda     <$03
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          ldx     <$06
          cly     
lf654_00:
          lda     [$00], Y
          sta     video_data_l
          iny     
          lda     [$00], Y
          sta     video_data_h
          iny     
          dex     
          bne     lf654_00
          dec     <$08
          bne     lf668_00
          rts     
lf668_00:
          clc     
          tya     
          adc     <$00
          sta     <$00
          cla     
          adc     <$01
          sta     <$01
          clc     
          lda     <$02
          adc     #$40
          sta     <$02
          lda     <$03
          adc     #$00
          sta     <$03
          jmp     lf639_00
          cly     
          lda     <$07
          bpl     lf696_00
          lda     <$06
          eor     #$ff
          sta     <$06
          lda     <$07
          eor     #$ff
          sta     <$07
          ldy     #$08
lf696_00:
          lda     <$09
          bpl     lf6aa_00
          lda     <$08
          eor     #$ff
          sta     <$08
          lda     <$09
          eor     #$ff
          sta     <$09
          tya     
          ora     #$10
          tay     
lf6aa_00:
          jmp     lf6f2_00
          inc     <$07
          inc     <$09
          inc     <$01
          inc     <$03
          cly     
          sec     
          lda     <$06
          sbc     <$00
          sta     <$06
          lda     <$07
          sbc     <$01
          sta     <$07
          bcs     lf6d3_00
          lda     <$06
          eor     #$ff
          sta     <$06
          lda     <$07
          eor     #$ff
          sta     <$07
          ldy     #$08
lf6d3_00:
          sec     
          lda     <$08
          sbc     <$02
          sta     <$08
          lda     <$09
          sbc     <$03
          sta     <$09
          bcs     lf6f2_00
          lda     <$08
          eor     #$ff
          sta     <$08
          lda     <$09
          eor     #$ff
          sta     <$09
          tya     
          ora     #$10
          tay     
lf6f2_00:
          lda     <$06
          asl     A
          sta     <$00
          sta     $24c8
          sta     $24ca
          lda     <$07
          rol     A
          sta     <$01
          sta     $24c9
          sta     $24cb
          clc     
          lda     $24c8
          adc     <$06
          sta     $24c8
          lda     $24c9
          adc     <$07
          sta     $24c9
          clc     
          lda     $24ca
          adc     $24c8
          sta     $24ca
          lda     $24cb
          adc     $24c9
          sta     $24cb
          lda     <$08
          asl     A
          sta     <$02
          sta     $24cc
          sta     $24ce
          lda     <$09
          rol     A
          sta     <$03
          sta     $24cd
          sta     $24cf
          clc     
          lda     $24cc
          adc     <$08
          sta     $24cc
          lda     $24cd
          adc     <$09
          sta     $24cd
          clc     
          lda     $24ce
          adc     $24cc
          sta     $24ce
          lda     $24cf
          adc     $24cd
          sta     $24cf
          sec     
          lda     <$06
          sbc     $24ce
          lda     <$07
          sbc     $24cf
          bcs     lf79e_00
          iny     
          sec     
          lda     <$00
          sbc     $24cc
          lda     <$01
          sbc     $24cd
          bcs     lf79e_00
          iny     
          sec     
          lda     $24c8
          sbc     <$02
          lda     $24c9
          sbc     <$03
          bcs     lf79e_00
          iny     
          sec     
          lda     $24ca
          sbc     <$08
          lda     $24cb
          sbc     <$09
          bcs     lf79e_00
          iny     
lf79e_00:
          lda     $f7a7, Y
          tay     
          eor     #$ff
          and     #$0f
          rts     
          tsb     <$05
          asl     <$07
          php     
          brk     
          brk     
          brk     
          tsb     $0a0b
          ora     #$08
          brk     
          brk     
          brk     
          tsb     <$03
          sxy     
          ora     [$00, X]
          brk     
          brk     
          brk     
          tsb     $0e0d
          bbr0    <$00, lf7c5_00
lf7c5_00:
          brk     
          brk     
          sec     
          lda     <$06
          sbc     <$00
          sta     <$06
          lda     <$07
          sbc     <$01
          sta     <$07
          sta     <$04
          bpl     lf7e3_00
          cla     
          sec     
          sbc     <$06
          sta     <$06
          cla     
          sbc     <$07
          sta     <$07
lf7e3_00:
          sec     
          lda     <$08
          sbc     <$02
          sta     <$08
          lda     <$09
          sbc     <$03
          sta     <$09
          sta     <$05
          bpl     lf7ff_00
          cla     
          sec     
          sbc     <$08
          sta     <$08
          cla     
          sbc     <$09
          sta     <$09
lf7ff_00:
          sec     
          lda     <$06
          sbc     <$08
          lda     <$07
          sbc     <$09
          bcs     lf81f_00
lf80a_00:
          sec     
          lda     <$08
          sbc     #$08
          lda     <$09
          sbc     #$00
          bcc     lf834_00
          lsr     <$07
          ror     <$06
          lsr     <$09
          ror     <$08
          bra     lf80a_00
lf81f_00:
          sec     
          lda     <$06
          sbc     #$08
          lda     <$07
          sbc     #$00
          bcc     lf834_00
          lsr     <$07
          ror     <$06
          lsr     <$09
          ror     <$08
          bra     lf81f_00
lf834_00:
          lda     <$08
          asl     A
          asl     A
          asl     A
          ora     <$06
          tay     
          lda     $f864, Y
          sta     <$00
          lda     <$04
          bmi     lf857_00
          lda     <$05
          bmi     lf84f_00
          lda     #$20
          clc     
          adc     <$00
          rts     
lf84f_00:
          lda     #$40
          sec     
          sbc     <$00
          and     #$3f
          rts     
lf857_00:
          lda     <$05
          bmi     lf861_00
          lda     #$20
          sec     
          sbc     <$00
          rts     
lf861_00:
          lda     <$00
          rts     
          bpl     lf876_00
          bpl     lf878_00
          bpl     lf87a_00
          bpl     lf87c_00
          brk     
          php     
          .db     $0b
          tsb     $0d0d
          asl     $000e
          tsb     <$08
          asl     A
lf878_00:
          .db     $0b
          tsb     $0d0c
lf87c_00:
          brk     
          st0     #$05
          php     
          ora     #$0a
          .db     $0b
          .db     $0b
          brk     
          sxy     
          tsb     <$06
          php     
          ora     #$0a
          asl     A
          brk     
          sxy     
          tsb     <$05
          rmb0    <$08
          ora     #$0a
          brk     
          sxy     
          st0     #$05
          asl     <$07
          php     
          ora     #$00
          ora     [$03, X]
          tsb     <$05
          asl     <$07
          php     
gx_main:
          jsr     gx_cd_reset
          jsr     gx_update_scroll
          jsr     gx_unknown_ed03
          ldx     #$f9
          ldy     #$7c
          jsr     gx_unknown_e98c
          lda     #$00
          jsr     gx_display_init
          jsr     gx_vdc_disable_display
          cla     
          jsr     gx_vdc_set_ctrl_hi
          jsr     gx_vdc_clear_tiles
          jsr     gx_vdc_enable_interrupts
          cli     
          lda     $18c1
          cmp     #$aa
          bne     lf8eb_00
          lda     $18c2
          cmp     #$55
          bne     lf8eb_00
          lda     #$aa
          sta     $18c0
          lda     #$55
          sta     $18c0
          lda     #$68
          sta     $2204
          lda     #$20
          sta     $2205
          bra     lf8f5_00
lf8eb_00:
          lda     #$80
          sta     $2204
          lda     #$08
          sta     $2205
lf8f5_00:
          lda     #$01
          tam     #$06
          jsr     gx_load_gfx_data
lf8fc_00:
          jsr     gx_cd_reset
          jsr     gx_unknown_c07f
          jsr     gx_adpcm_reset
          cla     
          jsr     gx_write_cd_fade_timer
lf909_00:
          jsr     gx_cd_reset
lf90c_00:
          jsr     gx_unknown_e245
          bcc     lf918_00
          lda     #$1e
          jsr     gx_unknown_e9e4
          bra     lf90c_00
lf918_00:
          jsr     gx_unknown_e17f
          bne     lf96e_00
          lda     $2235
          sta     <$23
          lda     #$02
          sta     <$20
          lda     #$3c
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     gx_unknown_e1a0
          tst     #$04, $223f
          bne     lf93a_00
          jmp     lf96e_00
lf93a_00:
          jsr     gx_unknown_fe3c
          bpl     lf942_00
          jmp     lf96e_00
lf942_00:
          lda     #$78
          sta     <$00
          lda     #$f9
          sta     <$01
          lda     $2204
          sta     <$21
          jsr     gx_unknown_ff75
          cmp     #$ff
          beq     lf96e_00
          cmp     #$00
          bne     lf909_00
          jsr     gx_vdc_disable_display
          lda     $2204
          tam     #$03
          inc     A
          tam     #$04
          inc     A
          tam     #$05
          inc     A
          tam     #$06
          jmp     l6000_00
lf96e_00:
          lda     #$01
          tam     #$06
          jsr     gx_unknown_c053
          jmp     lf8fc_00

gx_update_scroll:
          stz     <$35
          stz     <$38
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          rts     

gx_unknown_eb00:
          lda     $24c0
          sta     <$39
          lda     $24bf
          sta     $24c0
          lda     #$20
          bit     $24c1
          bne     leb59_00
          bmi     leb34_00
          lda     <$39
          cmp     $24bf
          beq     leb1f_00
          lda     #$c0
          tsb     <vdc_control
leb1f_00:
          lda     $24c1
          and     #$0f
          eor     #$ff
          sec     
          adc     $24bf
          sta     $24bf
          bpl     leb6a_00
          stz     $24bf
          bra     leb52_00
leb34_00:
          lda     $24c1
          and     #$0f
          clc     
          adc     $24bf
          bcs     leb48_00
          sta     $24bf
          asl     A
          cmp     $24c2
          bcc     leb6a_00
leb48_00:
          lda     $24c2
          sta     $24bf
          lda     #$c0
          trb     <vdc_control
leb52_00:
          lda     #$20
          tsb     $24c1
          bra     leb6a_00
leb59_00:
          lda     #$10
          bit     $24c1
          bne     leb65_00
          tsb     $24c1
          bra     leb6a_00
leb65_00:
          lda     #$40
          trb     $24c1
leb6a_00:
          st0     #$08
          lda     <vdc_scroll_y
          clc     
          adc     <$39
          sta     video_data_l
          lda     <vdc_scroll_y+1
          bcc     leb79_00
          inc     A
leb79_00:
          sta     video_data_h
          st0     #$0c
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          clc     
          adc     <$39
          sta     video_data_h
          st0     #$0d
          lda     $24c2
          lsr     A
          sbc     <$39
          asl     A
          sta     video_data_l
          st0     #$0e
          lda     $24c4
          clc     
          adc     <$39
          sta     video_data_l
          rts     

gx_irq_1:
          bbr0    <irq_m, @gx_irq1
          jmp     [irq1_user_hook]
@gx_irq1:
          pha     
          phx     
          phy     
          lda     video_reg_l
          sta     <vdc_status
          bit     #$08
          beq     @check_spr_or
          lda     $204a
          and     #$01
          clc     
          adc     #$08
          st0     #$13
          st1     #$00
          sta     video_data_h
          lda     <vdc_status
@check_spr_or:
          bit     #$02
          beq     @check_vsync
          inc     $2049
          lda     <vdc_control
          and     #$fd
          sta     <vdc_control
          st0     #$05
          sta     video_data_l
          lda     <vdc_status
@check_vsync:
          bit     #$20
          bne     @vsync
          jmp     lec5a_00
@vsync:
          lda     <$35
          sta     <$37
          bne     lec24_00
          st0     #$06
          st1     #$00
          st2     #$00
          st0     #$07
          lda     <vdc_scroll_x
          sta     video_data_l
          lda     <vdc_scroll_x+1
          sta     video_data_h
          bit     $24c1
          bvc     @scroll_y
          jsr     gx_unknown_eb00
          bra     @update_scroll
@scroll_y:
          st0     #$08
          lda     <vdc_scroll_y
          sta     video_data_l
          lda     <vdc_scroll_y+1
          sta     video_data_h
@update_scroll:
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          jmp     lec2d_00
lec24_00:
          lda     <$34
          sta     <$36
          stz     <$38
          jsr     gx_unknown_ec6f
lec2d_00:
          st0     #$05
          lda     <vdc_control
          ora     #$02
          sta     video_data_l
          inc     <$33
          lda     <vdc_reg
          sta     video_reg_l
          jsr     gx_unknown_f27a
          jsr     gx_unknown_ef41
          ldx     $22bd
          lda     $228b, X
          bit     #$80
          bne     lec6b_00
          lda     $22be
          bit     #$01
          bne     lec6b_00
          ply     
          plx     
          pla     
          jmp     gx_unknown_ea19
lec5a_00:
          lda     <$37
          beq     lec66_00
          ldx     #$0f
lec60_00:
          dex     
          bpl     lec60_00
          jsr     gx_unknown_ec6f
lec66_00:
          lda     <vdc_reg
          sta     video_reg_l
lec6b_00:
          ply     
          plx     
          pla     
          rti     

gx_unknown_ec6f:
          ldy     <$38
          lda     [$36], Y
          bmi     lec90_00
          beq     lece1_00
          dec     A
          beq     leccf_00
          dec     A
          beq     lecbd_00
          dec     A
          beq     lec91_00
          iny     
          lda     <vdc_control
          and     [$36], Y
          iny     
          ora     [$36], Y
          st0     #$05
          sta     video_data_l
          jmp     lece1_00
lec90_00:
          rts     
lec91_00:
          iny     
          st0     #$07
          lda     <vdc_scroll_x
          sta     video_data_l
          lda     <vdc_scroll_x+1
          sta     video_data_h
          st0     #$08
          lda     <vdc_scroll_y
          sta     video_data_l
          lda     <vdc_scroll_y+1
          sta     video_data_h
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          jmp     lecf2_00
lecbd_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$08
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          jmp     lecf2_00
leccf_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$07
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          jmp     lecf2_00
lece1_00:
          iny     
          lda     [$36], Y
          iny     
          st0     #$07
          sta     video_data_l
          lda     [$36], Y
          sta     video_data_h
          jmp     lecbd_00
lecf2_00:
          lda     [$36], Y
          iny     
          st0     #$06
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          sty     <$38
          rts     

gx_unknown_ed03:
          stz     $22c6
          rts     

	.code
	.bank $000
	.org $ed15
; $3a   : data address LSB
; $3b   : data address MSB
; $22c7 : data bank
; $22c1 : VRAM offset LSB
; $22c2 : VRAM offset MSB
gx_vdc_load_vram:
          lda     <$3b                      ; adjust data address and bank
led17_00:
          cmp     #$60
          bcc     led22_00
          sbc     #$20
          inc     $22c7
          bra     led17_00
led22_00:
          sta     <$3b
          stz     $22c0
          lda     #$05                      ; VDC control register
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7                      ; set auto increment to 1
          sta     <vdc_control+1            ; there may be an issue here
          sta     video_data_h              ; the previous value of video_data_l will be re-used
          lda     #$00                      ; VRAM write pointer
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          sta     video_data_l
          lda     $22c2
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l               ; VRAM data register
          lda     $22c1
          asl     A
          sta     $22c3
          lda     $22c2
          rol     A
          sta     $22c4                     ; 22c3.w = 22c1.w << 1
          tma     #$02                      ; save mpr 2
          sta     $22c8
          tma     #$03                      ; save mpr 3
          sta     $22c9
          lda     $22c7                     ; map data bank
          tam     #$02
          inc     A
          tam     #$03
          lda     [$3a]                     ; 
          sta     $22c6
          inc     <$3a                      ; next data byte
          bne     led7c_00
          inc     <$3b
led7c_00:
          clx     
          bra     ledcb_00
          lda     $22c6
          bne     led85_00
          rts     
led85_00:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7
          sta     <vdc_control+1
          sta     video_data_h
          lda     #$00
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          sta     video_data_l
          lda     $22c2
          sta     video_data_h
          lda     #$02
          sta     <vdc_reg
          sta     video_reg_l
          tma     #$02
          sta     $22c8
          tma     #$03
          sta     $22c9
          lda     $22c7
          tam     #$02
          inc     A
          tam     #$03
          ldx     $22c0
          beq     ledcb_00
          lda     <$3f
          sta     video_data_l
ledcb_00:
          lda     <$3b
          cmp     #$60
          bcc     leddc_00
          sbc     #$20
          sta     <$3b
          tma     #$03
          tam     #$02
          inc     A
          tam     #$03
leddc_00:
          lda     [$3a]
          cmp     #$ff
          beq     leded_00
          bit     #$80
          beq     lee1e_00
          bit     #$40
          beq     lee51_00
          jmp     gx_vdc_write
leded_00:
          dec     $22c6
          lda     $22c4
          lsr     A
          sta     $22c2
          lda     $22c3
          ror     A
          sta     $22c1
          stx     $22c0
          clc     
          lda     <$3a
          adc     #$01
          sta     <$3a
          lda     <$3b
          adc     #$00
          sta     <$3b
          tma     #$02
          sta     $22c7
          lda     $22c8                     ; restore mpr 2 and 3
          tam     #$02
          lda     $22c9
          tam     #$03
          rts     

	.code
	.bank $000
	.org $eec7
gx_vdc_write:
          and     #$3f
          sta     <$3e
          asl     A
          adc     $22c3
          sta     $22c3
          bcc     @loop
          inc     $22c4
@loop:
          ldy     #$01
          lda     [$3a], Y
          sta     video_data_l, X
          txa     
          eor     #$01
          tax     
          iny     
          lda     [$3a], Y
          sta     video_data_l, X
          sax     
          eor     #$01
          sax     
          dec     <$3e
          bne     @loop
          sta     <$3f
          clc     
          lda     <$3a
          adc     #$03
          sta     <$3a
          lda     <$3b
          adc     #$00
          sta     <$3b
          jmp     ledcb_00

	.code
	.bank $000
	.org $ef41
gx_unknown_ef41:
          cly     
          lda     #$01
          sta     joyport
          lda     #$03
          sta     joyport
lef4c_00:
          lda     #$01
          sta     joyport
          pha     
          pla     
          nop     
          lda     $22d3, Y
          sta     $22ce, Y
          lda     joyport
          pha     
          and     #$0f
          eor     #$0f
          tax     
          lda     lefb9_00, X
          stz     joyport
          pla     
          asl     A
          asl     A
          asl     A
          asl     A
          sta     $22d3, Y
          lda     joyport
          and     #$0f
          ora     $22d3, Y
          eor     #$ff
          sta     $22d3, Y
          eor     $22ce, Y
          pha     
          and     $22d3, Y
          sta     $22d8, Y
          pla     
          and     $22ce, Y
          sta     $22dd, Y
          iny     
          cpy     #$05
          bcc     lef4c_00
          cly     
lef95_00:
          lda     $22cd
          and     $efb4, Y
          beq     lefae_00
          lda     $22d8, Y
          cmp     #$04
          bne     lefae_00
          lda     $22d3, Y
          cmp     #$0c
          bne     lefae_00
          jmp     lead1_00
lefae_00:
          iny     
          cpy     #$05
          bcc     lef95_00
          rts     

	.code
	.bank $000
	.org $efc9
gx_display_init:
          stz     <gx_scroll_x
lefcb_00:
          stz     <gx_scroll_x+1
          stz     <gx_scroll_y
          stz     <gx_scroll_y+1
          sta     <$42
          lsr     A
          lsr     A
          lsr     A
          sta     <$43
          stz     <$11
          stz     $2303
          stz     $2302
          jsr     gx_vce_init
          jsr     gx_vdc_init
          stz     $24bf
          stz     $24c0
          rts     

gx_vdc_init:
          lda     gx_vdc_init_table+1
          sta     <vdc_control
          lda     gx_vdc_init_table+2
          sta     <vdc_control+1
          lda     #low(gx_vdc_init_table)
          sta     <$00
          lda     #high(gx_vdc_init_table)
          sta     <$01
          php     
          sei     
          ldy     #$00
@vdc_set_reg:
          lda     [$00], Y
          iny     
          sta     video_reg_l
          lda     [$00], Y
          iny     
          sta     video_data_l
          lda     [$00], Y
          iny     
          sta     video_data_h
          cpy     #$1b
          bne     @vdc_set_reg
          lda     <$42
          beq     @skip
@vdc_xres_341:
          st0     #$0a                  ; set horizontal resolution to 341px
          st1     #$02                  ; this will work if vce dot clock is set to 7MHz
          st2     #$05
          st0     #$0b
          st1     #$27
          st2     #$04
@skip:
          lda     #$e8
          jsr     gx_vdc_set_yres
          plp     
          rts     

gx_vdc_init_table:
          .db $05,$8e,$03
          .db $06,$00,$00
          .db $07,$00,$00
          .db $08,$00,$00
          .db $09,$40,$00               ; BAT size: 32x64
          .db $0a,$02,$02               ; horizontal resolution: 256px
          .db $0b,$1f,$04
          .db $0f,$01,$00
          .db $13,$00,$08

gx_vce_init:
          lda     <$42
          bne     @vce_next_mode
          lda     #$04                  ; blur edges + 5MHz dot clock
          bra     @vce_clear
@vce_next_mode:
          lda     #$05                  ; blur edges + 7MHz dot clock
@vce_clear:
          sta     color_ctrl
          stz     color_reg_l           ; clear all palette colors
          stz     color_reg_h           ; well... there's only 512 color entries
          ldx     #$04                  ; but this loops set 4*256=1024 colors to 0.
          cly     
@loop:
          stz     color_data_l
          stz     color_data_h
          dey     
          bne     @loop
          dex     
          bne     @loop
          rts     

gx_vdc_enable_display:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$c0
          sta     <vdc_control
          sta     video_data_l
          rts     

gx_vdc_disable_display:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          and     #$3f
          sta     <vdc_control
          sta     video_data_l
          rts     

gx_vdc_set_ctrl_hi:
          tax     
          lda     #$05                      ; VDC control register
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7                      ; Clear out r/w address auto increment
          ora     gx_vdc_vram_auto_inc, X   ; and fetch it from a table
          sta     <vdc_control+1
          sta     video_data_h
          rts     

gx_vdc_vram_auto_inc:
          .db $00,$08,$10,$18

	.code
	.bank $000
	.org $f0e5
gx_vdc_set_yres:
          bit     #$01
          beq     @l0
          inc     A
@l0:
          sta     $24c2
          stz     $24c3
          eor     #$ff
          inc     A
          lsr     A
          sta     $24c4
          stz     $24c5
          adc     #$08
          sta     $24c7
          lda     #$02
          sta     $24c6
          lda     #$0d                      ; Vertical Display Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c2
          sta     video_data_l
          lda     $24c3
          sta     video_data_h
          lda     #$0c                      ; Vertical Synchro Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          sta     video_data_h
          lda     #$0e                      ; Vertical Display End Position Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c4
          sta     video_data_l
          lda     $24c5
          sta     video_data_h
          lda     #$02                      ; VRAM data register
          sta     <vdc_reg
          sta     video_reg_l
          rts     

	.code
	.bank $000
	.org $f16a
gx_vdc_enable_interrupts:
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$0c
          sta     <vdc_control
          sta     video_data_l
          stz     irq_disable
          rts     

	.code
	.bank $000
	.org $f27a
gx_unknown_f27a:
          ldx     #$ff
          lda     $2302
lf27f_00:
          beq     lf28b_00
          inx     
          lsr     A
          bcc     lf27f_00
          tay     
          bsr     lf261_00
          tya     
          bra     lf27f_00
lf28b_00:
          lda     #$20
          trb     <$11
          stz     $2302
          ldx     #$ff
          lda     $2303
lf297_00:
          beq     lf2df_00
          inx     
          lsr     A
          bcc     lf297_00
          pha     
          phx     
          lda     $2314, X
          jsr     lf1cd_00
          txa     
          asl     A
          tax     
          jmp     [$f2ab, X]
          tst     #$f2, $f2be, X
          cmp     #$f2
          csh     
          sbc     [$e3]
          clc     
          st2     #$04
          tsb     <$20
          brk     
          plx     
          pla     
          bra     lf297_00
          tia     $2338, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
          tia     $2358, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
          tia     $2378, color_data_l, $0020
          plx     
          pla     
          bra     lf297_00
lf2df_00:
          lda     #$10
          trb     <$11
          stz     $2303
          jsr     lf3c4_00
          bbs0    <$11, lf2ed_00
          rts     
lf2ed_00:
          bbs1    <$11, lf334_00
          ldy     $239d
          clc     
          ldx     #$03
lf2f6_00:
          lda     $245f, Y
          adc     $239f, Y
          sta     $245f, Y
          lda     $23ff, Y
          adc     #$00
          sta     $23ff, Y
          lda     $247f, Y
          adc     $23bf, Y
          sta     $247f, Y
          lda     $241f, Y
          adc     #$00
          sta     $241f, Y
          lda     $249f, Y
          adc     $23df, Y
          sta     $249f, Y
          lda     $243f, Y
          adc     #$00
          sta     $243f, Y
          dey     
          dex     
          bpl     lf2f6_00
          tya     
          sty     $239d
          bmi     lf378_00
          rts     
lf334_00:
          ldy     $239d
          sec     
          ldx     #$03
lf33a_00:
          lda     $245f, Y
          sbc     $239f, Y
          sta     $245f, Y
          lda     $23ff, Y
          sbc     #$00
          sta     $23ff, Y
          lda     $247f, Y
          sbc     $23bf, Y
          sta     $247f, Y
          lda     $241f, Y
          sbc     #$00
          sta     $241f, Y
          lda     $249f, Y
          sbc     $23df, Y
          sta     $249f, Y
          lda     $243f, Y
          sbc     #$00
          sta     $243f, Y
          dey     
          dex     
          bpl     lf33a_00
          tya     
          sty     $239d
          bmi     lf378_00
          rts     
lf378_00:
          lda     #$0f
          sta     $239d
          jsr     lf3a2_00
          lda     $239b
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          tia     $22e2, color_data_l, $0020
          dec     $2399
          beq     lf39d_00
          rts     
lf39d_00:
          lda     #$03
          trb     <$11
          rts     

	.code
	.bank $000
	.org $f8a4
gx_main:
          jsr     gx_cd_reset
          jsr     gx_update_scroll
          jsr     gx_unknown_ed03
          ldx     #$f9
          ldy     #$7c
          jsr     gx_unknown_e98c
          lda     #$00
          jsr     gx_display_init
          jsr     gx_vdc_disable_display
          cla     
          jsr     gx_vdc_set_ctrl_hi
          jsr     gx_vdc_clear_tiles
          jsr     gx_vdc_enable_interrupts
          cli     
          lda     $18c1                         ; check if the game is running on a Super CDRom 2
          cmp     #$aa
          bne     lf8eb_00
          lda     $18c2
          cmp     #$55
          bne     lf8eb_00
          lda     #$aa                          ; this is a Super CDRom 2
          sta     $18c0
          lda     #$55
          sta     $18c0
          lda     #$68
          sta     $2204
          lda     #$20
          sta     $2205
          bra     lf8f5_00
lf8eb_00:
          lda     #$80                          ; this is not a Super CDRom 2
          sta     $2204
          lda     #$08
          sta     $2205
lf8f5_00:
          lda     #$01
          tam     #$06
          jsr     gx_load_gfx_data
lf8fc_00:
          jsr     gx_cd_reset
          jsr     gx_unknown_c07f
          jsr     gx_adpcm_reset
          cla     
          jsr     le179_00
lf909_00:
          jsr     gx_cd_reset
lf90c_00:
          jsr     gx_unknown_e245
          bcc     lf918_00
          lda     #$1e
          jsr     le9e4_00
          bra     lf90c_00
lf918_00:
          jsr     le17f_00
          bne     lf96e_00
          lda     $2235
          sta     <$23
          lda     #$02
          sta     <$20
          lda     #$3c
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     le1a0_00
          tst     #$04, $223f
          bne     lf93a_00
          jmp     lf96e_00
lf93a_00:
          jsr     lfe3c_00
          bpl     lf942_00
          jmp     lf96e_00
lf942_00:
          lda     #$78
          sta     <$00
          lda     #$f9
          sta     <$01
          lda     $2204
          sta     <$21
          jsr     lff75_00
          cmp     #$ff
          beq     lf96e_00
          cmp     #$00
          bne     lf909_00
          jsr     gx_vdc_disable_display
          lda     $2204
          tam     #$03
          inc     A
          tam     #$04
          inc     A
          tam     #$05
          inc     A
          tam     #$06
          jmp     l6000_00
lf96e_00:
          lda     #$01
          tam     #$06
          jsr     lc053_01
          jmp     lf8fc_00

	.code
	.bank $000
	.org $f989
gx_vdc_clear_tiles:
          stz     <$46
          stz     <$47
          stz     <$48
          stz     <$49
          stz     <$4a
          jmp     lf996_00
lf996_00:
          ldx     #$0f
          lda     #$ff
lf99a_00:
          sta     $2791, X
          dex     
          bpl     lf99a_00
          stz     <$4b
          stz     <$4c
          stz     <$4d
          lda     #$05
          sta     vdc_reg
          sta     video_reg_l
          lda     vdc_control+1
          and     #$e7
          sta     vdc_control+1
          sta     video_data_h
          lda     #$00                          ; VRAM write pointer
          sta     vdc_reg
          sta     video_reg_l
          st1     #$00                          ; set to past the BAT
          st2     #$08
          lda     #$02                          ; VRAM data register
          sta     vdc_reg
          sta     video_reg_l
          ldx     #$80                          
          ldx     #$00                          ; clear 256 tiles
@loop:
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          dex     
          bne     @loop
          rts     

          stz     <$06
          stz     <$07
          stz     <$08
          stz     <$09
lf9ed_00:
          cmp     #$10
          bcc     lf9f5_00
          lsr     A
          jmp     lf9ed_00
lf9f5_00:
          tax     
          lda     $2791, X
          bpl     lfa14_00
          lda     $2790
          cmp     #$40
          bcs     lfa61_00
          sta     $27a1, X
          sta     $2791, X
          tay     
          lda     #$ff
          sta     $2750, Y
          sta     $2710, Y
          jmp     lfa2b_00
lfa14_00:
          tay     
          lda     $2790
          cmp     #$40
          bcs     lfa61_00
          sta     $2710, Y
          sta     $2791, X
          say     
          sta     $2750, Y
          lda     #$ff
          sta     $2710, Y
lfa2b_00:
          lda     <$08
          sec     
          sbc     $24bf
          sta     $24d0, Y
          lda     <$09
          sbc     #$00
          sta     $2510, Y
          lda     <$06
          sta     $2550, Y
          lda     <$07
          sta     $2590, Y
          lda     <$46
          sta     $25d0, Y
          lda     <$47
          sta     $2610, Y
          lda     <$48
          sta     $2650, Y
          lda     <$00
          sta     $2690, Y
          lda     <$01
          sta     $26d0, Y
          inc     $2790
lfa61_00:
          rts     

	.code
	.bank $000
	.org $fe3c
gx_unknown_fe3c:
          lda     #$80
          sta     $2021
          tam     #$02
          inc     A
          tam     #$03
          inc     A
          tam     #$04
          inc     A
          tam     #$05
          stz     $2026
          stz     $2027
          lda     #$10
          sta     $2025
          lda     #$01
          sta     $2023
          jsr     le33a_00
          ldx     #$04
lfe61_00:
          lda     $ff2a, X
          cmp     $4001, X
          beq     lfe6c_00
          jmp     lff27_00
lfe6c_00:
          dex     
          bpl     lfe61_00
          tii     $409e, $2025, $0003
          tii     $40a6, $200a, $0004
          jsr     lfe11_00
          sta     $2023
          lda     #$80
          sta     $2021
          jsr     le33a_00
          lda     #$00
          sta     <$00
          lda     #$40
          sta     <$01
          lda     #$bd
          sta     <$02
          lda     #$27
          sta     <$03
lfe9b_00:
          lda     [$00]
          beq     lff10_00
          sta     <$06
          ldy     #$20
          lda     [$00], Y
          cmp     #$02
          bcc     lff02_00
          cmp     #$04
          bcc     lfeaf_00
          lda     #$04
lfeaf_00:
          sta     <$08
          clx     
          iny     
lfeb3_00:
          cla     
          cpx     <$08
          bcs     lfeba_00
          lda     [$00], Y
lfeba_00:
          sta     [$02]
          inc     <$02
          bne     lfec2_00
          inc     <$03
lfec2_00:
          iny     
          inx     
          cpx     #$04
          bne     lfeb3_00
          ldy     #$02
          lda     [$00], Y
          sta     [$02]
          inc     <$02
          bne     lfed4_00
          inc     <$03
lfed4_00:
          iny     
          lda     [$00], Y
          sta     [$02]
          inc     <$02
          bne     lfedf_00
          inc     <$03
lfedf_00:
          iny     
          lda     [$00], Y
          sta     [$02]
          inc     <$02
          bne     lfeea_00
          inc     <$03
lfeea_00:
          ldy     #$0a
          clx     
lfeed_00:
          lda     [$00], Y
          sta     <$0a, X
          iny     
          inx     
          cpx     #$04
          bne     lfeed_00
          jsr     lfe11_00
          sta     [$02]
          inc     <$02
          bne     lff02_00
          inc     <$03
lff02_00:
          lda     <$06
          clc     
          adc     <$00
          sta     <$00
          cla     
          adc     <$01
          sta     <$01
          bra     lfe9b_00
lff10_00:
          lda     #$ff
          sta     [$02]
          inc     <$02
          bne     lff1a_00
          inc     <$03
lff1a_00:
          lda     <$02
          sta     $2265
          lda     <$03
          sta     $2266
          lda     #$00
          rts     

	.code
	.bank $000
	.org $ff75
gx_unknown_ff75:
          jsr     lff2f_00
          bmi     lff7d_00
          jsr     le33a_00
lff7d_00:
          rts     

	.data
	.bank $000
	.org $fff6
irq_vectors:
          .dw $eaa3
          .dw $eba5
          .dw $ea9c
          .dw $ea9b
          .dw $eab3

	.code
	.bank $001
	.org $c000
gx_load_gfx_data:
          jsr     gx_vdc_disable_display
          stz     <gx_scroll_x
          stz     <gx_scroll_x+1
          stz     <gx_scroll_y
          stz     <gx_scroll_y+1
          stz     color_reg_l                           ; upload complete palette (all 512 colors)
          stz     color_reg_h
          tia     gx_pal_00, color_data_l, $0400
          cla     
          jsr     gx_vdc_set_ctrl_hi                    ; set vram r/w auto increment to 1
          lda     #$00                                  ; VRAM write pointer set to $0000 (BAT)
          sta     <vdc_reg
          sta     video_reg_l
          st1     #$00
          st2     #$00
          lda     #$02                                  ; copy the whole BAT
          sta     <vdc_reg
          sta     video_reg_l
          tia     gx_bat_00, video_data_l, $0800
          lda     #$01
          sta     $22c7
          lda     #$00
          sta     $22c1
          lda     #$10
          sta     $22c2
          lda     #$5f
          sta     <$3a
          lda     #$4d
          sta     <$3b
          jsr     gx_vdc_load_vram
          jsr     gx_vdc_enable_display
          rts     

gx_unknown_c053:
          jsr     gx_unknown_e9e2
          jsr     gx_unknown_f996
          jsr     gx_unknown_e9e2
          ldx     #$0a
lc05e_01:
          phx     
          jsr     gx_unknown_f996
          lda     #$0a
          jsr     gx_unknown_e9e4
          lda     #$36
          sta     <$00
          lda     #$c1
          sta     <$01
          jsr     lf9e5_00
          jsr     lfa62_00
          lda     #$14
          jsr     gx_unknown_e9e4
          plx     
          dex     
          bpl     lc05e_01
          rts     

gx_unknown_c07f:
          ldx     #$c0
          ldy     #$99
          jsr     gx_unknown_e98c
          pha     
lc087_01:
          jsr     gx_unknown_e9e2
          lda     $22d8
          and     #$08
          beq     lc087_01
          plx     
          jsr     gx_unknown_e9d7
          jsr     gx_unknown_f996
          rts     

