# multicontrol
Shell scripts to control multiple servers by the list of server addresses.
Please change the default $keyFile to your own key path in the scripts.

  - vm\_list.csv: Default vm list. The csv format is: vmName,vmIP
  - multiquery.sh : execute the same command on all vms in the list
  - multicopy.sh : copy files to all vms or download files from all vms to local folder.

### Usage
#### multiquery.sh
```sh
$ ./multiquery vm_list.csv "command to be executed"
```

#### multicopy.sh
```sh
$ ./multicopy vm_list.csv @remoteFiles localFolder
$ ./multicopy vm_list.csv localFiles @remoteFolder
```
