DROP TABLE $scratch.CX_RUL_Testdata_v1_LoadCollective;
CREATE TABLE $scratch.CX_RUL_Testdata_v1_LoadCollective AS (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
        JSON.json['metadata'].projectDescription as metadata_projectDescription,
        JSON.json['metadata'].componentDescription as metadata_componentDescription,
        TO_DATE(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.json['metadata'].status.operatingTime AS DOUBLE) as metadata_status_operatingTime,
        CAST(JSON.json['metadata'].status.mileage AS DOUBLE) as metadata_status_mileage,
        JSON.json.header.countingUnit as header_countingUnit,
        JSON.json.header.countingMethod as header_countingMethod,
        CONVERT_TO(JSON.json.header.channels,'json') as header_channels,
        CONVERT_TO(JSON.json.body.counts,'json') as body_counts,
        CONVERT_TO(JSON.json.body.classes,'json') as body_classes
    FROM (
      SELECT
        catenaXId,
        FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective") AS json
      FROM datalake."catenax-knowledge-agents"."CX_RUL_Testdata_v1.0.0.ndjson"
    ) JSON
    WHERE JSON.json IS NOT NULL
);
DROP VIEW "HI_TEST_OEM".CX_RUL_Testdata_v1_LoadCollective;
CREATE VIEW "HI_TEST_OEM".CX_RUL_Testdata_v1_LoadCollective AS SELECT * FROM $scratch.CX_RUL_Testdata_v1_LoadCollective;
