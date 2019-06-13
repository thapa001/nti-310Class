#!/bin/bash
https://github.com/thapa001/nti-310Class.git
#1. Create RsyslogServer
gcloud compute instances create rsyslog-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/rsyslog_server.sh


#2.Create Build Server
gcloud compute instances create build-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=NTI-320/rpmbuilderver.sh \

#3.Create Repository Server
gcloud compute instances create repository-server \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=NTI-320/reposerver.sh \

#4.Create repository Client Server
gcloud compute instances create repository-client \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=NTI-320/clientforrepo.sh \

#5.Create nagios server
gcloud compute instances create nagiosinstall \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nagios_install.sh

#6. Create cactiServer
gcloud compute instances create cactiinstall \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/cacti_install.sh

#7.Create postgres and phpPGadmin
gcloud compute instances create postgresphpadminserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/postgres_phpadmin.sh

#8.Create ldap Server
gcloud compute instances create ldapserver \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/ldap.sh

#9.Create nfs
gcloud compute instances create nfs \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs-a.sh

#10.Create django
gcloud compute instances create django \
--image-family centos-7 \
--image-project centos-cloud \
--zone us-west1-b \
--tags "http-server","https-server" \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/django_postgres.sh

#11.Create nfs and ldap client - 1 
gcloud compute instances create nfspart1 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs_and_ldap_client.sh

# Create nfs and ldap client- 2
gcloud compute instances create nfspart2 \
--image-family ubuntu-1804-lts \
--image-project ubuntu-os-cloud \
--zone us-west1-b \
--machine-type f1-micro \
--scopes cloud-platform \
--metadata-from-file startup-script=nti-310Class/nfs_and_ldap_client.sh








