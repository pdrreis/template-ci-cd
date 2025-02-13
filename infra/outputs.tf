output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

output "nlb_dns_name" {
  value = format("http://%s", aws_lb.this.dns_name)
}
-----

26. sg.tf dentro da diretório de infra
27. colar o conteúdo abaixo dentro do arquivo:

-----
# Crie um grupo de segurança
resource "aws_security_group" "allow_inbound" {
  name        = format("%s-sg", var.cluster_name)
  vpc_id      = var.vpc_id
  description = "Allow inbound traffic"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-sg", var.cluster_name)
  }
}