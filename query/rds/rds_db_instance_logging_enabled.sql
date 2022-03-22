select
  type || ' ' || name as resource,
  (properties ->> 'Engine') as engine,
  case
    when
      (properties ->> 'Engine')::text like any (array ['mariadb', '%mysql'])
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["audit","error","general","slowquery"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["audit","error","general","slowquery"]'::jsonb then 'ok'
    when
      (properties ->> 'Engine')::text like any (array['%postgres%'])
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["postgresql","upgrade"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["postgresql","upgrade"]'::jsonb then 'ok'
    when
      (properties ->> 'Engine')::text like 'oracle%' and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["alert","audit", "trace","listener"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["alert","audit", "trace","listener"]'::jsonb then 'ok'
    when
      (properties ->> 'Engine')::text = 'sqlserver-ex'
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["error"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["error"]'::jsonb then 'ok'
    when
      (properties ->> 'Engine')::text like 'sqlserver%'
      and (properties -> 'EnableCloudwatchLogsExports')is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["error","agent"]' then 'ok'
    else 'alarm'
  end as status,
  name || case
    when
      (properties ->> 'Engine')::text like any (array ['mariadb', '%mysql'])
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["audit","error","general","slowquery"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["audit","error","general","slowquery"]'::jsonb then ' logging enabled'
    when
      (properties ->> 'Engine')::text like any (array['%postgres%'])
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["postgresql","upgrade"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["postgresql","upgrade"]'::jsonb then ' logging enabled'
    when
      (properties ->> 'Engine')::text like 'oracle%'
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["alert","audit", "trace","listener"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["alert","audit", "trace","listener"]'::jsonb then ' logging enabled'
    when
      (properties ->> 'Engine')::text = 'sqlserver-ex'
      and (properties -> 'EnableCloudwatchLogsExports') is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["error"]'::jsonb
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb @> '["error"]'::jsonb then ' logging enabled'
    when
      (properties ->> 'Engine')::text like 'sqlserver%'
      and (properties -> 'EnableCloudwatchLogsExports')is not null
      and (properties -> 'EnableCloudwatchLogsExports')::jsonb <@ '["error","agent"]' then ' logging enabled'
    else ' logging disabled'
  end || '.' as reason,
  path
from
  awscfn_resource
where
  type = 'AWS::RDS::DBInstance';