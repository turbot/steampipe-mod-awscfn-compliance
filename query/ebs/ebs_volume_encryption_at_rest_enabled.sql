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
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::EC2::Volume';