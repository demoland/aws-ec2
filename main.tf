locals {
  public_subnet_0 = element(data.terraform_remote_state.vpc.outputs.public_subnet_ids, 0)
 vpc_id         = data.terraform_remote_state.vpc.outputs.vpc_id
 ami_id         = "ami-0730adff5a378dbfc" 
 my_ip = "208.72.79.146/32"
}

resource "aws_key_pair" "management_key" {
  key_name   = "management"
  public_key = var.management_pubkey
}

module "ssh-sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-ssh"
  description = "Security group for user ssh "
  vpc_id      = local.vpc_id

  ingress_cidr_blocks      = ["10.27.0.0/16", local.my_ip ]
  ingress_rules = ["ssh-tcp", "https-443-tcp"]
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "demoland-instance"

  ami                    = local.ami_id 
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.management_key.key_name
  monitoring             = true
  vpc_security_group_ids = [module.ssh-sg.security_group_id]
  subnet_id              = local.public_subnet_0
  associate_public_ip_address = true
}
