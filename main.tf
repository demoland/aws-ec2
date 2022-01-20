resource "aws_key_pair" "management_key" {
  key_name   = "management"
  public_key = var.management_pubkey
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "demoland-instance"

  ami                         = local.ami_id
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.management_key.key_name
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.demoland_ssh.id]
  subnet_id                   = local.public_subnet_0
  associate_public_ip_address = true
}
