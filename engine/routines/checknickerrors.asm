CheckNickErrors:: ; 669f
; error-check monster nick before use
; must be a peace offering to gamesharkers

; input: de = nick location
; 금 버전 추출
; 닉네임 에러 검사
	push bc
	push de
	ld b, MON_NAME_LENGTH
	ld c, MON_NAME_LENGTH / 2 ; 한글 전용(5글자)

.checkchar
; end of nick?
	ld a, [de]
	cp $0c
	jr c, .hangul

	cp "@" ; terminator
	jr z, .end

; check if this char is a text command
	ld hl, .textcommands
	dec hl
.loop
; next entry
	inc hl
; reached end of commands table?
	ld a, [hl]
	cp -1
	jr z, .done

; is the current char between this value (inclusive)...
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .loop
; ...and this one?
	cp [hl]
	jr nc, .loop

; replace it with a "?"
	ld a, "?"
	ld [de], a
	jr .loop
.hangul
	dec b
	jr z, .PlaceEnd

	inc de
.done
; next char
	inc de
; reached end of nick without finding a terminator?
	dec c
	jr z, .PlaceEnd

	dec b
	jr nz, .checkchar

; change nick to "?@"
.PlaceEnd
	ld a, "@"
	ld [de], a
.end
; if the nick has any errors at this point it's out of our hands
	pop de
	pop bc
	ret

.textcommands ; 66cf
; table defining which characters are actually text commands
; format:
	;      ≥           <
	db TX_START,   TX_BOX    + 1
	db "<PLAY_G>", "<JP_18>" + 1
	db "<NI>",     "<NO>"    + 1
	db "<ROUTE>",  "<GREEN>" + 1
	db "<ENEMY>",  "<ENEMY>" + 1
	db "<MOM>",    "<TM>"    + 1
	db "<ROCKET>", "┘"       + 1
	db -1 ; end
