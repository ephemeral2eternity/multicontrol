#!/bin/bash
f=$1
cmd=$2
keyFile="/home/chenw/.ssh/chenw-theone"
cat $f | while IFS=, read -r a b c; do
	srvName=$a
	srvIP=$b
	echo "ssh into remote server $srvName with ip $srvIP and execute command $cmd"
	ssh_cmd="ssh -i $keyFile -n chenw@$srvIP $cmd"
	# echo $ssh_cmd
	$ssh_cmd
done
