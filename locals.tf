locals {
  public_subnet_0 = element(data.terraform_remote_state.vpc.outputs.public_subnet_ids, 0)
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  ami_id          = "ami-0730adff5a378dbfc"
  my_ip           = "208.72.79.146/32"
  cidr_block      = "10.27.0.0/16"
}