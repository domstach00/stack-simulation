.data
	mesMenu:	.asciiz "\nWybierz co chcesz zrobic (1 - wpisac liczbe (push), 2 - wypisac liczbe (pop))\n"
	input:		.asciiz "\nProsze wporwadzic liczbe: "
	ifNext:		.asciiz "\nCzy chcesz wprowadzic kolejna liczbe? (1 - tak, 0 - nie)\n"
	mesPrint:	.asciiz "\nCzy chcesz wypisac liczbe? (1 - tak, 0 - nie (wyjscie do menu))\n"
	
.text
	main:
		# pytanie uzytkownika co chce zorbic
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
		
		
	pushNr: # pobieramy liczbe od uzytkownika
		li $v0, 4
    		la $a0, input
    		syscall
    		
    		li  $v0, 6
    		syscall
    		
    		# przechowujemy liczbe na stosie
    		s.s $f0, 0($sp)
    		addi $sp, $sp, 4
    		
    		# zliczamy ile liczb dodalismy na stos
    		addi $t0, $t0, 1
    		
    		# pytanie o kolejna liczbe
    		li $v0, 4
		la $a0, ifNext
    		syscall
    		
    		li $v0, 5
    		syscall
    		beq $v0, 1, pushNr
    		nop
    		
    		j main
    		nop
    		
    		
    	print: # wyswietlanie wpisanych liczb
    		# pytanie uzytkownika co chce zrobic
    		li $v0, 4
    		la $a0, mesPrint
    		syscall
    		
    		li $v0, 5
    		syscall
    		blt $v0, 1, main
    		nop
    		
    		# jesli wypisalismy wszystkie nasze liczby to nie mozemy kontynuowac
    		ble $t0, 0, main
    		
    		# wypisywanie ze stosu i wyswietlanie
    		addi $sp, $sp, -4
    		l.s $f12, 0($sp)
    		
    		li $v0, 2
    		syscall
    		
    		# zmieniamu ilosc liczb ktore zostaly zapisane na stosie
    		sub $t0, $t0, 1
    		
    		j print
    		nop
