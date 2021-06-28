data "aws_vpc" "farmiq_test" {
  id = var.vpc_id
}

# resource "aws_security_group" "allow_all_in_vpc" {
#   name   = "allow-all-in-vpc-${terraform.workspace}"
#   vpc_id = data.aws_vpc.farmiq_test.id
#   ingress {
#     description = "allow all in bound request"
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = [data.aws_vpc.farmiq_test.cidr_block]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

resource "aws_security_group" "allow_http_https_lb" {
  name   = "allow-http-https-lb-${terraform.workspace}"
  vpc_id = data.aws_vpc.farmiq_test.id
  ingress {
    description      = "Allow https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Allow http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "farmiq" {
  name = "farmiq-lb-${terraform.workspace}"

  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_https_lb.id]
  subnets            = [var.subnet_a, var.subnet_b]
  enable_deletion_protection = false
}

resource "aws_lb_listener" "farmiq" {
  load_balancer_arn = aws_lb.farmiq.arn
  port              = "80"
  protocol          = "HTTP"  
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "'${terraform.workspace}' Load balancer is running"
      status_code  = "200"
    }
  }
}
