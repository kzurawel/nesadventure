build: main sprite input backgrounds scroll
	ld65 src/*.o -C nes.cfg -o ex6-scrolling.nes

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

clean:
	rm src/*.o
