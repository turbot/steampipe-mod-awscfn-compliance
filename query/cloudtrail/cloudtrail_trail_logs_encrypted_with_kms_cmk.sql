select
  type || ' ' || name as resource,
  case
    when (properties -> 'KMSKeyId') is not null then 'ok'
    else 'alarm'
  end as status,
  name || case
    when (properties -> 'KMSKeyId') is not null then ' logs are encrypted at rest'
    else ' logs are not encrypted at rest'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::CloudTrail::Trail';