
/* WARNING: Could not reconcile some variable overlaps */

char * getcwd(char *__buf,size_t __size)

{
  int plabel;
  int is_mac_moldy;
  int stat_ret;
  DIR *dirp;
  int fstat_dir_ret;
  undefined4 oserr;
  dirent *de;
  int lstat_ret;
  dirent *de_notSameDev;
  int lstat_ret_l2;
  size_t dirNameLen;
  int sgiLabel;
  int iVar1;
  __ino_t mac_d_ino;
  int *byteptr_prev_st;
  int *memcpy_csr_2;
  int *byteptr_cur_st;
  int *byte_memcpy_csr;
  uchar *dirNamePtr;
  char *filename;
  char *endOfOutStr;
  int buf_str_len;
  char *out_path_buf;
  int is_mac_supported;
  undefined macLabel [516];
  int allocated_path_buf;
  stat st;
  int iStack2324;
  stat lst;
  stat prev_st;
  //char acStack2048 [1533];
  char pathBuf[1538];
  char strBuf [512];
  bool mac_is_moldy;
  
  filename = &pathBuf;
  mac_is_moldy = false;
  is_mac_supported = sysconf(0x1c);
  if (is_mac_supported == 1) {
    plabel = sgi_getplabel(macLabel);
    if (plabel < 0) {
      perror(&DAT_0faaec20);
      exit(1);
    }
    is_mac_moldy = mac_is_moldy(macLabel);
    if (is_mac_moldy != 0) {
      mac_is_moldy = true;
    }
  }
  else {
    is_mac_supported = 0;
  }
  if (__size == 0) {
    setoserror(0x16);
  }
  else {
    stat_ret = stat(".",&st);
    if (-1 < stat_ret) {
      allocated_path_buf = 0;
      out_path_buf = __buf;
      if (__buf == (char *)0x0) {
        out_path_buf = (char *)malloc(__size);
        if (out_path_buf == (char *)0x0) {
          setoserror(0xc);
          return (char *)0x0;
        }
        allocated_path_buf = 1;
      }
      buf_str_len = __size - 1;
      pathBuf[0] = '.';
      pathBuf[1] = '.';
      pathBuf[2] = '\0';
      endOfOutStr = out_path_buf + buf_str_len;
      *endOfOutStr = '\0';
      while( true ) {
        byteptr_prev_st = (int *)&prev_st;
        byteptr_cur_st = (int *)&st;
        do {
          byte_memcpy_csr = byteptr_cur_st + 3;
          byteptr_prev_st[0] = byteptr_cur_st[0];
          memcpy_csr_2 = byteptr_prev_st + 3;
          byteptr_prev_st[1] = byteptr_cur_st[1];
          byteptr_prev_st[2] = byteptr_cur_st[2];
          byteptr_prev_st = memcpy_csr_2;
          byteptr_cur_st = byte_memcpy_csr;
        } while (byte_memcpy_csr != &iStack2324);
        *memcpy_csr_2 = *byte_memcpy_csr;
        dirp = opendir(filename);
        if (dirp == (DIR *)0x0) goto free_and_fail;
        fstat_dir_ret = fstat(*(int *)dirp,&st);
        if (fstat_dir_ret < 0) break;
        if (prev_st.st_dev == st.st_dev) {
          if (prev_st.st_mode == st.st_mode) {
            closedir(dirp);
            if (buf_str_len + 1U == __size) {
              endOfOutStr = endOfOutStr + -1;
              *endOfOutStr = '/';
            }
            strcpy(out_path_buf,endOfOutStr);
            return out_path_buf;
          }
          do {
            de = readdir(dirp);
            if (de == (dirent *)0x0) {
              oserr = oserror();
              closedir(dirp);
              setoserror(oserr);
              goto free_and_fail;
            }
            if (is_mac_supported == 0) {
              mac_d_ino = de->d_ino;
              lstat_ret = 0;
            }
            else {
              strcpy(strBuf,(char *)&de->d_type);
              lstat_ret = lstat(filename,&lst);
              mac_d_ino = lst.st_mode;
            }
          } while ((lstat_ret == -1) || (mac_d_ino != prev_st.st_mode));
          dirNamePtr = &de->d_type;
        }
        else {
          do {
            de_notSameDev = readdir(dirp);
            if (de_notSameDev == (dirent *)0x0) {
              oserr = oserror();
              closedir(dirp);
              setoserror(oserr);
              goto free_and_fail;
            }
            dirNamePtr = &de_notSameDev->d_type;
            strcpy(strBuf,(char *)dirNamePtr);
            lstat_ret_l2 = lstat(filename,&lst);
          } while (((lstat_ret_l2 == -1) || (lst.st_mode != prev_st.st_mode)) ||
                  (lst.st_dev._0_4_ != prev_st.st_dev._0_4_));
        }
        dirNameLen = strlen((char *)dirNamePtr);
        if ((buf_str_len == 0) || (buf_str_len - 1U < dirNameLen)) {
          setoserror(0x22);
          closedir(dirp);
          goto free_and_fail;
        }
        if (is_mac_supported == 0) {
          endOfOutStr = out_path_buf + (buf_str_len - dirNameLen);
          strncpy(endOfOutStr,(char *)dirNamePtr,dirNameLen);
          endOfOutStr[-1] = '/';
          buf_str_len = (buf_str_len - dirNameLen) + -1;
          endOfOutStr = endOfOutStr + -1;
          closedir(dirp);
        }
        else {
          sgiLabel = sgi_getlabel(filename,macLabel);
          if (sgiLabel < 0) {
            perror(&DAT_0faaec28);
            exit(1);
          }
          if ((mac_is_moldy) || (iVar1 = mac_is_moldy(macLabel), iVar1 == 0)) {
            endOfOutStr = out_path_buf + (buf_str_len - dirNameLen);
            strncpy(endOfOutStr,(char *)dirNamePtr,dirNameLen);
            endOfOutStr[-1] = '/';
            buf_str_len = (buf_str_len - dirNameLen) + -1;
            endOfOutStr = endOfOutStr + -1;
            closedir(dirp);
          }
        }
        if (filename + -3 < acStack2048) goto free_and_fail;
        filename[-1] = '/';
        filename[-2] = '.';
        filename[-3] = '.';
        filename = filename + -3;
      }
      oserr = oserror();
      closedir(dirp);
      setoserror(oserr);
free_and_fail:
      if (allocated_path_buf != 0) {
        free(out_path_buf);
      }
    }
  }
  return (char *)0x0;
}

