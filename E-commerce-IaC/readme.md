# E-commerce Platform Infrastructure Requirements

### Objective
Build a secure, scalable infrastructure for an e-commerce platform with optimized resource usage.

### Methodology
This Assignment should be organized in the following 4 phases:
- *Design:* Prepare and confirm the design.
- *Build and Deploy:* Write Infrastructure as Code (IaC) and deploy using the AWS CI/CD pipeline.
- *Document:*
  - Provide a `Readme.md` file explaining how to create the infrastructure and run the CI/CD pipeline.
  - Provide an infrastructure runbook in Markdown Format detailing operational procedures.
- *Demo:* Prepare a small demo script on how you are going to explain your work. Provide a video recording showcasing the deployment and operation of the infrastructure.

**All assignment assests should be stored in github repository.**

### General Requirements
1. Map out the system architecture using draw.io.
2. Generate an IAM user with the necessary permissions for this specific infrastructure.
3. Implement an AWS CI/CD pipeline for continuous update deployment.
4. Construct Terraform code that follows the AWS Well-Architected Framework, focusing on scalability, cost efficency and security. Organize terraform resources in modules.
5. Create a Bastion server to access the DB Server securely.

### AWS Resources
- VPC with public and private subnets, NAT Gateway for outbound internet access from the private subnet.
- S3 (for static website assets)
- EC2 (t3.micro for web servers in public subnet)
- RDS (db.t3.micro for PostgreSQL engine in private subnet)
- DynamoDB (for session storage)
- EFS (for shared product images)
- CloudWatch
- Autoscaling Group (min 1, max 2 instances)
- Load Balancer (Application Load Balancer in public subnet)
- Bastion Host (t3.micro EC2 instance in public subnet for secure SSH access)

### Specific Technical Requirements

#### Security
- Custom Security Group for web servers allowing HTTP (80) and HTTPS (443).
- NACLs for subnet level traffic control.
- Security Group for Bastion Host allowing SSH (22) from your IP range.

#### Autoscaling
- Minimum 1 instance, maximum 2, scale based on CPU utilization > 70%.

#### Monitoring & Log Retention
- CloudWatch logs with retention set to 1 week.
- Enable detailed monitoring.

#### Database Backup
- RDS PostgreSQL daily backups with a 7-day retention period.

#### Bonus Requirement
- Set up CloudWatch alerts for high CPU utilization on EC2 instances and RDS. Notify via SNS.
