query "ebs_volume_encryption_at_rest_enabled" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when (properties -> 'Encrypted') is null then 'alarm'
        when (properties ->> 'Encrypted')::bool then 'ok'
        else 'alarm'
      end as status,
      name || case
        when (properties -> 'Encrypted') is null then ' ''Encrypted'' is not defined'
        when (properties ->> 'Encrypted')::bool then ' Encrypted.'
        else ' not Encrypted.'
      end || '.' as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Volume';
  EOQ
}

query "ebs_snapshot_copy_encrypted_with_kms_cmk" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when (properties_src ->> 'Encrypted') is null then 'alarm'
        when (properties_src ->> 'Encrypted')::boolean and (properties_src ->> 'KmsKeyId') is not null then 'ok'
        else 'alarm'
      end as status,
      name || case
        when (properties_src ->> 'Encrypted') is null then ' ''encrypted'' is not defined'
        when (properties_src ->> 'Encrypted')::boolean and (properties_src ->> 'KmsKeyId') is not null then ' encrypted'
        else ' not encrypted'
      end || '.' as reason
      ${local.tag_dimensions_sql}
      ${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Snapshot';
  EOQ
}
