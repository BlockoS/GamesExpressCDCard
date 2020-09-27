	.code
	.bank $000
	.org $e000
gx_unknown_e000:
          jmp     gx_irq_reset
          jmp     gx_proc_reset
          jmp     gx_unknown_ea19
          jmp     gx_unknown_e9e4
          jmp     gx_unknown_e94f
          jmp     gx_unknown_e95b
          jmp     gx_proc_load
          jmp     gx_unknown_e9cc
          jmp     gx_unknown_e9d7
          jmp     gx_unknown_e9e2
          jmp     gx_read_joypad
          jmp     lfce4_00
          jmp     gx_vdc_load_vram
          jmp     gx_unknown_ed03
          jmp     gx_unknown_ed07
          jmp     gx_unknown_ed0b
          jmp     gx_unknown_ef12
          jmp     gx_unknown_ef02
          jmp     gx_cd_reset
          jmp     gx_unknown_e17f
          jmp     gx_unknown_e1a0
          jmp     gx_unknown_fe3c
          jmp     gx_unknown_ff75
          jmp     gx_write_cd_fade_timer
          jmp     gx_unknown_e28b
          jmp     gx_unknown_e33a
          jmp     gx_unknown_e6ea
          jmp     gx_unknown_e738
          jmp     gx_adpcm_reset
          jmp     gx_unknown_e7a8
          jmp     gx_unknown_e7e7
          jmp     gx_unknown_e817
          jmp     gx_unknown_e5cd
          jmp     gx_unknown_e28b
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     lfe11_00
          jmp     lff2f_00
          jmp     gx_vdc_clear_tiles
          jmp     lf9e5_00
          jmp     lf9ed_00
          jmp     lfa62_00
          jmp     gx_unknown_f996
          jmp     gx_display_init
          jmp     gx_vdc_enable_display
          jmp     gx_vdc_disable_display
          jmp     gx_unknown_f145
          jmp     gx_vdc_set_ctrl_hi
          jmp     gx_unknown_f194
          jmp     lf22d_00
          jmp     gx_unknown_f1db
          jmp     lf4a4_00
          jmp     lf4ce_00
          jmp     lf4fa_00
          jmp     lf518_00
          jmp     lf49f_00
          jmp     lf1b1_00
          jmp     gx_vdc_enable_interrupts
          jmp     gx_vdc_set_control_reg
          jmp     gx_vdc_set_yres
          jmp     gx_vdc_set_bat_size
          jmp     gx_unknown_f0c3
          jmp     lf596_00
          jmp     lf59e_00
          jmp     lf5aa_00
          jmp     lf5b7_00
          jmp     lf5c0_00
          jmp     lf5fa_00
          jmp     lf622_00
          jmp     lf6ad_00
          jmp     lf683_00
          jmp     lf7c7_00
          jmp     lfb5c_00
          jmp     lfb66_00
          jmp     lfbc3_00
          jmp     lfbf5_00
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset
          jmp     gx_irq_reset

gx_info_string:
          db "SYSTEM KERNEL REV 2reserv_tbl_0 1993/04/18",$0d,$0a
          db "Created by Hack Technical Group",$0d,$0a
          db "Special thanks to Ryo",$0d,$0a,$00,
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

;-------------------------------------------------------------------------------
; Reset CDROM
;-------------------------------------------------------------------------------
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

;-------------------------------------------------------------------------------
; Wait 7962 cycles.
; This should be enough for CDROM to be ready.
;-------------------------------------------------------------------------------
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
          lda     cd_status                 ; poll cd status while bit 6 is set
          and     #$40
          bne     le27e_00
          lda     #$80
          trb     cd_control
          rts     
gx_unknown_e28b:
          stz     $220f
le28e_00:
          lda     #$81                      ; try to send command prefix $81, $ff
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

gx_unknown_e33a:
          tii     $2020, $2207, $0008
          jsr     gx_unknown_e25c
          lda     #$08
          sta     $2210
          lda     <$27
          sta     $2211
          lda     <$26
          sta     $2212
          lda     <$25
          sta     $2213
          lda     <$23
          sta     $2214
          lda     <$20
          cmp     #$ff
          beq     le3b0_00
          tma     #$06
          pha     
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le393_00
le36d_00:
          lda     <$21
          tam     #$06
          lda     #$00
          sta     <$15
          lda     #$c0
          sta     <$16
          lda     #$00
          sta     <$17
          lda     #$20
          sta     <$18
          jsr     gx_adpcm_read_to_ram
          cmp     #$88
          bne     le393_00
          inc     <$21
          lda     <$23
          sec     
          sbc     #$04
          beq     le393_00
          bpl     le36d_00
