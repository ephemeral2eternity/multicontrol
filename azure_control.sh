#!/bin/bash
if [ $# -eq 2 ]
then
	f=$1
	cmd=$2
	echo "Start $cmd all users' VMs on Azure"
	cat $f | while IFS=, read -r a b c; do
		vmName=$a
		vmLocation=$b
		echo "$cmd VM $vmName at $vmLocation !"
		azcmd="az vm $cmd -g dssgusers --name $vmName"
		# echo $azcmd
		$azcmd
	done
else
	echo "Usage: ./azure_control.sh vm_list.csv start/stop/restart/delete/show"
fi
