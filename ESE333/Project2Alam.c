/*
*
*
*@author Ashikul Alam
*ID: 108221262
*Stony Brook ESE 333
*Machine used: Windows 8.1 with SSH Client & xwin32
*
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~Project 2~~~~~~~~~~~~~~~~~
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*
*Implementation of the producer-consumer problem
*using a shared memory buffer and a monitor.
*File1's contents are byte by byte copied into a buffer
*and then transferred to File2.
*
*I did not use these specific system calls:
*---Forks 
*---Semaphores
*---Signals
*
*Instead, I used these similar advanced system calls:
*---Threads (thr_create)
*---Mutexes (mutex-lock())
*---Conditional Signals (cond_signal())
*
*
*To run the program:
*-MUST be in jessica server for compile to work
*-NOT labXX.ece.stonybrook.edu server
*-ex: [ug001@jessica ~ ]
*-NOT [ug001@lab38.ece.stonybrook.edu ~ ]
*
*
*Next:
*-Have file Project2Alam.c in current directory
*-to compile, type "gcc -o Project2Alam Project2Alam.c"
*-to run, type "./Project2Alam"
*-Program will automatically start copying file1 into file2
*-There is an error message if there is no "file1" in current directory
*
*
*Output:
*-Total program run time depends on file1 size
*-Check that file2 is the SAME as file1
*-Check that the file "table" shows a line of P's and C's and    *	the total run time in microseconds
*
*/

/* Imports */

//Import differently for sleep function depending on machine
#ifdef __unix__
# include <unistd.h>
#elif defined _WIN32
# include <windows.h>
#define sleep(x) Sleep(x)
#endif

#define _REEENTRANT
#include <stdio.h>
#include <thread.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/uio.h>

//Transfer size of producer/consumer
#define BUFFER_TRANSFER_SIZE 1
//Length of shared buffer
#define BUFFER_LENGTH  1
//Delay of sleep function range in microseconds
#define CONSUMER_MIN_DELAY 100 //0.1ms
#define CONSUMER_MAX_DELAY 60000 //60ms
#define PRODUCER_MIN_DELAY 300 
#define PRODUCER_MAX_DELAY 85000

/* Monitor data structure used for the producer
   and consumer threads */
  
struct {
		//Shared buffer
        char buffer[BUFFER_LENGTH][BUFFER_TRANSFER_SIZE];
		//Buffer data holder
        int byteinbuf[BUFFER_LENGTH];
		//Lock for using the shared buffer
        mutex_t buffer_lock;
		//Lock for producer/consumer thread
        mutex_t done_lock;
		//Producer add to shared buffer flag
        cond_t add_dataFlag;
		//Consumer take from shared buffer flag
        cond_t remove_dataFlag;
		//Counters
        int add_counter, remove_counter, occupied, done;
		//File descriptor for monitor table output
	   int table;
		//Integer to store consumer time
	   int consumer_time;
		//Integer to store producer time
	   int producer_time;
		//Consumer + Producer time
	   int total_time;
		
} Buffer; //Shared Buffer object

/* Function prototypes */
void *consumer(void *);
int rand_range(int min_n, int max_n);

