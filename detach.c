#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

#ifndef NULL
#define NULL  ((void*) 0)
#endif

static void replacefd(int fd, const char *filename, int flags, int mode) {
	int n;
	n = open(filename, flags, mode);
	if(n < 0) {
		perror(filename);
		exit(1);
	} else {
		dup2(n, fd);
		close(n);
	}
}

int main(int argc, char **argv) {
	int do_fork = 1, command_start, i;
	char *infile = NULL, *outfile = NULL, *errfile = NULL, *pidfile = NULL;
	FILE *pidfh;

	/* Parse command line */
	for(i = 1; i < argc; i++) {
		if(!strcmp(argv[i], "-e")) errfile = argv[++i];
		else if(!strcmp(argv[i], "-f")) do_fork = 0;
		else if(!strcmp(argv[i], "-i")) infile = argv[++i];
		else if(!strcmp(argv[i], "-o")) outfile = argv[++i];
		else if(!strcmp(argv[i], "-p")) pidfile = argv[++i];
		else if(!strcmp(argv[i], "--")) {
			i++;
			break;
		} else if(argv[i][0] == '-') {
			fprintf(stderr, "Invalid option: %s\n", argv[i]);
			exit(0x80);
		} else break;
	}
	command_start = i;

	if(do_fork && fork()) return 0;

	if(pidfile) {
		pidfh = fopen(pidfile, "w");
		if(!pidfh) {
			perror(pidfile);
			exit(1);
		}
		fprintf(pidfh, "%d\n", getpid());
		fclose(pidfh);
	}

	if(infile) replacefd(0, infile, O_RDONLY, 0666);
	else close(0);
	if(outfile) replacefd(1, outfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
	else close(1);
	if(errfile) replacefd(2, errfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
	else close(2);
	setsid();

	execvp(argv[command_start], &argv[command_start]);

	perror(argv[command_start]);
	return -1;
}
