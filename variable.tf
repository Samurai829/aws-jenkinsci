# REGION USADA POR DEFECTO EN AWS
variable "region" {
    description = "Region de AWS"
    type = string
    default = "us-east-1"
}
# CLAVE PAR POR REGION DE AWS
variable "keypair" {
    description = "KeyPair por Region"
    type = map(string)
    default = {
      us-east-1     = "shogun1"
      us-east-2     = "shogun2"
      ca_central-1  = "shogun3"
    }
}


variable "amis" {
    description         = "AMIS por region para instancias EC2"
    type                = map(string)
    default   = {
        us-east-1       = "ami-05c13eab67c5d8861"
        us-east-2       = "ami-089c26792dcb1fbd4"
        ca-central-1    = "ami-0e27477e1cba0d324"
    }
}


variable "server_name" {
    description = "Nombre de Instancia EC2"
    type = string
}
variable "ec2_type" {
    description = "Tipo de Instancia de AWS"
    type = string
    default = "t2.micro"
}
variable "ec2_port" {
    description = "Puerto de Instancia EC2"
    type = number

    validation {
      condition     = var.ec2_port > 0 && var.ec2_port <= 65525
      error_message = "Inserte un puerto valido"
    }
}

variable "secgroup" {
    description = "Nombre de Secgroup"
    type = string
    default = "aws_security_group.secgroup.id" 
}
/*
variable "ec2_user" {
    description = "Usuario de configuracion de AWS EC2"
    type = string
    default = "file("./packages/ec2_user.bash")"
  
}
*/