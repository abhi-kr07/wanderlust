#!/bin/bash

Instance_ID="i-0e12f3c50299eb0ac"
Public_IPv4=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

find_the_file="../frontend/.env.sample"
current_url=$(cat $file_the_find)

if [[ "${current_url}" != "VITE_API_PATH=\"http://${Public_IPv4}:31100\"" ]]
then
    if [[ -f ${find_the_file} ]]
    then 
        sed -i -e "s|VITE_API_PATH.*|VITE_API_PATH=\"http://${Public_IPv4}:31100\"|g" $file_the_find
    else
        echo "File Not Found"
    fi
fi
