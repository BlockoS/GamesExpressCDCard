	.code
	.bank $000
	.org $e000
gx_unknown_e000:
          jmp     gx_irq_reset
; $E003:
          jmp     gx_proc_reset
; $E006:
          jmp     gx_unknown_ea19
; $E009:
          jmp     gx_unknown_e9e4
; $E00C:
          jmp     gx_unknown_e94f
; $E00F:
          jmp     gx_unknown_e95b
; $E012:
          jmp     gx_proc_load
; $E015:
          jmp     gx_unknown_e9cc
; $E018:
          jmp     gx_unknown_e9d7
; $E01B:
          jmp     gx_unknown_e9e2
; $E01E:
          jmp     gx_read_joypad
; $E021:
          jmp     gx_unpack
; $E024:
          jmp     gx_vdc_load_vram
; $E027:
          jmp     gx_unknown_ed03
; $E02A:
          jmp     gx_unknown_ed07
; $E02D:
          jmp     gx_unknown_ed0b
; $E030:
          jmp     gx_unknown_ef12
; $E033:
          jmp     gx_unknown_ef02
; $E036:
          jmp     gx_cd_reset
; $E039:
          jmp     gx_unknown_e17f
; $E03C:
          jmp     gx_cd_dinfo
; $E03F:
          jmp     gx_unknown_fe3c
; $E042:
          jmp     gx_unknown_ff75
; $E045:
          jmp     gx_write_cd_fade_timer
; $E048:
          jmp     gx_scsi_cmd
; $E04B:
          jmp     gx_unknown_e33a
; $E04E:
          jmp     gx_unknown_e6ea
; $E051:
          jmp     gx_unknown_e738
; $E054:
          jmp     gx_adpcm_reset
; $E057:
          jmp     gx_unknown_e7a8
; $E05A:
          jmp     gx_unknown_e7e7
; $E05D:
          jmp     gx_unknown_e817
; $E060:
          jmp     gx_cd_play
; $E063:
          jmp     gx_scsi_cmd
; $E066:
          jmp     gx_irq_reset
; $E069:
          jmp     gx_irq_reset
; $E06C:
          jmp     gx_irq_reset
; $E06F:
          jmp     gx_irq_reset
; $E072:
          jmp     gx_irq_reset
; $E075:
          jmp     gx_irq_reset
; $E078:
          jmp     gx_irq_reset
; $E07B:
          jmp     gx_irq_reset
; $E07E:
          jmp     gx_irq_reset
; $E081:
          jmp     gx_irq_reset
; $E084:
          jmp     gx_irq_reset
; $E087:
          jmp     gx_irq_reset
; $E08A:
          jmp     lfe11_00
; $E08D:
          jmp     gx_unknown_ff2f
; $E090:
          jmp     gx_vdc_clear_satb
; $E093:
          jmp     lf9e5_00
; $E096:
          jmp     lf9ed_00
; $E099:
          jmp     lfa62_00
; $E09C:
          jmp     gx_vdc_clear_satb_2
; $E09F:
          jmp     gx_display_init
; $E0A2:
          jmp     gx_vdc_enable_display
; $E0A5:
          jmp     gx_vdc_disable_display
; $E0A8:
          jmp     gx_clear_bat
; $E0AB:
          jmp     gx_vdc_set_ctrl_hi
; $E0AE:
          jmp     gx_unknown_f194
; $E0B1:
          jmp     lf22d_00
; $E0B4:
          jmp     gx_unknown_f1db
; $E0B7:
          jmp     lf4a4_00
; $E0BA:
          jmp     lf4ce_00
; $E0BD:
          jmp     lf4fa_00
; $E0C0:
          jmp     lf518_00
; $E0C3:
          jmp     lf49f_00
; $E0C6:
          jmp     lf1b1_00
; $E0C9:
          jmp     gx_vdc_enable_interrupts
; $E0CC:
          jmp     gx_vdc_set_control_reg
; $E0CF:
          jmp     gx_vdc_set_yres
; $E0D2:
          jmp     gx_vdc_set_bat_size
; $E0D5:
          jmp     gx_unknown_f0c3
; $E0D8:
          jmp     lf596_00
; $E0DB:
          jmp     lf59e_00
; $E0DE:
          jmp     lf5aa_00
; $E0E1:
          jmp     lf5b7_00
; $E0E4:
          jmp     lf5c0_00
; $E0E7:
          jmp     lf5fa_00
; $E0EA:
          jmp     lf622_00
; $E0ED:
          jmp     lf6ad_00
; $E0F0:
          jmp     lf683_00
; $E0F3:
          jmp     lf7c7_00
; $E0F6:
          jmp     lfb5c_00
; $E0F9:
          jmp     lfb66_00
; $E0FC:
          jmp     lfbc3_00
; $E0FF:
          jmp     lfbf5_00
; $E102:
          jmp     gx_irq_reset
; $E105:
          jmp     gx_irq_reset
; $E108:
          jmp     gx_irq_reset
; $E10B:
          jmp     gx_irq_reset
; $E10E:
          jmp     gx_irq_reset
; $E111:
          jmp     gx_irq_reset

gx_info_string:                         ; bank: $000 logical: $e114
          db "SYSTEM KERNEL REV 2reserv_tbl_0 1993/04/18",$0d,$0a
          db "Created by Hack Technical Group",$0d,$0a
          db "Special thanks to Ryo",$0d,$0a,$00,
gx_write_cd_fade_timer:                 ; bank: $000 logical: $e179
          and     #$0f
          sta     cd_fade_timer
          rts     
gx_unknown_e17f:                        ; bank: $000 logical: $e17f
          stz     <$20
          lda     #$35                  ; output buffer lsb
          sta     <$21
          lda     #$22                  ; output buffer msb
          sta     <$22
          jsr     gx_cd_dinfo
          tax     
          bne     le19f_00
          lda     #$01
          sta     <$20
          lda     #$37                  ; output buffer lsb
          sta     <$21
          lda     #$22                  ; output buffer msb
          sta     <$22
          jsr     gx_cd_dinfo
          tax     
le19f_00:                               ; bank: $000 logical: $e19f
          rts     

;-------------------------------------------------------------------------------
; Get DIR Info
;-------------------------------------------------------------------------------
gx_cd_dinfo:                            ; bank: $000 logical: $e1a0
          tii     $2020, $2207, $0008
@loop:                                  ; bank: $000 logical: $e1a7
          jsr     gx_scsi_clear_buffer
          lda     #$de
          sta     $2210
          lda     <$20
          sta     $2211
          lda     <$23
          sta     $2212
          jsr     gx_scsi_cmd
          cmp     #$c8
          bne     @end
          lda     #$04
          sta     <$23
          stz     <$24
          jsr     gx_unknown_e1e7
          jsr     gx_unknown_e4cd
          tii     $2207, $2020, $0008
          cmp     #$00
          beq     @end
          jsr     gx_unknown_e532
          bcs     end
          tii     $2207, $2020, $0008
          jmp     @loop
@end:                                   ; bank: $000 logical: $e1e6
          rts 
;-------------------------------------------------------------------------------
; Read data?
; Warning this routine doesn't not remap the destination pointer.
; $2021, $2022 : address of the destination buffer
; $2023, $2024 : number of bytes to read
;-------------------------------------------------------------------------------    
gx_unknown_e1e7:                        ; bank: $000 logical: $e1e7
          lda     cd_port
          and     #$f8
          sta     $222f
          cmp     #$d8
          beq     @resp
          cmp     #$c8
          beq     @read
          jmp     gx_unknown_e1e7
@read:
          cly     
          lda     cd_command
          sta     [$21], Y
          jsr     gx_scsi_handshake
          inc     <$21
          bne     @l0
          inc     <$22
@l0:
          sec     
          lda     <$23
          sbc     #$01
          sta     <$23
          lda     <$24
          sbc     #$00
          sta     <$24
          ora     <$23
          bne     gx_unknown_e1e7
@resp:
          lda     cd_port
          and     #$f8
          sta     $222f
          and     #$b8
          cmp     #$88
          jsr     gx_scsi_resp
          rts     
;-------------------------------------------------------------------------------
; Reset CDROM
;-------------------------------------------------------------------------------
gx_cd_reset:                            ; bank: $000 logical: $e22a
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
  
gx_unknown_e245:                        ; bank: $000 logical: $e245
          jsr     gx_scsi_clear_buffer
          stz     $2210
          jsr     gx_scsi_cmd
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le25a_00
          jsr     gx_unknown_e532
          sec     
          rts     
le25a_00:                               ; bank: $000 logical: $e25a
          clc     
          rts     

gx_scsi_clear_buffer:                   ; bank: $000 logical: $e25c
          stz     $2211
          tii     $2211, $2212, $0008
          rts     
;-------------------------------------------------------------------------------
; Wait 7962 cycles.
; This should be enough for CDROM to be ready.
;-------------------------------------------------------------------------------
gx_cd_wait:                             ; bank: $000 logical: $e267                                 ; A is the input parameter
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
;-------------------------------------------------------------------------------
; SCSI handshake.
;-------------------------------------------------------------------------------
gx_scsi_handshake:                          ; bank: $000 logical: $e279
          lda     #$80
          tsb     cd_control                ; initiation (PCE) set /ACK signal to 1
@l0:                                        ; wait for target (CD) to set /REQ signal to 0
          lda     cd_port
          and     #$40
          bne     @l0
          lda     #$80                      ; initiator (PCE) set /ACK signal to 0
          trb     cd_control
          rts     
;-------------------------------------------------------------------------------
; Process SCSI command buffer
;-------------------------------------------------------------------------------
gx_scsi_cmd:                            ; bank: $000 logical: $e28b
          stz     $220f
@retry:                                     ; bank: $000 logical: $e28e
          lda     #$81                      ; try to send command prefix $81, $ff
          sta     cd_command
          tst     #$80, cd_port
          beq     @go
          lda     #$60                      ; flush command buffer
          trb     cd_control
          sta     cd_port
          lda     #$19
          jsr     gx_cd_wait
          lda     #$ff
          sta     cd_command
          tst     #$40, cd_port
          beq     @retry
@l0:                                        ; wait while the CD is busy
          jsr     gx_scsi_handshake
@l1:
          tst     #$40, cd_port
          bne     @l0
          tst     #$80, cd_port
          bne     @l1
          bra     @retry
@go:
          sta     cd_port
          clx     
@busy:
          lda     cd_port
          and     #$40
          bne     @next
          lda     #$5a
@wait:
          dec     A
          bne     @wait
          nop     
          dex     
          bne     @busy
          bra     @retry
@next:
          stz     $222f
          clx     
@l2:
          lda     cd_port                   ; get cd status
          and     #$f8
          sta     $222f
          cmp     #$d0
          beq     @send
          and     #$b8
          cmp     #$98
          beq     le308_00
          cmp     #$88
          beq     le308_00
          cmp     #$80
          beq     le308_00
          bra     @l2
@send:                                      ; send command buffer
          lda     $2210, X
          inx     
          sta     cd_command
          nop     
          nop     
          nop     
          nop     
          jsr     gx_scsi_handshake
          bra     @l2
le308_00:                               ; bank: $000 logical: $e308
          lda     $2206
          bne     le339_00
          lda     $2210
          cmp     #$d9
          bne     le31b_00
          lda     $2211
          cmp     #$01
          beq     le339_00
le31b_00:                               ; bank: $000 logical: $e31b
          ldx     <$33
le31d_00:                               ; bank: $000 logical: $e31d
          lda     cd_port
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
le339_00:                               ; bank: $000 logical: $e339
          rts

; 2021 : mpr 6 page
; 2023 : ?
gx_unknown_e33a:                        ; bank: $000 logical: $e33a
          tii     $2020, $2207, $0008
          jsr     gx_scsi_clear_buffer  ; clears the 9 bytes starting at $2211
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
          beq     @vdc.copy
          tma     #$06                  ; backup MPR 6
          pha     
          jsr     gx_scsi_cmd
          cmp     #$c8
          bne     @end
@loop:                                  ; bank: $000 logical: $e36d
          lda     <$21                  ; map CDROM RAM
          tam     #$06
          lda     #$00                  ; dest: $c000
          sta     <$15
          lda     #$c0
          sta     <$16
          lda     #$00                  ; len: 8 KBytes
          sta     <$17
          lda     #$20
          sta     <$18
          jsr     gx_cd_read
          cmp     #$88                  ; check if the CD read is successful
          bne     @end
          inc     <$21                  ; next 8KB RAM
          lda     <$23                  ; we just read 8KB (4 sectors) 
          sec     
          sbc     #$04
          beq     @end                  ; repeat until we read all sectors
          bpl     @loop
