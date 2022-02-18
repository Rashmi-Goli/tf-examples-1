module "ec2" {
  source     = "./modules/ec2"
  subnet = var.subnet
  #awsprops=awsprops 

}

