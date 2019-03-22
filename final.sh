#!/bin/bash
#install git
https://github.com/thapa001/nti-310Class.git
#1. rsyslog
#installing gcloud compute command
gcloud compute instances create rsyslogserver2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/rsyslog_server.sh


#2. postgres and phpPGadmin
#installing gcloud compute command
gcloud compute instances create postgresphpadminserver2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/postgres_phpadmin.sh

#3 ldap
gcloud compute instances create ldapautouser2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/ldap.sh
      

#4 #nfs
gcloud compute instances create nfspart1 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs-a.sh
      
#5 django
gcloud compute instances create djangopostgresfinal2 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/django_postgres.sh
      

#6 ubuntu client - 1 
gcloud compute instances create nfsandubuntufinal1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfsandubuntu.sh
      

#7 ubuntu client- 2
gcloud compute instances create nfsandubuntufinalpart2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfsandubuntu.sh
