build: main sprite input
	ld65 src/*.o -C nes.cfg -o ex4-input.nes

main:
	ca65 src/main.asm

sprite:
	ca65 src/sprite.asm

input:
	ca65 src/input.asm

clean:
	rm src/*.o
