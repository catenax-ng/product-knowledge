DROP TABLE $scratch.CX_RUL_LoadCollective;
CREATE TABLE $scratch.CX_RUL_LoadCollective AS (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
        JSON.json['metadata'].projectDescription as metadata_projectDescription,
        JSON.json['metadata'].componentDescription as metadata_componentDescription,
        TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.json['metadata'].status.operatingHours AS DOUBLE)*3600.0 as metadata_status_operatingTime,
        CAST(JSON.json['metadata'].status.mileage AS DOUBLE) as metadata_status_mileage,
        JSON.json.header.countingValue as header_countingValue,
        JSON.json.header.countingUnit as header_countingUnit,
        JSON.json.header.countingMethod as header_countingMethod,
        CONVERT_TO(JSON.json.header.channels,'json') as header_channels,
        CONVERT_TO(JSON.json.body.counts,'json') as body_counts,
        CONVERT_TO(JSON.json.body.classes,'json') as body_classes
    FROM (
      SELECT
        catenaXId,
        FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
      FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
    ) JSON
    WHERE JSON.json IS NOT NULL
);

DROP VIEW "HI_TEST_OEM".CX_RUL_LoadCollective;
CREATE VIEW "HI_TEST_OEM".CX_RUL_LoadCollective AS 
SELECT catenaXId,
       targetComponentId,
       metadata_projectDescription,
       metadata_componentDescription,
       TO_CHAR(metadata_status_date,'YYYY-MM-DD"T"HH:MI:SS.FFF"Z"') as metadata_status_date,
       CAST(metadata_status_operatingTime AS INTEGER) as metadata_status_operatingTime,
       CAST(metadata_status_mileage AS INTEGER) as metadata_status_mileage,
       header_countingValue,
       header_countingUnit,
       header_countingMethod,
       header_channels,
       body_counts,
       body_classes
  FROM $scratch.CX_RUL_LoadCollective;

ALTER TABLE $scratch.CX_RUL_LoadCollective ADD PRIMARY KEY (catenaXId,targetComponentId,metadata_projectDescription);
