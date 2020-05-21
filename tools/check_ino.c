#include <dirent.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <errno.h>
#include <limits.h>

enum InoCmpResult {
    CmpOkay,
    CmpDirEnd,
    CmpError,
    CmpLstatError,
};

/**
 * macOS 10.15 seems to have an issue with ino values
 * when comparing ino between `stat` and `dirent`
 */
enum InoCmpResult compare_ino() {
    struct stat curSt;
    struct stat prevSt;
    struct stat lst;
    DIR *dirp;
    struct dirent *de;
    int ret;
    char path[PATH_MAX] = { '\0' };
    char prevPath[PATH_MAX] = { '\0' };
    char out[PATH_MAX] = { '\0' };
    char lstatPath[PATH_MAX] = { '\0' };

    ret = stat(".", &curSt);
    if (ret == -1) return CmpError;

    strcpy(path, "..");
    while (true) {
        memcpy(&prevSt, &curSt, sizeof(struct stat));

        dirp = opendir(path);
        if (dirp == NULL) return CmpError;
        ret = fstat(dirp->__dd_fd, &curSt);
        if (ret == -1) return CmpError;

        if (prevSt.st_dev == curSt.st_dev) {
            if (prevSt.st_ino == curSt.st_ino) {
                closedir(dirp);
                strcat(out, "/");

                printf("Found matching dev and ino at '%s'\n", path);
                printf("\t Prev: %s\n", prevPath);
                printf("\t       dev %x ino %llx\n", prevSt.st_dev, prevSt.st_ino);
                printf("\t Curr: %s\n", path);
                printf("\t       dev %x ino %llx\n", curSt.st_dev, curSt.st_ino);
                printf("Assuming that this is the root dir\n\n");
                printf("cwd: %s\n\n", out);

                return CmpOkay;
            }

            printf("checking for entry with ino %llx\n", prevSt.st_ino);
            printf("  at '%s'\n", path);
            errno = 0;
            while ((de = readdir(dirp))) {
                printf("\t'%s' [ino %llx]\n", de->d_name, de->d_ino);
                if ((uintptr_t)de->d_ino > UINT_MAX) {
                    memset(lstatPath, '\0', PATH_MAX);
                    memcpy(lstatPath, path, PATH_MAX);
                    strcat(lstatPath, "/");
                    strncat(lstatPath, de->d_name, de->d_namlen);
                    ret = stat(lstatPath, &lst);
                    if (ret == -1) {
                        perror("\t  issue when checking lstat");
                        errno = 0;
                        continue;
                    }
                    printf("\t\tino > u32\n");
                    printf("\t\tlstat ino %llx\n", lst.st_ino);
                    if (de->d_ino == prevSt.st_ino || lst.st_ino == prevSt.st_ino) break;
                }
                if (de->d_ino == prevSt.st_ino) break;
            }

            if (de == NULL) {
                if (errno != 0) return CmpError;
                else return CmpDirEnd;
            }
        } else {
            printf("devices did not match\n");
            printf("\tprev: %x\n", prevSt.st_dev);
            printf("\tcurr: %x\n", curSt.st_dev);

            printf("checking for entry with ino %llx\n", prevSt.st_ino);
            printf("  or with device %x\n", prevSt.st_dev);
            printf("  at '%s'\n", path);
            errno = 0;
            while ((de = readdir(dirp))) {
                printf("\t'%s'  [ino %llx]\n", de->d_name, de->d_ino);

                memset(lstatPath, '\0', PATH_MAX);
                memcpy(lstatPath, path, PATH_MAX);
                strcat(lstatPath, "/");
                strncat(lstatPath, de->d_name, de->d_namlen);
                printf("\t  lstat(%s)\n", lstatPath);
                ret = lstat(lstatPath, &lst);
                if (ret == -1) {
                    perror("\t  issue when checking lstat");
                    errno = 0;
                    continue;
                }

                printf("\t  lstat [ino %llx dev %x]\n", lst.st_ino, lst.st_dev);


                if (lst.st_ino == prevSt.st_ino || lst.st_dev == prevSt.st_dev) break;
            }

            if (de == NULL) {
                if (errno != 0) return CmpError;
                else return CmpDirEnd;
            }

        }
        printf("found matching ino with '%s'\n", de->d_name);
        strcat(out, "/");
        strcat(out, de->d_name);
        memcpy(prevPath, path, PATH_MAX);
        strcat(path, "/..");
        closedir(dirp);
    }

    return CmpError;
}


int main(void) {
    switch (compare_ino()) {
        case CmpOkay: return 0;
        case CmpDirEnd: 
            fprintf(stderr, "ran out of dirents before finding ino match\n");
            return 1;
        case CmpLstatError:
            perror("issue when checking lstat");
            return 2;
        case CmpError:
            perror("weird C error");
            return 3;
    }
}
