#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H-%M-%S")

echo p1 start
nohup python main.py -c ./config/config.p1.ini -m > ./logs/${NOW}_p1.log 2>&1 &

echo p4 start
nohup python main.py -c ./config/config.p4.ini -m > ./logs/${NOW}_p4.log 2>&1 &

tail -f ./logs/${NOW}_p1.log ./logs/${NOW}_p4.log