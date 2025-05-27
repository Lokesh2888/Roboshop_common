#!/bin/bash

source ./common.sh
app_name=mongodb

check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo 
VALIDATE $? "Copying MongoDB repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing the mongoDB server"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "enabling mongod "

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "starting mongod "

sed -i 's/127.0.0.1/0.0.0.0./g' /etc/mongod.conf
VALIDATE $? "Editing filr for remote connections"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restarting mongod "

print_time

