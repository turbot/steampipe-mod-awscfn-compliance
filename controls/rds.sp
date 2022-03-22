locals {
  rds_compliance_common_tags = merge(local.compliance_common_tags, {
    service = "rds"
  })
}

benchmark "rds" {
  title       = "RDS"
  description = "This benchmark provides a set of controls that detect AWS CloudFormation RDS resources deviating from security best practices."

  children = [
    control.rds_db_cluster_aurora_backtracking_enabled,
    control.rds_db_cluster_copy_tags_to_snapshot_enabled,
    control.rds_db_cluster_deletion_protection_enabled,
    control.rds_db_instance_encryption_at_rest_enabled,
    control.rds_db_instance_backup_enabled,
    control.rds_db_instance_logging_enabled
  ]

  tags = local.rds_compliance_common_tags
}

control "rds_db_cluster_aurora_backtracking_enabled" {
  title       = "Amazon Aurora clusters should have backtracking enabled"
  description = "This control checks whether Amazon Aurora clusters have backtracking enabled. Backups help you to recover more quickly from a security incident. They also strengthen the resilience of your systems. Aurora backtracking reduces the time to recover a database to a point in time. It does not require a database restore to do so."
  sql         = query.rds_db_cluster_aurora_backtracking_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    aws_foundational_security = "true"
  })
}

control "rds_db_cluster_copy_tags_to_snapshot_enabled" {
  title       = "RDS DB clusters should be configured to copy tags to snapshots"
  description = "This control checks whether RDS DB clusters are configured to copy all tags to snapshots when the snapshots are created."
  sql         = query.rds_db_cluster_copy_tags_to_snapshot_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    aws_foundational_security = "true"
  })
}

control "rds_db_cluster_deletion_protection_enabled" {
  title       = "RDS clusters should have deletion protection enabled"
  description = "This control checks whether RDS clusters have deletion protection enabled. This control is intended for RDS DB instances. However, it can also generate findings for Aurora DB instances, Neptune DB instances, and Amazon DocumentDB clusters. If these findings are not useful,then you can suppress them."
  sql         = query.rds_db_cluster_deletion_protection_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    aws_foundational_security = "true"
  })
}

control "rds_db_instance_encryption_at_rest_enabled" {
  title       = "RDS DB instance encryption at rest should be enabled"
  description = "To help protect data at rest, ensure that encryption is enabled for your Amazon Relational Database Service (Amazon RDS) instances."
  sql           = query.rds_db_instance_encryption_at_rest_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    aws_foundational_security = "true"
    cis = "true"
    gdpr               = "true"
    hipaa              = "true"
    nist_800_53_rev_4  = "true"
    nist_csf           = "true"
    rbi_cyber_security = "true"
  })
}

control "rds_db_instance_backup_enabled" {
  title       = "RDS DB instance backup should be enabled"
  description = "The backup feature of Amazon RDS creates backups of your databases and transaction logs."
  sql           = query.rds_db_instance_backup_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    hipaa              = "true"
    nist_800_53_rev_4  = "true"
    nist_csf           = "true"
    rbi_cyber_security = "true"
    soc_2              = "true"
  })
}

control "rds_db_instance_logging_enabled" {
  title       = "Database logging should be enabled"
  description = "To help with logging and monitoring within your environment, ensure Amazon Relational Database Service (Amazon RDS) logging is enabled."
  sql           = query.rds_db_instance_logging_enabled.sql

  tags = merge(local.rds_compliance_common_tags, {
    aws_foundational_security = "true"
    gdpr               = "true"
    nist_800_53_rev_4  = "true"
    rbi_cyber_security = "true"
    soc_2              = "true"
  })
}