DROP TABLE $scratch.CX_RUL_Analysis;
CREATE TABLE $scratch.CX_RUL_Analysis AS (
  SELECT
    catenaXId,
    targetComponentId,
    MIN(metadata_status_date) as metadata_status_date_min,
    MAX(metadata_status_date) as metadata_status_date_max,
    AVG(metadata_status_operatingHours) as metadata_status_operatingHours_avg,
    AVG(metadata_status_mileage) as metadata_status_mileage_avg
    FROM (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
        TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.json['metadata'].status.operatingHours AS DOUBLE) as metadata_status_operatingHours,
        CAST(JSON.json['metadata'].status.mileage AS DOUBLE) as metadata_status_mileage
    FROM (
      SELECT
        catenaXId,
        FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
      FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
    ) JSON
    WHERE JSON.json IS NOT NULL
   ) GROUP BY catenaXId, targetComponentId
);

DROP TABLE $scratch.CX_RUL_LoadCollective;
CREATE TABLE $scratch.CX_RUL_LoadCollective AS (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
        JSON.json['metadata'].projectDescription as metadata_projectDescription,
        JSON.json['metadata'].componentDescription as metadata_componentDescription,
        JSON.json['metadata'].routeDescription as metadata_routeDescription,
        TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.json['metadata'].status.operatingHours AS DOUBLE) as metadata_status_operatingHours,
        CAST(JSON.json['metadata'].status.mileage AS DOUBLE) as metadata_status_mileage,
        JSON.json.body.counts.countsName as header_countingValue,
        JSON.json.header.countingUnit as header_countingUnit,
        JSON.json.header.countingMethod as header_countingMethod,
        CONVERT_TO(JSON.json.header.channels,'json') as header_channels,
        CONVERT_TO(JSON.json.body.counts.countsList,'json') as body_counts_countsList,
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

