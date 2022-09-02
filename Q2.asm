#===================================#
# Nome: Matheus Gomes Diniz Andrade #
#===================================#

.data
	A:   .float 2.0
	B:   .float 3.0
	p:    .float 0.0
	TOL:  .float 0.1 # Tolerância
	N:    .word  10  # Máximo de iteraçoes
	
	# CONSTANTES AUXILIARES
	zero: .float 0.0
	dois: .float 2.0
	dez:  .float 10.0

	# TEXTOS
	msg1:  .asciiz "p = "
	msg2:  .asciiz "Raiz não encontrada!"

	
.text
	main:
	li $t0, 0 # t0 = 0 (contador)
	lw $s0, N # s0 = N
		
	lwc1 $f0, A
	lwc1 $f1, B
	lwc1 $f2, p
	lwc1 $f3, TOL
	
	lwc1 $f20, dois
	lwc1 $f21, zero
	lwc1 $f22, dez
	
	while: 
		beq   $t0, $s0, rootNotFound # se i == N vá para raizNaoEncontrada
		
		
		sub.s $f5, $f1, $f0  # f5 = b - a
		div.s $f5, $f5, $f20 # f5 = p / 2
		add.s $f2, $f0, $f5  # p = a + f5
		
		mul.s $f6, $f2, $f2  # FP = p * p
		mul.s $f6, $f6, $f2  # FP = p^2 * p
		sub.s $f6, $f6, $f22 # FP = p^3 - 10
		
		# Se FP == 0 vá para print
		c.eq.s $f6, $f21
		bc1t print
		
		# Se (b-a)<TOL vá para print
		c.lt.s $f5, $f3
		bc1t print
		
		addi  $t0, $t0, 1 # i = i + 1
		
		
		mul.s $f7, $f0, $f0  # FA = a * a
		mul.s $f7, $f7, $f0  # FA = a^2 * a
		sub.s $f7, $f7, $f22 # FA = a^3 - 10
		
		mul.s $f8, $f7, $f6  # f8 = FP * FA
		
		#if FP * FA > 0
			c.lt.s $f21, $f8
			bc1t if
		#else
			mov.s $f1, $f2 # b = p
			j while
 
	if: 
		mov.s $f0, $f2 # a = p
		mov.s $f7, $f6 # FA = FP
		j while
		
	print:
		# p = 
		li $v0, 4
		la $a0, msg1
		syscall
		
		# Imprime valor de p
		li $v0, 2
		add.s $f12, $f2, $f21
		syscall
		
		j end
			
	rootNotFound:
		# Imprime "Raiz não encontrada!"
		li $v0, 4
		la $a0, msg2
		syscall
		
		j end

	end:
		# Encerrar
		li $v0, 10
		syscall
