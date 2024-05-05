resource "aws_security_group" "load_balancer_sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "Allow http requests"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    description     = "Allow http requests"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_elb" "load_balancer" {
  name            = var.lb_configuration.name
  subnets         = [for subnet in aws_subnet.public_subnets : subnet.id]
  security_groups = [aws_security_group.load_balancer_sg.id]
  tags            = var.tags
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = var.lb_configuration.healthy_threshold
    unhealthy_threshold = var.lb_configuration.unhealthy_threshold
    timeout             = var.lb_configuration.timeout
    target              = var.lb_configuration.target
    interval            = var.lb_configuration.interval
  }
  depends_on                  = [aws_instance.ec2]
  cross_zone_load_balancing   = var.lb_configuration.cross_zone_load_balancing
  idle_timeout                = var.lb_configuration.idle_timeout
  connection_draining         = var.lb_configuration.connection_draining
  connection_draining_timeout = var.lb_configuration.connection_draining_timeout
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.ssh_key_name
  public_key = var.ssh_public_key
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "ec2" {
  for_each               = aws_subnet.private_subnets
  ami                    = data.aws_ami.amzn-linux-2023-ami.id
  instance_type          = var.instance_configuration.type
  subnet_id              = aws_subnet.private_subnets[each.key].id
  key_name               = aws_key_pair.ssh_key.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  tags                   = var.tags
  metadata_options {
    http_tokens = "optional"
  }
  user_data = file("${path.module}/apache-setup.sh")
}

resource "aws_elb_attachment" "instance_attachment" {
  for_each = aws_instance.ec2
  instance = aws_instance.ec2[each.key].id
  elb      = aws_elb.load_balancer.name
}
