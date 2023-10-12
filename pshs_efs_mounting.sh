#PSHS EFS Mounting after the deployment
Step 1. Connect to the web servers (10.2.1.110 and 10.2.1.108) 
Step 2. Create a Temporary folder.
Command:
mkdir /home/ubuntu/applicant[type the version number]

Step 3: The application will create files in the local drive. Move the folders under applicant directory to a temporary folder.  
Command:
sudo mv /media/efs/nfaps-files/applicant/* /home/ubuntu/applicant 

Step 4: Remount the Elastic File System. 
The EFS with 10.2.1.34 IP address is mounted on /media/efs directory: 
Command:
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.2.1.34:/ /media/efs

Step 5: Check if the EFS is successfully mounted
Command: df -H
Step 6: Use rsync command to do the incremental transfer. 
The temporary folder we used to store the files is /home/ubuntu/applicant. 
Log is created after rysnc command. Location: $HOME/rsynch.txt
Command:
 rsync -ruv /home/ubuntu/applicant/* /media/efs/nfaps-files/applicant >>$HOME/rsynch.txt
Step 7: Enter the docker container.
Command:
sudo docker exec -it nfaps-server /bin/bash
Step 8: Go to /root/nfaps-files/applicant 
Check the efs or move the files to a temporary directory. 
Step 9: Restart Docker
Command:
sudo docker container restart nfaps-server 
Consolidate the files, compare them to the rsync logs and efs directory. 

Step 10:
Backup or delete the temporary folders and rsync logs to save storage space. 



if the unmount is busy:
umount /media/efs
try: fuser -mv /media/efs
then:fuser -kmv /media/efs
then: unmount again
