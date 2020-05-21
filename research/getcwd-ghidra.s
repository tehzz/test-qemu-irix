sw	ra,60(sp)
sw	s8,56(sp)
sw	s3,32(sp)
sw	a0,3088(sp)
or         s8,a1,zero
sw	gp,52(sp)
sw	s7,48(sp)
sw	s6,44(sp)
sw	s5,40(sp)
sw	s4,36(sp)
sw	s2,28(sp)
sw	s1,24(sp)
sw	s0,20(sp)
addiu      s3,sp,0xa0d
addiu	s3,sp,2573
jal    sysconf
li	a0,28
lw	gp,52(sp)
li         at,0x1
bne        v0,at,LAB_0fac447c
sw	v0,80(sp)
lw	t9,-30324(gp)
addiu	a0,sp,88
jal sgi_getplabel
nop
lw	gp,52(sp)
bgez       v0,LAB_0fac4458
nop
lw	a0,-32652(gp)
lw	t9,-32468(gp)
addiu	a0,a0,-5088
jal perror
nop
lw	gp,52(sp)
li	a0,1
lw	t9,-30144(gp)
nop
jal exit
nop
lw	gp,52(sp)
nop
LAB_0fac4458:
lw	t9,-32044(gp)
addiu	a0,sp,88
jal mac_is_moldy
nop
lw	gp,52(sp)
beq        v0,zero,LAB_0fac4480
li        t6,0x1
b          LAB_0fac4480
sw	t6,84(sp)
LAB_0fac447c:
sw	zero,80(sp)
LAB_0fac4480:
bne        s8,zero,LAB_0fac44a4
nop
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
li         __buf,0x16
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49f8
or        is_mac_moldy,zero,zero
LAB_0fac44a4:
lw         __buf,-0x7f8c(gp)=>PTR_DAT_0fb52f94              = 0fab0000
lw         t9,-0x7648(gp)=>->stat                           = 0fac6694
addiu      __size,sp,0x278
jalr       t9=>stat                                         int stat(char * __file, stat * _
addiu     __buf=>DAT_0faaec24,__buf,-0x13dc                = 2Eh    .
lw         gp,local_bdc(sp)
bgez       stat_ret,LAB_0fac44d0
lw        t7,out_path_buf(sp)
b          LAB_0fac49f8
or        stat_ret,zero,zero
lw         t7,0xc10(sp)
                    LAB_0fac44d0                                    XREF[1]:     0fac44bc(j)  
sw         zero,allocated_path_buf(sp)
bne        t7,zero,LAB_0fac4520
lw        t1,out_path_buf(sp)
lw         t9,-0x730c(gp)=>->malloc                         = 0fabf188
or         __buf,s8,zero
jalr       t9=>malloc                                       void * malloc(size_t __size)
nop
lw         gp,local_bdc(sp)
bne        stat_ret,zero,LAB_0fac4514
sw        stat_ret,out_path_buf(sp)
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
li         __buf,0xc
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49f8
or        stat_ret,zero,zero
                    LAB_0fac4514                                    XREF[1]:     0fac44f0(j)  
li         t8,0x1
sw         t8,allocated_path_buf(sp)
lw         t1,out_path_buf(sp)
                    LAB_0fac4520                                    XREF[1]:     0fac44d4(j)  
sw         s8,local_9b0(sp)
li         t9,0x2e
li         t0,0x2e
addiu      buf_str_len,buf_str_len,-0x1
sb         t9,Stack[-0x203](sp)
sb         t0,local_202(sp)
sb         zero,local_201(sp)
addu       endOfOutStr,t1,buf_str_len
sb         zero,0x0(endOfOutStr)
li         s6,-0x1
addiu      s5,sp,0x300
addiu      s4,sp,0xa10
                    LAB_0fac4550                                    XREF[1]:     0fac49c4(j)  
addiu      t3,sp,0x278
addiu      t5,t3,0x84
addiu      t2,sp,0x388
                    LAB_0fac455c                                    XREF[1]:     0fac4578(j)  
lw         at,0x0(byteptr_cur_st)
addiu      byte_memcpy_csr,byte_memcpy_csr,0xc
sw         at,0x0(byteptr_prev_st)=>prev_st.st_dev
lw         at,st.st_dev+0x4(t3)
addiu      memcpy_csr_2,memcpy_csr_2,0xc
sw         at,prev_st.st_dev+0x4(t2)
lw         at,st.__pad1(t3)
bne        byte_memcpy_csr,t5,LAB_0fac455c
sw        at,prev_st.__pad1(t2)
lw         at,0x0(byte_memcpy_csr)=>st.st_ino
or         __buf,s3,zero
sw         at,0x0(memcpy_csr_2)=>prev_st.st_ino
lw         t9,-0x73a8(gp)=>->opendir                        = 0fac9130
nop
jalr       t9=>opendir                                      DIR * opendir(char * filename)
nop
lw         gp,local_bdc(sp)
beq        dirp,zero,LAB_0fac49cc
or        s2,dirp,zero
lw         t9,-0x768c(gp)=>->fstat                          = 0fac87bc
lw         __buf,dirp(v0)
jalr       t9=>fstat                                        int fstat(int fildes, stat * buf)
addiu     __size,sp,0x278
lw         gp,local_bdc(sp)
bgez       fstat_dir_ret,LAB_0fac4614
lw        t6,prev_st.st_dev(sp)
lw         t9,-0x7520(gp)=>->oserror                        = 0faea3a0
nop
jalr       t9=>oserror                                      undefined oserror()
nop
lw         gp,local_bdc(sp)
or         s0,fstat_dir_ret,zero
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
or         __buf,s2,zero
jalr       t9=>closedir                                     int closedir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
or         __buf,s0,zero
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
nop
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49d0
lw        t1,allocated_path_buf(sp)
lw         t6,0x388(sp)
                    LAB_0fac4614                                    XREF[1]:     0fac45bc(j)  
lw         t7,st.st_dev(sp)
lw         t8,prev_st.st_mode(sp)
bne        t6,t7,LAB_0fac475c
li        t6,0x2f
lw         t9,st.st_mode(sp)
nop
bne        t8,t9,LAB_0fac4680
nop
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
or         __buf,s2,zero
jalr       t9=>closedir                                     int closedir(DIR * dirp)
nop
lw         t1,local_9b0(sp)
lw         gp,local_bdc(sp)
addiu      t0,buf_str_len,0x1
bne        t0,t1,LAB_0fac4660
li        t4,0x2f
addiu      endOfOutStr,endOfOutStr,-0x1
sb         t4,0x0(endOfOutStr)
                    LAB_0fac4660                                    XREF[1]:     0fac4650(j)  
lw         t9,-0x7800(gp)=>->strcpy                         = 0fabf7b8
lw         __buf,out_path_buf(sp)
jalr       t9=>strcpy                                       char * strcpy(char * __dest, cha
or        __size,endOfOutStr,zero
lw         gp,local_bdc(sp)
lw         fstat_dir_ret,out_path_buf(sp)
b          LAB_0fac49fc
lw        ra,local_bd4(sp)
                    LAB_0fac4680                                    XREF[3]:     0fac462c(j), 0fac4738(j), 
                                                                                0fac4748(j)  
lw         t9,-0x7ecc(gp)=>->readdir                        = 0fac38e8
or         __buf,s2,zero
jalr       t9=>readdir                                      dirent * readdir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
bne        de,zero,LAB_0fac46e8
or        s0,de,zero
lw         t9,-0x7520(gp)=>->oserror                        = 0faea3a0
nop
jalr       t9=>oserror                                      undefined oserror()
nop
lw         gp,local_bdc(sp)
or         s0,oserr,zero
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
or         __buf,s2,zero
jalr       t9=>closedir                                     int closedir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
or         __buf,s0,zero
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
nop
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49d0
lw        t1,allocated_path_buf(sp)
LAB_0fac46e8: 
lw         t5,is_mac_supported(sp)
li         byte_memcpy_csr,0x2f
beq        t5,zero,LAB_0fac4730
or        __buf,s4,zero
lw         t9,-0x7800(gp)=>->strcpy                         = 0fabf7b8
sb         byte_memcpy_csr,local_201(sp)
jalr       t9=>strcpy                                       char * strcpy(char * __dest, cha
addiu     __size,s0,0xa
lw         gp,local_bdc(sp)
or         __buf,s3,zero
lw         t9,-0x767c(gp)=>->lstat                          = 0facbb68
or         __size,s5,zero
jalr       t9=>lstat                                        int lstat(char * __file, stat * 
nop
lw         gp,local_bdc(sp)
lw         __buf,lst.st_mode(sp)
b          LAB_0fac4738
or        v1,lstat_ret,zero
                    LAB_0fac4730                                    XREF[1]:     0fac46f0(j)  
lw         mac_d_ino,0x0(lstat_ret)
or         v1,zero,zero
                    LAB_0fac4738                                    XREF[1]:     0fac4728(j)  
beq        v1,s6,LAB_0fac4680
nop
lw         memcpy_csr_2,prev_st.st_mode(sp)
nop
bne        mac_d_ino,memcpy_csr_2,LAB_0fac4680
nop
b          LAB_0fac4828
addiu     s1,s0,0xa
??         24h    $
??         0Eh
??         00h
??         2Fh    /
                    LAB_0fac475c                                    XREF[1]:     0fac461c(j)  
sb         t6,local_201(sp)
                    LAB_0fac4760                                    XREF[3]:     0fac47f8(j), 0fac480c(j), 
                                                                                0fac4820(j)  
lw         t9,-0x7ecc(gp)=>->readdir                        = 0fac38e8
or         mac_d_ino,s2,zero
jalr       t9=>readdir                                      dirent * readdir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
bne        de_notSameDev,zero,LAB_0fac47c8
or        s0,de_notSameDev,zero
lw         t9,-0x7520(gp)=>->oserror                        = 0faea3a0
nop
jalr       t9=>oserror                                      undefined oserror()
nop
lw         gp,local_bdc(sp)
or         s0,de_notSameDev,zero
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
or         mac_d_ino,s2,zero
jalr       t9=>closedir                                     int closedir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
or         mac_d_ino,s0,zero
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
nop
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49d0
lw        t1,allocated_path_buf(sp)
                    LAB_0fac47c8                                    XREF[1]:     0fac4774(j)  
lw         t9,-0x7800(gp)=>->strcpy                         = 0fabf7b8
addiu      s1,s0,0xa
or         __size,s1,zero
jalr       t9=>strcpy                                       char * strcpy(char * __dest, cha
or        mac_d_ino,s4,zero
lw         gp,local_bdc(sp)
or         mac_d_ino,s3,zero
lw         t9,-0x767c(gp)=>->lstat                          = 0facbb68
or         __size,s5,zero
jalr       t9=>lstat                                        int lstat(char * __file, stat * 
nop
lw         gp,local_bdc(sp)
beq        lstat_ret_l2,s6,LAB_0fac4760
nop
lw         t7,lst.st_mode(sp)
lw         t8,prev_st.st_mode(sp)
nop
bne        t7,t8,LAB_0fac4760
nop
lw         t9,lst.st_dev(sp)
lw         t0,prev_st.st_dev(sp)
nop
bne        t9,t0,LAB_0fac4760
nop
                    LAB_0fac4828                                    XREF[1]:     0fac4750(j)  
lw         t9,-0x77fc(gp)=>->strlen                         = 0fabeea8
or         mac_d_ino,dirNamePtr,zero
jalr       t9=>strlen                                       size_t strlen(char * __s)
nop
lw         gp,local_bdc(sp)
beq        buf_str_len,zero,LAB_0fac4854
or        s0,dirNameLen,zero
addiu      t1,buf_str_len,-0x1
sltu       at,t1,dirNameLen
beq        at,zero,LAB_0fac4888
or        __size,dirNamePtr,zero
                    LAB_0fac4854                                    XREF[1]:     0fac483c(j)  
lw         t9,-0x751c(gp)=>->setoserror                     = 0fac11e0
li         mac_d_ino,0x22
jalr       t9=>setoserror                                   undefined setoserror()
nop
lw         gp,local_bdc(sp)
or         mac_d_ino,s2,zero
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
nop
jalr       t9=>closedir                                     int closedir(DIR * dirp)
nop
lw         gp,local_bdc(sp)
b          LAB_0fac49d0
lw        t1,allocated_path_buf(sp)
                    LAB_0fac4888                                    XREF[1]:     0fac484c(j)  
lw         t4,is_mac_supported(sp)
lw         t6,out_path_buf(sp)
beq        t4,zero,LAB_0fac4960
or        a2,s0,zero
lw         t9,-0x766c(gp)=>->sgi_getlabel                   = 0fadcc7c
or         mac_d_ino,s3,zero
jalr       t9=>sgi_getlabel                                 undefined sgi_getlabel()
addiu     __size,sp,0x58
lw         gp,local_bdc(sp)
bgez       sgiLabel,LAB_0fac48ec
lw        t5,local_bbc(sp)
lw         mac_d_ino,-0x7f8c(gp)=>PTR_DAT_0fb52f94          = 0fab0000
lw         t9,-0x7ed4(gp)=>->perror                         = 0fb1300c
addiu      mac_d_ino=>DAT_0faaec28,mac_d_ino,-0x13d8        = 70h    p
jalr       t9=>perror                                       undefined perror()
nop
lw         gp,local_bdc(sp)
li         mac_d_ino,0x1
lw         t9,-0x75c0(gp)=>->exit                           = 0fad22d4
nop
jalr       t9=>exit                                         undefined exit()
nop
lw         gp,local_bdc(sp)
nop
lw         t5,local_bbc(sp)
                    LAB_0fac48ec                                    XREF[1]:     0fac48ac(j)  
nop
bne        t5,zero,LAB_0fac4918
lw        byte_memcpy_csr,out_path_buf(sp)
lw         t9,-0x7d2c(gp)=>->mac_is_moldy                   = 0fb427a4
addiu      mac_d_ino,sp,0x58
jalr       t9=>mac_is_moldy                                 undefined mac_is_moldy()
nop
lw         gp,local_bdc(sp)
bne        mim_ret2,zero,LAB_0fac49a0
addiu     t8,sp,0x410
lw         byte_memcpy_csr,out_path_buf(sp)
                    LAB_0fac4918                                    XREF[1]:     0fac48f0(j)  
lw         t9,-0x77c0(gp)=>->strncpy                        = 0fac2454
subu       buf_str_len,buf_str_len,s0
addu       endOfOutStr,byte_memcpy_csr,buf_str_len
or         mac_d_ino,endOfOutStr,zero
or         __size,dirNamePtr,zero
jalr       t9=>strncpy                                      char * strncpy(char * __dest, ch
or        a2,s0,zero
lw         gp,local_bdc(sp)
li         memcpy_csr_2,0x2f
sb         memcpy_csr_2,-0x1(endOfOutStr)
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
addiu      buf_str_len,buf_str_len,-0x1
addiu      endOfOutStr,endOfOutStr,-0x1
jalr       t9=>closedir                                     int closedir(DIR * dirp)
or        mac_d_ino,s2,zero
lw         gp,local_bdc(sp)
b          LAB_0fac49a0
addiu     t8,sp,0x410
                    LAB_0fac4960                                    XREF[1]:     0fac4890(j)  
lw         t9,-0x77c0(gp)=>->strncpy                        = 0fac2454
subu       buf_str_len,buf_str_len,s0
addu       endOfOutStr,t6,buf_str_len
jalr       t9=>strncpy                                      char * strncpy(char * __dest, ch
or        mac_d_ino,endOfOutStr,zero
lw         gp,local_bdc(sp)
li         t7,0x2f
sb         t7,-0x1(endOfOutStr)
lw         t9,-0x7eec(gp)=>->closedir                       = 0facb264
addiu      buf_str_len,buf_str_len,-0x1
addiu      endOfOutStr,endOfOutStr,-0x1
jalr       t9=>closedir                                     int closedir(DIR * dirp)
or        mac_d_ino,s2,zero
lw         gp,local_bdc(sp)
nop
addiu      t8,sp,0x410
                    LAB_0fac49a0                                    XREF[2]:     0fac490c(j), 0fac4958(j)  
addiu      t9,s3,-0x3
sltu       at,t9,t8
bne        at,zero,LAB_0fac49cc
li        mim_ret2,0x2e
li         t0,0x2f
sb         t0,Stack[-0x204](s3)
sb         mim_ret2,Stack[-0x205](s3)
sb         mim_ret2,Stack[-0x206](s3)
addiu      s3,s3,-0x3
b          LAB_0fac4550
sb        zero,local_201(sp)
                    LAB_0fac49cc                                    XREF[2]:     0fac45a0(j), 0fac49a8(j)  
lw         t1,allocated_path_buf(sp)
                    LAB_0fac49d0                                    XREF[4]:     0fac4608(j), 0fac46e0(j), 
                                                                                0fac47c0(j), 0fac4880(j)  
nop
beq        t1,zero,LAB_0fac49f8
or        mim_ret2,zero,zero
lw         t9,-0x7304(gp)=>->free                           = 0fabf650
lw         mac_d_ino,out_path_buf(sp)
jalr       t9=>free                                         void free(void * __ptr)
nop
lw         gp,local_bdc(sp)
nop
or         mim_ret2,zero,zero
                    LAB_0fac49f8                                    XREF[4]:     0fac449c(j), 0fac44c4(j), 
                                                                                0fac450c(j), 0fac49d4(j)  
lw         ra,local_bd4(sp)
                    LAB_0fac49fc                                    XREF[1]:     0fac4678(j)  
lw         s0,local_bfc(sp)
lw         dirNamePtr,local_bf8(sp)
lw         s2,local_bf4(sp)
lw         s3,local_bf0(sp)
lw         s4,local_bec(sp)
lw         s5,local_be8(sp)
lw         s6,local_be4(sp)
lw         endOfOutStr,local_be0(sp)
lw         buf_str_len,local_bd8(sp)
jr         ra
addiu     sp,sp,0xc10
