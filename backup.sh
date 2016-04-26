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
