#!/usr/bin/env bash

# Ths script installs Jenkins and tidy

sudo apt -y update
sudo apt -y upgrade
sudo apt -y install default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt -y update
sudo apt -y install jenkins
sudo apt -y install tidy

# After installation, copy password from
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword
# Launch Jenkins by opening EC2 DNS or IP Address with port 8080 into a browser
# Enter the password
