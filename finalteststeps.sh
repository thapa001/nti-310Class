git clone https://github.com/thapa001/nti-310Class.git
cd nti-310Class.git
git pull # whenever you do update your git repository
cd ..
gcloud compute instances create rsyslog-server4 --image-family centos-7 --image-project centos-cloud --zone us-ea
st1-b --tags "http-server","https-server" --machine-type f1-micro --scopes cloud-platform --metadata-from-file startup-s
cript=nti-310Class/postgres_phpadmin.sh


#client, nfs and rsyslog server does not needed http server 
