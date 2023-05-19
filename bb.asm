ball STRUCT

    xleft dw 0
    xright dw 0
    ytop dw 0
    ybot dw 0
    xspeed dw 1
    yspeed dw -1

ball ENDS

player STRUCT

    xleft dw 0
    xright dw 0
    ytop dw 0
    ybot dw 0
    xspeed dw 0
    yspeed dw 0

player ENDS

brick STRUCT

    xl dw 0
    xr dw 0
    yt dw 0
    yb dw 0
    isHit dw 0
    color db 0
    score dw 0
    drawn dw 0
    isFixed dw 0
    isSpecial dw 0

brick ENDS

.model small
.stack 100h
.data
; tileMaker 15,45,110,120,1100b,0100b
; tileMaker 275,305,110,120,1100b,0100b
; tileMaker 15,45,30,40,1100b,0100b
; tileMaker 275,305,30,40,1100b,0100b
b1 brick<25,55,30,45>
b2 brick<56,85,30,45>
b3 brick<86,115,30,45>
b4 brick<116,145,30,45>
b5 brick<146,175,30,45>
b6 brick<176,205,30,45>
b7 brick<206,235,30,45>
b8 brick<236,265,30,45>
b9 brick<266,295,30,45>

b10 brick<41,70,46,60>
b11 brick<71,100,46,60>
b12 brick<101,130,46,60>
b13 brick<131,160,46,60>
b14 brick<161,190,46,60>
b15 brick<191,220,46,60>
b16 brick<221,250,46,60>
b17 brick<251,280,46,60>
b18 brick<116,145,61,75>
b19 brick<146,175,61,75>
b20 brick<176,205,61,75>


gameLoop dw 1
gameLoopPrevious dw -1
w1 db "BRICK BREAKER MANIA!$"
baby1 db "ENTER YOUR NAME TO PLAY!$"
ins1 db "1: This is a single player 2D brick$" 
ins2 db " breaker game$"
ins3 db "2: In this game, the player moves a $"
ins4 db "PADDLE to hit a BALL$"
ins5 db "3: The game's objective is to destroy$"
ins6 db "all of the BRICKS with the BALL$"
ins7 db "4:if the ball hits the bottom screen,    the player loses and the game ends!$"
playername db 10 dup ('$')
papa db "2D BRICK BREAKER MANIA$"
newgame db "NEW GAME$"
resume db "RESUME$"
instructions db "INSTRUCTIONS$"
highscore db "HIGHSCORERS$"
Exitstring db "EXIT$"
pause db "PAUSED$"
score db "SCORE:$"
level db "LEVEL :$"
levelNum db 1
lives db "LIVES :$"
btmainmenu db "BACK TO MAIN MENU$"
navigationString1 db "$"
navigationString2 db "$"
yay db "YOU WON !!!$"
;highscore index
index1 db "1:$"
index2 db "2:$"
index3 db "3:$"
index4 db "4:$"
index5 db "5:$"
;gamevover
khatam_ta_ta db "GAME OVER !!!$"
scoreString db 5 dup('$')
gameBall ball<157,163,130,136>
gamePlayer player<120,180,180,185>
xreversed dw 0
yreversed dw 0
thirdBar dw 0
secondThirdBar dw 0
totalScore dw 0
tempScore dw 0
divider dw 10
numLives dw 3
irony dw 1
menuChoice dw 1
bricksHit dw 0
gameLevel dw 1
;xleft, xright, ytop, ybot, color1, color2
xleft dw 0
xright dw 0
ytop dw 0
ybot dw 0
color1 db 0
color2 db 0
xpos db 0
ypos db 0
color db 0
color3 db 0
x dw 0
y dw 0
time dw 0
specialBrickCount db 0
freq dw 0
firstName db 10 dup('$')
secondName db 10 dup('$')
thirdName db 10 dup('$')
fourthName db 10 dup('$')
fifthName db 10 dup('$')
sixthName db 10 dup('$')
firstScore db 5 dup('$')
secondScore db 5 dup('$')
thirdScore db 5 dup('$')
fourthScore db 5 dup('$')
fifthScore db 5 dup('$')
sixthScore db 5 dup('$')
firstLevel db 2 dup('$')
secondLevel db 2 dup('$')
thirdLevel db 2 dup('$')
fourthLevel db 2 dup('$')
fifthLevel db 2 dup('$')
sixthLevel db 2 dup('$')
numArray dw 0,0,0,0,0,0 
arrayIndex db 0
valueArr dw 10 dup(10)
numWords db 6
dummyShit db 6
sum dw 12
stringArr db 150 dup(13)
loop1Counter db 0
loop2Counter db 0
string1 dw 0
string2 dw 0
stringSwapCounter db 0
file db "highscores.txt", 0
handler dw ?
buffer db 100 dup('$')
isSpecialHit dw 0
bricksDisappeared dw 0
thething dw 0

.code
; pixelPrinter MACRO x, y, color3

;     mov cx, x
;     mov dx, y

;     mov al, color3
;     mov ah, 0ch 
;     int 10h

; ENDM

; textWriter MACRO string, xpos, ypos, color

;     mov si, offset string

;     mov ah, 2
;     mov dh, ypos
;     mov dl, xpos
;     mov bh, 0
;     int 10h

;     mov dl, '$'

;     .while [si] != dl

;         mov ah, 0eh
;         mov al, [si]
;         mov bh, 0
;         mov bl, color
;         mov cx, 1
;         int 10h

;         inc si

;     .endw

; ENDM

clearScreen MACRO color

    mov ah, 0
    mov al, 13h
    int 10h

    mov di, 0

    .while di < 200

        mov bx, 0

        .while bx < 320

            mov x, bx
            mov y, di
            mov al, color
            mov color3, color

            call pixelPrinter

            ;pixelPrinter bx, di, color

            inc bx

        .endw

        inc di

    .endw

ENDM

