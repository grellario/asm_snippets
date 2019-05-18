; NASM
section     .text
global      _start


byte_to_hex:				; Converts a BYTE in AL into its HEX equivalent into AH:AL
	push	edx
	push	esi
	sub	esp, 0x02
	xor	edx, edx

	mov	dl, al
	and	dl, 0x0F
	mov	esi, hex
	add	esi, edx
	mov	dl, BYTE [esi]
	mov	BYTE [esp + 0x00], dl

	mov	dl, al
	shr	dl, 0x04
	and	dl, 0x0F
	mov	esi, hex
	add	esi, edx
	mov	dl, BYTE [esi]
	mov	BYTE [esp + 0x01], dl

	mov	ax, WORD [esp]

	add	esp, 0x02
	pop	esi
	pop	edx
	ret

worker:
	mov	eax, 0xAB
	call	byte_to_hex
	mov	[outs + 0], BYTE '0'
	mov	[outs + 1], BYTE 'x'
	mov	[outs + 2], BYTE ah
	mov	[outs + 3], BYTE al
	mov	[outs + 4], BYTE 0x0A
	mov	edx, 0x05
	mov	ecx, outs
	mov	ebx, 0x01
	mov	eax, 0x04
	int	0x80
	ret

leave:
	mov	eax, 0x01
	int	0x80
	ret

_start:
	call	worker
	call	leave
	ret

section .data

hex	db 	'0123456789ABCDEF'

section .bss

outs	resb 0x05
