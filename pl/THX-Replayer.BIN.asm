����  *f                                    ;-------------------T-----------T-----------------T---------T---------------

;=============================================================================
;=============================================================================
;===================== t h x - s o u n d   s y s t e m =======================
;=============================================================================
;=================== r e p l a y e r - t e s t   c o d e =====================
;=============================================================================
;=============================================================================
;========================= v e r s i o n   1 . 2 7 ===========================
;=============================================================================
;=============================================================================

	IncDIR	"work:thx/"
	Include	"THX-Offsets.I"


	Section	Dexter\Abyss_rulez,Code

Start	movem.l	d1-d7/a0-a6,-(sp)

.InitPlayer	sub.l	a0,a0	;auto-allocate public (fast)
	sub.l	a1,a1	;auto-allocate chip
	jsr	thxReplayer+thxInitPlayer

	move	#$f00,d0
	bsr	colo

.InitModule	lea	thxodule,a0	;module
	jsr	thxReplayer+thxInitModule

	move	#$0f0,d0
	bsr	colo


.InitSubSong	moveq	#0,d0	;Subsong #0 = Mainsong
	moveq	#0,d1	;Play immediately
	jsr	thxReplayer+thxInitSubSong

	move	#$fff,d0
	bsr	colo

.InitCIA	lea	thxCIAInterrupt,a0
	moveq	#0,d0
	jsr	thxReplayer+thxInitCIA
	tst	d0
	bne.b	.thxInitFailed

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	

.thxLetHimPlay
.r	cmp.b	#$80,$dff006
	bne.b	.r
	jsr	thxReplayer+thxInterrupt

	btst	#6,$bfe001
	bne.b	.thxLetHimPlay

.RemoveCIA	jsr	thxReplayer+thxKillCIA	;don't forget!

.thxInitFailed

.StopSong	jsr	thxReplayer+thxStopSong

.KillPlayer	jsr	thxReplayer+thxKillPlayer	;don't forget!

	movem.l	(sp)+,d1-d7/a0-a6
	moveq	#0,d0
	RTS

thxCIAInterrupt	move	#0,$dff180
	;jsr	thxReplayer+thxInterrupt
	move	#$aaa,$dff180
	RTS

colo	moveq	#-1,d1
.ro	move	d0,$dff180
	dbf	d1,.ro
	rts

	Section	Pink\Abyss_rulez,Data
thxodule	IncBIN	"music:thx/carpe noctem/THX.the fugitive"
 even

	Section	Pink\Abyss_rul,code

thxReplayer	
;thxReplayer	IncBIN	THX-Replayer.BIN

ALKU


lbC000000	bra.w	lbC000034

	bra.w	lbC0002A0

	bra.w	lbC0004C2

	bra.w	lbC00056C

	bra.w	lbC000668

	bra.w	lbC00061E

	bra.w	lbC000272

	bra.w	lbC000136

lbW000020	dcb.w	2,0
lbL000024	dc.l	0
lbL000028	dc.l	0
lbL00002C	dcb.l	2,0

lbC000034	lea	(lbC000000,PC),A4
	move.l	A0,($198,A4)
	tst.w	D0
	beq.b	lbC000044
	moveq	#-1,D0
	rts

lbC000044	lea	(THXSoundSyste.MSG,PC),A0
	move.l	A0,($172,A4)
	lea	(lbL000186,PC),A0
	move.l	A0,($176,A4)
	lea	(lbC00017E,PC),A0
	move.l	A0,($17A,A4)
	lea	(ciaaresource.MSG,PC),A1
	move.l	A1,-(SP)
	move.b	#$61,(3,A1)
	moveq	#0,D0
	move.l	(4).W,A6
	jsr	(-$1F2,A6)
	lea	(lbC000000,PC),A4
	move.l	D0,($1A2,A4)
	move.l	(SP)+,A1
	move.b	#$62,(3,A1)
	moveq	#0,D0
	jsr	(-$1F2,A6)
	lea	(lbC000000,PC),A4
	move.l	D0,($1A6,A4)
	move.w	#$3781,($19C,A4)
	lea	($BFE001).L,A3
	lea	(lbL000168,PC),A4
	moveq	#0,D6
	move.l	(lbL0001A2,PC),A6
	lea	(A4),A1
	move.l	D6,D0
	jsr	(-6,A6)
	tst.l	D0
	beq.b	lbC0000FC
	lea	(A4),A1
	moveq	#1,D6
	move.l	D6,D0
	jsr	(-6,A6)
	tst.l	D0
	beq.b	lbC0000FC
	lea	($BFD000).L,A3
	moveq	#0,D6
	move.l	(lbL0001A6,PC),A6
	lea	(A4),A1
	move.l	D6,D0
	lea	(lbC000000,PC),A4
	move.l	D0,($19E,A4)
	jsr	(-6,A6)
	tst.l	D0
	beq.b	lbC0000FC
	lea	(A4),A1
	moveq	#1,D6
	move.l	D6,D0
	lea	(lbC000000,PC),A4
	move.l	D0,($19E,A4)
	jsr	(-6,A6)
	tst.l	D0
	beq.b	lbC0000FC
	moveq	#-1,D0
	bra.w	lbC000134

lbC0000FC	lea	(lbC000000,PC),A4
	move.l	A3,($1AA,A4)
	move.l	A6,($1AE,A4)
	move.b	D6,($1B2,A4)
	lea	($400,A3),A2
	tst.b	D6
	beq.b	lbC000118
	lea	($600,A3),A2
lbC000118	move.b	(lbB00019D,PC),(A2)
	move.b	(lbB00019C,PC),($100,A2)
	lea	($E00,A3),A2
	tst.b	D6
	beq.b	lbC00012E
	lea	($F00,A3),A2
lbC00012E	move.b	#$11,(A2)
	moveq	#0,D0
lbC000134	rts

lbC000136	move.l	(lbL0001AA,PC),A3
	lea	(lbC000000,PC),A4
	tst.b	($1B2,A4)
	bne.b	lbC00014C
	move.b	#0,($E00,A3)
	bra.b	lbC000152

