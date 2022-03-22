select
  type || ' ' || name as resource,
  case
    when (properties -> 'EnableKeyRotation') is null then 'alarm'
    when (properties -> 'EnableKeyRotation')::boolean then 'ok'
    else 'alarm'
  end as status,
  name || case
    when (properties -> 'EnableKeyRotation') is null then ' key rotation disabled'
    when (properties -> 'EnableKeyRotation')::boolean then ' key rotation enabled'
    else ' key rotation disabled'
  end || '.' as reason,
  path || ':' || start_line
from
  awscfn_resource
where
  type = 'AWS::KMS::Key';