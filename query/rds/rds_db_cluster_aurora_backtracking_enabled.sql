select
  type || ' ' || name as resource,
  case
    when (properties ->> 'Engine') not like any (array ['%aurora%', '%aurora-mysql%']) then 'skip'
    when (properties -> 'BacktrackWindow') is not null then 'ok'
    else 'alarm'
  end as status,
  name || case
    when (properties ->> 'Engine') not like any (array ['%aurora%', '%aurora-mysql%']) then ' not Aurora MySQL-compatible edition'
    when (properties -> 'BacktrackWindow') is not null then ' backtracking enabled'
    else ' backtracking disabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::RDS::DBCluster';