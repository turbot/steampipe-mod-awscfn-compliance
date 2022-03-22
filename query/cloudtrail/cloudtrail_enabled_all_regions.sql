select
  distinct type || ' ' || name as resource,
  case
    when (properties ->> 'IsMultiRegionTrail') is null or (properties ->> 'IsMultiRegionTrail')::boolean = 'false' then 'alarm'
    when (properties ->> 'IsLogging') is null or (properties ->> 'IsLogging')::boolean = 'false' then 'alarm'
    when not properties -> 'EventSelectors' @> '[{"ReadWriteType": "All"}]' then 'alarm'
    else 'ok'
  end status,
  name || case
    when (properties ->> 'IsMultiRegionTrail') is null or (properties ->> 'IsMultiRegionTrail')::boolean = 'false' then ' multi region trails not enabled'
    when (properties ->> 'IsLogging') is null or (properties ->> 'IsLogging')::boolean = 'false' then ' logging disabled'
    when not properties -> 'EventSelectors' @> '[{"ReadWriteType": "All"}]' then ' not enbaled for all events'
    else ' logging enabled for ALL events'
  end || '.' reason,
  path
from
  awscfn_resource
where
  type = 'AWS::CloudTrail::Trail';