le393_00:
          pla     
          tam     #$06
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le3ac_00
          jsr     gx_unknown_e532
          bcs     le3ac_00
          tii     $2207, $2020, $0008
          jmp     gx_unknown_e33a
le3ac_00:
          stz     $2246
          rts     
le3b0_00:
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le3ed_00
          cla     
          jsr     gx_vdc_set_ctrl_hi
          lda     #$01
          sta     $2246
          lda     #$00
          sta     vdc_reg
          sta     video_reg_l
          lda     <$21
          sta     video_data_l
          lda     <$22
          sta     video_data_h
          lda     #$02
          sta     vdc_reg
          sta     video_reg_l
le3da_00:
          lda     #$00
          sta     <$17
          lda     #$08
          sta     <$18
          jsr     gx_adpcm_read_to_vdc
          cmp     #$88
          bne     le3ed_00
          dec     <$23
          bne     le3da_00
le3ed_00:
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le3ac_00
          jsr     gx_unknown_e532
          bcs     le3ac_00
          tii     $2207, $2020, $0008
          jmp     gx_unknown_e33a
gx_negate:
          cla     
          sec     
          sbc     <$17
          sta     <$17
          cla     
          sbc     <$18
          sta     <$18
          rts     

;-------------------------------------------------------------------------------
; Read data from ADPCM? and store it to RAM.
; Parameters:
;   $2017-18 : the number of bytes to read.
;   $2015-16 : the memory address where the read data will be stored
;
; Return:
;   A : CD status
;   X : Remaining number of 256 bytes blocs in the current sector 
;-------------------------------------------------------------------------------
gx_adpcm_read_to_ram:
          jsr     gx_negate     ; negates the number of bytes to read
@start:                         
          lda     cd_status     ; wait until cdrom is ready
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     @ok           ; data can be read
          cmp     #$d8
          beq     @end          ; cd is unavailable
          jmp     @start
@ok:
          lda     <$15
          ora     <$16          ; is this some write overflow test?
          beq     @end
          ldx     #$02
@wait:                          ; wait ...
          nop     
          dex     
          bne     @wait
          cly     
          ldx     #$08          ; you can't read more than 8*256 bytes (a whole sector)
@loop:
          lda     adpcm_addr_l
          sta     [$15], Y
          inc     <$17          ; check if we read all the requested number of bytes
          bne     @next
          inc     <$18
          beq     @end
@next:
          iny     
          bne     @loop
          inc     <$16         ; we wrote 256 bytes, so we increase the MSB of the output pointer
          dex                  ; check if we read a whole sector
          bne     @loop
          bra     @start
@end:
          lda     cd_status
          and     #$f8
          sta     $222f
          rts     
; Same as gx_adpcm_read_to_ram but the read bytes are transfered to the VDC.
; Note that the VDC write register must have been set beforehand.
gx_adpcm_read_to_vdc:
          jsr     gx_negate
@start:
          lda     cd_status
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     @ok
          cmp     #$d8
          beq     @end
          jmp     @start
@ok:
          ldx     #$02
@wait:
          nop     
          dex     
          bne     @wait
          cly     
@loop:
          lda     adpcm_addr_l
          sta     video_data_l, Y
          say     
          inc     A
          and     #$01
          say     
          inc     <$17
          bne     @loop
          inc     <$18
          beq     @end
          bra     @loop
@end:
          lda     cd_status
          and     #$f8
          sta     $222f
          rts     
          cla     
          sec     
          sbc     <$17
          sta     <$17
          cla     
          sbc     <$18
          sta     <$18
le49a_00:
          lda     cd_status
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     le4ad_00
          cmp     #$d8
          beq     le4c4_00
          jmp     le49a_00
le4ad_00:
          cly     
          lda     cd_command
          sta     [$15], Y
          jsr     gx_unknown_e279
          inc     <$15
          bne     le4bc_00
          inc     <$16
le4bc_00:
          inc     <$17
          bne     le49a_00
          inc     <$18
          bne     le49a_00
