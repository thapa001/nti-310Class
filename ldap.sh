#!/bin/bash

#import git that has config.php

yum install -y git
cd /tmp
git clone https://github.com/nic-instruction/hello-nti-310.git

#install ldap server material
yum install -y openldap-servers openldap-clients

#copy server example to production ldap
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG

#change ownership to ldap from root
            #chown ldap:ldap /var/lib/ldap/DB_CONFIG 
#Faster version of above indented command
chown ldap. /var/lib/ldap/DB_CONFIG

#enable and slapd daemon
systemctl enable slapd
systemctl start slapd
#check status if desired:
systemctl status slapd

#install apache server: httpd (http daemon)
yum install httpd -y

#special repo of community driven project not installed in redhat( included in CentOS 7)
yum install epel-release -y 

#install php ldap admin
yum install phpldapadmin -y

#Let apache server to connect to ldap without SELinux objecting
setsebool -P httpd_can_connect_ldap on

#enable and start httpd; start apache server
systemctl enable httpd
systemctl start httpd

#modifies out apache server (httpd) so it can be accessed from external url.
#modifying phpldapadmin.conf server
sed -i 's,Require local,#Require local\n  Require all granted,g' /etc/httpd/conf.d/phpldapadmin.conf

#remove alias for cp so it doesn't question copy overrides during automation process
unalias cp

#make backup copy of config file before modifying it:
cp /etc/phpldapadmin/config.php /etc/phpldapadmin/config.php.orig

#copy php config file here from repo
cp /tmp/hello-nti-310/config/config.php /etc/phpldapadmin/config.php

#change ownership to ldap group apache
chown ldap:apache /etc/phpldapadmin/config.php

#restart apache server
systemctl restart httpd.service

#give feedback to user that phpldapadmin install was successful, and continuing with configurations.
echo "phpldapadmin is now up and running"
echo "we are configuring ldap and ldapadmin"

#Generate, store, and hash new secret password securely
#newsecret=$(slappasswd -g)
newsecret="P@ssw0rd1"
newhash=$(slappasswd -s "$newsecret")

#stores only in root/ldap_admin_pass file
echo -n "$newsecret" > /root/ldap_admin_pass

#restricts ldap_admin_pass to be read only by user
chmod 600 /root/ldap_admin_pass

