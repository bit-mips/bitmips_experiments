    .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
    lui $1, 0xbfaf
    ori $1, $1, 0x8000  # digital num led address
    lui $2, 0xbfc1
    ori $2, 0x0000      # $2 = 0xbfc1_0000 which is the head address of an array where the fibonacci array store
    lui $3, 0x0000
    ori $3, 0x0001      # $3 = 1
    lui $4, 0x0000
    ori $4, 0x0004      # $4 = 4
    lui $8, 0x0000
    ori $8, 0x0014      # $8 = 20 means program will calculate first (20 + 2) items of fibonacci array
    lui $9, 0x0000      # $9 = 0
    lui $10, 0x0000
    ori $10, 0x0001     # $10 = 1
    lui $11, 0x0000
    ori $11, 0x0001     # $11 = 1

cal:
    add $12, $10, $11   # $12 = $10 + $11
    sw  $12, 0x0($2)

    add $10, $0, $11    # $10 = $11
    add $11, $0, $12    # $11 = $12

    add $2, $2, $4
    add $9, $9, $3
    beq $9, $8, endCal
    nop

    j cal
    nop
endCal:

    
    lui $2, 0xbfc1
    ori $2, 0x0000
    lui $9, 0x0000
showAns:                # show fibonacci array with digital num led, 2, 3, 5, ... 17711(0x452f)
    lw  $10, 0x0($2)
    sw  $10, 0x0($1)

    add $2, $2, $4
    add $9, $9, $3
    beq $9, $8, endShowAns
    nop

    # delay for a long time so that human eyes can see
    lui $7, 0x0131
    ori $7, $7, 0x2d00  # delay time = 10ns * 0x1312d00 * instructions per loop, 0x1312d00 = 20000000
    lui $15, 0x0000
delayLoop:
    add $15, $15, $3
    beq $7, $15, endDelayLoop
    nop
    j delayLoop
    nop
endDelayLoop:

    j showAns           # loop
    nop
endShowAns:

endLoop:
    j endLoop
    nop