le4c4_00:
          lda     cd_status
          and     #$b8
          sta     $222f
          rts     

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
gx_unknown_e5cd:
          tii     $2020, $2207, $0008
le5d4_00:
          jsr     gx_unknown_e25c
          lda     #$80
          sta     $2219
          lda     #$d8
          sta     $2210
          lda     <$25
          sta     $2212
          jsr     gx_unknown_e28b
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le600_00
          jsr     gx_unknown_e532
          bcc     le5f6_00
          rts     
le5f6_00:
          tii     $2207, $2020, $0008
          jmp     le5d4_00
le600_00:
          jsr     gx_unknown_e25c
          lda     #$d9
          sta     $2210
          lda     <$20
          and     #$07
          sta     $2211
          lda     #$80
          sta     $2219
          lda     <$26
          sta     $2212
          jsr     gx_unknown_e28b
          cmp     #$98
          beq     le63f_00
          lda     $2211
          cmp     #$04
          bne     le62a_00
          lda     $223b
le62a_00:
          sta     $223b
          cmp     #$01
          beq     le660_00
          cmp     #$02
          bne     le63f_00
          stz     $2206
          lda     #$20
          tsb     cd_control
          bra     le660_00
le63f_00:
          lda     $2211
          cmp     #$04
          bne     le649_00
          sta     $223b
le649_00:
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le65f_00
          jsr     gx_unknown_e532
          bcs     le65f_00
          tii     $2207, $2020, $0008
          jmp     le600_00
le65f_00:
          rts     
le660_00:
          lda     #$00
          rts     
le663_00:
          lda     #$3c
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     le68e_00
          lda     $223c
          beq     le676_00
          lda     #$00
          rts     
le676_00:
          jsr     gx_unknown_e25c
          lda     #$da
          sta     $2210
          jsr     gx_unknown_e28b
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le68d_00
          jsr     gx_unknown_e532
          bcc     le663_00
le68d_00:
          rts     
le68e_00:
          tii     $2020, $2207, $0008
le695_00:
          jsr     gx_unknown_e25c
          lda     #$dd
          sta     $2210
          lda     #$0a
          sta     $2211
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le6b4_00
          lda     #$0a
          sta     <$23
          lda     #$00
          sta     <$24
          jsr     gx_unknown_e1e7
le6b4_00:
          jsr     gx_unknown_e4cd
          tax     
          beq     le6c9_00
          jsr     gx_unknown_e532
          bcs     le6c9_00
          tii     $2207, $2020, $0008
          jmp     le695_00
le6c9_00:
          rts     
le6ca_00:
          lda     #$03
          tsb     adpcm_addr_ctrl
          lda     #$01
          trb     adpcm_addr_ctrl
          lda     #$02
          trb     adpcm_addr_ctrl
          rts     
gx_unknown_e6da:
          lda     #$0c
          tsb     adpcm_addr_ctrl
          lda     #$04
          trb     adpcm_addr_ctrl
          lda     #$08
          trb     adpcm_addr_ctrl
          rts     
gx_unknown_e6ea:
          lda     adpcm_status
          and     #$01
          bne     le6f6_00
          lda     bram_lock
          and     #$04
le6f6_00:
          tax     
          lda     adpcm_addr_ctrl
          and     #$20
          bne     le703_00
          lda     adpcm_status
          and     #$08
le703_00:
          rts     
le704_00:
          lda     #$10
          tsb     adpcm_addr_ctrl
          lda     #$10
          trb     adpcm_addr_ctrl
          rts     
le70f_00:
          lda     cd_status
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     le721_00
          cmp     #$d8
          beq     le72f_00
          bra     le70f_00
le721_00:
          lda     adpcm_addr_l
          sta     adpcm_ram_offset
le727_00:
          tst     #$04, $180c
          bne     le727_00
          bra     le70f_00
le72f_00:
          lda     cd_status
          and     #$b8
          sta     $222f
          rts     
gx_unknown_e738:
          tst     #$03, $180b
          beq     le742_00
          lda     #$ff
          bra     le793_00
le742_00:
          tii     $2020, $2207, $0008
le749_00:
          tii     $2021, adpcm_addr_l, $0002
          jsr     le6ca_00
          jsr     gx_unknown_e25c
          lda     #$08
          sta     $2210
          lda     <$27
          sta     $2211
          lda     <$26
          sta     $2212
          lda     <$25
          sta     $2213
          lda     <$23
          sta     $2214
          jsr     gx_unknown_e28b
          cmp     #$c8
          bne     le779_00
          jsr     le70f_00