@end:                                   ; bank: $000 logical: $e393
          pla                           ; restore MPR 6
          tam     #$06
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     @quit
          jsr     gx_unknown_e532
          bcs     @quit
          tii     $2207, $2020, $0008
          jmp     gx_unknown_e33a
@quit:                                  ; bank: $000 logical: $e3ac
          stz     $2246
          rts     
@vdc.copy:                              ; bank: $000 logical: $e3b0
          jsr     gx_scsi_cmd
          cmp     #$c8
          bne     le3ed_00
          cla     
          jsr     gx_vdc_set_ctrl_hi    ; copy data to VRAM
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
le3da_00:                               ; bank: $000 logical: $e3da
          lda     #$00
          sta     <$17
          lda     #$08
          sta     <$18
          jsr     gx_cd_read_to_vdc
          cmp     #$88
          bne     le3ed_00
          dec     <$23
          bne     le3da_00
le3ed_00:                               ; bank: $000 logical: $e3ed
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     @quit
          jsr     gx_unknown_e532
          bcs     @quit
          tii     $2207, $2020, $0008
          jmp     gx_unknown_e33a

gx_negate:                              ; bank: $000 logical: $e403
          cla     
          sec     
          sbc     <$17
          sta     <$17
          cla     
          sbc     <$18
          sta     <$18
          rts     

;-------------------------------------------------------------------------------
; Read data from CD and store it to RAM.
; Parameters:
;   $2017-18 : the number of bytes to read.
;   $2015-16 : the memory address where the read data will be stored
;
; Return:
;   A : CD status
;   X : Remaining number of 256 bytes blocs in the current sector 
;-------------------------------------------------------------------------------
gx_cd_read:              	  ; bank: $000 logical: $e40f
          jsr     gx_negate     ; negates the number of bytes to read
@start:                         
          lda     cd_port       ; wait until cdrom is ready
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
          lda     cd_data
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
          lda     cd_port
          and     #$f8
          sta     $222f
          rts     
;-------------------------------------------------------------------------------
; Same as gx_cd_read_to_ram but the read bytes are transfered to the VDC.
; Note that the VDC write register must have been set beforehand.
;-------------------------------------------------------------------------------
gx_cd_read_to_vdc:                      ; bank: $000 logical: $e454
          jsr     gx_negate
@start:
          lda     cd_port
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
          lda     cd_data
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
          lda     cd_port
          and     #$f8
          sta     $222f
          rts     
le48f_00:                               ; bank: $000 logical: $e48f
          cla     
          sec     
          sbc     <$17
          sta     <$17
          cla     
          sbc     <$18
          sta     <$18
le49a_00:                               ; bank: $000 logical: $e49a
          lda     cd_port
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     le4ad_00
          cmp     #$d8
          beq     le4c4_00
          jmp     le49a_00
le4ad_00:                               ; bank: $000 logical: $e4ad
          cly     
          lda     cd_command
          sta     [$15], Y
          jsr     gx_scsi_handshake
          inc     <$15
          bne     le4bc_00
          inc     <$16
le4bc_00:                               ; bank: $000 logical: $e4bc
          inc     <$17
          bne     le49a_00
          inc     <$18
          bne     le49a_00
le4c4_00:                               ; bank: $000 logical: $e4c4
          lda     cd_port
          and     #$b8
          sta     $222f
          rts     
gx_unknown_e4cd:                        ; bank: $000 logical: $e4cd
          lda     $220f
          beq     le4db_00
          stz     $220f
          jsr     gx_cd_reset
          lda     #$06
          rts     
le4db_00:                               ; bank: $000 logical: $e4db
          jsr     gx_scsi_resp
          jsr     gx_unknown_e513
          lda     $2232
          bne     le4e9_00
          stz     $2233
le4e9_00:                               ; bank: $000 logical: $e4e9
          rts     
;-------------------------------------------------------------------------------
; Process SCSI response
;-------------------------------------------------------------------------------
gx_scsi_resp:                               ; bank: $000 logical: $e4ea
          stz     $2232
le4ed_00:
          lda     cd_port
          and     #$f8
          sta     $222f
          cmp     #$d8
          beq     le4ff_00
          cmp     #$f8
          beq     le50a_00
          bra     le4ed_00
le4ff_00:                               ; bank: $000 logical: $e4ff
          lda     cd_command
          sta     $2232
          jsr     gx_scsi_handshake
          bra     le4ed_00
le50a_00:                               ; bank: $000 logical: $e50a
          lda     cd_port
          and     #$b8
          sta     $222f
          rts    
;-------------------------------------------------------------------------------
;------------------------------------------------------------------------------- 
gx_unknown_e513:                        ; bank: $000 logical: $e513php     
          sei     
le515_00:                               ; bank: $000 logical: $e515
          lda     cd_port
          and     #$f8
          cmp     #$f8
          beq     le520_00
          bra     le515_00
le520_00:                               ; bank: $000 logical: $e520
          lda     cd_command
          sta     $222f
          jsr     gx_scsi_handshake
          plp     
le52a_00:                               ; bank: $000 logical: $e52a
          lda     cd_port
          and     #$80
          bmi     le52a_00
          rts     
gx_unknown_e532:                        ; bank: $000 logical: $e532
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
le57f_00:                               ; bank: $000 logical: $e57f
          sta     $2231
le582_00:                               ; bank: $000 logical: $e582
          clc     
          rts     
le584_00:                               ; bank: $000 logical: $e584
          sec     
          rts     
gx_unknown_e586:                        ; bank: $000 logical: $e586
          stz     $2225
          tii     $2225, $2226, $0009
          jsr     gx_scsi_clear_buffer
          lda     #$00
          sta     $2210
          lda     #$0a
          sta     $2214
          jsr     gx_scsi_cmd
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
le5b7_00:                               ; bank: $000 logical: $e5b7
          jsr     gx_unknown_e4cd
          pha     
          cmp     #$00
          bne     le5cb_00
          lda     $2227
          sta     $2230
          lda     $222e
          sta     $2233
le5cb_00:                               ; bank: $000 logical: $e5cb
          pla     
          rts     
;-------------------------------------------------------------------------------
; CD Audio playback; Parameters:
; Parameters:
;   $2020 - Play mode.
;   $2025 - Start track number.
;   $2026 -  End track number.
;
; Return:
;   A - 00 ok else sub error code.
;-------------------------------------------------------------------------------
gx_cd_play:                             ; bank: $000 logical: $e5cd
          tii     $2020, $2207, $0008
le5d4_00:                               ; bank: $000 logical: $e5d4
          jsr     gx_unknown_e25c
          lda     #$80
          sta     $2219
          lda     #$d8
          sta     $2210
          lda     <$25
          sta     $2212
          jsr     gx_scsi_cmd
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le600_00
          jsr     gx_unknown_e532
          bcc     le5f6_00
          rts     
le5f6_00:                               ; bank: $000 logical: $e5f6
          tii     $2207, $2020, $0008
          jmp     le5d4_00
le600_00:                               ; bank: $000 logical: $e600
          jsr     gx_scsi_clear_buffer
          lda     #$d9
          sta     $2210
          lda     <$20
          and     #$07
          sta     $2211
          lda     #$80
          sta     $2219
          lda     <$26
          sta     $2212
          jsr     gx_scsi_cmd
          cmp     #$98
          beq     le63f_00
          lda     $2211
          cmp     #$04
          bne     le62a_00
          lda     $223b
le62a_00:                               ; bank: $000 logical: $e62a
          sta     $223b
          cmp     #$01
          beq     le660_00
          cmp     #$02
          bne     le63f_00
          stz     $2206
          lda     #$20
          tsb     cd_control
          bra     le660_00
le63f_00:                               ; bank: $000 logical: $e63f
          lda     $2211
          cmp     #$04
          bne     le649_00
          sta     $223b
le649_00:                               ; bank: $000 logical: $e649
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le65f_00
          jsr     gx_unknown_e532
          bcs     le65f_00
          tii     $2207, $2020, $0008
          jmp     le600_00
le65f_00:                               ; bank: $000 logical: $e65f
          rts     
le660_00:                               ; bank: $000 logical: $e660
          lda     #$00
          rts     
le663_00:                               ; bank: $000 logical: $e663
          lda     #$3c
          sta     <$21
          lda     #$22
          sta     <$22
          jsr     le68e_00
          lda     $223c
          beq     le676_00
          lda     #$00
          rts     
le676_00:                               ; bank: $000 logical: $e676
          jsr     gx_scsi_clear_buffer
          lda     #$da
          sta     $2210
          jsr     gx_scsi_cmd
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le68d_00
          jsr     gx_unknown_e532
          bcc     le663_00
le68d_00:                               ; bank: $000 logical: $e68d
          rts     
le68e_00:                               ; bank: $000 logical: $e68e
          tii     $2020, $2207, $0008
le695_00:                               ; bank: $000 logical: $e695
          jsr     gx_scsi_clear_buffer
          lda     #$dd
          sta     $2210
          lda     #$0a
          sta     $2211
          jsr     gx_scsi_cmd
          cmp     #$c8
          bne     le6b4_00
          lda     #$0a
          sta     <$23
          lda     #$00
          sta     <$24
          jsr     gx_unknown_e1e7
le6b4_00:                               ; bank: $000 logical: $e6b4
          jsr     gx_unknown_e4cd
          tax     
          beq     le6c9_00
          jsr     gx_unknown_e532
          bcs     le6c9_00
          tii     $2207, $2020, $0008
          jmp     le695_00
le6c9_00:                               ; bank: $000 logical: $e6c9
          rts     
le6ca_00:                               ; bank: $000 logical: $e6ca
          lda     #$03
          tsb     adpcm_addr_ctrl
          lda     #$01
          trb     adpcm_addr_ctrl
          lda     #$02
          trb     adpcm_addr_ctrl
          rts     
gx_unknown_e6da:                        ; bank: $000 logical: $e6da
          lda     #$0c
          tsb     adpcm_addr_ctrl
          lda     #$04
          trb     adpcm_addr_ctrl
          lda     #$08
          trb     adpcm_addr_ctrl
          rts     
gx_unknown_e6ea:                        ; bank: $000 logical: $e6ea
          lda     adpcm_status
          and     #$01
          bne     le6f6_00
          lda     bram_lock
          and     #$04
le6f6_00:                               ; bank: $000 logical: $e6f6
          tax     
          lda     adpcm_addr_ctrl
          and     #$20
          bne     le703_00
          lda     adpcm_status
          and     #$08
le703_00:                               ; bank: $000 logical: $e703
          rts     
le704_00:                               ; bank: $000 logical: $e704
          lda     #$10
          tsb     adpcm_addr_ctrl
          lda     #$10
          trb     adpcm_addr_ctrl
          rts     
le70f_00:                               ; bank: $000 logical: $e70f
          lda     cd_port
          and     #$f8
          sta     $222f
          cmp     #$c8
          beq     le721_00
          cmp     #$d8
          beq     le72f_00
          bra     le70f_00
le721_00:                               ; bank: $000 logical: $e721
          lda     cd_data
          sta     adpcm_ram_offset
le727_00:                               ; bank: $000 logical: $e727
          tst     #$04, adpcm_status
          bne     le727_00
          bra     le70f_00
le72f_00:                               ; bank: $000 logical: $e72f
          lda     cd_port
          and     #$b8
          sta     $222f
          rts     
gx_unknown_e738:                        ; bank: $000 logical: $e738
          tst     #$03, adpcm_dma_ctrl
          beq     le742_00
          lda     #$ff
          bra     le793_00
le742_00:                               ; bank: $000 logical: $e742
          tii     $2020, $2207, $0008
le749_00:                               ; bank: $000 logical: $e749
          tii     $2021, cd_data, $0002
          jsr     le6ca_00
          jsr     gx_scsi_clear_buffer
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
          jsr     gx_scsi_cmd
          cmp     #$c8
          bne     le779_00
          jsr     le70f_00
le779_00:                               ; bank: $000 logical: $e779
          jsr     gx_unknown_e4cd
          cmp     #$00
          beq     le793_00
          jsr     gx_unknown_e532
          bcs     le793_00
          tii     $2207, $2020, $0008
          lda     $2233
          cmp     #$10
          bcc     le749_00
le793_00:                               ; bank: $000 logical: $e793
          rts     
