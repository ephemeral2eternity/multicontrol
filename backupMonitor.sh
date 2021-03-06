#!/bin/bash
f=$1
suffix=`date +"%Y%m%d" -d now`
localFolder="/home/chenw/data/qrank/$suffix"
mkdir -p $localFolder
monitorFolder="$localFolder/monitor"
mkdir -p $monitorFolder
cat $f | while read -r line; do
	plNode=$line
	echo "ssh into planetlab node $plNode and copy data from ~/monitorData"
        nodeFolder="$monitorFolder/$plNode/"
	mkdir -p $nodeFolder
	scp_cmd="scp -r cmu_agens@$plNode:~/monitorData/* $nodeFolder"
	echo $scp_cmd
	$scp_cmd
done
