movi R10, 240
movi R11, 241

movi R0, 18
movi R1, 52
movi R2, 86
movi R3, 170

movs R10
stor R0

movs R11
stor R1

movi R0, 0
movi R1, 0

movs R10
load R4

movs R11
load R5

movs R4
add R5
movd R6

movs R6
adi 16
movd R7

movs R7
xri 0xFF
movd R8

movs R8
ani 0xF0
movd R9

movs R9
ori 10
movd R0

movs R0
sub R4
movd R1

movs R1
xor R5
movd R2

movs R2
and R3
movd R3

movs R3
or R6
movd R4

movs R4
sbi 32
movd R5

movs R5
adi 1
movd R6

stop