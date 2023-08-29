locals {
  elb_compliance_common_tags = merge(local.aws_cfn_compliance_common_tags, {
    service = "AWS/ELB"
  })
}

benchmark "elb" {
  title       = "ELB"
  description = "This benchmark provides a set of controls that detect Terraform AWS ELB resources deviating from security best practices."

  children = [
    control.ec2_classic_lb_connection_draining_enabled
  ]

  tags = merge(local.elb_compliance_common_tags, {
    type = "Benchmark"
  })
}

control "ec2_classic_lb_connection_draining_enabled" {
  title       = "Classic Load Balancers should have connection draining enabled"
  description = "This control checks whether Classic Load Balancers have connection draining enabled."
  query       = query.ec2_classic_lb_connection_draining_enabled

  tags = local.elb_compliance_common_tags
}
