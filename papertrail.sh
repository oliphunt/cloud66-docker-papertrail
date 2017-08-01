#!/bin/bash

# prepare the remote_syslog2 config file
cp ./log_files.yml ./temp_log_files.yml
sed -i 's/{{ HOST }}/'$PAPERTRAIL_HOST'/g' ./temp_log_files.yml
sed -i 's/{{ PORT }}/'$PAPERTRAIL_PORT'/g' ./temp_log_files.yml
sudo cp ./temp_log_files.yml /etc/log_files.yml

# Prepare the init script
sudo cp ./remote_syslog.init.d /etc/init.d/remote_syslog
sudo chmod +x /etc/init.d/remote_syslog

# Download and install the remote_syslog2 binary from papertrail
wget https://github.com/papertrail/remote_syslog2/releases/download/v0.19/remote_syslog_linux_amd64.tar.gz
tar xzf ./remote_syslog*.tar.gz
cd remote_syslog
sudo cp ./remote_syslog /usr/local/bin

# Start the service
sudo service remote_syslog stop
sudo service remote_syslog start
sudo update-rc.d remote_syslog defaults