lbC00014C	move.b	#0,($F00,A3)
lbC000152	move.l	(lbL0001AE,PC),A6
	lea	(lbL000168,PC),A1
	lea	(lbC000000,PC),A4
	move.l	($19E,A4),D0
	jsr	(-12,A6)
	rts

lbL000168	dcb.l	2,0
	dc.l	$2000000
	dcb.l	2,0
	dc.w	0

lbC00017E	jsr	(-$B4,A6)
	moveq	#0,D0
	rts

lbL000186	dcb.l	2,0
	dc.w	$200
	dcb.w	2,0
	dc.l	$BFE001
	dc.l	0
lbB00019C	dc.b	0
lbB00019D	dcb.b	5,0
lbL0001A2	dc.l	0
lbL0001A6	dc.l	0
lbL0001AA	dc.l	0
lbL0001AE	dc.l	0
	dc.b	0
ciaaresource.MSG	dc.b	'ciaa.resource',0
THXSoundSyste.MSG	dc.b	'THX Sound System (tm)',0,0

lbC0001D8	move.l	(lbL000024,PC),A5
	move.l	(lbW000020,PC),A6
	moveq	#8,D0
	lea	(0,A5),A3
	lea	($1CB4,A6),A4
	moveq	#3,D7
lbC0001EC	move.l	A3,($4C,A6,D0.W)
	move.l	A4,($50,A6,D0.W)
	add.w	#$280,A3
	add.w	#$80,A4
	add.w	#$5C,D0
	dbra	D7,lbC0001EC
	lea	($DFF000).L,A5
	move.w	#15,($96,A5)
	moveq	#$4F,D7
lbC000212	move.l	(4,A5),D0
	and.l	#$1FF00,D0
lbC00021C	move.l	(4,A5),D1
	and.l	#$1FF00,D1
	cmp.l	D0,D1
	beq.b	lbC00021C
	dbra	D7,lbC000212
	lea	(8,A6),A0
	lea	($A0,A5),A3
	moveq	#3,D7
lbC000238	move.w	#$88,(6,A3)
	move.l	($4C,A0),(A3)
	move.w	#0,(8,A3)
	move.w	#$140,(4,A3)
	add.w	#$5C,A0
	add.w	#$10,A3
	dbra	D7,lbC000238
	move.w	#$800F,($96,A5)
	bset	#1,($BFE001).L
	move.w	#$FF,($DFF09E).L
	rts

lbC000272	movem.l	D0-D7/A0-A6,-(SP)
	move.l	(lbL000028,PC),D0
	beq.b	lbC000288
	move.l	(4).W,A6
	move.l	(lbW000020,PC),A1
	jsr	(-$D2,A6)
lbC000288	move.l	(lbL00002C,PC),D0
	beq.b	lbC00029A
	move.l	(4).W,A6
	move.l	(lbL000024,PC),A1
	jsr	(-$D2,A6)
lbC00029A	movem.l	(SP)+,D0-D7/A0-A6
	rts

lbC0002A0	movem.l	D0-D7/A0-A6,-(SP)
	lea	(lbC000000,PC),A5
	move.l	A1,($24,A5)
	move.l	A0,($20,A5)
	bne.b	lbC0002CE
	move.l	(4).W,A6
	move.l	#$1EB4,D0
	move.l	D0,($28,A5)
	move.l	#$10000,D1
	jsr	(-$C6,A6)
	move.l	D0,($20,A5)
lbC0002CE	lea	(lbL000024,PC),A6
	tst.l	(A6)
	bne.b	lbC0002F2
	move.l	(4).W,A6
	move.l	#$A00,D0
	move.l	D0,($2C,A5)
	move.l	#$10002,D1
	jsr	(-$C6,A6)
	move.l	D0,($24,A5)
lbC0002F2	move.l	(lbW000020,PC),A1
	lea	($334,A1),A1
	moveq	#5,D3
	moveq	#4,D2
lbC0002FE	move.w	D2,D5
	lsr.w	#2,D5
	move.l	#$80,D1
	divu	D5,D1
	subq.w	#1,D5
	move.w	D2,D4
	lsr.w	#1,D4
	neg.w	D4
	move.l	#$80,D6
	divu	D2,D6
	subq.w	#1,D6
	bsr.w	lbC00047A
	lsl.w	#1,D2
	dbra	D3,lbC0002FE
	moveq	#$1F,D6
lbC000328	move.w	#3,D7
	move.w	#$55,D2
	move.w	#$FF80,D0
lbC000334	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC000334
	dbra	D6,lbC000328
	moveq	#15,D6
lbC000342	move.w	#7,D7
	move.w	#$24,D2
	move.w	#$FF80,D0
lbC00034E	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC00034E
	dbra	D6,lbC000342
	moveq	#7,D6
lbC00035C	move.w	#15,D7
	move.w	#$11,D2
	move.w	#$FF80,D0
lbC000368	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC000368
	dbra	D6,lbC00035C
	moveq	#3,D6
lbC000376	move.w	#$1F,D7
	move.w	#8,D2
	move.w	#$FF80,D0
lbC000382	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC000382
	dbra	D6,lbC000376
	moveq	#1,D6
lbC000390	move.w	#$3F,D7
	move.w	#4,D2
	move.w	#$FF80,D0
lbC00039C	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC00039C
	dbra	D6,lbC000390
	moveq	#0,D6
lbC0003AA	move.w	#$7F,D7
	move.w	#2,D2
	move.w	#$FF80,D0
lbC0003B6	move.b	D0,(A1)+
	add.b	D2,D0
	dbra	D7,lbC0003B6
	dbra	D6,lbC0003AA
	move.l	(lbW000020,PC),A1
	lea	($934,A1),A1
	move.w	#$7F,D7
	move.w	#$FF80,D0
lbC0003D2	move.b	D0,(A1)+
	dbra	D7,lbC0003D2
	move.w	#$7F,D7
	move.w	#$7F,D0
