LoadHangulFont::
	ld a, [rSVBK]
	push af
	ld a, 4
	ld [rSVBK], a

	call FindTileIndex
	call Mapping

	pop af
	ld [rSVBK], a
	ret

; ==========================================
FindTileIndex:
	push hl
.restart
	ld hl, wHangulTable - 2
	ld d, b
	ld e, c

.Increase@Compare
	inc l
	inc l

	ld a, $E8
	cp l
	jr z, .FullTable

; 빈 테이블 검사
	bit 7, [hl]
	jr nz, .NotEmpty

	ld a, b
	set 7, a
	ld [hl+], a
	ld a, c
	ld [hl-], a
	jr .setTile

; 중복된 테이블 검사
.NotEmpty
	ld a, [hl]
	res 7, a
	cp d
	jr nz, .Increase@Compare

	inc l
	ld a, [hl]
	cp e
	jr z, .FoundCompare

	dec l
	jr .Increase@Compare

; 빈 공간 만들고 재시도
.FullTable
	call UpdateTable
	jr .restart

.FoundCompare
	dec l
.setTile
	ld a, l
	ld [wHangulTile], a

	ld b, $08
	ld c, l
	ld a, 4
.getVramTile
	sla c
	rl b
	dec a
	jr nz, .getVramTile

; 반환값
; bc = vram 주소
	pop hl
	ret

; ==========================================
Mapping:
	ld a, d
	cp $0d
	jr nz, .hangul_mapping
	ld a, [wHangulTile]
	ld [hl+], a
	jr .end_mapping

.hangul_mapping
	push hl
	push bc
	ld bc, $ffec
	add hl, bc
	pop bc

; 타일 매핑
	ld a, [wHangulTile]
	ld [hl], a
	pop hl
	inc a
	ld [hl+], a
.end_mapping

; 뱅크
	ld a, d
	cp $0d
	jr nz, .hangul_bank
	ld a, BANK(Font)
	ld [wHangulFontBank], a
	jr .end_bank
	
.hangul_bank
	ld a, d
	and $c
	rrca
	rrca
	add $78
	ld [wHangulFontBank], a
.end_bank

; 주소
	ld a, d
	cp $0d
	jr nz, .hangul_address

	ld a, e
	sub $80
	ld d, 0
	ld e, a
	ld a, 3
.loop
	sla e
	rl d
	dec a
	jr nz, .loop

	ld a, d
	add $42
	ld d, a
	jr .end_address

.hangul_address
	ld a, d
	and a, 3
	add a, 4
	ld d, a
	ld a, 4
.loop_hangul
	sla e
	rl d
	dec a
	jr nz, .loop_hangul
.end_address

; 폰트그래픽 저장
; memcpy(wHangulFontTemp, wHangulFontBank:hl, 0x10);
	push hl
	push bc
	ld a, [wHangulFontBank]
	ld h, d
	ld l, e
	ld de, wHangulFontTemp
	ld bc, $10
	call FarCopyBytesDouble_DoubleBankSwitch

; 폰트 설정
	ld a, [wFontSetting]
	and a
	jr z, .endFontSetting
	cp 1
	jr z, .FontSetting_Inverse

; 팔레트 옮기기
	ld hl, wHangulFontTemp
	ld c, $10

.loop_Palette
	ld a, $ff
	ld [hl], a
	inc hl
	inc hl
	dec c
	jr nz, .loop_Palette
	jr .endFontSetting

; 반전
.FontSetting_Inverse
	ld hl, wHangulFontTemp
	ld c, $20

.loop_Inverse
	ld a, [hl]
	cpl
	ld [hl+], a
	dec c
	jr nz, .loop_Inverse

.endFontSetting
	pop bc
	pop hl

; hdma_src = wHangulFontTemp
	ld a, $d1
	ld [rHDMA1], a
	ld a, $00
	ld [rHDMA2], a

; hdma_dest = bc
	ld a, b
	ld [rHDMA3], a
	ld a, c
	ld [rHDMA4], a

; 출력
	ld a, [rLCDC]
	bit 7, a
	jr z, .NoRequest

	ld a, [rLCDC]
	bit 7, a
	jr z, .Request

.loop_LY
	ld a, [rLY]
	cp a, $8c
	jr nc, .loop_LY

.Request
	di
	ld a, $81
	ld [rHDMA5], a

	ld a, [rHDMA5]
	and $7f
	inc a
.loop_request
	push af
	call .delay
	pop af
	dec a
	jr nz, .loop_request

	ei
	ret

.NoRequest
	di
	ld a, 1
	ld [rHDMA5], a
	ei
	ret

.delay:
	ld a, $39
.loop_delay
	dec a
	jr nz, .loop_delay
	ret

; ==========================================
UpdateTable:
	push hl
	push bc

	ld bc, wTileMapEnd - wTileMap + 1
	ld hl, wHangulTable
	xor a

.TableInit
	res 7, [hl]
	inc l
	inc l

	cp l
	jr nz, .TableInit

	ld hl, wTileMap - 1

.TileMapCompare
	inc hl
	dec bc

	xor a
	cp c
	jr nz, .NotZero
	cp b
	jr z, .EndCompare

.NotZero
	bit 7, [hl]
	jr z, .TileMapCompare

	ld a, [hl]
	and a, 1
	jr nz, .TileMapCompare

	push hl
	ld a, [hl]
	ld h, $D0
	ld l, a
	set 7, [hl]
	pop hl

	jr .TileMapCompare

.EndCompare
	pop bc
	pop hl
	ret