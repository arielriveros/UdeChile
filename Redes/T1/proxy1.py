#!/usr/bin/python3
# proxy1 in-port host out-port
# mono-cliente
# simula TCP sobre un UDP con proxy2
# Usa threads (uno TCP->UDP y otro UDP->TCP) y espera al siguiente cliente cuando uno termina
import os, signal
import sys
import socket, jsockets
import threading
import struct, time

MAX_DATA = 1500
TCP_alive = False

def UDP_rdr(conn2, conn):
    global TCP_alive

    while True:
        try:
            data=bytearray(conn2.recv(MAX_DATA))
        except:
            data=None
        if not data and not TCP_alive:
            break
        if data:
            print('UDP_rdr Recibi:')
            print(data)
            # Acabo de leer una serie de bytes desde UDP
            try:
                conn.send(data)
            except:
                break

def TCP_rdr(conn, conn2):
    global TCP_alive

    TCP_alive = True
    first_time = True
    while True:
        try:
            data=bytearray(conn.recv(MAX_DATA))
        except:
            data=None
        print('TCP_rdr Recibi:')
        print(data)
        # Acabo de leer una serie de bytes desde TCP
        if not data:
            break
        conn2.send(data)
        if first_time:
            time.sleep(0.01)  # Le doy tiempo a proxy2 para que se "conecte" conmigo o se confunde con muchos paquetes
            first_time = False

    print('TCP_rdr Exit()')
    conn.close()
    TCP_alive = False

# Este el servidor de un socket ya conectado
# y el cliente del verdadero servidor (TCP_sock, UDP_sock)
def proxy(conn, conn2):

    print('Cliente conectado')

    # inicializar el mundo
    newthread1 = threading.Thread(target=UDP_rdr, daemon=True, args=(conn2, conn))
    newthread1.start()
    TCP_rdr(conn, conn2)
    print('TCP rdr retorna, esperando UDP_rdr...')
    newthread1.join()
    print('Cliente desconectado')

# Main

if len(sys.argv) != 4:
    print('Use: '+sys.argv[0]+' port-in host port-out')
    sys.exit(1)

portin = sys.argv[1]
host = sys.argv[2]
portout = sys.argv[3]

s = jsockets.socket_tcp_bind(portin)
if s is None:
    print('bind falló')
    sys.exit(1)

conn2 = jsockets.socket_udp_connect(host, portout)
if conn2 is None:
    print('conexión UDP rechazada por '+host+', '+portout)
    sys.exit(1)

# timeout de 1s, para que retorne siempre y vea si hay cliente aun...
conn2.setsockopt(socket.SOL_SOCKET, socket.SO_RCVTIMEO, struct.pack("LL",1,0))

while True:
    print('Aceptando cliente')
    conn, addr = s.accept()
    proxy(conn, conn2)
