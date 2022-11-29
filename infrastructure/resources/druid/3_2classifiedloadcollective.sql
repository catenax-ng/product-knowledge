INSERT INTO CX_RUL_Testdata_v1_LoadCollective
WITH
  JSON AS (
    SELECT *
    FROM TABLE(
      EXTERN(
        '{"type":"azure","uris":["azure://catenax-knowledge-agents/CX_RUL_Testdata_v1.0.0.ndjson"]}',
        '{"type":"json"}',
        '[{"name":"catenaXId","type":"string"},{"name":"urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective","type":"string"}]'
     )
    )
    WHERE "urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective" IS NOT NULL),
  LC AS (
    SELECT
      catenaXId,
      JSON_QUERY("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective",'$[1]') as lc
   FROM JSON),
  FLAT AS (
    SELECT
        SUBSTR(catenaXId,10) as catenaXId,
        SUBSTR(JSON_VALUE(lc,'$.targetComponentID' RETURNING VARCHAR),10) as targetComponentId,
        JSON_VALUE(lc,'$.metadata.projectDescription' RETURNING VARCHAR) as metadata_projectDescription,
        JSON_VALUE(lc,'$.metadata.componentDescription' RETURNING VARCHAR) as metadata_componentDescription,
        JSON_VALUE(lc,'$.metadata.status.date' RETURNING VARCHAR) as metadata_status_date,
        JSON_VALUE(lc,'$.metadata.status.operatingTime' RETURNING DOUBLE) as metadata_status_operatingTime,
        JSON_VALUE(lc,'$.metadata.status.mileage' RETURNING DOUBLE) as metadata_status_mileage,
        JSON_VALUE(lc,'$.header.countingUnit' RETURNING VARCHAR) as header_countingUnit,
        JSON_VALUE(lc,'$.header.countingMethod' RETURNING VARCHAR) as header_countingMethod,
        JSON_VALUE(lc,'$.header.channels[0].unit' RETURNING VARCHAR) as header_channel0_unit,
        JSON_VALUE(lc,'$.header.channels[0].numberOfBins' RETURNING INTEGER) as header_channel0_numberOfBins,
        JSON_VALUE(lc,'$.header.channels[0].channelName' RETURNING VARCHAR) as header_channel0_channelName,
        JSON_VALUE(lc,'$.header.channels[0].upperLimit' RETURNING DOUBLE) as header_channel0_upperLimit,
        JSON_VALUE(lc,'$.header.channels[0].lowerLimit' RETURNING DOUBLE) as header_channel0_lowerLimit,
        JSON_VALUE(lc,'$.header.channels[1].unit' RETURNING VARCHAR) as header_channel1_unit,
        JSON_VALUE(lc,'$.header.channels[1].numberOfBins' RETURNING INTEGER) as header_channel1_numberOfBins,
        JSON_VALUE(lc,'$.header.channels[1].channelName' RETURNING VARCHAR) as header_channel1_channelName,
        JSON_VALUE(lc,'$.header.channels[1].upperLimit' RETURNING DOUBLE) as header_channel1_upperLimit,
        JSON_VALUE(lc,'$.header.channels[1].lowerLimit' RETURNING DOUBLE) as header_channel1_lowerLimit,
        JSON_VALUE(lc,'$.header.channels[2].unit' RETURNING VARCHAR) as header_channel2_unit,
        JSON_VALUE(lc,'$.header.channels[2].numberOfBins' RETURNING INTEGER) as header_channel2_numberOfBins,
        JSON_VALUE(lc,'$.header.channels[2].channelName' RETURNING VARCHAR) as header_channe2_channelName,
        JSON_VALUE(lc,'$.header.channels[2].upperLimit' RETURNING DOUBLE) as header_channel2_upperLimit,
        JSON_VALUE(lc,'$.header.channels[2].lowerLimit' RETURNING DOUBLE) as header_channel2_lowerLimit,
        TO_JSON_STRING(JSON_QUERY(lc,'$.body.counts.countsList')) as body_counts_countsList,
        JSON_VALUE(lc,'$.body.counts.countsName' RETURNING VARCHAR) as body_counts_countsName,
        TO_JSON_STRING(JSON_QUERY(lc,'$.body.classes[0].classList')) as body_class0_classList,
        JSON_VALUE(lc,'$.body.classes[0].className' RETURNING VARCHAR) as body_class0_className,
        TO_JSON_STRING(JSON_QUERY(lc,'$.body.classes[1].classList')) as body_class1_classList,
        JSON_VALUE(lc,'$.body.classes[1].className' RETURNING VARCHAR) as body_class1_className,
        TO_JSON_STRING(JSON_QUERY(lc,'$.body.classes[2].classList')) as body_class2_classList,
        JSON_VALUE(lc,'$.body.classes[2].className' RETURNING VARCHAR) as body_class2_className,
        TO_JSON_STRING(lc) AS lc_total
  from LC)
SELECT
    catenaXId,
    targetComponentId,
    metadata_componentDescription,
    lc_total
 FROM FLAT
GROUP BY catenaXId, targetComponentId, metadata_componentDescription, lc_total
PARTITIONED BY ALL
CLUSTERED BY catenaXId
