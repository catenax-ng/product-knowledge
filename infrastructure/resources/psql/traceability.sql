DROP TABLE IF EXISTS "CX_TRC_MaterialForRecycling_Components";
DROP TABLE IF EXISTS "CX_TRC_MaterialForRecycling";
DROP TABLE IF EXISTS "CX_TRC_SingleLevelBomAsPlanned";
DROP TABLE IF EXISTS "CX_TRC_PartSiteInformationAsPlanned";
DROP TABLE IF EXISTS "CX_TRC_PartAsPlanned";

CREATE TABLE "CX_TRC_PartAsPlanned" (
      "catenaXId" VARCHAR(64) NOT NULL PRIMARY KEY,
      "bpnl" VARCHAR(16) NOT NULL,
      "partTypeInformation_manufacturerPartId" VARCHAR(128) NOT NULL,
      "partTypeInformation_classification" VARCHAR(20) NOT NULL,
      "partTypeInformation_nameAtManufacturer" VARCHAR(256) NOT NULL,
      "validityPeriod_validFrom" DATE NOT NULL,
      "validityPeriod_validTo" DATE,
      "assembly_status" INTEGER NOT NULL
);

COPY "CX_TRC_PartAsPlanned"("catenaXId", "bpnl", "partTypeInformation_manufacturerPartId", "partTypeInformation_classification", "partTypeInformation_nameAtManufacturer", "validityPeriod_validFrom", "validityPeriod_validTo", "assembly_status")
FROM '/tmp/data/CX_TRC_PartAsPlanned.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE "CX_TRC_PartSiteInformationAsPlanned" (
      "catenaXId" VARCHAR(64) NOT NULL PRIMARY KEY,
      "bpnl" VARCHAR(16) NOT NULL,
      "catenaXSiteId" VARCHAR(16) NOT NULL,
      "functionValidFrom" DATE NOT NULL,
      "functionValidUntil" DATE,
      "function" VARCHAR(20) NOT NULL,
      FOREIGN KEY ("catenaXId") REFERENCES "CX_TRC_PartAsPlanned"("catenaXId")
);

COPY "CX_TRC_PartSiteInformationAsPlanned"("catenaXId", "bpnl", "catenaXSiteId", "functionValidFrom", "functionValidUntil", "function")
FROM '/tmp/data/CX_TRC_PartSiteInformationAsPlanned.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE "CX_TRC_SingleLevelBomAsPlanned" (
  "catenaXId" VARCHAR(64) NOT NULL,
  "quantity_number" DOUBLE PRECISION NOT NULL,
  "quantity_unit" VARCHAR(64) NOT NULL,
  "lifecycle-context" VARCHAR(20) NOT NULL,
  "created_on" DATE NOT NULL,
  "last_modified_on" DATE NOT NULL,
  "childCatenaXId" VARCHAR(64) NOT NULL,
  PRIMARY KEY ( "catenaXId", "childCatenaXId"),
  FOREIGN KEY ("catenaXId") REFERENCES "CX_TRC_PartAsPlanned"("catenaXId"),
  FOREIGN KEY ("childCatenaXId") REFERENCES "CX_TRC_PartAsPlanned"("catenaXId")
);

COPY "CX_TRC_SingleLevelBomAsPlanned"("catenaXId", "quantity_number", "quantity_unit", "lifecycle-context", "created_on", "last_modified_on", "childCatenaXId")
FROM '/tmp/data/CX_TRC_SingleLevelBomAsPlanned.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE "CX_TRC_MaterialForRecycling" (
  "catenaXId" VARCHAR(64) NOT NULL,
  "material_name" VARCHAR(128) NOT NULL,
  "material_class" VARCHAR(128),
  PRIMARY KEY ( "catenaXId", "material_name"),
  FOREIGN KEY ("catenaXId") REFERENCES "CX_TRC_PartAsPlanned"("catenaXId")
);

COPY "CX_TRC_MaterialForRecycling"("catenaXId", "material_name", "material_class")
FROM '/tmp/data/CX_TRC_MaterialForRecycling.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE "CX_TRC_MaterialForRecycling_Components" (
  "catenaXId" VARCHAR(64) NOT NULL,
  "material_name" VARCHAR(128) NOT NULL,
  "material_class" VARCHAR(128),
  "component_aggregate_state" VARCHAR(20) NOT NULL,
  "component_weight" DOUBLE PRECISION NOT NULL,
  "component_material_name" VARCHAR(128) NOT NULL,
  "component_material_class" VARCHAR(128),
  "component_recycled_content" DOUBLE PRECISION NOT NULL,
  "component_material_abbreviation" VARCHAR(32) NOT NULL,
  PRIMARY KEY ( "catenaXId", "material_name", "component_material_name"),
  FOREIGN KEY ("catenaXId", "material_name") REFERENCES "CX_TRC_MaterialForRecycling"("catenaXId", "material_name"),
  FOREIGN KEY ("catenaXId") REFERENCES "CX_TRC_PartAsPlanned"("catenaXId")
);

COPY "CX_TRC_MaterialForRecycling_Components"("catenaXId", "material_name", "material_class", "component_aggregate_state", "component_weight", "component_material_name", "component_material_class", "component_recycled_content", "component_material_abbreviation")
FROM '/tmp/data/CX_TRC_MaterialForRecycling_Components.csv'
DELIMITER ','
CSV HEADER;