gx_adpcm_reset:                         ; bank: $000 logical: $e794
          lda     #$80
          sta     adpcm_addr_ctrl
          stz     adpcm_addr_ctrl
          stz     adpcm_dma_ctrl
          lda     #$6f
          trb     cd_control            ; clear all bits except bits 4 and 7
          stz     adpcm_playback_rate
          rts     
gx_unknown_e7a8:                        ; bank: $000 logical: $e7a8
          jsr     gx_adpcm_reset
le7ab_00:                               ; bank: $000 logical: $e7ab
          jsr     gx_unknown_e6ea
          bne     le7ab_00
          tii     $201a, cd_data, $0002
          jsr     gx_unknown_e6da
          tii     $201e, cd_data, $0002
          jsr     le704_00
          lda     adpcm_ram_offset
le7c7_00:                               ; bank: $000 logical: $e7c7
          tst     #$80, adpcm_status
          bne     le7c7_00
          lda     adpcm_ram_offset
          sta     [$1c]
          inc     <$1c
          bne     le7d8_00
          inc     <$1d
le7d8_00:                               ; bank: $000 logical: $e7d8
          lda     <$1e
          bne     le7de_00
          dec     <$1f
le7de_00:                               ; bank: $000 logical: $e7de
          dec     <$1e
          lda     <$1e
          ora     <$1f
          bne     le7c7_00
          rts     
gx_unknown_e7e7:                        ; bank: $000 logical: $e7e7
          tst     #$03, adpcm_dma_ctrl
          bne     le816_00
          tii     $201a, cd_data, $0002
          jsr     le6ca_00
le7f7_00:                               ; bank: $000 logical: $e7f7
          lda     [$1c]
          sta     adpcm_ram_offset
le7fc_00:                               ; bank: $000 logical: $e7fc
          tst     #$04, adpcm_status
          bne     le7fc_00
          inc     <$1c
          bne     le808_00
          inc     <$1d
le808_00:                               ; bank: $000 logical: $e808
          lda     <$1e
          bne     le80e_00
          dec     <$1f
le80e_00:                               ; bank: $000 logical: $e80e
          dec     <$1e
          lda     <$1e
          ora     <$1f
          bne     le7f7_00
le816_00:                               ; bank: $000 logical: $e816
          rts     
gx_unknown_e817:                        ; bank: $000 logical: $e817
          jsr     gx_unknown_e6ea
          bne     le851_00
          lda     <$1d
          cmp     #$10
          bcs     le851_00
          sta     adpcm_playback_rate
          lda     <$1a
          sta     cd_data
          lda     <$1b
          sta     cd_data+1
          jsr     le852_00
          lda     <$1e
          sta     cd_data
          lda     <$1f
          sta     cd_data+1
          lda     #$10
          tsb     adpcm_addr_ctrl
          lda     #$10
          trb     adpcm_addr_ctrl
          lda     #$08
          tsb     cd_control
          lda     #$60
          sta     adpcm_addr_ctrl
          cla     
le851_00:                               ; bank: $000 logical: $e851
          rts     
le852_00:                               ; bank: $000 logical: $e852
          lda     #$08
          tsb     adpcm_addr_ctrl
          lda     adpcm_ram_offset
          lda     #$05
le85c_00:                               ; bank: $000 logical: $e85c
          dec     A
          bne     le85c_00
          lda     #$08
          trb     adpcm_addr_ctrl
          rts     
gx_irq_2_unknown:                       ; bank: $000 logical: $e865
          lda     cd_control
          and     bram_lock 
          ora     <$19                  ; 2019 contains a copy of cd_control
          sta     <$19
          bbr2    <$19, le87c_00
          lda     #$04                  ; bit 2 is set : adpcm sample playback in progress / half end
          trb     cd_control            ; reset bit 3 of cd_control
          lda     #$04
          trb     <$19
          cli     
le87c_00:                               ; bank: $000 logical: $e87c
          bbr5    <$19, le8d9_00
          lda     #$20                  ; bit 5 is set: data transfer done?
          trb     cd_control            ; clear bit 5
          lda     #$20
          trb     <$19
          cli     
          lda     $2206
          beq     le891_00
          stz     adpcm_dma_ctrl
le891_00:                               ; bank: $000 logical: $e891
          lda     cd_command
          sta     $2232
          lda     #$80
          tsb     cd_control
le89c_00:                               ; bank: $000 logical: $e89c
          tst     #$40, cd_port
          bne     le89c_00
          php     
          sei     
          lda     #$80
          trb     cd_control
le8a9_00:                               ; bank: $000 logical: $e8a9
          lda     cd_port
          and     #$f8
          cmp     #$f8
          bne     le8a9_00
          lda     cd_command
          lda     #$80
          tsb     cd_control
          plp     
le8bb_00:                               ; bank: $000 logical: $e8bb
          tst     #$40, cd_port
          bne     le8bb_00
          lda     #$80
          trb     cd_control
le8c6_00:                               ; bank: $000 logical: $e8c6
          tst     #$80, cd_port
          bne     le8c6_00
          lda     $2206
          beq     le8d9_00
          stz     $2206
          lda     #$04
          tsb     cd_control
le8d9_00:                               ; bank: $000 logical: $e8d9
          bbr4    <$19, le8f1_00
          lda     #$10                  ; subchannel fifo something ?
          trb     cd_control
          lda     #$10
          trb     <$19
          cli     
          lda     bram_unlock
          sta     $2234
          lda     #$10
          tsb     cd_control
le8f1_00:                               ; bank: $000 logical: $e8f1
          bbr3    <$19, le902_00        ; adpcm end reached
          lda     #$0c
          trb     cd_control
          lda     #$08
          trb     <$19
          lda     #$60
          trb     adpcm_addr_ctrl
le902_00:                               ; bank: $000 logical: $e902
          rts  

;-------------------------------------------------------------------------------
; Reset process list.
; The process list will only contain "gx_wait_forever".
;-------------------------------------------------------------------------------
gx_proc_reset:                          ; bank: $000 logical: $e903
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
          sta     $228b, X                      ; bit 0 => free
                                                ;     1 => trigger irq2 ?
                                                ;     2 => ??
                                                ;     3 => active/to be run ?
                                                ;  ....
                                                ;     7 => ? 
                                                
          stz     $22b8, X                      ; [todo] ???
          dex     
@loop:                                          ; clear the rest of the proc list
              lda     #$00
              sta     $228b, X
              stz     $2290, X
              stz     $22b8, X
              dex     
              bne     @loop
          stz     gx_proc.current
          lda     #$80
          sta     $22b8, X
          lda     #$81
          sta     $228b
          plp                                   ; restore status register
          rts     

          ; Count the number of process to run.
          ldx     #$04
          cly     
le942_00:                               ; bank: $000 logical: $e942
          lda     $228b, X
          cmp     #$00
          beq     le94a_00
          iny     
le94a_00:                               ; bank: $000 logical: $e94a
          dex     
          bpl     le942_00
          tya     
          rts     
gx_unknown_e94f:                        ; bank: $000 logical: $e94f
          php     
          sei     
          stz     $2290, X
          lda     #$04
          sta     $228b, X
          plp     
          rts     
gx_unknown_e95b:                        ; bank: $000 logical: $e95b
          lda     #$01
          tsb     gx_proc.lock
          stx     <$29
          sty     <$28
          ldx     gx_proc.current
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
gx_proc_load:                           ; bank: $000 logical: $e98c
          lda     #$01                      ; lock process list
          tsb     gx_proc.lock
          stx     <$29                      ; set data pointer
          sty     <$28
          clx     
@search:                                    ; search for the first empty entry in the process list
              lda     $228b, X              ; what's inside 228b and onwards?
              cmp     #$00
              beq     @found
          inx     
          cmp     #$05
          bne     @search
          brk                               ; trigger IRQ2 => run process list ?
@found:
          lda     #$04
          sta     $228b, X
          ldy     #$01
          lda     [$28]                     ; load proc address
          sta     gx_proc.lsb, X
          lda     [$28], Y
          sta     gx_proc.msb, X
          iny     
          lda     [$28], Y                  ; stack offset
          sta     gx_proc.stack_ptr, X
          iny     
          lda     [$28], Y                  ; flag?
          sta     $22b8, X
          lda     #$00
          sta     gx_proc.reg_p, X
          lda     #$01
          trb     gx_proc.lock              ; unlock process list
          txa     
          rts   

gx_unknown_e9cc:                        ; bank: $000 logical: $e9cc
          ldx     gx_proc.current
          lda     #$00
          sta     $228b, X
          jmp     lea55_00
gx_unknown_e9d7:                        ; bank: $000 logical: $e9d7
          cpx     gx_proc.current
          beq     gx_unknown_e9cc
          lda     #$00
          sta     $228b, X
          rts     

gx_unknown_e9e2:                        ; bank: $000 logical: $e9e2
          lda     #$01
gx_unknown_e9e4:                        ; bank: $000 logical: $e9e4
          pha     
          lda     #$01
          tsb     gx_proc.lock
          txa     
          ldx     gx_proc.current          ; use the last proc
          sta     gx_proc.reg_x, X      ; backup X register
          tya     
          sta     gx_proc.reg_y, X      ; backup Y register
          pla     
          php     
          sta     $2290, X              ; ???
          pla     
          sta     gx_proc.reg_p, X      ; backup status flag
          pla                           ; retrieve return address
          clc
          adc     #$01
          sta     gx_proc.lsb, X        ; and set it as the next proc
          pla     
          adc     #$00
          sta     gx_proc.msb, X
          sax     
          tsx                           ; backup stack pointer offset
          sax     
          sta     gx_proc.stack_ptr, X
          lda     #$02                  ; set flag ?
          sta     $228b, X
          jmp     lea5a_00
          
gx_unknown_ea19:                        ; bank: $000 logical: $ea19
          phx     
          ldx     gx_proc.current
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
lea41_00:                               ; bank: $000 logical: $ea41
          lda     $228b, X
          cmp     #$02
          bne     lea52_00
          dec     $2290, X
          bne     lea52_00
          lda     #$04
          sta     $228b, X
lea52_00:                               ; bank: $000 logical: $ea52
          dex     
          bpl     lea41_00
lea55_00:                               ; bank: $000 logical: $ea55
          lda     #$01
          tsb     gx_proc.lock
lea5a_00:                               ; bank: $000 logical: $ea5a
          clx     
lea5b_00:                               ; bank: $000 logical: $ea5b
          lda     $228b, X              ; find the next proc to run
          cmp     #$04
          beq     lea6b_00
          inx     
          cpx     #$05
          bne     lea5b_00

          brk     

gx_wait_forever:                        ; bank: $000 logical: $ea68
          cli     
@loop:                                  ; bank: $000 logical: $ea69
          bra     @loop

;-------------------------------------------------------------------------------
; [todo] gx_proc.run
;-------------------------------------------------------------------------------
lea6b_00:                               ; bank: $000 logical: $ea6b
          stx     gx_proc.current       ; 
          lda     #$01
          ora     $22b8, X
          sta     $228b, X              ; update flag
          lda     gx_proc.reg_y, X      ; future Y reg
          tay     
          lda     gx_proc.stack_ptr, X  ; stack offset
          sax     
          txs     
          sax     
          lda     gx_proc.msb, X        ; proc MSB
          pha     
          lda     gx_proc.lsb, X        ; proc LSB
          pha     
          lda     gx_proc.reg_p, X      ; status register
          pha     
          lda     gx_proc.reg_x, X      ; future X reg
          pha     
          sei     
          lda     #$01
          trb     gx_proc.lock
          lda     gx_proc.reg_a, X      ; future A reg
          plx     
          rti                           ; jump to the proc

gx_irq_nmi:                             ; bank: $000 logical: $ea9b
          rti     
gx_irq_timer:                           ; bank: $000 logical: $ea9c
          bbr2    <irq_m, leaa2_00
          jmp     [irq_timer_user_hook]
leaa2_00:                               ; bank: $000 logical: $eaa2
          rti     

;-------------------------------------------------------------------------------
; IRQ2 interrupt handler
;-------------------------------------------------------------------------------
gx_irq_2:                               ; bank: $000 logical: $eaa3
          bbr1    <irq_m, leaa9_00
          jmp     [irq2_user_hook]
