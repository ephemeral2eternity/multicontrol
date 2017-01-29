#!/bin/bash
f=$1
echo "VM List file: $f"
srcFile=$2
dstFile=$3
# keyFile="/home/chenw/.ssh/chenw-theone"
keyFile="/home/18757/.ssh/18757-s17"
echo "Copy from location $srcFile to location $dstFile !"
cat $f | while IFS=, read -r a b; do
	srvName=$a
	srvIP=$b
	if echo "$srcFile" |grep -q "@"; then
		full_srcFile=$(echo $srcFile| sed s/@/18757@$srvIP/g)
	else
		full_srcFile=$srcFile
	fi
	if echo "$dstFile" |grep "@"; then
		full_dstFile=$(echo $dstFile| sed s/@/18757@$srvIP/g)
	else
		full_dstFile=$dstFile
	fi
	echo "scp from $full_srcFile to $full_dstFile"
	scp -r -i $keyFile $full_srcFile $full_dstFile
done
