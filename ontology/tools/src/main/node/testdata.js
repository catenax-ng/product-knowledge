/**
 * Template for test generation
 */
const JG = require('./JG');
const moment = require('./moment');

/*
 * read the former testdata
 */
var testDataContainer=JG.readFile('tools/src/main/resources/CX_Testdata_v1.4.1-AsPlanned.json');
var testData = testDataContainer['https://catenax.io/schema/TestDataContainer/1.0.0'];
var testHeader = testData[0];
var plainObject=testHeader.PlainObject[0];
var UIDPOOL = JSON.parse(plainObject.UIDPOOL.replaceAll("'",'"'));
var testObjects = testData.slice(1);
var twins={};
for(twinId in testObjects) {
    var twin=testObjects[twinId];
    twins[twin.catenaXId]=twin;
}

/* manipulate test data */
plainObject['BPN_SUB_TIER_D']='BPNL00000007OR16';
plainObject['BPN_N_TIER_D']='BPNL00000003CSGV';
plainObject['BPN_TIER_A_SITE_B']='BPNS0000000006V6';
plainObject['BPN_SUB_TIER_D_SITE_A']='BPNS0000000002XY';
plainObject['BPN_N_TIER_D_SITE_A']='BPNS000000000DQB';

for(var id in twins){
    twin=twins[id];
    var childs=0;
    var bom=twin["urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned"];
    if(bom != undefined && bom.length>0) {
        childs=bom[0].childParts.length;
    }
    var part=twin["urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"];
    var materialName=JG.loremIpsum({units: 'words', count: 1});
    var materialClass=JG.materialClass();
    if(part!= undefined && part.length>0 && part[0].partTypeInformation.nameAtManufacturer.includes('Cathode')) {
        materialName='Automotive Cell Cathode Material';
        materialClass='CathodeMaterial_LithiumNickelManganeseCobaltOxides';
    }
    twin["urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling"] = [ {
        "materialName" : materialName,
        "materialClass" : materialClass,
        "component" : JG.repeat(1,childs+1, function() {
        return {
            "aggregateState" : JG.random("solid", "liquid", "gasenous"),
            "weight" : JG.floating(1, 1000, 3),
            "materialName" : JG.loremIpsum({units: 'words', count: 1}),
            "recycledContent" : JG.floating(1, 1000, 3),
            "materialClass" : JG.materialClass(),
            "materialAbbreviation" : JG.objectId()
            };
         })
      } ];
}

var nrubberId=JG.guid();
UIDPOOL.push(`urn:uuid:${nrubberId}`);
var nrubber= {
      "catenaXId": `urn:uuid:${nrubberId}`,
      "bpnl": plainObject['BPN_N_TIER_D'],
      "urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned": [
       {
          "validityPeriod": {
            "validFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
            "validTo": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ')
          },
          "catenaXId": `urn:uuid:${nrubberId}`,
          "partTypeInformation": {
            "manufacturerPartId": "NR-1",
            "classification": "raw material",
            "nameAtManufacturer": "Natural Rubber"
          }
        }
      ],
      "urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned": [
        {
          "catenaXId": `urn:uuid:${nrubberId}`,
          "sites": [
            {
              "functionValidUntil": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "function": "production",
              "functionValidFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "catenaXSiteId": plainObject['BPN_N_TIER_D_SITE_A']
            }
          ]
        }
      ],
      "urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned": [
        {
          "catenaXId": `urn:uuid:${nrubberId}`,
          "childParts": [
          ]
        }
      ],
      "urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling": [ {
              "materialName" : "Natural Rubber Class 5",
              "materialClass" : "OrganicMaterial_Rubber"
            } ]
    };

twins[nrubber.catenaXId]=nrubber;

var rubberId=JG.guid();
UIDPOOL.push(`urn:uuid:${rubberId}`);
var rubber= {
      "catenaXId": `urn:uuid:${rubberId}`,
      "bpnl": plainObject['BPN_SUB_TIER_D'],
      "urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned": [
       {
          "validityPeriod": {
            "validFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
            "validTo": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ')
          },
          "catenaXId": `urn:uuid:${rubberId}`,
          "partTypeInformation": {
            "manufacturerPartId": "SR-17",
            "classification": "material",
            "nameAtManufacturer": "Synthetic Wheel Rubber"
          }
        }
      ],
      "urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned": [
        {
          "catenaXId": `urn:uuid:${rubberId}`,
          "sites": [
            {
              "functionValidUntil": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "function": "production",
              "functionValidFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "catenaXSiteId": plainObject['BPN_SUB_TIER_D_SITE_A']
            }
          ]
        }
      ],
      "urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned": [
        {
          "catenaXId": `urn:uuid:${rubberId}`,
          "childParts": [
            {
              "quantity": {
                "quantityNumber": "4.2",
                "measurementUnit": {
                  "datatypeURI": "urn:bamm:io.openmanufacturing:meta-model:1.0.0#curie",
                  "lexicalValue": "unit:kilogram"
                }
              },
              "createdOn": moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "lastModifiedOn": moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "childCatenaXId": `urn:uuid:${nrubberId}`
            }
          ]
        }
      ],
      "urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling": [ {
         "materialName" : "Synthetic Rubber Class 3",
         "materialClass" : "PolymerMaterial_Rubber",
         "component" : [ {
            "aggregateState" : "solid",
            "weight" : "4.2",
            "materialName" : "Natural Rubber Class 5",
            "recycledContent" : "0.2",
            "materialClass" : "OrganicMaterial_Rubber",
            "materialAbbreviation" : "NR"
           } ]
      } ]
    };

