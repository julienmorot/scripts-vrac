// Simple demo script to freeze a FS, for a backup for example

#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <mntent.h>
#include <linux/fs.h>

main(int argc, char **argv) {
        int fd;
        int ret;
        fd = open("/opt", O_RDONLY);
        if (fd == -1) {
            printf("failed to open fd");
        }

        ret = ioctl(fd, FIFREEZE);
        if (ret != 0) {
                printf("ret : %d", ret);
                printf("Error : %s\n", strerror(errno));
                printf("failed to freeze fs\n");
        }
        close(fd);
}