main PROC

    mov ax,@data
    mov ds, ax

    clearScreen 0000b
    call welcomePage

    mov ax, 1
    mov gameLoop, ax

    FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

        call randomNumber

        mov brik.color, dl

        .if brik.color == 0000b

            add brik.color, 1010b

        .endif

        mov ax, dx
        xor dx, dx
        mov bx, 5
        div bx

        inc ax
        mov brik.score, ax

        .IF specialBrickCount == 0

            call randomNumber

            mov ax,dx
            xor dx,dx
            mov bx, 6
            div bx

            .IF dx == 1

                mov brik.isSpecial, 1
                mov specialBrickCount, 1
                mov brik.color, 1101b

            .ENDIF

        .ENDIF

        mov time, 10000000

        call delay

        ;delay 10000000

    ENDM

    mov b11.isFixed, 1
    mov b13.isFixed, 1
    mov b14.isFixed, 1
    mov b16.isFixed, 1
    mov b11.color, 1100b
    mov b13.color, 1100b
    mov b14.color, 1100b
    mov b16.color, 1100b


    .while gameLoop != 0

        .IF gameLoop == 1

            clearScreen 0000b
            call mainmenu

        .ENDIF

        .IF gameLoop == 2

            .IF gameLevel == 1

                call updateScore
                call gameBar
                call ballMovement

                mov time, 12000

                call delay

                ;delay 12000
                call playerMovement
                call brickDrawing

            .ENDIF

            .IF gameLevel == 2

                inc levelNum
                inc gameLevel

        ; clearScreen 0000b

        ; mov xleft, 0
        ; mov xright, 320
        ; mov ytop, 0
        ; mov ybot, 20
        ; mov color1, 1100b
        ; mov color2, 0100b

        ; call tileMaker

        ; ;tileMaker 0,320,0,20,1100b,0100b

        ; mov si, offset lives
        ; mov xpos, 1
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter
    
        ; ;textWriter lives, 1,1, 1111b

        ; mov si, offset score
        ; mov xpos, 14
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter

        ; ;textWriter score, 14, 1, 1111b ;xpos,ypos,color

        ; mov si, offset playername
        ; mov xpos, 30
        ; mov ypos, 0
        ; mov color, 1111b

        ; call textWriter

        ; ;textWriter playername, 30, 0, 1111b ;xpos,ypos,color

        ; mov si, offset level
        ; mov xpos, 30
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter

                FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

                    mov brik.isHit, 0
                    mov brik.drawn, 0

                ENDM

                mov xleft, 0
                mov xright, 320
                mov ax, gamePlayer.ytop
                mov ytop, ax
                mov ax, gamePlayer.ybot
                mov ybot, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker 0, 320, gamePlayer.ytop, gamePlayer.ybot, 0000b, 0000b
                
                mov gamePlayer.xleft, 120
                mov gamePlayer.xright,170
                mov gamePlayer.ytop,180
                mov gamePlayer.ybot,185

                ;gameBall ball<157,163,130,136>

                mov ax, gamePlayer.xleft
                mov xleft, ax
                mov ax, gamePlayer.xright
                mov xright, ax
                mov ax, gamePlayer.ytop
                mov ytop, ax
                mov ax, gamePlayer.ybot
                mov ybot, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

            

                mov gameBall.xleft, 157
                mov gameBall.xright,163
                mov gameBall.ytop,130
                mov gameBall.ybot,136
                mov gameBall.yspeed, -1

            .ENDIF

            .IF gameLevel == 3

                call updateScore
                call gameBar
                call ballMovement

                mov time, 10000

                call delay

                ;delay 10000
                call playerMovement
                call brickDrawing

            .ENDIF

            .IF gameLevel == 4

                mov levelnum, 3
                inc gameLevel

        ; clearScreen 0000b

        ; mov xleft, 0
        ; mov xright, 320
        ; mov ytop, 0
        ; mov ybot, 20
        ; mov color1, 1100b
        ; mov color2, 0100b

        ; call tileMaker

        ; ;tileMaker 0,320,0,20,1100b,0100b

        ; mov si, offset lives
        ; mov xpos, 1
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter
    
        ; ;textWriter lives, 1,1, 1111b

        ; mov si, offset score
        ; mov xpos, 14
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter

        ; ;textWriter score, 14, 1, 1111b ;xpos,ypos,color

        ; mov si, offset playername
        ; mov xpos, 30
        ; mov ypos, 0
        ; mov color, 1111b

        ; call textWriter

        ; ;textWriter playername, 30, 0, 1111b ;xpos,ypos,color

        ; mov si, offset level
        ; mov xpos, 30
        ; mov ypos, 1
        ; mov color, 1111b

        ; call textWriter

                FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

                    mov brik.isHit, 0
                    mov brik.drawn, 0

                ENDM

                mov xleft, 0
                mov xright, 320
                mov ax, gamePlayer.ytop
                mov ytop, ax
                mov ax, gamePlayer.ybot
                mov ybot, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker 0, 320, gamePlayer.ytop, gamePlayer.ybot, 0000b, 0000b
                
                mov gamePlayer.xleft, 120
                mov gamePlayer.xright,170
                mov gamePlayer.ytop,180
                mov gamePlayer.ybot,185

                ;gameBall ball<157,163,130,136>

                mov ax, gamePlayer.xleft
                mov xleft, ax
                mov ax, gamePlayer.xright
                mov xright, ax
                mov ax, gamePlayer.ytop
                mov ytop, ax
                mov ax, gamePlayer.ybot
                mov ybot, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker gameBall.xleft, gameBall.xright, gameBall.ytop, gameBall.ybot, 0000b, 0000b

                mov gameBall.xleft, 157
                mov gameBall.xright,163
                mov gameBall.ytop,130
                mov gameBall.ybot,136
                mov gameBall.yspeed, -1

            .ENDIF


            .IF gameLevel == 5

                call updateScore
                call gameBar
                call ballMovement

                mov time, 8000

                call delay

                ;delay 8000
                call playerMovement
                call brickDrawing

            .ENDIF

            .IF gameLevel == 6

                mov freq, 400
                mov thething, 65535
                call beep

                mov freq, 800
                mov thething, 65535
                call beep

                mov freq, 1200
                mov thething, 65535
                call beep

                mov freq, 1400
                mov thething, 65535
                call beep

                mov freq, 1600
                mov thething, 65535
                call beep

                mov freq, 1800
                mov thething, 65535
                call beep

                mov si, offset playername
                mov di, offset sixthName
                mov ax, 0

                .while ax < 10

                    mov bl, [si]
                    mov [di], bl
                    inc ax

                .endw

                mov si, offset totalScore
                mov di, offset sixthScore
                mov ax, 0

                .while ax < 5

                    mov bl, [si]
                    mov [di], bl
                    inc ax

                .endw

                mov si, offset levelNum
                mov di, offset sixthLevel
                mov ax, 0

                .while ax < 2

                    mov bl, [si]
                    mov [di], bl
                    inc ax

                .endw

                call fileWriter

                call winner

            .ENDIF

            mov ah, 1
            int 16h

            .IF numLives == 0

                mov freq, 400
                mov thething, 65535
                call beep

                mov freq, 800
                mov thething, 65535
                call beep

                mov freq, 1200
                mov thething, 65535
                call beep

                mov freq, 1400
                mov thething, 65535
                call beep

                mov freq, 1600
                mov thething, 65535
                call beep

                mov freq, 1800
                mov thething, 65535
                call beep

                mov si, offset playername
                mov di, offset sixthName
                mov ax, 0

                .while ax < 10

                    mov bl, [si]
                    mov [di], bl
                    inc si
                    inc di
                    inc ax

                .endw

                mov si, offset scoreString
                mov di, offset sixthScore
                mov ax, 0

                .while ax < 5

                    mov bl, [si]
                    mov [di], bl
                    inc si
                    inc di
                    inc ax

                .endw

                mov si, offset sixthLevel

                .If levelNum == 1

                    mov al, 1
                    mov [si], al
                    inc si
                    mov al, '$'
                    mov [si], al

                .ELSEIF levelNum == 2

                    mov al, 2
                    mov [si], al
                    inc si
                    mov al, '$'
                    mov [si], al

                .ELSEIF levelNum == 3

                    mov al, 3
                    mov [si], al
                    inc si
                    mov al, '$'
                    mov [si], al

                .ENDIF

                call fileWriter

                call gameover

            .ENDIF

        .ENDIF

        .IF gameLoop == 3

            ;okwhatever

        .ENDIF

        .IF gameLoop == 4

            call instructionsPage

        .ENDIF

        .IF gameLoop == 5

            call highscoresPage

        .ENDIF

        .IF gameLoop == 6

            mov ah, 4ch
            int 21h

        .ENDIF

        .IF gameLoop == 7

            call pausegame

        .ENDIF

    .endw
     
    mov ah,4ch
    int 21h

main ENDP

colissions PROC

        .IF gameBall.xleft <= 0

            mov ax, gameBall.xspeed
            mov bx, -1
            mul bx
            mov gameBall.xspeed, ax

            mov ax, 0
            mov gameBall.xleft, ax

            mov ax, 6
            mov gameBall.xright, ax

            mov freq, 400
            mov thething, 655
            call beep

        .ENDIF

        .IF gameBall.xright >= 320

            mov ax, gameBall.xspeed
            mov bx, -1
            mul bx
            mov gameBall.xspeed, ax

            mov ax, 314
            mov gameBall.xleft, ax

            mov ax, 320
            mov gameBall.xright, ax

            mov freq, 400
            mov thething, 655
            call beep

        .ENDIF

        .IF gameBall.ytop <= 21

            mov ax, gameBall.yspeed
            mov bx, -1
            mul bx
            mov gameBall.yspeed, ax

            mov ax, 21
            mov gameBall.ytop, ax

            mov ax, 27
            mov gameBall.ybot, ax

            mov freq, 400
            mov thething, 655
            call beep

        .ENDIF

        .IF gameBall.ybot >= 200

            mov ax, gameBall.yspeed
            mov bx, -1
            mul bx
            mov gameBall.yspeed, ax

            ;157,163,97,103

            mov ax, 130
            mov gameBall.ytop, ax

            mov ax, 136
            mov gameBall.ybot, ax

            mov ax, 157
            mov gameBall.xleft, ax

            mov ax, 163
            mov gameBall.xright, ax

            .IF numLives > 0

                sub numLives, 1

            .ENDIF

        .ENDIF

        mov bx, gamePlayer.ytop

        .IF gameBall.ybot >= bx

            mov cx, gamePlayer.xleft
            mov dx, gamePlayer.xright

            mov ax, 0
            add ax, cx
            add ax, 20
            mov thirdBar, ax
            add ax, 20
            mov secondThirdBar, ax

            .IF gameBall.xright >= cx && gameBall.xleft <= dx

                mov ax, gameBall.yspeed
                mov bx, -1
                mul bx
                mov gameBall.yspeed, ax

                ;pusha

            mov freq, 400
            mov thething, 655
            call beep

                mov ax, thirdBar
                mov bx, secondThirdBar
                mov cx, gamePlayer.xleft
                mov dx, gamePlayer.xright

                .IF gameBall.xright >= cx && gameBall.xleft < ax

                    mov ax, -1
                    mov gameball.xspeed, ax

                .ENDIF

                mov ax, thirdBar
                mov bx, secondThirdBar
                mov cx, gamePlayer.xleft
                mov dx, gamePlayer.xright

                .IF gameBall.xright >= ax && gameball.xleft < bx

                    mov ax, 0
                    mov gameball.xspeed, ax

                .ENDIF

                mov ax, thirdBar
                mov bx, secondThirdBar
                mov cx, gamePlayer.xleft
                mov dx, gamePlayer.xright

                .IF gameBall.xright >= bx && gameball.xleft <= dx

                    mov ax, 1
                    mov gameball.xspeed, ax

                .ENDIF

                ;popa

                mov ax, gamePlayer.ytop
                mov gameBall.ybot, ax

                dec ax
                dec ax
                dec ax
                dec ax
                dec ax
                dec ax
                mov gameBall.ytop, ax

            .ENDIF

        .ENDIF

        ret

