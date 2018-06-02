PlaceWaitingText:: ; 4000
	hlcoord 3, 10
	ld b, 1
	ld c, 11

	ld a, [wBattleMode]
	and a
	jr z, .notinbattle

	call TextBox
	jr .proceed

.notinbattle
	predef LinkTextboxAtHL

.proceed
	hlcoord 4, 11
	ld de, .Waiting
	call PlaceString
	ld c, 50
	jp DelayFrames

.Waiting: ; 4025
	; db "통신대기중!@"
	db $09, $BB, $06, $65, $02, $EB, $01, $B2, $08, $0F, $0B, $66, "@"
