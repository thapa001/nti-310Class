for servername in $( gcloud compute instances list | awk '{print $1}' | sed "1 d" | grep -v reposerver.sh );  do 
    gcloud compute ssh --zone us-west1-b mailatpradip8@$servername --command=' sudo yum -y install wget && sudo wget https://raw.githubusercontent.com/thapa001/nti-310Class/master/clientforrepo.sh && sudo bash clientforrepo.sh'
done
