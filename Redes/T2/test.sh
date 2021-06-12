#!/bin/sh

pkill -f python3

python3 proxy1.py 3327 anakena.dcc.uchile.cl 1818 &
python3 client_echo3.py localhost 3327