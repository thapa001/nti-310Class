#!/bin/bash
bash generate_config.sh $1 $2
gcloud compute scp --zone us-west1-b $1.cfg mailatpradip8@nagios_install:/etc/nagios/servers
usermod -a -G nagios mailatpradip8
chmod 777 /etc/nagios/servers
usermod -a -G nagios mailatpradip8
gcloud compute ssh --zone us-west1-b mailatpradip8@nagios_install --command='sudo /usr/sbin/nagios -v /etc/nagios/nagios.cfg'
