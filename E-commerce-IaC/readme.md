E-commerce Platform Infrastructure
Objective
Build a secure, scalable infrastructure for an e-commerce platform with optimized resource usage.

Methodology
This assignment is organized into four phases:

Design
System Architecture: Utilize draw.io to map out the system architecture.
IAM User: Generate an IAM user with specific permissions for this infrastructure.
Build and Deploy
Infrastructure as Code (IaC): Write Terraform code following the AWS Well-Architected Framework principles, emphasizing scalability, cost efficiency, and security.
AWS CI/CD Pipeline: Implement a CI/CD pipeline for continuous deployment using AWS services.
Document
Readme.md:
Explain how to create the infrastructure using the provided Terraform code.
Detail the steps to run the CI/CD pipeline.
Runbook.md:
Provide operational procedures in Markdown format.
Demo
Script: Prepare a demo script explaining your work.
Recording: Provide a video showcasing the deployment and operation of the infrastructure.
All assets should be stored in a GitHub repository.

General Requirements
System Architecture:
Utilize draw.io to visualize the system architecture.
IAM User:
Generate an IAM user with the necessary permissions for the infrastructure.
CI/CD Pipeline:
Implement an AWS CI/CD pipeline for continuous update deployment.
Terraform Code:
Construct Terraform code following the AWS Well-Architected Framework.
Organize Terraform resources in modules.
Bastion Server:
Create a Bastion server for secure SSH access to the DB Server.
AWS Resources
VPC with public and private subnets, NAT Gateway for outbound internet access.
S3 for static website assets.
EC2 (t3.micro) for web servers in public subnet.
RDS (db.t3.micro) for PostgreSQL engine in private subnet.
DynamoDB for session storage.
EFS for shared product images.
CloudWatch for monitoring.
Autoscaling Group (min 1, max 2 instances) based on CPU utilization.
Load Balancer (Application Load Balancer in public subnet).
Bastion Host (t3.micro EC2 instance in public subnet for secure SSH access).
Specific Technical Requirements
Security
Custom Security Group for web servers allowing HTTP (80) and HTTPS (443).
NACLs for subnet level traffic control.
Security Group for Bastion Host allowing SSH (22) from your IP range.
Autoscaling
Autoscaling with a minimum of 1 instance and a maximum of 2, scaling based on CPU utilization > 70%.
Monitoring & Log Retention
CloudWatch logs with retention set to 1 week.
Enable detailed monitoring.
Database Backup
RDS PostgreSQL daily backups with a 7-day retention period.
Bonus Requirement
Set up CloudWatch alerts for high CPU utilization on EC2 instances and RDS, notifying via SNS.

In oe of S3 bucket tfstate will be saved
