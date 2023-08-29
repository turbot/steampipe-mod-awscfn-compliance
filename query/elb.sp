
query "ec2_classic_lb_connection_draining_enabled" {
  sql = <<-EOQ
    select
      type || ' ' || name as resource,
      case
        when ( properties is not null  and (properties -> 'ConnectionDrainingPolicy') is null )
        or ( properties_src is not null  and (properties_src -> 'ConnectionDrainingPolicy') is null )
        then 'alarm'
        when (properties is not null and (properties -> 'ConnectionDrainingPolicy' ->> 'Enabled')::bool)
        or (properties_src is not null and (properties_src -> 'ConnectionDrainingPolicy' ->> 'Enabled')::bool)
         then 'ok'
        else 'alarm'
      end as status,
      name || case
        when ( properties is not null  and (properties -> 'ConnectionDrainingPolicy') is null )
        or ( properties_src is not null  and (properties_src -> 'ConnectionDrainingPolicy') is null )
        then ' ''ConnectionDrainingPolicy'' is not defined'
        when (properties is not null and (properties -> 'ConnectionDrainingPolicy' ->> 'Enabled')::bool)
        or (properties_src is not null and (properties_src -> 'ConnectionDrainingPolicy' ->> 'Enabled')::bool)
        then ' connection draining enabled'
        else ' connection draining disabled'
      end || '.' as reason
      --${local.tag_dimensions_sql}
      --${local.common_dimensions_sql}
    from
      awscfn_resource
    where
      type = 'AWS::ElasticLoadBalancing::LoadBalancer';
  EOQ
}
