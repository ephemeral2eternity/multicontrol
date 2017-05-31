from azure.common.credentials import UserPassCredentials
from azure.mgmt.compute import ComputeManagementClient
# from azure.mgmt.compute import ComputeManagementClient, ComputeManagementClientConfiguration
from azure.mgmt.network import NetworkManagementClient
# from azure.mgmt.network import NetworkManagementClient, NetworkManagementClientConfiguration
import json
import csv
import os

def list_agents(rg_name, prefix):
    # info_dict = json.load(open(os.path.dirname(__file__) + "/info.json"))
    # location_dict = json.load(open(os.path.dirname(__file__) + "/locations.json"))
    info_dict = json.load(open(os.getcwd() + "/info.json"))
    location_dict = json.load(open(os.getcwd() + "/locations.json"))
    subscription_id = info_dict["subscription_id"]
    # TODO: See above how to get a Credentials instance
    credentials = UserPassCredentials(
        info_dict["user"],    # Your new user
        info_dict["password"],  # Your password, Woku5113
    )

    #compute_client = ComputeManagementClient(ComputeManagementClientConfiguration(
    #        credentials,
    #        subscription_id
    #    )
    #)

    compute_client = ComputeManagementClient(credentials, subscription_id)

    #network_client = NetworkManagementClient(NetworkManagementClientConfiguration(
    #        credentials,
    #        subscription_id
    #    )
    #)

    network_client = NetworkManagementClient(credentials, subscription_id)

    locators = []

    vms = compute_client.virtual_machines.list(rg_name)

    csv_file_name = prefix + "list.csv"
    f = open(csv_file_name, 'w', newline='')
    csv_file = csv.writer(f)
    for vm in vms:
        vm_name = vm.name
        if prefix in vm_name:
            try:
                 vm_ip = network_client.public_ip_addresses.get(rg_name, vm_name + "-ip").ip_address
            except:
                 vm_ip = network_client.public_ip_addresses.get(rg_name, vm_name).ip_address
            vm_location = vm.location
            # vm_coordinates = location_dict[vm_location]
            # print vm_name, vm_ip, vm_location
            cur_locator = {"name" : vm_name, "ip" : vm_ip, "location" : vm_location}
            csv_file.writerow([vm_name, vm_ip, vm_location])
            locators.append(cur_locator)

    f.close()
    return locators

if __name__ == '__main__':
    # locators = list_agents("agens", "locator-")
    agents = list_agents("monitoring", "agent-")
    # print(locators)
    print(agents)
