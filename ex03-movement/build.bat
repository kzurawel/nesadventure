@echo off
c:\cc65\bin\ca65 src\main.asm
c:\cc65\bin\ca65 src\sprite.asm
c:\cc65\bin\ld65 src\main.o src\sprite.o -C nes.cfg -o ex03-movement.nes
