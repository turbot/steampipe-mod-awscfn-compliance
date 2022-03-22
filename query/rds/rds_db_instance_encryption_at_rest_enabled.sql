select
  type || ' ' || name as resource,
  case
    when (properties -> 'StorageEncrypted') is null then 'alarm'
    when (properties -> 'StorageEncrypted')::bool then 'ok'
    else 'alarm'
  end status,
  name || case
    when (properties -> 'StorageEncrypted') is null then ' not encrypted'
    when (properties -> 'StorageEncrypted')::bool then ' encrypted'
    else ' not encrypted'
  end || '.' reason,
  path || ':' || start_line
from
  awscfn_resource
where
  type = 'AWS::RDS::DBInstance';