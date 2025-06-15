#!/bin/bash
# Update the package index
echo "Hello World"
curl ifconfig.me
yum update -y

# Install Apache HTTP server
yum install -y httpd

# Start the Apache service
systemctl start httpd
systemctl enable httpd
firewall-cmd --permanent --add-service=http
firewall-cmd --reload


chmod 777 /var/www/html

# Create a simple HTML file
echo "<h1>Welcome to My EC2 Web Server!</h1>" > /var/www/html/index.html
