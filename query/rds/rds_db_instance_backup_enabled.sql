select
  type || ' ' || name as resource,
  case
    when (properties -> 'BackupRetentionPeriod') is null then 'alarm'
    when (properties -> 'BackupRetentionPeriod')::integer < 1 then 'alarm'
    else 'ok'
  end status,
  name || case
    when (properties -> 'BackupRetentionPeriod') is null then ' backup disabled'
    when (properties -> 'BackupRetentionPeriod')::integer < 1 then ' backup disabled'
    else ' backup enabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::RDS::DBInstance';