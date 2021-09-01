#!/bin/bash
sudo yum -y update

#!/bin/bash 
#Download the java
cd /tmp 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
echo "deb https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
apt-get update
apt install openjdk-8-jdk -y
apt-get install jenkins -y
service jenkins status
service jenkis start
service jenkins enable

 