lbC0003E0	move.b	D0,(A1)+
	dbra	D7,lbC0003E0
	move.l	(lbW000020,PC),A1
	lea	($A34,A1),A1
	move.w	#$127F,D7
	move.l	#$41595321,D0
lbC0003F8	btst	#8,D0
	beq.b	lbC00040E
	tst.w	D0
	bmi.b	lbC000408
	move.b	#$7F,(A1)+
	bra.b	lbC000410

lbC000408	move.b	#$80,(A1)+
	bra.b	lbC000410

lbC00040E	move.b	D0,(A1)+
lbC000410	ror.l	#5,D0
	eor.b	#$9A,D0
	move.w	D0,D1
	rol.l	#2,D0
	add.w	D0,D1
	eor.w	D1,D0
	ror.l	#3,D0
	dbra	D7,lbC0003F8
	move.l	(lbW000020,PC),A6
	move.b	#$40,(1,A6)
	lea	($334,A6),A0
	move.l	A0,($324,A6)
	lea	($634,A6),A0
	move.l	A0,($328,A6)
	lea	($A34,A6),A0
	move.l	A0,($330,A6)
	lea	(lbW000FB4,PC),A0
	lea	($190,A6),A1
	lea	($1D0,A6),A2
	moveq	#$10,D7
lbC000454	move.w	(A0),(A1)+
	move.w	(A0)+,(A2)+
	dbra	D7,lbC000454
	sub.w	#2,A0
	moveq	#14,D7
lbC000462	move.w	(-2,A0),(A1)+
	move.w	-(A0),(A2)+
	dbra	D7,lbC000462
	moveq	#$1F,D7
lbC00046E	neg.w	(A1)+
	dbra	D7,lbC00046E
	movem.l	(SP)+,D0-D7/A0-A6
	rts

lbC00047A	move.w	D5,D7
	moveq	#0,D0
lbC00047E	move.b	D0,(A1)+
	add.w	D1,D0
	dbra	D7,lbC00047E
	move.b	#$7F,(A1)+
	move.w	D5,D7
	beq.b	lbC00049C
	subq.w	#1,D7
	move.w	#$80,D0
lbC000494	sub.w	D1,D0
	move.b	D0,(A1)+
	dbra	D7,lbC000494
lbC00049C	move.w	D5,D7
	addq.w	#1,D7
	lea	(A1,D4.W),A2
	add.w	D7,D7
	subq.w	#1,D7
lbC0004A8	move.b	(A2)+,(A1)
	cmp.b	#$7F,(A1)
	bne.b	lbC0004B6
	move.b	#$80,(A1)+
	bra.b	lbC0004B8

lbC0004B6	neg.b	(A1)+
lbC0004B8	dbra	D7,lbC0004A8
	dbra	D6,lbC00047A
	rts

lbC0004C2	movem.l	D0-D7/A0-A6,-(SP)
	lea	(lbC000000,PC),A5
	move.l	A0,($30,A5)
	cmp.l	#$54485800,(A0)+
	bne.w	lbC000568
	move.l	(lbW000020,PC),A6
	addq.w	#2,A0
	move.w	(A0)+,D1
	btst	#15,D1
	sne	(7,A6)
	bclr	#15,D1
	move.w	D1,($21A,A6)
	move.w	(A0)+,($218,A6)
	move.b	(A0)+,($17D,A6)
	move.b	(A0)+,($213,A6)
	move.b	(A0)+,($211,A6)
	move.b	(A0)+,D3
	move.b	D3,(2,A6)
	beq.b	lbC000514
	move.l	A0,($320,A6)
	and.w	#$FF,D3
	add.w	D3,D3
	add.w	D3,A0
lbC000514	clr.w	($216,A6)
	move.l	A0,($21C,A6)
	move.w	($21A,A6),D3
	lsl.w	#3,D3
	add.w	D3,A0
	move.l	A0,($220,A6)
	move.w	($212,A6),D7
	tst.b	(7,A6)
	bne.b	lbC000534
	addq.w	#1,D7
lbC000534	move.w	($17C,A6),D3
	mulu	#3,D3
	mulu	D7,D3
	add.w	D3,A0
	lea	($224,A6),A2
	move.w	($210,A6),D7
	beq.b	lbC000560
	subq.w	#1,D7
lbC00054C	move.l	A0,(A2)+
	moveq	#0,D3
	move.b	($15,A0),D3
	add.w	#$16,A0
	lsl.w	#2,D3
	add.w	D3,A0
	dbra	D7,lbC00054C
lbC000560	clr.w	D0
lbC000562	movem.l	(SP)+,D0-D7/A0-A6
	rts

lbC000568	moveq	#-1,D0
	bra.b	lbC000562

lbC00056C	movem.l	D0-D7/A0-A6,-(SP)
	move.l	(lbW000020,PC),A6
	btst	#15,D0
	beq.b	lbC000580
	bclr	#15,D0
	bra.b	lbC00058E

lbC000580	tst.w	D0
	beq.b	lbC00058E
	move.l	($320,A6),A3
	subq.w	#1,D0

;	move.w	(A3,D0.W*2),D0
	add	d0,d0
	move.w	(A3,D0.W),D0

lbC00058E	move.w	D0,($216,A6)
	clr.w	($18A,A6)
	move.w	#6,($182,A6)
	clr.w	($17E,A6)
	st	($180,A6)
	sf	(3,A6)
	clr.b	(0,A6)
	clr.w	($214,A6)
	bsr.w	lbC00064E
	moveq	#3,D6
	lea	(8,A6),A0
lbC0005BA	bsr.w	lbC0005D8
	add.w	#$5C,A0
	dbra	D6,lbC0005BA
	bsr.w	lbC0001D8
	movem.l	(SP)+,D0-D7/A0-A5
	tst.b	D1
	seq	(4,A6)
	move.l	(SP)+,A6
	rts

lbC0005D8	move.w	#$5B,D7
	move.l	A0,A1
	move.b	($25,A1),D0
	move.l	($4C,A1),-(SP)
	move.l	($50,A1),-(SP)
