REPLACE INTO CX_RUL_Testdata_v1_SerialPartTypization OVERWRITE ALL
WITH
   JSON AS (
    SELECT *
      FROM TABLE(
        EXTERN(
          '{"type":"azure","uris":["azure://catenax-knowledge-agents/CX_RUL_Testdata_v1.0.0.ndjson"]}',
          '{"type":"json"}',
          '[{"name":"catenaXId","type":"string"},{"name":"urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization","type":"string"}]'
        )
      )
    WHERE "urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization" IS NOT NULL),
  FLAT AS (
   SELECT
    SUBSTR(catenaXId,10) as catenaXId,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].localIdentifiers[0].value' RETURNING VARCHAR) as localIdentifiers_manufacturerId,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].localIdentifiers[2].value' RETURNING VARCHAR) as localIdentifiers_partInstanceId,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].localIdentifiers[3].value' RETURNING VARCHAR) as localIdentifiers_van,
    TIME_PARSE(JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].manufacturingInformation.date' RETURNING VARCHAR)) as manufacturingInformation_date,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].manufacturingInformation.country' RETURNING VARCHAR) as manufacturingInformation_country,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].partTypeInformation.manufacturerPartId' RETURNING VARCHAR) as partTypeInformation_manufacturerPartId,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].partTypeInformation.classification' RETURNING VARCHAR) as partTypeInformation_classification,
    JSON_VALUE("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization",'$[0].partTypeInformation.nameAtManufacturer' RETURNING VARCHAR) as partTypeInformation_nameAtManufacturer
    FROM JSON
  )
SELECT
 catenaXId,
 localIdentifiers_manufacturerId,
 localIdentifiers_partInstanceId,
 localIdentifiers_van,
 MIN(manufacturingInformation_date) as manufacturingInformation_date,
 'DEU' as manufacturingInformation_country,
 partTypeInformation_manufacturerPartId,
 'product' as partTypeInformation_classification,
 partTypeInformation_nameAtManufacturer
FROM FLAT
GROUP BY catenaXId,
         localIdentifiers_manufacturerId,
         localIdentifiers_partInstanceId,
         localIdentifiers_van,
         partTypeInformation_manufacturerPartId,
         partTypeInformation_nameAtManufacturer
PARTITIONED BY ALL
CLUSTERED BY catenaXId