Current Steps to Creating static site server with Nginx (to complete)

1. Use Digital Ocean to create a ubuntu instance (alternative can be AWS)

2. login using SSH
   ssh user@your.server.ip

3. its good practice to do
   sudo apt update

4. also do this command to install nginx
   sudo apt install nginx -y

5. for me it automatically had access to the port, if you see an error when you do http://instance-ip-address, then you will need to do this command
   sudo ufw allow 'Nginx Full'

6. I already have HTML,CSS and an image which you can use. create a folder named webpage and add these files to it
