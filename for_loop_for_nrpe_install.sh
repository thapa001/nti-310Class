for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v nagios_install );  do 
    gcloud compute ssh --zone us-east1-b mailatpradip8@$servername --command=' sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/thapa001/nti-310Class/master/nagiosclientconfig.sh && sudo bash nagiosclientconfig.sh'
done
