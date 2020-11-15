from lista import * 
from estructura import crear
from abstraccion import filtro
from abstraccion import fold

estructura.crear( "resultadoMesa" , "circunscripcion mesa apruebo rechazo")

def buscaMesa(resultados, circ, mesa):
    if not (isinstance(resultados,lista) and isinstance(circ,str) and isinstance(mesa,int)):
        return None
    while not vacia(resultados):
        if cabeza(resultados).circunscripcion == circ:
            if cabeza(resultados).mesa == mesa:
                return cabeza(resultados)
            else:
                return buscaMesa(cola(resultados),circ,mesa)
        else:
            return buscaMesa(cola(resultados),circ,mesa)
    return None

# agregaMesa: Agrega estructura resultadoMesa a una lista de resultados
def agregaMesa(resultados,mesaNueva):
    if buscaMesa(resultados, mesaNueva.circunscripcion, mesaNueva.mesa) is None:
        return crearLista(mesaNueva,resultados)
    else:
        return resultados

# Funcion auxiliar, verifica en cada recursion el numero de votos totales de la mesa actual
# Si la siguiente mesa tiene mas votos entonces mesa actual pasa a ser la siguiente
# Caso contrario continua la recusion con actual sin cambios
def mesaConMasVotosAux(resultados, actual):
    aux = actual.apruebo + actual.rechazo
    while not vacia(cola(resultados)):
        sgte = cabeza(cola(resultados)).apruebo + cabeza(cola(resultados)).rechazo
        if aux <= sgte:
            return mesaConMasVotosAux(cola(resultados), cabeza(cola(resultados)))
        else:
            return mesaConMasVotosAux(cola(resultados), actual)
    return actual

# mesaConMasVotos: retorna la estructura resultadoMesa que tenga la mayor suma de votos rechazo y apruebo
def mesaConMasVotos(resultados):
    if vacia(resultados):
        return None
    else:
        return mesaConMasVotosAux(resultados, cabeza(resultados))


def resultadosCircunscripcion(resultados, circ):
    if vacia(resultados):
        return None
    else:
        return filtro(lambda x: x.circunscripcion == circ, resultados)

def totalesPorCircunscripcion(resultados, circ, voto):
    listaCirc = resultadosCircunscripcion(resultados,circ)
    if voto == 'Apruebo':
        return fold(lambda x,y: x + y.apruebo, 0, listaCirc)
    elif voto == 'Rechazo':
        return fold(lambda x,y: x + y.rechazo, 0, listaCirc)
    else:
        return None

def totalVotosFinales(resultados, voto):
    if voto == 'Apruebo':
        return fold(lambda x,y: x + y.apruebo, 0, resultados)
    elif voto == 'Rechazo':
        return fold(lambda x,y: x + y.rechazo, 0, resultados)
    else:
        return None

##########################################################################################
#                                                                                        #
#                                      TESTS                                             #
#                                                                                        #
##########################################################################################

r1 = resultadoMesa( "Santiago" , 3 , 100 , 20 )
r2 = resultadoMesa( "San Miguel" , 2 , 200 , 60 )
r3 = resultadoMesa( "Nunoa" , 1 , 200 , 40 )
r4 = resultadoMesa( "Santiago" , 5 , 500 , 100 )
r5 = resultadoMesa( "Nunoa" , 3 , 300 , 100 )
r6 = resultadoMesa( "Putre" , 3 , 150 , 40 )

L = crearLista(r1,crearLista(r2,crearLista(r3,crearLista(r4,crearLista(r5,crearLista(r6,listaVacia))))))

# Tests buscaMesa

assert buscaMesa(L, 'Santiago', 3) ==  resultadoMesa( "Santiago" , 3 , 100 , 20 )
assert buscaMesa(L, 'Nunoa', 1) !=  resultadoMesa( "Nunoa" , 1 , 100 , 20 )
assert buscaMesa(L, 'Nunoa', 1) ==  resultadoMesa( "Nunoa" , 1 , 200 , 40 )
assert buscaMesa(L, 'Nunoa', 3) ==  resultadoMesa( "Nunoa" , 3 , 300 , 100 )
assert buscaMesa(L, 'Springfield', 1) == None
assert buscaMesa(L, 'San Miguel', 0) == None
assert buscaMesa('L', 'Putre', 1) == None
assert buscaMesa(L, 0, 1) == None

# Tests agregarMesa

r0 = resultadoMesa( "Las Condes" , 2 , 10 , 500 )
L0 = agregaMesa(L, r0)


assert (agregaMesa(L, r1) == L and agregaMesa(L, r6) == L)
assert agregaMesa(L, r0) != L
assert agregaMesa(L, r0) == crearLista(r0,L)
assert buscaMesa(L0, 'Las Condes', 2) ==  resultadoMesa( "Las Condes" , 2 , 10 , 500 )


# Tests mesaConMasVotos

assert mesaConMasVotos(L) == resultadoMesa( "Santiago" , 5 , 500 , 100 )
L1 = agregaMesa(L, resultadoMesa( "Providencia" , 3 , 200 , 500 ))
assert mesaConMasVotos(L1) == resultadoMesa( "Providencia" , 3 , 200 , 500 )
L2 = agregaMesa(L1, r6)
assert mesaConMasVotos(L2) == resultadoMesa( "Providencia" , 3 , 200 , 500 )
assert mesaConMasVotos(listaVacia) == None

# Tests resultadosCircunscripcion

L3 = crearLista(r1,listaVacia)
assert resultadosCircunscripcion(L3, 'Santiago') == L3
assert resultadosCircunscripcion(L, 'Santiago') == crearLista(r1, crearLista(r4, listaVacia))
assert resultadosCircunscripcion(L, 'Putre') == crearLista(r6,listaVacia)

# Tests totalesPorCircunscripcion

assert totalesPorCircunscripcion(L, 'Santiago', 'Apruebo') == 600
assert totalesPorCircunscripcion(L, 'Santiago', 'Rechazo') == 120
assert totalesPorCircunscripcion(L, 'Nunoa', 'Apruebo') == 500
assert totalesPorCircunscripcion(L, 'San Miguel', 'Rechazo') == 60

# Tests totalVotosFinales

assert totalVotosFinales(L, 'Apruebo') == 1450
assert totalVotosFinales(L, 'Rechazo') == 360
assert totalVotosFinales(L0, 'Apruebo') == 1460
assert totalVotosFinales(L0, 'Rechazo') == 860