lbC0005EA	clr.b	(A0)+
	dbra	D7,lbC0005EA
	move.w	#$40,($1E,A1)
	move.b	#$10,($3F,A1)
	move.b	#1,($40,A1)
	move.b	#1,($3D,A1)
	move.b	#$3F,($3E,A1)
	move.b	D0,($25,A1)
	move.l	(SP)+,($50,A1)
	move.l	(SP)+,($4C,A1)
	move.l	A1,A0
	rts

lbC00061E	movem.l	D0-D7/A0-A6,-(SP)
	move.l	(lbW000020,PC),A6
	sf	(4,A6)
	bsr.w	lbC00064E
	moveq	#3,D6
	lea	(8,A6),A0
lbC000634	bsr.w	lbC0005D8
	add.w	#$5C,A0
	dbra	D6,lbC000634
	movem.l	(SP)+,D0-D7/A0-A6
	rts

	move.w	#15,($DFF096).L
lbC00064E	clr.w	($DFF0A8).L
	clr.w	($DFF0B8).L
	clr.w	($DFF0C8).L
	clr.w	($DFF0D8).L
	rts

************ PLAY

lbC000668	movem.l	D0-D7/A0-A6,-(SP)
	move.l	(lbL000024,PC),A4
	move.l	(lbW000020,PC),A6
	lea	($DFF000).L,A5
	tst.w	(4,A6)
	beq.w	lbC00075C
	lea	(8,A6),A0
	lea	($A0,A5),A3
	moveq	#3,D7
lbC00068C	bsr.w	lbC000EDC
	add.w	#$5C,A0
	add.w	#$10,A3
	dbra	D7,lbC00068C
	tst.w	($17E,A6)
	bne.w	lbC0006EA
	tst.b	($180,A6)
	beq.w	lbC0006D2
	move.l	($21C,A6),A3
	move.w	($216,A6),D2
	lsl.w	#3,D2
	move.w	(A3,D2.W),(8,A6)
	move.w	(2,A3,D2.W),($64,A6)
	move.w	(4,A3,D2.W),($C0,A6)
	move.w	(6,A3,D2.W),($11C,A6)
	sf	($180,A6)
lbC0006D2	moveq	#3,D7
	lea	(8,A6),A0
lbC0006D8	bsr.w	lbC000762
	add.w	#$5C,A0
	dbra	D7,lbC0006D8
	move.w	($182,A6),($17E,A6)
lbC0006EA	moveq	#3,D7
	lea	(8,A6),A0
lbC0006F0	bsr.w	lbC000A82
	add.w	#$5C,A0
	dbra	D7,lbC0006F0
	sub.w	#1,($17E,A6)
	bne.w	lbC00075C
	tst.b	($184,A6)
	bne.w	lbC00072C

	add.w	#1,($214,A6)
	move.w	($17C,A6),D0
	cmp.w	($214,A6),D0
	bne.w	lbC00075C
	move.w	($216,A6),($18A,A6)
	add.w	#1,($18A,A6)
lbC00072C	sf	($184,A6)
	clr.w	($214,A6)
	tst.b	($178,A6)
	bne.b	lbC000744
	move.w	($18A,A6),($216,A6)
	clr.w	($18A,A6)
lbC000744	move.w	($216,A6),D0
	cmp.w	($21A,A6),D0
	bne.b	lbC000758
	st	(3,A6)
	move.w	($218,A6),($216,A6)
lbC000758	st	($180,A6)
lbC00075C	movem.l	(SP)+,D0-D7/A0-A6
	rts

lbC000762	tst.b	($25,A0)
	bne.w	lbC000A80
	clr.b	($27,A0)
	clr.b	($28,A0)
	moveq	#0,D0
	move.b	(0,A0),D0
	tst.b	(7,A6)
	beq.b	lbC000786
	subq.w	#1,D0
	bge.b	lbC000786
	moveq	#0,D1
	bra.b	lbC00079C

lbC000786	move.l	($220,A6),A1
	move.w	($17C,A6),D1
	mulu	D1,D0
	add.w	($214,A6),D0
	mulu	#3,D0

;	move.w	(A1,D0.L),D1
	move.b	(a1,d0.l),d1
	ror	#8,d1
	move.b	1(a1,d0.l),d1


lbC00079C	move.w	D1,D3
	move.w	D1,D2
	and.w	#15,D2
	cmp.w	#14,D2
	bne.b	lbC0007F0
	moveq	#0,D5
	move.b	(2,A1,D0.L),D5
	move.w	D5,D6
	lsr.w	#4,D5
	and.w	#15,D6
	cmp.w	#12,D5
	bne.b	lbC0007CE
	cmp.b	($183,A6),D6
	bge.b	lbC0007CE
	move.b	D6,($4A,A0)
	beq.b	lbC0007CE
	st	($4B,A0)
lbC0007CE	cmp.w	#13,D5
	bne.b	lbC0007F0
	tst.b	($49,A0)
	bne.b	lbC0007EC
	cmp.b	($183,A6),D6
	bge.b	lbC0007F0
	move.b	D6,($48,A0)
	beq.b	lbC0007F0
	st	($49,A0)
	rts

lbC0007EC	sf	($49,A0)
lbC0007F0	tst.w	D2
	bne.b	lbC00080C
	tst.b	(2,A1,D0.L)
	beq.b	lbC00080C
	move.b	(2,A1,D0.L),D5
	and.w	#15,D5
	cmp.w	#9,D5
	bgt.b	lbC00080C
	move.w	D5,($18A,A6)
lbC00080C	cmp.w	#8,D2
	bne.b	lbC000818
	move.b	(2,A1,D0.L),(0,A6)
lbC000818	cmp.w	#13,D2
	bne.b	lbC00082E
	move.w	($216,A6),($18A,A6)
	add.w	#1,($18A,A6)
	st	($184,A6)