le779_00:
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le793_00
          jsr     gx_unknown_e532
          bcs     le793_00
          tii     $2207, $2020, $0008
          lda     $2233
          cmp     #$10
          bcc     le749_00
le793_00:
          rts     
gx_adpcm_reset:
          lda     #$80
          sta     adpcm_addr_ctrl
          stz     adpcm_addr_ctrl
          stz     adpcm_dma_ctrl
          lda     #$6f
          trb     cd_control                ; clear all bits except bits 4 and 7
          stz     adpcm_playback_rate
          rts     
gx_unknown_e7a8:
          jsr     gx_adpcm_reset
le7ab_00:
          jsr     gx_unknown_e6ea
          bne     le7ab_00
          tii     $201a, adpcm_addr_l, $0002
          jsr     gx_unknown_e6da
          tii     $201e, adpcm_addr_l, $0002
          jsr     le704_00
          lda     adpcm_ram_offset
le7c7_00:
          tst     #$80, $180c
          bne     le7c7_00
          lda     adpcm_ram_offset
          sta     [$1c]
          inc     <$1c
          bne     le7d8_00
          inc     <$1d
le7d8_00:
          lda     <$1e
          bne     le7de_00
          dec     <$1f
le7de_00:
          dec     <$1e
          lda     <$1e
          ora     <$1f
          bne     le7c7_00
          rts     
gx_unknown_e7e7:
          tst     #$03, $180b
          bne     le816_00
          tii     $201a, adpcm_addr_l, $0002
          jsr     le6ca_00
le7f7_00:
          lda     [$1c]
          sta     adpcm_ram_offset
le7fc_00:
          tst     #$04, $180c
          bne     le7fc_00
          inc     <$1c
          bne     le808_00
          inc     <$1d
le808_00:
          lda     <$1e
          bne     le80e_00
          dec     <$1f
le80e_00:
          dec     <$1e
          lda     <$1e
          ora     <$1f
          bne     le7f7_00
le816_00:
          rts     
gx_unknown_e817:
          jsr     gx_unknown_e6ea
          bne     le851_00
          lda     <$1d
          cmp     #$10
          bcs     le851_00
          sta     adpcm_playback_rate
          lda     <$1a
          sta     adpcm_addr_l
          lda     <$1b
          sta     adpcm_addr_h
          jsr     le852_00
          lda     <$1e
          sta     adpcm_addr_l
          lda     <$1f
          sta     adpcm_addr_h
          lda     #$10
          tsb     adpcm_addr_ctrl
          lda     #$10
          trb     adpcm_addr_ctrl
          lda     #$08
          tsb     cd_control
          lda     #$60
          sta     adpcm_addr_ctrl
          cla     
le851_00:
          rts     

	.code
	.bank $000
	.org $e865
gx_irq_2_unknown:                           ; cd irq
          lda     cd_control
          and     bram_lock 
          ora     <$19                      ; 2019 contains a copy of cd_control
          sta     <$19
          bbr2    <$19, le87c_00
          lda     #$04                      ; bit 2 is set : adpcm sample playback in progress / half end
          trb     cd_control                ; reset bit 3 of cd_control
          lda     #$04
          trb     <$19
          cli     
le87c_00:
          bbr5    <$19, le8d9_00
          lda     #$20                      ; bit 5 is set: data transfer done?
          trb     cd_control                ; clear bit 5
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
          tst     #$40, cd_status
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
          tst     #$40, cd_status
          bne     le8bb_00
          lda     #$80
          trb     cd_control
le8c6_00:
          tst     #$80, cd_status
          bne     le8c6_00
          lda     $2206
          beq     le8d9_00
          stz     $2206
          lda     #$04
          tsb     cd_control
le8d9_00:
          bbr4    <$19, le8f1_00
          lda     #$10                              ; subchannel fifo something ?
          trb     cd_control
          lda     #$10
          trb     <$19
          cli     
          lda     bram_unlock
          sta     $2234
          lda     #$10
          tsb     cd_control
le8f1_00:
          bbr3    <$19, le902_00                    ; adpcm end reached
          lda     #$0c
          trb     cd_control
          lda     #$08
          trb     <$19
          lda     #$60
          trb     adpcm_addr_ctrl
