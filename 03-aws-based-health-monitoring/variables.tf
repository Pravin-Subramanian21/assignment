variable "region" {
  type        = string
  description = "The AWS region in which you wnat to deploy resources"
  default     = "us-east-1"
}

variable "app_name" {
  type        = string
  description = "The appname for which you want to monitor health checks"
}
variable "email_id" {
  type        = string
  description = "The email-id to which you want yo receive alerts on"
}

variable "health_check_configuration" {
  type = object({
    url               = string
    port              = number
    protocol          = string
    path              = string
    failure_threshold = string
    request_interval  = string
  })

}
variable "tags" {
  type        = map(string)
  description = "Key-value map of resource tags"
  default     = {}

}