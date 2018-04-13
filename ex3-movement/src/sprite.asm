.segment "ZEROPAGE"
.importzp sprite_x, sprite_y

.segment "CODE"
.export draw_sprite
.proc draw_sprite
  PHA ; store all registers in stack
  TXA
  PHA
  TYA
  PHA
  PHP

  LDY sprite_y
  STY $0200
  LDA #$06
  STA $0201
  LDA #%00000000
  STA $0202
  LDX sprite_x
  STX $0203

  STY $0204 ; Y still contains sprite_y
  LDA #$08
  STA $0205
  LDA #%00000000
  STA $0206
  TXA ; X still contains sprite_x
  CLC
  ADC #$08 ; add 8 to put second tile to the right
  STA $0207

  PLP ; restore all registers from stack
  PLA
  TAY
  PLA
  TAX
  PLA
  RTS
.endproc

.export update_sprite_position
.proc update_sprite_position
  PHP

  INC sprite_x

  PLP
  RTS
.endproc