le902_00:
          rts  

;-------------------------------------------------------------------------------
; Reset process list.
; The process list will only contain "gx_wait_forever".
;-------------------------------------------------------------------------------
gx_proc_reset:
          php                                   ; backup status register onto the stack
          sei                                   ; disable interrupts
          stz     gx_proc.lock                  ; reset process list lock
          ldx     #$04                          ; set the 5th entry
          lda     #low(gx_wait_forever)         ; the routine will be gx_wait_forever
          sta     $gx_proc.lsb, X
          lda     #high(gx_wait_forever)
          sta     $gx_proc.msb, X
          lda     #$20
          sta     gx_proc.stack_ptr, X          ; set the routine stack offset
          lda     #$04
          sta     $228b, X                      ; 0 => free
                                                ; 1 => ??
                                                ; 2 => ??
                                                ; 4 => ??
                                                ; 8 => ??
                                                
          stz     $22b8, X                      ; [todo] ???
          dex     
@loop:                                          ; [todo] ???
              lda     #$00
              sta     $228b, X
              stz     $2290, X
              stz     $22b8, X
              dex     
              bne     @loop
          stz     gx_proc.last
          lda     #$80
          sta     $22b8, X
          lda     #$81
          sta     $228b
          plp                                   ; restore status register
          rts     

          ; Count the number of process to run.
          ldx     #$04
          cly     
le942_00:
          lda     $228b, X
          cmp     #$00
          beq     le94a_00
          iny     
le94a_00:
          dex     
          bpl     le942_00
          tya     
          rts   

gx_unknown_e94f:
          php     
          sei     
          stz     $2290, X
          lda     #$04
          sta     $228b, X
          plp     
          rts     
          
gx_unknown_e95b:
          lda     #$01
          tsb     gx_proc.lock
          stx     <$29
          sty     <$28
          ldx     gx_proc.last
          ldy     #$01
          lda     [$28]
          sta     gx_proc.lsb, X
          lda     [$28], Y
          sta     gx_proc.msb, X
          iny     
          lda     [$28], Y
          sta     gx_proc.stack_ptr, X
          iny     
          lda     [$28], Y
          sta     $22b8, X
          lda     #$00
          sta     gx_proc.reg_p, X
          lda     #$04
          sta     $228b, X
          jmp     lea5a_00

;-------------------------------------------------------------------------------
; Add process to list.
; Parameters:
;   X : MSB of the process infos address
;   Y : LSB of the process infos address
;
; Return:
;   A : Process index.
;-------------------------------------------------------------------------------
gx_proc_load:
          lda     #$01                      ; lock process list
          tsb     gx_proc.lock
          stx     <$29                      ; set data pointer
          sty     <$28
          clx     
le996_00:                                   ; search for the first empty entry in the process list
              lda     $228b, X              ; what's inside 228b and onwards?
              cmp     #$00
              beq     @found
          inx     
          cmp     #$05
          bne     le996_00
          brk                               ; trigger IRQ2 => run process list ?
@found:
          lda     #$04
          sta     $228b, X
          ldy     #$01
          lda     [$28]
          sta     gx_proc.lsb, X
          lda     [$28], Y
          sta     gx_proc.msb, X
          iny     
          lda     [$28], Y
          sta     gx_proc.stack_ptr, X
          iny     
          lda     [$28], Y
          sta     $22b8, X
          lda     #$00
          sta     gx_proc.reg_p, X
          lda     #$01
          trb     gx_proc.lock              ; unlock process list
          txa     
          rts     

gx_unknown_e9cc:
          ldx     gx_proc.last
          lda     #$00
          sta     $228b, X
          jmp     lea55_00
gx_unknown_e9d7:
          cpx     gx_proc.last
          beq     gx_unknown_e9cc
          lda     #$00
          sta     $228b, X
          rts     
gx_unknown_e9e2:
          lda     #$01
gx_unknown_e9e4:
          pha     
          lda     #$01
          tsb     gx_proc.lock
          txa     
          ldx     gx_proc.last
          sta     gx_proc.reg_x, X
          tya     
          sta     gx_proc.reg_y, X
          pla     
          php     
          sta     $2290, X
          pla     
          sta     gx_proc.reg_p, X
          pla     
          clc     
          adc     #$01
          sta     gx_proc.lsb, X
          pla     
          adc     #$00
          sta     gx_proc.msb, X
          sax     
          tsx     
          sax     
          sta     gx_proc.stack_ptr, X
          lda     #$02
          sta     $228b, X
          jmp     lea5a_00
