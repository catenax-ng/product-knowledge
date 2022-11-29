/* Examples for Flatting Views based on a JSON file */

SELECT 
  'BPNL00000003COJN' as bpnl,
  "dtc_codes.json".meta.first,
  "dtc_codes.json".meta.last, 
  "dtc_codes.json".meta.number,
  "dtc_codes.json".meta.number_of_elements,
  "dtc_codes.json".meta.size,
  "dtc_codes.json".meta.total_elements,
  "dtc_codes.json".meta.total_pages
FROM "Local"."dtc_codes.json"

/** content */
SELECT 'BPNL00000003COJN' as bpnl,
  0 as number,
  contents.content.id,
  contents.content.code,
  contents.content.description,
  contents.content.possible_causes,
  '' as make,
  contents.content.created_at,
  contents.content.updated_at,
  contents.content.lock_version
FROM (
  SELECT flatten(content) AS content
  FROM "Local"."dtc_codes.json"
) contents

/** part */

SELECT distinct 'BPNL00000003COJN' as bpnl,
  0 as number,
  parts.part.part.entityGuid,
  parts.part.part.enDenomination,
  parts.part.part.classification,
  parts.part.part.category,
  parts.part.part.enDaClass
FROM (
  SELECT FLATTEN(contents.content.parts) AS part FROM (
    SELECT flatten(content) AS content
    FROM "Local"."dtc_codes.json"
  ) contents
) parts

/** content_part */
SELECT parts.id as dtc_id,
  parts.part.part.entityGuid as part_entityguid
FROM (
  SELECT contents.content.id, FLATTEN(contents.content.parts) AS part FROM (
    SELECT flatten(content) AS content
    FROM "Local"."dtc_codes.json"
  ) contents
) parts