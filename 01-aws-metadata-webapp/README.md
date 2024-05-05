# AWS MetaData Web application

An Highly available environment should contain the following components.

- [ ]  VPC
- [ ]  Public & Private subnets (across different Availability zones)
- [ ]  Load balancer & Target group (if necessary)
- [ ]  Auto Scaling group (Optional)
- [ ]  EC2 instances

## High level Design
This terraform module contains the list of resources that is required for deploying a HA web app.
* [network.tf](./network.tf) - Contains all the networking related components that are requried (VPC, Subnets, Route table, NAT Gateways, ElasticIPs, Internet Gateway)
* [main.tf](./main.tf) - Contains all the necessary infra components that make up the web application - Load balancer & EC2 instances.
* [terraform.tfvars.json](./terraform.tfvars.json) - Contains all the user related configuration that can be changed/modified.
* [variables.tf](./variables.tf) - Contains all the variables that are referenced in the tf files.

## Steps required to create the environment
* An AWS account
* An IAM user with admin permission.
* Setup your AWS credentials in your local with `aws configure`
* Change/Define your AWS-region and the required parameters in [terraform.tfvars.json](./terraform.tfvars.json)
* Run the following terraform commands
    - `terraform init`  - Initializes the Terraform working directory by downloading necessary plugins and modules.
    - `terraform plan` - Generates an execution plan outlining the changes Terraform will make to infrastructure.
    - `terraform apply` - Executes the plan, making the changes to provision or modify infrastructure resources.
* Access the application from the output DNS URL of the load balancer.

## Best Practices followed 
- [ ] Abstract all the user configurable parameters in [terraform.tfvars.json](./terraform.tfvars.json) so that the code is re-usable across any environment.
- [ ] Ensuring that the EC2 instances are hosted in private subnet and the Load balancer is in public Subnet.
- [ ] The ingress and egress ports for security groups are created with minimum permissions as possible.
- [ ] Provided the load balancer DNS URL as one of the terraform output.
- [ ] Separate route table for all the subnets.

## Output
The following shows the output obtained after creating all the resources from terraform.