gx_unknown_ea19:
          phx     
          ldx     gx_proc.last
          sta     gx_proc.reg_a, X
          pla     
          sta     gx_proc.reg_x, X
          tya     
          sta     gx_proc.reg_y, X
          pla     
          sta     gx_proc.reg_p, X
          pla     
          sta     gx_proc.lsb, X
          pla     
          sta     gx_proc.msb, X
          sax     
          tsx     
          sax     
          sta     gx_proc.stack_ptr, X
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
lea55_00:
          lda     #$01
          tsb     gx_proc.lock
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

gx_wait_forever:
          cli     
@loop:
          bra     @loop

lea6b_00:
          stx     gx_proc.last
          lda     #$01
          ora     $22b8, X
          sta     $228b, X
          lda     gx_proc.reg_y, X
          tay     
          lda     gx_proc.stack_ptr, X      ; stack offset
          sax     
          txs     
          sax     
          lda     gx_proc.msb, X            ; return address MSB
          pha     
          lda     gx_proc.lsb, X            ; return address LSB
          pha     
          lda     gx_proc.reg_p, X          ; P register
          pha     
          lda     gx_proc.reg_x, X          ; future X reg
          pha     
          sei     
          lda     #$01
          trb     gx_proc.lock
          lda     gx_proc.reg_a, X
          plx     
          rti     
gx_irq_nmi:
          rti
gx_irq_timer:     
          bbr2    <irq_m, leaa2_00
          jmp     [irq_timer_user_hook]
leaa2_00:
          rti     

;-------------------------------------------------------------------------------
; IRQ2 interrupt handler
;-------------------------------------------------------------------------------
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

;-------------------------------------------------------------------------------
; "RESET" interrupt handler
;-------------------------------------------------------------------------------
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
gx_soft_reset:
          sei                           ; disable interrupts
          stz     timer_ctrl            ; disable CPU timer
          csh                           ; switch CPU to high speed mode
          ldx     #$ff                  ; reset stack pointer
          txs     
          lda     $22bf                 ; what is 22bf used for? 
          bne     leae1_00
              inc     $22bf
leae1_00:
          lda     #$01                  ; map 1st ROM bank to the 6th memory page
          tam     #$06
          jsr     gx_proc_reset         ; reset process list
          jmp     gx_main               ; jump to main routine

;-------------------------------------------------------------------------------
; 
;-------------------------------------------------------------------------------
gx_update_scroll:
          stz     <$35                  ; reset scroll window MSB [todo]
          stz     <$38                  ; reset scroll window index
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
          lda     #$c0                  ; enable display (background and sprites)
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
          lda     #$c0                  ; disable display.
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
          st0     #$0c                      ; vertical synchro register
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          clc     
          adc     <$39
          sta     video_data_h
          st0     #$0d                      ; vertical display register
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
          adc     #$08                          ; the source address ping/pong betweens $0800 and $0900
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
          sta     <$37                          ; [todo] scroll window data pointer MSB
          bne     lec24_00                      ; if != 0 => scroll window update else set scroll from "global" values
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
          sta     <$36                          ; set scroll data pointer LSB
          stz     <$38                          ; reset scroll window index
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
          jsr     gx_read_joypad
          ldx     gx_proc.last
          lda     $228b, X
          bit     #$80
          bne     lec6b_00
          lda     gx_proc.lock
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
gx_unknown_ec6f:                        ; [todo] hsync process
          ldy     <$38                  ; $2038 => current hsync op         [todo] where $2036-$2038 are set?
          lda     [$36], Y              ; $2036 => hsync op
          bmi     lec90_00              ; $80 => end
          beq     lece1_00              ; 0 =>  set X and Y scroll register  (values taken from hsync op)
          dec     A
          beq     leccf_00              ; 1 => set X scroll register only  (values taken from hsync op)
          dec     A
          beq     lecbd_00              ; 2 => set Y scroll register only (values taken from hsync op)
          dec     A
          beq     lec91_00              ; 3 => set X and Y scroll register
          iny     
          lda     <vdc_control          ; other => set control register
          and     [$36], Y
          iny     
          ora     [$36], Y
          st0     #$05
          sta     video_data_l
          jmp     lece1_00              ; set X and Y scroll register (same as 0)
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
          jmp     lecf2_00              ; set next rcr
