provider "aws" {
  region  = "ap-southeast-1"
  version = "~>2.70"
}

resource "aws_default_vpc" "default" {

}

// Security Group
// Allow access to these rules:
// HTTP Server -> 80 TCP, 22 TCP (SSH), CIDR (specify a range of address) ["0.0.0.0/0"]
resource "aws_security_group" "http_server_sg" {
  name   = "http_server_sg"
 // vpc_id = "vpc-acf5dccb"
vpc_id = aws_default_vpc.default.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    name = "http_server_sg"
  }

}

resource "aws_instance" "http_server" {
 // ami                    = "ami-0adbe59da7d24a349"
 ami = data.aws_ami.aws_linux_2_latest.id
  key_name               = "default-ec2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  //subnet_id              = "subnet-50d6d419"
  subnet_id = tolist(data.aws_subnet_ids.default_subnets.ids)[0]

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }

//install the http server httpd
//start
//copy a file, this index.html is expose to the outside world
  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                
      "sudo service httpd start",                                                                
      "echo Hello World - Virtual Server ${self.public_dns} | sudo tee /var/www/html/index.html" 
    ]
  }
}
