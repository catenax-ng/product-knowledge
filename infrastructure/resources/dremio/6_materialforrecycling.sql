DROP TABLE $scratch.CX_TRC_MaterialForRecycling;
CREATE TABLE $scratch.CX_TRC_MaterialForRecycling AS (
       SELECT
           SUBSTR(JSON.catenaXId,10) as catenaXId,
           JSON.json.materialName as material_name,
           JSON.json.materialClass as material_class
        FROM (
            SELECT
                catenaXId,
                FLATTEN("urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling") AS json
                FROM datalake."catenax-knowledge-agents"."CX_Testdata_v1.5-SNAPSHOT-AsPlanned.ndjson"
        ) JSON WHERE JSON.json IS NOT NULL
    );

DROP VIEW "TRACE_TEST_OEM".CX_TRC_MaterialForRecycling;
CREATE VIEW "TRACE_TEST_OEM".CX_TRC_MaterialForRecycling AS
SELECT
  catenaXId,
  material_name,
  material_class
 FROM $scratch.CX_TRC_MaterialForRecycling;

DROP TABLE $scratch.CX_TRC_MaterialForRecycling_Components;
CREATE TABLE $scratch.CX_TRC_MaterialForRecycling_Components AS (
       SELECT
           COMPONENTS.catenaXId as catenaXId,
           COMPONENTS.materialName as material_name,
           COMPONENTS.materialClass as material_class,
           COMPONENTS.component.aggregateState as component_aggregate_state,
           CAST(COMPONENTS.component.weight as DOUBLE) as component_weight,
           COMPONENTS.component.materialName as component_material_name,
           COMPONENTS.component.materialClass as component_material_class,
           CAST(COMPONENTS.component.recycledContent AS DOUBLE) as component_recycled_content,
           COMPONENTS.component.materialAbbreviation as component_material_abbreviation
        FROM (
            SELECT
                JSON.catenaXId,
                JSON.json.materialName,
                JSON.json.materialClass,
                FLATTEN(JSON.json['component']) AS component
             FROM (
                SELECT
                    catenaXId,
                    FLATTEN("urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling") AS json
                 FROM datalake."catenax-knowledge-agents"."CX_Testdata_v1.5-SNAPSHOT-AsPlanned.ndjson"
             ) JSON
             WHERE JSON.json IS NOT NULL) COMPONENTS
    );

DROP VIEW "TRACE_TEST_OEM".CX_TRC_MaterialForRecycling_Components;
CREATE VIEW "TRACE_TEST_OEM".CX_TRC_MaterialForRecycling_Components AS
SELECT
  catenaXId,
  material_name,
  material_class,
  component_aggregate_state,
  component_weight,
  component_material_name,
  component_material_class,
  component_recycled_content,
  component_material_abbreviation
 FROM $scratch.CX_TRC_MaterialForRecycling_Components;