colissions ENDP

ballMovement PROC

    mov ax, gameBall.xleft
    mov xleft, ax
    mov ax, gameBall.xright
    mov xright, ax
    mov ax, gameBall.ytop
    mov ytop, ax
    mov ax, gameBall.ybot
    mov ybot, ax
    mov color1, 0000b
    mov color2, 0000b

    call ballDrawer

    ;tileMaker gameBall.xleft, gameBall.xright, gameBall.ytop, gameBall.ybot, 0000b, 0000b

    mov ax, gameBall.xspeed
    add gameBall.xleft, ax
    add gameBall.xright, ax

    mov ax, gameBall.yspeed
    add gameBall.ytop, ax
    add gameBall.ybot, ax

    call colissions

    mov ax, gameBall.xleft
    mov xleft, ax
    mov ax, gameBall.xright
    mov xright, ax
    mov ax, gameBall.ytop
    mov ytop, ax
    mov ax, gameBall.ybot
    mov ybot, ax
    mov color1, 0001b
    mov color2, 0001b

    call ballDrawer

    ;tileMaker gameBall.xleft, gameBall.xright, gameBall.ytop, gameBall.ybot, 0001b, 0001b

    ret

ballMovement ENDP

playerMovement PROC

    mov ax, gamePlayer.xleft
    mov xleft, ax
    mov ax, gamePlayer.xright
    mov xright, ax
    mov ax, gamePlayer.ytop
    mov ytop, ax
    mov ax, gamePlayer.ybot
    mov ybot, ax
    mov color1, 0110b
    mov color2, 0000b

    call tileMaker

    ;tileMaker gamePlayer.xleft, gamePlayer.xright, gamePlayer.ytop, gamePlayer.ybot, 0110b, 0000b

    mov ah, 1
    int 16h

    jz ender

    mov ah, 0
    int 16h

    .IF ah == 4bh

        mov ax, -4
        mov gamePlayer.xspeed, ax

    .ENDIF

    .IF ah == 4dh

        mov ax, 4
        mov gamePlayer.xspeed, ax

    .ENDIF

    .IF al == 8

        mov gameLoop, 7

    .ENDIF

    mov ax, gamePlayer.xleft
    mov xleft, ax
    mov ax, gamePlayer.xright
    mov xright, ax
    mov ax, gamePlayer.ytop
    mov ytop, ax
    mov ax, gamePlayer.ybot
    mov ybot, ax
    mov color1, 0000b
    mov color2, 0000b

    call tileMaker

    ;tileMaker gamePlayer.xleft, gamePlayer.xright, gamePlayer.ytop, gamePlayer.ybot, 0000b, 0000b

    mov ax, gamePlayer.xspeed

    add gamePlayer.xleft, ax
    add gamePlayer.xright, ax

    .IF gameLevel == 1

        .IF gamePlayer.xright <= 60

            mov ax, 0
            mov gamePlayer.xleft, ax

            mov ax, 60
            mov gamePlayer.xright, ax

        .ENDIF

        .IF gamePlayer.xright >= 319

            mov ax, 259 
            mov gamePlayer.xleft, ax

            mov ax, 319
            mov gamePlayer.xright, ax

        .ENDIF

    .ENDIF

    .IF gameLevel == 3 || gameLevel == 5

        .IF gamePlayer.xright <= 50

            mov ax, 0
            mov gamePlayer.xleft, ax

            mov ax, 50
            mov gamePlayer.xright, ax

        .ENDIF

        .IF gamePlayer.xright >= 319

            mov ax, 269 
            mov gamePlayer.xleft, ax

            mov ax, 319
            mov gamePlayer.xright, ax

        .ENDIF

    .ENDIF

    mov ax, gamePlayer.xleft
    mov xleft, ax
    mov ax, gamePlayer.xright
    mov xright, ax
    mov ax, gamePlayer.ytop
    mov ytop, ax
    mov ax, gamePlayer.ybot
    mov ybot, ax
    mov color1, 0110b
    mov color2, 0000b

    call tileMaker

    ;player
    ;tileMaker gamePlayer.xleft, gamePlayer.xright, gamePlayer.ytop, gamePlayer.ybot, 0110b, 0000b

    mov ax, 0
    mov gamePlayer.xspeed, ax

    ender:

    ret

playerMovement ENDP

