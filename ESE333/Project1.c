/*
*
*@author Ashikul Alam
*ID: 108221262
*Stony Brook ESE 333
*
*Project 1
*A simple Unix shell interpreter written in C.
*
*-Features commands such as ls, man, cat and grep.
*-Includes input and output redirection, pipes, and background jobs.
*-Checks for operators, <, >, |, & once
*-No support for multiple pipes
*
*/

/* Imports */

#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Prototypes */

//Minor function to obtain a valid user input in one line
char* getCommand(char* str, int max_chars);

//Major function to tokenize string, check operators, and set up for execution
void parseCommand(char* input_command);

//Final function to execute and output to user
void executeCommand(char* c_argv[], int c_argc, int fg, int in_fd, int out_fd);

//Extra function for -cd command
void cd_Command(char* c_argv[], int c_argc);

//Used to break main while loop 
int quitFlag = 0; 

/* Main while loop */

int main()
{	while (!quitFlag)
	{
		
		/* Store command */
		char command[100];
		
		/* Print prompt */
		printf("Project1Shell:%s$ " getenv("PWD")); 

		/* Check if user input is valid */
		if (getCommand(command, 100) == NULL) {
			quitFlag = 1;
			puts("\n");
		} else if (strlen(command) < 1) {
		/* Nothing was entered  */
		} else {
			/* Execute command */
			parseCommand(command);
		}
	}
	return EXIT_SUCCESS;
}

char* getCommand(char* str, int max_chars)
{	char* fret = fgets(str, max_chars, stdin);
	int i = strlen(str)-1;
	if (str[i] == '\n')
	str[i] = '\0';
	return fret;
	//Fix for long commands that don't fit one line
}

void parseCommand(char* input_command)
{	
	assert(strlen(input_command) > 0);
	char* c_argv[50];
	
	/* Tokenize the string */
	char* token = strtok(input_command, " \t");
	
	/* Check flag for a runnable command*/
	int runFlag = 0;
	
	/* Check flag for valid tokens*/
	int tokenFlag = 0;
	
	/* Number of arguments*/
	int c_argc = 0;
	
	/* File descriptors */
	int fg = 1;
	int out_fd = STDOUT_FILENO;
	int in_fd = STDIN_FILENO;
	int next_in_fd = -1;
	
	/* Main parse check */
	for (;;)
	{
		if (next_in_fd != -1)
		{
			in_fd = next_in_fd;
			next_in_fd = -1;
		}
		if (token == NULL)
		{
			tokenFlag = 1;
			runFlag = 1;
		}
		else if (strcmp(token, "&") == 0)
		{
			fg = 0;
			runFlag = 1;
		}
		/* Single pipe set up is supported*/
		else if ((strcmp(token, "|") == 0) && (out_fd == STDOUT_FILENO))
		{
			int pipe_fds[2];
			if (pipe(pipe_fds) == -1)
			{
				perror("pipe");
				break;
			}
			out_fd = pipe_fds[1];
			next_in_fd = pipe_fds[0];
			runFlag = 1;
		}
		else if ((strcmp(token, ">") == 0) && (out_fd == STDOUT_FILENO))
		{
			char* out_name = strtok(NULL, " \t");
			if (out_name == NULL)
			{
				fputs("Error! Invalid location for output redirection!\n", stderr);
				break;
			}
			out_fd = open(out_name, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
			if (out_fd == -1)
			{
				perror("open");
				break;
			}
		}
		else if ((strcmp(token, "<") == 0) && (in_fd == STDIN_FILENO))
		{
			char* in_name = strtok(NULL, " \t");
			if (in_name == NULL)
			{
				fputs("Error! Invalid location for input redirection!\n", stderr);
				break;
			}
			in_fd = open(in_name, O_RDONLY);
			if (in_fd == -1)
			{
				perror("open");
				break;
			}
		}
		else
		{
			c_argv[c_argc++] = strdup(token);
		}
		/* Run Command */
		
		if (runFlag && c_argc)
		{
			c_argv[c_argc] = NULL;
			c_argc--;
			executeCommand(c_argv, c_argc, fg, in_fd, out_fd);
			int i;
			for (i = 0; i <= c_argc; i++)
			free(c_argv[i]);
			c_argc = 0;
			runFlag = 0;
			fg = 1;
			
			/* Close fds */
			if (out_fd != STDOUT_FILENO)
			{
				close(out_fd);
				out_fd = STDOUT_FILENO;
			}
			if (in_fd != STDIN_FILENO)
			{
				close(in_fd);
				in_fd = STDIN_FILENO;
			}
		}
		/* Check token flag */
		if (tokenFlag)
		{
			return;
		}
		token = strtok(NULL, " \t");
	}
}

void executeCommand(char* c_argv[], int c_argc, int fg, int in_fd, int out_fd)
{	if (strcmp(c_argv[0], "cd") == 0) {
		/* "cd" command function*/
		cd_Command(c_argv, c_argc);
		/* Check for exit and quit */
	} else if ((strcmp(c_argv[0], "exit") == 0) || (strcmp(c_argv[0], "quit") == 0)) {
		quitFlag = 1;
	} else {
		int c_pid = 0;
		c_pid = fork();
		if (c_pid == -1) {
			fprintf(stderr, "Fork() failed!.");
			exit(EXIT_FAILURE);
		} else if (!c_pid) {
			
			/* Child Process*/
			if (in_fd != 0) {
				close(0);
				dup(in_fd);
			}
			if (out_fd != 1) {
				close(1);
				dup(out_fd);
			}
			execvp(c_argv[0], c_argv);
		}
		/* Parent process */
		if (fg)
		wait(NULL);
	}
}

void cd_Command(char* c_argv[], int c_argc)
{	if (c_argc != 1) {
		printf("command: cd dir\n");
	} else {
		if (chdir(c_argv[1]) == 0) {
			char cwd[100];
			getcwd(cwd, sizeof(cwd));
			setenv("PWD", cwd, 1);
		} else {
			printf("Directory could not be changed! \"%s\"\n", c_argv[1]);
		}
	}
}