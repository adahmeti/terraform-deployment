#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
yum install httpd -y
service httpd start
aws configure set aws_access_key_id ""
aws configure set aws_secret_access_key ""
aws configure set region ""
aws configure set output "json"
cd ../../../usr/share/httpd/noindex
sudo rm index.html
cd ../../../../home/ec2-user
mkdir s3
aws s3 cp s3://ecommercepolymathlabz/ ../s3/ --recursive
sudo cp -r s3/ ../../../usr/share/httpd/noindex/

