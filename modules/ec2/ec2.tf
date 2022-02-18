resource "aws_security_group" "project-rg-sg" {
  name = var.secgroupname
  description = var.secgroupname
  vpc_id = var.vpc
 
  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_instance" "rg-server1"{

  ami = var.ami
  instance_type = var.itype
  subnet_id = var.subnet #FFXsubnet2
  associate_public_ip_address = var.publicip
  key_name = var.keyname
  count = var.ec2count
 

  vpc_security_group_ids = [
    aws_security_group.project-rg-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags =  merge(
    var.default_tags,
    {
      "Name" = "RG-SERVER-${count.index+1}"
    }
  )
  # var.default_tags
  depends_on = [ aws_security_group.project-rg-sg ]
}

# resource "aws_instance" "rg-server1"{

#   ami = lookup(var.awsprops, "ami")
#   instance_type = lookup(var.awsprops, "itype")
#   subnet_id = lookup(var.awsprops, "subnet") #FFXsubnet2
#   associate_public_ip_address = lookup(var.awsprops, "publicip")
#   key_name = lookup(var.awsprops, "keyname")


#   vpc_security_group_ids = [
#     aws_security_group.project-rg-sg.id
#   ]
#   root_block_device {
#     delete_on_termination = true
#     iops = 150
#     volume_size = 50
#     volume_type = "gp2"
#   }
#   tags = {
#     Name ="SERVER01"
#     Environment = "DEV"
#     OS = "UBUNTU"
#     Managed = "IAC"
#   }

#   depends_on = [ aws_security_group.project-rg-sg ]
# }


output "ec2instance" {
  value = aws_instance.rg-server1[0].public_ip
}


