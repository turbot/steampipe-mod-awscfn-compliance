select
  type || ' ' || name as resource,
  case
    when (properties -> 'DeletionProtection') is null then 'alarm'
    when (properties -> 'DeletionProtection')::boolean then 'ok'
    else 'alarm'
  end status,
  name || case
    when (properties -> 'DeletionProtection') is null then ' ''DeletionProtection'' disabled'
    when (properties -> 'DeletionProtection')::boolean then ' ''DeletionProtection'' enabled'
    else ' ''DeletionProtection'' disabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::RDS::DBCluster';