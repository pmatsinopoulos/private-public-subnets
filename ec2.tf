data "aws_ami" "client" {
  most_recent = true

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "block-device-mapping.delete-on-termination"
    values = ["true"]
  }

  filter {
    name   = "image-type"
    values = ["machine"]
  }

  filter {
    name   = "is-public"
    values = ["true"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["137112412989"] # AWS
}

resource "aws_instance" "ec2_1" {
  ami                         = data.aws_ami.client.id
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  subnet_id                   = aws_subnet.subnet_1.id
  key_name                    = aws_key_pair.internal_to_vpc.key_name
  associate_public_ip_address = false
  # +vpc_security_group_ids+ is not needed and it will be added to the default security group of the VPC.

  tags = {
    "Name" = "ec2-1"
  }
}

resource "aws_instance" "ec2_2" {
  ami                         = data.aws_ami.client.id
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1b"
  subnet_id                   = aws_subnet.subnet_2.id
  key_name                    = aws_key_pair.private_public_subnets.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_vpc.private_and_public_subnets.default_security_group_id, # required if we specify the security groups of a subnet
    aws_security_group.ssh_access.id
  ]

  tags = {
    "Name" = "ec2-2"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("./id_rsa")
  }

  provisioner "file" {
    source      = "./id_rsa_internal"
    destination = "/home/ec2-user/.ssh/id_rsa_internal"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/.ssh/id_rsa_internal"
    ]
  }
}

output "ssh_command_to_connect_to_ec1" {
  value       = "ssh -i ~/.ssh/id_rsa_internal ec2-user@${aws_instance.ec2_1.private_dns}"
  description = "This is how you can connect to the EC2 1 machine from EC2 2 machine"
}

output "ssh_command_to_connect_to_ec2" {
  value       = "ssh -i ./id_rsa ec2-user@${aws_instance.ec2_2.public_dns}"
  description = "This is how you can connect to the EC2 2 machine"
}
