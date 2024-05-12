locals {
  name   = var.server_name
  ami           = var.amis[var.region]
  type          = var.ec2_type
  ports         = var.ec2_port
  keypair       = var.keypair[var.region]
  secgroup      = var.secgroup
  
}

module "jenkins_ci" {
    source = "./module/EC2"

    name        = local.name
    ami         = local.ami
    type        = local.type
    ports       = local.ports
    keypair     = local.keypair

    secgroup    = local.secgroup

    data = file("./packages/userconfig.bash") 
    
}