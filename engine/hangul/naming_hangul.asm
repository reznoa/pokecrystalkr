; 금버전 추출
wkC5D0 EQUS "wNamingScreenDestinationPointer"
wkC5D2 EQUS "wNamingScreenCurrNameLength"
wkC5D3 EQUS "wNamingScreenMaxNameLength"
wkC5D7 EQUS "wNamingScreenLastCharacter"
asm_5C00:
	call asm_5EAD
	dec hl
	ld a, [hl-]
	ld b, [hl]
	ld c, a
	cp $FF
	jr nz, .asm_5C12
	ld a, b
	cp $0B
	jr nz, .asm_5C12
	scf
	ret

.asm_5C12
	sla c
	rl b
	ld hl, $4000;?
	add hl, bc
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	and b
	cp $FF
	jr nz, .asm_5C24
	and a
	ret
	
.asm_5C24
	ld a, b
	and $7C
	ret  z
	cp $04
	ret  z
	cp $10
	ret  z
	cp $20
	ret  z
	cp $44
	ret  z
	scf
	ret
	
asm_5C36:
	ld a, [wkC5D7]
	cp $7F
	jr nz, .asm_5C41
	ld bc, $0BFF;??
	ret

.asm_5C41
	cp $E6
	jr nz, .asm_5C49
	ld bc, $0B67
	ret

.asm_5C49
	cp $E7
	jr nz, .asm_5C51
	ld bc, $0B66
	ret

.asm_5C51
	cp $F6
	jr c, .asm_5C5B
	sub $06
	ld c, a
	ld b, $0B
	ret

.asm_5C5B
	ld a, [wkC5D2]
	and a
	jr nz, .asm_5C6A
	ld a, [wkC5D7]
	sub $A0
	ld c, a
	ld b, $0B
	ret

.asm_5C6A
	add sp, $FA
	ld hl, .asm_5C72
	push hl
	jr .asm_5C75

.asm_5C72
	add sp, $06
	ret  

.asm_5C75
	ld a, [wkC5D7]
	sub $A0
	ld c, a
	ld b, $0B
	ld hl, sp+$02
	ldi [hl], a
	ld [hl], b
	sla c
	rl b
	ld hl, $4000;?
	add hl, bc
	ld a, [hl+]
	ld b, [hl]
	ld hl, sp+$04
	ldi [hl], a
	ld [hl], b
	ld a, [wkC5D7]
	cp $C0
	rl a
	and $01
	ld hl, sp+$06
	ld [hl], a
	ld hl, wkC5D2
	dec [hl]
	dec [hl]
	call asm_5EAD
	ld a, [hl+]
	ld c, [hl]
	ld b, a
	sla  c
	rl   b
	ld hl, $4000;?
	add hl, bc
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	and b
	cp $FF
	jr nz,function_5CC1

asm_5CB6:
	ld hl, wkC5D2
	inc [hl]
	inc [hl]
	ld hl, sp+$02
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	ret
function_5CC1:
.asm_5CC1
	ld a, b
	and $7F
	jr nz, .asm_5CDE
	ld a, c
	and $E0
	jr nz, .asm_5CDE
	ld hl, sp+$06
	bit 0, [hl]
	jr z, .asm_5CD3
	jr asm_5CB6

.asm_5CD3
	ld hl, sp+$04
	ld a, [hl+]
	or c
	ld c, a
	ld a, [hl]
	or b
	ld b, a
	jp asm_5E21

.asm_5CDE
	ld a, b
	and $7C
	jr nz, .asm_5CEA
	ld a, c
	and $1F
	jr nz, .asm_5CEA
	jr asm_5CB6

.asm_5CEA
	ld a, b
	and $7C
	jr nz, .asm_5D0E
	ld hl, sp+$06
	bit 0, [hl]
	jr z, .asm_5D0C
	ld hl, sp+$02
	ld a, [hl]
	ld e,a
	ld d, $00
	sla e
	rl d
	ld hl, asm_5e4F
	add hl, de
	ld a, [hl+]
	or c
	ld c, a
	ld a, [hl]
	or b
	ld b, a
	jp asm_5E21

.asm_5D0C
	jr asm_5CB6

.asm_5D0E
	ld hl, sp+$06
	bit 0, [hl]
	jp z, asm_5DC8
	ld hl, sp+$04
	ld a, [hl]
	and $1F
	ld e, a
	ld a, b
	and $7C
	cp $04
	jr nz, .asm_5D31
	ld a, e
	cp $0A
	jp nz, asm_5CB6
	ld a, b
	and $03
	or $0C
	ld b, a
	jp asm_5E21

