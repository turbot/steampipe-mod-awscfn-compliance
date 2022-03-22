select
  type || ' ' || name as resource,
  case
    when (properties ->> 'EnableLogFileValidation')::boolean then 'ok'
    else 'alarm'
  end as status,
  name || case
    when (properties ->> 'EnableLogFileValidation')::boolean then ' log file validation enabled'
    else ' log file validation disabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::CloudTrail::Trail';