twins[rubber.catenaXId]=rubber;

var wheelId=JG.guid();
UIDPOOL.push(`urn:uuid:${wheelId}`);
var wheel= {
      "catenaXId": `urn:uuid:${wheelId}`,
      "bpnl": plainObject['BPN_TIER_A'],
      "urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned": [
       {
          "validityPeriod": {
            "validFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
            "validTo": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ')
          },
          "catenaXId": `urn:uuid:${wheelId}`,
          "partTypeInformation": {
            "manufacturerPartId": "TIRED-OF-TIER-HMS20",
            "classification": "product",
            "nameAtManufacturer": "All-Season Flatrun Tire 20inch"
          }
        }
      ],
      "urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned": [
        {
          "catenaXId": `urn:uuid:${wheelId}`,
          "sites": [
            {
              "functionValidUntil": moment(JG.date(new Date(2020, 0, 1), new Date(2030, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "function": "production",
              "functionValidFrom": moment(JG.date(new Date(2018, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "catenaXSiteId": plainObject['BPN_TIER_A_SITE_B']
            }
          ]
        }
      ],
      "urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned": [
        {
          "catenaXId": `urn:uuid:${wheelId}`,
          "childParts": [
            {
              "quantity": {
                "quantityNumber": "3.2",
                "measurementUnit": {
                  "datatypeURI": "urn:bamm:io.openmanufacturing:meta-model:1.0.0#curie",
                  "lexicalValue": "unit:kilogram"
                }
              },
              "createdOn": moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "lastModifiedOn": moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
              "childCatenaXId": `urn:uuid:${rubberId}`
            }
          ]
        }
      ],
      "urn:bamm:io.catenax.material_for_recycling:1.1.0#MaterialForRecycling": [ {
         "materialName" : "Wheel Rubber",
         "materialClass" : "PolymerMaterial",
         "component" : [ {
            "aggregateState" : "solid",
            "weight" : "3.2",
            "materialName" : "Synthetic Rubber Class 3",
            "recycledContent" : "0.2",
            "materialClass" : "PolymerMaterial_Rubber",
            "materialAbbreviation" : "SR"
          } ]
       } ]
    };

twins[wheel.catenaXId]=wheel;
for(var id in twins){
    twin=twins[id];
    var name=twin["urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"][0].partTypeInformation.nameAtManufacturer;
    if(name.includes("Vehicle Model B") || name.includes("Vehicle Model C")) {
        var children=twin["urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned"][0].childParts;
        children.push( {
            "quantity" : {
              "quantityNumber" : "4",
              "measurementUnit" : {
                 "datatypeURI" : "urn:bamm:io.openmanufacturing:meta-model:1.0.0#curie",
                 "lexicalValue" : "unit:piece"
              }
            },
            "createdOn" : moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
            "lastModifiedOn" : moment(JG.date(new Date(2022, 0, 1), new Date(2023, 0, 1))).format('YYYY-MM-DDTHH:mm:sssZ'),
            "childCatenaXId" : `urn:uuid:${wheelId}`
       });
    }
}

/** Recollect and write */
testObjects=[];
for(var id in twins){
    testObjects.push(twins[id]);
}

for(let i = 0; i < 0; i++) {
    var clones={};
    for(var id in twins) {
        clones[id]=`urn:uuid:${JG.guid()}`;
        UIDPOOL.push(clones[id]);
    }
    for(var id in twins) {
        var twin=JSON.parse(JSON.stringify(twins[id]));
        twin.catenaXId=clones[id];
        var aspect=twin["urn:bamm:io.catenax.part_as_planned:1.0.0#PartAsPlanned"][0];
        aspect.catenaXId=clones[id];
        aspect.partTypeInformation.manufacturerPartId=aspect.partTypeInformation.manufacturerPartId+i;
        aspect.partTypeInformation.nameAtManufacturer=aspect.partTypeInformation.nameAtManufacturer+i;
        var aspect=twin["urn:bamm:io.catenax.part_site_information_as_planned:1.0.0#PartSiteInformationAsPlanned"][0];
        aspect.catenaXId=clones[id];
        var aspect=twin["urn:bamm:io.catenax.single_level_bom_as_planned:1.0.2#SingleLevelBomAsPlanned"][0];
        aspect.catenaXId=clones[id];
        for(var childId in aspect.childParts) {
            var child=aspect.childParts[childId];
            child.childCatenaXId=clones[child.childCatenaXId];
        }
        testObjects.push(twin);
    }
}

plainObject.UIDPOOL=JSON.stringify(UIDPOOL).replaceAll('"',"'");
testObjects.unshift(testHeader);
testDataContainer={};
testDataContainer['https://catenax.io/schema/TestDataContainer/1.0.0']=testObjects;
JG.writeFile('tools/src/test/resources/CX_Testdata_v1.5-SNAPSHOT-AsPlanned.json',testDataContainer);