.asm_5D31
	cp $10
	jr nz, .asm_5D51
	ld a, e
	cp $0D
	jr nz, .asm_5D43
	ld a, b
	and $03
	or $14
	ld b, a
	jp asm_5E21

.asm_5D43
	cp $13
	jp nz, asm_5CB6
	ld a, b
	and $03
	or $18
	ld b, a
	jp asm_5E21

.asm_5D51
	cp $20
	jr nz, .asm_5DB2
	ld a, e
	cp $01
	jr nz, .asm_5D63
	ld a, b
	and $03
	or $24
	ld b, a
	jp asm_5E21

.asm_5D63
	cp $07
	jr nz, .asm_5D70
	ld a, b
	and $03
	or $28
	ld b, a
	jp asm_5E21

.asm_5D70
	cp $08
	jr nz, .asm_5D7D
	ld a, b
	and $03
	or $2C
	ld b, a
	jp asm_5E21

.asm_5D7D
	cp $0A
	jr nz, .asm_5D8A
	ld a, b
	and $03
	or $30
	ld b, a
	jp asm_5E21

.asm_5D8A
	cp $11
	jr nz, .asm_5D97
	ld a, b
	and $03
	or $34
	ld b, a
	jp asm_5E21

.asm_5D97
	cp $12
	jr nz, .asm_5DA4
	ld a, b
	and $03
	or $38
	ld b, a
	jp asm_5E21

.asm_5DA4
	cp $13
	jp nz, asm_5CB6
	ld a, b
	and $03
	or $3C
	ld b, a
	jp asm_5E21

.asm_5DB2
	cp $44
	jr nz, .asm_5DC5
	ld a, e
	cp $0A
	jp nz,asm_5CB6
	ld a, b
	and $03
	or $48
	ld b, a
	jp asm_5E21

.asm_5DC5
	jp asm_5CB6

asm_5DC8:
	ld hl, wkC5D2
	inc [hl]
	inc [hl]
	ld a, [wkC5D3]
	ld e, a
	ld a, [wkC5D2]
	cp e
	ret nc
	ld hl, wkC5D2
	dec [hl]
	dec [hl]
	ld a, b
	and $7C
	ld e, a
	ld d, $00
	srl e
	rr d
	srl e
	rr d
	push bc
	ld hl, asm_5E91
	add hl, de
	ld c, [hl]
	ld hl, sp+$06
	ld a, [hl+]
	and $E0
	or c
	ld c, a
	ld b, [hl]
	push de
	call asm_5E28
	pop de
	pop hl
	jp nc, asm_5CB6
	push bc
	ld c, l
	ld b, h
	ld hl, asm_5E75
	add hl, de
	ld a, b
	and $03
	or [hl]
	ld b, a
	call asm_5E28
	pop hl
	jp nc, asm_5CB6
	push hl
	call asm_5EAD
	ld a, b
	ldi [hl], a
	ld [hl], c
	ld hl, wkC5D2
	inc [hl]
	inc [hl]
	pop bc
	ret

asm_5E21:
	call asm_5E28
	jp nc, asm_5CB6
	ret

asm_5E28:
	ld hl, $4200;??
	ld d, $0A

.asm_5E2D
	ld e, $00

.asm_5E2F
	ld a, [hl]
	cp c
	jr nz, .asm_5E45
	inc hl
	ld a, [hl+]
	cp b
	jr nz, .asm_5E47
	ld de, $C000
	add hl, de
	srl h
	rr l
	dec hl
	ld c, l
	ld b, h
	scf
	ret

.asm_5E45
	inc hl
	inc hl

.asm_5E47
	dec e
	jr nz, .asm_5E2F
	dec d
	jr nz, .asm_5E2D
	and a
	ret

asm_5e4F:
	db $00, $04
	db $00, $10
	db $00, $1C
	db $00, $20
	db $00, $40
	db $00, $44
	db $00, $4C
	db $00, $54
	db $00, $58
	db $00, $5C
	db $00, $60
	db $00, $64
	db $00, $68
	db $00, $6C
	db $00, $08
	db $00, $7C
	db $00, $7C
	db $00, $50
	db $00, $7C

