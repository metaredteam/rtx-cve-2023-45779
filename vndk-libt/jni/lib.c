#include <fcntl.h>
#include <unistd.h>

#include <android/log.h>

__attribute__((constructor))
void lets_go(void) {
	int res;

	char cmdline[1024];
	char *msg = "no cmdline";

	int cmdf = open("/proc/self/cmdline", O_RDONLY);
	res = read(cmdf, cmdline, sizeof(cmdline) - 1);
	close(cmdf);

	/* Replace NULs with spaces, NUL-terminate */
	if (res > 0) {
		int i;
		for (i = 0; i < res; ++i)
			if (cmdline[i] == '\0')
				cmdline[i] = ' ';
		cmdline[i] = '\0';
		msg = cmdline;
	}

	__android_log_print(ANDROID_LOG_INFO, "RTXPoC", "%s", cmdline);
}
