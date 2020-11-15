from estadisticas import *

# Disclaimer: Por compatibilidad se han quitado caracteres especiales como tildes, apostrofes o letra &ntilde

print('''Bienvenido al sistema de estadisticas Plebiscito Constituyente 2020.
Ingrese los resultados por mesa''')

resultados = listaVacia

while True:
    Circ = input("Circunscripcion (o 'fin' para terminar): ")
    if Circ == 'fin':
        break
    else:
        mesa = int(input('Numero de la mesa: '))
        apr = int(input("Numero de votos opcion 'Apruebo': "))
        rec = int(input("Numero de votos opcion 'Rechazo': "))
        nuevaMesa = resultadoMesa(Circ,mesa,apr,rec)
        resultados = agregaMesa(resultados, nuevaMesa)

print('''
Estadisticas Basicas:
Totales Plebiscito Constituyente''')
print('Total Opcion Apruebo: %d' % totalVotosFinales(resultados,'Apruebo')) 
print('Total Opcion Rechazo: %d' % totalVotosFinales(resultados,'Rechazo')) 

mayCon = mesaConMasVotos(resultados)

print('''
Estadisticas Avanzadas:
Mesa con mas concurrencia: %s, mesa %d, con %d votantes.
''' % (mayCon.circunscripcion, mayCon.mesa, mayCon.apruebo + mayCon.rechazo))

interes = input('Circunscripcon de su interes: ')
print('''Votacion en Circunscripcion %s:
Apruebo: %d, Rechazo: %d. ''' % (interes, totalesPorCircunscripcion(resultados, interes, 'Apruebo'), totalesPorCircunscripcion(resultados, interes, 'Rechazo')))