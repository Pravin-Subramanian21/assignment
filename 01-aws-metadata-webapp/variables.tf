
variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type        = string
  description = "The IPV4 CIDR block for subnet"
  default     = "10.0.1.0/24"
}

variable "region" {
  type        = string
  description = "The AWS region on which you want to deploy resources"
}

variable "public_subnets" {
  type = map(object({
    cidr_block        = string,
    availability_zone = string,
  }))
  description = "List of public subnets"
  default = {
  }
}

variable "private_subnets" {
  type = map(object({
    cidr_block        = string,
    availability_zone = string,
  }))
  description = "List of private subnets"
  default = {
  }
}

variable "lb_configuration" {
  type = object({
    name                        = string
    healthy_threshold           = number
    unhealthy_threshold         = number
    timeout                     = number
    target                      = string
    interval                    = number
    cross_zone_load_balancing   = bool
    idle_timeout                = number
    connection_draining         = bool
    connection_draining_timeout = number
  })
  description = "The health check parameters for the load balancer"
}

variable "instance_configuration" {
  type = object({
    type = string
  })
  description = "The EC2 instance configuration that needs to be deployed"
}
variable "ssh_public_key" {
  type        = string
  description = "The SSH Public key that needs to configured for EC2 instances"

}
variable "ssh_key_name" {
  type        = string
  description = "The name of the SSH key created"
}

variable "tags" {
  type        = map(string)
  description = "Key-value map of resource tags"
  default     = {}
}