lbC00082E	cmp.w	#11,D2
	bne.b	lbC00085E
	moveq	#0,D5
	move.b	($18B,A6),D5
	mulu	#$64,D5
	move.b	(2,A1,D0.L),D6
	and.w	#15,D6
	add.w	D6,D5
	moveq	#0,D6
	move.b	(2,A1,D0.L),D6
	lsr.w	#4,D6
	mulu	#10,D6
	add.w	D6,D5
	move.w	D5,($18A,A6)
	st	($184,A6)
lbC00085E	cmp.w	#15,D2
	bne.b	lbC00086A
	move.b	(2,A1,D0.L),($183,A6)
lbC00086A	cmp.w	#5,D2
	beq.b	lbC000876
	cmp.w	#10,D2
	bne.b	lbC00088A
lbC000876	move.b	(2,A1,D0.L),D5
	move.b	D5,D6
	and.b	#15,D6
	move.b	D6,($28,A0)
	lsr.b	#4,D5
	move.b	D5,($27,A0)
lbC00088A	and.w	#$3F0,D3
	lsr.w	#4,D3
	subq.w	#1,D3
	bmi.w	lbC000986
	move.l	D1,-(SP)
	move.w	#$40,($1C,A0)

;	clr.w	($29,A0)
	clr.b	$29(a0)
	clr.b	$2a(a0)

;	clr.w	($2B,A0)
	clr.b	$2b(a0)
	clr.b	$2c(a0)

;	clr.w	($2D,A0)
	clr.b	$2d(a0)
	clr.b	$2e(a0)


	lea	($224,A6),A3

;	move.l	(A3,D3.W*4),A3
	lsl	#2,d3
	move.l	(A3,D3.W),A3
	lsr	#2,d3

	move.w	#0,(2,A0)
	moveq	#0,D1
	move.b	(2,A3),D1
	move.b	D1,(4,A0)
	moveq	#0,D4
	move.b	(3,A3),D4
	lsl.w	#8,D4
	divu	D1,D4
	move.w	D4,(8,A0)
	moveq	#0,D1
	move.b	(4,A3),D1
	move.b	D1,(5,A0)
	move.b	(5,A3),D4
	sub.b	(3,A3),D4
	ext.w	D4
	asl.w	#8,D4
	ext.l	D4
	divs	D1,D4
	move.w	D4,(10,A0)
	move.b	(6,A3),(6,A0)
	moveq	#0,D1
	move.b	(7,A3),D1
	move.b	D1,(7,A0)
	move.b	(8,A3),D4
	sub.b	(5,A3),D4
	ext.w	D4
	asl.w	#8,D4
	ext.l	D4
	divs	D1,D4
	move.w	D4,(12,A0)
	move.b	(1,A3),D1
	and.b	#7,D1
	move.b	D1,($13,A0)
	move.b	(0,A3),($1B,A0)
	clr.b	($38,A0)
	move.b	(13,A3),($37,A0)
	move.b	(14,A3),($39,A0)
	move.b	(15,A3),($3A,A0)
	clr.w	($18,A0)
	sf	($23,A0)
	clr.b	($3C,A0)
	clr.b	($3B,A0)
	moveq	#5,D6
	sub.b	D1,D6
	move.b	($10,A3),D3
	lsr.b	D6,D3
	move.b	($11,A3),D4
	lsr.b	D6,D4
	move.b	D3,($3D,A0)
	move.b	D4,($3E,A0)
	move.b	#1,($40,A0)
	clr.b	($43,A0)
	move.b	($14,A3),($42,A0)
	clr.b	($41,A0)
	move.l	A3,(14,A0)
	add	#$16,A3
	move.l	A3,($44,A0)
	move.l	(SP)+,D1
lbC000986	cmp.w	#9,D2
	bne.b	lbC0009A4
	move.b	(2,A1,D0.L),D5
	moveq	#5,D6
	sub.b	($13,A0),D6
	lsr.b	D6,D5
	move.b	D5,($3F,A0)
	st	($22,A0)
	st	($23,A0)
lbC0009A4	sf	($2F,A0)
	cmp.w	#5,D2
	beq.b	lbC0009C4
	cmp.w	#3,D2
	bne.w	lbC0009F8
	moveq	#0,D5
	move.b	(2,A1,D0.L),D5
	beq.w	lbC0009C4

;	move.w	D5,($29,A0)
	move.b	d5,$2a(a0)
	ror	#8,d5
	move.b	d5,$29(a0)
	ror	#8,d5

lbC0009C4	move.w	D1,D4
	rol.w	#6,D4
	and.w	#$3F,D4
	beq.b	lbC0009EE
	move.w	($16,A0),D6
	lea	(lbW000F3A,PC),A3

;	move.w	(A3,D4.W*2),D4
;	move.w	(A3,D6.W*2),D6

	add	d4,d4
	move.w	(A3,D4.W),D4
	add	d6,d6
	move.w	(A3,D6.W),D6

	sub.w	D4,D6
	move.w	D6,D4

;	add.w	($2B,A0),D4

	move.l	d0,-(sp)
	move.b	$2b(a0),d0
	rol	#8,d0
	move.b	$2c(a0),d0
	add	d0,d4
	move.l	(sp)+,d0
	tst	d4

	beq.b	lbC0009F8
	neg.w	D6

;	move.w	D6,($2D,A0)
	move.b	d6,$2e(a0)
	ror	#8,d6
	move.b	d6,$2d(a0)
	ror	#8,d6

lbC0009EE	st	($2F,A0)
	st	($30,A0)
	bra.b	lbC000A08

lbC0009F8	rol.w	#6,D1
	and.w	#$3F,D1
	beq.b	lbC000A08
	move.w	D1,($16,A0)
	st	($24,A0)
lbC000A08	cmp.w	#1,D2
	bne.b	lbC000A22
	moveq	#0,D5
	move.b	(2,A1,D0.L),D5
	neg.w	D5

;	move.w	D5,($29,A0)
	move.b	d5,$2a(a0)
	ror	#8,d5
	move.b	d5,$29(a0)
	ror	#8,d5

	st	($2F,A0)
	sf	($30,A0)
lbC000A22	cmp.w	#2,D2
	bne.b	lbC000A3A
	moveq	#0,D5
	move.b	(2,A1,D0.L),D5

