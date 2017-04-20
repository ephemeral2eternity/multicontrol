#!/bin/bash
f=$1
filename=$2
# keyFile="/home/chenw/.ssh/chenw-theone"
keyFile="/home/18757/.ssh/18757-s17"
cat $f | while IFS=, read -r a b c; do
	srvName=$a
	srvIP=$b
	echo "ssh into remote server $srvName with ip $srvIP and execute command $cmd"
	ssh_cmd="ssh -i $keyFile -n 18757@$srvIP sudo mv ~/superbowl/probe/$filename ~/superbowl/probe/$a$filename"
	echo $a$filename
	$ssh_cmd
done
