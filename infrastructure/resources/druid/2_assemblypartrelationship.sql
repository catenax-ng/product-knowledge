REPLACE INTO CX_RUL_Testdata_v1_AssemblyPartRelationship OVERWRITE ALL
WITH
  JSON AS (
    SELECT *
      FROM TABLE(
        EXTERN(
          '{"type":"azure","uris":["azure://catenax-knowledge-agents/CX_RUL_Testdata_v1.0.0.ndjson"]}',
          '{"type":"json"}',
          '[{"name":"catenaXId","type":"string"},{"name":"urn:bamm:io.catenax.assembly_part_relationship:1.1.1#AssemblyPartRelationship","type":"string"}]'
        )
      )
    WHERE "urn:bamm:io.catenax.assembly_part_relationship:1.1.1#AssemblyPartRelationship" IS NOT NULL),
  CHILDREN AS (
    SELECT
      catenaXId,
      JSON_QUERY("urn:bamm:io.catenax.assembly_part_relationship:1.1.1#AssemblyPartRelationship",'$[0].childParts[0]') as childPart
    FROM JSON),
  FLAT AS (
    SELECT
        SUBSTR(catenaXId,10) as catenaXId,
        JSON_VALUE(childPart,'$.quantity.quantityNumber' RETURNING DOUBLE) as quantity_number,
        JSON_VALUE(childPart,'$.quantity.measurementUnit.lexicalValue' RETURNING VARCHAR) as quantity_unit,
        JSON_VALUE(childPart,'$.lifecycleContext' RETURNING VARCHAR) as lifecycle_context,
        TIME_PARSE(JSON_VALUE(childPart,'$.assembledOn' RETURNING VARCHAR)) as assembledOn,
        TIME_PARSE(JSON_VALUE(childPart,'$.lastModifiedOn' RETURNING VARCHAR)) as lastModifiedOn,
        SUBSTR(JSON_VALUE(childPart,'$.childCatenaXId' RETURNING VARCHAR),10) as childCatenaXId
   FROM CHILDREN)
SELECT
  catenaXId,
  MIN(quantity_number) AS quantity_number,
  'pc' AS quantity_unit,
  'as-built' AS lifecycle_context,
  MIN(assembledOn) AS assembledOn,
  MIN(lastModifiedOn) AS lastModifiedOn,
  childCatenaXId
FROM FLAT
GROUP BY catenaXId, childCatenaXId
PARTITIONED BY ALL
CLUSTERED BY catenaXId