;	move.w	D5,($29,A0)
	move.b	d5,$2a(a0)
	ror	#8,d5
	move.b	d5,$29(a0)
	ror	#8,d5

	st	($2F,A0)
	sf	($30,A0)
lbC000A3A	cmp.w	#12,D2
	bne.b	lbC000A80
	moveq	#0,D1
	move.b	(2,A1,D0.L),D1
	cmp.w	#$40,D1
	ble.b	lbC000A7C
	sub.w	#$50,D1
	bmi.b	lbC000A80
	cmp.w	#$40,D1
	ble.b	lbC000A6A
	sub.w	#$50,D1
	bmi.b	lbC000A80
	cmp.w	#$40,D1
	bgt.b	lbC000A80
	move.b	D1,($1F,A0)
	bra.b	lbC000A80

lbC000A6A	move.b	D1,($27,A6)
	move.b	D1,($83,A6)
	move.b	D1,($DF,A6)
	move.b	D1,($13B,A6)
	bra.b	lbC000A80

lbC000A7C	move.b	D1,($1B,A0)
lbC000A80	rts

lbC000A82	tst.b	($25,A0)
	bne.w	lbC000E14
	tst.b	($4B,A0)
	beq.b	lbC000AA6
	tst.b	($4A,A0)
	bne.b	lbC000AA0
	clr	($1A,A0)
	sf	($4B,A0)
lbC000AA0	subq.b	#1,($4A,A0)
lbC000AA6	tst.b	($49,A0)
	beq.b	lbC000ABE
	tst.b	($48,A0)
	bne.b	lbC000AB8
	bsr.w	lbC000762
	bra.b	lbC000ABE

lbC000AB8	subq.b	#1,($48,A0)
lbC000ABE	tst.b	(4,A0)
	beq.b	lbC000AD4
	move.w	(8,A0),D0
	add.w	D0,(2,A0)
	subq.b	#1,(4,A0)
	bra.b	lbC000B0C

lbC000AD4	tst.b	(5,A0)
	beq.b	lbC000AEA
	move.w	(10,A0),D0
	add.w	D0,(2,A0)
	subq.b	#1,(5,A0)
	bra.b	lbC000B0C

lbC000AEA	tst.b	(6,A0)
	beq.b	lbC000AF8
	subq.b	#1,(6,A0)
	bra.b	lbC000B0C

lbC000AF8	tst.b	(7,A0)
	beq.b	lbC000B0C
	move.w	(12,A0),D0
	add.w	D0,(2,A0)
	subq.b	#1,(7,A0)
lbC000B0C	move.b	($1B,A0),D0
	sub.b	($28,A0),D0
	add.b	($27,A0),D0
	bpl.b	lbC000B1C
	moveq	#0,D0
lbC000B1C	cmp.b	#$40,D0
	ble.b	lbC000B26
	move.b	#$40,D0
lbC000B26	move.b	D0,($1B,A0)
	tst.b	($2F,A0)
	beq.b	lbC000B68

;	move.w	($2B,A0),D0
	move.b	$2b(a0),d0
	ror	#8,d0
	move.b	$2c(a0),d0

;	move.w	($29,A0),D2
	move.b	$29(a0),d2
	ror	#8,d2
	move.b	$2a(a0),d2

	tst.b	($30,A0)
	beq.b	lbC000B5A

;	move.w	($2D,A0),D1
	move.b	$2d(a0),d1
	ror	#8,d1
	move.b	$2e(a0),d1

	sub.w	D1,D0
	beq.b	lbC000B68
	bmi.b	lbC000B4A
	neg.w	D2
lbC000B4A	move.w	D0,D3
	add.w	D2,D3
	eor.w	D0,D3
	btst	#15,D3
	bne.b	lbC000B5E

;	move.w	($2B,A0),D0
	move.b	$2b(a0),d0
	ror	#8,d0
	move.b	$2c(a0),d0

lbC000B5A	add.w	D2,D0
	bra.b	lbC000B60

lbC000B5E	move.w	D1,D0
lbC000B60	
;	move.w	D0,($2B,A0)
	move.b	d0,$2c(a0)
	ror	#8,d0
	move.b	d0,$2b(a0)
	ror	#8,d0

	st	($24,A0)
lbC000B68	moveq	#0,D0
	move.b	($39,A0),D0
	beq.b	lbC000BB0
	tst.b	($37,A0)
	beq.b	lbC000B7E
	subq.b	#1,($37,A0)
	bra.b	lbC000BB0

lbC000B7E	moveq	#0,D1
	move.b	($38,A0),D1
;	move.w	($190,A6,D1.W*2),D1

	add	#$190,a6
	add	d1,d1
	move	(a6,d1),d1
	sub	#$190,a6


	muls	D0,D1
	move.l	D1,D2
	swap	D2
	and.w	#$8000,D2
	asr.w	#7,D1
	or.w	D2,D1
	move.w	D1,($18,A0)
	st	($24,A0)
	move.b	($3A,A0),D1
	add.b	D1,($38,A0)
	and.b	#$3F,($38,A0)
lbC000BB0	move.l	(14,A0),A3

;	tst.l	A3
	move.l	a3,d5

	beq.w	lbC000C68
	move.b	($15,A3),D5
	cmp.b	($41,A0),D5
	beq.w	lbC000C54
	subq.b	#1,($43,A0)
	bgt.w	lbC000C52
	move.l	($44,A0),A2
	move.w	(A2),D0
	lsr.w	#7,D0
	and.w	#7,D0
	beq.b	lbC000BF2
	subq.b	#1,D0
	move.b	D0,($12,A0)
	st	($21,A0)
	clr.w	($32,A0)

;	clr.w	($35,A0)
	clr.b	$35(a0)
	clr.b	$36(a0)


lbC000BF2	sf	($34,A0)
	move.w	(A2),D0
	move.l	A2,-(SP)
	addq.w	#2,A2
	move.w	D0,D1
	rol.w	#6,D0
	and.l	#7,D0
	beq.w	lbC000C0E
	bsr.w	lbC000E16
