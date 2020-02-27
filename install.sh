#!/bin/bash

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

yum install -y jenkins

firewall-cmd --add-port=8080/tcp --permanent
firewall-cmd --reload

vim /etc/init.d/jenkins

sed -i "s/${/usr/bin/java}/a\\${/usr/java/jdk1.8.0_181/bin/java}" /etc/init.d/jenkins
systemctl daemon-reload
systemctl start jenkins
/sbin/chkconfig jenkins on