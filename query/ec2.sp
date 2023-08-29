query "ec2_instance_termination_protection_enabled" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when ( properties is not null  and (properties -> 'DisableApiTermination') is null )
        or ( properties_src is not null  and (properties_src -> 'DisableApiTermination') is null )
        then 'alarm'
        when (properties is not null and (properties ->> 'DisableApiTermination')::bool)
        or (properties_src is not null and (properties_src ->> 'DisableApiTermination')::bool)
         then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'DisableApiTermination') is null )
        or ( properties_src is not null  and (properties_src -> 'DisableApiTermination') is null )
        then ' ''DisableApiTermination'' is not defined'
        when (properties is not null and (properties ->> 'DisableApiTermination')::bool)
        or (properties_src is not null and (properties_src ->> 'DisableApiTermination')::bool)
        then ' deletion protection enabled'
        else ' deletion protection disabled'
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Instance';
  EOQ
}

query "ec2_instance_detailed_monitoring_enabled" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when ( properties is not null  and (properties -> 'Monitoring') is null )
        or ( properties_src is not null  and (properties_src -> 'Monitoring') is null )
        then 'alarm'
        when (properties is not null and (properties ->> 'Monitoring')::bool)
        or (properties_src is not null and (properties_src ->> 'Monitoring')::bool)
         then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'Monitoring') is null )
        or ( properties_src is not null  and (properties_src -> 'Monitoring') is null )
        then ' ''Monitoring'' is not defined'
        when (properties is not null and (properties ->> 'Monitoring')::bool)
        or (properties_src is not null and (properties_src ->> 'Monitoring')::bool)
        then ' detailed monitoring enabled'
        else ' detailed monitoring disabled'
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Instance';
  EOQ
}

query "ec2_instance_ebs_optimized" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when ( properties is not null  and (properties -> 'EbsOptimized') is null )
        or ( properties_src is not null  and (properties_src -> 'EbsOptimized') is null )
        then 'alarm'
        when (properties is not null and (properties ->> 'EbsOptimized')::bool)
        or (properties_src is not null and (properties_src ->> 'EbsOptimized')::bool)
         then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'EbsOptimized') is null )
        or ( properties_src is not null  and (properties_src -> 'EbsOptimized') is null )
        then ' ''EbsOptimized'' is not defined'
        when (properties is not null and (properties ->> 'EbsOptimized')::bool)
        or (properties_src is not null and (properties_src ->> 'EbsOptimized')::bool)
        then ' EBS optimization enabled'
        else ' EBS optimization disabled'
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Instance';
  EOQ
}

query "ec2_instance_not_publicly_accessible" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when ( properties is not null  and (properties -> 'AssociatePublicIpAddress') is null )
        or ( properties_src is not null  and (properties_src -> 'AssociatePublicIpAddress') is null )
        then 'alarm'
        when (properties is not null and not (properties ->> 'AssociatePublicIpAddress')::bool)
        or (properties_src is not null and not (properties_src ->> 'AssociatePublicIpAddress')::bool)
         then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'AssociatePublicIpAddress') is null )
        or ( properties_src is not null  and (properties_src -> 'AssociatePublicIpAddress') is null )
        then ' ''AssociatePublicIpAddress'' is not defined'
        when (properties is not null and not (properties ->> 'AssociatePublicIpAddress')::bool)
        or (properties_src is not null and not (properties_src ->> 'AssociatePublicIpAddress')::bool)
        then ' not publicly accessible'
        else ' publicly accessible'
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Instance';
  EOQ
}

query "ec2_instance_not_use_multiple_enis" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when (properties is not null and (properties -> 'NetworkInterfaces') is null)
        or (properties_src is not null  and (properties_src -> 'NetworkInterfaces') is null)
        then 'alarm'
        when (properties is not null and (jsonb_array_length(properties -> 'NetworkInterfaces') <= 1))
        or (properties_src is not null and (jsonb_array_length(properties_src -> 'NetworkInterfaces') <= 1))
        then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'NetworkInterfaces') is null )
        or ( properties_src is not null  and (properties_src -> 'NetworkInterfaces') is null )
        then ' ''NetworkInterfaces'' is not defined'
        else
          case
            when (properties -> 'NetworkInterfaces') is not null then ' has ' || (jsonb_array_length(properties -> 'NetworkInterfaces')) || ' ENI(s) attached'
            else ' has ' || (jsonb_array_length(properties_src -> 'NetworkInterfaces')) || ' ENI(s) attached'
          end
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::EC2::Instance';
  EOQ
}

