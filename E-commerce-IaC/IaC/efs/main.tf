resource "aws_efs_file_system" "dajmoxefs" {
  creation_token   = "efsdajmox"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "EFS-demo"
  }
}


resource "aws_efs_mount_target" "efs-mtas" {
  file_system_id  = aws_efs_file_system.dajmoxefs.id
  subnet_id       = var.pub1A_id
  security_groups = [var.efs-sg]
}



# Creating Mount Point for EFS
resource "null_resource" "configure_nfst" {
  depends_on = [aws_efs_mount_target.efs-mtas]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    # private_key = file(var.private_key)
    host        = var.autoscaling
    timeout     = "20s"
  }


  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum install httpd -y -q",
  #     "sleep 15",
  #     "sudo yum install php  -y -q ",
  #     "sleep 5",
  #     "sudo systemctl start httpd",
  #     "sleep 5",
  #     "sudo systemctl enable httpd",
  #     "sleep 5",
  #     "sudo yum install nfs-utils -y -q ", # Amazon ami has pre installed nfs utils
  #     "sleep 15",
  #     "sudo service rpcbind restart",
  #     "sleep 15",
  #     # Mounting Efs 
  #     "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
  #     "sleep 15",
  #     "sudo chmod go+rw /var/www/html",
  #     "sudo bash -c 'echo Welcome  > /var/www/html/index.html'",
  #   ]
  # }
}