DROP TABLE $scratch.CX_RUL_LoadCollective_Channels;
CREATE TABLE $scratch.CX_RUL_LoadCollective_Channels AS (
  SELECT
      catenaXId,
      targetComponentId,
      metadata_projectDescription,
      metadata_componentDescription,
      metadata_status_date,
      channels.index as channel_index,
      channels.channel.unit as channel_unit,
      channels.channel.numberOfBins as channel_numberOfBins,
      channels.channel.channelName as channel_channelName,
      channels.channel.upperLimit as channel_upperLimit,
      channels.channel.lowerLimit as channel_lowerLimit,
      channels.classes.className as classes_className,
      channels.classes.classList as classes_classList
  FROM (
    SELECT
      SUBSTR(JSON.catenaXId,10) as catenaXId,
      SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
      JSON.json['metadata'].projectDescription as metadata_projectDescription,
      JSON.json['metadata'].componentDescription as metadata_componentDescription,
      TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
      0 as index,
      JSON.json.header.channels[0] as channel,
      JSON.json.body.classes[0] as classes
    FROM (
           SELECT
              catenaXId,
              FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
            FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON WHERE
         JSON.json IS NOT NULL AND ARRAY_LENGTH(JSON.json.header.channels)>0
    UNION ALL
    SELECT
      SUBSTR(JSON.catenaXId,10) as catenaXId,
      SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
      JSON.json['metadata'].projectDescription as metadata_projectDescription,
      JSON.json['metadata'].componentDescription as metadata_componentDescription,
      TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
      1 as index,
      JSON.json.header.channels[1] as channel,
      JSON.json.body.classes[1] as classes
    FROM (
           SELECT
              catenaXId,
              FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
            FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON WHERE
         JSON.json IS NOT NULL AND ARRAY_LENGTH(JSON.json.header.channels)>1
    UNION ALL
    SELECT
      SUBSTR(JSON.catenaXId,10) as catenaXId,
      SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
      JSON.json['metadata'].projectDescription as metadata_projectDescription,
      JSON.json['metadata'].componentDescription as metadata_componentDescription,
      TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
      2 as index,
      JSON.json.header.channels[2] as channel,
      JSON.json.body.classes[2] as classes
    FROM (
           SELECT
              catenaXId,
              FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
            FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON WHERE
         JSON.json IS NOT NULL AND ARRAY_LENGTH(JSON.json.header.channels)>2
    UNION ALL
    SELECT
      SUBSTR(JSON.catenaXId,10) as catenaXId,
      SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
      JSON.json['metadata'].projectDescription as metadata_projectDescription,
      JSON.json['metadata'].componentDescription as metadata_componentDescription,
      TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
      3 as index,
      JSON.json.header.channels[3] as channel,
      JSON.json.body.classes[3] as classes
    FROM (
           SELECT
              catenaXId,
              FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
            FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON WHERE
         JSON.json IS NOT NULL AND ARRAY_LENGTH(JSON.json.header.channels)>3
    UNION ALL
    SELECT
      SUBSTR(JSON.catenaXId,10) as catenaXId,
      SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
      JSON.json['metadata'].projectDescription as metadata_projectDescription,
      JSON.json['metadata'].componentDescription as metadata_componentDescription,
      TO_TIMESTAMP(LEFT(JSON.json['metadata'].status['date'],10),'YYYY-MM-DD') as metadata_status_date,
      4 as index,
      JSON.json.header.channels[4] as channel,
      JSON.json.body.classes[4] as classes
    FROM (
           SELECT
              catenaXId,
              FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadSpectrum") AS json
            FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON WHERE
         JSON.json IS NOT NULL AND ARRAY_LENGTH(JSON.json.header.channels)>4
  ) channels
);

DROP VIEW "HI_TEST_OEM".CX_RUL_Analysis;
CREATE VIEW "HI_TEST_OEM".CX_RUL_Analysis AS
SELECT catenaXId,
       targetComponentId,
       TO_CHAR(metadata_status_date_min,'YYYY-MM-DD"T"HH:MI:SS.FFF"Z"') as metadata_status_date_min,
       TO_CHAR(metadata_status_date_max,'YYYY-MM-DD"T"HH:MI:SS.FFF"Z"') as metadata_status_date_max,
       metadata_status_operatingHours_avg,
       CAST(metadata_status_mileage_avg AS INTEGER) as metadata_status_mileage_avg
  FROM $scratch.CX_RUL_Analysis;

ALTER TABLE $scratch.CX_RUL_Analysis ADD PRIMARY KEY (catenaXId,targetComponentId,metadata_status_date_min);


DROP VIEW "HI_TEST_OEM".CX_RUL_LoadCollective;
CREATE VIEW "HI_TEST_OEM".CX_RUL_LoadCollective AS
SELECT catenaXId,
       targetComponentId,
       metadata_projectDescription,
       metadata_componentDescription,
       metadata_routeDescription,
       TO_CHAR(metadata_status_date,'YYYY-MM-DD"T"HH:MI:SS.FFF"Z"') as metadata_status_date,
       metadata_status_operatingHours as metadata_status_operatingHours,
       CAST(metadata_status_mileage AS INTEGER) as metadata_status_mileage,
       header_countingValue,
       header_countingUnit,
       header_countingMethod,
       header_channels,
       body_counts,
       body_counts_countsList,
       body_classes
  FROM $scratch.CX_RUL_LoadCollective;

ALTER TABLE $scratch.CX_RUL_LoadCollective ADD PRIMARY KEY (catenaXId,targetComponentId,metadata_projectDescription,metadata_status_date);

DROP VIEW "HI_TEST_OEM".CX_RUL_LoadCollective_Channels;
CREATE VIEW "HI_TEST_OEM".CX_RUL_LoadCollective_Channels AS
SELECT catenaXId,
       targetComponentId,
       metadata_projectDescription,
       metadata_componentDescription,
       TO_CHAR(metadata_status_date,'YYYY-MM-DD"T"HH:MI:SS.FFF"Z"') as metadata_status_date,
       channel_index,
       channel_unit,
       channel_numberOfBins,
       channel_channelName,
       channel_upperLimit,
       channel_lowerLimit,
       classes_className,
       classes_classList
  FROM $scratch.CX_RUL_LoadCollective_Channels;

ALTER TABLE $scratch.CX_RUL_LoadCollective_Channels ADD PRIMARY KEY (catenaXId,targetComponentId,metadata_projectDescription,metadata_status_date,channel_index);
