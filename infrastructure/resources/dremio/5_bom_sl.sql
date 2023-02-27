DROP TABLE $scratch.CX_TRC_SingleLevelBomAsPlanned;
CREATE TABLE $scratch.CX_TRC_SingleLevelBomAsPlanned AS (
       SELECT
           SUBSTR(CHILDREN.catenaXId,10) as catenaXId,
           CAST(CHILDREN.child['quantity'].quantityNumber AS DOUBLE) as quantity_number,
           CHILDREN.child['quantity'].measurementUnit.lexicalValue as quantity_unit,
           TO_DATE(LEFT(CHILDREN.child['createdOn'],10),'YYYY-MM-DD') as createdOn,
           TO_DATE(LEFT(CHILDREN.child['lastModifiedOn'],10),'YYYY-MM-DD') as lastModifiedOn,
           SUBSTR(CHILDREN.child['childCatenaXId'],10) as childCatenaXId
        FROM (
            SELECT
                JSON.catenaXId,
                FLATTEN(JSON.json['childParts']) AS child
             FROM (
                SELECT
                    catenaXId,
                    FLATTEN("urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned") AS json
                 FROM datalake."catenax-knowledge-agents"."CX_Testdata_v1.5-SNAPSHOT-AsPlanned.ndjson"
             ) JSON
             WHERE JSON.json IS NOT NULL) CHILDREN
    );

DROP VIEW "TRACE_TEST_OEM".CX_TRC_SingleLevelBomAsPlanned;
CREATE VIEW "TRACE_TEST_OEM".CX_TRC_SingleLevelBomAsPlanned AS
SELECT
  catenaXId,
  quantity_number,
  quantity_unit,
  'as-planned' as lifecycle_context,
  createdOn,
  lastModifiedOn,
  childCatenaXId
 FROM $scratch.CX_TRC_SingleLevelBomAsPlanned;