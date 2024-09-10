.data
n: .word 0        # Para almacenar el número de valores a comparar
max: .word 0      # Para almacenar el valor máximo
count: .word 0    # Contador para el ciclo

prompt1: .asciiz "Ingrese la cantidad de números a comparar (3-5): "
prompt2: .asciiz "Ingrese un número: "
result: .asciiz "El número mayor es: "

.text
.globl main

main:
    # Solicitar al usuario la cantidad de números a comparar
    li $v0, 4
    la $a0, prompt1
    syscall
    
    li $v0, 5
    syscall
    sw $v0, n
    
    # Inicializar max con el primer número
    li $v0, 4
    la $a0, prompt2
    syscall
    
    li $v0, 5
    syscall
    sw $v0, max
    
    # Bucle para comparar los números restantes
    lw $t0, n      # Cargar la cantidad de números a comparar
    addi $t1, $zero, 1  # Inicializar el contador en 1
    
loop:
    beq $t1, $t0, endloop   # Si se ha comparado el número requerido, salir del bucle
    
    # Solicitar el siguiente número
    li $v0, 4
    la $a0, prompt2
    syscall
    
    li $v0, 5
    syscall
    move $t2, $v0  # Guardar el valor ingresado en $t2
    
    # Comparar si el número actual es mayor que max
    lw $t3, max
    blt $t3, $t2, update_max
    
    addi $t1, $t1, 1
    j loop
    
update_max:
    sw $t2, max  # Actualizar max
    addi $t1, $t1, 1
    j loop

endloop:
    # Mostrar el número mayor
    li $v0, 4
    la $a0, result
    syscall
    
    lw $a0, max
    li $v0, 1
    syscall
    
    # Finalizar el programa
    li $v0, 10
    syscall
