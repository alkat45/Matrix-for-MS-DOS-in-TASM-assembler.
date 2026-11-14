# Matrix-for-MS-DOS-in-TASM-assembler.
MATRIX is a demoscene program that creates a visual effect of "digital rain" aka "matrix code" using the author's algorithm, created for disk operating systems. Created by alkat45 under GPLv3 license, which you can read in the [LICENSE](LICENSE) file. Maked on MS-DOS 6.22 in EDIT with compiler TASM 4.0 for PCs with a processor intel 8088 aka intel 8086.

## How to compile and run a file?
You will need an emulator (for example, I use [PCem]()), [MS-DOS 6.22](), [Turbo Assembler]() and make floppy.img for emulator.

> NOTE : IF YOU DON'T NOW HOW TO MAKE AND USE VIRTUAL FLOPPY DISK, YOU CAN WATCH GUIDE IN THE INTERNET.

Install them and add the following line to your "AUTOEXEC.BAT" file, on the 5th line:

```bat
PATH C:\PATH\TO\YOUR\TASM\...\BIN\;%RATH%
```

After that, insert the virtual floppy disk into the emulator and do the following:

```bat
C:\> A:
A:\> cd PATH\TO\YOUR\CODE\COPY\
A:\PATH\TO\YOUR\CODE\COPY\> tasm /zn matrix.asm
A:\PATH\TO\YOUR\CODE\COPY\> tlink /t matrix.obj
```

Congratulations, you now have the "MATRIX.COM" program, which you can run.
