#!/usr/bin/bash

set -ex

sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install mysql mariadb-server MySQL-python httpd icinga2
sudo rpm --import http://packages.icinga.org/icinga.key
yum list installed icinga-rpm-release
if [ $(echo "$?") -ne "0" ]; then
	sudo rpm -i https://packages.icinga.org/epel/7/release/noarch/icinga-rpm-release-7-1.el7.centos.noarch.rpm
fi

MYCNF_PATH="${HOME}/.my.cnf"
if [ ! -f ${MYCNF_PATH} ]; then
	echo "[client]" > ${MYCNF_PATH}
	echo "user=root" >> ${MYCNF_PATH}
	echo "password=TZHiNB9Rh5MV" >> ${MYCNF_PATH}
	sudo cp ${MYCNF_PATH} /root/
fi

sudo ansible-playbook playbook.yml

