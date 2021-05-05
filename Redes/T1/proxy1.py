#!/usr/bin/python3import os, signal
import sys
import socket, jsockets
import threading
import struct, time
import socket

MAX_DATA = 1500
TCP_alive = 0

def addHeader(tipo,identificador,data=''):
    return (tipo+str(identificador)+data).encode()

def findFirstNone(lista):
    for i in range(len(lista)):
        if(lista[i]==None):
            return i

clientes=[None for i in range(10)]

def UDP_rdr(conn_proxy2):
    global TCP_alive
    global clientes
    while True:
        try:
            data = conn_proxy2.recv(MAX_DATA).decode()
        except:
            data=None
        if data:
            print('UDP_rdr Recibi:')
            print(data)
            clientes[int(data[1])].send(data[2:].encode())

def TCP_rdr(conn, identificador, conn_proxy2):
    global TCP_alive
    TCP_alive += 1
    first_time = True
    while True:
        try:
            data=(conn.recv(MAX_DATA)).decode()
        except:
            data=None
        print('TCP_rdr Recibi:')
        print(data)
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
                conn_proxy2.send(addHeader("D",identificador,data))
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
    clientes[index], addr = socket_tcp.accept()
    proxy(clientes[index], index, conn_proxy2)
