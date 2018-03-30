@echo off
c:\cc65\bin\ca65 src\main.asm
c:\cc65\bin\ca65 src\sprite.asm
c:\cc65\bin\ca65 src\input.asm
c:\cc65\bin\ca65 src\backgrounds.asm
c:\cc65\bin\ld65 src\main.o src\sprite.o src\input.o src\backgrounds.o -C nes.cfg -o ex05-backgrounds.nes
