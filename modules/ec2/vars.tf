# variable "awsprops" {
#     type = map
#     default ={
#                 itype = "t2.micro"
#                 subnet = ""
#                 publicip = true
#                 keyname = "seckeyname"
#                 secgroupname = "rg-secgrp1"
#                 vpc = "" 
#                 ami = "ami-0c1bea58988a989155"
#     } 
# }

variable "itype" { 
    default = "t2.micro" 
    }
variable "subnet" {  }
variable "publicip" { default = true }
variable "keyname" { default = "seckeyname" }
variable "secgroupname" { default = "rg-secgrp1" }
variable "vpc" { default = "vpc-866cfbed" }
variable "ami"{ default = "ami-0c1bea58988a989155" }
variable "default_tags" {
    description = "RG-AWS-deploy env"
    type = map
    default = {
                Environment = "deply environment"
                Managed = "RG"
            }
}
