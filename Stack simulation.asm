.data
	mesMenu:	.asciiz "\nChoose what you want to do (1 - write a number (push), 2 - write a number (pop))\n"
	input:		.asciiz "\nPlease enter the number: "
	ifNext:		.asciiz "\nDo you want to enter another number? (1 - yes, 0 - no)\n"
	mesPrint:	.asciiz "\nDo you want to print a number? (1 - yes, 0 - no (exit to the menu))\n"
	
.text
	main:
		# asking the user what he wants to do
		li $v0, 4
    		la $a0, mesMenu
    		syscall
    		
    		li  $v0, 5
    		syscall
    		
		beq $v0, 1, pushNr
		beq $v0, 2, print
		nop
		
		j main
		nop
		
	end:
		li $v0, 10
		syscall
		
		
	pushNr: # get a number from the user
		li $v0, 4
    		la $a0, input
    		syscall
    		
    		li  $v0, 6
    		syscall
    		
    		# store the number on the stack
    		s.s $f0, 0($sp)
    		addi $sp, $sp, 4
    		
    		# count how many numbers we added on the stack
    		addi $t0, $t0, 1
    		
    		# question for the next number
    		li $v0, 4
		la $a0, ifNext
    		syscall
    		
    		li $v0, 5
    		syscall
    		beq $v0, 1, pushNr
    		nop
    		
    		j main
    		nop
    		
    		
    	print: # displaying the entered numbers
    		# asking the user what he wants to do
    		li $v0, 4
    		la $a0, mesPrint
    		syscall
    		
    		li $v0, 5
    		syscall
    		blt $v0, 1, main
    		nop
    		
    		# if we have listed all our numbers then we cannot continue
    		ble $t0, 0, main
    		
    		# printing from the stack and displaying
    		addi $sp, $sp, -4
    		l.s $f12, 0($sp)
    		
    		li $v0, 2
    		syscall
    		
    		# change the number of numbers that have been saved on the stack
    		sub $t0, $t0, 1
    		
    		j print
    		nop
