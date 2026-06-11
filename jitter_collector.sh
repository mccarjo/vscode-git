#!/bin/bash
iperf3 -u -c node-2 -R -p 5201 > iperf.log
cat iperf.log | awk '{print $9}' | egrep -v '10.105.0.38|-|0.000' | head -n 13 > jitter.collector
for x in `cat jitter.collector`
do
sed -i "s/data/$x/g" /var/lib/node_exporter/jitter_time_interval.prom.data
sleep 15
yes|cp /var/lib/node_exporter/jitter_time_interval.prom.data /var/lib/node_exporter/jitter_time_interval.prom
sed -i "s/$x/data/g" /var/lib/node_exporter/jitter_time_interval.prom.data
done