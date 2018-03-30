.segment "HEADER"
.byte "NES", $1a  ; Magic string that always begins an iNES header
.byte $01         ; how many 16KB PRG-ROM banks
.byte $01         ; how many 8KB CHR-ROM banks
.byte %00000001   ; Vertical mirroring, no save RAM, no mapper
.byte %00000000   ; Special-case flags (not used here), no mapper
.byte $00         ; No PRG-RAM
.byte $00         ; NTSC format
