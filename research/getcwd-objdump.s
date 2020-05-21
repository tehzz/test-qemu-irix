sw	ra,60(sp)
sw	s8,56(sp)
sw	s3,32(sp)
sw	a0,3088(sp)
move	s8,a1
sw	gp,52(sp)
sw	s7,48(sp)
sw	s6,44(sp)
sw	s5,40(sp)
sw	s4,36(sp)
sw	s2,28(sp)
sw	s1,24(sp)
sw	s0,20(sp)
addiu	s3,sp,2573
sw	zero,84(sp)
jalr	t9
li	a0,28
lw	gp,52(sp)
li	at,1
bne	v0,at,fac447c <_getcwd+0xdc>
sw	v0,80(sp)
lw	t9,-30324(gp)
addiu	a0,sp,88
jalr	t9
nop
lw	gp,52(sp)
bgez	v0,fac4458 <_getcwd+0xb8>
nop
lw	a0,-32652(gp)
lw	t9,-32468(gp)
addiu	a0,a0,-5088
jalr	t9
nop
lw	gp,52(sp)
li	a0,1
lw	t9,-30144(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
nop
lw	t9,-32044(gp)
addiu	a0,sp,88
jalr	t9
nop
lw	gp,52(sp)
beqz	v0,fac4480 <_getcwd+0xe0>
li	t6,1
b	fac4480 <_getcwd+0xe0>
sw	t6,84(sp)
sw	zero,80(sp)
bnez	s8,fac44a4 <_getcwd+0x104>
nop
lw	t9,-29980(gp)
li	a0,22
jalr	t9
nop
lw	gp,52(sp)
b	fac49f8 <_getcwd+0x658>
move	v0,zero
lw	a0,-32652(gp)
lw	t9,-30280(gp)
addiu	a1,sp,632
jalr	t9
addiu	a0,a0,-5084
lw	gp,52(sp)
bgez	v0,fac44d0 <_getcwd+0x130>
lw	t7,3088(sp)
b	fac49f8 <_getcwd+0x658>
move	v0,zero
lw	t7,3088(sp)
sw	zero,604(sp)
bnez	t7,fac4520 <_getcwd+0x180>
lw	t1,3088(sp)
lw	t9,-29452(gp)
move	a0,s8
jalr	t9
nop
lw	gp,52(sp)
bnez	v0,fac4514 <_getcwd+0x174>
sw	v0,3088(sp)
lw	t9,-29980(gp)
li	a0,12
jalr	t9
nop
lw	gp,52(sp)
b	fac49f8 <_getcwd+0x658>
move	v0,zero
li	t8,1
sw	t8,604(sp)
lw	t1,3088(sp)
sw	s8,608(sp)
li	t9,46
li	t0,46
addiu	s8,s8,-1
sb	t9,2573(sp)
sb	t0,2574(sp)
sb	zero,2575(sp)
addu	s7,t1,s8
sb	zero,0(s7)
li	s6,-1
addiu	s5,sp,768
addiu	s4,sp,2576
addiu	t3,sp,632
addiu	t5,t3,132
addiu	t2,sp,904
lw	at,0(t3)
addiu	t3,t3,12
sw	at,0(t2)
lw	at,-8(t3)
addiu	t2,t2,12
sw	at,-8(t2)
lw	at,-4(t3)
bne	t3,t5,fac455c <_getcwd+0x1bc>
sw	at,-4(t2)
lw	at,0(t3)
move	a0,s3
sw	at,0(t2)
lw	t9,-29608(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
beqz	v0,fac49cc <_getcwd+0x62c>
move	s2,v0
lw	t9,-30348(gp)
lw	a0,0(v0)
jalr	t9
addiu	a1,sp,632
lw	gp,52(sp)
bgez	v0,fac4614 <_getcwd+0x274>
lw	t6,904(sp)
lw	t9,-29984(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
move	s0,v0
lw	t9,-32492(gp)
move	a0,s2
jalr	t9
nop
lw	gp,52(sp)
move	a0,s0
lw	t9,-29980(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
b	fac49d0 <_getcwd+0x630>
lw	t1,604(sp)
lw	t6,904(sp)
lw	t7,632(sp)
lw	t8,920(sp)
bne	t6,t7,fac475c <_getcwd+0x3bc>
li	t6,47
lw	t9,648(sp)
nop
bne	t8,t9,fac4680 <_getcwd+0x2e0>
nop
lw	t9,-32492(gp)
move	a0,s2
jalr	t9
nop
lw	t1,608(sp)
lw	gp,52(sp)
addiu	t0,s8,1
bne	t0,t1,fac4660 <_getcwd+0x2c0>
li	t4,47
addiu	s7,s7,-1
sb	t4,0(s7)
lw	t9,-30720(gp)
lw	a0,3088(sp)
jalr	t9
move	a1,s7
lw	gp,52(sp)
lw	v0,3088(sp)
b	fac49fc <_getcwd+0x65c>
lw	ra,60(sp)
lw	t9,-32460(gp)
move	a0,s2
jalr	t9    #readdir
nop
lw	gp,52(sp)
bnez	v0,fac46e8 <_getcwd+0x348>
move	s0,v0
lw	t9,-29984(gp)
nop
jalr	t9 # oserror
nop
lw	gp,52(sp)
move	s0,v0
lw	t9,-32492(gp)
move	a0,s2
jalr	t9  #closedir
nop
lw	gp,52(sp)
move	a0,s0
lw	t9,-29980(gp)
nop
jalr	t9 #setoserror
nop
lw	gp,52(sp)
b	fac49d0 <_getcwd+0x630>
lw	t1,604(sp)
lw	t5,80(sp)
li	t3,47
beqz	t5,fac4730 <_getcwd+0x390>
move	a0,s4
lw	t9,-30720(gp)
sb	t3,2575(sp)
jalr	t9 #strcpr
addiu	a1,s0,10
lw	gp,52(sp)
move	a0,s3
lw	t9,-30332(gp)
move	a1,s5
jalr	t9 #lstat
nop
lw	gp,52(sp)
lw	a0,784(sp)
b	fac4738 <_getcwd+0x398>
move	v1,v0
lw	a0,0(v0)
move	v1,zero
beq	v1,s6,fac4680 <_getcwd+0x2e0>
nop
lw	t2,920(sp)
nop
bne	a0,t2,fac4680 <_getcwd+0x2e0>
nop
b	fac4828 <_getcwd+0x488>
addiu	s1,s0,10
li	t6,47
sb	t6,2575(sp)
lw	t9,-32460(gp)
move	a0,s2
jalr	t9
nop
lw	gp,52(sp)
bnez	v0,fac47c8 <_getcwd+0x428>
move	s0,v0
lw	t9,-29984(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
move	s0,v0
lw	t9,-32492(gp)
move	a0,s2
jalr	t9
nop
lw	gp,52(sp)
move	a0,s0
lw	t9,-29980(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
b	fac49d0 <_getcwd+0x630>
lw	t1,604(sp)
lw	t9,-30720(gp)
addiu	s1,s0,10
move	a1,s1
jalr	t9
move	a0,s4
lw	gp,52(sp)
move	a0,s3
lw	t9,-30332(gp)
move	a1,s5
jalr	t9
nop
lw	gp,52(sp)
beq	v0,s6,fac4760 <_getcwd+0x3c0>
nop
lw	t7,784(sp)
lw	t8,920(sp)
nop
bne	t7,t8,fac4760 <_getcwd+0x3c0>
nop
lw	t9,768(sp)
lw	t0,904(sp)
nop
bne	t9,t0,fac4760 <_getcwd+0x3c0>
nop
lw	t9,-30716(gp)
move	a0,s1
jalr	t9
nop
lw	gp,52(sp)
beqz	s8,fac4854 <_getcwd+0x4b4>
move	s0,v0
addiu	t1,s8,-1
sltu	at,t1,v0
beqz	at,fac4888 <_getcwd+0x4e8>
move	a1,s1
lw	t9,-29980(gp)
li	a0,34
jalr	t9
nop
lw	gp,52(sp)
move	a0,s2
lw	t9,-32492(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
b	fac49d0 <_getcwd+0x630>
lw	t1,604(sp)
lw	t4,80(sp)
lw	t6,3088(sp)
beqz	t4,fac4960 <_getcwd+0x5c0>
move	a2,s0
lw	t9,-30316(gp)
move	a0,s3
jalr	t9
addiu	a1,sp,88
lw	gp,52(sp)
bgez	v0,fac48ec <_getcwd+0x54c>
lw	t5,84(sp)
lw	a0,-32652(gp)
lw	t9,-32468(gp)
addiu	a0,a0,-5080
jalr	t9
nop
lw	gp,52(sp)
li	a0,1
lw	t9,-30144(gp)
nop
jalr	t9
nop
lw	gp,52(sp)
nop
lw	t5,84(sp)
nop
bnez	t5,fac4918 <_getcwd+0x578>
lw	t3,3088(sp)
lw	t9,-32044(gp)
addiu	a0,sp,88
jalr	t9
nop
lw	gp,52(sp)
bnez	v0,fac49a0 <_getcwd+0x600>
addiu	t8,sp,1040
lw	t3,3088(sp)
lw	t9,-30656(gp)
subu	s8,s8,s0
addu	s7,t3,s8
move	a0,s7
move	a1,s1
jalr	t9
move	a2,s0
lw	gp,52(sp)
li	t2,47
sb	t2,-1(s7)
lw	t9,-32492(gp)
addiu	s8,s8,-1
addiu	s7,s7,-1
jalr	t9
move	a0,s2
lw	gp,52(sp)
b	fac49a0 <_getcwd+0x600>
addiu	t8,sp,1040
lw	t9,-30656(gp)
subu	s8,s8,s0
addu	s7,t6,s8
jalr	t9
move	a0,s7
lw	gp,52(sp)
li	t7,47
sb	t7,-1(s7)
lw	t9,-32492(gp)
addiu	s8,s8,-1
addiu	s7,s7,-1
jalr	t9
move	a0,s2
lw	gp,52(sp)
nop
addiu	t8,sp,1040
addiu	t9,s3,-3
sltu	at,t9,t8
bnez	at,fac49cc <_getcwd+0x62c>
li	v0,46
li	t0,47
sb	t0,-1(s3)
sb	v0,-2(s3)
sb	v0,-3(s3)
addiu	s3,s3,-3
b	fac4550 <_getcwd+0x1b0>
sb	zero,2575(sp)
lw	t1,604(sp)
nop
beqz	t1,fac49f8 <_getcwd+0x658>
move	v0,zero
lw	t9,-29444(gp)
lw	a0,3088(sp)
jalr	t9
nop
lw	gp,52(sp)
nop
move	v0,zero
lw	ra,60(sp)
lw	s0,20(sp)
lw	s1,24(sp)
lw	s2,28(sp)
lw	s3,32(sp)
lw	s4,36(sp)
lw	s5,40(sp)
lw	s6,44(sp)
lw	s7,48(sp)
lw	s8,56(sp)
jr	ra
addiu	sp,sp,3088