leaa9_00:                               ; bank: $000 logical: $eaa9
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
gx_irq_reset:                           ; bank: $000 logical: $eab3
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
gx_soft_reset:                          ; bank: $000 logical: $ead1
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
gx_update_scroll:                       ; bank: $000 logical: $eaeb
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
gx_unknown_eb00:                        ; bank: $000 logical: $eb00
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
leb1f_00:                               ; bank: $000 logical: $eb1f
          lda     $24c1
          and     #$0f
          eor     #$ff
          sec     
          adc     $24bf
          sta     $24bf
          bpl     leb6a_00
          stz     $24bf
          bra     leb52_00
leb34_00:                               ; bank: $000 logical: $eb34
          lda     $24c1
          and     #$0f
          clc     
          adc     $24bf
          bcs     leb48_00
          sta     $24bf
          asl     A
          cmp     $24c2
          bcc     leb6a_00
leb48_00:                               ; bank: $000 logical: $eb48
          lda     $24c2
          sta     $24bf
          lda     #$c0                  ; disable display.
          trb     <vdc_control
leb52_00:                               ; bank: $000 logical: $eb52
          lda     #$20
          tsb     $24c1
          bra     leb6a_00
leb59_00:                               ; bank: $000 logical: $eb59
          lda     #$10
          bit     $24c1
          bne     leb65_00
          tsb     $24c1
          bra     leb6a_00
leb65_00:                               ; bank: $000 logical: $eb65
          lda     #$40
          trb     $24c1
leb6a_00:                               ; bank: $000 logical: $eb6a
          st0     #$08
          lda     <vdc_scroll_y
          clc     
          adc     <$39
          sta     video_data_l
          lda     <vdc_scroll_y+1
          bcc     leb79_00
          inc     A
leb79_00:                               ; bank: $000 logical: $eb79
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
gx_irq_1:                               ; bank: $000 logical: $eba5
          bbr0    <irq_m, @gx_irq1
          jmp     [irq1_user_hook]
@gx_irq1:                               ; bank: $000 logical: $ebab
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
@check_spr_or:                          ; bank: $000 logical: $ebc8
          bit     #$02                          ; test for sprites overflow 
          beq     @check_vsync
          inc     $2049                         ; ?!
          lda     <vdc_control
          and     #$fd                          ; disable sprite overflow interrupt
          sta     <vdc_control
          st0     #$05
          sta     video_data_l
          lda     <vdc_status
@check_vsync:                           ; bank: $000 logical: $ebdc
          bit     #$20                          ; test for vsync
          bne     @vsync
          jmp     lec5a_00
@vsync:                                 ; bank: $000 logical: $ebe3
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
@scroll_y:                              ; bank: $000 logical: $ec05
          st0     #$08                          ; set Y scroll
          lda     <vdc_scroll_y
          sta     video_data_l
          lda     <vdc_scroll_y+1
          sta     video_data_h
@update_scroll:                         ; bank: $000 logical: $ec11
          lda     <gx_scroll_x
          sta     <vdc_scroll_x
          lda     <gx_scroll_x+1
          sta     <vdc_scroll_x+1
          lda     <gx_scroll_y
          sta     <vdc_scroll_y
          lda     <gx_scroll_y+1
          sta     <vdc_scroll_y+1
          jmp     lec2d_00
lec24_00:                               ; bank: $000 logical: $ec24
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
          ldx     gx_proc.current
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
lec5a_00:                               ; bank: $000 logical: $ec5a
          lda     <$37
          beq     lec66_00
          ldx     #$0f
lec60_00:                               ; bank: $000 logical: $ec60
          dex     
          bpl     lec60_00
          jsr     gx_unknown_ec6f
lec66_00:                               ; bank: $000 logical: $ec66
          lda     <vdc_reg
          sta     video_reg_l
lec6b_00:                               ; bank: $000 logical: $ec6b
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
lec90_00:                               ; bank: $000 logical: $ec90
          rts     
lec91_00:                               ; bank: $000 logical: $ec91
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
gx_unknown_ed03:                        ; bank: $000 logical: $ed03
          stz     $22c6
          rts     
gx_unknown_ed07:                        ; bank: $000 logical: $ed07
          lda     $22c6
          rts     
gx_unknown_ed0b:                        ; bank: $000 logical: $ed0b
          lda     $22c6
          bne     led11_00
          rts     
led11_00:                               ; bank: $000 logical: $ed11
          jsr     gx_unknown_e9e4
          rts

;-------------------------------------------------------------------------------
; 
; 203a, 203b: source address
; 22c1, 22c2: VRAM destination address
; 22c7      : source bank (mapped to mpr 2, 3)
;-------------------------------------------------------------------------------
gx_vdc_load_vram:                       ; bank: $000 logical: $ed15
          lda     <$3b
@l0:                                    ; bank: $000 logical: $ed17
          cmp     #$60                  ; remap source pointer
          bcc     @l1                   ;     while ptr.hi >= 0x60
          sbc     #$20                  ;         ptr.hi -= 0x20
          inc     $22c7                 ;         bank++
          bra     @l0
@l1:                                    ; bank: $000 logical: $ed22
          sta     <$3b
          stz     $22c0
          lda     #$05                  ; disable sprite and background display
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1
          and     #$e7
          sta     <vdc_control+1
          sta     video_data_h
          lda     #$00                  ; set VRAM write pointer
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1
          sta     video_data_l
          lda     $22c2
          sta     video_data_h
          lda     #$02                  ; write to VRAM data register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1                 ; $22c3.w = $22c2.w << 1
          asl     A                     ; Why?
          sta     $22c3
          lda     $22c2
          rol     A
          sta     $22c4
          tma     #$02                  ; save mpr #2 to $22c8
          sta     $22c8
          tma     #$03                  ; save mpr #3 to $22c9
          sta     $22c9
          lda     $22c7                 ; map $22c7 to mpr #2 and the next one to mpr #3
          tam     #$02
          inc     A
          tam     #$03
          lda     [$3a]                 ; 1st byte : bloc count ?
          sta     $22c6
          inc     <$3a                  ; $203a.w += 1
          bne     @l2
          inc     <$3b
@l2:                                    ; bank: $000 logical: $ed7c
          clx     
          bra     ledcb_00

;-------------------------------------------------------------------------------
; [todo]
;-------------------------------------------------------------------------------
gx_unknown_ed7f:
          lda     $22c6
          bne     led85_00
          rts     
led85_00:                               ; bank: $000 logical: $ed85
          lda     #$05                  ; VDC Control register
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control+1        ; set auto increment to 1
          and     #$e7
          sta     <vdc_control+1
          sta     video_data_h
          lda     #$00                  ; set VRAM write pointer
          sta     <vdc_reg
          sta     video_reg_l
          lda     $22c1                 ; VRAM address LSB
          sta     video_data_l
          lda     $22c2                 ; VRAM address MSB
          sta     video_data_h
          lda     #$02                  ; write to VRAM data register
          sta     <vdc_reg
          sta     video_reg_l
          tma     #$02                  ; save mpr #2 to $22c8
          sta     $22c8
          tma     #$03                  ; save mpr #3 to $22c9
          sta     $22c9
          lda     $22c7                 ;  map $22c7 to mpr #2 and the next one to mpr #3
          tam     #$02
          inc     A
          tam     #$03
          ldx     $22c0
          beq     ledcb_00
          lda     <$3f
          sta     video_data_l
          
ledcb_00:                               ; bank: $000 logical: $edcb
          lda     <$3b                  ; remap pointer 
          cmp     #$60
          bcc     leddc_00
          sbc     #$20
          sta     <$3b
          tma     #$03
          tam     #$02
          inc     A
          tam     #$03
leddc_00:                               ; bank: $000 logical: $eddc
          lda     [$3a]                 ; this is some kind of control byte?
          cmp     #$ff                  ; $ff: end of data stream?
          beq     leded_00
          bit     #$80                  
          beq     lee1e_00              ; bit 7 cleared
          bit     #$40
          beq     lee51_00              ; bit 6 cleared
          jmp     gx_vdc_write
leded_00:                               ; bank: $000 logical: $eded
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
lee1e_00:                               ; bank: $000 logical: $ee1e
          bit     #$40
          bne     lee80_00
          and     #$3f
          sta     <$3e
          ldy     #$01
          adc     $22c3
          sta     $22c3
          bcc     lee33_00
          inc     $22c4
lee33_00:                               ; bank: $000 logical: $ee33
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
lee51_00:                               ; bank: $000 logical: $ee51
          and     #$3f
          sta     <$3e
          ldy     #$01
          adc     $22c3
          sta     $22c3
          bcc     lee62_00
          inc     $22c4
lee62_00:                               ; bank: $000 logical: $ee62
          lda     [$3a], Y
          sta     <$3f
lee66_00:                               ; bank: $000 logical: $ee66
          sta     video_data_l, X       ; looks like some RLE encoding?
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
lee80_00:                               ; bank: $000 logical: $ee80
          and     #$3f
          sta     <$3e
          asl     A
          adc     $22c3
          sta     $22c3
          bcc     lee90_00
          inc     $22c4
lee90_00:                               ; bank: $000 logical: $ee90
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
leea5_00:                               ; bank: $000 logical: $eea5
          lda     <$3c                  ; RLE encoding but with a word?
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
leebe_00:                               ; bank: $000 logical: $eebe
          dec     <$3e
          bne     leea5_00
          sta     <$3f
          jmp     ledcb_00
gx_vdc_write:                           ; bank: $000 logical: $eec7
          and     #$3f
          sta     <$3e
          asl     A
          adc     $22c3
          sta     $22c3
          bcc     @loop
          inc     $22c4
@loop:                                  ; bank: $000 logical: $eed7
          ldy     #$01                  ; raw data copy?
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
gx_unknown_ef02:                        ; bank: $000 logical: $ef02
          lda     #$40
          sta     $22ca
          lda     #$5e
          sta     $22cb
          lda     #$80
          sta     $22cc
          rts     
gx_unknown_ef12:                        ; bank: $000 logical: $ef12
          lda     $22ca
          eor     $22cb
          and     #$02
          clc     
          beq     lef1e_00
          sec     
lef1e_00:                               ; bank: $000 logical: $ef1e
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
gx_read_joypad:                         ; bank: $000 logical: $ef41
          cly     
          lda     #$01
          sta     joyport
          lda     #$03
          sta     joyport
@read_loop:                             ; bank: $000 logical: $ef4c
          lda     #$01
          sta     joyport
          pha     
          pla     
          nop     
          lda     gx_joypad, Y
          sta     gx_joyold, Y
          lda     joyport
          pha     
          and     #$0f
          eor     #$0f
          tax     
          lda     gx_unknown_efb9, X
          stz     joyport
          pla     
          asl     A
          asl     A
          asl     A
          asl     A
          sta     gx_joypad, Y
          lda     joyport
          and     #$0f
          ora     gx_joypad, Y
          eor     #$ff
          sta     gx_joypad, Y
          eor     gx_joyold, Y
          pha     
          and     gx_joypad, Y
          sta     gx_joytrg, Y
          pla     
          and     gx_joyold, Y
          sta     $22dd, Y
          iny     
          cpy     #$05
          bcc     @read_loop
          cly     
@check_soft_reset:                      ; bank: $000 logical: $ef95
          lda     $22cd
          and     gx_unknonwn_efb4, Y
          beq     @next_joypad
          lda     gx_joytrg, Y
          cmp     #$04
          bne     @next_joypad
          lda     gx_joypad, Y
          cmp     #$0c
          bne     @next_joypad
          jmp     gx_soft_reset
@next_joypad:                           ; bank: $000 logical: $efae
          iny     
          cpy     #$05
          bcc     @check_soft_reset
          rts    

gx_unknown_efb4:                        ; bank: $000 logical: $efb4
          .db $01,$02,$04,$08,$10
gx_unknown_efb9:                        ; bank: $000 logical: $efb9
          .db $ff,$00,$02,$01,$04
          .db $ff,$03,$ff,$06,$07
          .db $ff,$ff,$05,$ff,$ff
          .db $ff

gx_display_init:                        ; bank: $000 logical: $efc9
          stz     <gx_scroll_x
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
gx_vdc_init:                            ; bank: $000 logical: $efed
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
@vdc_set_reg:                           ; bank: $000 logical: $f003
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
@vdc_xres_341:                          ; bank: $000 logical: $f01d
          st0     #$0a
          st1     #$02
          st2     #$05
          st0     #$0b
          st1     #$27
          st2     #$04
@skip:                                  ; bank: $000 logical: $f029
          lda     #$e8
          jsr     gx_vdc_set_yres
          plp     
          rts     

