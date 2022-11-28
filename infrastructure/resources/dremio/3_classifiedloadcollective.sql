DROP TABLE $scratch.CX_RUL_Testdata_v1_LoadCollective;
CREATE TABLE $scratch.CX_RUL_Testdata_v1_LoadCollective AS (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.json.targetComponentID,10) as targetComponentId,
        JSON.json['metadata'].projectDescription as metadata_projectDescription,
        JSON.json['metadata'].componentDescription as metadata_componentDescription,
        TO_DATE(LEFT(JSON.json.status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.json['metadata'].status.operatingTime AS DOUBLE) as metadata_status_operatingTime,
        CAST(JSON.json['metadata'].status.mileage AS DOUBLE) as metadata_status_mileage,
        JSON.json.header.countingUnit as header_countingUnit,
        JSON.json.header.countingMethod as header_countingMethod,
        JSON.json.body.counts.countsList as body_counts_countsList,
        JSON.json.body.counts.countsName as body_counts_countsName,
        JSON.json as lc_total
    FROM (
      SELECT
        catenaXId,
        FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective") AS json
      FROM datalake."catenax-knowledge-agents"."CX_RUL_Testdata_v1.0.0.ndjson"
    ) JSON
    WHERE JSON.json IS NOT NULL
);
CREATE VIEW "HI_TEST_OEM".CX_RUL_Testdata_v1_LoadCollective AS SELECT * FROM $scratch.CX_RUL_Testdata_v1_LoadCollective;

CREATE TABLE $scratch.CX_RUL_Testdata_v1_LoadCollective AS (
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        SUBSTR(JSON.targetComponentID,10) as targetComponentId,
        JSON.metadata.projectDescription as metadata_projectDescription,
        JSON.metadata.componentDescription as metadata_componentDescription,
        TO_DATE(LEFT(JSON.status['date'],10),'YYYY-MM-DD') as metadata_status_date,
        CAST(JSON.metadata.status.operatingTime AS DOUBLE) as metadata_status_operatingTime,
        CAST(JSON.metadata.status.mileage AS DOUBLE) as metadata_status_mileage,
        JSON.header.countingUnit as header_countingUnit,
        JSON.header.countingMethod as header_countingMethod,
        JSON.header.channels[0].unit as header_channel0_unit,
        CAST(JSON.header.channels[0].numberOfBins AS INTEGER) as header_channel0_numberOfBins,
        JSON.header.channels[0].channelName as header_channel0_channelName,
        CAST(JSON.header.channels[0].upperLimit AS DOUBLE) as header_channel0_upperLimit,
        CAST(JSON.header.channels[0].lowerLimit AS DOUBLE) as header_channel0_lowerLimit,
        JSON.header.channels[1].unit as header_channel1_unit,
        CAST(JSON.header.channels[1].numberOfBins AS INTEGER) as header_channel1_numberOfBins,
        JSON.header.channels[1].channelName as header_channel1_channelName,
        CAST(JSON.header.channels[1].upperLimit AS DOUBLE) as header_channel1_upperLimit,
        CAST(JSON.header.channels[1].lowerLimit AS DOUBLE) as header_channel1_lowerLimit,
        JSON.header.channels[2].unit as header_channel2_unit,
        CAST(JSON.header.channels[2].numberOfBins AS INTEGER) as header_channel2_numberOfBins,
        JSON.header.channels[2].channelName as header_channel2_channelName,
        CAST(JSON.header.channels[2].upperLimit AS DOUBLE) as header_channel2_upperLimit,
        CAST(JSON.header.channels[2].lowerLimit AS DOUBLE) as header_channel2_lowerLimit,
        JSON.body.counts.countsList as body_counts_countsList,
        JSON.body.counts.countsName as body_counts_countsName,
        JSON.body.classes[0].classList as body_class0_classList,
        JSON.body.classes[0].className as body_class0_className,
        JSON.body.classes[1].classList as body_class1_classList,
        JSON.body.classes[1].className as body_class1_className,
        JSON.body.classes[2].classList as body_class2_classList,
        JSON.body.classes[2].className as body_class2_className
    FROM (
      SELECT
        catenaXId,
        FLATTEN("urn:bamm:io.openmanufacturing.digitaltwin:1.0.0#ClassifiedLoadCollective") AS json
      FROM datalake."catenax-knowledge-agents"."CX_RUL_Testdata_v1.0.0.ndjson"
    ) JSON
    WHERE JSON.json IS NOT NULL
);
