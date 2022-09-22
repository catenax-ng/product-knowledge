DROP SCHEMA IF EXISTS "report" CASCADE;
CREATE SCHEMA "report";

/*  Dummy Parts and Loadcollectives
    4 examples files: sample-input.json, Fzg1_LCollective.json, Fzg2_LCollective.json, Fzg3_LCollective.json*/
CREATE TABLE "report"."part_loadcollective" (
  "part_id" VARCHAR(64) NOT NULL PRIMARY KEY,
  "vin" VARCHAR(64) NOT NULL,
  "partName" VARCHAR(64) NOT NULL,
  "lc_id" VARCHAR(64) NOT NULL,
  "type" VARCHAR(64) NOT NULL,
  "component" VARCHAR(64) NOT NULL,
  "version" VARCHAR(64) NOT NULL,
  "counting_method" VARCHAR(64) NOT NULL,
  "counting_unit" VARCHAR(64) NOT NULL,
  "name" VARCHAR(64) NOT NULL,
  "channel_type" VARCHAR(64) NOT NULL,
  "unit" VARCHAR(64) NOT NULL,
  "lowerLimit" INT NOT NULL, 
  "upperLimit" INT NOT NULL,
  "numberOfBins" INT NOT NULL,
  "classes" VARCHAR(256) NOT NULL,
  "counts" VARCHAR(256) NOT NULL
);

INSERT INTO "report"."part_loadcollective" ("part_id", "vin", "partName", "lc_id","type", "version", "component", "counting_method","counting_unit","name","channel_type","unit","lowerLimit", "upperLimit", "numberOfBins", "classes", "counts") VALUES

  ('1', '8976543761', 'Gearbox', '1','ZF_load_collective','1.7', 'GearOil', 'ZF_TimeAtLevel','s','Temp_Oil','Load','degC', -40, 220, 52,'[1, 3, 4, 5, 7, 8, 12, 13, 17, 18, 20, 22, 23, 25, 28, 29, 31, 32, 33, 34, 36, 37, 38, 41, 42, 44, 45, 47, 48, 49, 50, 51]'
  ,'[7.234E+01, 2.345E+02, 6.654E+02, 5.983E+01, 4.321E+02, 3.876E+02, 5.567E+01, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+02, 6.098E+02, 7.432E+02, 8.873E+02, 4.738E+01, 6.927E+01, 1.234E+02, 2.345E+02, 3.654E+02, 2.983E+01, 4.321E+01, 3.876E+02, 5.567E+02, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+01, 6.098E+01, 3.432E+02, 1.873E+02, 4.738E+02, 6.927E+02]'),
  ('2', '8655389761', 'Gearbox', '2', 'ZF_load_collective','1.7', 'GearOil', 'ZF_TimeAtLevel','s','Temp_Oil','Load','degC', -40, 220, 52,'[2, 3, 4, 6, 7, 8, 12, 18, 20, 22, 23, 25, 28, 29, 31, 32, 33, 34, 36, 37, 38, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51]'
  ,'[1.234E+01, 2.345E+02, 1.654E+02, 4.321E+01, 6.098E+01, 3.432E+02, 1.873E+02, 4.738E+01, 6.927E+01, 1.234E+01, 2.345E+02, 1.654E+02, 2.983E+01, 2.983E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+01, 6.098E+01, 3.432E+02, 1.873E+02, 4.738E+01, 6.927E+01]'),
  ('3', '8532143761', 'Gearbox', '3', 'ZF_load_collective','1.7', 'GearOil', 'ZF_TimeAtLevel','s','Temp_Oil','Load','degC', -40, 220, 52,'[1, 3, 4, 5, 7, 8, 12, 13, 17, 18, 20, 22, 23, 25, 28, 29, 31, 32, 33, 34, 36, 37, 38, 41, 42, 44, 45, 47, 48, 49, 50, 51]'
  ,'[1.234E+01, 2.345E+02, 1.654E+02, 2.983E+02, 4.321E+01, 3.876E+02, 5.567E+01, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+02, 6.098E+02, 3.432E+02, 1.873E+02, 4.738E+01, 6.927E+01, 8.234E+01, 2.345E+02, 4.654E+02, 2.983E+01, 4.321E+01, 3.876E+02, 9.567E+01, 3.4456E+02, 4.556645E+02, 5.678E+01, 4.321E+02, 6.098E+01, 3.432E+02, 1.873E+02, 4.738E+01, 5.927E+01]');

/*Business Partner & Vehicle*/
CREATE TABLE "report"."businessPartner" (
  "vin" VARCHAR(64) NOT NULL PRIMARY KEY,
  "businessPartnerNummer" VARCHAR(64) NOT NULL,
  "manufacturer" VARCHAR(64) NOT NULL,
  "mileage_value" VARCHAR(64) NOT NULL, 
  "mileage_unit" VARCHAR(64) NOT NULL,
  "registrationDate_value" VARCHAR(64) NOT NULL,
  "registrationDate_unit" VARCHAR(64) NOT NULL
);

INSERT INTO "report"."businessPartner" ("vin","businessPartnerNummer", "manufacturer", "mileage_value", "mileage_unit", "registrationDate_value", "registrationDate_unit") VALUES
( '8976543761','BPNL00000003COJN',"BMW", '82563', 'km', '20171206', 'yyyymmdd' ),
( '8655389761', 'BPNL00000003COJN', "BMW", '28954', 'km', '20200814', 'yyyymmdd' ),
( '8532143761','BPNL00000003COJN', "BMW", '26475', 'km', '20191022', 'yyyymmdd' );

/*dtc*/
CREATE TABLE "report"."dtc" (
  "dtc_id" VARCHAR(64) NOT NULL PRIMARY KEY,
  "vin" VARCHAR(64) NOT NULL,
  "dtc_code_1" VARCHAR(64) NOT NULL,
  "dtc_code_2" VARCHAR(64) NOT NULL, 
  "dtc_code_3" VARCHAR(64) NOT NULL, 
);

INSERT INTO "report"."dtc" ("dtc_id","vin", "dtc_code_1", "dtc_code_2", "dtc_code_3" ) VALUES
( '8976543761','BPNL00000003COJN', 'P079C', 'P0469', 'P0470'),
( '8655389761', 'BPNL00000003COJN', 'P0472', 'P0930', 'P0000'),
( '8532143761','BPNL00000003COJN', 'P0689', 'P0473','P068A');