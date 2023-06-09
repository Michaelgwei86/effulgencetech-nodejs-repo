#!/bin/bash
sudo yum update
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key # Note: Refer this link to change this key line frequently https://pkg.jenkins.io/redhat-stable/
sudo yum upgrade
sudo yum install java-openjdk11 
sudo yum install jenkins 
sudo su && echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins