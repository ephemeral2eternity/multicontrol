#!/bin/bash
f=$1
echo "VM List file: $f"
keyFilePATH="/Users/chenw/.ssh/chenw-theone.pub"
echo "Start deploying all users' VMs on Azure"
cat $f | while IFS=, read -r a b c; do
	vmName=$a
	vmLocation=$b
	vmSize=$c
	echo "Deploying VM $vmName with size $vmSize at $vmLocation !"
	azcmd="az vm create -g dssgusers --name $vmName --location $vmLocation --image ubuntults --vnet-name $vmName --subnet users --nsg azusers-$vmLocation-nsg --public-ip-address $vmName --admin-username chenw --generate-ssh-keys --ssh-key-value $keyFilePATH"
	echo "Running the following command to create the VM:"
	echo $azcmd
	$azcmd
done
