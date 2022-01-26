#----------------------------------------------------------
# Build Jenkins master during Bootstrap
#
# Made by Roman Kuzmyn
#----------------------------------------------------------

provider "aws" {
  region = "eu-central-1"
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.jenkins-master.id
}

resource "aws_instance" "jenkins-master" {
    #count                  = 1
    ami                    = "ami-05cafdf7c9f772ad2"
    instance_type          = "t2.micro"
    vpc_security_group_ids = [aws_security_group.jenkins.id] #додати в створену security_group
    user_data              =  file ("install_jenkins.sh")
    tags                   = {
     Name                  = "jenkins-master"
     Owner                 = "Roman Kuzmyn"
     E-mail                = "kuzmyn1983@gmail.com"
     Location              = "UA"
     Company               = "SoftJourn"
     Project               = "Lessons Terraform"
    }
  
#  depends_on = [aws_instance.jenkins-master, aws_instance.jenkins-master] # залежить від ресурсів (створюється після них)
}

resource "aws_security_group" "jenkins" {
  name = "Security Group for jenkins"
  description = "Security Group for jenkins"
   dynamic "ingress" {
    for_each = ["8080", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
 
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
      } 
  tags                   = {
     Name                  = "jenkins"
     Owner                 = "Roman Kuzmyn"
     E-mail                = "kuzmyn1983@gmail.com"
     Location              = "UA"
     Company               = "SoftJourn"
     Project               = "Lessons Terraform"
    }
}

