#!/bin/bash
apt update
sudo apt install vim ssh wget curl neofetch unzip dos2unix

ssh = ""
read -p "whether install ssh:(y/n)" ssh

if [[ ${ssh} == "y" ]]
then
	wget https://raw.githubusercontent.com/you-bowen/sh/main/linux/sshd_config.txt
	mv sshd_config.txt /etc/ssh/sshd_config
	systemctl start ssh
	systemctl enable ssh
fi
server_ip=$(ip -4 addr | sed -ne 's|^.* inet \([^/]*\)/.* scope global.*$|\1|p' | head -1)
echo $server_ip