brickDrawing PROC

    FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

        mov bx, 0
        mov xreversed, bx
        mov yreversed, bx

        .IF gameLevel == 1

            mov ax, gameBall.ytop

            .IF brik.yb == ax && yreversed == 0 && brik.isHit == 0

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    mov brik.isHit, 1
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yb
                    mov gameBall.ytop, ax
                    add ax, 6
                    mov gameBall.ybot, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    inc bricksHit

                .ENDIF

            .ENDIF

            mov ax, gameBall.ybot

            .IF brik.yt == ax && yreversed == 0 && brik.isHit == 0

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    mov brik.isHit, 1
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yt
                    mov gameBall.ybot, ax
                    sub ax, 6
                    mov gameBall.ytop, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep
                    inc bricksHit

                .ENDIF

            .ENDIF

            mov ax, gameBall.xleft

            .IF brik.xr == ax && xreversed == 0 && brik.isHit == 0

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    mov brik.isHit, 1
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xr
                    mov gameBall.xleft, ax
                    add ax, 6
                    mov gameBall.xright, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    inc bricksHit

                .ENDIF

            .ENDIF

            mov ax, gameBall.xright

            .IF brik.xl == ax && xreversed == 0 && brik.isHit == 0

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    mov brik.isHit, 1
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xl
                    mov gameBall.xright, ax
                    sub ax, 6
                    mov gameBall.xleft, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    inc bricksHit

                .ENDIF

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit == 1

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yt
                mov ytop, ax
                mov ax, brik.yb
                mov ybot, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, 0000b,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit == 0

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yt
                mov ytop, ax
                mov ax, brik.yb
                mov ybot, ax
                mov al, brik.color

                mov color1, al
                mov color2, 0000b

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, brik.color,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF

        .ENDIF

        .IF gameLevel == 3

            mov ax, gameBall.ytop

            .IF brik.yb == ax && yreversed == 0 && brik.isHit != 2

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    inc brik.isHit
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yb
                    mov gameBall.ytop, ax
                    add ax, 6
                    mov gameBall.ybot, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isHit == 1

                        mov al, brik.color
                        sub al, 10
                        mov brik.color, al

                        .while brik.color == 0000b

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al

                        .endw

                    .ENDIF

                    .IF brik.isHit == 2

                        inc bricksHit

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.ybot

            .IF brik.yt == ax && yreversed == 0 && brik.isHit != 2

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    inc brik.isHit
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yt
                    mov gameBall.ybot, ax
                    sub ax, 6
                    mov gameBall.ytop, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isHit == 1

                        mov al, brik.color
                        sub al, 10
                        mov brik.color, al

                        .while brik.color == 0000b

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al
                            
                        .endw

                    .ENDIF

                    .IF brik.isHit == 2

                        inc bricksHit

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.xleft

            .IF brik.xr == ax && xreversed == 0 && brik.isHit != 2

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    inc brik.isHit
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xr
                    mov gameBall.xleft, ax
                    add ax, 6
                    mov gameBall.xright, ax

                    mov bx, brik.score
                    add totalScore, bx

            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isHit == 1

                        mov al, brik.color
                        sub al, 10
                        mov brik.color, al

                        .while brik.color == 0000b

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al
                            
                        .endw

                    .ENDIF

                    .IF brik.isHit == 2

                        inc bricksHit

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.xright

            .IF brik.xl == ax && xreversed == 0 && brik.isHit != 2

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    inc brik.isHit
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xl
                    mov gameBall.xright, ax
                    sub ax, 6
                    mov gameBall.xleft, ax

                    mov bx, brik.score
                    add totalScore, bx
            
            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isHit == 1

                        mov al, brik.color
                        sub al, 10
                        mov brik.color, al

                        .while brik.color == 0000b

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al
                            
                        .endw

                    .ENDIF

                    .IF brik.isHit == 2

                        inc bricksHit

                    .ENDIF

                .ENDIF

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit == 2

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yb
                mov ybot, ax
                mov ax, brik.yt
                mov ytop, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, 0000b,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit != 2

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yb
                mov ybot, ax
                mov ax, brik.yt
                mov ytop, ax
                mov al, brik.color

                mov color1, al
                mov color2, 0000b

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, brik.color,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF
            
        .ENDIF

        .IF gameLevel == 5

            mov ax, gameBall.ytop

            .IF brik.yb == ax && yreversed == 0 && brik.isHit != 3

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yb
                    mov gameBall.ytop, ax
                    add ax, 6
                    mov gameBall.ybot, ax
            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isFixed == 0

                        inc brik.isHit
                        mov bx, brik.score
                        add totalScore, bx

                        .IF brik.isHit != 3

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al

                            .while brik.color == 0000b

                                mov al, brik.color
                                sub al, 10
                                mov brik.color, al
                                
                            .endw

                        .ENDIF

                    .ENDIF

                    .IF brik.isHit == 3

                        inc bricksHit

                        .IF brik.isSpecial == 1

                            mov isSpecialHit, 1

                        .ENDIF

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.ybot

            .IF brik.yt == ax && yreversed == 0 && brik.isHit != 3

                mov bx, brik.xl
                mov cx, brik.xr

                .IF gameBall.xright >= bx && gameBall.xleft <= cx

                    mov dx, 1
                    mov yreversed, dx
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.yspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.yspeed, ax

                    mov ax, brik.yt
                    mov gameBall.ybot, ax
                    sub ax, 6
                    mov gameBall.ytop, ax

            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isFixed == 0

                        inc brik.isHit
                        mov bx, brik.score
                        add totalScore, bx

                        .IF brik.isHit != 3

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al

                            .while brik.color == 0000b

                                mov al, brik.color
                                sub al, 10
                                mov brik.color, al

                                
                            .endw

                        .ENDIF

                    .ENDIF

                    .IF brik.isHit == 3

                        inc bricksHit

                        .IF brik.isSpecial == 1

                            mov isSpecialHit, 1

                        .ENDIF

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.xleft

            .IF brik.xr == ax && xreversed == 0 && brik.isHit != 3

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xr
                    mov gameBall.xleft, ax
                    add ax, 6
                    mov gameBall.xright, ax

            mov freq, 400
            mov thething, 655
            call beep

                    .IF brik.isFixed == 0

                        inc brik.isHit
                        mov bx, brik.score
                        add totalScore, bx

                        .IF brik.isHit != 3

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al

                            .while brik.color == 0000b

                                mov al, brik.color
                                sub al, 10
                                mov brik.color, al
                                
                            .endw

                        .ENDIF

                    .ENDIF

                    .IF brik.isHit == 3

                        inc bricksHit

                        .IF brik.isSpecial == 1

                            mov isSpecialHit, 1

                        .ENDIF

                    .ENDIF

                .ENDIF

            .ENDIF

            mov ax, gameBall.xright

            .IF brik.xl == ax && xreversed == 0 && brik.isHit != 3

                mov bx, brik.yb
                mov cx, brik.yt

                .IF gameBall.ytop <= bx && gameBall.ybot >= cx

                    mov dx, 1
                    mov xreversed, dx
                    mov dx, 0
                    mov brik.drawn, dx

                    mov ax, gameBall.xspeed
                    mov bx, -1
                    mul bx
                    mov gameBall.xspeed, ax

                    mov ax, brik.xl
                    mov gameBall.xright, ax
                    sub ax, 6
                    mov gameBall.xleft, ax

                    mov freq, 400
                    mov thething, 655
                    call beep

                    .IF brik.isFixed == 0

                        inc brik.isHit
                        mov bx, brik.score
                        add totalScore, bx

                        .IF brik.isHit != 3

                            mov al, brik.color
                            sub al, 10
                            mov brik.color, al

                            .while brik.color == 0000b

                                mov al, brik.color
                                sub al, 10
                                mov brik.color, al
                                
                            .endw

                        .ENDIF

                    .ENDIF

                    .IF brik.isHit == 3

                        inc bricksHit

                        .IF brik.isSpecial == 1

                            mov isSpecialHit, 1

                        .ENDIF

                    .ENDIF

                .ENDIF

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit == 3

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yb
                mov ybot, ax
                mov ax, brik.yt
                mov ytop, ax
                mov color1, 0000b
                mov color2, 0000b

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, 0000b,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF

            .IF brik.drawn == 0 && brik.isHit != 3

                mov ax, brik.xl
                mov xleft, ax
                mov ax, brik.xr
                mov xright, ax
                mov ax, brik.yb
                mov ybot, ax
                mov ax, brik.yt
                mov ytop, ax
                mov al, brik.color

                .IF brik.isSpecial == 0

                    mov color1, al
                    mov color2, 0000b

                .ELSE

                    mov color1, al
                    mov color2, 1100b

                .ENDIF

                call tileMaker

                ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, brik.color,0000b
                mov ax, 1
                mov brik.drawn, ax

            .ENDIF
            
        .ENDIF

    ENDM

    .if isSpecialHit == 1 

        .if bricksHit >= 13

            FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

                .if brik.isHit != 3 && brik.isFixed == 0

                    mov brik.isHit, 3
                    mov brik.drawn, 0
                    inc bricksHit
                    mov bx, brik.score
                    add totalScore, bx

                .ENDIF

                .IF brik.drawn == 0 && brik.isHit == 3

                    mov ax, brik.xl
                    mov xleft, ax
                    mov ax, brik.xr
                    mov xright, ax
                    mov ax, brik.yb
                    mov ybot, ax
                    mov ax, brik.yt
                    mov ytop, ax
                    mov color1, 0000b
                    mov color2, 0000b

                    call tileMaker

                    ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, 0000b,0000b
                    mov ax, 1
                    mov brik.drawn, ax

                .ENDIF

                .IF brik.drawn == 0 && brik.isHit != 3

                    mov ax, brik.xl
                    mov xleft, ax
                    mov ax, brik.xr
                    mov xright, ax
                    mov ax, brik.yb
                    mov ybot, ax
                    mov ax, brik.yt
                    mov ytop, ax
                    mov al, brik.color

                    mov color1, al
                    mov color2, 0000b

                    call tileMaker

                    ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, brik.color,0000b
                    mov ax, 1
                    mov brik.drawn, ax

                .ENDIF

            ENDM

        .ENDIF

        .IF bricksHit < 13

                .while bricksDisappeared < 5

                FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

                    mov time, 1000000000

                    call delay

                    mov ah, 0
                    int 1AH
                    mov ax, dx
                    mov dx, 0
                    mov bx, 40
                    div bx

                    .if bricksDisappeared < 5 && dl >= 0 && dl <= 15

                        .if brik.isHit != 3 && brik.isFixed == 0

                            mov brik.isHit, 3
                            mov brik.drawn, 0
                            inc bricksHit
                            mov bx, brik.score
                            add totalScore, bx
                            inc bricksDisappeared

                        .ENDIF

                    .ENDIF

                    .IF brik.drawn == 0 && brik.isHit == 3

                        mov ax, brik.xl
                        mov xleft, ax
                        mov ax, brik.xr
                        mov xright, ax
                        mov ax, brik.yb
                        mov ybot, ax
                        mov ax, brik.yt
                        mov ytop, ax
                        mov color1, 0000b
                        mov color2, 0000b

                        call tileMaker

                        ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, 0000b,0000b
                        mov ax, 1
                        mov brik.drawn, ax

                    .ENDIF

                    .IF brik.drawn == 0 && brik.isHit != 3

                        mov ax, brik.xl
                        mov xleft, ax
                        mov ax, brik.xr
                        mov xright, ax
                        mov ax, brik.yb
                        mov ybot, ax
                        mov ax, brik.yt
                        mov ytop, ax
                        mov al, brik.color

                        mov color1, al
                        mov color2, 0000b

                        call tileMaker

                        ;tileMaker brik.xl,brik.xr,brik.yt,brik.yb, brik.color,0000b
                        mov ax, 1
                        mov brik.drawn, ax

                    .ENDIF

                ENDM

            .endw

        .ENDIF

    .ENDIF

    mov isSpecialHit, 0

    .IF gameLevel == 1 || gameLevel == 3

        .IF bricksHit >= 20

            inc gameLevel
            mov bricksHit, 0

        .ENDIF

    .ELSEIF gameLevel == 5

        .IF bricksHit >= 16

            inc gameLevel
            mov bricksHit, 0

        .ENDIF 

    .ENDIF       

    ret

brickDrawing ENDP

updateScore PROC

    pop di

    mov si, offset scoreString
    mov al, '$'
    mov [si], al
    inc si
    mov [si], al
    inc si
    mov [si], al
    inc si
    mov [si], al
    inc si
    mov [si], al
    inc si

    mov si, offset scoreString
    mov bx, 0

    .IF totalScore == bx

        mov cx, '0'
        mov [si], cx
        inc si

        mov cx, '$'
        mov [si], cx

    .ENDIF

    mov bx, 0

    .IF totalScore != bx

        mov cx, totalScore
        mov tempScore, cx
        mov cx, 0
        mov ax, tempScore

        divideLoop:

            xor dx, dx
            div divider
            add dx, 48
            push dx
            inc  cx

            TEST ax, ax
            jnz divideLoop

        mov si, offset scoreString

        mov ah, 1
        int 16h

        stringLoop:

            pop ax
            mov [si], ax
            inc si

            loop stringLoop

        mov ax, '$'
        mov [si], ax

    .ENDIF

    push di

    ret

