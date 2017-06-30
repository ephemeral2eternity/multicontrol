#!/bin/bash
f=$1
suffix=`date +"%Y%m%d" -d now`
localFolder="/home/chenw/data/qrank/$suffix"
mkdir -p $localFolder
qoesFolder="$localFolder/qoes"
mkdir -p $qoesFolder
cat $f | while read -r line; do
	plNode=$line
	echo "ssh into planetlab node $plNode and copy data from ~/dataQoE"
        nodeFolder="$qoesFolder/$plNode/"
	mkdir -p $nodeFolder
	scp_cmd="scp -r cmu_agens@$plNode:~/dataQoE/* $nodeFolder"
	echo $scp_cmd
	$scp_cmd
done