gx_vdc_init_table:                      ; bank: $000 logical: $f030
          .db $05,$8e,$03
          .db $06,$00,$00
          .db $07,$00,$00
          .db $08,$00,$00
          .db $09,$40,$00               ; BAT size: 32x64
          .db $0a,$02,$02               ; horizontal resolution: 256px
          .db $0b,$1f,$04
          .db $0f,$01,$00
          .db $13,$00,$08

gx_vce_init:                            ; bank: $000 logical: $f04b
          lda     <$42
          bne     @vce_next_mode
          lda     #$04                  ; blur edges + 5MHz dot clock
          bra     @vce_clear
@vce_next_mode:                         ; bank: $000 logical: $f053
          lda     #$05                  ; blur edges + 7MHz dot clock
@vce_clear:                             ; bank: $000 logical: $f055
          sta     color_ctrl
          stz     color_reg_l           ; clear all palette colors
          stz     color_reg_h           ; well... there's only 512 color entries
          ldx     #$04                  ; but this loops set 4*256=1024 colors to 0.
          cly     
@loop:                                  ; bank: $000 logical: $f061
          stz     color_data_l
          stz     color_data_h
          dey     
          bne     @loop
          dex     
          bne     @loop
          rts     
gx_vdc_enable_display:                  ; bank: $000 logical: $f06e
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$c0
          sta     <vdc_control
          sta     video_data_l
          rts     
gx_vdc_disable_display:                 ; bank: $000 logical: $f07f
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          and     #$3f
          sta     <vdc_control
          sta     video_data_l
          rts     
gx_vdc_set_ctrl_hi:                     ; bank: $000 logical: $f090
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

gx_vdc_vram_auto_inc:                   ; bank: $000 logical: $f0a5
          .db $00,$08,$10,$18

gx_vdc_set_bat_size:                    ; bank: $000 logical: $f0a9
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

gx_vdc_bat_size:                        ; bank: $000 logical: $f0bb
          .db $00,$10,$20,$30,$40,$50,$60,$70

gx_unknown_f0c3:                        ; bank: $000 logical: $f0c3
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
lf0d6_00:                               ; bank: $000 logical: $f0d6
          jsr     gx_vdc_disable_display
          lda     $24c2
          lsr     A
          sta     $24bf
          sta     $24c0
          plp     
          rts     
gx_vdc_set_yres:                        ; bank: $000 logical: $f0e5
          bit     #$01
          beq     @l0
          inc     A
@l0:                                    ; bank: $000 logical: $f0ea
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
          lda     #$0d                  ; Vertical Display Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c2
          sta     video_data_l
          lda     $24c3
          sta     video_data_h
          lda     #$0c                  ; Vertical Synchro Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c6
          sta     video_data_l
          lda     $24c7
          sta     video_data_h
          lda     #$0e                  ; Vertical Display End Position Register
          sta     <vdc_reg
          sta     video_reg_l
          lda     $24c4
          sta     video_data_l
          lda     $24c5
          sta     video_data_h
          lda     #$02                  ; VRAM data register
          sta     <vdc_reg
          sta     video_reg_l
          rts     
;-------------------------------------------------------------------------------
; This routine set BAT entries to $00f0.
; Here it's assumed that the BAT size is 32x64.
;-------------------------------------------------------------------------------
gx_clear_bat:                           ; bank: $000 logical: $f145
          cla                           ; set vram auto-increment to 1.
          jsr     gx_vdc_set_ctrl_hi 
          lda     #$00                  ; set VRAM write pointer to $0000
          sta     <vdc_reg
          sta     video_reg_l
          st1     #$00
          st2     #$00
          lda     #$02                  ; switch to VRAM data register
          sta     <vdc_reg
          sta     video_reg_l
          ldx     #$08
          ldy     #$00                  ; $0800 = 32*64
@l0:                                    ; bank: $000 logical: $f15f
            st1     #$f0
            st2     #$00
            dey     
            bne     @l0
          dex     
          bne     @l0
          rts     

gx_vdc_enable_interrupts:               ; bank: $000 logical: $f16a
          lda     #$05
          sta     <vdc_reg
          sta     video_reg_l
          lda     <vdc_control
          ora     #$0c
          sta     <vdc_control
          sta     video_data_l
          stz     irq_disable
          rts     
gx_vdc_set_control_reg:                 ; bank: $000 logical: $f17e
          lda     #$03
          sta     irq_disable           ; disable IRQ1 and IRQ2
          lda     #$05
          sta     <vdc_reg              ; VDC control register
          sta     video_reg_l
          lda     <vdc_control
          and     #$f3
          sta     <vdc_control
          sta     video_data_l
          rts     
gx_unknown_f194:                        ; bank: $000 logical: $f194
          cly     
lf195_00:                               ; bank: $000 logical: $f195
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
lf1b0_00:                               ; bank: $000 logical: $f1b0
          rts     
lf1b1_00:                               ; bank: $000 logical: $f1b1
          cly     
          ldx     <$06
          beq     lf1c4_00
lf1b6_00:                               ; bank: $000 logical: $f1b6
          lda     [$00], Y
          sta     [$02], Y
          iny     
          bne     lf1c1_00
          inc     <$01
          inc     <$03
lf1c1_00:                               ; bank: $000 logical: $f1c1
          dex     
          bne     lf1b6_00
lf1c4_00:                               ; bank: $000 logical: $f1c4
          lda     <$07
          beq     lf1cc_00
          dec     <$07
          bra     lf1b6_00
lf1cc_00:                               ; bank: $000 logical: $f1cc
          rts     
gx_unknown_f1cd:                        ; bank: $000 logical: $f1cd
          asl     A
          asl     A
          asl     A
          asl     A
          sta     color_reg_l
          cla     
          adc     #$00
          sta     color_reg_h
          rts     
gx_unknown_f1db:                        ; bank: $000 logical: $f1db
          sta     <$02
          lda     #$01
          sta     <$03
          lda     $2303
          clx     
lf1e5_00:                               ; bank: $000 logical: $f1e5
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
lf1f6_00:                               ; bank: $000 logical: $f1f6
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
lf208_00:                               ; bank: $000 logical: $f208
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
lf215_00:                               ; bank: $000 logical: $f215
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
lf22d_00:                               ; bank: $000 logical: $f22d
          lda     #$01
          sta     <$04
          lda     $2302
          clx     
lf235_00:                               ; bank: $000 logical: $f235
          lsr     A
          bcc     lf240_00
          asl     <$04
          inx     
          cpx     #$04
          bcc     lf235_00
          rts     
lf240_00:                               ; bank: $000 logical: $f240
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
lf261_00:                               ; bank: $000 logical: $f261
          lda     $2304, X
          sta     color_reg_l
          lda     $2308, X
          sta     color_reg_h
          lda     $230c, X
          sta     color_data_l
          lda     $2310, X
          sta     color_data_h
          rts     
gx_unknown_f27a:                        ; bank: $000 logical: $f27a
          ldx     #$ff
          lda     $2302
lf27f_00:                               ; bank: $000 logical: $f27f
          beq     lf28b_00
          inx     
          lsr     A
          bcc     lf27f_00
          tay     
          bsr     lf261_00
          tya     
          bra     lf27f_00
lf28b_00:                               ; bank: $000 logical: $f28b
          lda     #$20
          trb     <$11
          stz     $2302
          ldx     #$ff
          lda     $2303
lf297_00:                               ; bank: $000 logical: $f297
          beq     lf2df_00
          inx     
          lsr     A
          bcc     lf297_00
          pha     
          phx     
          lda     $2314, X
          jsr     gx_unknown_f1cd
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
lf2df_00:                               ; bank: $000 logical: $f2df
          lda     #$10
          trb     <$11
          stz     $2303
          jsr     lf3c4_00
          bbs0    <$11, lf2ed_00
          rts     
lf2ed_00:                               ; bank: $000 logical: $f2ed
          bbs1    <$11, lf334_00
          ldy     $239d
          clc     
          ldx     #$03
lf2f6_00:                               ; bank: $000 logical: $f2f6
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
lf334_00:                               ; bank: $000 logical: $f334
          ldy     $239d
          sec     
          ldx     #$03
lf33a_00:                               ; bank: $000 logical: $f33a
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
lf378_00:                               ; bank: $000 logical: $f378
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
lf39d_00:                               ; bank: $000 logical: $f39d
          lda     #$03
          trb     <$11
          rts     
lf3a2_00:                               ; bank: $000 logical: $f3a2
          clx     
          cly     
lf3a4_00:                               ; bank: $000 logical: $f3a4
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
lf3c4_00:                               ; bank: $000 logical: $f3c4
          bbs2    <$11, lf3c8_00
          rts     
lf3c8_00:                               ; bank: $000 logical: $f3c8
          bbs3    <$11, lf40f_00
          ldy     $239e
          clc     
          ldx     #$03
lf3d1_00:                               ; bank: $000 logical: $f3d1
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
lf40f_00:                               ; bank: $000 logical: $f40f
          ldy     $239e
          sec     
          ldx     #$03
lf415_00:                               ; bank: $000 logical: $f415
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
lf453_00:                               ; bank: $000 logical: $f453
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
lf478_00:                               ; bank: $000 logical: $f478
          lda     #$0c
          trb     <$11
          rts     
lf47d_00:                               ; bank: $000 logical: $f47d
          clx     
          cly     
lf47f_00:                               ; bank: $000 logical: $f47f
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
lf49f_00:                               ; bank: $000 logical: $f49f
          lda     #$0f
          trb     <$11
          rts     
lf4a4_00:                               ; bank: $000 logical: $f4a4
          pha     
          lda     #$03
          trb     <$11
          pla     
          sta     $239b
          stz     $2398
          jsr     lf537_00
          ldx     #$0f
          stx     $239d
lf4b8_00:                               ; bank: $000 logical: $f4b8
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
lf4ce_00:                               ; bank: $000 logical: $f4ce
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
lf4e4_00:                               ; bank: $000 logical: $f4e4
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
lf4fa_00:                               ; bank: $000 logical: $f4fa
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
lf518_00:                               ; bank: $000 logical: $f518
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
lf537_00:                               ; bank: $000 logical: $f537
          ldy     #$1f
lf539_00:                               ; bank: $000 logical: $f539
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
lf54e_00:                               ; bank: $000 logical: $f54e
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
lf596_00:                               ; bank: $000 logical: $f596
          ora     #$80
          sta     video_data_l
          st2     #$f0
          rts     
lf59e_00:                               ; bank: $000 logical: $f59e
          cly     
lf59f_00:                               ; bank: $000 logical: $f59f
          lda     [$00], Y
          beq     lf5a9_00
          jsr     lf596_00
          iny     
          bpl     lf59f_00
lf5a9_00:                               ; bank: $000 logical: $f5a9
          rts     
lf5aa_00:                               ; bank: $000 logical: $f5aa
          pha     
          lsr     A
          lsr     A
          lsr     A
          lsr     A
          tay     
          lda     $f5ea, Y
          jsr     lf596_00
          pla     
lf5b7_00:                               ; bank: $000 logical: $f5b7
          and     #$0f
          tay     
          lda     $f5ea, Y
          jmp     lf596_00
lf5c0_00:                               ; bank: $000 logical: $f5c0
          cly     
lf5c1_00:                               ; bank: $000 logical: $f5c1
          cmp     #$64
          bcc     lf5ca_00
          iny     
          sbc     #$64
          bra     lf5c1_00
lf5ca_00:                               ; bank: $000 logical: $f5ca
          pha     
          lda     $f5ea, Y
          jsr     lf596_00
          pla     
          cly     
lf5d3_00:                               ; bank: $000 logical: $f5d3
          cmp     #$0a
          bcc     lf5dc_00
          iny     
          sbc     #$0a
          bra     lf5d3_00
lf5dc_00:                               ; bank: $000 logical: $f5dc
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
lf5fa_00:                               ; bank: $000 logical: $f5fa
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
lf622_00:                               ; bank: $000 logical: $f622
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
lf639_00:                               ; bank: $000 logical: $f639
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
lf654_00:                               ; bank: $000 logical: $f654
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
lf668_00:                               ; bank: $000 logical: $f668
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
lf683_00:                               ; bank: $000 logical: $f683
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
lf696_00:                               ; bank: $000 logical: $f696
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
lf6aa_00:                               ; bank: $000 logical: $f6aa
          jmp     lf6f2_00
lf6ad_00:                               ; bank: $000 logical: $f6ad
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
lf6d3_00:                               ; bank: $000 logical: $f6d3
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
lf6f2_00:                               ; bank: $000 logical: $f6f2
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
lf79e_00:                               ; bank: $000 logical: $f79e
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
lf7c5_00:                               ; bank: $000 logical: $f7c5
          brk     
          brk     
