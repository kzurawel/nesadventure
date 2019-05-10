.include "constants.inc"

.segment "ZEROPAGE"
.importzp sprite_x, sprite_y, buttons1, direction, scroll_x, ppu_ctrl

.segment "CODE"
.export update_scroll
.proc update_scroll
	; calculate scroll updates
	; start with left scroll
	LDA direction
	AND #BTN_LEFT
	BEQ check_right ; if 0, left not pressed
	; moving left; now check player position
	LDA sprite_x
	CMP #$20  ; is sprite_x <= 32?
	BCS done_with_scroll ; if carry set, then no
	BEQ done_with_scroll
	LDA scroll_x
	SEC
	SBC #$01
	STA scroll_x
	; now, check if we need to switch tables
	CMP #$ff
	BNE done_with_scroll ; if scroll_x not $ff, we didn't wrap
	; we wrapped - have to update table
	LDA ppu_ctrl
  CMP #%10010000  ; are we in first table?
	BEQ switch_to_2nd_table
	JMP switch_to_1st_table
check_right:
	LDA direction
	AND #BTN_RIGHT
	BEQ done_with_scroll
	; moving right; now check player position
	LDA sprite_x
	CMP #$df ; is sprite_x >= 224?
	BCC done_with_scroll
	LDA scroll_x
	CLC
	ADC #$01
	STA scroll_x
	; now, check if we need to switch tables
	BNE done_with_scroll ; if scroll_x not 0, we didn't wrap
	; we wrapped - have to update table
	LDA ppu_ctrl
  CMP #%10010000  ; are we in first table?
	BEQ switch_to_2nd_table
	JMP switch_to_1st_table

switch_to_2nd_table:
	LDA #%10010001 ; 2nd table
	STA ppu_ctrl
	RTS

switch_to_1st_table:
	LDA #%10010000 ; 1st table
	STA ppu_ctrl

done_with_scroll:
	RTS
.endproc
