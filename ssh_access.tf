resource "aws_security_group" "ssh_access" {
  name        = "${local.project}-ssh-access"
  description = "Allow SSH traffic from anywhere"
  vpc_id      = aws_vpc.private_and_public_subnets.id
  ingress {
    description = "allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outgoing to anywhere"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${local.project}-ssh-access"
  }
}
