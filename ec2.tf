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
  key_name                    = aws_key_pair.private_public_subnets.key_name
  associate_public_ip_address = false

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
  associate_public_ip_address = false

  tags = {
    "Name" = "ec2-2"
  }
}
