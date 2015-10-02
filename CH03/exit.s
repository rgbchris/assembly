# PURPOSE: Simple program that exits and returns a
# status code back to the Linux kernel
#

# INPUT: none
#

# OUTPUT: returns a status code. This can be viewed
# by typing
#
# echo $?
#
# after running the program
#

# VARIABLES:
# %eax holds the system call number
# (this is always the case)
#
# %ebx holds the return status
#

.section .data

.section .text

.globl _start
_start:

# move the number 1 into %eax
# dollar sign in from of the 1 indicates that we
# want to use immediate mode addressing, e.g.
# we want the actual number loaded in

# system calls need to be loaded into %eax

movl $1, %eax # this is the linux kernel command
              # number (system call) for exiting
              # a program

movl $0, %ebx # this is the status number we will
              # return to the operating system.
              # Change this around and it will
              # return different things to
              # echo $?

# int stands for interrupt, transferring control
# from out program to Linux so it can do a 
# system call. (This is how operating system 
# features are accessed)

int $0x80     # this wakes up the kernel to run
              # the exit command
