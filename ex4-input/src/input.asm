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
                ; move the 1 left until done
                ; ("ring counter")

get_buttons:
  LDA CONTROLLER1 ; read next button state
  LSR A           ; shift button state to carry flag
  ROL buttons1    ; rotate button state into buttons1
                  ; and leftmost 0 into carry flag
  BCC get_buttons ; continue until original 1 in carry flag

  PLP
  PLA
  TAX
  PLA
  RTS
.endproc
