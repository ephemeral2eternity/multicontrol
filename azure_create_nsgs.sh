#!/bin/bash
f=$1
echo "Azure location file: $f"
echo "Start deploying nsg for users at all locations in Azure"
cat $f | while IFS=, read -r a; do
	location=$a
	nsgName="azusers-$location-nsg"
	echo "Creating network security group for all users in region $location!"
	az network nsg create --resource-group dssgusers --name $nsgName --location $location
	echo "Running the following command to update ssh rule:"
	az network nsg rule create --resource-group dssgusers --nsg-name $nsgName --name allow-inbound-ssh --access Allow --protocol Tcp --direction Inbound --priority 1000 --destination-port-range 22
	echo "Running the following command to update inbound rule:"
	az network nsg rule create --resource-group dssgusers --nsg-name $nsgName --name allow-inbound-icmp --access Allow --protocol \* --direction Inbound --priority 2000 --destination-port-range \*
	$inboundcmd
	echo "Running the following command to update outbound rule:"
	az network nsg rule create --resource-group dssgusers --nsg-name $nsgName --name allow-outbound-icmp --access Allow --protocol \* --direction Outbound --priority 2000 --destination-port-range \*
done
