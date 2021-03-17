# sort: Ordena alfabeticamente un arreglo de strings usando un algoritmo
# ridiculamente ineficiente.

# La funcion sort esta programada en assembler x86. El codigo equivalente en C
# esta comentado, mostrando la ubicacion de las variables en los registros.
# La funcion recorre el arreglo revisando que los elementos consecutivos
# esten ordenados.  Si encuentra 2 elementos consecutivos desordenados,
# los intercambia y reinicia el recorrido del arreglo desde el comienzo.
# El arreglo esta ordenado cuando se recorre completamente sin
# encontrar elementos consecutivos desordenados.

	.file "sort-x86-im.s"
	.text
	.globl sort		# Se necesita para que la etiqueta
                                # sea conocida en test-sort.c
	.type sort, @function
sort:
	pushl	%ebp
	movl	%esp, %ebp	# void sort(char *noms[] /* 8(%ebp) */,
                                #           int n /* 12(%ebp) */) {
	pushl	%edi		#   // -4(%ebp)  (se resguardan registros)
	pushl	%esi		#   // -8(%ebp)
	pushl	%ebx		#   // -12(%ebp)
	subl	$20, %esp	#   // -24(%ebp) y -32(%ebp): este espacio
                                #   // esta para que lo use Ud.
	movl	8(%ebp), %esi	#   // %esi= noms (no lo altera strcmp)
	movl	%esi, %edi	#   char **p= noms; // %edi, no lo cambia strcmp
	movl	12(%ebp), %ecx	#   // %ecx= n, solo se usa en la sgte inst.
				#   char **ult= &noms[n-1];
                                                 // %ebx, no lo altera strcmp
	leal	-4(%esi, %ecx, 4), %ebx
				#   while (p<ult) {
	jmp	.while_cond	#     // la condicion del while se evalua
                                #     // al final del ciclo
.while_begin:			#     // para mayor eficiencia
	movl	%ebx, -16(%ebp) #     // resguardar %ebx
	movl	%esi, -20(%ebp)	#     // resguardar %esi

	# Hasta aca no puede modificar nada

	#################################################
	### Comienza el codigo que Ud. debe modificar ###
	#################################################

    movl 4(%edi), %edx # p[1] -> edx
    movl 0(%edi), %ecx # p[0] -> ecx

    .trans1:
        cmpb    $91, (%edx)
        jl .mayus_minus1
        jmp .trans2

    .mayus_minus1:
        addl    $32, (%edx)
        jmp .trans2

    .trans2:
        cmpb    $91, (%ecx)
        jl .mayus_minus2
        jmp .comparacion

    .mayus_minus2:
        addl    $32, (%ecx)
        addl    $1, %ecx
        jmp .comparacion

    .comparacion:
        pushl    %edx
        pushl    %ecx
        call    strcmp
        addl    $8, %esp

	# %edi es la direccion de alguno de los strings del arreglo noms.
	# Considere char *p= %edi, entonces compare los strings p[0] y p[1].
	# Deje el resultado de la comparacion en %eax
	# Si p[0]<p[1], %eax debe ser <0, si p[0]==p[1], %eax debe ser 0,
	# y si p[0]>p[1], %eax debe ser >0
	# No modifique %edi %ebp %esp.
	# Puede usar el registros %ebx %ecx %edx %esi
    # Ademas puede guardar resultados en -24(%ebp) ... -32(%ebp).
	# Restriccion: no puede llamar a otras funciones

	#################################################
	### Fin del codigo que Ud. debe modificar     ###
	#################################################

	# Desde aca no puede modificar nada

	movl	-16(%ebp), %ebx	#     restaurar %ebx
	movl	-20(%ebp), %esi	#     restaurar %esi

	# En %eax debe quedar la conclusion de la comparacion:
	# si %eax<=0 p[0] y p[1] estan en orden y no se intercambiaran.
    # Si no, se intercambian p[0] y p[1] y se asigna p= noms para revisar
	# nuevamente que los elementos esten ordenados desde el comienzo
    # del arreglo

.decision:
	cmpl	$0, %eax
	jg	.else		#     // if %eax>0 goto .else
	addl	$4, %edi	#       p++; // en la siguiente interacion
	jmp	.while_cond	#            // se comparan p[1] y p[2]
.else:				#     else {
                                #       // intercambar p[0] y p[1], y reiniciar
	movl	(%edi),%eax	#       char *aux= p[0];
	movl	4(%edi), %ecx	#       char *aux2= p[1];
	movl	%ecx, (%edi)	#       p[0]= aux2;
	movl	%eax, 4(%edi)	#       p[1]= aux;
	movl	%esi, %edi	#	p= noms;
				#     }
.while_cond:			#     // se evalua la condicion del while
	cmpl	%ebx, %edi	#     // p ? ult (operandos estan invertidos)
	jb	.while_begin	#     // if p<ult goto .while_begin
				#   }
	addl	$20, %esp	#   // se desapila el espacio pedido
	popl	%ebx		#   // se restauran registros inalterables
	popl	%esi
	popl	%edi
	popl	%ebp
	ret			# }