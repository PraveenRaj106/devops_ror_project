output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnets[*].id
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "ecs_sg" {
  value = aws_security_group.ecs_sg.id
}

output "db_sg" {
  value = aws_security_group.db_sg.id
}