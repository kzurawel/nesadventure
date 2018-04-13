build: main sprite input backgrounds
	ld65 src/*.o -C nes.cfg -o ex5-backgrounds.nes

main:
	ca65 src/main.asm

sprite:
	ca65 src/sprite.asm

input:
	ca65 src/input.asm

backgrounds:
	ca65 src/backgrounds.asm

clean:
	rm src/*.o
