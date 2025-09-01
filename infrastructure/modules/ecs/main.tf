resource "aws_ecs_cluster" "demo_cluster" {
    name = var.ecs-name
}

resource "aws_ecs_task_definition" "demo_task" {
  family                   = "web-task"
  network_mode             = var.network_mode # you can also use "awsvpc" if you want ENI per task
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory
  task_role_arn            = var.task-role
  execution_role_arn       = var.task-role

  container_definitions = jsonencode([
    {
      name      = var.app-container
      image     = var.app-img    # <-- Rails app image (Puma)
      essential = true

      environment = [
        { name = "RAILS_ENV", value = var.RAILS_ENV },
        { name = "DB_HOSTNAME", value = var.DB_HOSTNAME },
        { name = "DB_NAME", value = var.DB_NAME },
        { name = "DB_USERNAME", value = var.DB_USERNAME },
        { name = "DB_PASSWORD", value = var.DB_PASSWORD },
        { name = "DB_PORT", value = var.DB_PORT }
      ]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.ecs-name
        }
      }
    },
    {
      name      = var.nginx-container
      image     = var.nginx-img    # <-- Nginx image
      essential = true

      portMappings = [
        {
          containerPort = 80
          hostPort      = 0
          protocol      = "tcp"
        }
      ]

      links = [var.app-container]

      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.log_name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.ecs-name
        }
      }
    }
  ])
}


resource "aws_ecs_service" "demo_service" {
    name            = "web-service"
    cluster         = aws_ecs_cluster.demo_cluster.id
    task_definition = aws_ecs_task_definition.demo_task.id
    desired_count   = var.task-count
    capacity_provider_strategy {
      capacity_provider = aws_ecs_capacity_provider.ecs_cp.name
      weight            = 1
    }

    load_balancer {
        target_group_arn = var.tg_arn
        container_name   = var.nginx-container
        container_port   = 80
    }
}

resource "aws_ecs_capacity_provider" "ecs_cp" {
  name = "asg-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.asg_arn
    managed_termination_protection = "DISABLED"
  }
  
}

# Associate Capacity Provider with Cluster
resource "aws_ecs_cluster_capacity_providers" "ecs_cluster_cp" {
  cluster_name       = aws_ecs_cluster.demo_cluster.name
  capacity_providers = [aws_ecs_capacity_provider.ecs_cp.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ecs_cp.name
    weight            = 1
    base              = 1
  }
}