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
  vpc_security_group_ids      = [aws_security_group.demoland_ssh.id, aws_security_group.demoland_consul.id]
  subnet_id                   = local.public_subnet_0
  associate_public_ip_address = true
}


/*
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce
sudo systemctl status docker
docker run -d -e CONSUL_BIND_INTERFACE=eth0 consul agent -dev

*/