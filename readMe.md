# How I made a worker-shell-script to automate Elastic Search Dumping/BackingUp data  

In my course of work I used to deal with a lot of Elastic Search, the thing is in a Scaling System you need to be able to 
Backup your Data in the format which is most suitable + Faster to backUp and Blazing fast to Push Up/ Restore also!

What works better than having an Automated Worker ready for You! 

## Requirements
  - UNIX system
  - BASH
  - Elastic Search
  - Elastic Dump
  - Node JS

> You can refer to the above Code which i shared
> So to run this just write this command
> Give the file backup.sh Execution permission and run
> You can 

> $ npm install elasticdump

> $ chmod 7777 ./backup.sh

> $ ./backup.sh

```bash
#!/bin/bash
##
# Author : Grepman
# Description : Shell script to backup data from ElasticSearch
# Requriments : node->npm->elasticdump
##
 
USERNAME="yourUsername"
PASSWORD="yourPassword"
BASE_URL="https://${USERNAME}:${PASSWORD}@5e7fc16503962.us-east-1.aws.found.io:9243"
 
backup_these_indexes=("dump" "active_orchestrator")
printf "\n"
echo "************************* @grepman is Initialized ************************"
echo "**************************************************************************"
printf "\n"
echo "@grepman - cluster_name = ${BASE_URL}"
printf "\n"
 
backup_directory_name="Found-Backup-`date +%Y-%m-%d`"
 
mkdir $backup_directory_name
 
for ix in ${!backup_these_indexes[*]}
do
    printf "\n"
    printf "  @grepman - backing up mapping --- ( %s )  " "${backup_these_indexes[$ix]} "
    printf "\n"
    backup_mapping_script_runner="elasticdump  --input=${BASE_URL}/${backup_these_indexes[$ix]}  --output=./${backup_directory_name}/${backup_these_indexes[$ix]}-mapping.json  --type=mapping"
    eval $backup_mapping_script_runner
    printf "\n"
done
 
for ix in ${!backup_these_indexes[*]}
do
    printf "\n"
    printf "  @grepman - backing up data --- ( %s )  " "${backup_these_indexes[$ix]} "
    printf "\n"
    backup_mapping_script_runner="elasticdump  --input=${BASE_URL}/${backup_these_indexes[$ix]}  --output=./${backup_directory_name}/${backup_these_indexes[$ix]}-data.json  --type=data"
    eval $backup_mapping_script_runner
    printf "\n"
done
 
echo "Worker saved the backups at - DIR - "$backup_directory_name
 
 
 
printf "\n"

```