#!/bin/bash
echo p1 start
nohup python main.py -c ./config/config.p1.ini -m > ./logs/p1.log 2>&1 &

tail -f ./logs/p1.log