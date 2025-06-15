resource "aws_security_group" "alb_sg" {
    name = "AlbSg"
    description = "Security Group for ALB"

    vpc_id = var.vpc_id

    ingress {
        description      = "Allow HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

}


resource "aws_lb" "myAlb" {
    name               = "MyALB"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [aws_security_group.alb_sg.id]
    subnets            = var.public_subnet_ids

}

resource "aws_lb_target_group" "app_tg" {
  name        = "AppTG"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    interval            = 60
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 7
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.myAlb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}





resource "aws_security_group" "app_sg" {
    name = "AppSg"
    description = "Security Group for Application"

    vpc_id = var.vpc_id

    ingress {
        description      = "Allow All"
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        security_groups  = [aws_security_group.alb_sg.id]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
    }

}


resource "aws_launch_template" "launch_template" {
    name                    = "MyLaunchTemplate"

    instance_type           = "t2.micro"
    image_id                = "ami-0e9bbd70d26d7cf4f"
    # vpc_security_group_ids  = [aws_security_group.app_sg.id]
    user_data               = filebase64("${path.module}/user_data.sh")

    block_device_mappings {
        device_name = "/dev/xvda"

        ebs {
            volume_size = 8
        }
    }

    network_interfaces {
        associate_public_ip_address = true
        security_groups = [ aws_security_group.app_sg.id ]
    }
}

resource "aws_autoscaling_group" "asg" {
    name                      = "MyASG"
    max_size                  = 1
    min_size                  = 1
    health_check_grace_period = 300
    vpc_zone_identifier       = var.public_subnet_ids
    target_group_arns         = [aws_lb_target_group.app_tg.arn]


    launch_template {
      id = aws_launch_template.launch_template.id
      version = "$Latest"
    }
    
}