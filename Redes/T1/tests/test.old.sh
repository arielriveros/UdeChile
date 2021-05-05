#!/bin/sh
pkill -f python3
python3 ../proxy1.py 3327 127.0.0.1 3328 &
python3 ../proxy2.py 3328 127.0.0.1 1818 &
python3 ../server_echo2.py &
# python3 ../client_echo2.py 127.0.0.1 3327