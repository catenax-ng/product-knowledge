/* Examples for Flatting Views based on a JSON file */

CREATE VIEW "DIAGNOSIS_LOCAL"."meta" AS 
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
CREATE VIEW "DIAGNOSIS_LOCAL"."content" AS
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
CREATE VIEW "DIAGNOSIS_LOCAL"."part" AS
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
CREATE VIEW "DIAGNOSIS_LOCAL"."content_part" AS
SELECT parts.id as dtc_id,
  parts.part.part.entityGuid as part_entityguid
FROM (
  SELECT contents.content.id, FLATTEN(contents.content.parts) AS part FROM (
    SELECT flatten(content) AS content
    FROM "Local"."dtc_codes.json"
  ) contents
) parts

/** Quality Skill */

/** data from cloud **/
/**
CREATE VIEW "quality"."DTC" AS SELECT * FROM datalake."catenax-knowledge-agents"."DTC.xlsx"
CREATE VIEW "quality"."DTC_PossibleCause_Error" AS SELECT * FROM datalake."catenax-knowledge-agents"."DTC_PossibleCause_Error.xlsx"
CREATE VIEW "quality"."Error" AS SELECT * FROM datalake."catenax-knowledge-agents"."Error.xlsx"
CREATE VIEW "quality"."Error_ErrorEffect" AS SELECT * FROM datalake."catenax-knowledge-agents"."Error_ErrorEffect.xlsx"
CREATE VIEW "quality"."Error_ErrorSolution" AS SELECT * FROM datalake."catenax-knowledge-agents"."Error_ErrorSolution.xlsx"
CREATE VIEW "quality"."ErrorEffect" AS SELECT * FROM datalake."catenax-knowledge-agents"."ErrorEffect.xlsx"
CREATE VIEW "quality"."ErrorSolution" AS SELECT * FROM datalake."catenax-knowledge-agents"."ErrorSolution.xlsx"
CREATE VIEW "quality"."Part" AS SELECT * FROM datalake."catenax-knowledge-agents"."Part.xlsx"
CREATE VIEW "quality"."Part_PossibleCause" AS SELECT * FROM datalake."catenax-knowledge-agents"."Part_PossibleCause.xlsx"
CREATE VIEW "quality"."PossibleCause" AS SELECT * FROM datalake."catenax-knowledge-agents"."PossibleCause.xlsx"
**/

/** data from local system **/
CREATE VIEW "quality"."DTC" AS SELECT * FROM "local"."DTC.xlsx"
CREATE VIEW "quality"."DTC_PossibleCause_Error" AS SELECT * FROM "local"."DTC_PossibleCause_Error.xlsx"
CREATE VIEW "quality"."Error" AS SELECT * FROM "local"."Error.xlsx"
CREATE VIEW "quality"."Error_ErrorEffect" AS SELECT * FROM "local"."Error_ErrorEffect.xlsx"
CREATE VIEW "quality"."Error_ErrorSolution" AS SELECT * FROM "local"."Error_ErrorSolution.xlsx"
CREATE VIEW "quality"."ErrorEffect" AS SELECT * FROM "local"."ErrorEffect.xlsx"
CREATE VIEW "quality"."ErrorSolution" AS SELECT * FROM "local"."ErrorSolution.xlsx"
CREATE VIEW "quality"."Part" AS SELECT * FROM "local"."Part.xlsx"
CREATE VIEW "quality"."Part_PossibleCause" AS SELECT * FROM "local"."Part_PossibleCause.xlsx"
CREATE VIEW "quality"."PossibleCause" AS SELECT * FROM "local"."PossibleCause.xlsx"