lf7c7_00:                               ; bank: $000 logical: $f7c7
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
lf7e3_00:                               ; bank: $000 logical: $f7e3
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
lf7ff_00:                               ; bank: $000 logical: $f7ff
          sec     
          lda     <$06
          sbc     <$08
          lda     <$07
          sbc     <$09
          bcs     lf81f_00
lf80a_00:                               ; bank: $000 logical: $f80a
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
lf81f_00:                               ; bank: $000 logical: $f81f
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
lf834_00:                               ; bank: $000 logical: $f834
          lda     <$08
          asl     A
          asl     A
          asl     A
          ora     <$06
          tay     
          lda     gx_unknown_data_00, Y
          sta     <$00
          lda     <$04
          bmi     lf857_00
          lda     <$05
          bmi     lf84f_00
          lda     #$20
          clc     
          adc     <$00
          rts     
lf84f_00:                               ; bank: $000 logical: $f84f
          lda     #$40
          sec     
          sbc     <$00
          and     #$3f
          rts     
lf857_00:                               ; bank: $000 logical: $f857
          lda     <$05
          bmi     lf861_00
          lda     #$20
          sec     
          sbc     <$00
          rts     
lf861_00:                               ; bank: $000 logical: $f861
          lda     <$00
          rts     
          
gx_unknown_data_00:                     ; bank: $000 logical: $f864
          .db $10,$10,$10,$10,$10,$10,$10,$10
          .db $00,$08,$0b,$0c,$0d,$0d,$0e,$0e
          .db $00,$04,$08,$0a,$0b,$0c,$0c,$0d
          .db $00,$03,$05,$08,$09,$0a,$0b,$0b
          .db $00,$02,$04,$06,$08,$09,$0a,$0a
          .db $00,$02,$04,$05,$07,$08,$09,$0a
          .db $00,$02,$03,$05,$06,$07,$08,$09
          .db $00,$01,$03,$04,$05,$06,$07,$08

;-------------------------------------------------------------------------------
; Main routine
;-------------------------------------------------------------------------------
gx_main:                                ; bank: $000 logical: $f8a4
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
          jsr     gx_vdc_clear_satb
          jsr     gx_vdc_enable_interrupts
          cli     
          lda     $18c1                         ; check if the game is running on a Super CDRom 2
          cmp     #$aa
          bne     @not_scd2
          lda     $18c2
          cmp     #$55
          bne     @not_scd2
          lda     #$aa                          ; this is a Super CDRom 2
          sta     $18c0
          lda     #$55
          sta     $18c0
          lda     #$68                          ; Super CDROM 2 has 64 KB of extra RAM starging at segment $80
          sta     $2204                         ; and 192 KB starting at $64
          lda     #$20                          ; so there's a total of 256KB of extram (32x8KB)
          sta     $2205
          bra     @l0
@not_scd2:                              ; bank: $000 logical: $f8eb
          lda     #$80                          ; here it assumes it is an IFU-30 (weird things will happen on a stock pcengine) 
          sta     $2204                         ; extra work RAM starts at segment $80
          lda     #$08
          sta     $2205                         ; and it's 64 KB (8x8KB)
@l0:                                    ; bank: $000 logical: $f8f5
          lda     #$01
          tam     #$06
          jsr     gx_load_gfx_data
lf8fc_00:                               ; bank: $000 logical: $f8fc
          jsr     gx_cd_reset
          jsr     gx_main_screen
          jsr     gx_adpcm_reset
          cla     
          jsr     gx_write_cd_fade_timer
lf909_00:                               ; bank: $000 logical: $f909
          jsr     gx_cd_reset
lf90c_00:                               ; bank: $000 logical: $f90c
          jsr     gx_unknown_e245
          bcc     lf918_00
          lda     #$1e
          jsr     gx_unknown_e9e4
          bra     lf90c_00
lf918_00:                               ; bank: $000 logical: $f918
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
          jsr     gx_cd_dinfo
          tst     #$04, $223f
          bne     lf93a_00
          jmp     lf96e_00
lf93a_00:                               ; bank: $000 logical: $f93a
          jsr     gx_unknown_fe3c
          bpl     lf942_00
          jmp     lf96e_00
lf942_00:                               ; bank: $000 logical: $f942
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
lf96e_00:                               ; bank: $000 logical: $f96e
          lda     #$01
          tam     #$06
          jsr     gx_error_msg          ; display error message
          jmp     lf8fc_00              ; "reset" after a while

gx_boot:                                ; bank: $000 logical: $f978
          .db "BOOT"
          .dw gx_menu
          .db $40
          .db $80
gx_menu:                                ; bank: $000 logical: $f980
          jsr     gx_unknown_ed7f
          jsr     gx_unknown_e9e2
          jmp     gx_menu
;-------------------------------------------------------------------------------
; Clears the SATB at $0800
;-------------------------------------------------------------------------------
gx_vdc_clear_satb:                      ; bank: $000 logical: $f989
          stz     <$46
          stz     <$47
          stz     <$48
          stz     <$49
          stz     <$4a
          jmp     gx_vdc_clear_satb_2
;-------------------------------------------------------------------------------
;
;-------------------------------------------------------------------------------
gx_vdc_clear_satb_2:                    ; bank: $000 logical: $f996
          ldx     #$0f
          lda     #$ff
lf99a_00:                               ; fill 2791 to 27a1 with ff
          sta     $2791, X
          dex     
          bpl     lf99a_00
          stz     <$4b
          stz     <$4c
          stz     <$4d
          lda     #$05
          sta     vdc_reg
          sta     video_reg_l           ; sprite collision + scanline interrupt = ON, vertical blanking interrupt = OFF
          lda     vdc_control+1
          and     #$e7
          sta     vdc_control+1
          sta     video_data_h
          lda     #$00                  ; VRAM write pointer
          sta     vdc_reg
          sta     video_reg_l
          st1     #$00                  ; set VRAM write pointer to SATB
          st2     #$08
          lda     #$02                  ; VRAM data register
          sta     vdc_reg
          sta     video_reg_l
          ldx     #$80                          
          ldx     #$00                  ; clear whole SATB entries
@loop:                                  ; bank: $000 logical: $f9d1
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00                  ; 32 bytes = 1 SATB entry
          dex     
          bne     @loop
          rts    

; input : A
;
lf9e5_00:                               ; bank: $000 logical: $f9e5
          stz     <$06
          stz     <$07
          stz     <$08
          stz     <$09
lf9ed_00:                               ; bank: $000 logical: $f9ed
          cmp     #$10
          bcc     lf9f5_00              ; while A < 16
          lsr     A                     ;   A >>= 1
          jmp     lf9ed_00
lf9f5_00:                               ; bank: $000 logical: $f9f5
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
lfa14_00:                               ; bank: $000 logical: $fa14
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
lfa2b_00:                               ; bank: $000 logical: $fa2b
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
lfa61_00:                               ; bank: $000 logical: $fa61
          rts   
;-------------------------------------------------------------------------------
; update SATB
;-------------------------------------------------------------------------------
lfa62_00:                               ; bank: $000 logical: $fa62
          stz     $2790
          ldx     #$0f
          lda     #$00
          sta     vdc_reg               ; set VRAM write pointer
          sta     video_reg_l
          inc     <$4a
          lda     <$4a
          lsr     A
          lda     #$08                  ; SATB is alternatively set between $0800 and $0900.
          adc     #$00
          st1     #$00
          sta     video_data_h
          lda     <$49
          lsr     A
          bcc     lfab5_00
          lda     #$02                  ; set VRAM write latch
          sta     vdc_reg
          sta     video_reg_l
lfa8a_00:                               ; bank: $000 logical: $fa8a
          ldy     $2791, X
          bmi     lfaa0_00
          ldy     $27a1, X
lfa92_00:                               ; bank: $000 logical: $fa92
          phx     
          jsr     lfaf3_00
          plx     
          lda     $2710, Y
          tay     
          bpl     lfa92_00
          sta     $2791, X
lfaa0_00:                               ; bank: $000 logical: $faa0
          dex     
          bpl     lfa8a_00
          lda     <$4a
          and     #$01
          tax     
          lda     <$4b
          tay     
          sec     
          sbc     <$4c, X
          sty     <$4c, X
          stz     <$4b
          bcc     lfae5_00
          rts     

lfab5_00:                               ; bank: $000 logical: $fab5
          lda     #$02
          sta     vdc_reg
          sta     video_reg_l
lfabd_00:                               ; bank: $000 logical: $fabd
          ldy     $2791, X
          bmi     lfad0_00
lfac2_00:                               ; bank: $000 logical: $fac2
          phx     
          jsr     lfaf3_00
          plx     
          lda     $2750, Y
          tay     
          bpl     lfac2_00
          sta     $2791, X
lfad0_00:                               ; bank: $000 logical: $fad0
          dex     
          bpl     lfabd_00
          lda     <$4a
          and     #$01
          tax     
          lda     <$4b
          tay     
          sec     
          sbc     <$4c, X
          sty     <$4c, X
          stz     <$4b
          bcc     lfae5_00
          rts     
lfae5_00:                               ; bank: $000 logical: $fae5
          asl     A
          tay     
lfae7_00:                               ; bank: $000 logical: $fae7
          st1     #$00
          st2     #$00
          st1     #$00
          st2     #$00
          dey     
          bne     lfae7_00
          rts    


lfaf3_00:                               ; bank: $000 logical: $faf3
          sxy     
          lda     $2690, X
          sta     <$00
          lda     $26d0, X
          sta     <$01
          ldy     #$01
          lda     [$00]
          beq     lfb59_00
          sta     <$06                  ; entry count
lfb06_00:                               ; bank: $000 logical: $fb06
          lda     <$4b
          cmp     #$40
          bcs     lfb5a_00              ; set SATB entry
          inc     <$4b
          lda     [$00], Y
          iny     
          adc     $24d0, X
          sta     video_data_l          ; Y LSB
          lda     [$00], Y
          iny     
          adc     $2510, X
          sta     video_data_h          ; Y MSB
          lda     [$00], Y
          iny     
          clc     
          adc     $2550, X
          sta     video_data_l          ; X LSB
          lda     [$00], Y
          iny     
          adc     $2590, X
          sta     video_data_h          ; X MSB
          lda     [$00], Y
          iny     
          adc     $25d0, X
          sta     video_data_l          ; Pattern address MSB
          lda     [$00], Y
          iny     
          adc     $2610, X
          sta     video_data_h          ; Pattern address LSB
          lda     [$00], Y
          iny     
          clc     
          adc     $2650, X
          sta     video_data_l          ; Palette index + priority
          lda     [$00], Y
          iny     
          sta     video_data_h          ; Width + horizontal flip + height + vertical flip
          dec     <$06
          bne     lfb06_00
lfb59_00:                               ; bank: $000 logical: $fb59
          clc     
lfb5a_00:                               ; bank: $000 logical: $fb5a
          sxy     
          rts    

lfb5c_00:                               ; bank: $000 logical: $fb5c
          lda     <$50
          sta     $27b5
          lda     <$51
          sta     $27b6
lfb66_00:                               ; bank: $000 logical: $fb66
          lda     #$ff
          jsr     lfbf5_00
          bsr     lfbb7_00
          beq     lfb86_00
          cmp     $27b6
          bne     lfb7b_00
          lda     <$4e
          cmp     $27b5
          beq     lfb86_00
lfb7b_00:                               ; bank: $000 logical: $fb7b
          lda     <$4e
          sta     <$50
          lda     <$4f
          sta     <$51
          jmp     lfb66_00
lfb86_00:                               ; bank: $000 logical: $fb86
          lda     $27b5
          sta     <$50
          lda     $27b6
          sta     <$51
lfb90_00:                               ; bank: $000 logical: $fb90
          jsr     lfbc3_00
          bit     #$08
          bne     lfbaf_00
          bit     #$10
          beq     lfba1_00
          bsr     lfbb3_00
          beq     lfb90_00
          bra     lfba5_00
lfba1_00:                               ; bank: $000 logical: $fba1
          bsr     lfbb7_00
          beq     lfb90_00
lfba5_00:                               ; bank: $000 logical: $fba5
          lda     <$4e
          sta     <$50
          lda     <$4f
          sta     <$51
          bra     lfb90_00
lfbaf_00:                               ; bank: $000 logical: $fbaf
          lda     $27b7
          rts     