asm_5E75:
	db $00, $00
	db $00, $04
	db $00, $10
	db $10, $00
	db $00, $20
	db $20, $00
	db $20, $20
	db $20, $20
	db $20, $00
	db $00, $44
	db $00, $00
	db $00, $00
	db $00, $00
	db $00, $00

asm_5E91:
	db $00, $01, $02, $0A, $03, $0D, $13, $04
	db $06, $01, $07, $08, $0A, $11, $12, $13
	db $07, $08, $0A, $0A, $0B, $0C, $0D, $0F
	db $10, $11, $12, $13

asm_5EAD:
	push af
	ld hl, wkC5D0
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, [wkC5D2]
	ld e, a
	ld d, $00
	add hl, de
	pop af
	ret

asm_5EBD:;?
	ld hl, wkC5D2
	dec [hl]
	dec [hl]
	call asm_5EAD
	ld a, [hl+]
	ld c, [hl]
	ld b, a
	sla c
	rl b
	ld hl, $4000;?
	add hl, bc
	ld a, [hl+]
	ld b, [hl]
	ld c, a
	and b
	cp $FF
	jr nz,function_5EEF

asm_5ED8:
	call asm_5EAD
	ld [hl], $0B
	inc hl
	ld [hl], $3E
	inc hl
	ld a, [hl+]
	cp $0B
	ret nz
	ld a, [hl-]
	cp $3E
	ret nz
	ld [hl], $0B
	inc hl
	ld [hl], $3F
	ret
function_5EEF:
.asm_5EEF
	ld a, b
	and $7C
	jr z, .asm_5F06
	ld hl, asm_5F93
	srl  a
	srl  a
	ld e, a
	ld d, $00
	add hl, de
	ld a, b
	and $03
	or [hl]
	ld b, a
	jr .asm_5F61

.asm_5F06
	ld a, b
	and $03
	jr nz, .asm_5F10
	ld a, c
	and $E0
	jr z, asm_5ED8

.asm_5F10
	call asm_5EAD
	ld [hl], $0B
	inc hl
	ld [hl], $3E
	inc hl
	ld a, [hl+]
	cp $0B
	jr nz, .asm_5F28
	ld a, [hl-]
	cp $3E
	jr nz, .asm_5F28
	ld [hl], $0B
	inc hl
	ld [hl], $3F

.asm_5F28
	ld b, $00
	ld a, c
	and $1F
	ret  z
	ld c, a
	ld hl, asm_5FAF
	add hl, bc
	ld a, [hl]
	ld [wkC5D7],a
	call asm_5C36
	ld a, [wkC5D3]
	ld e,a
	ld a, [wkC5D2]
	cp e
	ret  nc
	call asm_5EAD
	ld a, b
	ldi [hl], a
	ld [hl], c
	ld hl, wkC5D2
	inc [hl]
	inc [hl]
	call asm_5EAD
	ld a, [hl]
	cp $50
	jr z, .asm_5F5D
	ld [hl], $0B
	inc hl
	ld [hl], $3E
	and a
	ret  

.asm_5F5D
	call asm_5C00
	ret

.asm_5F61
	ld hl, $4200;?
	ld d, $0B
.asm_5F66
	ld e, $00
.asm_5F68
	ld a, [hl]
	cp c
	jr nz, .asm_5F88
	inc hl
	ld a, [hl+]
	cp b
	jr nz, .asm_5F8A
	ld de, $C000;?
	add hl, de
	srl h
	rr l
	dec hl
	ld c, l
	ld b, h
	call asm_5EAD
	ld a, b
	ldi [hl], a
	ld [hl], c
	ld hl, wkC5D2
	inc [hl]
	inc [hl]
	ret

.asm_5F88
	inc hl
	inc hl

.asm_5F8A
	dec e
	jr nz, .asm_5F68
	dec d
	jr nz, .asm_5F66
	jp asm_5ED8

asm_5F93:
	db $00, $00, $00, $04, $00, $10, $10, $00
	db $00, $20, $20, $20, $20, $20, $20, $20
	db $00, $00, $44, $00, $00, $00, $00, $00
	db $00, $00, $00, $00

asm_5FAF: 
	;" ㄱㄲㄴㄷㄸㄹㅁ"
	db $7F, $A0, $AE, $A1, $A2, $AF, $A3, $A4
	;"ㅂㅃㅅㅆㅇㅈㅉㅊ"
	db $A5, $B0, $A6, $B1, $A7, $A8, $B2, $A9
	;ㅋㅌㅍㅎ"
	db $AA, $AB, $AC, $AD