![Screenshot 2024-05-05 at 10 00 15 PM](https://github.com/Pravin-Subramanian21/hyperverge-assignment/assets/90493442/986420c3-c9c0-46ea-9724-9b60a54c2021)


```
Terraform will perform the following actions:

  # aws_eip.eip["public-subnet-1"] will be created
  + resource "aws_eip" "eip" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all             = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc                  = (known after apply)
    }

  # aws_eip.eip["public-subnet-2"] will be created
  + resource "aws_eip" "eip" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all             = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc                  = (known after apply)
    }

  # aws_eip.eip["public-subnet-3"] will be created
  + resource "aws_eip" "eip" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all             = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc                  = (known after apply)
    }

  # aws_elb.load_balancer will be created
  + resource "aws_elb" "load_balancer" {
      + arn                         = (known after apply)
      + availability_zones          = (known after apply)
      + connection_draining         = true
      + connection_draining_timeout = 400
      + cross_zone_load_balancing   = true
      + desync_mitigation_mode      = "defensive"
      + dns_name                    = (known after apply)
      + id                          = (known after apply)
      + idle_timeout                = 400
      + instances                   = (known after apply)
      + internal                    = (known after apply)
      + name                        = "aws-metadata-webapp"
      + name_prefix                 = (known after apply)
      + security_groups             = (known after apply)
      + source_security_group       = (known after apply)
      + source_security_group_id    = (known after apply)
      + subnets                     = (known after apply)
      + tags                        = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                    = {
          + "project" = "aws-metadata-webapp"
        }
      + zone_id                     = (known after apply)

      + health_check {
          + healthy_threshold   = 2
          + interval            = 30
          + target              = "HTTP:80/"
          + timeout             = 15
          + unhealthy_threshold = 5
        }

      + listener {
          + instance_port     = 80
          + instance_protocol = "http"
          + lb_port           = 80
          + lb_protocol       = "http"
        }
    }

  # aws_elb_attachment.instance_attachment["private-subnet-1"] will be created
  + resource "aws_elb_attachment" "instance_attachment" {
      + elb      = "aws-metadata-webapp"
      + id       = (known after apply)
      + instance = (known after apply)
    }

  # aws_elb_attachment.instance_attachment["private-subnet-2"] will be created
  + resource "aws_elb_attachment" "instance_attachment" {
      + elb      = "aws-metadata-webapp"
      + id       = (known after apply)
      + instance = (known after apply)
    }

  # aws_elb_attachment.instance_attachment["private-subnet-3"] will be created
  + resource "aws_elb_attachment" "instance_attachment" {
      + elb      = "aws-metadata-webapp"
      + id       = (known after apply)
      + instance = (known after apply)
    }

  # aws_instance.ec2["private-subnet-1"] will be created
  + resource "aws_instance" "ec2" {
      + ami                                  = "ami-013e83f579886baeb"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                             = {
          + "project" = "aws-metadata-webapp"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "e6cc1368c6cceeedcaa230a7b5674fc088ebc81b"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }
    }

  # aws_instance.ec2["private-subnet-2"] will be created
  + resource "aws_instance" "ec2" {
      + ami                                  = "ami-013e83f579886baeb"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                             = {
          + "project" = "aws-metadata-webapp"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "e6cc1368c6cceeedcaa230a7b5674fc088ebc81b"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }
    }

  # aws_instance.ec2["private-subnet-3"] will be created
  + resource "aws_instance" "ec2" {
      + ami                                  = "ami-013e83f579886baeb"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = (known after apply)
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_lifecycle                   = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t3.micro"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = (known after apply)
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = (known after apply)
      + source_dest_check                    = true
      + spot_instance_request_id             = (known after apply)
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                             = {
          + "project" = "aws-metadata-webapp"
        }
      + tenancy                              = (known after apply)
      + user_data                            = "e6cc1368c6cceeedcaa230a7b5674fc088ebc81b"
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_protocol_ipv6          = "disabled"
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = "optional"
          + instance_metadata_tags      = (known after apply)
        }
    }

  # aws_internet_gateway.igw will be created
  + resource "aws_internet_gateway" "igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id   = "vpc-01734b6e05d493a77"
    }

  # aws_key_pair.ssh_key will be created
  + resource "aws_key_pair" "ssh_key" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "private-key"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8G24eV3clDu81fPJX+BpOMhoVfTXe/Lz0tiPKk97G/XJiNiVTddIZ7zgN7Ta5Db/rhhVsBLTuHQurmXzIJhBh6Y4ulWlvy7aELPzI8rWjUU5IRiBntT2exwtZBlxR5Szw+eejP4RbSRHvBVBtLALkOXbP+Xmt0nOMdgNotxAeEneqR1bCvVxG0fJ/Qv4qP/pvhrjfcz2qpB0WM8qsG0d88aKW2n0VwOy+ZuXU85fPLFbaQyF3VnLQtbW4wl+uAl+FmY2duoMOXrMElbwVwVKeOqSS4iQB6Kizb2x15fPA4kBTe27cJ4eIlvod29RO3RA7R4MB1TCWYlvR1U2ttgIJmmtVhEbw4k0u3hHx7P0TcPkZ8phLxcojnfpkD93xz3r76xf0ZAa1McxozsvCBSEH4ZLtHMPsc2lGRRxUBm4CUn9n0bEzRYA9kdFxVdQfq4rMaAPqDl9hJkqrnapyvYQKESY5Q/NhXIZ74oIrl4pfFpY2MN2K1cYEiUKxd1Kvc+E="
      + tags_all        = (known after apply)
    }

  # aws_nat_gateway.ngw["public-subnet-1"] will be created
  + resource "aws_nat_gateway" "ngw" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                           = {
          + "project" = "aws-metadata-webapp"
        }
    }

  # aws_nat_gateway.ngw["public-subnet-2"] will be created
  + resource "aws_nat_gateway" "ngw" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                           = {
          + "project" = "aws-metadata-webapp"
        }
    }

  # aws_nat_gateway.ngw["public-subnet-3"] will be created
  + resource "aws_nat_gateway" "ngw" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags                               = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                           = {
          + "project" = "aws-metadata-webapp"
        }
    }

  # aws_route_table.private_rt["public-subnet-1"] will be created
  + resource "aws_route_table" "private_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table.private_rt["public-subnet-2"] will be created
  + resource "aws_route_table" "private_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table.private_rt["public-subnet-3"] will be created
  + resource "aws_route_table" "private_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = ""
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = (known after apply)
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table.public_rt["public-subnet-1"] will be created
  + resource "aws_route_table" "public_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table.public_rt["public-subnet-2"] will be created
  + resource "aws_route_table" "public_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table.public_rt["public-subnet-3"] will be created
  + resource "aws_route_table" "public_rt" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags_all         = (known after apply)
      + vpc_id           = "vpc-01734b6e05d493a77"
    }

  # aws_route_table_association.private_rt_association[0] will be created
  + resource "aws_route_table_association" "private_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.private_rt_association[1] will be created
  + resource "aws_route_table_association" "private_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.private_rt_association[2] will be created
  + resource "aws_route_table_association" "private_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_rt_association["public-subnet-1"] will be created
  + resource "aws_route_table_association" "public_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_rt_association["public-subnet-2"] will be created
  + resource "aws_route_table_association" "public_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_rt_association["public-subnet-3"] will be created
  + resource "aws_route_table_association" "public_rt_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.ec2_sg will be created
  + resource "aws_security_group" "ec2_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = []
              + description      = "Allow http requests"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = (known after apply)
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = "vpc-01734b6e05d493a77"
    }

  # aws_security_group.load_balancer_sg will be created
  + resource "aws_security_group" "load_balancer_sg" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow http requests"
              + from_port        = 80
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 80
            },
        ]
      + name                   = (known after apply)
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.private_subnets["private-subnet-1"] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.7.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.private_subnets["private-subnet-2"] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.8.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.private_subnets["private-subnet-3"] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1c"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.9.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.public_subnets["public-subnet-1"] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.public_subnets["public-subnet-2"] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.4.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_subnet.public_subnets["public-subnet-3"] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "ap-south-1c"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.5.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "project" = "aws-metadata-webapp"
        }
      + tags_all                                       = {
          + "project" = "aws-metadata-webapp"
        }
      + vpc_id                                         = "vpc-01734b6e05d493a77"
    }

  # aws_vpc.vpc will be updated in-place
  ~ resource "aws_vpc" "vpc" {
        id                                   = "vpc-01734b6e05d493a77"
      ~ tags                                 = {
          ~ "project" = "aws-metadata-server" -> "aws-metadata-webapp"
        }
      ~ tags_all                             = {
          ~ "project" = "aws-metadata-server" -> "aws-metadata-webapp"
        }
        # (14 unchanged attributes hidden)
    }

Plan: 35 to add, 1 to change, 0 to destroy.
```