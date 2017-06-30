#!/bin/bash
f=$1
suffix=`date +"%Y%m%d" -d now`
localFolder="/home/chenw/data/qrank/$suffix"
mkdir -p $localFolder
monitorFolder="$localFolder/monitor"
mkdir -p $monitorFolder
cat $f | while IFS=, read -r a b c; do
	nodeName=$a
	nodeIp=$b
	echo "ssh into planetlab node $nodeName and copy data from ~/monitorData"
        nodeFolder="$monitorFolder/$nodeName/"
	mkdir -p $nodeFolder
	scp_cmd="scp -i /home/chenw/.ssh/chenw-theone -r chenw@$nodeIp:~/monitorData/* $nodeFolder"
	echo $scp_cmd
	$scp_cmd
done
