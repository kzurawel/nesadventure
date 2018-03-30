.include "constants.inc"

.segment "ZEROPAGE"
.importzp sprite_x, sprite_y, buttons1, direction

.segment "CODE"
.export draw_sprite
.proc draw_sprite
  PHA ; store all registers in stack
  TXA
  PHA
  TYA
  PHA
  PHP

	; check "direction" to know what tiles to draw
	; we'll push them onto the stack,
	; then pull them off when we need them.
	; Push the right-side tile first, so the
	; left-side tile will come off the stack first.
	LDA direction
	AND #BTN_LEFT
	BEQ check_right
	LDA #$07
	PHA
	LDA #$09
	PHA
	JMP tiles_pushed_to_stack

check_right:
	LDA direction
	AND #BTN_RIGHT
	BEQ check_down
	LDA #$08
	PHA
	LDA #$06
	PHA
	JMP tiles_pushed_to_stack

check_down:
	LDA direction
	AND #BTN_DOWN
	BEQ	check_up
	LDA #$05
	PHA
	LDA #$04
	PHA
	JMP tiles_pushed_to_stack

check_up:
	; no need to test here -
	; it's not any of the other directions!
	LDA #$07
	PHA
	LDA #$06
	PHA

tiles_pushed_to_stack:
  LDY sprite_y
  STY $0200
	PLA				; get left-side tile from stack
  STA $0201
  LDA #%00000000
  STA $0202
  LDX sprite_x
  STX $0203

  STY $0204 ; Y still contains sprite_y
	PLA				; get right-side tile from stack
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
  PHA
  PHP

	; test each direction, update sprite_x / sprite_y
	; start with left/right
	; assume only one can be pressed at a time
	LDA buttons1
	AND #BTN_LEFT
	BEQ done_with_left
	; if PC gets here, left is pressed
	DEC sprite_x
	LDA #BTN_LEFT
	STA direction
	JMP start_vertical_checks
done_with_left:
	LDA buttons1
	AND #BTN_RIGHT
	BEQ start_vertical_checks
	; if PC gets here, right is pressed
	INC sprite_x
	LDA #BTN_RIGHT
	STA direction
	; no jump - we always want to check up/down next

	; now check for up / down
	; again, assume only one can be pressed at a time
start_vertical_checks:
	LDA buttons1
	AND #BTN_DOWN
	BEQ done_with_down
	; if PC gets here, down is pressed
	INC sprite_y
	LDA #BTN_DOWN
	STA direction
	JMP updates_complete
done_with_down:
	LDA buttons1
	AND #BTN_UP
	BEQ updates_complete
	; if PC gets here, up is pressed
	DEC sprite_y
	LDA #BTN_UP
	STA direction

updates_complete:
  PLP
  PLA
  RTS
.endproc