lfbb3_00:                               ; bank: $000 logical: $fbb3
          ldy     #$07
          bra     lfbb9_00
lfbb7_00:                               ; bank: $000 logical: $fbb7
          ldy     #$09
lfbb9_00:                               ; bank: $000 logical: $fbb9
          lda     [$50], Y
          sta     <$4e
          iny     
          lda     [$50], Y
          sta     <$4f
          rts     
lfbc3_00:                               ; bank: $000 logical: $fbc3
          lda     $2033
          and     #$10
          jsr     lfbf5_00
          lda     #$01
          jsr     gx_unknown_e9e4
          lda     [$4e]
          tay     
          lda     gx_joytrg
          bit     #$58
          bne     lfbea_00
          bit     #$24
          beq     lfbdf_00
          iny     
lfbdf_00:                               ; bank: $000 logical: $fbdf
          bit     #$80
          beq     lfbe4_00
          dey     
lfbe4_00:                               ; bank: $000 logical: $fbe4
          tya     
          sta     [$4e]
          jmp     lfbc3_00
lfbea_00:                               ; bank: $000 logical: $fbea
          pha     
          lda     #$ff
          jsr     lfbf5_00
          ldy     $27b7
          pla     
          rts     
lfbf5_00:                               ; bank: $000 logical: $fbf5
          pha     
          ldy     #$05
          lda     [$50], Y              ; load ?? lsb to $204e
          sta     <$4e
          iny     
          lda     [$50], Y              ; load ?? msb to $204f
          sta     <$4f
          ldy     #$0d
          lda     [$50], Y              ; load ?? to $27b7
          sta     $27b7
          ldy     #$03
          lda     [$50], Y              ; load ?? to $27b3
          sta     $27b3
          iny     
          lda     [$50], Y              ; load ?? to $27b4
          sta     $27b4
          lda     [$4e]
          bmi     lfc28_00
          cmp     $27b3
          bcc     lfc28_00
          cmp     $27b4
          bcc     lfc2c_00
          lda     $27b3
          bra     lfc2c_00
lfc28_00:                               ; bank: $000 logical: $fc28
          lda     $27b4
          dec     A
lfc2c_00:                               ; bank: $000 logical: $fc2c
          sta     [$4e]
          ldy     #$01
          lda     [$50]
          tax     
          lda     [$50], Y
          jsr     lf5fa_00
          lda     <$50
          sta     <$00
          lda     <$51
          sta     <$01
          clc     
          lda     <$00
          adc     #$0e
          sta     <$00
          lda     <$01
          adc     #$00
          sta     <$01
          pla     
          beq     lfc55_00
          jsr     lf59e_00
          bra     lfc58_00
lfc55_00:                               ; bank: $000 logical: $fc55
          jsr     lfcbe_00
lfc58_00:                               ; bank: $000 logical: $fc58
          ldy     #$05
          lda     [$50], Y
          sta     <$4e
          iny     
          lda     [$50], Y
          sta     <$4f
          ldy     #$02
          lda     [$50], Y
          beq     lfc84_00
          ldy     #$0b
          lda     [$50], Y
          sta     <$04
          iny     
          lda     [$50], Y
          sta     <$05
          lda     [$4e]
          asl     A
          tay     
          lda     [$04], Y
          sta     <$00
          iny     
          lda     [$04], Y
          sta     <$01
          jmp     lf59e_00
lfc84_00:                               ; bank: $000 logical: $fc84
          lda     #$20
          sta     $27b1
          lda     [$4e]
          ldx     #$64
          stx     $27b2
          jsr     lfc9f_00
          ldx     #$0a
          stx     $27b2
          jsr     lfc9f_00
          jsr     lfcb0_00
          rts     
lfc9f_00:                               ; bank: $000 logical: $fc9f
          clx     
lfca0_00:                               ; bank: $000 logical: $fca0
          sec     
          sbc     $27b2
          bcc     lfca9_00
          inx     
          bra     lfca0_00
lfca9_00:                               ; bank: $000 logical: $fca9
          adc     $27b2
          sax     
          tay     
          beq     lfcb5_00
lfcb0_00:                               ; bank: $000 logical: $fcb0
          ldy     #$30
          sty     $27b1
lfcb5_00:                               ; bank: $000 logical: $fcb5
          clc     
          adc     $27b1
          jsr     lf596_00
          sax     
          rts     
lfcbe_00:                               ; bank: $000 logical: $fcbe
          cly     
lfcbf_00:                               ; bank: $000 logical: $fcbf
          lda     [$00], Y
          bne     lfcc4_00
          rts     
lfcc4_00:                               ; bank: $000 logical: $fcc4
          lda     #$20
          jsr     lf596_00
          iny     
lfcca_00:                               ; bank: $000 logical: $fcca
          bra     lfcbf_00

gx_yes_no_tbl:                          ; bank: $000 logical: $fccc
          .dw gx_msg_no
          .dw gx_msg_yes

gx_msg_no:                              ; bank: $000 logical: $fcd0
          db " NO",$00
gx_msg_yes:                             ; bank: $000 logical: $fcd4 
          db "YES",$00 

gx_on_off_tbl:                          ; bank: $000 logical: $fcd8
          .dw $fce0
          .dw $fcdc

gx_msg_on:                              ; bank: $000 logical: $fcdc
          db " ON",$00
gx_msg_off:                             ; bank: $000 logical: $fce0
          db "OFF",$00 
;-------------------------------------------------------------------------------
; Decode packed data.
;
; Parameters:
;   $27ba - source bank
;   $2054 - source address LSB 
;   $2055 - source address MSB (mapped to mpr 2)
;   $2052 - destination address LSB 
;   $2053 - destination address MSB
;-------------------------------------------------------------------------------
gx_unpack:                              ; bank: $000 logical: $fce4
          lda     <$55
@remap.src.00:                          ; remap pointer
          cmp     #$60
          bcc     @remap.src.01
          sbc     #$20
          inc     $27ba                 ; next page/bank
          bra     @remap.src.00
@remap.src.01:
          sta     <$55
          tma     #$02                  ; save mpr 2
          sta     $27bb
          tma     #$03                  ; save mpr 3
          sta     $27bc
          lda     $27ba                 ; map source page to mpr 2 and 3
          tam     #$02
          inc     A
          tam     #$03
          lda     [$54]                 ; $27b8 = [$54]
          sta     $27b8                 ; encoded sequence count
          inc     <$54                  ; increment source pointer
          bne     @l0
          inc     <$55
@l0:
          clx     
@decode:                                ; remap source pointer if nedeed
          lda     <$55
          cmp     #$60
          bcc     @no.remap
          sbc     #$20
          sta     <$55
          tma     #$03
          tam     #$02
          inc     A
          tam     #$03
@no.remap:                              ; bank: $000 logical: $fd22
          lda     [$54]
          cmp     #$ff
          beq     @skip                 ; $ff: empty sequence
          bit     #$80
          beq     @other                ; raw copy or incremental sequence
          bit     #$40
          beq     @rle.b                ; the data is rle encoded (either word or byte)
          jmp     @rle.w
@skip:
          inc     <$54                  ; increment source pointer
          bne     @l1
          inc     <$55
@l1:                                    ; bank: $000 logical: $fd39
          dec     $27b8
          bne     @decode               ; loop until there is something to decode
          lda     $27bb                 ; restore mpr 2
          tam     #$02
          lda     $27bc                 ; restore mpr 3
          tam     #$03
          rts     
@other:                                 ; bank: $000 logical: $fd49
          bit     #$40
          bne     @sequence
          and     #$3f                  ; count
          tax     
          inc     <$54                  ; incremement source pointer
          bne     @l1
          inc     <$55
@l1:                                    ; bank: $000 logical: $fd56
          cly     
@raw.loop:                              ; bank: $000 logical: $fd57
          lda     [$54], Y
          sta     [$52], Y
          iny     
          dex     
          bne     @raw.loop
          clc                           ; update destination pointer (dest += count)
          tya     
          adc     <$54
          sta     <$54
          bcc     @raw.l0
          inc     <$55
@raw.l0:                                ; bank: $000 logical: $fd69
          clc                           ; update source pointer (src += count)
          tya     
          adc     <$52
          sta     <$52
          bcc     @raw.l1
          inc     <$53
@raw.l1:                                ; bank: $000 logical: $fd73
          jmp     @decode
@rle.b:                                 ; bank: $000 logical: $fd76
          and     #$3f
          tax                           ; count
          ldy     #$01
          lda     [$54], Y              ; value
          cly     
@rle.b.loop:                            ; bank: $000 logical: $fd7e
          sta     [$52], Y
          iny     
          dex     
          bne     @rle.b.loop
          clc                           ; move source pointer past count+value
          lda     <$54
          adc     #$02
          sta     <$54
          lda     <$55
          adc     #$00
          sta     <$55
          clc                           ; update destination pointer (dest += count)
          tya     
          adc     <$52
          sta     <$52
          bcc     @rle.b.l0
          inc     <$53
@rle.b.l0:                              ; bank: $000 logical: $fd9b
          jmp     @decode
@sequence:                              ; bank: $000 logical: $fd9e
          and     #$3f                  ; count
          tax     
          ldy     #$01
          lda     [$54], Y              ; sequence start lsb
          sta     <$56
          iny     
          lda     [$54], Y              ; sequence start msb
          sta     <$57
          clc                           ; source pointer += 3
          lda     <$54
          adc     #$03
          sta     <$54
          lda     <$55
          adc     #$00
          sta     <$55
          cly     
@sequence.loop:                         ; bank: $000 logical: $fdba
          lda     <$56                  ; [destination] = sequence++
          sta     [$52], Y
          iny     
          lda     <$57
          sta     [$52], Y
          iny     
          inc     <$56
          bne     @sequence.l0
          inc     <$57
@sequence.l0:                           ; bank: $000 logical: $fdca
          dex     
          bne     @sequence.loop
          clc     
          clc                           ; update destination pointer (dest += 2*count)
          tya     
          adc     <$52
          sta     <$52
          bcc     @sequence.l1
          inc     <$53
@sequence.l1:                           ; bank: $000 logical: $fdd8
          jmp     @decode
@rle.w:                                 ; bank: $000 logical: $fddb
          and     #$3f                  ; count
          tax     
          ldy     #$01                  ; value lsb
          lda     [$54], Y
          sta     <$56
          iny     
          lda     [$54], Y              ; value msb
          sta     <$57
          clc     
          lda     <$54                  ; move pointer past count+value
          adc     #$03
          sta     <$54
          lda     <$55
          adc     #$00
          sta     <$55
          cly                           ; copy X times the word to destination
@rle.w.loop:                            ; bank: $000 logical: $fdf7
          lda     <$56
          sta     [$52], Y
          iny     
          lda     <$57
          sta     [$52], Y
          iny     
          dex     
          bne     @rle.w.loop
          clc                           ; update destination pointer (dest += 2*count)
          tya     
          adc     <$52
          sta     <$52
          bcc     @rle.w.l0
          inc     <$53
@rle.w.l0:                              ; bank: $000 logical: $fe0e
          jmp     @decode

;-------------------------------------------------------------------------------
; byte size to sector count
; input: 
;    $200a-$200d contains a 32 bits value.
; output: 
;    $200b sector count MSB
;    $200a sector count LSB
;        A sector count LSB
;-------------------------------------------------------------------------------
lfe11_00:                               ; bank: $000 logical: $fe11
          clc     
          lda     <$0a                  ; add 2047 to the 32 bit value
          adc     #$ff
          sta     <$0a
          lda     <$0b
          adc     #$07
          sta     <$0b
          bcc     lfe26_00
          inc     <$0c
          bne     lfe26_00
          inc     <$0d
lfe26_00: 
          ldx     #$04                  ; multiply by 32
lfe28_00:
          asl     <$0a
          rol     <$0b
          rol     <$0c
          rol     <$0d
          dex     
          bpl     lfe28_00
          lda     <$0d                  ; as 2048*32 = 65536, getting the 2 upper bytes will give us the sector count
          sta     <$0b
          lda     <$0c
          sta     <$0a
          rts     

; return:
;  A - $ff = error
gx_unknown_fe3c:                        ; bank: $000 logical: $fe3c
          lda     #$80
          sta     $2021
          tam     #$02
          inc     A
          tam     #$03
          inc     A
          tam     #$04
          inc     A
          tam     #$05
          stz     $2026                 ; sector mid ?
          stz     $2027                 ; sector hi ?
          lda     #$10
          sta     $2025                 ; sector lo ?
          lda     #$01
          sta     $2023                 ; sector count ?
          jsr     gx_unknown_e33a       ; read sector routine ?
          ldx     #$04
