    .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
    lui $1, 0xbfaf
    ori $1, $1, 0x8000  # digital num led address
    lui $2, 0xbfaf
    ori $2, $2, 0x8004  # switch address
    lui $3, 0xbfaf
    ori $3, $3, 0x8008  # led address
    lui $4, 0xbfaf
    ori $4, $4, 0x800c  # mid button address
    lui $5, 0xbfaf
    ori $5, $5, 0x8018  # up button address
    lui $6, 0xbfaf
    ori $6, $6, 0x8014  # right button address

    lui $10, 0x0000     # init reg $10
    lui $11, 0x0000     # init reg $11
    sw  $0, 0x0($1)     # init digital num led
    sw  $0, 0x0($3)     # init led

mainLoop:
    lui $7, 0x0000

    lw  $8, 0x0($5)
    beq $7, $8, detectUpBtnIs0
    nop
    lw  $11, 0x0($2)    # up btn is pressed, load num1 from switch
    sw  $11, 0x0($3)    # light led
detectUpBtnIs0:

    lw  $9, 0x0($6)
    beq $7, $9, detectRightBtnIs0
    nop
    lw  $12, 0x0($2)    # rigth btn is pressed, load num2 from switch
    sw  $12, 0x0($3)    # light led
detectRightBtnIs0:

    lw  $10, 0x0($4)
    beq $7, $10, detectMidBtnIs0
    nop
    add $13, $11, $12   # mid btn is pressed, then calculate the answer and load answer to digital num led
    sw  $13, 0x0($1)
    sw  $13, 0x0($3)    # ligth led
    add $11, $0, $13    # move value of $13 to $11

    lui $7, 0x0000
    ori $7, 0x0001
waitLoose:              # wait for loosing mid btn to avoid repeated calculation
    lw  $10, 0x0($4)
    beq $7, $10, waitLoose
    nop
detectMidBtnIs0:


    ## delay a moment
    lui $7, 0x0001
    ori $7, $7, 0x86a0  # delay time = 10ns * 0x186a0 * instructions per loop, 0x186a0 = 100000
    lui $14, 0x0000
    ori $14, 0x0001
    lui $15, 0x0000
delayLoop:
    add $15, $15, $14
    beq $7, $15, endDelayLoop
    nop
    j delayLoop
    nop
endDelayLoop:

    j mainLoop
    nop
