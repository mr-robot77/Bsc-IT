#include <time.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/resource.h>
#include <stdlib.h> 
#include <linux/kernel.h>
#include <stdio.h>
int main () 
{ 
int who = RUSAGE_SELF;
 struct rusage usage;
int ret;
ret = getrusage(who, &usage);
 printf ("CPU time: %ld.%06ld sec user, %ld.%06ld sec system\n",
     usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
     usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
 return 0;
}
