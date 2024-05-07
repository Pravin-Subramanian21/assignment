# Health Monitoring System

The system uses **Route53** Health check to determine the health of any given API endpoint(s) based on health check configuration provided by the users.

Combined with AWS cloudwatch and SNS, we can send notifications to any particular mail ID when an endpoint is down.

## High level Design
This terraform module contains the list of resources that is required for deploying a Health monitoring system.
* [main.tf](./main.tf) - Contains all the necessary infra components that make up the  - Load balancer & EC2 instances.
* [variables.tf](./variables.tf) - Contains all the variables that are referenced in the tf files.
* [terraform.tfvars.json](./terraform.tfvars.json) - Contains all the user related configuration that can be changed/modified.
## Steps required to create the environment
* An AWS account
* An IAM user with admin permission.
* Setup your AWS credentials in your local with `aws configure`
* Change/Define your AWS-region and the required parameters in [terraform.tfvars.json](./terraform.tfvars.json)
* Run the following terraform commands
    - `terraform init`  - Initializes the Terraform working directory by downloading necessary plugins and modules.
    - `terraform plan` - Generates an execution plan outlining the changes Terraform will make to infrastructure.
    - `terraform apply` - Executes the plan, making the changes to provision or modify infrastructure resources.
* Once the SNS subscription is confirmed, you should receive alerts when the endpoint is down.

> [!NOTE]
> Route 53 metrics are [not available](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/monitoring-health-checks.html#:~:text=To%20view%20Route%2053%20metrics,region%20as%20the%20current%20region) if you select any other region other than us-east-1.

## Output
The following contains the list of resources that is created for health monitoring system.

```
Terraform will perform the following actions:

  # aws_cloudwatch_metric_alarm.api_health_check_alarm will be created
  + resource "aws_cloudwatch_metric_alarm" "api_health_check_alarm" {
      + actions_enabled                       = true
      + alarm_actions                         = (known after apply)
      + alarm_description                     = "This alarm is triggered when API health check fails."
      + alarm_name                            = "Critical | aws-metadata-app Health check"
      + arn                                   = (known after apply)
      + comparison_operator                   = "LessThanThreshold"
      + dimensions                            = (known after apply)
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "HealthCheckStatus"
      + namespace                             = "AWS/Route53"
      + period                                = 60
      + statistic                             = "Minimum"
      + tags                                  = {
          + "project" = "terraform"
        }
      + tags_all                              = {
          + "project" = "terraform"
        }
      + threshold                             = 0
      + treat_missing_data                    = "breaching"
    }

  # aws_route53_health_check.api_health_check will be created
  + resource "aws_route53_health_check" "api_health_check" {
      + arn               = (known after apply)
      + disabled          = false
      + enable_sni        = (known after apply)
      + failure_threshold = 2
      + fqdn              = "record.aws-metadata-webapp-1038166563.ap-south-1.elb.amazonaws.com"
      + id                = (known after apply)
      + measure_latency   = false
      + port              = 80
      + request_interval  = 10
      + resource_path     = "/"
      + tags              = {
          + "project" = "terraform"
        }
      + tags_all          = {
          + "project" = "terraform"
        }
      + type              = "HTTP"
    }

  # aws_sns_topic.health_check_notifications will be created
  + resource "aws_sns_topic" "health_check_notifications" {
      + arn                         = (known after apply)
      + beginning_archive_time      = (known after apply)
      + content_based_deduplication = false
      + fifo_topic                  = false
      + id                          = (known after apply)
      + name                        = "aws-metadata-app"
      + name_prefix                 = (known after apply)
      + owner                       = (known after apply)
      + policy                      = (known after apply)
      + signature_version           = (known after apply)
      + tags_all                    = (known after apply)
      + tracing_config              = (known after apply)
    }

  # aws_sns_topic_subscription.email_subscription will be created
  + resource "aws_sns_topic_subscription" "email_subscription" {
      + arn                             = (known after apply)
      + confirmation_timeout_in_minutes = 1
      + confirmation_was_authenticated  = (known after apply)
      + endpoint                        = "kspravin1997@gmail.com"
      + endpoint_auto_confirms          = false
      + filter_policy_scope             = (known after apply)
      + id                              = (known after apply)
      + owner_id                        = (known after apply)
      + pending_confirmation            = (known after apply)
      + protocol                        = "email"
      + raw_message_delivery            = false
      + topic_arn                       = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

```