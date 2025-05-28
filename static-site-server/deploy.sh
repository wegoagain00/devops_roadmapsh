#!/bin/bash

# Configuration
USER=your_user               # <-- Replace with your SSH username
HOST=your_ip_address         # <-- Replace with your server's IP address
REMOTE_DIR=/var/www/html/website

# Deploy using rsync
echo "Deploying static site to $USER@$HOST..."
rsync -avz --delete ./website/ $USER@$HOST:$REMOTE_DIR
echo "Deployment complete!"
