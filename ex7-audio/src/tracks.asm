.feature force_range
.include "tracks.inc"
.include "ggsound.inc"

.segment "CODE"

.align 64
.include "songs_dpcm.inc"

.segment "RODATA"
.include "songs_data.inc"
