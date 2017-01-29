#!/bin/bash
f=$1
cmd=$2
# keyFile="/home/chenw/.ssh/chenw-theone"
keyFile="/home/18757/.ssh/18757-s17"
cat $f | while IFS=, read -r a b; do
	srvName=$a
	srvIP=$b
	echo "ssh into remote server $srvName with ip $srvIP and execute command $cmd"
	ssh_cmd="ssh -i $keyFile -n 18757@$srvIP $cmd"
	# echo $ssh_cmd
	$ssh_cmd
done
