resource "aws_launch_template" "ecs_ec2" {
    name = "ecs-ec2"
    image_id = var.img_id
    instance_type = var.instance_type
    # key_name = var.key
    iam_instance_profile {
      arn = var.profile_arn
    }
    
    network_interfaces {
      security_groups = [var.ecs_sg]
    }

    user_data = filebase64("${path.module}/user_data.sh")

    # user_data = filebase64("user_data.sh")
    # user_data = base64encode(<<-EOF
    #           #!/bin/bash
    #           echo "ECS_CLUSTER=app-nginx" >> /etc/ecs/ecs.config
    #           echo "ECS_BACKEND_HOST=" >> /etc/ecs/ecs.config
    #           EOF
    # )



    tag_specifications {
      resource_type = "instance"

      tags = {
        Name = "ecs-ec2"
      }
    }
}


resource "aws_autoscaling_group" "ecs_asg" {
  name = "ecs-auto-scaling-group"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.ecs_ec2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-asg"
    propagate_at_launch = true
  }
}
