#!/usr/bin/bash

set -ex

sudo yum -y update
sudo yum -y install epel-release
sudo yum -y install mysql mariadb-server MySQL-python httpd icinga2
sudo rpm --import http://packages.icinga.org/icinga.key
sudo rpm -i https://packages.icinga.org/epel/7/release/noarch/icinga-rpm-release-7-1.el7.centos.noarch.rpm

MYCNF_PATH="${HOME}/.my.cnf"
if [ ! -f ${MYCNF_PATH} ]; then
	echo "[client]" > ${MYCNF_PATH}
	echo "user=root" >> ${MYCNF_PATH}
fi

sudo ansible-playbook playbook.yml

