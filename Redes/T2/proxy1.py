#!/usr/bin/python3import os, signal
import sys
import socket, jsockets
import threading
import struct, time
import queue as q

MAX_DATA = 1500
TCP_alive = 0
loss = 10

def addHeader(tipo, identificador,data='', secuencia = 0):
    return (tipo+str(identificador)+str(secuencia)+data).encode()

def findFirstNone(lista):
    for i in range(len(lista)):
        if(lista[i][0]==None):
            return i
#            conn   buffer   [recv,send]
clientes = [[None, q.Queue, [0,1]] for i in range(10)]

def UDP_rdr(conn_proxy2):
    global TCP_alive
    global clientes
    while True:
        try:
            data = jsockets.recv_loss(conn_proxy2,50,MAX_DATA).decode()
        except:
            data=None
        if data:
            print('UDP_rdr Recibi:')
            print(data)
            tipo = data[0]
            identificador = int(data[1])
            ackBit = int(data[2])
            if tipo == 'A': # Acknowledged
                clientes[identificador][1].put(data)
            elif tipo == 'D':
                sendAck = addHeader('A', identificador, '', ackBit)
                jsockets.send_loss(conn_proxy2, loss, sendAck)
                if ackBit != clientes[identificador][2][1]:
                    jsockets.send_loss(clientes[int(data[1])],loss,data[3:].encode())
                    clientes[identificador][2][1] = ackBit

def TCP_rdr(conn, identificador, conn_proxy2):
    global TCP_alive
    TCP_alive += 1
    first_time = True
    msgs = q.Queue()
    while True:
        if msgs.empty():
            try:
                data=(conn.recv(MAX_DATA)).decode()
            except:
                data=None
            print('TCP_rdr Recibi:')
            print(data)
        else:
            data = msgs.pop(0)
        if first_time:
            first_time = False
            time.sleep(0.01)
            conn_proxy2.send(addHeader("C",identificador))
        else:
            if not data:
                conn_proxy2.send(addHeader("X",identificador))
                print('TCP_rdr Exit()')
                print('Cliente desconectado')
                break
            else:
                ack =  False
                while not ack:
                    ackBit = clientes[identificador][2][0]
                    conn_proxy2.send(addHeader("D",identificador,data,ackBit))
                    try:
                        msgs.put(conn.recv(MAX_DATA).decode())
                    except: pass
                    try:
                        clientes[identificador][1].get(True,7)
                        ack = True
                        if ackBit == 0:
                            clientes[identificador][2][0] = 1
                        else:
                            clientes[identificador][2][0] = 0
                    except: continue
                continue
    conn.close()
    clientes[identificador]=None
    TCP_alive -= 1

def proxy(conn, id, conn_proxy2):
    global TCP_alive

    print('Cliente conectado')

    if(TCP_alive < 1):
        newthread = threading.Thread(target=UDP_rdr, daemon=True, args=[conn_proxy2]) 
        newthread.start()
    newthread = threading.Thread(target=TCP_rdr, daemon=True, args=[conn, id, conn_proxy2])
    newthread.start()
    print('TCP rdr retorna, esperando UDP_rdr...')

# Main

if len(sys.argv) != 4:
    print('Use: '+sys.argv[0]+' port-in host port-out')
    sys.exit(1)
portin = sys.argv[1]
host = sys.argv[2]
portout = sys.argv[3]
socket_tcp = jsockets.socket_tcp_bind(portin)
if socket_tcp is None:
    print('bind fallo')
    sys.exit(1)
conn_proxy2 = jsockets.socket_udp_connect(host, portout)
if conn_proxy2 is None:
    print('conexion UDP rechazada por '+host+', '+portout)
    sys.exit(1)
conn_proxy2.setsockopt(socket.SOL_SOCKET, socket.SO_RCVTIMEO, struct.pack("LL",1,0))
while True:
    print('Aceptando cliente')
    index = findFirstNone(clientes)
    clientes[index][0], addr = socket_tcp.accept()
    proxy(clientes[index][0], index, conn_proxy2)