/* Main function*/
main(int argc, char **argv)
{
//file1 and file2 file descriptors
int ifd, ofd;
//Thread initialized
thread_t cons_thr;

/* Open the input file for the producer */
if ((ifd = open("file1", O_RDONLY)) == -1)
        {
        fprintf(stderr, "Can't open file %s\n", "file1");
        exit(1);
        }

/* Open the output file for the consumer */
if ((ofd = open("file2", O_WRONLY|O_CREAT, 0666)) == -1)
        {
        fprintf(stderr, "Can't open file %s\n", "file1");
        exit(1);
        }

/* Open the monitor table for output */		
Buffer.table = open("table", O_WRONLY|O_CREAT, 0666);		

/* Various counters set to 0 */
Buffer.add_counter = Buffer.remove_counter = Buffer.occupied = Buffer.done = 0;

Buffer.total_time = Buffer.consumer_time = Buffer.producer_time = 0;

/* Thread concurrency set to 2 so the producer and consumer can
   run concurrently */
thr_setconcurrency(2);

/* Create the consumer thread */
thr_create(NULL, 0, consumer, (void *)ofd, NULL, &cons_thr);

/* Producer Loop*/
while (1) {

        /* Lock the shared buffer mutex */
        mutex_lock(&Buffer.buffer_lock);
 
		/* Check to see if any buffers are empty */
        /* If not then wait for that condition to become true */
        while (Buffer.occupied == BUFFER_LENGTH)
                cond_wait(&Buffer.remove_dataFlag, &Buffer.buffer_lock);

        /* Read from the file and put data into a buffer */
        Buffer.byteinbuf[Buffer.add_counter] = read(ifd,Buffer.buffer[Buffer.add_counter],BUFFER_TRANSFER_SIZE);

        /* Check to see if done reading */
        if (Buffer.byteinbuf[Buffer.add_counter] == 0) {

                /* Lock the done lock */
                mutex_lock(&Buffer.done_lock);

                /* Set the done flag and release the mutex lock */
                Buffer.done = 1;
                mutex_unlock(&Buffer.done_lock);

                /* Signal the consumer to start consuming */
                cond_signal(&Buffer.add_dataFlag);

                /* Release the buffer mutex */
                mutex_unlock(&Buffer.buffer_lock);

                /* Leave the while loop */
                break;
                }

        /* Set the next buffer to fill */
        Buffer.add_counter = ++Buffer.add_counter % BUFFER_LENGTH;

        /* Increment the number of buffers that are filled */
        Buffer.occupied++;

        /* Signal the consumer to start consuming */
        cond_signal(&Buffer.add_dataFlag);

        /* Release the mutex */
        mutex_unlock(&Buffer.buffer_lock);
		
		Buffer.consumer_time = rand_range(CONSUMER_MIN_DELAY, CONSUMER_MAX_DELAY);
		Buffer.total_time = Buffer.total_time + Buffer.consumer_time;
		/* Random Delay */
		usleep(Buffer.consumer_time);
		
		/* Write to monitor table*/
		write(Buffer.table, "C", 1);
		
        }

/* Close file descriptor*/		
close(ifd);

/* Wait for the consumer to finish */
thr_join(cons_thr, 0, NULL);

/* Write a string to monitor table */
char *output_string;
output_string = "\nTotal time (in us) : ";
write(Buffer.table, output_string , strlen(output_string));

/* Write the total time to monitor table*/
char *p, total[512];
sprintf(total, "%d", Buffer.total_time);
p = total;
write(Buffer.table, p, strlen(p));

/* Close monitor table*/
/* Check file "table" in directory for output*/
close(Buffer.table);

/* Exit the program */
return(0);
}


/* The Consumer Thread */
void *consumer(void *arg)
{
int fd = (int) arg;

/* Check to see if any buffers are filled or if the done flag is set */
while (1) {

        /* Lock the mutex */
        mutex_lock(&Buffer.buffer_lock);

        if (!Buffer.occupied && Buffer.done) {
           mutex_unlock(&Buffer.buffer_lock);
           break;
           }

        /* Check to see if any buffers are filled */
        /* iI not then wait for the condition to become true */
        while (Buffer.occupied == 0 && !Buffer.done)
                cond_wait(&Buffer.add_dataFlag, &Buffer.buffer_lock);

        /* Write the data from the buffer to the file */
        write(fd, Buffer.buffer[Buffer.remove_counter], Buffer.byteinbuf[Buffer.remove_counter]);

        /* Set the next buffer to write from */
        Buffer.remove_counter = ++Buffer.remove_counter % BUFFER_LENGTH;

        /* Decrement the number of buffers that are full */
        Buffer.occupied--;

        /* Signal the producer that a buffer is empty */
        cond_signal(&Buffer.remove_dataFlag);

        /* Release the mutex */
        mutex_unlock(&Buffer.buffer_lock);
		
		
		Buffer.producer_time = rand_range(PRODUCER_MIN_DELAY, PRODUCER_MAX_DELAY);
		Buffer.total_time = Buffer.total_time + Buffer.producer_time;
		usleep(Buffer.producer_time);

		/* Write to the monitor table*/
		write(Buffer.table, "P", 1);
		
        }

/* Exit the thread */
thr_exit((void *)0);
}

/* Function to get a random integer, dependent on initial seed*/
int rand_range(int min_n, int max_n)
{
    return rand() % (max_n - min_n + 1) + min_n;
}


