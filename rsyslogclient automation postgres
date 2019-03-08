
#Client automation on postgres
yum update -y && yum install -y rsyslog
systemctl start rsyslog
systemctl enable rsyslog

#backup file
cp /etc/rsyslog.conf /etc/ryslog.conf.bak

echo "*.* @@rsyslogserver:514" >> /etc/rsyslog.conf

systemctl restart rsyslog

#check this on rsyslog server

tail -F /var/log/messages

#message on client postgres: ***
#echo "test statement" | logger
