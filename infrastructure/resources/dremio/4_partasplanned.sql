DROP TABLE $scratch.CX_TRC_PartAsPlanned;
CREATE TABLE $scratch.CX_TRC_PartAsPlanned AS
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        bpnl,
        JSON.pasp['partTypeInformation'].manufacturerPartId as partTypeInformation_manufacturerPartId,
        JSON.pasp['partTypeInformation'].classification as partTypeInformation_classification,
        JSON.pasp['partTypeInformation'].nameAtManufacturer as partTypeInformation_nameAtManufacturer,
        TO_DATE(LEFT(JSON.pasp['validityPeriod']['validFrom'],10),'YYYY-MM-DD') as validityPeriod_validFrom,
        TO_DATE(LEFT(JSON.pasp['validityPeriod']['validTo'],10),'YYYY-MM-DD') as validityPeriod_validTo,
        ARRAY_LENGTH(JSON.slbomasp.childParts) as assembly_status
    FROM (
       SELECT catenaXId,
              bpnl,
              FLATTEN("urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned") AS pasp,
              FLATTEN("urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned") AS slbomasp
         FROM datalake."catenax-knowledge-agents"."CX_Testdata_v1.4.1-AsPlanned.ndjson"
    ) JSON;

DROP VIEW "TRACE_TEST_OEM".CX_TRC_PartAsPlanned;
CREATE VIEW "TRACE_TEST_OEM".CX_TRC_PartAsPlanned AS
SELECT
      catenaXId,
      bpnl,
      partTypeInformation_manufacturerPartId,
      partTypeInformation_classification,
      partTypeInformation_nameAtManufacturer,
      validityPeriod_validFrom,
      validityPeriod_validTo,
      assembly_status
 FROM $scratch.CX_TRC_PartAsPlanned;

DROP TABLE $scratch.CX_TRC_PartSiteInformationAsPlanned;
CREATE TABLE $scratch.CX_TRC_PartSiteInformationAsPlanned AS
    SELECT
        SUBSTR(SITE.catenaXId,10) as catenaXId,
        SITE.bpnl,
        SITE.site.catenaXSiteId as catenaXSiteId,
        TO_DATE(LEFT(SITE.site['functionValidFrom'],10),'YYYY-MM-DD') as functionValidFrom,
        TO_DATE(LEFT(SITE.site['functionValidUntil'],10),'YYYY-MM-DD') as functionValidUntil,
        SITE.site['function'] as "function"
    FROM (
     SELECT JSON.catenaXId,
            JSON.bpnl,
            FLATTEN(JSON.psiap.sites) as site
      FROM (
       SELECT catenaXId,
              bpnl,
              FLATTEN("urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned") AS psiap
         FROM datalake."catenax-knowledge-agents"."CX_Testdata_v1.4.1-AsPlanned.ndjson"
      ) JSON
    ) SITE;

DROP VIEW "TRACE_TEST_OEM".CX_TRC_PartSiteInformationAsPlanned;
CREATE VIEW "TRACE_TEST_OEM".CX_TRC_PartSiteInformationAsPlanned AS
SELECT
      catenaXId,
      bpnl,
      catenaXSiteId,
      functionValidFrom,
      functionValidUntil,
      "function"
 FROM $scratch.CX_TRC_PartSiteInformationAsPlanned;