select
  type || ' ' || name as resource,
  case
    when coalesce(trim(properties ->> 'KmsMasterKeyId'), '') = '' then 'alarm'
    else 'ok'
  end as status,
  name || case
    when (properties -> 'KmsMasterKeyId') is null then ' ''KmsMasterKeyId'' is not defined.'
    when coalesce(trim(properties ->> 'KmsMasterKeyId'), '') <> '' then ' encryption at rest enabled.'
    else ' encryption at rest disabled.'
  end || '.' reason,
  path
from
  awscfn_resource
where
  type = 'AWS::SNS::Topic';