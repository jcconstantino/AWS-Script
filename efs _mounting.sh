sudo apt-get update
sudo apt-get install nfs-common
Back up first
sudo cp -r /var/www/insurance.gov.ph/wordpress/wp-content/uploads /var/www/insurance.gov.ph/wordpress/wp-content/uploads_backup
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-01234567.efs.us-east-1.amazonaws.com:/ /var/www/insurance.gov.ph/wordpress/wp-content/uploads

Update /etc/fstab: To ensure that the EFS is mounted automatically on system boot, add an entry to the /etc/fstab file:

Open the /etc/fstab file with a text editor:
sudo nano /etc/fstab
Add a line like this:
fs-01234567.efs.us-east-1.amazonaws.com:/ /var/www/insurance.gov.ph/wordpress/wp-content/uploads nfs defaults 0 0
Save and exit the text editor.
Mount the EFS: After updating /etc/fstab, you can mount the EFS using the mount command:
sudo mount -a



sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-07a9d63eb54882211.efs.ap-southeast-1.amazonaws.com:/ /var/www/insurance.gov.ph/wordpress/wp-content/uploads

FOR AUTOSCALING AND USER DATA

#!/bin/bash
EFS_ID=fs-07a9d63eb54882211  # Replace with your EFS file system ID

# Install necessary NFS utilities
sudo apt-get update
sudo apt-get install -y nfs-common

# Mount the EFS file system to the root directory
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport $EFS_ID.efs.ap-southeast-1.amazonaws.com:/ /

