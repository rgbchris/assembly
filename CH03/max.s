# PURPOSE: Find the maximum in a set of data items

# VARIABLES: The registers have the following uses
# 
# %edi - will hold the current position in the list
# %ebx - will hold the current highest value in the list
# %eax - will hold the current element being examined
#
# The following memory locations are used
#
# data_items - contains the item data. A 0 is used to
#              terminate the data

.section .data

data_items: # These are the data items (data_items: <- label)
  .long 3,67,34,222,45,75,54,34,44,33,22,11,66,0 # (.long <- directive)

  .section .text

  .globl _start
_start:
  movl $0, %edi     # move 0 into the index register
  # e.g. movl BEGINNINGADDRESS (,INDEXREGISTER,WORDSIZE)
  movl data_items(,%edi,4), %eax # lod the first byte of data
  movl %eax, %ebx   # since this is the first item, %eax is the biggest

start_loop:         # start loop
  cmpl $0, %eax     # check to see if we've hit the end, by checking if we are comparing 0
  je loop_exit      # "jump if equal" to exit loop
  incl %edi         # load next value
  movl data_items(,%edi,4), %eax
  cmpl %ebx, %eax   # compare values
  jle start_loop    # jump to loop beginning if the new
                    # one isn't bigger
  movl %eax, %ebx   # move the value as the largest
  jmp start_loop    # jump to loop beginning

loop_exit:
  # %ebx is the return value, and it already has the number
      movl $1, %eax  # 1 is the exit() syscall, syscall must be in this register
                     # exit status must be in %ebx (which will be our largest number)
      int $0x80 # interrupt with number 128

# "move long"
# movl A B => copies value from register A to register B
# cmpl => compare (checking equality)
# incl A => increments register A value by 1

# je  => jump if the values were equal
# jg  => jump if the second value was greater than the first value
# jge => jump if the second value was greater than or equal to the first value
# jl  => jump if the second value was less than the first value
# jle => jump if the second value was less then or equal to the first value
# jpm => jump no matter what, no need to be preceded by a comparison