lbC000C0E	addq.w	#1,A2
	rol.w	#3,D1
	and.l	#7,D1
	move.l	D1,D0
	beq.w	lbC000C22
	bsr.w	lbC000E16
lbC000C22	move.l	(SP)+,A2
	move.w	(A2),D0
	move.w	D0,D1
	and.w	#$3F,D0
	beq.b	lbC000C3E
	move.w	D0,($14,A0)
	st	($24,A0)
	btst	#6,D1
	sne	($26,A0)
lbC000C3E	addq.l	#4,($44,A0)
	addq.b	#1,($41,A0)
	move.b	($42,A0),($43,A0)
lbC000C52	bra.b	lbC000C68

lbC000C54	tst.b	($43,A0)
	bne.b	lbC000C62
	clr	($32,A0)
	bra.b	lbC000C68

lbC000C62	subq.b	#1,($43,A0)
lbC000C68	tst.b	($34,A0)
	beq.b	lbC000C80

;	move.w	($35,A0),D0
	move.b	$35(a0),d0
	ror	#8,d0
	move.b	$36(a0),d0

	sub.w	($32,A0),D0

;	move.w	D0,($35,A0)
	move.b	d0,$36(a0)
	ror	#8,d0
	move.b	d0,$35(a0)
	ror	#8,d0
	tst	d0

	beq.b	lbC000C80
	st	($24,A0)

lbC000C80	cmp.b	#2,($12,A0)
	bne.w	lbC000CCA
	tst.b	($3B,A0)
	beq.w	lbC000CCA
	subq.b	#1,($3C,A0)
	bgt.w	lbC000CCA
	move.b	($3D,A0),D1
	move.b	($3E,A0),D2
	move.b	($3F,A0),D3
	cmp.b	D1,D3
	beq.b	lbC000CB0
	cmp.b	D2,D3
	bne.b	lbC000CB4
lbC000CB0	neg.b	($40,A0)
lbC000CB4	add.b	($40,A0),D3
	move.b	D3,($3F,A0)
	st	($22,A0)
	move.l	(14,A0),A3
	move.b	($12,A3),($3C,A0)
lbC000CCA	cmp.b	#2,($12,A0)
	beq.b	lbC000CD8
	tst.b	($22,A0)
	beq.b	lbC000D3A
lbC000CD8	lea	($934,A6),A3
	moveq	#0,D1
	move.b	($3F,A0),D1
	lsl.w	#1,D1
	add.w	D1,A3
	moveq	#0,D1
	move.b	($13,A0),D1
	lsl.w	#1,D1
	add.w	(lbW000CF6,PC,D1.W),A3
	move.l	A3,-(SP)
	bra.b	lbC000D02

lbW000CF6	dc.w	$7C
	dc.w	$78
	dc.w	$70
	dc.w	$60
	dc.w	$40
	dc.w	0

lbC000D02	move.l	($50,A0),A2
	lea	($32C,A6),A3
	move.l	A2,(A3)
	move.w	#$20,D2
	moveq	#5,D1
	moveq	#1,D3
	sub.b	($13,A0),D1
	lsr.w	D1,D2
	lsl.w	D1,D3
	subq.w	#1,D2
	subq.w	#1,D3
lbC000D20	move.l	(SP),A3
	move.w	D2,-(SP)
lbC000D24	
;	move.l	(A3)+,(A2)+
	rept 4
	move.b	(a3)+,(a2)+
	endr
	dbra	D2,lbC000D24
	move.w	(SP)+,D2
	dbra	D3,lbC000D20
	move.l	(SP)+,A3
	st	($21,A0)
	sf	($22,A0)
lbC000D3A	cmp.b	#3,($12,A0)
	bne.b	lbC000D46
	st	($21,A0)
lbC000D46	tst.b	($21,A0)
	beq.b	lbC000D9C
	moveq	#0,D0
	move.b	($12,A0),D0
	lea	($324,A6),A3

;	move.l	(A3,D0.W*4),A3
	lsl	#2,d0
	move.l	(A3,D0.W),A3
	lsr	#2,d0

	cmp.b	#2,D0
	bge.b	lbC000D6A
	moveq	#0,D1
	move.b	($13,A0),D1
	lsl.w	#7,D1
	add.l	D1,A3
lbC000D6A	cmp.b	#3,D0
	bne.b	lbC000D98
	move.l	($18C,A6),D0
	move.w	D0,D1
	and.w	#$FFF,D1
	add.w	D1,A3
	add.l	#$222B98,D0
	ror.l	#8,D0
	add.l	#$BEFF3,D0
	eor.b	#$4B,D0
	sub.l	#$1A4F,D0
	move.l	D0,($18C,A6)
lbC000D98	move.l	A3,($54,A0)
lbC000D9C	move.w	($14,A0),D1
	tst.b	($26,A0)
	bne.b	lbC000DB6
	move.b	(1,A0),D2
	ext.w	D2
	add.w	D2,D1
	move.w	($16,A0),D2
	subq.w	#1,D2
	add.w	D2,D1
lbC000DB6	lea	(lbW000F3A,PC),A3

;	move.w	(A3,D1.W*2),D1
	add	d1,d1
	move.w	(A3,D1.W),D1

	tst.b	($26,A0)
	bne.b	lbC000DC8

;	add.w	($2B,A0),D1
	move.l	d0,-(sp)
	move.b	$2b(a0),d0
	ror	#8,d0
	move.b	$2c(a0),d0
	add	d0,d1
	move.l	(sp)+,d0

lbC000DC8	
;	add.w	($35,A0),D1
	move.l	d0,-(sp)
	move.b	$35(a0),d0
	ror	#8,d0
	move.b	$36(a0),d0
	add	d0,d1
	move.l	(sp)+,d0

	add.w	($18,A0),D1
	cmp.w	#$D60,D1
	ble.b	lbC000DDA
	move.w	#$D60,D1
lbC000DDA	cmp.w	#$71,D1
	bge.b	lbC000DE4
	move.w	#$71,D1
