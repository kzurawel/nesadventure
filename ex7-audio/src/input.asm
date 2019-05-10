.include "constants.inc"

.segment "ZEROPAGE"
.importzp buttons1

.segment "CODE"
.export read_controller1
.proc read_controller1
  PHA
  TXA
  PHA
  PHP

  ; write a 1, then a 0, to CONTROLLER1
  ; to latch button states
  LDA #$01
  STA CONTROLLER1
  LDA #$00
  STA CONTROLLER1

  LDA #$01
  STA buttons1  ; start with %00000001 and
                ; move the 1 left until it
                ; falls into the carry flag
                ; ("ring counter")

get_buttons:
  LDA CONTROLLER1 ; read next button's state
  LSR A           ; shift button state right, into carry flag
  ROL buttons1    ; rotate button state from carry flag
                  ; onto right side of buttons1
                  ; and leftmost 0 of buttons1 into carry flag
  BCC get_buttons ; continue until original "1" is in carry flag

  PLP
  PLA
  TAX
  PLA
  RTS
.endproc
