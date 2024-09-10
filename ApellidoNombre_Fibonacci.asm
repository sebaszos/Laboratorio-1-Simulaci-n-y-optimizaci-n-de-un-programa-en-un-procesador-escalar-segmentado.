.data
n: .word 0        # Para almacenar el número de elementos a generar
a: .word 0        # Primer número en la secuencia Fibonacci
b: .word 1        # Segundo número en la secuencia Fibonacci
temp: .word 0     # Variable temporal para cálculos
sum: .word 0      # Para almacenar la suma de la secuencia

prompt1: .asciiz "Ingrese la cantidad de números de la serie Fibonacci: "
result1: .asciiz "La serie Fibonacci es: "
result2: .asciiz "La suma de la serie es: "

.text
.globl main

main:
    # Solicitar al usuario la cantidad de números a generar
    li $v0, 4
    la $a0, prompt1
    syscall
    
    li $v0, 5
    syscall
    sw $v0, n
    
    # Inicializar sum con el primer número
    lw $t0, a
    lw $t1, b
    add $t2, $t0, $t1
    sw $t2, sum
    
    # Mostrar el primer número de la serie
    li $v0, 4
    la $a0, result1
    syscall
    
    li $v0, 1
    lw $a0, a
    syscall
    
    # Mostrar el segundo número de la serie
    li $v0, 1
    lw $a0, b
    syscall
    
    # Bucle para generar la secuencia Fibonacci
    lw $t3, n
    addi $t4, $zero, 2  # Inicializar el contador en 2
    
fibonacci_loop:
    beq $t4, $t3, endloop  # Si se ha generado la cantidad requerida, salir del bucle
    
    # Calcular el siguiente número de la serie
    lw $t0, a
    lw $t1, b
    add $t2, $t0, $t1
    sw $t2, temp
    
    # Actualizar los valores de a y b
    sw $t1, a
    sw $t2, b
    
    # Sumar al total
    lw $t5, sum
    add $t5, $t5, $t2
    sw $t5, sum
    
    # Mostrar el siguiente número de la serie
    li $v0, 1
    move $a0, $t2
    syscall
    
    addi $t4, $t4, 1
    j fibonacci_loop

endloop:
    # Mostrar la suma de la serie
    li $v0, 4
    la $a0, result2
    syscall
    
    lw $a0, sum
    li $v0, 1
    syscall
    
    # Finalizar el programa
    li $v0, 10
    syscall

