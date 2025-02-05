#!/bin/bash

Instance_ID="i-0e12f3c50299eb0ac"
Public_IPv4=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

find_the_file="../backend/.env.sample"
current_url=$(sed -n "4p" $file_the_find)

if [[ "${current_url}" != "FRONTEND_URL=\"http://${Public_IPv4}:5173\"" ]]
then
    if [[ -f ${find_the_file} ]]
    then 
        sed -i -e "s|FRONTEND_URL.*|FRONTEND_URL=\"http://${Public_IPv4}:5173\"|g" $file_the_find
    else
        echo "File Not Found"
    fi
fi


