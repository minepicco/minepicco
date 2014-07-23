#!/bin/bash

## Params for Apache Bench
# Requests at the same time = 100
rqc=100
# Numner of requests = 10000
rqn=10000

## ============================================
## L = Iterations (param $1), Tgt = Target VM IP (Param $2), Ept = Export file name (Param $3)

L=$1
Tgt=$2
Ept=$3

echo "=============================================="
echo "started" 
echo "==============================================" 


Ttl='iperf-tcp'

echo "==============================================" >> $Ept
echo "$Ttl" >> $Ept
echo "==============================================" >> $Ept

i=1
while [ $i -le $L ];
do
date >> $Ept
echo "[$Ttl][$i/$L]"
echo "[$Ttl][$i/$L]" >> $Ept
iperf -c $Tgt -i 1 | grep '0.0-10.0 sec' >> $Ept
    i=`expr $i + 1`
done

Ttl='iperf-udp'

echo "==============================================" >> $Ept
echo "$Ttl" >> $Ept
echo "==============================================" >> $Ept

i=1
while [ $i -le $L ];
do
date >> $Ept
echo "[$Ttl][$i/$L]"
echo "[$Ttl][$i/$L]" >> $Ept
iperf -c $Tgt -i 1 -u | grep '0.0-10.0 sec' >> $Ept
    i=`expr $i + 1`
done


Ttl='Apache bench tests'

echo "==============================================" >> $Ept
echo "$Ttl" >> $Ept
echo "==============================================" >> $Ept


Ttl='32Kb'
i=1
echo "====================[$Ttl]===================" >> $Ept
while [ $i -le $L ];
do
date >> $Ept
echo "[$Ttl][$i/$L]"
echo "[$Ttl][$i/$L]" >> $Ept
ab -n $rqn -c $rqc http://$Tgt/$Ttl | grep 'Transfer rate:' >> $Ept
    i=`expr $i + 1`
done

Ttl='64Kb'
i=1
echo "====================[$Ttl]===================" >> $Ept
while [ $i -le $L ];
do
date >> $Ept
echo "[$Ttl][$i/$L]"
echo "[$Ttl][$i/$L]" >> $Ept
ab -n $rqn -c $rqc http://$Tgt/$Ttl | grep 'Transfer rate:' >> $Ept
    i=`expr $i + 1`
done

Ttl='128Kb'
i=1
echo "====================[$Ttl]===================" >> $Ept
while [ $i -le $L ];
do
date >> $Ept
echo "[$Ttl][$i/$L]"
echo "[$Ttl][$i/$L]" >> $Ept
ab -n $rqn -c $rqc http://$Tgt/$Ttl | grep 'Transfer rate:' >> $Ept
    i=`expr $i + 1`
done

# Output results to screen
date
echo "=============================================="
echo "completed" 
echo "==============================================" 