lbC000DE4	move.w	D1,($58,A0)
	move.b	(2,A0),D0
	ext.w	D0
	move.w	($1A,A0),D1
	mulu	D1,D0
	lsr.w	#6,D0
	move.w	($1C,A0),D1
	mulu	D1,D0
	lsr.w	#6,D0
	move.w	($1E,A0),D1
	mulu	D1,D0
	lsr.w	#6,D0
	move.b	(1,A6),D1
	ext.w	D1
	mulu	D1,D0
	lsr.w	#6,D0
	move.w	D0,($5A,A0)
lbC000E14	rts

lbC000E16	subq.w	#1,D0
	bne.b	lbC000E2A
	moveq	#0,D5
	move.b	(A2),D5
	move.w	D5,($32,A0)
	st	($34,A0)
	bra.w	lbC000EDA

lbC000E2A	subq.w	#1,D0
	bne.b	lbC000E40
	moveq	#0,D5
	move.b	(A2),D5
	neg.w	D5
	move.w	D5,($32,A0)
	st	($34,A0)
	bra.w	lbC000EDA

lbC000E40	subq.w	#1,D0
	bne.b	lbC000E64
	tst.b	($23,A0)
	bne.b	lbC000E5C
	move.b	(A2),D5
	moveq	#5,D6
	sub.b	($13,A0),D6
	lsr.b	D6,D5
	move.b	D5,($3F,A0)
	bra.w	lbC000EDA

lbC000E5C	sf	($23,A0)
	bra.w	lbC000EDA

lbC000E64	subq.w	#1,D0
	bne.b	lbC000E70
	not.b	($3B,A0)
	bra.w	lbC000EDA

lbC000E70	subq.w	#1,D0
	bne.b	lbC000E98
	moveq	#0,D5
	move.b	(A2),D5
	move.l	(14,A0),A3
	add	#$12,A3
	move.w	D5,D2
	subq.w	#1,D2
	move.b	D2,($41,A0)
	lsl.w	#2,D5
	add.w	D5,A3
	move.l	A3,($44,A0)
	bra.w	lbC000EDA

lbC000E98	subq.w	#1,D0
	bne.b	lbC000ED2
	moveq	#0,D5
	move.b	(A2),D5
	cmp.w	#$40,D5
	ble.b	lbC000ECA
	sub.w	#$50,D5
	bmi.b	lbC000ECE
	cmp.w	#$40,D5
	bgt.b	lbC000EB8
	move.b	D5,($1D,A0)
	bra.b	lbC000ECE

lbC000EB8	sub.w	#$50,D5
	bmi.b	lbC000ECE
	cmp.w	#$40,D5
	bgt.b	lbC000ECE
	move.b	D5,($1F,A0)
	bra.b	lbC000ECE

lbC000ECA	move.b	D5,($1B,A0)
lbC000ECE	bra.w	lbC000EDA

lbC000ED2	move.b	(A2),($42,A0)
	move.b	(A2),($43,A0)
lbC000EDA	rts

lbC000EDC	tst.b	($25,A0)
	bne.w	lbC000F32
	tst.b	($24,A0)
	beq.b	lbC000EF4
	move.w	($58,A0),(6,A3)
	sf	($24,A0)
lbC000EF4	tst.b	($21,A0)
	beq.b	lbC000F2A
	movem.l	D6/D7/A1/A2,-(SP)
	move.l	($54,A0),A1
	move.l	($4C,A0),A2
	moveq	#4,D6
lbC000F08	cmp.b	#3,($12,A0)
	beq.b	lbC000F14
	move.l	($54,A0),A1
lbC000F14	moveq	#15,D7
lbC000F16	;move.l	(A1)+,(A2)+
	;move.l	(A1)+,(A2)+
	rept 8
	move.b	(a1)+,(a2)+
	endr
	dbra	D7,lbC000F16
	dbra	D6,lbC000F08
	movem.l	(SP)+,D6/D7/A1/A2
	sf	($21,A0)
lbC000F2A	move.w	($5A,A0),(8,A3)
	rts

lbC000F32	clr	(8,A3)
	rts

lbW000F3A	dc.w	0
	dc.w	$D60
	dc.w	$CA0
	dc.w	$BE8
	dc.w	$B40
	dc.w	$A98
	dc.w	$A00
	dc.w	$970
	dc.w	$8E8
	dc.w	$868
	dc.w	$7F0
	dc.w	$780
	dc.w	$714
	dc.w	$6B0
	dc.w	$650
	dc.w	$5F4
	dc.w	$5A0
	dc.w	$54C
	dc.w	$500
	dc.w	$4B8
	dc.w	$474
	dc.w	$434
	dc.w	$3F8
	dc.w	$3C0
	dc.w	$38A
	dc.w	$358
	dc.w	$328
	dc.w	$2FA
	dc.w	$2D0
	dc.w	$2A6
	dc.w	$280
	dc.w	$25C
	dc.w	$23A
	dc.w	$21A
	dc.w	$1FC
	dc.w	$1E0
	dc.w	$1C5
	dc.w	$1AC
	dc.w	$194
	dc.w	$17D
	dc.w	$168
	dc.w	$153
	dc.w	$140
	dc.w	$12E
	dc.w	$11D
	dc.w	$10D
	dc.w	$FE
	dc.w	$F0
	dc.w	$E2
	dc.w	$D6
	dc.w	$CA
	dc.w	$BE
	dc.w	$B4
	dc.w	$AA
	dc.w	$A0
	dc.w	$97
	dc.w	$8F
	dc.w	$87
	dc.w	$7F
	dc.w	$78
	dc.w	$71
lbW000FB4	dc.w	0
	dc.w	$18
	dc.w	$31
	dc.w	$4A
	dc.w	$61
	dc.w	$78
	dc.w	$8D
	dc.w	$A1
	dc.w	$B4
	dc.w	$C5
	dc.w	$D4
	dc.w	$E0
	dc.w	$EB
	dc.w	$F4
	dc.w	$FA
	dc.w	$FD
	dc.w	$FF

LOPPU

	end

