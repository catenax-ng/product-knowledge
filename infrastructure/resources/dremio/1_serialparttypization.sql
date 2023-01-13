DROP VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization;
CREATE VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization AS
    SELECT
        SUBSTR(JSON.catenaXId,10) as catenaXId,
        JSON.json['localIdentifiers'][0]['value'] as localIdentifiers_manufacturerId,
        JSON.json['localIdentifiers'][2]['value'] as localIdentifiers_partInstanceId,
        JSON.json['localIdentifiers'][3]['value'] as localIdentifiers_van,
        TO_DATE(LEFT(JSON.json['manufacturingInformation']['date'],10),'YYYY-MM-DD') as manufacturingInformation_date,
        JSON.json['manufacturingInformation'].country as manufacturingInformation_country,
        JSON.json['partTypeInformation'].manufacturerPartId as partTypeInformation_manufacturerPartId,
        JSON.json['partTypeInformation'].classification as partTypeInformation_classification,
        JSON.json['partTypeInformation'].nameAtManufacturer as partTypeInformation_nameAtManufacturer
    FROM (
       SELECT catenaXId,
              FLATTEN("urn:bamm:io.catenax.serial_part_typization:1.1.0#SerialPartTypization") AS json
         FROM datalake."catenax-knowledge-agents"."CX_RUL_Testdata_v1.0.0.ndjson"
    ) JSON;

DROP TABLE $scratch.CX_RUL_SerialPartTypization_Vehicle;
CREATE TABLE $scratch.CX_RUL_SerialPartTypization_Vehicle AS
    SELECT
        catenaXId,
        localIdentifiers_manufacturerId,
        localIdentifiers_partInstanceId,
        localIdentifiers_van,
        manufacturingInformation_date,
        manufacturingInformation_country,
        partTypeInformation_manufacturerPartId,
        partTypeInformation_classification,
        partTypeInformation_nameAtManufacturer
    FROM "HI_TEST_OEM".CX_RUL_SerialPartTypization
    WHERE localIdentifiers_van IS NOT NULL;
ALTER TABLE $scratch.CX_RUL_SerialPartTypization_Vehicle ADD PRIMARY KEY (catenaXId);

DROP TABLE $scratch.CX_RUL_SerialPartTypization_Component;
CREATE TABLE $scratch.CX_RUL_SerialPartTypization_Component AS
    SELECT
        catenaXId,
        localIdentifiers_manufacturerId,
        localIdentifiers_partInstanceId,
        manufacturingInformation_date,
        manufacturingInformation_country,
        partTypeInformation_manufacturerPartId,
        partTypeInformation_classification,
        partTypeInformation_nameAtManufacturer
    FROM "HI_TEST_OEM".CX_RUL_SerialPartTypization
    WHERE localIdentifiers_van IS NULL;

DROP VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization_Vehicle;
CREATE VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization_Vehicle AS SELECT * FROM $scratch.CX_RUL_SerialPartTypization_Vehicle;
DROP VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization_Component;
CREATE VIEW "HI_TEST_OEM".CX_RUL_SerialPartTypization_Component AS SELECT * FROM $scratch.CX_RUL_SerialPartTypization_Component;
