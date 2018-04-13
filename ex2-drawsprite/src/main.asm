.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
.segment "BSS"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc reset_handler
  SEI           ; turn on interrupts
  CLD           ; turn off non-existent decimal mode
  LDX #$00
  STX PPUCTRL   ; disable NMI
  STX PPUMASK   ; turn off display

vblankwait:     ; wait for PPU to fully boot up
  BIT PPUSTATUS
  BPL vblankwait

  JMP main
.endproc

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
  RTI
.endproc

.proc main
  LDX PPUSTATUS   ; reset PPUADDR latch
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR     ; set PPU to write to $3f00 (palette ram)

copy_palettes:
  LDA palettes,x  ; use indexed addressing into palette storage
  STA PPUDATA
  INX
  CPX #$20          ; have we copied 32 values?
  BNE copy_palettes ; if no, repeat

  LDX #$00            ; set X register back to zero
set_up_sprites:
  LDA sprites,x       ; load next byte of sprite data
  STA $0200,x         ; copy to $0200 + x
  INX
  CPX #$08            ; have we copied 8 values?
  BNE set_up_sprites  ; if no, repeat

vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JMP forever     ; do nothing, forever
.endproc

.segment "RODATA"
palettes:
; background palettes
.byte $29, $00, $16, $30
.byte $29, $01, $0f, $31
.byte $29, $06, $16, $26
.byte $29, $09, $19, $29

; sprite palettes
.byte $29, $11, $30, $26
.byte $29, $01, $0f, $31
.byte $29, $06, $16, $26
.byte $29, $09, $19, $29

sprites:
.byte $70, $04, %00000000, $70
.byte $70, $05, %00000000, $78

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "CHR"
.incbin "sprites.chr"
