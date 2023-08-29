locals {
  ec2_compliance_common_tags = merge(local.aws_cfn_compliance_common_tags, {
    service = "AWS/EC2"
  })
}

benchmark "ec2" {
  title       = "EC2"
  description = "This benchmark provides a set of controls that detect AWS CloudFormation EC2 resources deviating from security best practices."

  children = [
    control.ec2_instance_termination_protection_enabled,
    control.ec2_instance_detailed_monitoring_enabled,
    control.ec2_instance_ebs_optimized,
    control.ec2_instance_not_publicly_accessible,
    control.ec2_classic_lb_connection_draining_enabled
  ]

  tags = merge(local.ec2_compliance_common_tags, {
    type = "Benchmark"
  })
}

control "ec2_instance_termination_protection_enabled" {
  title       = "EC2 instances termination protection should be enabled"
  description = "To prevent your instance from being accidentally terminated using Amazon EC2, you can enable termination protection for the instance."
  query       = query.ec2_instance_termination_protection_enabled

  tags = local.ec2_compliance_common_tags
}

control "ec2_instance_detailed_monitoring_enabled" {
  title       = "EC2 instance detailed monitoring should be enabled"
  description = "Enable this rule to help improve Amazon Elastic Compute Cloud (Amazon EC2) instance monitoring on the Amazon EC2 console, which displays monitoring graphs with a one minute period for the instance."
  query       = query.ec2_instance_detailed_monitoring_enabled

  tags =local.ec2_compliance_common_tags
}

control "ec2_instance_ebs_optimized" {
  title       = "EC2 instance should have EBS optimization enabled"
  description = "An optimized instance in Amazon Elastic Block Store (Amazon EBS) provides additional, dedicated capacity for Amazon EBS I/O operations."
  query       = query.ec2_instance_ebs_optimized

  tags = local.ec2_compliance_common_tags
}

control "ec2_instance_not_publicly_accessible" {
  title       = "EC2 instances should not have a public IP address"
  description = "Manage access to the AWS Cloud by ensuring Amazon Elastic Compute Cloud (Amazon EC2) instances cannot be publicly accessed."
  query       = query.ec2_instance_not_publicly_accessible

  tags = local.ec2_compliance_common_tags
}