#!/bin/bash
NOW=$(date +"%Y-%m-%d_%H-%M-%S")

echo p1 start
nohup python main.py -c ./PAE_private/config/config.p1.ini -m > ./logs/${NOW}_p1.log 2>&1 &

tail -f ./logs/${NOW}_p1.log