movi R10, 0xF0
movi R11, 0xF1

movi R0, 60
movi R1, 0xA5

movs R10
stor R0

movs R11
stor R1

movi R0, 0
movi R1, 0

movs R10
load R2

movs R11
load R3

movs R2
add R3
movd R4

movs R3
xor R2
movd R5

movs R4
sbi 16
movd R6

stop