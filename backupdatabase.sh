#!/bin/bash
f=$1
keyFile="/home/chenw/.ssh/chenw-theone"
suffix=`date +"%m%d" -d now`
localFolder="/home/chenw/databaseBackup/qrank$suffix/"
mkdir -p $localFolder
cat $f | while IFS=, read -r a b c; do
	srvName=$a
	srvIP=$b
	srvFolder="anomalyLocator"
	echo "ssh into remote server $srvName with ip $srvIP and execute command in folder $srvFolder"
	cmd="cd ~/$srvFolder; python3 manage.py dumpdata --indent=4 -e sessions -e admin -e contenttypes -e auth --natural-foreign > ~/databaseBackup/$srvName-$suffix.json"
	echo $cmd
	ssh_cmd="ssh -i $keyFile -n chenw@$srvIP $cmd"
        echo $ssh_cmd
        $ssh_cmd
	scp_cmd="scp -i $keyFile -r chenw@$srvIP:~/databaseBackup/*-$suffix.json $localFolder"
	echo $scp_cmd
	$scp_cmd
done
