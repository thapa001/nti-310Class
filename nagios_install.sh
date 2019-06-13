#!bin/bash
#nagios install 
#(this is for the first week of configuration.  We will be compiling from source later in the quarter)
yum -y install nagios
systemctl enable nagios
systemctl start nagios
setenforce 0
yum -y install httpd
systemctl enable httpd
systemctl start httpd
yum -y install nrpe
systemctl enable nrpe
systemctl start nrpe
yum -y install nagios-plugins-all
yum -y install nagios-plugins-nrpe
htpasswd -b -c /etc/nagios/passwd nagiosadmin #P@ssw0rd1
chmod 666 /var/log/nagios/nagios.log
mkdir /etc/nagios/servers
sed -i '51 s/^#//' /etc/nagios/nagios.cfg

#checking configuration which reads nagios
/usr/sbin/nagios -v /etc/nagios/nagios.cfg
systemctl restart nagios
##verifying the server to navigate ip instance server 
./generate_config.sh web-a 10.150.0.4
systemctl restart nagios
echo "define command{
                                command_name check_nrpe
                                command_line /usr/lib64/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$
                                }" >> /etc/nagios/objects/commands.cfg       

usermod -a -G nagios mailatpradip8
chmod 777 /etc/nagios/servers
systemctl restart nagios
