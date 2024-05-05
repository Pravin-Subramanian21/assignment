output "load_balancer_dns" {
  description = "The DNS value of the loadbalancer"
  value       = aws_elb.load_balancer.dns_name
}