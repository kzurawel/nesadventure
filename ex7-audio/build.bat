@echo off
c:\cc65\bin\ca65 src\main.asm
c:\cc65\bin\ca65 src\sprite.asm
c:\cc65\bin\ca65 src\input.asm
c:\cc65\bin\ca65 src\backgrounds.asm
c:\cc65\bin\ca65 src\scroll.asm
c:\cc65\bin\ca65 src\ggsound.asm
c:\cc65\bin\ca65 src\tracks.asm
c:\cc65\bin\ld65 src\main.o src\sprite.o src\input.o src\backgrounds.o src\scroll.o src\ggsound.o src\tracks.o -C nes.cfg -o ex7-audio.nes
