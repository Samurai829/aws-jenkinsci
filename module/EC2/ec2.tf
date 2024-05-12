resource "aws_instance" "ec2_instance" {
    ami                     = var.ami
    instance_type           = var.type
    vpc_security_group_ids  = [aws_security_group.secgroup.id]
    key_name                = var.keypair
    user_data               = var.data

    tags   = {
      name = var.name
    }

}

resource "aws_security_group" "secgroup" {
    description = "Secgroup de Instancia EC2"
    name        = var.name
    
    tags    = {
      name  = var.name
    }
    
    ingress {
        description = "Puertos definido"
        from_port   = 22
        to_port     = 22
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Puertos definido"
        from_port   = var.ports
        to_port     = var.ports
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        description = "Puerto de Acceso"
        from_port   = var.ports
        to_port     = var.ports
        protocol    = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}