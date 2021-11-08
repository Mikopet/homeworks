# Some defaults
provider "aws" {
  profile = "default"
  region  = "eu-west-1"

  default_tags {
    tags = {
      Company = "Red Acre"
      Project = "DevOps Challenge"
    }
  }
}

# create the ECS cluster
resource "aws_ecs_cluster" "red_acre-ecs-cluster" {
  name = "RedAcre-DevOps-Challenge"

  tags = {
    Name = "red_acre-ecs-cluster"
  }
}

# create and define the container task
resource "aws_ecs_task_definition" "flask-task" {
  family                   = "flask-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 512
  container_definitions    = <<DEFINITION
[
   {
      "name":"flask-app",
      "image":"${var.app_image}",
      "essential":true,
      "portMappings":[
         {
            "containerPort":5000,
            "hostPort":8080,
            "protocol":"tcp"
         }
      ],
      "environment":[
         {
            "name":"FLASK_ENV",
            "value":"${var.flask_env}"
         },
         {
            "name":"APP_PORT",
            "value":"${var.app_port}"
         }
      ]
   }
]
DEFINITION
}

resource "aws_ecs_service" "flask-service" {
  name            = "flask-app-service"
  cluster         = aws_ecs_cluster.red_acre-ecs-cluster.id
  task_definition = aws_ecs_task_definition.flask-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.red_acre-ecs-sg.id]
    subnets          = aws_subnet.red_acre-public-subnets.*.id
    assign_public_ip = true
  }

  load_balancer {
    container_name   = "flask-app"
    container_port   = var.app_port
    target_group_arn = aws_alb_target_group.red_acre-target-group.id
  }

  depends_on = [
    aws_alb_listener.red_acre-alb-listener
  ]
}

