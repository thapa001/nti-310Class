#!/bin/bash

#install python-pip and virtual environment
yum -y install python-pip
pip install virtualenv
pip install --upgrade pip

#make directory and enter it
mkdir ~/myproject
cd ~/myproject

#installing virtual python environment
virtualenv myprojectenv

#activate python virtual environment
source myprojectenv/bin/activate

#install django in virtual environment
pip install django psycopg2

#start django project
django-admin.py startproject myproject .

#we do none of this:
#replace default database with specific database data:
#DATABASES = {
#    'default': {
#        'ENGINE': 'django.db.backends.sqlite3',
#        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
#    }
#}
#DATABASES = {
#    'default': {
#        'ENGINE': 'django.db.backends.postgresql_psycopg2',
#        'NAME': 'myproject',
#        'USER': 'myprojectuser',
#        'PASSWORD': 'password',
#        'HOST': 'postgres-a',
#        'PORT': '5432',
#    }
#} #~/myproject/myproject/settings.py

#download file settings.py file directly from git
wget -O ~/myproject/myproject/settings.py https://raw.githubusercontent.com/thapa001/nti-310Class/master/settings.py

#migrate python files
python manage.py makemigrations
python manage.py migrate

#ryslog client automation (install in client server instances):
yum update -y  && yum install -y rsyslog
systemctl start rsyslog
systemctl enable rsyslog
cp /etc/rsyslog.conf /etc/rsyslog.conf.bak

echo "*.*  @@rsyslogserver2:514" >> /etc/rsyslog.conf
