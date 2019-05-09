#!/bin/bash

#https://github.com/thapa001/nti-310Class.git

#1 create nagios server
gcloud compute instances create nagiosinstall \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nagios_install.sh

#2 create cacti server
gcloud compute instances create cactiinstall \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/cacti_install.sh

#3 Rsyslog Server
gcloud compute instances create rsyslogserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/rsyslog_server.sh

#4 postgres and phpPGadmin
gcloud compute instances create postgresphpadminserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/postgres_phpadmin.sh

#5 ldap
gcloud compute instances create ldapserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/ldap.sh
      
#6 nfs
gcloud compute instances create nfs \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs-a.sh
      
#7 django
gcloud compute instances create django \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/django_postgres.sh
      

#8 nfs and ldap client - 1 
gcloud compute instances create nfspart1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs_and_ldap_client.sh
      

#9 nfs and ldap client- 2
gcloud compute instances create nfspart2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs_and_ldap_client.sh








