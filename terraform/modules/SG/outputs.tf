output "ALB-sg" {
  value = aws_security_group.melkamutech["ext-alb-sg"].id
}


output "IALB-sg" {
  value = aws_security_group.melkamutech["int-alb-sg"].id
}


output "bastion-sg" {
  value = aws_security_group.melkamutech["bastion-sg"].id
}


output "nginx-sg" {
  value = aws_security_group.melkamutech["nginx-sg"].id
}


output "web-sg" {
  value = aws_security_group.melkamutech["webserver-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.melkamutech["datalayer-sg"].id
}