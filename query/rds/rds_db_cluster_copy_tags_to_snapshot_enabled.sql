select
  type || ' ' || name as resource,
  case
    when (properties -> 'CopyTagsToSnapshot') is null then 'alarm'
    when (properties -> 'CopyTagsToSnapshot')::bool then 'ok'
    else 'alarm'
  end status,
  name || case
    when (properties -> 'CopyTagsToSnapshot') is null then ' ''CopyTagsToSnapshot'' disabled'
    when (properties -> 'CopyTagsToSnapshot')::bool then ' ''CopyTagsToSnapshot'' enabled'
    else ' ''CopyTagsToSnapshot'' disabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::RDS::DBCluster';