# create a security group to access the ECS application
resource "aws_security_group" "red-acre-alb-sg" {
  name        = "red-acre-app-alb"
  description = "control access to the application load balancer"
  vpc_id      = aws_vpc.red-acre-vpc.id

  ingress {
    from_port   = 80
    protocol    = "TCP"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create security group to access the ECS cluster (traffic to ECS cluster should only come from the ALB)
resource "aws_security_group" "red-acre-ecs-sg" {
  name        = "red-acre-app-ecs-from-alb"
  description = "control access to the ECS cluster"
  vpc_id      = aws_vpc.red-acre-vpc.id

  ingress {
    from_port       = var.app_port
    protocol        = "TCP"
    to_port         = var.app_port
    security_groups = [aws_security_group.red-acre-alb-sg.id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# create the ALB
resource "aws_alb" "red-acre-alb" {
  load_balancer_type = "application"
  name               = "red-acre-alb"
  subnets            = aws_subnet.red-acre-public-subnets.*.id
  security_groups    = [aws_security_group.red-acre-alb-sg.id]
}

# point redirected traffic to the app
resource "aws_alb_target_group" "red-acre-target-group" {
  name        = "red-acre-ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.red-acre-vpc.id
  target_type = "ip"
}

# direct traffic through the ALB
resource "aws_alb_listener" "red-acre-alb-listener" {
  load_balancer_arn = aws_alb.red-acre-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.red-acre-target-group.arn
    type             = "forward"
  }
}

#################################
output "alb-dns-name" {
  value = aws_alb.red-acre-alb.dns_name
}