updateScore ENDP

gameBar PROC

    mov si, offset scoreString
    mov xpos, 22
    mov ypos, 1
    mov color, 1111b

    call textWriter

    ;textWriter scoreString, 22, 1, 1111b

    mov ah, 2
    mov dh, 1
    mov dl, 7
    mov bh, 0
    int 10h

    mov ah, 09h
    mov al, ' '
    mov bh, 0
    mov bl, 0100b
    mov cx, 3
    int 10h

    mov ah, 2
    mov dh, 1
    mov dl, 7
    mov bh, 0
    int 10h

    mov ah, 09h
    mov al, 3
    mov bh, 0
    mov bl, 0100b
    mov cx, numLives
    int 10h

    mov ah, 2
    mov dh, 1
    mov dl, 36
    mov bh, 0
    int 10h

    mov ah, 09h
    mov al, levelNum
    add al, 48
    mov bh, 0
    mov bl, 1111b
    mov cx, 1
    int 10h

    ret

gameBar ENDP

mainmenu PROC

    clearScreen 0000b
    mov menuChoice, 1

    shuru:

    mov xleft, 60
    mov xright, 270
    mov ytop, 10
    mov ybot, 30
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 60,270,10,30,0001b,0010b ;papa tile

    mov xleft, 110
    mov xright, 220
    mov ytop, 40
    mov ybot, 55
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 110,220,40,55,0001b,0010b;new game

    mov xleft, 110
    mov xright, 220
    mov ytop, 65
    mov ybot, 80
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 110,220,65,80,0001b,0010b;resume

    mov xleft, 110
    mov xright, 220
    mov ytop, 90
    mov ybot, 105
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 110,220,90,105,0001b,0010b;instructions

    mov xleft, 110
    mov xright, 220
    mov ytop, 115
    mov ybot, 130
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 110,220,115,130,0001b,0010b;highscore

    mov xleft, 110
    mov xright, 220
    mov ytop, 140
    mov ybot, 155
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 110,220,140,155,0001b,0010b;exit

    .IF menuChoice == 1

        mov xleft, 110
        mov xright, 220
        mov ytop, 40
        mov ybot, 55
        mov color1, 0000b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 110,220,40,55,0001b,0100b;new game

    .ENDIF

    .IF menuChoice == 2

        mov xleft, 110
        mov xright, 220
        mov ytop, 65
        mov ybot, 80
        mov color1, 0000b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 110,220,65,80,0001b,0100b;resume

    .ENDIF

    .IF menuChoice == 3

        mov xleft, 110
        mov xright, 220
        mov ytop, 90
        mov ybot, 105
        mov color1, 0000b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 110,220,90,105,0001b,0100b;instructions

    .ENDIF

    .IF menuChoice == 4

        mov xleft, 110
        mov xright, 220
        mov ytop, 115
        mov ybot, 130
        mov color1, 0000b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 110,220,115,130,0001b,0100b;highscore

    .ENDIF

    .IF menuChoice == 5

        mov xleft, 110
        mov xright, 220
        mov ytop, 140
        mov ybot, 155
        mov color1, 0000b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 110,220,140,155,0001b,0100b;exit

    .ENDIF

    mov si, offset papa
    mov xpos, 10
    mov ypos, 2
    mov color, 1111b

    call textWriter

    ;textWriter papa, 10, 2, 0011b ;xpos,ypos,color

    mov si, offset newgame
    mov xpos, 17
    mov ypos, 6
    mov color, 1111b

    call textWriter

    ;textWriter newgame, 17, 6, 0011b

    mov si, offset resume
    mov xpos, 17
    mov ypos, 9
    mov color, 1111b

    call textWriter

    ;textWriter resume, 17, 9, 0011b

    mov si, offset instructions
    mov xpos, 15
    mov ypos, 12
    mov color, 1111b

    call textWriter

    ;textWriter instructions, 15, 12, 0011b

    mov si, offset highscore
    mov xpos, 16
    mov ypos, 15
    mov color, 1111b

    call textWriter

    ;textWriter highscore, 16, 15, 0011b

    mov si, offset Exitstring
    mov xpos, 18
    mov ypos, 18
    mov color, 1111b

    call textWriter

    ;textWriter Exitstring, 18, 18, 0011b

        ;borders

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 315,320,0,200,0011b,0010b;right border


    mov ah, 0
    int 16h

    push ax
    push bx
    push cx
    push dx
            mov freq, 400
            mov thething, 655
            call beep

    pop dx
    pop cx
    pop bx
    pop ax

    .IF ah == 50h

        .IF menuChoice != 5

            .IF menuChoice == 1

                mov menuChoice, 2

            .ELSEIF menuChoice == 2

                mov menuChoice, 3


            .ELSEIF menuChoice == 3

                mov menuChoice, 4

            .ELSEIF menuChoice == 4

                mov menuChoice, 5

            .ELSEIF menuChoice == 5

                mov menuChoice, 5

            .ENDIF

        .ENDIF

    .ENDIF

    .IF ah == 48h

        .IF menuChoice != 1

            .IF menuChoice == 2

                mov menuChoice, 1

            .ELSEIF menuChoice == 3

                mov menuChoice, 2

            .ELSEIF menuChoice == 4

                mov menuChoice, 3

            .ELSEIF menuChoice == 5

                mov menuChoice, 4

            .ELSEIF menuChoice == 1

                mov menuChoice, 1

            .ENDIF

        .ENDIF

    .ENDIF

    .IF al != 13

        jmp shuru

    .ENDIF

    .IF menuChoice == 1

        FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

            mov brik.drawn, 0
            mov brik.isHit, 0

        ENDM

        mov totalScore, 0
        mov numLives, 3

        clearScreen 0000b

        mov xleft, 0
        mov xright, 320
        mov ytop, 0
        mov ybot, 20
        mov color1, 1100b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 0,320,0,20,1100b,0100b

        mov si, offset lives
        mov xpos, 1
        mov ypos, 1
        mov color, 1111b

        call textWriter
    
        ;textWriter lives, 1,1, 1111b

        mov si, offset score
        mov xpos, 14
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter score, 14, 1, 1111b ;xpos,ypos,color

        mov si, offset playername
        mov xpos, 30
        mov ypos, 0
        mov color, 1111b

        call textWriter

        ;textWriter playername, 30, 0, 1111b ;xpos,ypos,color

        mov si, offset level
        mov xpos, 30
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter level,30,1,1111b

        ;gameBall ball<157,163,130,136>

        mov gameBall.xleft,157
        mov gameBall.xright,163
        mov gameBall.ytop,130
        mov gameBall.ybot,136

        ;gamePlayer player<120,180,180,185>

        mov gamePlayer.xleft,120
        mov gamePlayer.xright,180
        mov gamePlayer.ytop,180
        mov gamePlayer.ybot,185

        mov gameBall.xspeed, 1
        mov gameBall.yspeed, -1

        mov levelNum, 1
        mov gameLevel, 4

        mov gameLoop, 2

            mov freq, 1600
            mov thething, 65535
            call beep

            mov freq, 1400
            mov thething, 65535
            call beep

            mov freq, 1200
            mov thething, 65535
            call beep

            mov freq, 1000
            mov thething, 65535
            call beep

            mov freq, 800
            mov thething, 65535
            call beep

            mov freq, 600
            mov thething, 65535
            call beep

    .ENDIF

    .IF menuChoice == 2

        clearScreen 0000b

        mov xleft, 0
        mov xright, 320
        mov ytop, 0
        mov ybot, 20
        mov color1, 1100b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 0,320,0,20,1100b,0100b

        mov si, offset lives
        mov xpos, 1
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter lives, 1,1, 1111b

        mov si, offset score
        mov xpos, 14
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter score, 14, 1, 1111b ;xpos,ypos,color

        mov si, offset playername
        mov xpos, 30
        mov ypos, 0
        mov color, 1111b

        call textWriter

        ;textWriter playername, 30, 0, 1111b ;xpos,ypos,color

        mov si, offset level
        mov xpos, 30
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter level,30,1,1111b

        mov gameLoop, 2

    .ENDIF

    .IF menuChoice == 3

        clearScreen 0000b
        mov gameLoop, 4

    .ENDIF

    .IF menuChoice == 4

        clearScreen 0000b
        mov gameLoop, 5

    .ENDIF

    .IF menuChoice == 5

        clearScreen 0000b
        mov gameLoop, 6

    .ENDIF

    ret

mainmenu ENDP

