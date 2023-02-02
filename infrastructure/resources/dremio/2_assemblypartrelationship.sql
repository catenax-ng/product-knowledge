DROP TABLE $scratch.CX_RUL_AssemblyPartRelationship;
CREATE TABLE $scratch.CX_RUL_AssemblyPartRelationship AS (
    SELECT
        SUBSTR(CHILDREN.catenaXId,10) as catenaXId,
        CAST(CHILDREN.child['quantity'].quantityNumber AS DOUBLE) as quantity_number,
        CHILDREN.child['quantity'].measurementUnit.lexicalValue as quantity_unit,
        CHILDREN.child['lifecycleContext'] as lifecycle_context,
        TO_DATE(LEFT(CHILDREN.child['assembledOn'],10),'YYYY-MM-DD') as assembledOn,
        TO_DATE(LEFT(CHILDREN.child['lastModifiedOn'],10),'YYYY-MM-DD') as lastModifiedOn,
        SUBSTR(CHILDREN.child['childCatenaXId'],10) as childCatenaXId
    FROM (
        SELECT
            JSON.catenaXId,
            FLATTEN(JSON.json['childParts']) AS child
         FROM (
            SELECT
                catenaXId,
                FLATTEN("urn:bamm:io.catenax.assembly_part_relationship:1.1.1#AssemblyPartRelationship") AS json
             FROM datalake."catenax-knowledge-agents"."20230124_testdata_new_bamm.ndjson"
         ) JSON
         WHERE JSON.json IS NOT NULL) CHILDREN
);

DROP VIEW "HI_TEST_OEM".CX_RUL_AssemblyPartRelationship;
CREATE VIEW "HI_TEST_OEM".CX_RUL_AssemblyPartRelationship AS SELECT * FROM $scratch.CX_RUL_AssemblyPartRelationship;

ALTER TABLE $scratch.CX_RUL_AssemblyPartRelationship ADD PRIMARY KEY (childCatenaXId,catenaXId);
