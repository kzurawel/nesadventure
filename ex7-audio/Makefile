build: main sprite input backgrounds scroll ggsound tracks
	ld65 src/*.o -C nes.cfg -o ex7-audio.nes

main:
	ca65 src/main.asm

sprite:
	ca65 src/sprite.asm

input:
	ca65 src/input.asm

backgrounds:
	ca65 src/backgrounds.asm

scroll:
	ca65 src/scroll.asm

ggsound:
	ca65 src/ggsound.asm

tracks:
	ca65 src/tracks.asm

clean:
	rm src/*.o