instructionsPage PROC

    mov xleft, 100
    mov xright, 220
    mov ytop, 10
    mov ybot, 30
    mov color1, 1001b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 100,220,10,30,0011b,0010b ;papa tile

    mov si, offset instructions
    mov xpos, 14
    mov ypos, 2
    mov color, 1111b

    call textWriter

    ;textWriter instructions, 14, 2, 1111b

    mov si, offset ins1
    mov xpos, 1
    mov ypos, 5
    mov color, 1001b

    call textWriter

    ;textWriter ins1, 1, 5, 0011b

    mov si, offset ins2
    mov xpos, 1
    mov ypos, 6
    mov color, 1001b

    call textWriter

    ;textWriter ins2, 1, 6, 0011b

    mov si, offset ins3
    mov xpos, 1
    mov ypos, 9
    mov color, 1001b

    call textWriter

    ;textWriter ins3, 1, 9, 0011b

    mov si, offset ins4
    mov xpos, 1
    mov ypos, 10
    mov color, 1001b

    call textWriter

    ;textWriter ins4, 1, 10, 0011b

    mov si, offset ins5
    mov xpos, 1
    mov ypos, 13
    mov color, 1001b

    call textWriter

    ;textWriter ins5, 1, 13, 0011b

    mov si, offset ins6
    mov xpos, 1
    mov ypos, 14
    mov color, 1001b

    call textWriter

    ;textWriter ins6, 1, 14, 0011b

    mov si, offset ins7
    mov xpos, 1
    mov ypos, 17
    mov color, 1001b

    call textWriter

    ;textWriter ins7, 1, 17, 0011b
    ;borders

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 315,320,0,200,0011b,0010b;right border

    ripo:

    mov ah, 0
    int 16h

    push ax
    push bx
    push cx
    push dx

    mov freq, 400
    call beep

    pop dx
    pop cx
    pop bx
    pop ax

    .IF AL == 8

        mov gameLoop, 1
    
    .ELSEIF AL != 8

        JMP ripo

    .ENDIF

    ret

instructionsPage ENDP

highscoresPage PROC

    call fileReader

    mov xleft, 110
    mov xright, 220
    mov ytop, 20
    mov ybot, 37
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker
    
    ;tileMaker 110,220,20,37,0011b,0010b

    mov si, offset highscore
    mov xpos, 15
    mov ypos, 3
    mov color, 1111b

    call textWriter

    ;textWriter highscore, 15, 3, 1111b 


    ;highscore1

    mov si, offset index1
    mov xpos, 10
    mov ypos, 8
    mov color, 0100b

    call textWriter

    ;textWriter index1, 10, 8, 0100b

    mov si, offset firstName
    mov xpos, 15
    mov ypos, 8
    mov color, 0011b

    call textWriter

    ;textWriter name1, 15, 8, 0011b

    mov si, offset firstScore
    mov xpos, 25
    mov ypos, 8
    mov color, 0011b

    call textWriter

    ;textWriter score1, 25, 8, 0011b

    ;highscore2

    mov si, offset index2
    mov xpos, 10
    mov ypos, 10
    mov color, 0100b

    call textWriter

    ;textWriter index2, 10, 10, 0100b

    mov si, offset secondName
    mov xpos, 15
    mov ypos, 10
    mov color, 0011b

    call textWriter

    ;textWriter name2, 15, 10, 0011b

    mov si, offset secondScore
    mov xpos, 25
    mov ypos, 10
    mov color, 0011b

    call textWriter

    ;textWriter score2, 25, 10, 0011b

    ;highscore3

    mov si, offset index3
    mov xpos, 10
    mov ypos, 12
    mov color, 0100b

    call textWriter

    ;textWriter index3, 10, 12, 0100b

    mov si, offset thirdName
    mov xpos, 15
    mov ypos, 12
    mov color, 0011b

    call textWriter

    ;textWriter name3, 15, 12, 0011b

    mov si, offset thirdScore
    mov xpos, 25
    mov ypos, 12
    mov color, 0011b

    call textWriter

    ;textWriter score3, 25, 12, 0011b
    ;highscore4

    mov si, offset index4
    mov xpos, 10
    mov ypos, 14
    mov color, 0100b

    call textWriter

    ;textWriter index4, 10, 14, 0100b

    mov si, offset fourthName
    mov xpos, 15
    mov ypos, 14
    mov color, 0011b

    call textWriter

    ;textWriter name4, 15, 14, 0011b

    mov si, offset fourthScore
    mov xpos, 25
    mov ypos, 14
    mov color, 0011b

    call textWriter

    ;textWriter score4, 25, 14, 0011b
    ;highscore5

    mov si, offset index5
    mov xpos, 10
    mov ypos, 16
    mov color, 0100b

    call textWriter

    ;textWriter index5, 10, 16, 0100b

    mov si, offset fifthName
    mov xpos, 15
    mov ypos, 16
    mov color, 0011b

    call textWriter

    ;textWriter name5, 15, 16, 0011b

    mov si, offset fifthScore
    mov xpos, 25
    mov ypos, 16
    mov color, 0011b

    call textWriter

    ;textWriter score5, 25, 16, 0011b

    ;borders

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 1101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 1101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 1101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 1101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 315,320,0,200,0011b,0010b;right border

    oops:

    mov ah, 0
    int 16h

    push ax
    push bx
    push cx
    push dx

    mov freq, 400
    call beep

    pop dx
    pop cx
    pop bx
    pop ax

    .IF AL == 8

        mov gameLoop, 1
    
    .ELSEIF AL != 8

        JMP oops

    .ENDIF

    ret

highscoresPage ENDP

pausegame PROC

    clearScreen 0000b

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 315,320,0,200,0011b,0010b;right border

    mov si, offset pause
    mov xpos, 17
    mov ypos, 3
    mov color, 1111b

    call textWriter

    ;textWriter pause, 17, 3, 1111b

    mov menuChoice, 1

    poops:

    .IF menuChoice == 1

    mov xleft, 130
    mov xright, 190
    mov ytop, 65
    mov ybot, 86
    mov color1, 0011b
    mov color2, 0100b

    call tileMaker


    mov xleft, 90
    mov xright, 235
    mov ytop, 95
    mov ybot, 118
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker


    mov si, offset resume
    mov xpos, 17
    mov ypos, 9
    mov color, 1111b

    call textWriter

    

    mov si, offset btmainmenu
    mov xpos, 12
    mov ypos, 13
    mov color, 1111b

    call textWriter

    ;textWriter btmainmenu,12,13,1111b


    .ENDIF

    .IF menuChoice == 2

    mov xleft, 130
    mov xright, 190
    mov ytop, 65
    mov ybot, 86
    mov color1, 0011b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 130,190,65,86,0011b,0010b;new game

    mov xleft, 90
    mov xright, 235
    mov ytop, 95
    mov ybot, 118
    mov color1, 0011b
    mov color2, 0100b

    call tileMaker

    ;tileMaker 90,235,95,118,0011b,0100b;new game

    mov si, offset resume
    mov xpos, 17
    mov ypos, 9
    mov color, 1111b

    call textWriter

    ;textWriter resume, 17, 9, 1111b

    mov si, offset btmainmenu
    mov xpos, 12
    mov ypos, 13
    mov color, 1111b

    call textWriter

    ;textWriter btmainmenu,12,13,1111b
    ;borders

    .ENDIF

    mov ah, 0
    int 16h

    push ax
    push bx
    push cx
    push dx

    mov freq, 400
    call beep

    pop dx
    pop cx
    pop bx
    pop ax

    .IF AL == 13

        FOR brik, <b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20>

            mov brik.drawn, 0

        ENDM

        clearScreen 0000b

        mov xleft, 0
        mov xright, 320
        mov ytop, 0
        mov ybot, 20
        mov color1, 1100b
        mov color2, 0100b

        call tileMaker

        ;tileMaker 0,320,0,20,1100b,0100b

        mov si, offset lives
        mov xpos, 1
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter lives, 1,1, 1111b

        mov si, offset score
        mov xpos, 14
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter score, 14, 1, 1111b ;xpos,ypos,color

        mov si, offset playername
        mov xpos, 30
        mov ypos, 0
        mov color, 1111b

        call textWriter

        ;textWriter playername, 30, 0, 1111b ;xpos,ypos,color

        mov si, offset level
        mov xpos, 30
        mov ypos, 1
        mov color, 1111b

        call textWriter

        ;textWriter level,30,1,1111b
        mov gameLoop, 2
    
    .ELSEIF AL != 13

        .IF ah == 50h

            .IF menuChoice == 1

                mov menuChoice, 2

            .ENDIF

        .ELSEIF ah == 48h

            .IF menuChoice == 2

                mov menuChoice, 1

            .ENDIF

        .ENDIF

        JMP poops

    .ENDIF

    .IF menuChoice == 1



    .ELSEIF menuChoice == 2

        mov gameLoop, 1

    .ENDIF


    ret

pausegame ENDP

