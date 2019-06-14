#!/bin/bash
#Install rpm tools, compiling tools and source tools
yum -y install rpm-build make gcc git   
#Make directory structure of rpm
mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS} 
#Change the directory as a root
cd ~/
#Set the rpmbuild path into .rpmmacro file
echo '%_topdir %(echo $HOME)/rpmbuild' > ~/.rpmmacros  
cd ~/rpmbuild/SOURCES
# Not needed but to better automate what is needed.
git clone https://github.com/nic-instruction/custom-nrpe-2019.git
cd custom-nrpe-2019/
cp custom-nrpe-2019/nti-320-plugins-0.1.tar.gz .
cp custom-nrpe-2019/nti-320-plugins/apachectl_config_example.sh .
cp custom-nrpe-2019/nti-320-plugins.spec .
mv nti-320-plugins.spec ../SPECS
cd ..
#Builds rpm 
rpmbuild -v -bb --clean SPECS/nti-320-plugins.spec
yum -y install RPMS/x86_64/nti-320-plugins-0.1-1.el7.centos.x86_64.rpm 

