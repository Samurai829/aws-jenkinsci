
variable "name" {
    description = "Nombre de Instancia EC2"
    type        = string
}

variable "type" {
    description = "Tipo de instancia"
    type        = string
}

variable "ami" {
    description = "AMI de Instancia"
    type        = string
}

variable "ports" {
    description = "Puertos de Instancia"
    type        = number
}

variable "keypair" {
    description = "KeyPair de Instancia"
    type        = string
}

variable "secgroup" {
    description = "Nombre de Secgroup"
    type        = string
}

variable "data" {
    description = "Configuracion de USER en EC2"
    type        = string
}