welcomePage PROC


    mov xleft, 100
    mov xright, 210
    mov ytop, 115
    mov ybot, 130
    mov color1, 0101b
    mov color2, 1001b

    call tileMaker

;;top rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 6
    mov ybot, 21 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 6
    mov ybot, 21
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 6
    mov ybot, 21
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 6
    mov ybot, 21
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 6
    mov ybot, 21
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 6
    mov ybot, 21
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;topend;;


;;bottom rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 180
    mov ybot, 195 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 180
    mov ybot, 195
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 180
    mov ybot, 195
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 180
    mov ybot, 195
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 180
    mov ybot, 195
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 180
    mov ybot, 195
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;bottomend;;


    ;;left rainbow

    ;;top
    mov xleft, 6
    mov xright, 21
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,6 
    mov xright, 21
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,6
    mov xright, 21
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;left end
   
   ;;right rainbow
    mov xleft, 298
    mov xright, 313
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,298 
    mov xright, 313
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,298
    mov xright,313
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
   ;;right end

    ;borders

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0101b
    mov color2, 1001b

    call tileMaker

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0101b
    mov color2, 1001b

    call tileMaker


    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 1001b

    call tileMaker

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 1001b

    call tileMaker


    mov si, offset w1
    mov xpos, 10
    mov ypos, 6
    mov color, 1001b

    call textWriter

   mov si, offset baby1
    mov xpos, 8
    mov ypos, 9
    mov color, 1001b

    call textWriter


    mov ah, 2
    mov dh, 117
    mov dl, 103
    mov bh, 0
    int 10h

    mov si,OFFSET playername

    again:

    mov ah, 0
    int 16h

        push ax
        push bx
        push cx
        push dx

        mov freq, 400
        call beep

        pop dx
        pop cx
        pop bx
        pop ax
        
        mov [si],al
        mov dl, al
        mov ah, 2
        int 21h
        inc si
        CMP al, 13
        jne again

    ret

welcomePage ENDP

gameover PROC

    clearScreen 0000b

    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker
    ;;top rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 6
    mov ybot, 21 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 6
    mov ybot, 21
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 6
    mov ybot, 21
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 6
    mov ybot, 21
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 6
    mov ybot, 21
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 6
    mov ybot, 21
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;topend;;


;;bottom rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 180
    mov ybot, 195 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 180
    mov ybot, 195
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 180
    mov ybot, 195
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 180
    mov ybot, 195
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 180
    mov ybot, 195
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 180
    mov ybot, 195
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;bottomend;;


    ;;left rainbow

    ;;top
    mov xleft, 6
    mov xright, 21
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,6 
    mov xright, 21
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,6
    mov xright, 21
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;left end
   
   ;;right rainbow
    mov xleft, 298
    mov xright, 313
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,298 
    mov xright, 313
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,298
    mov xright,313
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
   ;;right end


    ;tileMaker 315,320,0,200,0011b,0010b;right border
    ;text

    mov si, offset khatam_ta_ta
    mov xpos, 14
    mov ypos, 10
    mov color, 1100b

    call textWriter

    ;textWriter khatam_ta_ta, 14, 10, 1100b

    mov si, offset score
    mov xpos, 16
    mov ypos, 12
    mov color, 1111b

    call textWriter

    ;textWriter score, 16, 12,1111b

    mov si, offset scoreString
    mov xpos, 22
    mov ypos, 12
    mov color, 1111b

    call textWriter

    ;textWriter scoreString, 22, 12, 1111b

    mov ah, 2
    mov dh, 15
    mov dl, 20
    mov bh, 0
    int 10h

    mov dl, 1
    mov ah, 2
    int 21h
    
    mov ah,4ch
    int 21h

    ret

gameover ENDP


winner PROC



    clearScreen 0000b

    ;;top rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 6
    mov ybot, 21 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 6
    mov ybot, 21
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 6
    mov ybot, 21
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 6
    mov ybot, 21
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 6
    mov ybot, 21
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 6
    mov ybot, 21
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 6
    mov ybot, 21
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 6
    mov ybot, 21
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;topend;;


;;bottom rainbow
    mov xleft, 6
    mov xright, 36
    mov ytop, 180
    mov ybot, 195 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,37 
    mov xright, 67
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 68
    mov xright, 98
    mov ytop, 180
    mov ybot, 195
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 99
    mov xright, 129
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 130
    mov xright, 160
    mov ytop, 180
    mov ybot, 195
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 161
    mov xright, 191
    mov ytop, 180
    mov ybot, 195
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 192
    mov xright, 220
    mov ytop, 180
    mov ybot, 195
    mov color1, 1001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 221
    mov xright, 251
    mov ytop, 180
    mov ybot, 195
    mov color1, 0110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 252
    mov xright, 282
    mov ytop, 180
    mov ybot, 195
    mov color1, 0010b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 283
    mov xright, 313
    mov ytop, 180
    mov ybot, 195
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;bottomend;;


    ;;left rainbow

    ;;top
    mov xleft, 6
    mov xright, 21
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,6 
    mov xright, 21
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,6
    mov xright, 21
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 6
    mov xright, 21
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;left end
   
   ;;right rainbow
    mov xleft, 298
    mov xright, 313
    mov ytop, 22
    mov ybot, 48 
    mov color1, 1010b
    mov color2, 1000b

    call tileMaker

    ;;
     mov xleft,298 
    mov xright, 313
    mov ytop, 49
    mov ybot, 75
    mov color1, 1110b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft,298
    mov xright,313
    mov ytop, 76
    mov ybot, 102
    mov color1, 0001b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 103
    mov ybot, 129
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 130
    mov ybot, 154
    mov color1, 1011b
    mov color2, 1000b

    call tileMaker
    ;;
     mov xleft, 298
    mov xright, 313
    mov ytop, 155
    mov ybot, 180
    mov color1, 1100b
    mov color2, 1000b

    call tileMaker
   ;;right end


    mov xleft, 0
    mov xright, 320
    mov ytop, 0
    mov ybot, 4
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,0,4,0011b,0010b;top border

    mov xleft, 0
    mov xright, 320
    mov ytop, 196
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,320,196,200,0011b,0010b;bottom border

    mov xleft, 0
    mov xright, 4
    mov ytop, 0
    mov ybot, 200
    mov color1, 0101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 0,4,0,200,0011b,0010b;left border

    mov xleft, 315
    mov xright, 320
    mov ytop, 0
    mov ybot, 200
    mov color1, 1101b
    mov color2, 0010b

    call tileMaker

    ;tileMaker 315,320,0,200,0011b,0010b;right border
    ;text

    mov si, offset yay
    mov xpos, 14
    mov ypos, 10
    mov color, 1100b

    call textWriter

    ;textWriter khatam_ta_ta, 14, 10, 1100b

    mov si, offset score
    mov xpos, 16
    mov ypos, 12
    mov color, 1111b

    call textWriter

    ;textWriter score, 16, 12,1111b

    mov si, offset scoreString
    mov xpos, 22
    mov ypos, 12
    mov color, 1111b

    call textWriter

    ;textWriter scoreString, 22, 12, 1111b

    mov ah, 2
    mov dh, 15
    mov dl, 20
    mov bh, 0
    int 10h

    mov dl, 1
    mov ah, 2
    int 21h
    
    mov ah,4ch
    int 21h

    ret

winner ENDP

randomNumber PROC

   mov AH, 00h  ; interrupts to get system time        
   int 1AH      ; CX:DX now hold number of clock ticks since midnight      

   mov  ax, dx
   xor  dx, dx
   mov  cx, 240  ;here dx contains the remainder of the division - from 0 to 9    
   div  cx 
   add dx, 16

   ret

randomNumber ENDP

tileMaker PROC

    mov di, ytop  ;70,285,10,30,0001b,0010b

    .while di < ybot

        mov bx, xleft

        .while bx < xright

            mov x, bx
            mov y, di
            mov al, color1
            mov color3, al

            call pixelPrinter

            ;pixelPrinter bx, di, color1

            inc bx

        .endw

        inc di

    .endw

    mov bx, xleft

    .while bx < xright

        mov x, bx
        mov ax, ytop
        mov y, ax
        mov al, color2
        mov color3, al

        call pixelPrinter

        ;pixelPrinter bx, ytop, color2

        inc bx

    .endw

    mov bx, xleft

    mov di, xright
    inc di

    .while bx < di

        mov x, bx
        mov ax, ybot
        mov y, ax
        mov al, color2
        mov color3, al

        call pixelPrinter

        ;pixelPrinter bx, ybot, color2

        inc bx

    .endw

    mov bx, ytop

    .while bx < ybot

        mov ax, xleft
        mov x, ax
        mov y, bx
        mov al, color2
        mov color3, al

        call pixelPrinter

        ;pixelPrinter xleft, bx, color2

        inc bx

    .endw

    mov bx, ytop

    .while bx < ybot    

        mov ax, xright
        mov x, ax
        mov y, bx
        mov al, color2
        mov color3, al


        call pixelPrinter
        
        ;pixelPrinter xright, bx, color2

        inc bx

    .endw

    ret