#ldiff file, configures root domain name 
echo -e "dn: olcDatabase ={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=nti310,dc=local
\n
dn: olcDatabase = {2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=ldapadm,dc=nti310,dc=local
\n
dn: olcDatabase = {2}hdb,cn=config
changetype: modify
replace: olcRootPW
olcRootPW: $newhash" > db.ldif

#modifying root password according to domain specs
ldapmodify -Y EXTERNAL -H ldapi:/// -f db.ldif

#Auth restriction
echo 'dn: olcDatabase ={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=0+uidNumber=0, cn=peercred, cn=external, cn=auth" read by dn.base="cn=ldapadm,dc=nti310,dc=local" read by * none' > monitor.ldif

ldapmodify -Y EXTERNAL  -H ldapi:/// -f monitor.ldif


# Generate certs

openssl req -new -x509 -nodes -out /etc/openldap/certs/nti310ldapcert.pem -keyout /etc/openldap/certs/nti310ldapkey.pem -days 365 -subj "/C=US/ST=WA/L=Seattle/O=SCC/OU=IT/CN=nti310.local"

chown -R ldap. /etc/openldap/certs/nti*.pem

# Use Certs in LDAP. Run ldapkey part first and then ldapcert part second

echo -e "dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/openldap/certs/nti310ldapcert.pem
\n 
dn: cn=config     
changetype: modify
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/certs/nti310ldapkey.pem" > certs.ldif

ldapmodify -Y EXTERNAL  -H ldapi:/// -f certs.ldif

# Test cert configuration

slaptest -u

unalias cp


ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif 
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif


# Create base group and people structure

echo -e "dn: dc=nti310,dc=local
dc: nti310
objectClass: top
objectClass: domain
\n
dn: cn=ldapadm ,dc=nti310,dc=local
objectClass: organizationalRole
cn: ldapadm
description: LDAP Manager
\n
dn: ou=People,dc=nti310,dc=local
objectClass: organizationalUnit
ou: People
\n
dn: ou=Group,dc=nti310,dc=local
objectClass: organizationalUnit
ou: Group" > base.ldif

setenforce 0

#Adding in base.ldif just created
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f base.ldif -y /root/ldap_admin_pass

#restart system after updates
systemctl restart httpd

#add user Accounts Data

echo -e "# Entry 1: cn=alison becker,ou=People,dc=nti310,dc=local
dn: cn=alison becker,ou=People,dc=nti310,dc=local
cn: alison becker
gidnumber: 500
givenname: alison
homedirectory: /home/users/abecker
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: becker
uid: abecker
uidnumber: 1000
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw=
\n
# Entry 2: cn=jack jameson,ou=People,dc=nti310,dc=local
dn: cn=jack jameson,ou=People,dc=nti310,dc=local
cn: jack jameson
gidnumber: 500
givenname: jack
homedirectory: /home/jjameson
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: jack
uid: jjameson
uidnumber: 1001
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw= 
\n
 # Entry 3: cn=josh singh,ou=People,dc=nti310,dc=local
dn: cn=josh singh,ou=People,dc=nti310,dc=local
cn: josh singh
gidnumber: 500
givenname: josh
homedirectory: /home/jsingh
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: josh
uid: jsingh
uidnumber: 1005
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw=
\n
# Entry 4: cn=ram kc,ou=People,dc=nti310,dc=local
dn: cn=ram kc,ou=People,dc=nti310,dc=local
cn: ram kc
gidnumber: 500
givenname: ram
homedirectory: /home/rkc
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: ram
uid: rkc
uidnumber: 1004
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw=
\n
# Entry 5: cn=sam rock,ou=People,dc=nti310,dc=local
dn: cn=sam rock,ou=People,dc=nti310,dc=local
cn: sam rock
gidnumber: 500
givenname: sam
homedirectory: /home/srock
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: sam
uid: srock
uidnumber: 1002
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw=
\n
# Entry 6: cn=van burger,ou=People,dc=nti310,dc=local
dn: cn=van burger,ou=People,dc=nti310,dc=local
cn: van burger
gidnumber: 500
givenname: van
homedirectory: /home/vburger
loginshell: /bin/sh
objectclass: inetOrgPerson
objectclass: posixAccount
objectclass: top
sn: van
uid: vburger
uidnumber: 1006
userpassword: {SHA}ufCIMwLTxU9IWN9eCXG2+GYYwmw=" > user2.ldif

#Execute user account creation
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f user2.ldif -y /root/ldap_admin_pass

# add user groups
echo -e "# Entry 1: cn=users,ou=Group,dc=nti310,dc=local
dn: cn=users,ou=Group,dc=nti310,dc=local
cn: users
gidnumber: 500
objectclass: posixGroup
objectclass: top
\n
# Entry 2: cn=man,ou=Group,dc=nti310,dc=local
dn: cn=man,ou=Group,dc=nti310,dc=local
cn: man
gidnumber: 502
objectclass: posixGroup
objectclass: top
\n
# Entry 3: cn=woman,ou=Group,dc=nti310,dc=local
dn: cn=woman,ou=Group,dc=nti310,dc=local
cn: users
cn: woman
gidnumber: 503
objectclass: posixGroup
objectclass: top" > groups.ldif
#adding in userGroup.ldif
ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f groups.ldif -y /root/ldap_admin_pass

#Execute user account creation
#ldapadd -x -W -D "cn=ldapadm,dc=nti310,dc=local" -f userAccount.ldif -y /root/ldap_admin_pass

#ryslog client automation (install in client server instances):
yum update -y  && yum install -y rsyslog
systemctl start rsyslog
systemctl enable rsyslog
cp /etc/rsyslog.conf /etc/rsyslog.conf.bak

echo "*.*  @@rsyslog-server2:514" >> /etc/rsyslog.conf


