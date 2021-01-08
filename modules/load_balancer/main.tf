resource "aws_lb" "load_balancer" {
    name                = "eng74-matt-lb-terraform"
    load_balancer_type  = "network"
    ip_address_type     = "ipv4"
    subnets = var.public_subnet_id

    tags = {
        Name = "eng74-matt-lb-terraform"
    }
}

resource "aws_lb_target_group" "lb_target_group" {
    name        = "eng74-matt-targetgroup-terraform"
    port        = "80"
    protocol    = "TCP"
    vpc_id      = var.vpc_id
    target_type = "instance"

    tags = {
        Name = "eng74-matt-target-group-terraform"
    }
}

resource "aws_lb_listener" "load_balancer_listener" {
    load_balancer_arn   = aws_lb.load_balancer.arn
    port                = "80"
    protocol            = "TCP"
    
    default_action {
        type                = "forward"
        target_group_arn    = aws_lb_target_group.lb_target_group.arn
    }
}

resource "aws_launch_configuration" "launch_config" {
    
    image_id                    = var.ami_app
    instance_type               = "t2.micro"
    key_name                    = var.aws_key
    security_groups             = [var.app_sg_id]
    associate_public_ip_address = true
    user_data                   = <<-EOF
        #! /bin/bash
        cd /home/ubuntu/app
        DB_HOST=${var.db_host_ip} pm2 start app.js
        npm run seed
        EOF

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "scaling_group" {
    name                    = "eng74-matt-scaling-group-terraform"
    launch_configuration    = aws_launch_configuration.launch_config.name
    min_size                = 1
    max_size                = 4
    desired_capacity        = 2
    vpc_zone_identifier = [var.public_subnet_id]
    target_group_arns = [aws_lb_target_group.lb_target_group]
    
    
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_policy" "scaling_group_policy" {
  name = "eng74-matt-scaling-policy-CPU"
  autoscaling_group_name = aws_autoscaling_group.scaling_group.name

  target_tracking_configuration {
    predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80
  }
}
