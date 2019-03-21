#!/bin/bash
#install git
https://github.com/thapa001/nti-310Class.git
#1. rsyslog
#installing gcloud compute command
gcloud compute instances create rsyslogserver1 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/rsyslog_server.sh


#2. postgres and phpPGadmin
#installing gcloud compute command
gcloud compute instances create postgresphpadminserver1 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/postgres_phpadmin.sh

#3 ldap
gcloud compute instances create ldapautouser1 \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/ldap.sh
      

#4 #nfs
gcloud compute instances create nfs-server-a \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nsf-a.sh
      
#5 django
gcloud compute instances create django-postgres-server-a \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-east1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/django-postgres_Mar07.sh
      

#6 ubuntu client - 1 
gcloud compute instances create nsf-ubuntu-client-server-a-1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nsf_plus_ubuntu_client_Mar14.sh
      

#7 ubuntu client- 2
gcloud compute instances create nsf-ubuntu-client-server-a-2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-east1-b \
#--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nsf_plus_ubuntu_client_Mar14.sh