tileMaker ENDP

textWriter PROC

    ;mov si, offset string

    mov ah, 2
    mov dh, ypos
    mov dl, xpos
    mov bh, 0
    int 10h

    mov dl, '$'

    .while [si] != dl

        mov ah, 0eh
        mov al, [si]
        mov bh, 0
        mov bl, color
        mov cx, 1
        int 10h

        inc si

    .endw

    ret

textWriter ENDP

pixelPrinter PROC

    mov cx, x
    mov dx, y

    mov al, color3
    mov ah, 0ch 
    int 10h

    ret

pixelPrinter ENDP

delay PROC

    mov si, 0

    .while si < time

        inc si

    .endw

    ret

delay ENDP

beep PROC

    mov     al, 182         ; meaning that we're about to load
    out     43h, al         ; a new countdown value

    mov     ax, freq       ; countdown value is stored in ax. It is calculated by 
                            ; dividing 1193180 by the desired frequency (with the
                            ; number being the frequency at which the main system
                            ; oscillator runs
    out     42h, al         ; Output low byte.
    mov     al, ah          ; Output high byte.
    out     42h, al               

    in      al, 61h         
                            ; to connect the speaker to timer 2
    or      al, 00000011b  
    out     61h, al         ; Send the new value
    mov bx, 2

pause1:
    ;mov cx, 65535
    mov cx, thething
pause2:
    dec cx
    jne pause2
    dec bx
    jne pause1
    in al, 61h

    and al, 11111100b
    out 61h, al

    ret

beep ENDP

convertStringToNum PROC

    mov cl, '$'
    mov bx, 0

    .while [si] != cl

        mov cx, 10

        mov ax, bx
        mul cx
        mov bx, ax

        mov cl, [si]
        sub cl, 48
        mov ch, 0
        add bx, cx
        inc si

        mov cl, '$'

    .endw

    ret

convertStringToNum ENDP

fileWriter PROC

    call fileReader

    mov arrayIndex, 0
    mov di, offset numArray

    mov si, offset firstScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax
    inc di
    inc di

    ;2nd num

    mov si, offset secondScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax
    inc di
    inc di

    ;thirdnum

    mov si, offset thirdScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax
    inc di
    inc di

    ;fourthNum

    mov si, offset fourthScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax
    inc di
    inc di

    ;FifthNum

    mov si, offset fifthScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax
    inc di
    inc di

    ;SixthNum

    mov si, offset sixthScore

    call convertStringToNum

    mov ax, bx

    mov bl, arrayIndex
    mov bh, 0

    mov[di + bx], ax

    mov si, offset numArray

    call sorter

    mov ah, 3dh
    mov dx, offset file
    mov al, 1
    int 21h
    mov handler, ax

    ;firstplayer

    mov ah, 40h
    mov bx, handler
    mov cx, 10
    mov dx, offset firstName
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 5
    mov dx, offset firstScore
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 2
    mov dx, offset firstLevel
    int 21h

    ;firstplayer

    mov ah, 40h
    mov bx, handler
    mov cx, 10
    mov dx, offset secondName
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 5
    mov dx, offset secondScore
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 2
    mov dx, offset secondLevel
    int 21h

    ;firstplayer

    mov ah, 40h
    mov bx, handler
    mov cx, 10
    mov dx, offset thirdName
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 5
    mov dx, offset thirdScore
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 2
    mov dx, offset thirdLevel
    int 21h

    ;firstplayer

    mov ah, 40h
    mov bx, handler
    mov cx, 10
    mov dx, offset fourthName
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 5
    mov dx, offset fourthScore
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 2
    mov dx, offset fourthLevel
    int 21h

    ;firstplayer

    mov ah, 40h
    mov bx, handler
    mov cx, 10
    mov dx, offset fifthName
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 5
    mov dx, offset fifthScore
    int 21h

    mov ah, 40h
    mov bx, handler
    mov cx, 2
    mov dx, offset fifthLevel
    int 21h

    mov ah, 3Eh
    mov bx, handler
    int 21h

    ret

fileWriter ENDP

sorter PROC

    loop1:

        mov cx, 0
        mov cl, numWords
        mov loop2Counter, 0
        sub cl, loop1Counter
        sub cl, 1

        loop2:

            mov bx,2

            mov ax, 0
            mov al, loop2Counter
            mul bx
            mov bx, ax

            mov ax, [si + bx]

            inc bx
            inc bx

            mov dx, [si + bx]

            CMP ax, dx
            JAE dontSwap

            mov [si + bx], ax
            dec bx
            dec bx
            mov [si + bx], dx

            mov ax, 0

            mov ah, 0
            mov al, loop2Counter
            mov di, 10
            mul di
            mov string1, ax
            mov di, offset firstName
            add string1, di

            mov ah, 0
            mov al, loop2Counter
            inc ax
            mov di, 10
            mul di
            mov string2, ax
            mov di, offset firstName
            add string2, di

            mov stringSwapCounter, 10

            call swapString

            ;;;;;;;;;;;;;;;;;;;;;

            mov ax, 0

            mov ah, 0
            mov al, loop2Counter
            mov di, 5
            mul di
            mov string1, ax
            mov di, offset firstScore
            add string1, di

            mov ah, 0
            mov al, loop2Counter
            inc ax
            mov di, 5
            mul di
            mov string2, ax
            mov di, offset firstScore
            add string2, di

            mov stringSwapCounter, 5

            call swapString

            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            mov ax, 0

            mov ah, 0
            mov al, loop2Counter
            mov di, 2
            mul di
            mov string1, ax
            mov di, offset firstLevel
            add string1, di

            mov ah, 0
            mov al, loop2Counter
            inc ax
            mov di, 2
            mul di
            mov string2, ax
            mov di, offset firstLevel
            add string2, di

            mov stringSwapCounter, 2

            call swapString

            ;;;;;;;;;;;;;;;;;;;;;;;;;;;

            mov si, offset numArray

            dontSwap:
            inc loop2Counter

        CMP cl, loop2Counter
        JNE loop2

        inc loop1Counter

        mov cx, 0
        mov cl, numWords
        dec cl
        mov ax, 0
        mov al, loop1Counter
        
    CMP cl, loop1Counter
    JNE loop1

    ret

sorter ENDP

swapString PROC

    stringSwapLoop:

        mov si, string1
        mov al, [si]
        mov si, string2
        mov bl, [si]

        mov si, string1
        mov [si], bl
        mov si, string2
        mov [si], al

        inc string1
        inc string2

        dec stringSwapCounter
        CMP stringSwapCounter, 0
        JNE stringSwapLoop


    ret

swapString ENDP

fileReader PROC

    mov ah, 3dh
    mov dx, offset file
    mov al,2
    int 21h
    mov handler, ax
    jnc next

    mov dl, 3
    mov ah, 2
    int 21h

    next:

    ;1

    mov ah, 3FH
    mov cx, 10
    mov dx, offset firstName
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 5
    mov dx, offset firstScore
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 2
    mov dx, offset firstLevel
    mov bx, handler
    int 21h

    ;2

    mov ah, 3FH
    mov cx, 10
    mov dx, offset secondName
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 5
    mov dx, offset secondScore
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 2
    mov dx, offset secondLevel
    mov bx, handler
    int 21h

    ;3

    mov ah, 3FH
    mov cx, 10
    mov dx, offset thirdName
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 5
    mov dx, offset thirdScore
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 2
    mov dx, offset thirdLevel
    mov bx, handler
    int 21h

    ;4

    mov ah, 3FH
    mov cx, 10
    mov dx, offset fourthName
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 5
    mov dx, offset fourthScore
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 2
    mov dx, offset fourthLevel
    mov bx, handler
    int 21h

    ;5

    mov ah, 3FH
    mov cx, 10
    mov dx, offset fifthName
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 5
    mov dx, offset fifthScore
    mov bx, handler
    int 21h

    mov ah, 3FH
    mov cx, 2
    mov dx, offset fifthLevel
    mov bx, handler
    int 21h

    mov ah, 3Eh
    mov bx, handler
    int 21h
    
    ret

fileReader ENDP

ballDrawer PROC

    ;firstline

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ;secondline

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ;thirdline

    MOV CX, xleft    ;(column)
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ;fourthline

    MOV CX, xleft    ;(column)
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ;secondline

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ;firstline

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    MOV CX, xleft    ;(column)
    inc cx
    inc cx
    inc cx
    inc cx
    MOV DX, ytop    ;(row)
    inc dx
    inc dx
    inc dx
    inc dx
    inc dx
    mov bh, 0
    MOV AL, color1  ;yellow color
    MOV AH, 0CH 
    INT 10H

    ret

ballDrawer ENDP

end

