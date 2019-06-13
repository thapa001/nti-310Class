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
cp custom-nrpe-2019/rpm-info/hellow_world_from_source/helloworld-0.1.tar.gz .
cp custom-nrpe-2019/rpm-info/hello_world_from_source/helloworld.spec .
cp custom-nrpe-2019/rpm-info/hello_world_from_source/hello.spec .
mv hello.spec ../SPECS
cd ..
#Builds rpm 
rpmbuild -v -bb --clean SPECS/nti-320-plugins.spec
yum -y install RPMS/x86_64/helloworld-0.1-1.el7.x86_64.rpm 




