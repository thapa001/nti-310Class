#!/bin/bash
https://github.com/thapa001/nti-320FinalAutomation.git
#1. Create RsyslogServer
gcloud compute instances create rsyslog-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/rsyslog_server.sh \
--private-network-ip=10.128.0.6


#2.Create Build Server
gcloud compute instances create build-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/rpmbuildserver.sh \
--private-network-ip=10.128.0.7

#3.Create Repository Server
gcloud compute instances create repository-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/reposerver.sh \
--private-network-ip=10.128.0.8

#4.Create repository Client Server
gcloud compute instances create repository-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/clientforrepo.sh \
--private-network-ip=10.128.0.9

#5.Create nagios server
gcloud compute instances create nagios-install \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/nagios_install.sh \
--private-network-ip=10.128.0.10

#6. Create cactiServer
gcloud compute instances create cacti-install \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/cacti_install.sh \
--private-network-ip=10.128.0.11

#7.Create postgres and phpPGadmin
gcloud compute instances create postgres-php-admin-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/postgres_phpadmin.sh \
--private-network-ip=10.128.0.12

#8.Create ldap Server
gcloud compute instances create ldap-server007 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/ldap.sh \
--private-network-ip=10.128.0.13

#9.Create nfs
gcloud compute instances create nfs-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/nfs-a.sh \
--private-network-ip=10.128.0.14

#10.Create django
gcloud compute instances create django-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/django_postgres.sh \
--private-network-ip=10.128.0.15

#11.Create nfs and ldap client - 1 
gcloud compute instances create nfspart1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/nfs_and_ldap_client.sh \
--private-network-ip=10.128.0.16

# Create nfs and ldap client- 2
gcloud compute instances create nfspart2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-320FinalAutomation/nfs_and_ldap_client.sh \
--private-network-ip=10.128.0.17