lecbd_00:                               ; set Y scroll register
          iny     
          lda     [$36], Y
          iny     
          st0     #$08
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          jmp     lecf2_00              ; set next RCR
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
lece1_00:                               ; set X scroll register
          iny     
          lda     [$36], Y
          iny     
          st0     #$07
          sta     video_data_l
          lda     [$36], Y
          sta     video_data_h
          jmp     lecbd_00              ; then set Y scroll register
lecf2_00:
          lda     [$36], Y
          iny     
          st0     #$06                  ; set next rcr
          sta     video_data_l
          lda     [$36], Y
          iny     
          sta     video_data_h
          sty     <$38                  ; save index
          rts     

gx_unknown_ed03:
          stz     $22c6
          rts  

gx_unknown_ed07:
          lda     $22c6
          rts     

gx_unknown_ed0b:
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
gx_unknown_ef02:
          lda     #$40
          sta     $22ca
          lda     #$5e
          sta     $22cb
          lda     #$80
          sta     $22cc
          rts     
gx_unknown_ef12:
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
gx_read_joypad:
          cly     
          lda     #$01
          sta     joyport
          lda     #$03
          sta     joyport
@read_loop:
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
          bcc     @read_loop
          cly     
@check_soft_reset:
          lda     $22cd
          and     $efb4, Y
          beq     @next_joypad
          lda     $22d8, Y
          cmp     #$04
          bne     @next_joypad
          lda     $22d3, Y
          cmp     #$0c
          bne     @next_joypad
          jmp     gx_soft_reset
@next_joypad:
          iny     
          cpy     #$05
          bcc     @check_soft_reset
          rts     
          ora     [$02, X]                              ; [todo] this looks like data
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

gx_vdc_set_bat_size:
          tax     
          lda     gx_vdc_bat_size, X
          php     
          sei     
          st0     #$09
          sta     video_data_l
          lda     <vdc_reg
          sta     video_reg_l
          plp     
          rts     
gx_vdc_bat_size:
          .db $00,$10,$20,$30,$40,$50,$60,$70

gx_unknown_f0c3:
          php     
          sei     
          ora     #$40
          and     #$cf
          sta     $24c1
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
gx_unknown_f145:
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

gx_vdc_set_control_reg:
          lda     #$03
          sta     irq_disable               ; disable IRQ1 and IRQ2
          lda     #$05
          sta     <vdc_reg                  ; VDC control register
          sta     video_reg_l
          lda     <vdc_control
          and     #$f3
          sta     <vdc_control
          sta     video_data_l
          rts  
   
gx_unknown_f194:
          cly     
lf195_00:
          lda     [$04], Y
          cmp     #$ff
          beq     lf1b0_00
          phy     
          jsr     gx_unknown_f1db
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
lf1b1_00:
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
gx_unknown_f1cd:
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          rts     
gx_unknown_f1db:
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
          bsr     gx_unknown_f1cd
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

	.code
	.bank $000
	.org $f8a4
;-------------------------------------------------------------------------------
; Main routine
;-------------------------------------------------------------------------------
gx_main:
          jsr     gx_cd_reset                   ; reset cdrom drive
          jsr     gx_update_scroll
          jsr     gx_unknown_ed03
          ldx     #high(gx_boot+4)              ; add the gx_boot to process list
          ldy     #low(gx_boot+4)
          jsr     gx_proc_load
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

gx_boot:
          .db "BOOT"
          .dw gx_menu
          .db $40,$80
gx_menu:
          jsr     led7f_00
          jsr     gx_unknown_e9e2
          jmp     gx_menu
gx_vdc_clear_tiles:
          stz     <$46
          stz     <$47
          stz     <$48
          stz     <$49
          stz     <$4a
          jmp     gx_unknown_f996
gx_unknown_f996:
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
          jsr     gx_unknown_e33a
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
          jsr     gx_unknown_e33a
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
          jsr     gx_unknown_e33a
lff7d_00:
          rts     

	.data
	.bank $000
	.org $fff6
irq_vectors:
          .dw gx_irq_2
          .dw gx_irq_1
          .dw gx_irq_timer
          .dw gx_irq_nmi
          .dw gx_irq_reset

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
          jsr     gx_proc_load
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

