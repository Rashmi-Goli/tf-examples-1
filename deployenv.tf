module "ec2" {
  source     = "./modules/ec2"
  subnet = var.subnet
  ec2count = var.ec2count
  #awsprops=awsprops 

}

