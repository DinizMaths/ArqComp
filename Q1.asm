#===================================#
# Nome: Matheus Gomes Diniz Andrade #
#===================================#

.data
	ref:   .word  2,  3, 11, 16, 21, 13, 64, 48, 19, 11,  3, 22,  4, 27,  6, 11 # Array de referências
	cache: .word -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 # Inicializando cache com valores inválidos
	
	size:  .word 16 # Tamanho do array de referências
	
	msg1:  .ascii   "HIT: "
	hit:   .word 0  # Número de acertos
	
	msg2:  .ascii   "\nMISS: "
	miss:  .word 0  # Número de erros


.text
	main:
		li $t0, 0 # t0 = 0 (Índice do array ref)
		li $t1, 0 # t1 = 0 (Índice do array cache)
		
		li $t2, 0 # t2 = 0 (Valor atual do array ref)
		li $t3, 0 # t3 = 0 (Valor atual do array cache)
		
		lw   $s0, size  # s0 = 16
		lw   $s1, hit   # s1 = hit
		lw   $s2, miss  # s2 = miss
		
		li   $t4, 0     # t4 = 0 (contador do loop)

	loop:
		beq  $t4, $s0, end   # se t4 == 16, finaliza (vai para end)
    addi $t4, $t4, 1     # t4 = t4 + 1
    
		lw   $t2, ref($t0)   # t2 = ref[t0]
		div  $t2, $s0        # Divisão t2 / s0 (ref[t0] / 16)
		mfhi $t1             # Resto da divisão
		mul  $t1, $t1, 4     # t1 = t1 * 4
		
		addi $t0, $t0, 4     #t0 = t0 + 4
		
		lw   $t3, cache($t1) # t3 = cache[t1]
		bne  $t3, $t2, if    #va para if caso t3 != t2 (cache[t1] != ref[t0])
		
		j loop               # voltar ao loop
		
		
	if:
		sw   $t2, cache($t1) # t2 = cache[t1]
		addi $s2, $s2, 1     # s2 = s2 + 1 (miss++)
		j loop               # voltar ao loop
	
		
	end:
		sub $s1, $s0, $s2    # s1 = s0 - s2 (hit = 16 - miss)
	
		#Imprimir acertos
		li $v0, 4
		la $a0, msg1
		syscall
		li $v0, 1
		move $a0, $s1
		syscall
	
		#Imprimir erros
		li $v0, 4
		la $a0, msg2
		syscall
		li $v0, 1
		move $a0, $s2
		syscall
	
		#Encerrar
		li $v0, 10
		syscall












































#===================================#
# Nome: Matheus Gomes Diniz Andrade #
#===================================#