lfe61_00:                               ; bank: $000 logical: $fe61
          lda     gx_iso9660_id, X      ; check for primary volume descriptor identifier
          cmp     $4001, X
          beq     lfe6c_00
          jmp     lff27_00
lfe6c_00:                               ; bank: $000 logical: $fe6c
          dex     
          bpl     lfe61_00
          tii     $409e, $2025, $0003   ; location of the extent (LBA) (little endian).
          tii     $40a6, $200a, $0004   ; data length (size of the extent) (little endian)
          jsr     lfe11_00              ; byte size to sector count?
          sta     $2023 
          lda     #$80
          sta     $2021
          jsr     gx_unknown_e33a       ; read root dir extent
          lda     #$00
          sta     <$00
          lda     #$40
          sta     <$01
          lda     #$bd
          sta     <$02
          lda     #$27
          sta     <$03
lfe9b_00:                               ; bank: $000 logical: $fe9b
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
lfeaf_00:                               ; bank: $000 logical: $feaf
          sta     <$08
          clx     
          iny     
lfeb3_00:                               ; bank: $000 logical: $feb3
          cla     
          cpx     <$08
          bcs     lfeba_00
          lda     [$00], Y
lfeba_00:                               ; bank: $000 logical: $feba
          sta     [$02]
          inc     <$02
          bne     lfec2_00
          inc     <$03
lfec2_00:                               ; bank: $000 logical: $fec2
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
lfed4_00:                               ; bank: $000 logical: $fed4
          iny     
          lda     [$00], Y
          sta     [$02]
          inc     <$02
          bne     lfedf_00
          inc     <$03
lfedf_00:                               ; bank: $000 logical: $fedf
          iny     
          lda     [$00], Y
          sta     [$02]
          inc     <$02
          bne     lfeea_00
          inc     <$03
lfeea_00:                               ; bank: $000 logical: $feea
          ldy     #$0a
          clx     
lfeed_00:                               ; bank: $000 logical: $feed
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
lff02_00:                               ; bank: $000 logical: $ff02
          lda     <$06
          clc     
          adc     <$00
          sta     <$00
          cla     
          adc     <$01
          sta     <$01
          bra     lfe9b_00
lff10_00:                               ; bank: $000 logical: $ff10
          lda     #$ff
          sta     [$02]
          inc     <$02
          bne     lff1a_00
          inc     <$03
lff1a_00:                               ; bank: $000 logical: $ff1a
          lda     <$02
          sta     $2265
          lda     <$03
          sta     $2266
          lda     #$00
          rts     
lff27_00:                               ; bank: $000 logical: $ff27
          lda     #$ff
          rts    

gx_iso9660_id:                          ; bank: $000 logical: $ff2a
          db "CD001"

gx_unknown_ff2f:                        ; bank: $000 logical: $ff2f
          lda     #$bd
          sta     <$02
          lda     #$27
          sta     <$03
lff37_00:                               ; bank: $000 logical: $ff37
          lda     [$02]
          bmi     lff58_00
          cly     
lff3c_00:                               ; bank: $000 logical: $ff3c
          lda     [$00], Y
          cmp     [$02], Y
          bne     lff49_00
          iny     
          cpy     #$04
          beq     lff5b_00
          bra     lff3c_00
lff49_00:                               ; bank: $000 logical: $ff49
          clc     
          lda     <$02
          adc     #$08
          sta     <$02
          lda     <$03
          adc     #$00
          sta     <$03
          bra     lff37_00
lff58_00:                               ; bank: $000 logical: $ff58
          lda     #$ff
          rts     
lff5b_00:                               ; bank: $000 logical: $ff5b
          lda     [$02], Y
          sta     $2025
          iny     
          lda     [$02], Y
          sta     $2026
          iny     
          lda     [$02], Y
          sta     $2027
          iny     
          lda     [$02], Y
          sta     $2023
          lda     #$00
          rts     
gx_unknown_ff75:                        ; bank: $000 logical: $ff75
          jsr     gx_unknown_ff2f
          bmi     lff7d_00
          jsr     gx_unknown_e33a
lff7d_00:                               ; bank: $000 logical: $ff7d
          rts     
   

	.data
	.bank $000
	.org $fff6
irq_vectors:                            ; bank: $000 logical: $fff6
          .dw gx_irq_2
          .dw gx_irq_1
          .dw gx_irq_timer
          .dw gx_irq_nmi
          .dw gx_irq_reset

	.code
	.bank $001
	.org $c000
gx_load_gfx_data:                                       ; bank: $001 logical: $c000
          jsr     gx_vdc_disable_display
          stz     <gx_scroll_x                          ; reset scrolling coordinates
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
          sta     $22c7                                 ; bank: $01
          lda     #$00
          sta     $22c1
          lda     #$10
          sta     $22c2                                 ; VRAM destination: $1000
          lda     #$5f
          sta     <$3a
          lda     #$4d
          sta     <$3b                                  ; source: $4d5f
          jsr     gx_vdc_load_vram
          jsr     gx_vdc_enable_display
          rts     

;-------------------------------------------------------------------------------
; Display a blinking "ERROR" sprite for 
;-------------------------------------------------------------------------------
gx_error_msg:                           ; bank: $001 logical: $c053
          jsr     gx_unknown_e9e2
          jsr     gx_vdc_clear_satb_2
          jsr     gx_unknown_e9e2
          ldx     #$0a                  ; make the error message blink for 5 seconds (10 * (10 + 20) frames)
@loop:                                  ; bank: $001 logical: $c05e
          phx     
          jsr     gx_vdc_clear_satb_2
          lda     #$0a
          jsr     gx_unknown_e9e4       ; wait for 10 frames
          lda     #low(gx_error_satb)
          sta     <$00
          lda     #high(gx_error_satb)
          sta     <$01
          jsr     lf9e5_00
          jsr     lfa62_00              ; update SATB
          lda     #$14
          jsr     gx_unknown_e9e4       ; wait for 20 frames
          plx     
          dex     
          bpl     @loop
          rts     

;-------------------------------------------------------------------------------
; Display atlernatively 3 sprites and "boot" cdrom when the user presses RUN.
;-------------------------------------------------------------------------------
gx_main_screen:                             ; bank: $001 logical: $c07f
          ldx     #high(gx_main_screen_proc)
          ldy     #low(gx_main_screen_proc) ; [todo] what's at $c099?
          jsr     gx_proc_load
          pha     
@wait_run:                                  ; wait for run button o be pressed.
          jsr     gx_unknown_e9e2
          lda     gx_joytrg                 ; get joypad 0 state
          and     #$08                      ; check if RUN bit is set
          beq     @wait_run
          plx     
          jsr     gx_unknown_e9d7
          jsr     gx_vdc_clear_satb_2
          rts     

gx_main_screen_proc:                        ; bank: $001 logical: $c099
          .dw gx_main_screen_anim
          .db $80
          .db $80
;-------------------------------------------------------------------------------
; Main screen animation.
; Displays alternatively "set a disk", "and", "push run button" sprites.
;-------------------------------------------------------------------------------     
gx_main_screen_anim:                    ; bank: $001 logical: $c09d
          jsr     gx_vdc_clear_satb_2
          jsr     gx_unknown_e9e2
          jsr     lfa62_00
          lda     #$05
          jsr     gx_unknown_e9e4
lc0ab_01:                               ; bank: $001 logical: $c0ab
          lda     #low(gx_set_a_disk_satb)
          sta     <$00
          lda     #high(gx_set_a_disk_satb)
          sta     <$01                  ; c0f2 (set a disk)
          cla     
          jsr     lf9e5_00              
          jsr     lfa62_00              ; update SATB
          lda     #$1e
          jsr     gx_unknown_e9e4

          lda     #low(gx_and_satb)
          sta     <$00
          lda     #high(gx_and_satb)
          sta     <$01                  ; c10b (and)
          cla     
          jsr     lf9e5_00
          jsr     lfa62_00
          lda     #$1e
          jsr     gx_unknown_e9e4

          lda     #low(gx_push_run_button_satb)
          sta     <$00
          lda     #high(gx_push_run_button_satb)
          sta     <$01                  ; c11c (push run button)
          cla     
          jsr     lf9e5_00
          jsr     lfa62_00
          lda     #$1e
          jsr     gx_unknown_e9e4

          jsr     lfa62_00
          lda     #$14
          jsr     gx_unknown_e9e4       ; (clear)
          jmp     lc0ab_01

gx_set_a_disk_satb:                     ; bank: $001 logical: $c0f2
          .db $03                       ; 3 SATB entries
          .db $d0                       ; entry #0: Y LSB (208)
          .db $00                       ;           Y MSB
          .db $30                       ;           X LSB (48)
          .db $00                       ;           X MSB
          .db $80                       ;           Pattern address MSB ($280 => $5000)
          .db $02                       ;           Pattern address LSB
          .db $80                       ;           Palette index (0) + prioriry (foreground) 
          .db $31                       ;           Width (32) + horizontal flip (normal) + height (64) + vertical flip (normal)
          .db $d0                       ; entry #1  (Y: 208)
          .db $00
          .db $50                       ;           (X: 80)
          .db $00
          .db $a0                       ;           (Pattern: $2a0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $31                       ;           (W: 32, HFlip: normal, H:64, VFlip: Normal)
          .db $d0                       ; entry #2  (Y: 208)
          .db $00
          .db $70                       ;           (X: 112)
          .db $00
          .db $c0                       ;           (Pattern: $2c0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $30                       ;           (W: 16, HFlip: normal, H:64, VFlip: Normal)

gx_and_satb:                            ; bank: $001 logical: $c10b
          .db $02                       ; 2 SATB entries
          .db $f0                       ; entry #0  (Y: 240)
          .db $00
          .db $80                       ;           (X: 128)
          .db $00
          .db $c2                       ;           (Pattern: $2c2)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $10                       ;           (W: 16, HFlip: normal, H:32, VFlip: Normal)
          .db $f0                       ; entry #1  (Y: 240)
          .db $00
          .db $90                       ;           (X: 144)
          .db $00
          .db $e0                       ;           (Pattern: $2e0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)

gx_push_run_button_satb:                ; bank: $001 logical: $c11c
          .db $03                       ; 3 SATB entries
          .db $d0                       ; entry #0  (Y: 208)
          .db $00
          .db $a0                       ;           (X: 160)
          .db $00
          .db $90                       ;           (Pattern: $290)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $31                       ;           Width (32) + horizontal flip (normal) + height (64) + vertical flip (normal)
          .db $d0                       ; entry #1  (Y: 208)
          .db $00
          .db $c0                       ;           (X: 192)
          .db $00
          .db $b0                       ;           (Pattern: $2b0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $31                       ;           Width (32) + horizontal flip (normal) + height (64) + vertical flip (normal)
          .db $d0                       ; entry #2  (Y: 208)
          .db $00
          .db $e0                       ;           (X: 224)
          .db $00
          .db $d0                       ;           (Pattern: $2d0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $31                       ;           Width (32) + horizontal flip (normal) + height (64) + vertical flip (normal)

          .db $00                       ; ??

gx_error_satb:                          ; bank: $001 logical: $c136
          .db $05                       ; 5 SATB entries
          .db $a0                       ; entry #0  (Y: 160)
          .db $00
          .db $50                       ;           (X: 80)
          .db $00
          .db $e8                       ;           (Pattern: $2e8)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)
          .db $a0                       ; entry #1  (Y: 160)
          .db $00
          .db $70                       ;           (X: 112)
          .db $00
          .db $f0                       ;           (Pattern: $2f0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)
          .db $a0                       ; entry #2  (Y: 160)
          .db $00
          .db $90                       ;           (X: 144)
          .db $00
          .db $f0                       ;           (Pattern: $2f0)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)
          .db $a0                       ; entry #3  (Y: 160)
          .db $00
          .db $b0                       ;           (X: 176)
          .db $00
          .db $f8                       ;           (Pattern: $2f8)
          .db $02
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)
          .db $a0                       ; entry #4  (Y: 160)
          .db $00
          .db $d0                       ;           (X: 208)
          .db $00
          .db $f0
          .db $02                       ;           (Pattern: $2f0)
          .db $80                       ;           (Pal: 0, Pri: foreground)
          .db $11                       ;           (W: 32, HFlip: normal, H:32, VFlip: Normal)