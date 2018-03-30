build: main sprite
	ld65 src/*.o -C nes.cfg -o ex03-movement.nes

main:
	ca65 src/main.asm

sprite:
	ca65 src/sprite.asm

clean:
	rm src/*.o
