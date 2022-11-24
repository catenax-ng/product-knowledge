DROP SCHEMA IF EXISTS "dtc" CASCADE;
CREATE SCHEMA IF NOT EXISTS "dtc";

CREATE TABLE IF NOT EXISTS "dtc"."meta" (
  "bpnl" varchar(17) NOT NULL,
  "first" BOOLEAN NOT NULL,
  "last" BOOLEAN NOT NULL,
  "number" INT NOT NULL,
  "number_of_elements" INT NOT NULL,
  "size" INT NOT NULL,
  "total_elements" INT NOT NULL,
  "total_pages" INT NOT NULL,
  PRIMARY KEY ("bpnl", "number")
);
MERGE INTO "dtc"."meta" VALUES
  ('BPNL00000003COJN',true,true,0,2555,30000,2555,1);

CREATE TABLE IF NOT EXISTS "dtc"."content" (
  "bpnl" varchar(17) NOT NULL,
  "number" INT NOT NULL,
  "id" VARCHAR(64) NOT NULL PRIMARY KEY,
  "code" VARCHAR(10) NOT NULL,
  "description" VARCHAR(256) NOT NULL,
  "possible_causes" VARCHAR(256) NOT NULL,
  "created_at" VARCHAR(64) NOT NULL,
  "lock_version" INT NOT NULL,
  FOREIGN KEY ("bpnl","number") REFERENCES "dtc"."meta"("bpnl","number")
);
MERGE INTO  "dtc"."content" VALUES
  ('BPNL00000003COJN',0,'aafbc999-1157-44aa-a395-d1a62ddf93d5','P0000','Keinen Fehler gefunden','-','2022-05-11T11:16:13.724169Z',0),
  ('BPNL00000003COJN',0,'9573c2a6-9c2e-4983-818b-89bd76032735','P0001','Steuerkreis Kraftstoffvolumenregler - offener Stromkreis','Kabelbaum, Regelmagnetventil','2022-05-11T11:16:13.913631Z',0),
  ('BPNL00000003COJN',0,'2be3578e-2b51-4b8d-92b6-2fc752314a13','P0002','Steuerkreis Kraftstoffvolumenregler - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Regelmagnetventil','2022-05-11T11:16:13.927145Z',0),
  ('BPNL00000003COJN',0,'9fe16ce0-410c-4fb0-b840-93e8a0cd8eee','P0003','Steuerkreis Kraftstoffvolumenregler - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Regelmagnetventil','2022-05-11T11:16:13.933045Z',0),
  ('BPNL00000003COJN',0,'f3898483-6c89-4e45-b187-90fcee2554a6','P0004','Steuerkreis Kraftstoffvolumenregler - Signal zu hoch','Kabelbaum unterbrochen/Kurzschluss an Plus, Regelmagnetventil','2022-05-11T11:16:13.938835Z',0),
  ('BPNL00000003COJN',0,'6e4d5a1c-a464-4de2-a999-e8deac78d797','P0005','Kraftstoffabschalt-Magnetventil - offener Stromkreis','Kabelbaum unterbrochen, Kraftstoffabschalt-Magnetventil','2022-05-11T11:16:13.945285Z',0),
  ('BPNL00000003COJN',0,'2afd3fda-a5c5-4df2-8283-3f2dec03909b','P0006','Kraftstoffabschalt-Magnetventil - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffabschalt-Magnetventil','2022-05-11T11:16:13.950727Z',0),
  ('BPNL00000003COJN',0,'a531794c-eb14-4e3d-bf0f-24ccd4f2ddd6','P0007','Kraftstoffabschalt-Magnetventil - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffabschalt-Magnetventil','2022-05-11T11:16:13.955737Z',0),
  ('BPNL00000003COJN',0,'d1f00732-7955-4c12-9a13-34f2160a1f66','P0008','Motorsteuerzeiten, Zylinderreihe 1 - Motorleistung','Mechanische Fehlfunktion','2022-05-11T11:16:13.960952Z',0),
  ('BPNL00000003COJN',0,'7cecbc13-10d6-47a3-9d84-01975f0b8486','P0009','Motorsteuerzeiten, Zylinderreihe 2 - Motorleistung','Mechanische Fehlfunktion','2022-05-11T11:16:13.969871Z',0),
  ('BPNL00000003COJN',0,'8ed80f96-405a-4c25-a6c1-33e59879e32e','P000A','Einlassnockenwellenstellung A, Zylinderreihe 1 - träges Ausregelverhalten','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:13.975126Z',0),
  ('BPNL00000003COJN',0,'68d0417e-c15d-4704-89c8-e175a9d383fa','P000B','Auslassnockenwellenstellung B, Zylinderreihe 1 - träges Ausregelverhalten','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:13.980417Z',0),
  ('BPNL00000003COJN',0,'a5c1c7c9-b6d5-4b8e-b196-dee5041e210c','P000C','Einlassnockenwellenstellung A, Zylinderreihe 2 - träges Ausregelverhalten','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:13.985450Z',0),
  ('BPNL00000003COJN',0,'7ae77ed6-c6d5-49b5-8df2-bb264bd95cfd','P000D','Auslassnockenwellenstellung B, Zylinderreihe 2 - träges Ausregelverhalten','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:13.990467Z',0),
  ('BPNL00000003COJN',0,'dc5195a0-0ec0-455d-b449-5cb339f7852e','P000E','Kraftstoffmengenregler Regelung - Grenzwert der Parameteradaption überschritten','Kabelbaum, Kraftstoffmengenregler, Einspritzventile/-düsen, Motorsteuergerät','2022-05-11T11:16:13.995208Z',0),
  ('BPNL00000003COJN',0,'0abb4b66-5176-4715-b21d-da7449963331','P000F','Überdruckventil im Kraftstoffsystem aktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.000569Z',0),
  ('BPNL00000003COJN',0,'aa7325ea-d430-4926-a75b-33f63b93a1a6','P0010','Nockenwellensteller, einlassseitig/links/vorn, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellensteller, Motorsteuergerät','2022-05-11T11:16:14.005862Z',0),
  ('BPNL00000003COJN',0,'67784149-f6c7-4f89-8c2e-6f3818a3c99c','P0011','Nockenwellenstellung, einlassseitig/links/vorn, Zylinderreihe 1 - übermäßige Frühverstellung/Funktionsfehler','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.011020Z',0),
  ('BPNL00000003COJN',0,'f9c933e0-d9b3-4602-8cba-de28afe1a9eb','P0012','Nockenwellenstellung, einlassseitig/links/vorn, Zylinderreihe 1 - übermäßige Spätverstellung','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.016196Z',0),
  ('BPNL00000003COJN',0,'2107d2d7-cdc8-4444-bd0f-a87a00e0c070','P0013','Nockenwellensteller, einlassseitig/links/vorn, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellensteller, Motorsteuergerät','2022-05-11T11:16:14.021743Z',0),
  ('BPNL00000003COJN',0,'5f6f4500-2c02-4898-8b7c-0bd8b9e34dc7','P0014','Nockenwellensteller, auslassseitig/rechts/hinten, Zylinderreihe 1 - übermäßige Frühverstellung/Funktionsfehler','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.026992Z',0),
  ('BPNL00000003COJN',0,'1322a79c-9f88-4e39-ac76-489da82de0f9','P0015','Nockenwellensteller, auslassseitig/rechts/hinten, Zylinderreihe 1 - übermäßige Spätverstellung','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.032946Z',0),
  ('BPNL00000003COJN',0,'a48bf23c-c92d-47d7-9209-9edcc8199d11','P0016','Kurbelwellenstellung/Nockenwellenstellung, Zylinderreihe 1 Sensor A - Bezugsfehler','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:14.038137Z',0),
  ('BPNL00000003COJN',0,'7ccc94bf-796c-4cfa-9e59-a9d306a64775','P0017','Kurbelwellenstellung/Nockenwellenstellung, Zylinderreihe 1 Sensor B - Bezugsfehler','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:14.043541Z',0),
  ('BPNL00000003COJN',0,'28bf8789-074a-4f19-9afe-b5e303eca9bf','P0018','Kurbelwellenstellung/Nockenwellenstellung, Zylinderreihe 2 Sensor A - Bezugsfehler','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:14.048582Z',0),
  ('BPNL00000003COJN',0,'0bd5f518-6876-4d6c-9083-d5ab78fb5972','P0019','Kurbelwellenstellung/Nockenwellenstellung, Zylinderreihe 2 Sensor B - Bezugsfehler','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:14.053731Z',0),
  ('BPNL00000003COJN',0,'99184a27-f88c-4d30-9cd9-532a9467088d','P001A','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 1 - offener Stromkreis','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.058453Z',0),
  ('BPNL00000003COJN',0,'ce7f4a42-4c61-456f-a56c-448bf054be37','P001B','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 1 - Signal zu niedrig','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:14.063720Z',0),
  ('BPNL00000003COJN',0,'ece1c117-b26a-4416-8a83-668009aeb93f','P001C','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 1 - Signal zu hoch','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.070687Z',0),
  ('BPNL00000003COJN',0,'8cf9da91-c3df-467e-a4df-c4ea0268ce6b','P001D','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 2 - offener Stromkreis','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.076124Z',0),
  ('BPNL00000003COJN',0,'fb5da26b-f060-40f3-b03e-d3436301972f','P001E','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.081573Z',0),
  ('BPNL00000003COJN',0,'f1c535de-b6ae-45d2-9218-2bc0a0a929d0','P001F','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:14.087354Z',0),
  ('BPNL00000003COJN',0,'01cd77a0-0632-4efc-ba4e-83b056ec8d5f','P0020','Nockenwellensteller, einlassseitig/links/vorn, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellensteller, Motorsteuergerät','2022-05-11T11:16:14.093292Z',0),
  ('BPNL00000003COJN',0,'3a43175e-069f-4db9-b9ca-4eb06ac1acb7','P0021','Nockenwellenstellung, einlassseitig/links/vorn, Zylinderreihe 2 - übermäßige Frühverstellung/Funktionsfehler','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.098995Z',0),
  ('BPNL00000003COJN',0,'fb9384ab-3068-4fba-9e55-833e5d056274','P0022','Nockenwellenstellung, einlassseitig/links/vorn, Zylinderreihe 2 - übermäßige Spätverstellung','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.104429Z',0),
  ('BPNL00000003COJN',0,'74a7c7a6-b6bc-4453-a5ce-5c4080f4cba3','P0023','Nockenwellensteller, auslassseitig/rechts/hinten, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellensteller, Motorsteuergerät','2022-05-11T11:16:14.109753Z',0),
  ('BPNL00000003COJN',0,'ec88ab7d-9728-472a-83d4-b4b71ff31fd2','P0024','Nockenwellenstellung, auslassseitig/rechts/hinten, Zylinderreihe 2 - übermäßige Frühverstellung/Funktionsfehler','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.114997Z',0),
  ('BPNL00000003COJN',0,'3f7863b1-3670-4f57-9df4-a62b5a811a59','P0025','Nockenwellenstellung, auslassseitig/rechts/hinten, Zylinderreihe 2 - übermäßige Spätverstellung','Ventilsteuerzeiten, mechanische Motorstörung, Nockenwellensteller','2022-05-11T11:16:14.119961Z',0),
  ('BPNL00000003COJN',0,'78e67690-e1fd-446c-b81b-5ffd643b7c9d','P0026','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 1 - Bereichs-/Funktionsfehler','Kabelbaum, Magnetventil Einlassnockenwellenverstellung','2022-05-11T11:16:14.124967Z',0),
  ('BPNL00000003COJN',0,'cf16993b-996e-4bcd-b5d9-f1784b89a0e7','P0027','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 1 - Bereichs-/Funktionsfehler','Kabelbaum, Magnetventil Auslassnockenwellenverstellung','2022-05-11T11:16:14.130018Z',0),
  ('BPNL00000003COJN',0,'810a040d-f2e8-4fce-b207-ed0352f15ee4','P0028','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 2 - Bereichs-/Funktionsfehler','Kabelbaum, Magnetventil Einlassnockenwellenverstellung','2022-05-11T11:16:14.152997Z',0),
  ('BPNL00000003COJN',0,'90a8a87f-44a4-4299-8d1f-38c1f40b288a','P0029','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 2 - Bereichs-/Funktionsfehler','Kabelbaum, Magnetventil Auslassnockenwellenverstellung','2022-05-11T11:16:14.164001Z',0),
  ('BPNL00000003COJN',0,'7632a54a-3a75-48e2-bc7a-d746eee601cb','P002A','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 1 - offener Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:14.172059Z',0),
  ('BPNL00000003COJN',0,'86ef1dcc-1d8b-42f8-8b5a-2df129a1e356','P002B','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 1 - Signal zu niedrig','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:14.178818Z',0),
  ('BPNL00000003COJN',0,'c84dff8e-50d7-45f4-a530-887ab66e2e1f','P002C','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 1 - Signal zu hoch','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.184007Z',0),
  ('BPNL00000003COJN',0,'abfd397e-add2-4f88-bd05-ad32ed7ce128','P002D','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 2 - offener Stromkreis','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.191538Z',0),
  ('BPNL00000003COJN',0,'233dd0a1-dc39-413b-a6e1-da519ac3f007','P002E','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.196923Z',0),
  ('BPNL00000003COJN',0,'e86f9dda-1fcd-4d6a-9bc7-020b10bd5660','P002F','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.203034Z',0),
  ('BPNL00000003COJN',0,'1ca18631-05d8-4d85-b6f0-a0c6b44d5123','P0030','Beheizte Lambdasonde 1, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.209021Z',0),
  ('BPNL00000003COJN',0,'9d0f8036-9ce3-4bec-9bab-6a0bb917d700','P0031','Beheizte Lambdasonde 1, Zylinderreihe 1, Heizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.214623Z',0),
  ('BPNL00000003COJN',0,'cea56ff4-5b91-4eb2-befe-6e43dab43d53','P0032','Beheizte Lambdasonde 1, Zylinderreihe 1, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.219816Z',0),
  ('BPNL00000003COJN',0,'8439e2a5-7452-4df5-be12-8d85b2de021f','P0033','Turbolader-Bypassventil - Fehlfunktion Stromkreis','Kabelbaum, Ladedruck-Regelventil, Motorsteuergerät','2022-05-11T11:16:14.224935Z',0),
  ('BPNL00000003COJN',0,'60cfdcb1-c381-49c6-969a-cb40eb45c658','P0034','Turbolader-Bypassventil - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Ladedruck-Regelventil, Motorsteuergerät','2022-05-11T11:16:14.230075Z',0),
  ('BPNL00000003COJN',0,'40ad9c4f-edc0-4758-b800-08e4f49aa2f7','P0035','Turbolader-Bypassventil - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Ladedruck-Regelventil, Motorsteuergerät','2022-05-11T11:16:14.237943Z',0),
  ('BPNL00000003COJN',0,'6c35326d-06f8-475f-ac21-b8881cef8bc1','P0036','Beheizte Lambdasonde 2, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.243429Z',0),
  ('BPNL00000003COJN',0,'93533ba2-6156-4b63-8182-8fa88a7f7c7c','P0037','Beheizte Lambdasonde 2, Zylinderreihe 1, Heizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.248759Z',0),
  ('BPNL00000003COJN',0,'19341da2-31ee-4b34-986a-81acfcbb8049','P0038','Beheizte Lambdasonde 2, Zylinderreihe 1, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.254634Z',0),
  ('BPNL00000003COJN',0,'1f512c34-059c-4d89-8817-3d24363bc14e','P0039','Turbolader-Bypassventil/Motoraufladungskompressor-Bypassventil, Regelung - Bereichs-/Funktionsfehler','Kabelbaum, Bypassventil','2022-05-11T11:16:14.260180Z',0),
  ('BPNL00000003COJN',0,'92d2748d-a2d1-48ce-a6fc-eefb4136782e','P003A','Turbo-/Kompressorladedruckregelung A - Grenzwert der Parameteradaption überschritten','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.265725Z',0),
  ('BPNL00000003COJN',0,'c0f05974-b9af-4520-8b6d-2ddb74213cc5','P003B','Turbo-/Kompressorladedruckregelung B - Grenzwert der Parameteradaption überschritten','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.272309Z',0),
  ('BPNL00000003COJN',0,'1e49ae8d-261c-48cc-852b-b114b1dc3518','P003C','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 1 - Fehlfunktion oder ständig deaktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.277906Z',0),
  ('BPNL00000003COJN',0,'d4d32443-dce9-41d6-b94d-4a092fba75f1','P003D','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 1 - ständig aktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.283611Z',0),
  ('BPNL00000003COJN',0,'8d4ce1ea-2842-43a3-9c79-78cb06443c9f','P003E','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 2 - beeinträchtigte Funktion oder ständig deaktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.288810Z',0),
  ('BPNL00000003COJN',0,'fddb281d-7e69-42fe-9659-30d6c04cc881','P003F','Nockenprofilsteuerung Einlassnockenwelle A, Zylinderreihe 2 - ständig aktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.294404Z',0),
  ('BPNL00000003COJN',0,'8c14505b-61ca-48c4-814f-5f942df82737','P0040','Lambdasonden-Signale vertauscht, Zylinderreihe 1 Sensor 1/Zylinderreihe 2 Sensor 1','Kabelbaum','2022-05-11T11:16:14.306840Z',0),
  ('BPNL00000003COJN',0,'eae34c6d-66e4-43ed-b1c0-e23a86143afd','P0041','Lambdasonden-Signale vertauscht, Zylinderreihe 1 Sensor 2/Zylinderreihe 2 Sensor 2','Kabelbaum','2022-05-11T11:16:14.315271Z',0),
  ('BPNL00000003COJN',0,'150822f7-36a3-486e-960c-4491c82119f4','P0042','Beheizte Lambdasonde 3, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.322847Z',0),
  ('BPNL00000003COJN',0,'d8112a2b-38fa-41e6-9ba9-f1aaaea37b49','P0043','Beheizte Lambdasonde 3, Zylinderreihe 1, Heizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.327684Z',0),
  ('BPNL00000003COJN',0,'e81e39a8-d354-48b5-ae6b-74640d3bd450','P0044','Beheizte Lambdasonde 3, Zylinderreihe 1, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.334575Z',0),
  ('BPNL00000003COJN',0,'b29324a0-37c1-4b13-ad0b-e9334bb52890','P0045','Turbolader-Regelmagnetventil/Motoraufladungskompressor-Regelmagnetventil - offener Stromkreis','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil','2022-05-11T11:16:14.341542Z',0),
  ('BPNL00000003COJN',0,'81410616-b3da-4708-8926-fc0d9112e33d','P0046','Turbolader-Regelmagnetventil/Motoraufladungskompressor-Regelmagnetventil - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, mechanische Fehlfunktion','2022-05-11T11:16:14.346723Z',0),
  ('BPNL00000003COJN',0,'c8575816-f79e-469c-9c3e-bd30a3ea2cad','P0047','Turbolader-Regelmagnetventil/Motoraufladungskompressor-Regelmagnetventil - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil','2022-05-11T11:16:14.352422Z',0),
  ('BPNL00000003COJN',0,'c2f28205-c609-4613-87f6-3f399679fb56','P0048','Turbolader-Regelmagnetventil/Motoraufladungskompressor-Regelmagnetventil - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil','2022-05-11T11:16:14.358049Z',0),
  ('BPNL00000003COJN',0,'3a6399b6-d380-4e1e-859d-fc89720f830d','P0049','Turbinenrad Turbolader/Aufladungskompressor - Überdrehzahl','Mechanische Fehlfunktion','2022-05-11T11:16:14.364067Z',0),
  ('BPNL00000003COJN',0,'d83105fe-1ca5-4ad8-8437-1ce16788c9b8','P004A','Turbo-/Kompressorladedruckregelung B - offener Stromkreis','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.371140Z',0),
  ('BPNL00000003COJN',0,'b3dbaf74-067b-4fe0-be4e-707bc6ea084b','P004B','Turbo-/Kompressorladedruckregelung B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.376713Z',0),
  ('BPNL00000003COJN',0,'e3dedf70-cc72-4725-b282-ba91f9f2f38f','P004C','Turbo-/Kompressorladedruckregelung B - Signal zu niedrig','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.382016Z',0),
  ('BPNL00000003COJN',0,'95002715-7aef-42f9-bf26-f608d7c73d01','P004D','Turbo-/Kompressorladedruckregelung B - Signal zu hoch','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.388021Z',0),
  ('BPNL00000003COJN',0,'863796d0-bab0-455a-9c5d-90cd52a04d5c','P004E','Turbo-/Kompressorladedruckregelung A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.393844Z',0),
  ('BPNL00000003COJN',0,'aeb9af89-2f5a-4ed5-a69e-413f9b800ba5','P004F','Turbo-/Kompressorladedruckregelung B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.399815Z',0),
  ('BPNL00000003COJN',0,'ddb133dd-9d61-477b-8064-9987896d017a','P0050','Beheizte Lambdasonde 1, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.410321Z',0),
  ('BPNL00000003COJN',0,'846a483f-f909-48a2-a75c-b286ac7c5aca','P0051','Beheizte Lambdasonde 1, Zylinderreihe 2, Heizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.415602Z',0),
  ('BPNL00000003COJN',0,'ee3f0074-4267-4475-89ac-d5061c3eea9a','P0052','Beheizte Lambdasonde 1, Zylinderreihe 2, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.421250Z',0),
  ('BPNL00000003COJN',0,'536bcb5b-7b0c-421f-9486-d585e9389ad3','P0053','Beheizte Lambdasonde, Zylinderreihe 1, Sensor 1 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.426834Z',0),
  ('BPNL00000003COJN',0,'9529663b-0342-44a5-bb6d-a47bc1d8d7fe','P0054','Beheizte Lambdasonde, Zylinderreihe 1, Sensor 2 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.432406Z',0),
  ('BPNL00000003COJN',0,'60df1659-1deb-4161-876c-e58ac24463d5','P0055','Beheizte Lambdasonde, Zylinderreihe 1, Sensor 3 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.437947Z',0),
  ('BPNL00000003COJN',0,'851225f7-c73b-42aa-b731-f8e87427b213','P0056','Beheizte Lambdasonde 2, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.445006Z',0),
  ('BPNL00000003COJN',0,'614ba012-09f8-434b-a1d6-91478db1a564','P0057','Beheizte Lambdasonde 2, Zylinderreihe 2, Heizregelung - Heizstromkreis Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.450871Z',0),
  ('BPNL00000003COJN',0,'3857335a-658d-4a0e-8a93-797938a38982','P0058','Beheizte Lambdasonde 2, Zylinderreihe 2, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.456017Z',0),
  ('BPNL00000003COJN',0,'6bd47091-6cd3-4c0f-874b-2592c97c2fe7','P0059','Beheizte Lambdasonde, Zylinderreihe 2, Sensor 1 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.461076Z',0),
  ('BPNL00000003COJN',0,'045640ae-4bd9-4030-88d4-55cef7c953f3','P005A','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 1 - Fehlfunktion oder ständig deaktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.466586Z',0),
  ('BPNL00000003COJN',0,'361caea1-6534-4e29-9912-7cba5fa18966','P005B','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 1 - ständig aktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.472718Z',0),
  ('BPNL00000003COJN',0,'257528fc-df94-4abf-9f75-f32d2159f340','P005C','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 2 - Fehlfunktion oder ständig deaktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.484496Z',0),
  ('BPNL00000003COJN',0,'489fffcb-ef37-455e-baf8-5029f7edfc80','P005D','Nockenprofilsteuerung Auslassnockenwelle B, Zylinderreihe 2 - ständig aktiviert','Kabelbaum, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.490513Z',0),
  ('BPNL00000003COJN',0,'e40f416e-7600-455b-87c3-b171d350be07','P005E','Turbo-/Kompressorladedruckregelung B - Versorgungsspannung zu niedrig','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.495421Z',0),
  ('BPNL00000003COJN',0,'9b747d4c-c718-4508-9059-4c8e4dea7c4c','P005F','Turbo-/Kompressorladedruckregelung B - Versorgungsspannung zu hoch','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.500809Z',0),
  ('BPNL00000003COJN',0,'d40025d2-eff9-47ec-a32f-5e09d4598bfd','P0060','Beheizte Lambdasonde, Zylinderreihe 2, Sensor 2 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.506087Z',0),
  ('BPNL00000003COJN',0,'e60a2a03-f7e4-4e13-a6cc-96cc47139c42','P0061','Beheizte Lambdasonde, Zylinderreihe 2, Sensor 3 - Heizelementwiderstand','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:14.511382Z',0),
  ('BPNL00000003COJN',0,'2723cc1a-4f5b-4016-bbc3-d053e2b2b87b','P0062','Beheizte Lambdasonde 3, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.516939Z',0),
  ('BPNL00000003COJN',0,'7612c27c-bf40-4c6d-81a2-4fb8c6a552df','P0063','Beheizte Lambdasonde 3, Zylinderreihe 2, Heizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.524955Z',0),
  ('BPNL00000003COJN',0,'68bec88b-3d75-446c-8977-fd76127aa47f','P0064','Beheizte Lambdasonde 3, Zylinderreihe 2, Heizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:14.529861Z',0),
  ('BPNL00000003COJN',0,'3ac13340-3b05-441c-817b-7a584c05084a','P0065','Saugluftunterstütztes Einspritzventil - Bereichs-/Funktionsfehler','Saugluftunterstütztes Einspritzventil','2022-05-11T11:16:14.534866Z',0),
  ('BPNL00000003COJN',0,'3b7d79d5-ed84-48c3-9af1-89736af2cfce','P0066','Saugluftunterstütztes Einspritzventil - Fehlfunktion Stromkreis/Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, saugluftunterstütztes Einspritzventil, Motorsteuergerät','2022-05-11T11:16:14.539644Z',0),
  ('BPNL00000003COJN',0,'ed31cc31-11e6-4c01-94c0-350711852d72','P0067','Saugluftunterstütztes Einspritzventil - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, saugluftunterstütztes Einspritzventil, Motorsteuergerät','2022-05-11T11:16:14.544782Z',0),
  ('BPNL00000003COJN',0,'ae80ed19-ce83-4165-94a5-8bd06458af55','P0068','Saugrohrdrucksensor/Luftmassenmesser - Bezugsfehler Drosselklappenstellung','Kabelbaum, Saugrohrdrucksensor, Luftmassenmesser, mechanische Fehlfunktion','2022-05-11T11:16:14.549553Z',0),
  ('BPNL00000003COJN',0,'d56a6498-1080-4f0e-abc6-d6367d21aec2','P0069','Saugrohrdrucksensor/Atmosphärendrucksensor - Bezugsfehler','Saugrohrdrucksensor, mechanische Fehlfunktion','2022-05-11T11:16:14.554759Z',0),
  ('BPNL00000003COJN',0,'a32f0f61-864c-4ada-902e-d5bf7549faeb','P006A','Saugrohrdrucksensor/Luftmassenmesser oder Luftmengenmesser Zylinderreihe 1 - Bezugsfehler','Kabelbaum, Saugrohrdrucksensor, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:14.563321Z',0),
  ('BPNL00000003COJN',0,'1f05e7ad-6798-4963-b237-ec18d64ea579','P006B','Saugrohrdrucksensor/Abgasdruck - Bezugsfehler','Kabelbaum, Saugrohrdrucksensor, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:14.574341Z',0),
  ('BPNL00000003COJN',0,'749ff365-ec70-4581-bd0e-915aba9e90d6','P006C','Saugrohrdrucksensor/Turbo-/Kompressorladedrucksensor - Bezugsfehler','Kabelbaum, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:14.584145Z',0),
  ('BPNL00000003COJN',0,'e4206e43-70dd-4e95-8c45-e398c95e1502','P006D','Atmosphärendruck/Turbolader/Aufladungskompressor-Saugdruck - Bezugsfehler','Kabelbaum, Atmosphärendrucksensor, Saugdrucksensor für Turbolader/Aufladungskompressor, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.593157Z',0),
  ('BPNL00000003COJN',0,'72da8143-f705-4120-a0f0-b33c94228fa7','P006E','Turbo-/Kompressorladedruckregelung A - Versorgungsspannung zu niedrig','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.599755Z',0),
  ('BPNL00000003COJN',0,'14acc4da-bfa9-4d09-a8d1-c87fa9151288','P006F','Turbo-/Kompressorladedruckregelung A - Versorgungsspannung zu hoch','Kabelbaum, Turbolader-/Kompressor-Regelmagnetventil, Turbo-/Kompressorladedruck-Stellglied, Motorsteuergerät','2022-05-11T11:16:14.605021Z',0),
  ('BPNL00000003COJN',0,'feb20cff-8c93-475a-82b8-ed4fceb516fe','P0070','Außentemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.611713Z',0),
  ('BPNL00000003COJN',0,'29e169dc-3528-4aa4-b6ae-0daccd5d9272','P0071','Außentemperatursensor - Bereichs-/Funktionsfehler','Außentemperatursensor','2022-05-11T11:16:14.617372Z',0),
  ('BPNL00000003COJN',0,'b6249ee0-2869-41bd-9c15-f2014a199d03','P0072','Außentemperatursensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.625867Z',0),
  ('BPNL00000003COJN',0,'82d63b77-def8-470d-8146-f0d4d7e045c3','P0073','Außentemperatursensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.631846Z',0),
  ('BPNL00000003COJN',0,'3d129486-9488-405e-bc9b-77e17caef249','P0319','Fahrbahnsensor B - Fehlfunktion Stromkreis','Kabelbaum, Fahrbahnsensor B, mechanische Fehlfunktion','2022-05-11T11:16:17.856635Z',0),
  ('BPNL00000003COJN',0,'25ff5ebf-5eb8-4a96-8358-2a75c3ff574d','P0074','Außentemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.638949Z',0),
  ('BPNL00000003COJN',0,'f37c9b50-2bff-4f95-9a1c-3aebfea203b0','P0075','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.645197Z',0),
  ('BPNL00000003COJN',0,'cdad595d-7ca9-4619-b424-3d7bcda6e09f','P0076','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 1 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.651437Z',0),
  ('BPNL00000003COJN',0,'6da13010-0525-4d92-b9f8-d880697e6381','P0077','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 1 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.656648Z',0),
  ('BPNL00000003COJN',0,'8d120aa8-7d14-4948-a7a7-e57b07c33cc7','P0078','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.663430Z',0),
  ('BPNL00000003COJN',0,'6bbebb13-100e-4338-9f0a-2c092e5f741b','P0079','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 1 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.669401Z',0),
  ('BPNL00000003COJN',0,'48d54926-2a3b-4112-86e2-9f042e684049','P007A','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.677127Z',0),
  ('BPNL00000003COJN',0,'5f1475ee-b8f7-4a93-b374-639ecb15dc64','P007B','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.682564Z',0),
  ('BPNL00000003COJN',0,'82390642-7053-449a-84fe-d618f6a72941','P007C','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1 - Signal zu niedrig','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.688279Z',0),
  ('BPNL00000003COJN',0,'405849b7-ce12-4592-ab7b-882559c245b7','P007D','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1 - Signal zu hoch','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.696953Z',0),
  ('BPNL00000003COJN',0,'b0c1782f-a3ee-4485-ae9a-d8d8d3210932','P007E','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.714131Z',0),
  ('BPNL00000003COJN',0,'640bf5b7-a7d1-41d3-aad6-aba2244dff21','P007F','Turboladeluftkühler-Temperatursensor, Zylinderreihe 1/2 - Bezugsfehler','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:14.724315Z',0),
  ('BPNL00000003COJN',0,'ad3895a7-d478-4ae4-b0e6-d5e07bbd42ea','P0080','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 1 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.732749Z',0),
  ('BPNL00000003COJN',0,'0a568dfa-7f5c-4c22-955f-5d353419379c','P0081','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.738134Z',0),
  ('BPNL00000003COJN',0,'a6923afe-3518-4431-ad9a-798a779dd563','P0082','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.746665Z',0),
  ('BPNL00000003COJN',0,'100773ae-8df1-403e-b033-6cdfbb04265c','P0083','Magnetventil Einlassnockenwellenverstellung, Zylinderreihe 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Magnetventil Einlassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.757828Z',0),
  ('BPNL00000003COJN',0,'8890ef3e-dfd5-4b02-87e2-ba7f6eaa3ea2','P0084','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.768275Z',0),
  ('BPNL00000003COJN',0,'1da96b7a-9f56-441f-9b6c-9bdea20847c0','P0085','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.774981Z',0),
  ('BPNL00000003COJN',0,'fbe83272-5992-4760-8c8b-b38563992052','P0086','Magnetventil Auslassnockenwellenverstellung, Zylinderreihe 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Magnetventil Auslassnockenwellenverstellung, Motorsteuergerät','2022-05-11T11:16:14.790443Z',0),
  ('BPNL00000003COJN',0,'44502186-3f5b-4eea-9368-6230dc63d8b3','P0087','Kraftstoffverteilerleiste/Systemdruck zu niedrig','Kraftstoffpumpe, Kraftstoffdruckregler, Kraftstoffzulaufleitung verstopft, mechanische Fehlfunktion','2022-05-11T11:16:14.804312Z',0),
  ('BPNL00000003COJN',0,'9a36811c-c087-4c81-adf6-16d8ae822318','P0088','Kraftstoffverteilerleiste/Systemdruck zu hoch','Kraftstoffpumpe, Kraftstoffdruckregler, Kraftstoffrücklaufleitung verstopft, mechanische Fehlfunktion','2022-05-11T11:16:14.810379Z',0),
  ('BPNL00000003COJN',0,'1c0d685b-7724-4da8-8532-b914e49d95e6','P0089','Kraftstoffdruckregler 1 - beeinträchtigte Funktion','Kraftstoffdruckregler, mechanische Fehlfunktion','2022-05-11T11:16:14.818063Z',0),
  ('BPNL00000003COJN',0,'89fc21d9-668d-4226-a1f0-6636b7594a91','P008A','Kraftstoff-Niederdrucksystem - Druck zu niedrig','Kabelbaum, Kraftstoffpumpe, eingeschränkte Kraftstoffversorgung, Kraftstoffdruck-Regelventil','2022-05-11T11:16:14.826810Z',0),
  ('BPNL00000003COJN',0,'030e96da-f1ad-489b-b6d4-fa92d58f4b1c','P008B','Kraftstoff-Niederdrucksystem - Druck zu hoch','Kraftstoff-Überdruckventil','2022-05-11T11:16:14.834273Z',0),
  ('BPNL00000003COJN',0,'a046ad0a-0d90-4396-b68f-3156bf5c50b6','P008C','Kraftstoffkühlpumpenmotor-Steuerung - offener Stromkreis','Kabelbaum, Kraftstoffkühlpumpenmotor, Motorsteuergerät','2022-05-11T11:16:14.845672Z',0),
  ('BPNL00000003COJN',0,'5bf1b629-6265-43f1-9d21-4e4710e847aa','P008D','Kraftstoffkühlpumpenmotor - Signal zu niedrig','Kabelbaum, Kraftstoffkühlpumpenmotor, Motorsteuergerät','2022-05-11T11:16:14.853390Z',0),
  ('BPNL00000003COJN',0,'958e5bbb-de00-4e3f-a78c-be16269a1512','P008E','Kraftstoffkühlpumpenmotor - Signal Steuerstromkreis zu hoch','Kabelbaum, Kraftstoffkühlpumpenmotor, Motorsteuergerät','2022-05-11T11:16:14.861785Z',0),
  ('BPNL00000003COJN',0,'fb836830-1486-4666-a64b-ee3a980e950e','P008F','Kühlmitteltemperatur/Kraftstofftemperatur - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.873725Z',0),
  ('BPNL00000003COJN',0,'25e0f1e0-51b5-4be0-8257-712f5d8a409c','P0090','Kraftstoffdruckregler 1 - offener Stromkreis','Kabelbaum unterbrochen, Kraftstoffdosierventil, Motorsteuergerät','2022-05-11T11:16:14.881833Z',0),
  ('BPNL00000003COJN',0,'1bd1b130-de7c-44ca-96e9-383416dddef8','P0091','Kraftstoffdruckregler 1 - Kurzschluss an Masse','Kurzschluss an Masse im Kabelbaum, Kraftstoffdosierventil, Motorsteuergerät','2022-05-11T11:16:14.888454Z',0),
  ('BPNL00000003COJN',0,'c337a3a1-f9ef-4dfb-a233-87a10ab09595','P0092','Kraftstoffdruckregler 1 - Kurzschluss an Plus','Kurzschluss an Plus im Kabelbaum, Kraftstoffdosierventil, Motorsteuergerät','2022-05-11T11:16:14.896688Z',0),
  ('BPNL00000003COJN',0,'c8ae69d9-ff83-4b31-ad99-d09473de35b7','P0093','Kraftstoffsystem undicht - große Undichtigkeit festgestellt','Kabelbaum, Kraftstoffdrucksensor, mechanische Fehlfunktion','2022-05-11T11:16:14.904656Z',0),
  ('BPNL00000003COJN',0,'e3eaefee-d687-45d3-9d1a-effe42d70104','P0094','Kraftstoffsystem undicht - kleine Undichtigkeit festgestellt','Kabelbaum, Kraftstoffdrucksensor, mechanische Fehlfunktion','2022-05-11T11:16:14.913751Z',0),
  ('BPNL00000003COJN',0,'b9af6737-b420-48e2-a02c-74f49edfe461','P0095','Ansauglufttemperatursensor 2 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.921131Z',0),
  ('BPNL00000003COJN',0,'6812b049-f376-4519-aea8-228796feb87f','P0096','Ansauglufttemperatursensor 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.933983Z',0),
  ('BPNL00000003COJN',0,'e695c37d-c0c3-4de6-bb8e-df462773d1b6','P0097','Ansauglufttemperatursensor 2 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.941742Z',0),
  ('BPNL00000003COJN',0,'48309e9c-42c2-4bb0-96f0-007363d6ee2c','P0098','Ansauglufttemperatursensor 2 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.946883Z',0),
  ('BPNL00000003COJN',0,'fa63dbb5-5673-4a2f-9977-801d273135ec','P0099','Ansauglufttemperatursensor 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.956780Z',0),
  ('BPNL00000003COJN',0,'dc231a2a-ee57-4128-915a-9225d0cbcdcc','P009A','Ansauglufttemperatur/Außentemperatur - Bezugsfehler','Kabelbaum, Ansauglufttemperatursensor, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:14.965004Z',0),
  ('BPNL00000003COJN',0,'0479b799-62a8-4e7f-abce-38e3993c4258','P009B','Kraftstoff-Überdruckregelsystem - offener Steuerstromkreis','Kabelbaum, Kraftstoff-Überdruckventil, Motorsteuergerät','2022-05-11T11:16:14.970993Z',0),
  ('BPNL00000003COJN',0,'eebd7e89-8b15-4b99-a8a5-dded98b836c6','P009C','Kraftstoff-Überdruckregelsystem - Signal Steuerstromkreis zu niedrig','Kabelbaum, Kraftstoff-Überdruckventil, Motorsteuergerät','2022-05-11T11:16:14.979089Z',0),
  ('BPNL00000003COJN',0,'9bb65bea-081a-40f3-b250-7ae3f191bda8','P009D','Kraftstoff-Überdruckregelsystem - Signal Steuerstromkreis zu hoch','Kabelbaum, Kraftstoffdruckregelungs-Magnetventil, Motorsteuergerät','2022-05-11T11:16:14.991452Z',0),
  ('BPNL00000003COJN',0,'26c4675c-0401-4993-8902-de335b52a055','P009E','Kraftstoff-Überdruckregelsystem - beeinträchtigte Funktion oder ständig deaktiviert','Kabelbaum, Kraftstoff-Überdruckventil, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:14.997181Z',0),
  ('BPNL00000003COJN',0,'9f98f506-4006-43a3-b3ca-eea20b27d1ab','P009F','Kraftstoff-Überdruckregelsystem - Ventil klemmt','Kabelbaum, Kraftstoff-Überdruckventil, Motorsteuergerät','2022-05-11T11:16:15.003168Z',0),
  ('BPNL00000003COJN',0,'ebb67702-014a-4bd1-94ef-36f9d1060e7c','P00A0','Turboladeluftkühler-Temperatursensor, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:15.009182Z',0),
  ('BPNL00000003COJN',0,'8af1839c-aeda-4d7f-9669-4cf86126f8f8','P00A1','Turboladeluftkühler-Temperatursensor, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:15.014931Z',0),
  ('BPNL00000003COJN',0,'fe03af7d-251f-470c-96f6-47cffb66217d','P00A2','Turboladeluftkühler-Temperatursensor Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:15.020853Z',0),
  ('BPNL00000003COJN',0,'2e5f51d0-60c8-43f7-8d18-659fbf114e54','P00A3','Turboladeluftkühler-Temperatursensor, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:15.028642Z',0),
  ('BPNL00000003COJN',0,'f2092661-e72e-477e-9918-5f12d35577b8','P00A4','Turboladeluftkühler-Temperatursensor - zeitweilige Stromkreisunterbrechungen, Zylinderreihe 2','Kabelbaum, Turboladeluftkühler-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:15.033668Z',0),
  ('BPNL00000003COJN',0,'5a2991e9-ca4b-48c2-8174-3da70cadd677','P00A5','Ansauglufttemperatursensor 2, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.040635Z',0),
  ('BPNL00000003COJN',0,'b6e3d50e-f2c3-46a7-85df-3eb0a4265d9b','P00A6','Ansauglufttemperatursensor 2, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.046081Z',0),
  ('BPNL00000003COJN',0,'311a4bb3-62f2-4f8f-9d9e-779def7dbf91','P00A7','Ansauglufttemperatursensor 2, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.051432Z',0),
  ('BPNL00000003COJN',0,'1f2ffb46-9951-4624-9dfc-eadf173c9ded','P00A8','Ansauglufttemperatursensor 2, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.056858Z',0),
  ('BPNL00000003COJN',0,'6e8234ee-4f40-437a-8345-3e72536dac4f','P00A9','Ansauglufttemperatursensor 2, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.062690Z',0),
  ('BPNL00000003COJN',0,'060f54da-d9be-410f-93c2-f9cddeb9404e','P00AA','Ansauglufttemperatursensor 1, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.069830Z',0),
  ('BPNL00000003COJN',0,'78fbb848-3b61-43a4-9ac4-7f3290ac9fbc','P00AB','Ansauglufttemperatursensor 1, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.077365Z',0),
  ('BPNL00000003COJN',0,'78ba1c7d-de3c-40b3-a075-f7908a90a898','P00AC','Ansauglufttemperatursensor 1, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.083379Z',0),
  ('BPNL00000003COJN',0,'0d93ae2a-e911-4418-8710-a8b1e7be3af0','P00AD','Ansauglufttemperatursensor 1, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.089563Z',0),
  ('BPNL00000003COJN',0,'c0abaef3-16c3-4858-b0f9-37f043b9c9f0','P00AE','Ansauglufttemperatursensor 1, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.094844Z',0),
  ('BPNL00000003COJN',0,'e4946d83-2348-48d5-a68f-f4ee3a48521c','P00AF','Turbo-/Kompressorladedruckregelung A - Funktionsfehler Modul','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:15.102167Z',0),
  ('BPNL00000003COJN',0,'df4a0b02-c9c1-40ac-8932-5478a9dba419','P00B0','Turbo-/Kompressorladedruckregelung B - Funktionsfehler Modul','Motorsteuergerät','2022-05-11T11:16:15.107475Z',0),
  ('BPNL00000003COJN',0,'aeb44d8f-8441-44eb-abfa-cc5d3e211f08','P00B1','Kühlmitteltemperatursensor (am Kühler) - Fehlfunktion Stromkreis','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Motorsteuergerät','2022-05-11T11:16:15.112837Z',0),
  ('BPNL00000003COJN',0,'f4a05875-61b2-4ef7-a77c-cb9cf727c3d0','P00B2','Kühlmitteltemperatursensor (am Kühler) - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Motorsteuergerät','2022-05-11T11:16:15.118372Z',0),
  ('BPNL00000003COJN',0,'abd1338f-f0db-4222-ab74-a24cdf3f8fc3','P00B3','Kühlmitteltemperatursensor (am Kühler) - Signal zu niedrig','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Motorsteuergerät','2022-05-11T11:16:15.124207Z',0),
  ('BPNL00000003COJN',0,'51eb36ba-b06f-498f-b355-46b8c267b220','P00B4','Kühlmitteltemperatursensor (am Kühler) - Signal zu hoch','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Motorsteuergerät','2022-05-11T11:16:15.131841Z',0),
  ('BPNL00000003COJN',0,'16e0415d-7c77-4030-8c18-289d46c95711','P00B5','Kühlmitteltemperatursensor (am Kühler) - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Motorsteuergerät','2022-05-11T11:16:15.137110Z',0),
  ('BPNL00000003COJN',0,'c8d98fa2-b6c9-40ad-967a-7b5650f9b02c','P00B6','Kühlmitteltemperatur (im Kühler)/Kühlmitteltemperatur - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor (am Kühler), Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.142373Z',0),
  ('BPNL00000003COJN',0,'ec3595c2-5cf6-4525-9507-8b259eba98be','P00B7','Kühlmittelflussrate zu niedrig - beeinträchtigte Funktion','Thermostat, Kühler, Kühlmittelpumpe','2022-05-11T11:16:15.147371Z',0),
  ('BPNL00000003COJN',0,'e2de828f-3131-4a2f-95de-335ffedeadbf','P00B8','Saugrohrdrucksensor/Luftmassenmesser oder Luftmengenmesser, Zylinderreihe 2 - Bezugsfehler','Kabelbaum, Saugrohrdrucksensor, Luftmassenmesser, Luftmengenmesser, Schlauch verstopft/undicht - Motorsteuergerät','2022-05-11T11:16:15.152920Z',0),
  ('BPNL00000003COJN',0,'0d2fb0be-a134-47b3-bbd3-fc74868facca','P00B9','Kraftstoffdrucksensor - Druck zu niedrig','Kabelbaum, Umgebungstemperatur zu niedrig, Kraftstoffdrucksensor','2022-05-11T11:16:15.159034Z',0),
  ('BPNL00000003COJN',0,'21c08282-954b-4bc3-a757-be93d502f680','P00BA','Kraftstoffdruck zu niedrig - Betriebsmodus "Motorleistungsbegrenzung"','-','2022-05-11T11:16:15.164729Z',0),
  ('BPNL00000003COJN',0,'c064fe64-99b8-450b-8c3e-7246ba2ba052','P00BB','Einspritzventil/-düse, unzureichende Flussrate festgestellt - Betriebsmodus "Motorleistungsbegrenzung"','-','2022-05-11T11:16:15.169712Z',0),
  ('BPNL00000003COJN',0,'1395a665-5d9f-4cef-a555-26d29621dbea','P00BC','Luftmassenmesser A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Luftmassenmesser','2022-05-11T11:16:15.175573Z',0),
  ('BPNL00000003COJN',0,'85b363d9-6a69-4922-b101-9847be43d550','P00BD','Luftmassenmesser A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Luftmassenmesser','2022-05-11T11:16:15.186008Z',0),
  ('BPNL00000003COJN',0,'2ceddb26-e521-433f-bbd7-fd370676fd66','P00BE','Luftmassenmesser B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Luftmassenmesser','2022-05-11T11:16:15.192643Z',0),
  ('BPNL00000003COJN',0,'990d25fc-dcfb-477c-bc15-4b66875cc1e1','P00BF','Luftmassenmesser B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Luftmassenmesser','2022-05-11T11:16:15.197626Z',0),
  ('BPNL00000003COJN',0,'b3f3f267-46de-461d-880e-1dc1409d0c18','P00C0','Turbolader-/Motoraufladungskompressor-Bypassventil B - Steuerstromkreis','Kabelbaum, Turbolader-/Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:15.203281Z',0),
  ('BPNL00000003COJN',0,'562768a3-2b3b-4a80-a3d0-55fc0e63e095','P00C1','Turbolader-/Motoraufladungskompressor-Bypassventil B - Signal zu niedrig','Kabelbaum, Turbolader-/Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:15.208923Z',0),
  ('BPNL00000003COJN',0,'3a3def8f-e64e-4963-8b59-29be9c5289f0','P00C2','Turbo-/Kompressorlader B - Signal zu hoch','Kabelbaum, Turbolader-/Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:15.214597Z',0),
  ('BPNL00000003COJN',0,'f1f327dd-dd38-4af8-a8a0-97c5b02492f7','P00C3','Turbo-/Kompressorlader B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Turbolader-/Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:15.220396Z',0),
  ('BPNL00000003COJN',0,'09815cda-aa02-4388-a45a-c8deb73edfb5','P00C4','Turbolader-/Motoraufladungskompressor-Bypassventil B - mechanische Fehlfunktion','-','2022-05-11T11:16:15.225748Z',0),
  ('BPNL00000003COJN',0,'c334946f-e7d7-4c8a-b2c9-82274d68de20','P00C5','Turbo-/Kompressorlader B - Turbinendrehzahl zu hoch','-','2022-05-11T11:16:15.230881Z',0),
  ('BPNL00000003COJN',0,'42b2e3a9-0681-4b35-893d-5c3e4774aa21','P00C6','Kraftstoffverteilerdruck - Anlasserbetätigung - Druck zu niedrig','Kraftstoffstand zu niedrig, Schlauch undicht/blockiert, Kraftstoffpumpe, Einspritzventil(e)/-düse(n)','2022-05-11T11:16:15.236259Z',0),
  ('BPNL00000003COJN',0,'a07ba4e0-9886-424e-af8f-e35f2b5267af','P00C7','Saugluftdruckmesssystem - Bezugsfehler mehrere Sensoren','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:15.242015Z',0),
  ('BPNL00000003COJN',0,'ab2f63a7-2dcd-44cb-a898-39d5dec00f65','P00C8','Kraftstoffdruckregelungs-Magnetventil - offener Stromkreis','Kabelbaum, Kraftstoffdruckregelungs-Magnetventil, Motorsteuergerät','2022-05-11T11:16:15.246979Z',0),
  ('BPNL00000003COJN',0,'80368835-bb71-4ae3-a5e8-2fda18a4fed4','P00C9','Kraftstoffdruckregelungs-Magnetventil - Signal zu niedrig','Kabelbaum, Kraftstoffdruckregelungs-Magnetventil, Motorsteuergerät','2022-05-11T11:16:15.252017Z',0),
  ('BPNL00000003COJN',0,'3ababf27-68b7-4dd2-8e26-4aedcb1a5066','P00CA','Kraftstoffdruckregelungs-Magnetventil - Signal zu hoch','Kabelbaum, Kraftstoffdruckregelungs-Magnetventil, Motorsteuergerät','2022-05-11T11:16:15.258114Z',0),
  ('BPNL00000003COJN',0,'99486432-50d1-4e3f-a35f-94fa7d6464cf','P00CB','Kraftstoffmengenregler - offener Stromkreis','Kabelbaum, Kraftstoffmengenregler, Motorsteuergerät','2022-05-11T11:16:15.264565Z',0),
  ('BPNL00000003COJN',0,'df395823-5d77-4486-bbb6-f6ce6d97fabc','P00CC','Kraftstoffmengenregler - Signal zu niedrig','Kabelbaum, Kraftstoffmengenregler, Motorsteuergerät','2022-05-11T11:16:15.269939Z',0),
  ('BPNL00000003COJN',0,'5d644929-d66d-4a05-90e0-1e1a08958c95','P00CD','Kraftstoffmengenregler - Signal zu hoch','Kabelbaum, Kraftstoffmengenregler, Motorsteuergerät','2022-05-11T11:16:15.276191Z',0),
  ('BPNL00000003COJN',0,'ab7479ec-20d4-4b2f-ba3b-bbff202af943','P00CE','Sauglufttemperaturmesssystem - Bezugsfehler mehrere Sensoren','Kabelbaum, Ansauglufttemperatursensor(en), Motorsteuergerät','2022-05-11T11:16:15.281397Z',0),
  ('BPNL00000003COJN',0,'27dd30bf-22a9-4948-a0d2-11071eb64cf1','P00CF','Atmosphärendrucksensor/Turbo-/Kompressorladedrucksensor A - Bezugsfehler','Kabelbaum, Atmosphärendrucksensor, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:15.286761Z',0),
  ('BPNL00000003COJN',0,'a3a367e4-fb6f-4dc5-b223-fd7182e54bb3','P00D0','Atmosphärendrucksensor/Turbo-/Kompressorladedrucksensor B - Bezugsfehler','Kabelbaum, Atmosphärendrucksensor, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:15.293410Z',0),
  ('BPNL00000003COJN',0,'b94bff44-6a49-4822-98e7-d68a3ad71c40','P0100','Luftmassenmesser/Luftmengenmesser - Fehlfunktion Stromkreis','Kabelbaum, Luftmassenmesser/Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.300826Z',0),
  ('BPNL00000003COJN',0,'37b169ec-4da4-484e-90b2-f1e0f2a02f69','P0101','Luftmassenmesser/Luftmengenmesser - Bereichs-/Funktionsfehler','Ansaugsystem undicht/blockiert, Luftmassenmesser/Luftmengenmesser','2022-05-11T11:16:15.305704Z',0),
  ('BPNL00000003COJN',0,'947a0b2b-8c4c-4441-b9d3-712b0ce42ed0','P0102','Luftmassenmesser/Luftmengenmesser - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Luftmassenmesser/Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.310440Z',0),
  ('BPNL00000003COJN',0,'65b9ef0d-09a4-4539-9006-05d19b5ab944','P0103','Luftmassenmesser/Luftmengenmesser - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Luftmassenmesser/Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.315844Z',0),
  ('BPNL00000003COJN',0,'7fb81607-a071-4273-91d8-38530b60347f','P0104','Luftmassenmesser/Luftmengenmesser - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Luftmassenmesser/Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.321249Z',0),
  ('BPNL00000003COJN',0,'c8916b45-df9f-4ea3-b37b-436b788e439d','P0105','Saugrohrdrucksensor/Atmosphärendrucksensor - Fehlfunktion Stromkreis','Kabelbaum, Saugrohrdrucksensor, Atmosphärendrucksensor, Motorsteuergerät','2022-05-11T11:16:15.326639Z',0),
  ('BPNL00000003COJN',0,'fa99df80-6dc5-454f-a876-36f255436286','P0106','Saugrohrdrucksensor/Atmosphärendrucksensor - Bereichs-/Funktionsfehler','Einlass-/auslassseitige Undichtigkeit, Kabelbaum, Saugrohrdrucksensor, Atmosphärendrucksensor','2022-05-11T11:16:15.332834Z',0),
  ('BPNL00000003COJN',0,'cb83a996-bd43-404a-8544-9baebc0b84bf','P0107','Saugrohrdrucksensor/Atmosphärendrucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Saugrohrdrucksensor, Atmosphärendrucksensor, Motorsteuergerät','2022-05-11T11:16:15.338511Z',0),
  ('BPNL00000003COJN',0,'1e36d638-fe7c-4492-ad6b-d9c476b41918','P0108','Saugrohrdrucksensor/Atmosphärendrucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Saugrohrdrucksensor, Atmosphärendrucksensor, Motorsteuergerät','2022-05-11T11:16:15.343466Z',0),
  ('BPNL00000003COJN',0,'6f29f7ab-7b2b-4ecc-955e-de459be1e368','P0109','Saugrohrdrucksensor/Atmosphärendrucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Saugrohrdrucksensor, Atmosphärendrucksensor, Motorsteuergerät','2022-05-11T11:16:15.349067Z',0),
  ('BPNL00000003COJN',0,'ee6c8b9f-e370-478c-92f7-9fe488ecb2e3','P010A','Luftmassenmesser oder Luftmengenmesser B - Fehlfunktion Stromkreis','Kabelbaum, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.355083Z',0),
  ('BPNL00000003COJN',0,'b44ce451-3de6-458b-a5bc-2dd960ff5e9d','P010B','AGR-Steuergerät B - Kommunikationsfehler','Kabelbaum, AGR-Steuergerät, Motorsteuergerät','2022-05-11T11:16:15.360402Z',0),
  ('BPNL00000003COJN',0,'bfc2e8f3-f13d-451c-883b-cf9e306bf5c4','P010C','Luftmassenmesser oder Luftmengenmesser B - Signal zu niedrig','Kabelbaum, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.378877Z',0),
  ('BPNL00000003COJN',0,'6d6ae25a-16f6-4e21-9075-c7d0775e677a','P010D','Luftmassenmesser oder Luftmengenmesser B - Signal zu hoch','Kabelbaum, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.384888Z',0),
  ('BPNL00000003COJN',0,'80d19c0d-ab6e-46c9-a847-b103b07cdf12','P010E','Luftmassenmesser oder Luftmengenmesser B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.391704Z',0),
  ('BPNL00000003COJN',0,'a41b43c0-e9bf-481a-983a-5789c4da219c','P010F','Luftmassenmesser oder Luftmengenmesser A/B - Bezugsfehler','Kabelbaum, Luftmassenmesser, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:15.397430Z',0),
  ('BPNL00000003COJN',0,'125ae090-ff2a-43df-967d-b4ac6aa5999b','P0110','Ansauglufttemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.402523Z',0),
  ('BPNL00000003COJN',0,'af2c7fb1-c6aa-4cc7-9a37-cb161795eb7c','P0111','Ansauglufttemperatursensor - Bereichs-/Funktionsfehler','Ansauglufttemperatursensor','2022-05-11T11:16:15.407965Z',0),
  ('BPNL00000003COJN',0,'39a3017a-aaaa-4fcd-9fdc-33ccfd66d60a','P0112','Ansauglufttemperatursensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.413792Z',0),
  ('BPNL00000003COJN',0,'515ccc09-a04b-46e3-9ba9-cda36e81e21c','P0113','Ansauglufttemperatursensor - Eingangssignal zu hoch','Offener Stromkreis/Kurzschluss an Plus im Kabelbaum, Massekabel defekt, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.419012Z',0),
  ('BPNL00000003COJN',0,'ef70a032-c44d-4752-b3fc-96fae88c3034','P0114','Ansauglufttemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.424673Z',0),
  ('BPNL00000003COJN',0,'450e3c0a-b8d8-4258-8525-a99160db3461','P0115','Kühlmitteltemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.430909Z',0),
  ('BPNL00000003COJN',0,'a3ee636d-c622-4789-849b-83c24548e3f4','P0116','Kühlmitteltemperatursensor - Bereichs-/Funktionsfehler','Kühlmittelthermostat, schlechte Kontaktierung, Kabelbaum, Kühlmitteltemperatursensor','2022-05-11T11:16:15.436043Z',0),
  ('BPNL00000003COJN',0,'b7b405aa-4607-4996-99d5-9c564e289556','P0117','Kühlmitteltemperatursensor - Eingangssignal zu niedrig','Kühlmittelthermostat, Kurzschluss an Masse im Kabelbaum, Kühlmitteltemperatursensor','2022-05-11T11:16:15.441479Z',0),
  ('BPNL00000003COJN',0,'27f773db-c54f-4b5d-947e-2f1ddd5e156b','P0118','Kühlmitteltemperatursensor - Eingangssignal zu hoch','Kühlmittelthermostat, offener Stromkreis/Kurzschluss an Plus im Kabelbaum, Massekabel defekt, Kühlmitteltemperatursensor','2022-05-11T11:16:15.447278Z',0),
  ('BPNL00000003COJN',0,'b3640e96-4ebd-42a7-ab62-fe5b57634691','P03C6','Zylinder 5 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.727384Z',0),
  ('BPNL00000003COJN',0,'2262acc1-1983-4f8f-b02a-1cc89d3ffd57','P0119','Kühlmitteltemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.453544Z',0),
  ('BPNL00000003COJN',0,'fa8ff1f8-4a25-497d-830d-db3fe2d8a487','P011A','Kühlmitteltemperatursensor 1/2 - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.458893Z',0),
  ('BPNL00000003COJN',0,'d215e86f-2cf1-40a6-a936-4c9296f68bcb','P011B','Kühlmitteltemperatur/Ansauglufttemperatur - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor, Ansauglufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.464280Z',0),
  ('BPNL00000003COJN',0,'273b1864-df66-43c8-8169-91f43e9092c0','P011C','Ladelufttemperatur/Ansauglufttemperatur, Zylinderreihe 1 - Bezugsfehler','Kabelbaum, Ansauglufttemperatursensor, Turbo-/Kompressorladelufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.469177Z',0),
  ('BPNL00000003COJN',0,'6df7d462-19b7-4f98-b7c2-4d9c336e6e97','P011D','Ladelufttemperatur/Ansauglufttemperatur, Zylinderreihe 2 - Bezugsfehler','Kabelbaum, Ansauglufttemperatursensor, Turbo-/Kompressorladelufttemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.474714Z',0),
  ('BPNL00000003COJN',0,'e754c5e6-6e57-47a9-9bd2-89d615ac6645','P011E','Kühlmitteltemperatursensor 1/Außentemperatursensor - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.480190Z',0),
  ('BPNL00000003COJN',0,'63b55dbf-4ad2-4d97-bd16-3e9c148f1900','P011F','Kühlmitteltemperatursensor 2/Außentemperatursensor - Bezugsfehler','Kabelbaum, Kühlmitteltemperatursensor, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:15.486740Z',0),
  ('BPNL00000003COJN',0,'11dc6c5a-4d9a-4bcb-9c3f-5d0ea754aa1e','P0120','Drosselklappenpotenziometer A/Fahrpedalsensor A - Fehlfunktion Stromkreis','Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:15.492440Z',0),
  ('BPNL00000003COJN',0,'6e5da891-9277-4994-9320-827f35f2e080','P0121','Drosselklappenpotenziometer A/Fahrpedalsensor A - Bereichs-/Funktionsfehler','Einstellung Fahrpedalzug, Drosselklappenpotenziometer/Fahrpedalsensor','2022-05-11T11:16:15.506879Z',0),
  ('BPNL00000003COJN',0,'81202c52-fe77-4d2f-a9ea-a40681a25e8f','P0122','Drosselklappenpotenziometer A/Fahrpedalsensor A - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:15.521235Z',0),
  ('BPNL00000003COJN',0,'e11a7b8f-480d-4aa1-9da2-1cb903f89277','P0123','Drosselklappenpotenziometer A/Fahrpedalsensor A - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:15.531729Z',0),
  ('BPNL00000003COJN',0,'45dfb1ac-4d11-4ac5-9d9d-9c30b17a108e','P0124','Drosselklappenpotenziometer A/Fahrpedalsensor A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:15.541684Z',0),
  ('BPNL00000003COJN',0,'05bef5b0-5382-44fc-b7f7-02a1605607ce','P0125','Kühlmitteltemperatur zu niedrig - kein geschlossener Regelkreis der Kraftstoffzumessung','Kabelbaum, Motorkühlsystem, Kühlmittelthermostat, Kühlmitteltemperatursensor','2022-05-11T11:16:15.556303Z',0),
  ('BPNL00000003COJN',0,'d802499c-9703-4ccb-a592-728dc295d315','P0126','Kühlmitteltemperatur zu niedrig - unrunder Motorlauf','Kabelbaum, Motorkühlsystem, Kühlmittelthermostat, Kühlmitteltemperatursensor','2022-05-11T11:16:15.561669Z',0),
  ('BPNL00000003COJN',0,'e6a138ff-07f0-4e5e-8c85-c8a11cb2306c','P0127','Ansauglufttemperatur zu hoch','Kurzschluss an Masse im Kabelbaum, Ansauglufttemperatursensor 2, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:15.567091Z',0),
  ('BPNL00000003COJN',0,'494a8e3e-b698-4444-aaa4-d2f371997b0b','P0128','Kühlmittelthermostat - Kühlmitteltemperatur unterhalb Thermostat-Regeltemperatur','Mechanische Fehlfunktion','2022-05-11T11:16:15.572588Z',0),
  ('BPNL00000003COJN',0,'d67793d6-e401-45d6-bc41-c338c134607c','P0129','Atmosphärendruck zu niedrig','Kabelbaum, Atmosphärendrucksensor, mechanische Fehlfunktion','2022-05-11T11:16:15.578196Z',0),
  ('BPNL00000003COJN',0,'f4168eed-09fb-4709-92fd-ea7ef9f49cd5','P012A','Saugdrucksensor für Turbolader/Aufladungskompressor - Fehlfunktion Stromkreis','Kabelbaum, Saugdrucksensor für Turbolader/Aufladungskompressor, Motorsteuergerät','2022-05-11T11:16:15.583099Z',0),
  ('BPNL00000003COJN',0,'5c249be6-5963-4705-b64d-8196858a7321','P012B','Saugdrucksensor für Turbolader/Aufladungskompressor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Saugdrucksensor für Turbolader/Aufladungskompressor, Motorsteuergerät','2022-05-11T11:16:15.587863Z',0),
  ('BPNL00000003COJN',0,'e5080842-f427-486a-bc46-6e0341af4905','P012C','Saugdrucksensor für Turbolader/Aufladungskompressor - Signal zu niedrig','Kabelbaum, Saugdrucksensor für Turbolader/Aufladungskompressor, Motorsteuergerät','2022-05-11T11:16:15.592770Z',0),
  ('BPNL00000003COJN',0,'c853c740-2a67-4e86-a75e-c2ccc8def438','P012D','Saugdrucksensor für Turbolader/Aufladungskompressor - Signal zu hoch','Kabelbaum, Saugdrucksensor für Turbolader/Aufladungskompressor, Motorsteuergerät','2022-05-11T11:16:15.604314Z',0),
  ('BPNL00000003COJN',0,'0151b5ea-5e47-47a3-9060-d4101dba8e4b','P012E','Saugdrucksensor für Turbolader/Aufladungskompressor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Saugdrucksensor für Turbolader/Aufladungskompressor, Motorsteuergerät','2022-05-11T11:16:15.609804Z',0),
  ('BPNL00000003COJN',0,'5bed5b1e-ba37-4223-9b84-320852369ac3','P0130','Beheizte Lambdasonde 1, Zylinderreihe 1 - Fehlfunktion Stromkreis','Heizelement funktionslos, schlechte Kontaktierung, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.614993Z',0),
  ('BPNL00000003COJN',0,'9cdaf7e8-119f-48aa-961b-ccdf321e424f','P0131','Beheizte Lambdasonde 1, Zylinderreihe 1 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.625637Z',0),
  ('BPNL00000003COJN',0,'d93d9398-4e46-4dc7-9e29-de9c2597ae7b','P079B','Getriebereibelement B - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.280418Z',2),
  ('BPNL00000003COJN',0,'a237e958-dc23-43c4-9b4a-c24178867e6b','P0132','Beheizte Lambdasonde 1, Zylinderreihe 1 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.636014Z',0),
  ('BPNL00000003COJN',0,'d0e2f6c7-de4d-4d4b-9242-b4ec8a23842e','P079C','Getriebereibelement C - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.285926Z',2),
  ('BPNL00000003COJN',0,'e10cdabe-3f5c-4450-83c9-c7fd4988bce9','P0133','Beheizte Lambdasonde 1, Zylinderreihe 1 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.645814Z',0),
  ('BPNL00000003COJN',0,'84dc90dc-19a1-407b-b498-7c80a42bf4dd','P079D','Getriebereibelement D - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.293448Z',2),
  ('BPNL00000003COJN',0,'954b7d53-ad0a-4e38-b1eb-67cb3636732e','P0134','Beheizte Lambdasonde 1, Zylinderreihe 1 - funktionslos','Kabelbaum unterbrochen, Heizelement funktionslos, beheizte Lambdasonde','2022-05-11T11:16:15.655168Z',0),
  ('BPNL00000003COJN',0,'cfbc6e1c-4c5b-4e7a-8a05-f717588cdc69','P079E','Getriebereibelement E - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.297781Z',2),
  ('BPNL00000003COJN',0,'c8874f97-5c6b-4ec5-8896-a1a16d7d5038','P0135','Beheizte Lambdasonde 1, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Sicherung, Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.664450Z',0),
  ('BPNL00000003COJN',0,'e3048c9a-b6d4-4428-b54b-38e3e3dbe4e6','P079F','Getriebereibelement F - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.302074Z',2),
  ('BPNL00000003COJN',0,'192b65bf-a83b-4a6d-9bf9-0a5ac0a1baad','P07A1','Getriebereibelement H - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.313415Z',2),
  ('BPNL00000003COJN',0,'15d00f3b-bc1d-4219-bb53-1961ea0646dc','P0136','Beheizte Lambdasonde 2, Zylinderreihe 1 - Fehlfunktion Stromkreis','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.669558Z',0),
  ('BPNL00000003COJN',0,'077f4e8a-efaf-4c20-bfd9-3a15f6dca769','P079A','Getriebereibelement A - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.275591Z',2),
  ('BPNL00000003COJN',0,'d1b25663-47a0-45db-ae96-f77ca8a79e9e','P0137','Beheizte Lambdasonde 2, Zylinderreihe 1 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.680191Z',0),
  ('BPNL00000003COJN',0,'47d67ef5-8611-4fbc-a56e-3af2a465aba1','P0138','Beheizte Lambdasonde 2, Zylinderreihe 1 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.689728Z',0),
  ('BPNL00000003COJN',0,'383d737a-36e5-47d1-ab62-f0129493b7f7','P0139','Beheizte Lambdasonde 2, Zylinderreihe 1 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.701171Z',0),
  ('BPNL00000003COJN',0,'432ed19c-6a94-4df7-ba79-dcb8e69197af','P013A','Beheizte Lambdasonde 2, Zylinderreihe 1 - träges Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.711823Z',0),
  ('BPNL00000003COJN',0,'23bcdeb0-e297-4ca8-905e-b0361178ada4','P013B','Beheizte Lambdasonde 2, Zylinderreihe 1 - träges Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.717077Z',0),
  ('BPNL00000003COJN',0,'c25f65c6-e14c-4fee-8352-90cad1ee2c90','P013C','Beheizte Lambdasonde 2, Zylinderreihe 2 - träges Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.722182Z',0),
  ('BPNL00000003COJN',0,'31f261b4-5d9d-48a4-9225-be43da0f6bb7','P013D','Beheizte Lambdasonde 2, Zylinderreihe 2 - träges Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.731436Z',0),
  ('BPNL00000003COJN',0,'9f1b5cc6-29db-45cb-b18c-4bb87c157e1a','P013E','Beheizte Lambdasonde 2, Zylinderreihe 1 - verzögertes Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.736695Z',0),
  ('BPNL00000003COJN',0,'0da75bc4-6c7b-4195-8790-972b22bafa44','P013F','Beheizte Lambdasonde 2, Zylinderreihe 1 - verzögertes Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.741826Z',0),
  ('BPNL00000003COJN',0,'0ba51750-9718-48b9-b816-34e95d10a510','P0140','Beheizte Lambdasonde 2, Zylinderreihe 1 - funktionslos','Kabelbaum, Heizelement funktionslos, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.746855Z',0),
  ('BPNL00000003COJN',0,'e577aeee-bf4d-4426-bd26-ca19ca5faec3','P0141','Beheizte Lambdasonde 2, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.757038Z',0),
  ('BPNL00000003COJN',0,'6c26fb52-1977-45b6-84de-2cf978bc72d9','P0142','Beheizte Lambdasonde 3, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.762182Z',0),
  ('BPNL00000003COJN',0,'55f53a34-9668-4789-8c9d-97940ab717f8','P0143','Beheizte Lambdasonde 3, Zylinderreihe 1 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.766980Z',0),
  ('BPNL00000003COJN',0,'6eeabecc-c3f2-4d4a-831c-cbac0651c2f7','P0144','Beheizte Lambdasonde 3, Zylinderreihe 1 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.779068Z',0),
  ('BPNL00000003COJN',0,'59880b94-ea44-4159-b557-ac1c3a2b5460','P0145','Beheizte Lambdasonde 3, Zylinderreihe 1 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.790613Z',0),
  ('BPNL00000003COJN',0,'8696cbc0-5f4e-4f9e-b11e-cab93f0ce197','P0146','Beheizte Lambdasonde 3, Zylinderreihe 1 - funktionslos','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.800570Z',0),
  ('BPNL00000003COJN',0,'16f2c7c0-b270-42d6-b930-2019185ed9a4','P0147','Beheizte Lambdasonde 3, Zylinderreihe 1, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.812570Z',0),
  ('BPNL00000003COJN',0,'4b0abec1-90e8-4118-b5f5-81893906aa15','P0148','Falsche Kraftstofffördermenge','Kraftstoffpumpe/Einspritzpumpe','2022-05-11T11:16:15.818347Z',0),
  ('BPNL00000003COJN',0,'f7cee725-0aaa-486c-acad-09d3c6c05a5f','P0149','Falscher Einpritzzeitpunkt','Kraftstoffpumpe/Einspritzpumpe','2022-05-11T11:16:15.823939Z',0),
  ('BPNL00000003COJN',0,'b4b1116a-e826-4f77-8098-cc156c03346a','P014A','Beheizte Lambdasonde 2, Zylinderreihe 2 - verzögertes Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.828955Z',0),
  ('BPNL00000003COJN',0,'b190de6e-5cbe-4c3e-a7e4-0463f53ee868','P014B','Beheizte Lambdasonde 2, Zylinderreihe 2 - verzögertes Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.834311Z',0),
  ('BPNL00000003COJN',0,'b4e434f3-1dfa-4195-90f1-4dc7abd2ec83','P014C','Beheizte Lambdasonde 1, Zylinderreihe 1 - träges Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.839530Z',0),
  ('BPNL00000003COJN',0,'98bfe826-54ef-4f39-a591-1dc63c62bb67','P014D','Beheizte Lambdasonde 1, Zylinderreihe 1 - träges Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.844595Z',0),
  ('BPNL00000003COJN',0,'6492f5cf-0dfd-44f3-8404-fcc3230d8375','P014E','Beheizte Lambdasonde 1, Zylinderreihe 2 - träges Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.849714Z',0),
  ('BPNL00000003COJN',0,'33889341-8a57-41ab-b965-31ecd347a65b','P014F','Beheizte Lambdasonde 1, Zylinderreihe 2 - träges Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.854890Z',0),
  ('BPNL00000003COJN',0,'9971985a-d4bd-4975-9486-50731608c997','P0150','Beheizte Lambdasonde 1, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.859711Z',0),
  ('BPNL00000003COJN',0,'15c99179-8011-4e77-a6fa-8cdec786c1ba','P0151','Beheizte Lambdasonde 1, Zylinderreihe 2 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.869287Z',0),
  ('BPNL00000003COJN',0,'d787e99f-8767-4751-931d-a7315ead79be','P015A','Beheizte Lambdasonde 1, Zylinderreihe 1 - verzögertes Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.874625Z',0),
  ('BPNL00000003COJN',0,'399986ac-0a66-457a-bca9-8f69e00778e1','P015B','Beheizte Lambdasonde 1, Zylinderreihe 1 - verzögertes Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.880212Z',0),
  ('BPNL00000003COJN',0,'7b80da6f-ad57-47d3-87e3-d7d3b8e8c1eb','P015C','Beheizte Lambdasonde 1, Zylinderreihe 2 - verzögertes Ausregelverhalten beim Übergang von fettem zu magerem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.885686Z',0),
  ('BPNL00000003COJN',0,'72c49c53-7ae0-4c8d-9a24-16871bb1a89e','P015D','Beheizte Lambdasonde 1, Zylinderreihe 2 - verzögertes Ausregelverhalten beim Übergang von magerem zu fettem Gemisch','Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.892476Z',0),
  ('BPNL00000003COJN',0,'40f5021c-c229-4cbe-9928-572735271694','P0152','Beheizte Lambdasonde 1, Zylinderreihe 2 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.905409Z',0),
  ('BPNL00000003COJN',0,'068d4b13-6cf2-4cd0-af04-704744ff44e0','P0153','Beheizte Lambdasonde 1, Zylinderreihe 2 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.915940Z',0),
  ('BPNL00000003COJN',0,'d19677a6-3f36-4bf3-a7ad-cfaa2438d484','P0154','Beheizte Lambdasonde 1, Zylinderreihe 2 - funktionslos','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.925725Z',0),
  ('BPNL00000003COJN',0,'5f00a83d-cc0a-49dc-998b-fe29f91e5536','P0155','Beheizte Lambdasonde 1, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.935077Z',0),
  ('BPNL00000003COJN',0,'c00ae8c6-7d95-445f-8710-5488a5e976fb','P0156','Beheizte Lambdasonde 2, Zylinderreihe 2 - Fehlfunktion Stromkreis','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.940730Z',0),
  ('BPNL00000003COJN',0,'4d6f5096-a554-4832-936b-76c6f92e6e22','P0157','Beheizte Lambdasonde 2, Zylinderreihe 2 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.950475Z',0),
  ('BPNL00000003COJN',0,'b4b5b910-e67e-4189-a5ee-af769b8681bb','P0158','Beheizte Lambdasonde 2, Zylinderreihe 2 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.959610Z',0),
  ('BPNL00000003COJN',0,'1c364064-5d2b-47d2-954f-f574cef85c64','P0159','Beheizte Lambdasonde 2, Zylinderreihe 2 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:15.969070Z',0),
  ('BPNL00000003COJN',0,'4ee4e6db-2a9b-4a3f-8a32-e6b8473dc474','P0160','Beheizte Lambdasonde 2, Zylinderreihe 2 - funktionslos','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.983917Z',0),
  ('BPNL00000003COJN',0,'d15b34ab-90b3-4dbc-9a4a-82ef04e9a450','P0161','Beheizte Lambdasonde 2, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:15.993517Z',0),
  ('BPNL00000003COJN',0,'8a8a9b38-8bc6-4647-9a02-4cb21a8ccb72','P0162','Beheizte Lambdasonde 3, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:16.001058Z',0),
  ('BPNL00000003COJN',0,'34908a76-ec71-4b98-9526-9ca1a300da5b','P0163','Beheizte Lambdasonde 3, Zylinderreihe 2 - Spannung zu niedrig','Auslassseitige Undichtigkeit, Kurzschluss an Masse im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:16.012720Z',0),
  ('BPNL00000003COJN',0,'4b39f96b-9f58-451d-9a5f-5c9171348473','P0164','Beheizte Lambdasonde 3, Zylinderreihe 2 - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:16.022549Z',0),
  ('BPNL00000003COJN',0,'c5ab6e26-5863-4d44-9fe7-a9e4c932d3f1','P0165','Beheizte Lambdasonde 3, Zylinderreihe 2 - träges Ausregelverhalten','Heizelement funktionslos, Kabelbaum, beheizte Lambdasonde','2022-05-11T11:16:16.032680Z',0),
  ('BPNL00000003COJN',0,'e8f2c09b-a99b-4cac-9100-8b0b60fdabf0','P0166','Beheizte Lambdasonde 3, Zylinderreihe 2 - funktionslos','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:16.042977Z',0),
  ('BPNL00000003COJN',0,'d5fc7aea-d488-402c-a612-dff919a0dd36','P0167','Beheizte Lambdasonde 3, Zylinderreihe 2, Heizregelung - Fehlfunktion Stromkreis','Kabelbaum, beheizte Lambdasonde, Motorsteuergerät','2022-05-11T11:16:16.053755Z',0),
  ('BPNL00000003COJN',0,'c281655b-e283-431a-bf77-857e7aaf7b7a','P0168','Kraftstofftemperatur zu hoch','Kabelbaum, Kraftstofftemperatursensor, mechanische Fehlfunktion','2022-05-11T11:16:16.058931Z',0),
  ('BPNL00000003COJN',0,'a33ef62a-f394-4f67-a55e-ee8508df19f3','P0169','Falsche Kraftstoffzusammensetzung','Kabelbaum, Kraftstoffzusammensetzungssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.064319Z',0),
  ('BPNL00000003COJN',0,'25ca58d9-71aa-4e70-8ca3-cbd8bcbafe23','P016A','Übermäßige Vorlaufphase bis zum Erreichen eines geschlossenen Wirkungsablaufs im Gemischbildungsregelkreis','-','2022-05-11T11:16:16.070522Z',0),
  ('BPNL00000003COJN',0,'b5d00f9b-53bc-4aed-aa03-3f6ecc2fabe1','P016B','Geschlossener Gemischbildungsregelkreis, Grenzwert erreicht - Gemisch zu fett','-','2022-05-11T11:16:16.075811Z',0),
  ('BPNL00000003COJN',0,'66009794-0431-4a15-afcc-4446b0bd38c1','P016C','Geschlossener Gemischbildungsregelkreis, Grenzwert erreicht - Gemisch zu mager','-','2022-05-11T11:16:16.080894Z',0),
  ('BPNL00000003COJN',0,'0de25cad-de20-4f0f-ab36-b8dad74ac8dd','P016D','Übermäßige Vorlaufphase bis zum Erreichen eines geschlossenen Wirkungsablaufs im Kraftstoffdruckregelkreis','-','2022-05-11T11:16:16.086726Z',0),
  ('BPNL00000003COJN',0,'fa03ec88-8dc8-459d-9af7-3d5b9f8d3a95','P016E','Geschlossener Kraftstoffdruckregelkreis, Grenzwert erreicht - Druck zu hoch','-','2022-05-11T11:16:16.091173Z',0),
  ('BPNL00000003COJN',0,'7b25eeaf-aabc-4694-bff1-48fb3b4d5984','P016F','Geschlossener Kraftstoffdruckregelkreis, Grenzwert erreicht - Druck zu niedrig','-','2022-05-11T11:16:16.096962Z',0),
  ('BPNL00000003COJN',0,'05b499b2-f7c3-464a-8910-be6f70227bbc','P0170','Kraftstoffregelung, Zylinderreihe 1 - Fehlfunktion','Einlassseitige Undichtigkeit, Sekundärlufteinblasung, Kraftstoffdruck/-pumpe, Einspritzventil(e)/-düse(n), Kraftstoffdampf-Aktivkohlefilter-Magnetventil, beheizte Lambdasonde','2022-05-11T11:16:16.103448Z',0),
  ('BPNL00000003COJN',0,'526abcc0-bd14-47ea-854c-caa32a3c16f7','P0171','Gemisch zu mager, Zylinderreihe 1','Einlass-/auslassseitige Undichtigkeit, Sekundärlufteinblasung, Luftmassenmesser/Luftmengenmesser, Kraftstoffdruck/-pumpe, Einspritzventil(e)/-düse(n), beheizte Lambdasonde','2022-05-11T11:16:16.113637Z',0),
  ('BPNL00000003COJN',0,'a8d784da-aeb0-40d0-b2d0-027d3816e920','P04BA','Tankklappensensor/-schalter - Signal zu hoch','Kabelbaum, Tankklappensensor/-schalter','2022-05-11T11:16:20.122057Z',0),
  ('BPNL00000003COJN',0,'8f9f801c-7680-46f6-82dc-093e7fc1e35a','P0172','Gemisch zu fett, Zylinderreihe 1','Ansaugsystem blockiert, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Kraftstoffdruck, AGR-System, Einspritzventil(e)/-düse(n), beheizte Lambdasonde','2022-05-11T11:16:16.118740Z',0),
  ('BPNL00000003COJN',0,'316fba3e-8bfe-4ac4-8830-6d2274311ada','P0173','Kraftstoffregelung, Zylinderreihe 2 - Fehlfunktion','Einlassseitige Undichtigkeit, Sekundärlufteinblasung, Kraftstoffdruck/-pumpe, Einspritzventil(e)/-düse(n), Kraftstoffdampf-Aktivkohlefilter-Magnetventil, beheizte Lambdasonde','2022-05-11T11:16:16.123738Z',0),
  ('BPNL00000003COJN',0,'984bdad6-fcff-471f-8c0a-fec936846147','P0174','Gemisch zu mager, Zylinderreihe 2','Einlass-/auslassseitige Undichtigkeit, Kraftstoffdruck/-pumpe, Einspritzventil(e)/-düse(n), Sekundärlufteinblasung, Schlauchverbindung(en)','2022-05-11T11:16:16.128783Z',0),
  ('BPNL00000003COJN',0,'212d8f0c-3c0a-467c-b005-3af424137012','P0175','Gemisch zu fett, Zylinderreihe 2','Ansaugsystem blockiert, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Kraftstoffdruck, AGR-System, Einspritzventil(e)/-düse(n), beheizte Lambdasonde','2022-05-11T11:16:16.133938Z',0),
  ('BPNL00000003COJN',0,'b18e2c57-64f6-4821-b129-53b2a5d85d39','P0176','Kraftstoffzusammensetzungssensor - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffzusammensetzungssensor, Motorsteuergerät','2022-05-11T11:16:16.139148Z',0),
  ('BPNL00000003COJN',0,'32da1947-8888-4e6f-b434-7a68b589d0de','P0177','Kraftstoffzusammensetzungssensor - Bereichs-/Funktionsfehler','Kraftstoffzusammensetzungssensor','2022-05-11T11:16:16.144532Z',0),
  ('BPNL00000003COJN',0,'a26228b2-5970-4576-a577-6dc2619fbdc4','P0178','Kraftstoffzusammensetzungssensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffzusammensetzungssensor, Motorsteuergerät','2022-05-11T11:16:16.149594Z',0),
  ('BPNL00000003COJN',0,'e494dda0-d1b7-4065-9089-5ee1d0a7d023','P0179','Kraftstoffzusammensetzungssensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffzusammensetzungssensor, Motorsteuergerät','2022-05-11T11:16:16.154411Z',0),
  ('BPNL00000003COJN',0,'6b34f373-4cd8-49d2-a504-6a155ec22d57','P017A','Zylinderkopftemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Zylinderkopftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.158959Z',0),
  ('BPNL00000003COJN',0,'29586396-0525-4b2c-8be2-b444fac4f2d8','P017B','Zylinderkopftemperatursensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderkopftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.163702Z',0),
  ('BPNL00000003COJN',0,'ae0e1d27-44e6-41b6-adfc-c70c8a54a326','P017C','Zylinderkopftemperatursensor - Signal zu niedrig','Kabelbaum, Zylinderkopftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.168751Z',0),
  ('BPNL00000003COJN',0,'df402391-1762-48cc-aeda-90245426b792','P017D','Zylinderkopftemperatursensor - Signal zu hoch','Kabelbaum, Zylinderkopftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.173911Z',0),
  ('BPNL00000003COJN',0,'be26aef4-f42c-4ed5-a57f-00071808a4a6','P017E','Zylinderkopftemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderkopftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.179180Z',0),
  ('BPNL00000003COJN',0,'cbf8e65e-30ed-4ccb-855d-2d1c983ec24f','P0180','Kraftstofftemperatursensor A - Fehlfunktion Stromkreis','Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.185301Z',0),
  ('BPNL00000003COJN',0,'7b286643-d150-413b-8ea9-e8a9ed6e51c6','P0181','Kraftstofftemperatursensor A - Bereichs-/Funktionsfehler','Kraftstofftemperatursensor','2022-05-11T11:16:16.190720Z',0),
  ('BPNL00000003COJN',0,'18cef877-90e3-4ed9-9b99-584a7d8685e0','P0182','Kraftstofftemperatursensor A - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.195660Z',0),
  ('BPNL00000003COJN',0,'eb41499f-ab1a-47f4-b14f-9f6637e840d6','P0183','Kraftstofftemperatursensor A - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.200982Z',0),
  ('BPNL00000003COJN',0,'69b9f100-c6aa-4e17-8f43-5d025e696cdf','P0184','Kraftstofftemperatursensor A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.206267Z',0),
  ('BPNL00000003COJN',0,'63255ca9-fe29-48f5-95d4-c498a78e1243','P0185','Kraftstofftemperatursensor B - Fehlfunktion Stromkreis','Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.211269Z',0),
  ('BPNL00000003COJN',0,'615d2ca6-ed4f-4ddb-852e-bd0b0613d5d4','P0186','Kraftstofftemperatursensor B - Bereichs-/Funktionsfehler','Kraftstofftemperatursensor','2022-05-11T11:16:16.215905Z',0),
  ('BPNL00000003COJN',0,'62039bbf-eba3-49ae-aee2-db276ac00216','P0187','Kraftstofftemperatursensor B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.221870Z',0),
  ('BPNL00000003COJN',0,'acc38a00-011e-4224-b755-28e75d8a70cd','P0188','Kraftstofftemperatursensor B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.229141Z',0),
  ('BPNL00000003COJN',0,'deb460cd-642a-4632-a224-e0bee1ae0e1e','P0189','Kraftstofftemperatursensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstofftemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.234713Z',0),
  ('BPNL00000003COJN',0,'d8c4eb64-869a-4ac1-8c49-2a7dd90dcc46','P018A','Kraftstoffdrucksensor B - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.242093Z',0),
  ('BPNL00000003COJN',0,'f1bcc08a-5e12-4f93-9d16-c6db15030e13','P018B','Kraftstoffdrucksensor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kraftstoffdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.248459Z',0),
  ('BPNL00000003COJN',0,'a972a916-dbb3-4aed-9a68-eba91a0cb40c','P018C','Kraftstoffdrucksensor B - Signal zu niedrig','Kabelbaum, Kraftstoffdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.254320Z',0),
  ('BPNL00000003COJN',0,'b92b2385-c31c-4eec-a569-1f60cdb4370d','P018D','Kraftstoffdrucksensor B - Signal zu hoch','Kabelbaum, Kraftstoffdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.259089Z',0),
  ('BPNL00000003COJN',0,'edbceb99-c956-4522-b44c-5052313876db','P018E','Kraftstoffdrucksensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Kraftstoffdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.264711Z',0),
  ('BPNL00000003COJN',0,'7911a4bb-7709-45f1-a44f-accd852f36ee','P018F','Kraftstoff-Überdruckregelsystem - häufige Ansteuerung','-','2022-05-11T11:16:16.270078Z',0),
  ('BPNL00000003COJN',0,'53a20db7-f8b6-460c-ae00-934416886cee','P0190','Kraftstoffverteilerdrucksensor - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffverteilerdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.275476Z',0),
  ('BPNL00000003COJN',0,'c5098f56-3191-4bd4-962d-0d4529d7b146','P0191','Kraftstoffverteilerdrucksensor - Bereichs-/Funktionsfehler','Kabelbaum, Kraftstoffverteilerdrucksensor','2022-05-11T11:16:16.280259Z',0),
  ('BPNL00000003COJN',0,'318f603f-a0f9-4a38-ab68-ad8131a8e86e','P0192','Kraftstoffverteilerdrucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffverteilerdrucksensor','2022-05-11T11:16:16.286252Z',0),
  ('BPNL00000003COJN',0,'952ddd1c-6497-4084-82f7-66b9358429da','P0193','Kraftstoffverteilerdrucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffverteilerdrucksensor','2022-05-11T11:16:16.291276Z',0),
  ('BPNL00000003COJN',0,'951a8754-3e97-442a-baff-fce605e8bb20','P0194','Kraftstoffverteilerdrucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstoffverteilerdrucksensor','2022-05-11T11:16:16.296343Z',0),
  ('BPNL00000003COJN',0,'4118344b-7fa6-4220-b075-6a68c61af0fb','P0195','Motoröltemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Motoröltemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.301448Z',0),
  ('BPNL00000003COJN',0,'6c1de8d4-bc83-4c68-a8b7-7166d574462b','P0196','Motoröltemperatursensor - Bereichs-/Funktionsfehler','Motoröltemperatursensor','2022-05-11T11:16:16.306533Z',0),
  ('BPNL00000003COJN',0,'64f7e36a-8e01-46ff-a937-ef3914ebc3b3','P0197','Motoröltemperatursensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motoröltemperatursensor','2022-05-11T11:16:16.312151Z',0),
  ('BPNL00000003COJN',0,'02d9daeb-317a-4804-a84f-c760d3ab42c4','P0198','Motoröltemperatursensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Motoröltemperatursensor','2022-05-11T11:16:16.317334Z',0),
  ('BPNL00000003COJN',0,'9d8aee51-7d81-47a1-9699-f26a0ca12e75','P0199','Motoröltemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motoröltemperatursensor, Motorsteuergerät','2022-05-11T11:16:16.322844Z',0),
  ('BPNL00000003COJN',0,'dbc5fe37-a3df-4110-8d40-4aa60eb950ba','P0200','Einspritzventil/-düse - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.327927Z',0),
  ('BPNL00000003COJN',0,'aa1a27ac-175a-4c3a-a731-9586edf2b39d','P0201','Einspritzventil/-düse 1 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.332943Z',0),
  ('BPNL00000003COJN',0,'1d538b20-b902-4ff5-9046-486dc1f931be','P0202','Einspritzventil/-düse 2 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.338437Z',0),
  ('BPNL00000003COJN',0,'b50abdab-e8b1-43a9-aa45-3eece2d8895e','P0203','Einspritzventil/-düse 3 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.344114Z',0),
  ('BPNL00000003COJN',0,'4c3743ac-811b-4ebd-8e29-ef508a6b38a3','P0204','Einspritzventil/-düse 4 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.349672Z',0),
  ('BPNL00000003COJN',0,'3540f6f5-86a4-4a0b-80dc-9564ff986755','P0205','Einspritzventil/-düse 5 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.354953Z',0),
  ('BPNL00000003COJN',0,'acc4d229-cf63-4ae4-b9c7-4e2922099f61','P0206','Einspritzventil/-düse 6 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.360552Z',0),
  ('BPNL00000003COJN',0,'a061c64b-b8f3-4d0c-8c83-a85b8dc78540','P0207','Einspritzventil/-düse 7 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.366097Z',0),
  ('BPNL00000003COJN',0,'fc6d0548-9260-4b48-947e-2848628c87c8','P0208','Einspritzventil/-düse 8 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.373032Z',0),
  ('BPNL00000003COJN',0,'201fe420-40dd-4bd5-8c53-c9d9592c8ae4','P0209','Einspritzventil/-düse 9 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.378654Z',0),
  ('BPNL00000003COJN',0,'a20b8b8b-a483-4a58-9438-b435d2765587','P020A','Einspritzregelung, Zylinder 1','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.383706Z',0),
  ('BPNL00000003COJN',0,'88a9b695-0674-4b7d-8d6e-79380e5bb0f2','P020B','Einspritzregelung, Zylinder 2','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.388624Z',0),
  ('BPNL00000003COJN',0,'f5d1eceb-369c-4336-814d-f0d311244c5b','P020C','Einspritzregelung, Zylinder 3','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.394381Z',0),
  ('BPNL00000003COJN',0,'9211c10c-111c-4b41-a6e0-2e73bab64abd','P020D','Einspritzregelung, Zylinder 4','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.399644Z',0),
  ('BPNL00000003COJN',0,'58a0d3d7-a5e8-4b7b-9c2b-b83e82b126ba','P020E','Einspritzregelung, Zylinder 5','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.405083Z',0),
  ('BPNL00000003COJN',0,'827c8b7f-462c-4853-ac9f-5db3b6c96f0a','P020F','Einspritzregelung, Zylinder 6','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.411049Z',0),
  ('BPNL00000003COJN',0,'012f9c48-371e-46eb-a847-f6cfe78b5070','P0210','Einspritzventil/-düse 10 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.416240Z',0),
  ('BPNL00000003COJN',0,'4fbe3058-82f0-40ed-aca4-8cf0a9ed0881','P0211','Einspritzventil/-düse 11 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.421143Z',0),
  ('BPNL00000003COJN',0,'44650803-2d27-439c-a935-a15f77f3a32b','P0212','Einspritzventil/-düse 12 - Fehlfunktion Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.426975Z',0),
  ('BPNL00000003COJN',0,'b841dc96-ea53-4738-a157-ceecd19c8c39','P0213','Kaltstartventil 1 - Fehlfunktion Stromkreis','Kabelbaum, Kaltstartventil, Motorsteuergerät','2022-05-11T11:16:16.431860Z',0),
  ('BPNL00000003COJN',0,'835c6687-55a5-4267-8413-e5d4dd679d88','P0214','Kaltstartventil 2 - Fehlfunktion Stromkreis','Kabelbaum, Kaltstartventil, Motorsteuergerät','2022-05-11T11:16:16.437381Z',0),
  ('BPNL00000003COJN',0,'ba94156c-1a3d-4d1a-96c3-34107da9ea73','P0215','Kraftstoff-Abschaltmagnetventil - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoff-Abschaltmagnetventil, Motorsteuergerät','2022-05-11T11:16:16.442677Z',0),
  ('BPNL00000003COJN',0,'88d49731-7ea7-4d52-8ef3-fabb2411e44e','P0216','Kraftstoff-Einspritzregelung - Fehlfunktion Stromkreis','Kabelbaum, Einspritzregelung-Magnetventil, Motorsteuergerät','2022-05-11T11:16:16.447857Z',0),
  ('BPNL00000003COJN',0,'0facf145-6333-46e2-b18d-258b5fd95f41','P0217','Motor-Überhitzung','Kabelbaum, Motorkühlsystem, Kühlmittelthermostat, Kühlmitteltemperatursensor','2022-05-11T11:16:16.453609Z',0),
  ('BPNL00000003COJN',0,'5fbd363e-6289-4604-a30a-865fcae78c2a','P0219','Motor-Überdrehzahl','Fehlerhafter Gangwechsel','2022-05-11T11:16:16.463954Z',0),
  ('BPNL00000003COJN',0,'1f11882d-ae8b-4f62-a598-ace5a46d8e16','P021A','Einspritzregelung, Zylinder 7','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.468816Z',0),
  ('BPNL00000003COJN',0,'85fa34cf-1e11-42ac-8316-5086c6b6e8b0','P021B','Einspritzregelung, Zylinder 8','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.473609Z',0),
  ('BPNL00000003COJN',0,'9d6ef26a-9867-4c86-bc5a-95e4e4b6eaae','P021C','Einspritzregelung, Zylinder 9','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.478774Z',0),
  ('BPNL00000003COJN',0,'80af8ad1-e3af-4451-af8b-c922274e22de','P021D','Einspritzregelung, Zylinder 10','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.484026Z',0),
  ('BPNL00000003COJN',0,'c1e7a7be-2e52-45c0-88e7-728d78fc9fdc','P021E','Einspritzregelung, Zylinder 11','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.489072Z',0),
  ('BPNL00000003COJN',0,'b0673a21-eed8-4e64-a6f6-5e4ded396a9d','P021F','Einspritzregelung, Zylinder 12','Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion','2022-05-11T11:16:16.493752Z',0),
  ('BPNL00000003COJN',0,'4562cf5f-e2b5-4174-b088-9e8545bea857','P0220','Drosselklappenpotenziometer B/Fahrpedalsensor B - Fehlfunktion Stromkreis','Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.498393Z',0),
  ('BPNL00000003COJN',0,'df7d0016-e2a2-43a8-9b36-4dfa70950093','P0218','Getriebe-Überhitzung','Kabelbaum, Getriebeöltemperatursensor, Motorsteuergerät, Automatikgetriebe','2022-05-11T11:16:16.458722Z',1),
  ('BPNL00000003COJN',0,'54e9c741-8402-4a83-aa9d-844067c15cf0','P0221','Drosselklappenpotenziometer B/Fahrpedalsensor B - Bereichs-/Funktionsfehler','Einstellung Fahrpedalzug, Drosselklappenpotenziometer/Fahrpedalsensor','2022-05-11T11:16:16.508383Z',0),
  ('BPNL00000003COJN',0,'a43dabc3-20b1-4f08-9d39-1318481c50d6','P0222','Drosselklappenpotenziometer B/Fahrpedalsensor B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.519716Z',0),
  ('BPNL00000003COJN',0,'1c9556da-c1af-4208-bd50-4292dfaa1948','P0223','Drosselklappenpotenziometer B/Fahrpedalsensor B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.531833Z',0),
  ('BPNL00000003COJN',0,'d595b8a0-5b99-414b-afd0-d9dd54a0a3db','P0224','Drosselklappenpotenziometer B/Fahrpedalsensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.542383Z',0),
  ('BPNL00000003COJN',0,'b851ae87-bb6a-40d2-8a75-c3fc62574c56','P0225','Drosselklappenpotenziometer C/Fahrpedalsensor C - Fehlfunktion Stromkreis','Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.552149Z',0),
  ('BPNL00000003COJN',0,'4d720e81-77f3-4dea-990f-a6ffde98a39f','P0226','Drosselklappenpotenziometer C/Fahrpedalsensor C - Bereichs-/Funktionsfehler','Einstellung Fahrpedalzug, Drosselklappenpotenziometer/Fahrpedalsensor','2022-05-11T11:16:16.568011Z',0),
  ('BPNL00000003COJN',0,'b809c933-2b3a-4686-8e58-1a4361767722','P0227','Drosselklappenpotenziometer C/Fahrpedalsensor C - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.578868Z',0),
  ('BPNL00000003COJN',0,'a03460c2-afc6-4355-9606-7d74b2f9793e','P0228','Drosselklappenpotenziometer C/Fahrpedalsensor C - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.588697Z',0),
  ('BPNL00000003COJN',0,'5fd6ff2e-0fc3-4ebb-a1c2-c2c8118746a6','P07A0','Getriebereibelement G - Schlupf festgestellt','Automatikgetriebe, Automatikgetriebeöl','2022-05-11T11:16:23.309062Z',2),
  ('BPNL00000003COJN',0,'16c83da0-fe08-48a6-bbbf-88da78e8a8da','P0229','Drosselklappenpotenziometer C/Fahrpedalsensor C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Drosselklappenpotenziometer/Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:16.604611Z',0),
  ('BPNL00000003COJN',0,'f8f96e1d-f137-42d2-b716-c13db0546ef2','P022A','Turboladeluftkühler-Bypass-Stellglied A - offener Stromkreis','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.614397Z',0),
  ('BPNL00000003COJN',0,'bcf9ff83-3c92-4b60-9ff8-75b3bfa5ab90','P022B','Steuerung Turboladeluftkühler-Bypass-Stellglied A - Signal zu niedrig','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.619236Z',0),
  ('BPNL00000003COJN',0,'7193bd6e-5360-44a8-8493-6f3454467b46','P022C','Turboladeluftkühler-Bypass-Stellglied A - Signal zu hoch','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.626670Z',0),
  ('BPNL00000003COJN',0,'38aa7627-73e1-4dfb-aaf0-071e394c9bc8','P022D','Steuerung Turboladeluftkühler-Bypass-Stellglied B - offener Stromkreis','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.631718Z',0),
  ('BPNL00000003COJN',0,'953bffcb-f674-4e76-befd-9dc0d3024ca9','P022E','Steuerung Turboladeluftkühler-Bypass-Stellglied B - Signal zu niedrig','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.636854Z',0),
  ('BPNL00000003COJN',0,'caf6720d-a85b-4bab-b215-0965575b93ec','P022F','Steuerung Turboladeluftkühler-Bypass-Stellglied B - Signal zu hoch','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.641309Z',0),
  ('BPNL00000003COJN',0,'f48c972c-29f9-47e7-9950-dd3bac82b0e4','P0230','Kraftstoffpumpenrelais - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffpumpenrelais, Motorsteuergerät','2022-05-11T11:16:16.646168Z',0),
  ('BPNL00000003COJN',0,'31fedcec-35a2-4898-ad6b-e67ee5383096','P0231','Kraftstoffpumpenrelais - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffpumpenrelais, Motorsteuergerät','2022-05-11T11:16:16.651300Z',0),
  ('BPNL00000003COJN',0,'c7fb7b34-b572-489b-b7ce-1942ca084ddd','P0232','Kraftstoffpumpenrelais - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffpumpenrelais, Motorsteuergerät','2022-05-11T11:16:16.656166Z',0),
  ('BPNL00000003COJN',0,'67239727-486f-40bc-a569-3434d9b05596','P0233','Kraftstoffpumpenrelais - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstoffpumpenrelais, Motorsteuergerät','2022-05-11T11:16:16.661193Z',0),
  ('BPNL00000003COJN',0,'402f3357-bab3-40a3-a5ae-9ffb80d964d7','P0234','Turbolader, Motoraufladung - Grenzwert überschritten','Schlauchverbindung(en), Kabelbaum, Ladedruck-Regelventil, Ladedruckventil','2022-05-11T11:16:16.666159Z',0),
  ('BPNL00000003COJN',0,'a4105f56-02b1-4aa9-a7a1-d7334b8aa72d','P0235','Saugrohrdrucksensor A, Turboladersystem - Fehlfunktion Stromkreis','Kabelbaum, Saugrohrdrucksensor','2022-05-11T11:16:16.679144Z',0),
  ('BPNL00000003COJN',0,'ebfa2fd5-5880-4123-964e-5f11fad4f107','P0236','Saugrohrdrucksensor A, Turboladersystem - Bereichs-/Funktionsfehler','Einlass-/auslassseitige Undichtigkeit, Schlauchverbindung(en), Saugrohrdrucksensor','2022-05-11T11:16:16.690048Z',0),
  ('BPNL00000003COJN',0,'506b1bf3-34db-4dd2-bf7f-30dd5ab7062f','P0237','Saugrohrdrucksensor A, Turboladersystem - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.702743Z',0),
  ('BPNL00000003COJN',0,'8e69cfee-463c-412b-a7af-0b15e4362917','P0238','Saugrohrdrucksensor A, Turboladersystem - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.716610Z',0),
  ('BPNL00000003COJN',0,'82aae5a7-771e-49c6-9c8c-1fe06a6dc41f','P0239','Saugrohrdrucksensor B, Turboladersystem - Fehlfunktion Stromkreis','Kabelbaum, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.729153Z',0),
  ('BPNL00000003COJN',0,'710f9962-79cb-41fd-9e61-09657b137786','P023A','Turbolader-Kühlmittelpumpe - offener Stromkreis','Kabelbaum, Turbolader-Kühlmittelpumpe, Motorsteuergerät','2022-05-11T11:16:16.740290Z',0),
  ('BPNL00000003COJN',0,'464de1f9-edb4-4c2b-9cbd-501fc599ec42','P023B','Turbolader-Kühlmittelpumpe - Signal zu niedrig','Kabelbaum, Turbolader-Kühlmittelpumpe, Motorsteuergerät','2022-05-11T11:16:16.745649Z',0),
  ('BPNL00000003COJN',0,'b75ae314-d602-42e1-b1bc-0a0f8e93e39b','P023C','Turbolader-Kühlmittelpumpe - Signal Steuerstromkreis zu hoch','Kabelbaum, Turbolader-Kühlmittelpumpe, Motorsteuergerät','2022-05-11T11:16:16.750572Z',0),
  ('BPNL00000003COJN',0,'94099871-47be-446f-8566-895beb065f64','P023D','Saugrohrdrucksensor/Turbo-/Kompressorladedrucksensor A - Bezugsfehler','Kabelbaum, Saugrohrdrucksensor, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:16.755408Z',0),
  ('BPNL00000003COJN',0,'9bc6ffff-c493-42e5-a94c-6d45f2c9679b','P023E','Saugrohrdrucksensor/Turbo-/Kompressorladedrucksensor B - Bezugsfehler','Kabelbaum, Saugrohrdrucksensor, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:16.760596Z',0),
  ('BPNL00000003COJN',0,'ea7968ed-c2aa-4955-94e9-84206d665aaf','P023F','Kraftstoffpumpe, sekundär - offener Stromkreis','Kabelbaum, Kraftstoffpumpe, Kraftstoffpumpenrelais, Motorsteuergerät','2022-05-11T11:16:16.766005Z',0),
  ('BPNL00000003COJN',0,'f7b2f281-c9c5-4232-895c-e25414b9d7b1','P0240','Saugrohrdrucksensor B, Turboladersystem - Bereichs-/Funktionsfehler','Einlass-/auslassseitige Undichtigkeit, Schlauchverbindung(en), Saugrohrdrucksensor','2022-05-11T11:16:16.770592Z',0),
  ('BPNL00000003COJN',0,'0408ea81-34f1-43fd-bf07-f5c2701209b4','P0241','Saugrohrdrucksensor B, Turboladersystem - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.781298Z',0),
  ('BPNL00000003COJN',0,'e4bfbf2e-4492-4b4b-946f-fe277d0e5811','P0242','Saugrohrdrucksensor B, Turboladersystem - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:16.789840Z',0),
  ('BPNL00000003COJN',0,'b9c82718-cda1-49c5-84c5-fd28bc87c069','P0243','Motoraufladungskompressor-Bypassventil A - Fehlfunktion Stromkreis','Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.799884Z',0),
  ('BPNL00000003COJN',0,'0fb73b89-9461-4cfe-a550-e6c2f07310b0','P0244','Motoraufladungskompressor-Bypassventil A - Bereichs-/Funktionsfehler','Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:16.808600Z',0),
  ('BPNL00000003COJN',0,'7b360fad-632c-4e30-b599-df3826d411af','P0245','Motoraufladungskompressor-Bypassventil A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.817932Z',0),
  ('BPNL00000003COJN',0,'bc860121-b797-4956-a0cd-4c363a3e3f37','P0246','Motoraufladungskompressor-Bypassventil A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.827089Z',0),
  ('BPNL00000003COJN',0,'b1dacf79-8cc9-45da-a803-b222c99c3282','P0247','Motoraufladungskompressor-Bypassventil B - Fehlfunktion Stromkreis','Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.838620Z',0),
  ('BPNL00000003COJN',0,'b6aa07c7-951f-49ae-8aa8-071450a42de1','P0248','Motoraufladungskompressor-Bypassventil B - Bereichs-/Funktionsfehler','Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:16.847917Z',0),
  ('BPNL00000003COJN',0,'bcfff0d2-3ca9-4968-b349-313d4e7fd799','P0249','Motoraufladungskompressor-Bypassventil B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.857509Z',0),
  ('BPNL00000003COJN',0,'7bea41af-3a79-4e0a-a66e-c71a81b0da28','P024A','Turboladeluftkühler-Bypass-Stellglied A - Bereichs-/Funktionsfehler','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, Motorsteuergerät','2022-05-11T11:16:16.867112Z',0),
  ('BPNL00000003COJN',0,'dc77d718-615a-4d14-b97f-81f7227872af','P024B','Turboladeluftkühler-Bypass-Stellglied A - Stellglied klemmt','Kabelbaum, Ladeluftkühler-Bypass-Stellglied, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:16.872348Z',0),
  ('BPNL00000003COJN',0,'9bb63f70-d978-45ce-9650-4964897fbe04','P024C','Stellungssensor für Turboladeluftkühler-Bypassstellglied A - Fehlfunktion Stromkreis','Kabelbaum, Ladeluftkühler-Bypass-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:16.876865Z',0),
  ('BPNL00000003COJN',0,'d367cda6-cb13-4f75-af60-c57730e76c25','P024D','Ladeluftkühler-Bypassstellungssensor A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Ladeluftkühler-Bypassstellungssensor, Motorsteuergerät','2022-05-11T11:16:16.882239Z',0),
  ('BPNL00000003COJN',0,'24f76020-4e68-4244-8a72-99cfe66da21d','P024E','Stellungssensor für Turboladeluftkühler-Bypassstellglied A - Signal zu niedrig','Kabelbaum, Ladeluftkühler-Bypass-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:16.887439Z',0),
  ('BPNL00000003COJN',0,'36b022a6-77e0-4851-bea9-f777535d7077','P024F','Stellungssensor für Turboladeluftkühler-Bypassstellglied A - Signal zu hoch','Kabelbaum, Ladeluftkühler-Bypass-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:16.892402Z',0),
  ('BPNL00000003COJN',0,'3b11614c-bb5f-4677-a749-34ff2aa1c596','P0250','Motoraufladungskompressor-Bypassventil B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Motoraufladungskompressor-Bypassventil, Motorsteuergerät','2022-05-11T11:16:16.897688Z',0),
  ('BPNL00000003COJN',0,'84ef0a1a-35c7-4975-99b6-99cf072df070','P0251','Einspritzpumpen-Mengendosierung A, Nockenring/Rotor/Einspritzventil/-düse - Fehlfunktion Stromkreis','Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.907602Z',0),
  ('BPNL00000003COJN',0,'62b9f909-3691-4ac2-9a5c-685877937d4a','P0252','Einspritzpumpen-Mengendosierung A, Nockenring/Rotor/Einspritzventil/-düse - Bereichs-/Funktionsfehler','Einspritzpumpe','2022-05-11T11:16:16.913038Z',0),
  ('BPNL00000003COJN',0,'ea8cc16e-9395-4ef3-a14d-33ba32962499','P0253','Einspritzpumpen-Mengendosierung A, Nockenring/Rotor/Einspritzventil/-düse - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.918373Z',0),
  ('BPNL00000003COJN',0,'974509e2-24a4-4807-9776-439805fc89cf','P0254','Einspritzpumpen-Mengendosierung A, Nockenring/Rotor/Einspritzventil/-düse - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.923737Z',0),
  ('BPNL00000003COJN',0,'668da4dd-12ca-4bb3-ac5d-bc0d2ae58b98','P0255','Einspritzpumpen-Mengendosierung A, Nockenring/Rotor/Einspritzventil/-düse - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.930276Z',0),
  ('BPNL00000003COJN',0,'1e55f315-5772-42e8-ac67-2ae08925081c','P0256','Einspritzpumpen-Mengendosierung B, Nockenring/Rotor/Einspritzventil/-düse - Fehlfunktion Stromkreis','Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.935869Z',0),
  ('BPNL00000003COJN',0,'4c305715-6294-4645-b9c6-3653fa0020d1','P0257','Einspritzpumpen-Mengendosierung B, Nockenring/Rotor/Einspritzventil/-düse - Bereichs-/Funktionsfehler','Einspritzpumpe','2022-05-11T11:16:16.941920Z',0),
  ('BPNL00000003COJN',0,'2ce465d1-421a-4abe-a770-e2787852cf17','P0258','Einspritzpumpen-Mengendosierung B, Nockenring/Rotor/Einspritzventil/-düse - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.946842Z',0),
  ('BPNL00000003COJN',0,'911aa5d5-adae-4ef4-9eab-d5fb5d52489e','P0259','Einspritzpumpen-Mengendosierung B, Nockenring/Rotor/Einspritzventil/-düse - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.952344Z',0),
  ('BPNL00000003COJN',0,'56ec7fde-4494-4b9f-a327-b565a55b6b12','P025A','Kraftstoffpumpen-Steuergerät - offener Stromkreis','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:16.956949Z',0),
  ('BPNL00000003COJN',0,'255bb712-ac52-4e6d-9fbd-b714e5007223','P025B','Kraftstoffpumpen-Steuergerät - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:16.963183Z',0),
  ('BPNL00000003COJN',0,'766a6be0-48e4-4835-a7f4-5fde84293f8e','P025C','Kraftstoffpumpen-Steuergerät - Signal zu niedrig','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:16.968440Z',0),
  ('BPNL00000003COJN',0,'3618d7b1-99a3-46d9-8e6a-b7de917df18c','P025D','Kraftstoffpumpen-Steuergerät - Signal zu hoch','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:16.972992Z',0),
  ('BPNL00000003COJN',0,'a20640bf-2dce-49b1-8925-eb0e6754f381','P025E','Turbo-/Kompressorladedrucksensor A - intermittierendes/sporadisches Signal','Kabelbaum, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:16.977465Z',0),
  ('BPNL00000003COJN',0,'9af80401-f3b2-4cb5-ba01-7b2e7dd3caa6','P025F','Turbo-/Kompressorladedrucksensor B - intermittierendes/sporadisches Signal','Kabelbaum, Turbo-/Kompressorladedrucksensor, Motorsteuergerät','2022-05-11T11:16:16.982205Z',0),
  ('BPNL00000003COJN',0,'326c2eea-b5b3-4eb2-8ae6-f81428836736','P0296','Zylinder 12 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.223856Z',0),
  ('BPNL00000003COJN',0,'71b2cf35-46f8-4334-a429-75735caa7b23','P0260','Einspritzpumpen-Mengendosierung B, Nockenring/Rotor/Einspritzventil/-düse - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Einspritzpumpe, Motorsteuergerät','2022-05-11T11:16:16.986697Z',0),
  ('BPNL00000003COJN',0,'30346380-1921-4d06-8055-95b5e01c3f95','P0261','Einspritzventil/-düse 1 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:16.995815Z',0),
  ('BPNL00000003COJN',0,'bc50c463-e0f3-49f3-92b6-cb162dbe815b','P0262','Einspritzventil/-düse 1 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.001304Z',0),
  ('BPNL00000003COJN',0,'c64ecd0e-06a9-48d8-8e58-8dee17e25502','P0263','Zylinder 1 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.005969Z',0),
  ('BPNL00000003COJN',0,'cb2f7195-f868-4f04-85a9-43793e0c0520','P0264','Einspritzventil/-düse 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.011436Z',0),
  ('BPNL00000003COJN',0,'0c4520b1-7039-4255-8da8-994b3517a19f','P0265','Einspritzventil/-düse 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.018094Z',0),
  ('BPNL00000003COJN',0,'70596009-1b0d-42b9-9c63-148d8ccc890b','P0266','Zylinder 2 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.023406Z',0),
  ('BPNL00000003COJN',0,'c709d41b-b7c7-4e54-8985-7f0d51370261','P0267','Einspritzventil/-düse 3 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.028298Z',0),
  ('BPNL00000003COJN',0,'923df6dc-8d20-4e51-9a69-b93814d4d1fe','P0268','Einspritzventil/-düse 3 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.033082Z',0),
  ('BPNL00000003COJN',0,'a5339bba-f781-4056-856a-7795ed418324','P0269','Zylinder 3 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.037620Z',0),
  ('BPNL00000003COJN',0,'d2a8d4f9-b3b6-4f3c-a02e-606c3b89c55b','P026A','Ladeluftkühler - Wirkungsgrad unter Schwellenwert','-','2022-05-11T11:16:17.042265Z',0),
  ('BPNL00000003COJN',0,'ae85e8e8-6acd-45d7-b393-26581268d8b0','P026B','Einspritzregelung - beeinträchtigte Funktion','-','2022-05-11T11:16:17.046770Z',0),
  ('BPNL00000003COJN',0,'64922167-64f1-4214-890e-cd85ac82283b','P026C','Einspritzmenge - Menge unter Sollwert','Kraftstoffstand zu niedrig, Schlauch undicht/blockiert, Kraftstoffdruckregler, Kraftstoffpumpe, Einspritzventil(e)/-düse(n)','2022-05-11T11:16:17.051531Z',0),
  ('BPNL00000003COJN',0,'f61897c7-f14e-49e6-9263-034850aae324','P026D','Einspritzmenge - Menge über Sollwert','Kraftstoffleitung verstopft, Kraftstoff-Überdruckventil, Kraftstoffdruckregler, Kraftstoffpumpe, Einspritzventil(e)/-düse(n)','2022-05-11T11:16:17.056374Z',0),
  ('BPNL00000003COJN',0,'17027cb2-0bc5-4313-8e49-62b54b1260cb','P0270','Einspritzventil/-düse 4 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.064597Z',0),
  ('BPNL00000003COJN',0,'2ef1a298-bdeb-4e5a-a700-73f2c7a262ca','P0271','Einspritzventil/-düse 4 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.070094Z',0),
  ('BPNL00000003COJN',0,'d90137a4-d8a1-40ac-b6cb-9a03c6088ef0','P0272','Zylinder 4 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.074952Z',0),
  ('BPNL00000003COJN',0,'d8971efd-984b-4b23-9fa8-60ea6071471a','P0273','Einspritzventil/-düse 5 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.080018Z',0),
  ('BPNL00000003COJN',0,'4fd43e75-816e-4095-aa16-e7b3e0bf15cd','P0274','Einspritzventil/-düse 5 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.086028Z',0),
  ('BPNL00000003COJN',0,'9e592066-7a3f-4541-8906-a64868644993','P0275','Zylinder 5 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.091224Z',0),
  ('BPNL00000003COJN',0,'27558182-709a-4c53-b1aa-bb1fac7161d8','P0276','Einspritzventil/-düse 6 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.097216Z',0),
  ('BPNL00000003COJN',0,'d3439a8b-710a-49c1-b833-e78d140f5a07','P0277','Einspritzventil/-düse 6 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.102284Z',0),
  ('BPNL00000003COJN',0,'6521dc1e-1bcf-4e3b-b97c-2d6ef41b47dc','P0278','Zylinder 6 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.109294Z',0),
  ('BPNL00000003COJN',0,'83fe7875-cd69-4e95-b728-01493c3500d6','P0279','Einspritzventil/-düse 7 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.114715Z',0),
  ('BPNL00000003COJN',0,'eda05e7a-a2eb-4ffc-ae6b-ee7ef81f07b4','P027A','Kraftstoffpumpen-Steuergerät B - offener Stromkreis','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:17.120590Z',0),
  ('BPNL00000003COJN',0,'fb08a77f-5925-4537-8a0c-a64964240fa1','P027B','Kraftstoffpumpen-Steuergerät B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:17.125383Z',0),
  ('BPNL00000003COJN',0,'48b19e76-e44f-471b-8b3c-2cd3ad56e4c0','P027C','Kraftstoffpumpen-Steuergerät B - Signal zu niedrig','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:17.134724Z',0),
  ('BPNL00000003COJN',0,'d762f6e1-e709-4d36-83b2-c96bb91ac892','P027D','Kraftstoffpumpen-Steuergerät B - Signal zu hoch','Kabelbaum, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:17.139842Z',0),
  ('BPNL00000003COJN',0,'7b44712c-f10c-4159-9098-5e67bba738b3','P0280','Einspritzventil/-düse 7 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.144998Z',0),
  ('BPNL00000003COJN',0,'0581cc3b-c541-4a61-9ebc-b0018992a85e','P0281','Zylinder 7 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.149552Z',0),
  ('BPNL00000003COJN',0,'0828cbf3-ab47-4d15-97e9-4f5f6497d897','P0282','Einspritzventil/-düse 8 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.154313Z',0),
  ('BPNL00000003COJN',0,'eb8f5cc5-2c4c-4cff-86ea-5c6aec1c56ea','P0283','Einspritzventil/-düse 8 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.159174Z',0),
  ('BPNL00000003COJN',0,'758cd62c-870d-47a4-9f41-afc3120c64c3','P0284','Zylinder 8 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.163730Z',0),
  ('BPNL00000003COJN',0,'350ddfb6-be30-46ff-b00b-eb80c534d799','P0285','Einspritzventil/-düse 9 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.168195Z',0),
  ('BPNL00000003COJN',0,'3aecb69c-da8a-4953-8df3-b7d84ebf84cb','P0286','Einspritzventil/-düse 9 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.172811Z',0),
  ('BPNL00000003COJN',0,'b07775c9-d9da-4e42-abdd-1a1deda8b36c','P0287','Zylinder 9 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.177274Z',0),
  ('BPNL00000003COJN',0,'e1796c45-4f19-4262-b91e-625f446e95d0','P0288','Einspritzventil/-düse 10 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.182172Z',0),
  ('BPNL00000003COJN',0,'cbbc26dc-fc9e-43f5-9ccf-6b6c49deb937','P0289','Einspritzventil/-düse 10 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.186826Z',0),
  ('BPNL00000003COJN',0,'9b873b55-9ccf-41ea-b196-edbe9bebe9b1','P0290','Zylinder 10 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.191456Z',0),
  ('BPNL00000003COJN',0,'3301b4e8-198d-438f-996f-8a1e480dc919','P0291','Einspritzventil/-düse 11 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.196561Z',0),
  ('BPNL00000003COJN',0,'fd53204a-542b-40ef-b996-5948d6db46df','P0292','Einspritzventil/-düse 11 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.201693Z',0),
  ('BPNL00000003COJN',0,'3a4aa387-168c-4816-8f9e-cc17739dcc03','P0293','Zylinder 11 - Fehler Zylinderleistung/Zylinderausgleich','Kabelbaum, Kraftstoffsystem, Motorsteuergerät','2022-05-11T11:16:17.206923Z',0),
  ('BPNL00000003COJN',0,'aeedbd51-ca12-436b-8de9-b4b38a282455','P0294','Einspritzventil/-düse 12 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.211821Z',0),
  ('BPNL00000003COJN',0,'bb0a5e46-c254-49a4-9df9-5420128c9e32','P0295','Einspritzventil/-düse 12 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.216877Z',0),
  ('BPNL00000003COJN',0,'6df0833f-7a52-498f-92f9-a37213f23d09','P0297','Unzulässige Fahrzeuggeschwindigkeit','Kabelbaum, Fahrgeschwindigkeitssensor, mechanische Fehlfunktion','2022-05-11T11:16:17.230906Z',0),
  ('BPNL00000003COJN',0,'d3f34f51-9a21-4afd-b25a-89b171bc18c7','P0298','Motoröltemperatur zu hoch','Kabelbaum, Motoröltemperatursensor, mechanische Fehlfunktion','2022-05-11T11:16:17.236536Z',0),
  ('BPNL00000003COJN',0,'3671949f-d155-40f9-a7f9-832b2d657abc','P0299','Turbolader/Motoraufladungskompressor - geringer Ladedruck','Mechanische Fehlfunktion','2022-05-11T11:16:17.241729Z',0),
  ('BPNL00000003COJN',0,'8407e715-c0c4-4736-b63f-ebf89799552c','P029A','Kraftstoffregelung, Zylinder 1 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.246729Z',0),
  ('BPNL00000003COJN',0,'ab4af604-ca93-422b-bce6-064e68d5966a','P029B','Kraftstoffregelung, Zylinder 1 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.251511Z',0),
  ('BPNL00000003COJN',0,'6ddefaa6-34a6-4984-b67b-068431066e4c','P029C','Einspritzventil/-düse 1 - Verstopfung','Einspritzventil/-düse','2022-05-11T11:16:17.256581Z',0),
  ('BPNL00000003COJN',0,'c13cba5f-9bae-47a6-9745-a633d448e66b','P029D','Einspritzventil/-düse 1 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.261385Z',0),
  ('BPNL00000003COJN',0,'e8b84cd0-38f0-43ea-961d-8115a6275f85','P029E','Kraftstoffregelung, Zylinder 2 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.266334Z',0),
  ('BPNL00000003COJN',0,'5b6afee6-e04c-41d3-aa9c-7be7252c2279','P029F','Kraftstoffregelung, Zylinder 2 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.271179Z',0),
  ('BPNL00000003COJN',0,'0b007ae6-6e8a-4adb-9165-a587cc9a4881','P02A0','Einspritzventil/-düse 2 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.277406Z',0),
  ('BPNL00000003COJN',0,'fac45ab4-5a3a-4b17-bdf8-bf66df8c3d33','P02A1','Einspritzventil/-düse 2 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.282168Z',0),
  ('BPNL00000003COJN',0,'6ce294d0-5f05-4b56-9c5f-5cab89894957','P02A2','Kraftstoffregelung, Zylinder 3 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.287435Z',0),
  ('BPNL00000003COJN',0,'a4dcddb0-5fb4-41a7-b0de-8e6e3d0e78b4','P02A3','Kraftstoffregelung, Zylinder 3 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.292117Z',0),
  ('BPNL00000003COJN',0,'67b081ba-85aa-4ec5-b68b-20b30a4c637e','P02A4','Einspritzventil/-düse 3 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.297593Z',0),
  ('BPNL00000003COJN',0,'106571c5-3a4c-4ddd-8db7-52dd5d75aea9','P02A5','Einspritzventil/-düse 3 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.302402Z',0),
  ('BPNL00000003COJN',0,'77128e6c-d775-4153-91cf-55d6c836d6ca','P02A6','Kraftstoffregelung, Zylinder 4 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.307384Z',0),
  ('BPNL00000003COJN',0,'b277f70f-de06-49b8-a5a8-d164e415255c','P02A7','Kraftstoffregelung, Zylinder 4 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.312048Z',0),
  ('BPNL00000003COJN',0,'d45624e9-8fb5-43a8-8586-5b05d8555e20','P02A8','Einspritzventil/-düse 4 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.321533Z',0),
  ('BPNL00000003COJN',0,'a19788f5-1fb8-4044-a460-9b3189e3bbc3','P02A9','Einspritzventil/-düse 4 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.328615Z',0),
  ('BPNL00000003COJN',0,'579c8fb7-1020-41da-af71-55022c307153','P02AA','Kraftstoffregelung, Zylinder 5 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.333413Z',0),
  ('BPNL00000003COJN',0,'a58b1943-853e-45a4-b509-910dd50ef338','P02AB','Kraftstoffregelung, Zylinder 5 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.338115Z',0),
  ('BPNL00000003COJN',0,'56709f45-9e44-477b-b1e9-3a39bae34f7d','P02AC','Zylinder 5 - Einspritzventil/-düse undicht','Einspritzventil/-düse','2022-05-11T11:16:17.342819Z',0),
  ('BPNL00000003COJN',0,'96708ce9-d04b-43a5-b542-f68f449f4e55','P02AD','Einspritzventil/-düse 5 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.347717Z',0),
  ('BPNL00000003COJN',0,'a03d5986-0ac5-434d-9d7a-aac67e2aa0f5','P02AE','Kraftstoffregelung, Zylinder 6 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.352447Z',0),
  ('BPNL00000003COJN',0,'e5187657-186c-4a21-973e-5017760fd28a','P02AF','Kraftstoffregelung, Zylinder 6 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.357515Z',0),
  ('BPNL00000003COJN',0,'fa0be406-ba37-4c2b-99f1-3b9defdca3ec','P02B0','Einspritzventil/-düse 6 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.362778Z',0),
  ('BPNL00000003COJN',0,'58ae8303-40c8-457e-b80a-49a3e06139c1','P02B1','Einspritzventil/-düse 6 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.367443Z',0),
  ('BPNL00000003COJN',0,'ee4de5fe-f4f8-4515-8911-5d6ce3105bc0','P02B2','Kraftstoffregelung, Zylinder 7 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.372300Z',0),
  ('BPNL00000003COJN',0,'b0983a46-1b49-4d39-b087-31d78bb974e4','P02B3','Kraftstoffregelung, Zylinder 7 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.377788Z',0),
  ('BPNL00000003COJN',0,'0be6107d-fa7c-41d3-a0e8-2c755601cbc3','P02B4','Einspritzventil/-düse 7 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.382761Z',0),
  ('BPNL00000003COJN',0,'73051fa3-e68c-44e5-b1dd-c5678f2240c3','P02B5','Einspritzventil/-düse 7 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.387725Z',0),
  ('BPNL00000003COJN',0,'5f022b0c-df94-4943-9508-bce17f3997c4','P02B6','Kraftstoffregelung, Zylinder 8 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.393111Z',0),
  ('BPNL00000003COJN',0,'1c810df6-a713-4fbc-8628-40df12660274','P02B7','Kraftstoffregelung, Zylinder 8 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.398369Z',0),
  ('BPNL00000003COJN',0,'5967ae20-ca13-4e85-a68b-34231435c7ec','P02B8','Einspritzventil/-düse 8 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.403262Z',0),
  ('BPNL00000003COJN',0,'57802a3f-55e8-4857-8f63-ed636e1fcd42','P02B9','Einspritzventil/-düse 8 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.408997Z',0),
  ('BPNL00000003COJN',0,'95ab1938-05ac-47e2-880a-88635ec35ab9','P02BA','Kraftstoffregelung, Zylinder 9 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.414239Z',0),
  ('BPNL00000003COJN',0,'c7a2c62f-e40d-4f0a-9d7f-77541ba1e1a9','P02BB','Einspritzventil/-düse 9 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.420049Z',0),
  ('BPNL00000003COJN',0,'536347d1-3c74-48fa-bfc7-f2d009dd6509','P02BC','Einspritzventil/-düse 9 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.425077Z',0),
  ('BPNL00000003COJN',0,'9fb9c3cc-e948-4388-861e-5b3353df821b','P02BD','Einspritzventil/-düse 9 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.430202Z',0),
  ('BPNL00000003COJN',0,'49a7a528-9a6f-4802-a413-b32a20b0e2c7','P02BE','Kraftstoffregelung, Zylinder 10 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.434880Z',0),
  ('BPNL00000003COJN',0,'7343f893-4b07-44c8-bc91-6736a76f3f1d','P02BF','Kraftstoffregelung, Zylinder 10 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.439608Z',0),
  ('BPNL00000003COJN',0,'1dc76b22-c7c2-445a-a44b-b30f17800457','P02C0','Einspritzventil/-düse 10 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.444914Z',0),
  ('BPNL00000003COJN',0,'a7149565-e421-453b-ac52-a7506dae0093','P02C1','Einspritzventil/-düse 10 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.449984Z',0),
  ('BPNL00000003COJN',0,'aa6284fa-f8f6-44ea-bea6-14687e4a76a3','P02C2','Kraftstoffregelung, Zylinder 11 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.454976Z',0),
  ('BPNL00000003COJN',0,'8563f1e1-b92d-4276-9a1c-a1c6da5288a2','P02C3','Kraftstoffregelung, Zylinder 11 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.459724Z',0),
  ('BPNL00000003COJN',0,'8ac596d0-4a21-485f-b66a-dad595f0f133','P02C4','Einspritzventil/-düse 11 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.464513Z',0),
  ('BPNL00000003COJN',0,'d907e3bf-61d5-420f-add8-66805a7ae604','P02C5','Einspritzventil/-düse 11 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.469503Z',0),
  ('BPNL00000003COJN',0,'bdf768d8-9377-424d-956b-086e42794911','P02C6','Kraftstoffregelung, Zylinder 12 - oberer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.474443Z',0),
  ('BPNL00000003COJN',0,'da800b38-b043-4f2c-a1a7-e82cbddf94c8','P02C7','Kraftstoffregelung, Zylinder 12 - unterer Regelgrenzwert erreicht','Einspritzventil/-düse, Kraftstoffdruck, Luftmassenmesser, Luftmengenmesser, Saugrohrdrucksensor, Motorsteuergerät','2022-05-11T11:16:17.479801Z',0),
  ('BPNL00000003COJN',0,'94c3f2c5-5f6f-4902-bbb2-61f34e544113','P02C8','Einspritzventil/-düse 12 - Verstopfung','Einspritzventil/-düse','2022-05-11T11:16:17.484540Z',0),
  ('BPNL00000003COJN',0,'1fbf205e-1544-4025-9858-d54ab88aad89','P02C9','Einspritzventil/-düse 12 - Undichtigkeit','Einspritzventil/-düse','2022-05-11T11:16:17.489255Z',0),
  ('BPNL00000003COJN',0,'68fafb02-e822-447b-b589-f99c5e9ba21e','P02CA','Turbo-/Kompressorlader B - Ladedruck zu hoch','Kabelbaum, Ladedruck-Stellglied, Motoraufladungskompressor-Regelventil, Motorsteuergerät','2022-05-11T11:16:17.494144Z',0),
  ('BPNL00000003COJN',0,'82607922-bff1-452b-a5bf-b691359c4c97','P02CB','Turbo-/Kompressorlader B - Ladedruck zu niedrig','Kabelbaum, Saugrohrdrucksensor, Turbo-/Kompressorladedrucksensor, Ladedruck-Stellglied, Turbolader, Motoraufladungskompressor, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:17.498850Z',0),
  ('BPNL00000003COJN',0,'65d6b3d5-3219-4f62-9b68-133456c62e49','P02CC','Einspritzventil/-düse 1 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.503698Z',0),
  ('BPNL00000003COJN',0,'7add20f6-3754-4e91-a93a-477dd675f36e','P02CD','Einspritzventil/-düse 1 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.508510Z',0),
  ('BPNL00000003COJN',0,'48e6d5a7-a961-4cd4-8ad6-af5d38946d2d','P02CE','Einspritzventil/-düse 2 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.514992Z',0),
  ('BPNL00000003COJN',0,'3196ecf4-123b-4417-90d2-b20bac00f68e','P02CF','Einspritzventil/-düse 2 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.519863Z',0),
  ('BPNL00000003COJN',0,'0b50fabc-6951-4887-8ffc-5433778a26a9','P02D0','Einspritzventil/-düse 3 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.526022Z',0),
  ('BPNL00000003COJN',0,'9ddacbf5-035d-4dd8-ad0c-77aa87678e48','P02D1','Einspritzventil/-düse 3 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.531618Z',0),
  ('BPNL00000003COJN',0,'5ac0b71a-4b11-4215-ae47-ed0ac357b1e5','P02D2','Einspritzventil/-düse 4 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.537067Z',0),
  ('BPNL00000003COJN',0,'a7b3bbd2-6d6e-4683-bfc5-db7d421dc2c6','P02D3','Einspritzventil/-düse 4 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.541918Z',0),
  ('BPNL00000003COJN',0,'20004931-781f-4840-a032-ddab769e6242','P02D4','Einspritzventil/-düse 5 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.546373Z',0),
  ('BPNL00000003COJN',0,'3c5003c0-e692-460b-9644-a4981d297484','P02D5','Einspritzventil/-düse 5 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.551171Z',0),
  ('BPNL00000003COJN',0,'cb475864-a2c0-4fb1-83bc-5e7cce14b642','P02D6','Einspritzventil/-düse 6 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.556108Z',0),
  ('BPNL00000003COJN',0,'aca5ca20-1627-4f44-b6b7-a3d3f260a3fe','P02D7','Einspritzventil/-düse 6 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.560899Z',0),
  ('BPNL00000003COJN',0,'2613c368-3f95-4ef9-8d5d-eb5fba2b21ad','P02D8','Einspritzventil/-düse 7 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.565873Z',0),
  ('BPNL00000003COJN',0,'cbfc092a-98a6-4915-a10b-36594afba760','P02D9','Einspritzventil/-düse 7 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.570610Z',0),
  ('BPNL00000003COJN',0,'ec04db38-b02c-4acf-9d96-fa0568a7c357','P02DA','Einspritzventil/-düse 8 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.575835Z',0),
  ('BPNL00000003COJN',0,'42a5e3ed-2cb8-4c8d-a1ba-b423de8c5a72','P02DB','Einspritzventil/-düse 8 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.582128Z',0),
  ('BPNL00000003COJN',0,'1f2cfaae-3ec8-4689-8d38-07c73c5f137b','P02DC','Einspritzventil/-düse 9 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.587894Z',0),
  ('BPNL00000003COJN',0,'d7f6286d-9346-40f1-98d0-8c033e03b48a','P02DD','Einspritzventil/-düse 9 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.592997Z',0),
  ('BPNL00000003COJN',0,'16f5f698-8523-4fbc-9ab4-6fba4c7d6afd','P02DE','Einspritzventil/-düse 10 - Parameteradaption für Zeitversatz (Offset) am unteren Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.598714Z',0),
  ('BPNL00000003COJN',0,'68f357fe-bcf8-46d7-aee0-6d8eb718ecee','P02DF','Einspritzventil/-düse 10 - Parameteradaption für Zeitversatz (Offset) am oberen Grenzwert','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.603700Z',0),
  ('BPNL00000003COJN',0,'876630d6-82f2-4273-a959-6a0f9f397326','P02E0','Ansaugluftklappen-Stellglied - offener Stromkreis','Kabelbaum, Ansaugluftklappen-Stellglied, Motorsteuergerät','2022-05-11T11:16:17.608406Z',0),
  ('BPNL00000003COJN',0,'c5ff028d-f0c7-453c-9f87-2edaabd8b6a9','P02E1','Ansaugluftklappen-Stellglied - beeinträchtigte Funktion','Kabelbaum, Ansaugluftklappen-Stellglied, Ansaugluftklappen-Stellgliedpositionssensor, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:17.613825Z',0),
  ('BPNL00000003COJN',0,'76f620b2-ae42-4628-b2cb-5bb7aae82988','P02E2','Ansaugluftklappen-Stellglied - Signal zu niedrig','Kabelbaum, Ansaugluftklappen-Stellglied, Motorsteuergerät','2022-05-11T11:16:17.618927Z',0),
  ('BPNL00000003COJN',0,'68e274a3-26ce-4be2-91b8-9e2bd27490af','P02E3','Ansaugluftklappen-Stellglied - Signal zu hoch','Kabelbaum, Ansaugluftklappen-Stellglied, Motorsteuergerät','2022-05-11T11:16:17.628767Z',0),
  ('BPNL00000003COJN',0,'09444d18-e47b-4450-88ed-8fed9142ce97','P02E4','Ansaugluftklappen-Stellglied - Stellglied klemmt in geöffneter Stellung','Kabelbaum, Ansaugluftklappen-Stellglied, Ansaugluftklappen-Stellgliedpositionssensor, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:17.634436Z',0),
  ('BPNL00000003COJN',0,'522ca45c-d39f-404a-b12a-057d97614c3a','P02E5','Ansaugluftklappen-Stellglied - Stellglied klemmt in geschlossener Stellung','Ansaugluftklappen-Stellglied, mechanische Fehlfunktion','2022-05-11T11:16:17.639975Z',0),
  ('BPNL00000003COJN',0,'1a654d7a-26e6-490c-b694-32dbad5caa5b','P02E6','Ansaugluftklappen-Stellgliedpositionssensor - Fehlfunktion Stromkreis','Kabelbaum, Ansaugluftklappen-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:17.645675Z',0),
  ('BPNL00000003COJN',0,'85ab7b97-569f-45fd-b75c-e4f8046155ef','P02E7','Ansaugluftklappen-Stellgliedpositionssensor - Bereichs-/Funktionsfehler','Kabelbaum, Ansaugluftklappen-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:17.651098Z',0),
  ('BPNL00000003COJN',0,'d40d5db2-14f7-4405-b59d-534942d86458','P02E8','Ansaugluftklappen-Stellgliedpositionssensor - Signal zu niedrig','Kabelbaum, Ansaugluftklappen-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:17.658169Z',0),
  ('BPNL00000003COJN',0,'9b6f4fee-8355-4aaa-9ff0-52af37a866b7','P02E9','Ansaugluftklappen-Stellgliedpositionssensor - Signal zu hoch','Kabelbaum, Ansaugluftklappen-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:17.663269Z',0),
  ('BPNL00000003COJN',0,'177f8783-1c93-43bd-a4e1-eeb93e910407','P02EA','Ansaugluftklappen-Stellgliedpositionssensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Ansaugluftklappen-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:17.667732Z',0),
  ('BPNL00000003COJN',0,'31f0c105-9343-40fc-a61b-3c2adc00ec8d','P02EB','Ansaugluftstrom-Steuermotor (Diesel) - Bereichs-/Funktionsfehler Stromstärke','Kabelbaum, Ansaugluftstrom-Steuermotor (Diesel)','2022-05-11T11:16:17.672759Z',0),
  ('BPNL00000003COJN',0,'be37cbf7-2df7-4026-9a1b-91dcb9d2e403','P02EC','Ansaugluftstrom-Steuerung (Diesel) - übermäßiger Luftstrom festgestellt','Kabelbaum, Ansaugluftstrom-Steuermotor (Diesel)','2022-05-11T11:16:17.678003Z',0),
  ('BPNL00000003COJN',0,'a5934d4f-235a-4270-935f-72a86d8ecebb','P02ED','Ansaugluftstrom-Steuerung (Diesel) - unzureichender Luftstrom festgestellt','Kabelbaum, Ansaugluftstrom-Steuermotor (Diesel)','2022-05-11T11:16:17.683502Z',0),
  ('BPNL00000003COJN',0,'1e8f4ca6-1c22-4a28-b9d7-74ff8305201b','P02EE','Einspritzventil/-düse 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.688240Z',0),
  ('BPNL00000003COJN',0,'3343248e-1fd0-430e-a2b0-09da734cfef8','P02EF','Einspritzventil/-düse 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.693770Z',0),
  ('BPNL00000003COJN',0,'c6b979dc-5943-4f32-8cc5-46e0504fb241','P02F0','Einspritzventil/-düse 3 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.698434Z',0),
  ('BPNL00000003COJN',0,'2530d754-1b73-4804-b75f-29b789883f20','P02F1','Einspritzventil/-düse 4 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.703391Z',0),
  ('BPNL00000003COJN',0,'3ff158f6-c9fa-400a-bb20-b4434b013bf0','P02F2','Einspritzventil/-düse 5 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.708385Z',0),
  ('BPNL00000003COJN',0,'34858fa0-07c1-45bc-a90b-c208ecafb7cd','P02F3','Einspritzventil/-düse 6 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.713318Z',0),
  ('BPNL00000003COJN',0,'3cc81d7d-6862-470c-99e0-a59cb5ff5d77','P02F4','Einspritzventil/-düse 7 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.718216Z',0),
  ('BPNL00000003COJN',0,'0c15d7b1-e61d-4e16-bdf6-b99013d67669','P02F5','Einspritzventil/-düse 8 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.723181Z',0),
  ('BPNL00000003COJN',0,'db6c6ce4-5bdf-46e0-8bf1-84012e798cd8','P02F6','Einspritzventil/-düse 9 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.729346Z',0),
  ('BPNL00000003COJN',0,'43c599be-b0c3-48d5-b8d7-091643795c4e','P02F7','Einspritzventil/-düse 10 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.734770Z',0),
  ('BPNL00000003COJN',0,'e93c1718-e401-4f1a-a0f6-1f372fb57c64','P02F8','Einspritzventil/-düse 11 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.739370Z',0),
  ('BPNL00000003COJN',0,'edb29727-3853-4542-85ba-cb1f78f0b4d9','P02F9','Einspritzventil/-düse 12 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Einspritzventil/-düse, Motorsteuergerät','2022-05-11T11:16:17.743905Z',0),
  ('BPNL00000003COJN',0,'73a6dc03-088e-4c9c-ac6f-4b32a04f697d','P02FA','Ansaugluftstrom-Stellungssensor (Diesel) - Adaptionsvorgang für Min.-/Max.-Stellung','Kabelbaum, Ansaugluftstrom-Stellungssensor (Diesel)','2022-05-11T11:16:17.748669Z',0),
  ('BPNL00000003COJN',0,'c434359d-a518-4d4e-b329-571adb3c4465','P0300','Beliebiger/mehrere Zylinder - Fehlzündung festgestellt','Zündkerze(n), Hochspannungskabel, Einspritzventil(e)/-düse(n), Zündspule(n), Verdichtung zu niedrig, Kabelbaum','2022-05-11T11:16:17.753536Z',0),
  ('BPNL00000003COJN',0,'d04fdabc-9a86-4e43-842b-6674b818e77d','P0301','Zylinder 1 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.758472Z',0),
  ('BPNL00000003COJN',0,'cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e','P0302','Zylinder 2 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.764265Z',0),
  ('BPNL00000003COJN',0,'31d19a2b-3042-4f3b-9559-562f6a394e5e','P0303','Zylinder 3 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.770032Z',0),
  ('BPNL00000003COJN',0,'95f80026-82a2-4bad-b228-4c1ca3147024','P0304','Zylinder 4 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.775912Z',0),
  ('BPNL00000003COJN',0,'5940df78-25b8-4ead-8766-ad62462fb6c4','P0305','Zylinder 5 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.784264Z',0),
  ('BPNL00000003COJN',0,'1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1','P0306','Zylinder 6 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.789368Z',0),
  ('BPNL00000003COJN',0,'25ddc856-f2c0-42d8-9d64-ef3bb8d438e7','P0307','Zylinder 7 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.794274Z',0),
  ('BPNL00000003COJN',0,'9a8d2c10-dba6-4837-b619-a65054344bbe','P0308','Zylinder 8 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.801725Z',0),
  ('BPNL00000003COJN',0,'86a87b01-05a5-4654-8530-4ad6030c742c','P0309','Zylinder 9 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.806407Z',0),
  ('BPNL00000003COJN',0,'980741eb-df1e-4284-94a9-0f6ccd3d418b','P0310','Zylinder 10 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.812720Z',0),
  ('BPNL00000003COJN',0,'0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b','P0311','Zylinder 11 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.817058Z',0),
  ('BPNL00000003COJN',0,'6cac6afe-01fd-4037-992a-205151ddf223','P0312','Zylinder 12 - Fehlzündung festgestellt','Mechanische Motorstörung, Kabelbaum, Zünd-/Kraftstoffsystem, Einspritzventil/-düse, Kühlmitteltemperatursensor/Luftmassenmesser, Motorsteuergerät','2022-05-11T11:16:17.821747Z',0),
  ('BPNL00000003COJN',0,'e420e3fe-4b6a-4c55-9abc-5e5c5136c779','P0313','Fehlzündung festgestellt - Kraftstoffstand zu niedrig','Kraftstoffsystem, mechanische Fehlfunktion','2022-05-11T11:16:17.826572Z',0),
  ('BPNL00000003COJN',0,'7d559e62-df65-4b24-ab4c-d48652e7b4d3','P0314','Fehlzündung in einem Zylinder - beliebiger Zylinder','Mechanische Motorstörung, Kabelbaum, Zündung/Kraftstoffsystem, Einspritzventil/-düse','2022-05-11T11:16:17.830970Z',0),
  ('BPNL00000003COJN',0,'da979d51-f8c1-4a53-a798-8151b00ca074','P0315','Kurbelwellenstellungssystem - Größenänderung nicht erfasst','Mechanische Motorstörung, Kabelbaum','2022-05-11T11:16:17.836991Z',0),
  ('BPNL00000003COJN',0,'c111d44b-908f-4e6a-bcf3-9eb4384bdc7c','P0316','Fehlzündung während Motorstart festgestellt - erste 1000 Motorumdrehungen','Mechanische Motorstörung, Kabelbaum, Zündung/Kraftstoffsystem, Einspritzventil/-düse','2022-05-11T11:16:17.842337Z',0),
  ('BPNL00000003COJN',0,'89627489-9ee0-498f-addf-7f7399d12131','P0317','Systemkomponenten "Fahrbahnunebenheit" nicht erkannt','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:17.846775Z',0),
  ('BPNL00000003COJN',0,'0a7ae0a6-16d8-4ead-83bc-19df15dda8d1','P0318','Fahrbahnsensor A - Fehlfunktion Stromkreis','Kabelbaum, Fahrbahnsensor A, mechanische Fehlfunktion','2022-05-11T11:16:17.851605Z',0),
  ('BPNL00000003COJN',0,'033e86b2-1655-418c-b157-a2b0c6aae4cc','P0320','Kurbelwinkelsensor/Drehzahlsensor - Fehlfunktion Stromkreis','Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät','2022-05-11T11:16:17.861658Z',0),
  ('BPNL00000003COJN',0,'51fc755f-72c4-4dfb-b4e2-683f59d7811d','P0321','Kurbelwinkelsensor/Drehzahlsensor - Bereichs-/Funktionsfehler','Luftspalt, Verunreinigung durch metallischen Abrieb, Sensor/Impulsgeber lose, Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor','2022-05-11T11:16:17.866347Z',0),
  ('BPNL00000003COJN',0,'b277db8f-6f2d-4ee6-9199-707263895355','P0322','Kurbelwinkelsensor/Drehzahlsensor - kein Signal','Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät','2022-05-11T11:16:17.870895Z',0),
  ('BPNL00000003COJN',0,'e0a65c67-b5da-4fc4-86fc-0fb4c23437c9','P0323','Kurbelwinkelsensor/Drehzahlsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät','2022-05-11T11:16:17.875895Z',0),
  ('BPNL00000003COJN',0,'749be668-22c9-488f-9d68-76b25889afa6','P0324','Fehler Klopfregelung','Kabelbaum, schlechte Kontaktierung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.880765Z',0),
  ('BPNL00000003COJN',0,'a46e8179-9e48-483d-9374-dcf0bf72e456','P0325','Klopfsensor 1, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Klopfsensor','2022-05-11T11:16:17.885422Z',0),
  ('BPNL00000003COJN',0,'21748edd-6575-41e2-b8b7-9dc17e987d89','P0326','Klopfsensor 1, Zylinderreihe 1 - Bereichs-/Funktionsfehler','Kabelbaum, falsches Anzugsdrehmoment Klopfsensorbefestigung, Klopfsensor','2022-05-11T11:16:17.890191Z',0),
  ('BPNL00000003COJN',0,'db88885e-0f05-4bc6-b04e-0d4ad3c44b7b','P0327','Klopfsensor 1, Zylinderreihe 1 - Eingangssignal zu niedrig','Klopfsensor lose, schlechte Kontaktierung, Kurzschluss an Masse im Kabelbaum, falsches Anzugsdrehmoment, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.894760Z',0),
  ('BPNL00000003COJN',0,'3c2cee55-a9a2-41c2-9236-c1faa27dc874','P0328','Klopfsensor 1, Zylinderreihe 1 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, falsches Anzugsdrehmoment Klopfsensorbefestigung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.900279Z',0),
  ('BPNL00000003COJN',0,'534d9be2-ecab-429a-b2c1-7b66303fb697','P0329','Klopfsensor 1, Zylinderreihe 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.907816Z',0),
  ('BPNL00000003COJN',0,'97ae30bf-ff12-4faa-bb6a-6e679238d81d','P032A','Klopfsensor 3, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.913256Z',0),
  ('BPNL00000003COJN',0,'21fd57c8-9ab7-471e-8731-2dc065c07a41','P032B','Klopfsensor 3, Zylinderreihe 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.918798Z',0),
  ('BPNL00000003COJN',0,'4947fc8b-c735-4d33-a967-9748d3dc1fb3','P032C','Klopfsensor 3, Zylinderreihe 1 - Signal zu niedrig','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.924852Z',0),
  ('BPNL00000003COJN',0,'3d288f32-4d63-43e7-9c88-e3e44d2074cc','P032D','Klopfsensor 3, Zylinderreihe 1 - Signal zu hoch','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.930264Z',0),
  ('BPNL00000003COJN',0,'ead712a2-6501-431f-8e8d-6f74a5c1643c','P032E','Klopfsensor 3, Zylinderreihe 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.936148Z',0),
  ('BPNL00000003COJN',0,'ccfad552-3690-4cb8-8a55-28b38e3a7856','P0330','Klopfsensor 2, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.940992Z',0),
  ('BPNL00000003COJN',0,'b3bbb852-09ea-46de-95a8-67991dd97d87','P0331','Klopfsensor 2, Zylinderreihe 2 - Bereichs-/Funktionsfehler','Kabelbaum, falsches Anzugsdrehmoment Klopfsensorbefestigung, Klopfsensor','2022-05-11T11:16:17.945856Z',0),
  ('BPNL00000003COJN',0,'c50111e1-612f-4aaf-abc5-aca1173f841f','P0332','Klopfsensor 2, Zylinderreihe 2 - Eingangssignal zu niedrig','Klopfsensor lose, schlechte Kontaktierung, Kurzschluss an Masse im Kabelbaum, falsches Anzugsdrehmoment Klopfsensorbefestigung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.951368Z',0),
  ('BPNL00000003COJN',0,'afd0e9a7-92dd-4984-a793-0c0788a754a7','P0333','Klopfsensor 2, Zylinderreihe 2 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, falsches Anzugsdrehmoment Klopfsensorbefestigung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.956972Z',0),
  ('BPNL00000003COJN',0,'f0375df3-60b2-494a-b2ec-f8d34bdd24b1','P0334','Klopfsensor 2, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.962248Z',0),
  ('BPNL00000003COJN',0,'ab1903b6-06d2-4aa5-acf7-485774a0a437','P0335','Kurbelwinkelsensor - Fehlfunktion Stromkreis','Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:17.967168Z',0),
  ('BPNL00000003COJN',0,'00897772-da4c-4183-82a7-9977cb06e038','P0336','Kurbelwinkelsensor - Bereichs-/Funktionsfehler','Sensor/Impulsgeber lose, Luftspalt, Kabelbaum, Kurbelwinkelsensor','2022-05-11T11:16:17.972001Z',0),
  ('BPNL00000003COJN',0,'d4966fdc-01fc-4433-a940-af4b6d74240b','P0337','Kurbelwinkelsensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:17.976879Z',0),
  ('BPNL00000003COJN',0,'18dca0f5-10b1-421c-82cf-2f9ce8341c48','P0338','Kurbelwinkelsensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:17.981706Z',0),
  ('BPNL00000003COJN',0,'e0d73834-c981-4ccc-811d-2600066901ee','P0339','Kurbelwinkelsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:17.987068Z',0),
  ('BPNL00000003COJN',0,'17871dba-5982-41d8-b654-370c30385a44','P033A','Klopfsensor 4, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.992453Z',0),
  ('BPNL00000003COJN',0,'d37f362b-705d-468e-99cf-9368c25a69b4','P033B','Klopfsensor 4, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:17.997440Z',0),
  ('BPNL00000003COJN',0,'032d3af5-11dd-4402-8ff5-cff8835c103d','P033C','Klopfsensor 4, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:18.002946Z',0),
  ('BPNL00000003COJN',0,'b492814f-13b5-466a-9b6a-0c58edb69ee8','P033D','Klopfsensor 4, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:18.007706Z',0),
  ('BPNL00000003COJN',0,'f2bb7d01-4a00-4bdb-876e-3e2b4dd3cfee','P033E','Klopfsensor 4, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Klopfsensor, Motorsteuergerät','2022-05-11T11:16:18.013206Z',0),
  ('BPNL00000003COJN',0,'36e5bea0-5d53-483f-ad35-9c7a4f3964af','P0340','Nockenwellenpositionssensor A, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.024420Z',0),
  ('BPNL00000003COJN',0,'c50068fd-61fb-46e2-b80b-4ba7902d68ef','P0341','Nockenwellenpositionssensor A, Zylinderreihe 1 - Bereichs-/Funktionsfehler','Sensor/Impulsgeber lose, Luftspalt, Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:18.029655Z',0),
  ('BPNL00000003COJN',0,'6aff0874-d6fa-43aa-95d5-df708b0d84ea','P0342','Nockenwellenpositionssensor A, Zylinderreihe 1 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.038013Z',0),
  ('BPNL00000003COJN',0,'ce2329ca-2d41-43f9-9fcb-f8d943bb3e66','P0343','Nockenwellenpositionssensor A, Zylinderreihe 1 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.043565Z',0),
  ('BPNL00000003COJN',0,'1efe4ef2-358c-44a9-8d2e-a5c7b25caeb3','P0344','Nockenwellenpositionssensor A, Zylinderreihe 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.049771Z',0),
  ('BPNL00000003COJN',0,'1bbe0dcb-cccb-4616-9e68-0095cd5ade5b','P0345','Nockenwellenpositionssensor A, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.055346Z',0),
  ('BPNL00000003COJN',0,'d69bf7fc-4af6-4495-9a15-2c2071d05134','P0346','Nockenwellenpositionssensor A, Zylinderreihe 2 - Bereichs-/Funktionsfehler','Sensor/Impulsgeber lose, Luftspalt, Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:18.062455Z',0),
  ('BPNL00000003COJN',0,'8cd6ac47-07c3-4aeb-b4f1-f710038e77b8','P0347','Nockenwellenpositionssensor A, Zylinderreihe 2 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.068272Z',0),
  ('BPNL00000003COJN',0,'a2893bb0-20a4-4ef1-b77c-71ad328c7c04','P0348','Nockenwellenpositionssensor A, Zylinderreihe 2 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.075114Z',0),
  ('BPNL00000003COJN',0,'d8724bbf-6b66-472e-8a8e-14004bb5df1f','P0349','Nockenwellenpositionssensor A, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.085152Z',0),
  ('BPNL00000003COJN',0,'009ed54a-0f28-4305-bae1-c10f64b6d5f4','P0350','Zündspule, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.090328Z',0),
  ('BPNL00000003COJN',0,'5b58755d-5472-4ed0-8975-a9bb2034b0c5','P0351','Zündspule A, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.095795Z',0),
  ('BPNL00000003COJN',0,'b022b3a8-019d-4970-94fd-1cf72fc2468b','P0352','Zündspule B, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.105211Z',0),
  ('BPNL00000003COJN',0,'6079e284-420a-462a-9a33-0cc6fd86085d','P0353','Zündspule C, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.109976Z',0),
  ('BPNL00000003COJN',0,'b8f0a3ca-1d09-4be7-af72-f9b48dffb44c','P0354','Zündspule D, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.118673Z',0),
  ('BPNL00000003COJN',0,'2ba84721-358b-4186-9d0a-439895a19e6b','P0355','Zündspule E, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.123391Z',0),
  ('BPNL00000003COJN',0,'bb9f4883-aa00-4b46-b4d5-1d1704b5584d','P0356','Zündspule F, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.127705Z',0),
  ('BPNL00000003COJN',0,'3fd7cda4-9b1e-4b24-b41c-c1bd208f792a','P0357','Zündspule G, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.132288Z',0),
  ('BPNL00000003COJN',0,'79fdb6dc-6596-442a-8934-bffbcb186e24','P0358','Zündspule H, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.138746Z',0),
  ('BPNL00000003COJN',0,'cd9ef201-19b9-494f-94cc-16fef0a16b21','P0359','Zündspule I, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.146639Z',0),
  ('BPNL00000003COJN',0,'ae32d196-9ac4-49c4-8c69-a7c5cb478c89','P0360','Zündspule J, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.155884Z',0),
  ('BPNL00000003COJN',0,'d5fad3f0-b255-41e7-ba82-5283750c6359','P0361','Zündspule K, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.160975Z',0),
  ('BPNL00000003COJN',0,'6ac4f510-0cce-4cce-8f80-d6d05a708643','P0362','Zündspule L, Primär-/Sekundärspule - Fehlfunktion Stromkreis','Kabelbaum, Zündspule, Motorsteuergerät','2022-05-11T11:16:18.167940Z',0),
  ('BPNL00000003COJN',0,'ff34252e-8700-4134-90b7-5537057e1253','P0363','Fehlzündung festgestellt - Kraftstoffversorgung deaktiviert','Kraftstoffsystem, mechanische Fehlfunktion','2022-05-11T11:16:18.182632Z',0),
  ('BPNL00000003COJN',0,'bd9d7225-1463-4e46-9830-89087fc11b7f','P0365','Nockenwellenpositionssensor B, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.191444Z',0),
  ('BPNL00000003COJN',0,'3b4e8fee-9c58-4333-be29-0d121892b220','P0366','Nockenwellenpositionssensor B, Zylinderreihe 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor','2022-05-11T11:16:18.196450Z',0),
  ('BPNL00000003COJN',0,'1829a363-298b-4974-ad2a-9cf6e5b068f9','P0367','Nockenwellenpositionssensor B, Zylinderreihe 1 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.204248Z',0),
  ('BPNL00000003COJN',0,'48f855a7-c1b9-46cf-ba40-88eefc64ee12','P0368','Nockenwellenpositionssensor B, Zylinderreihe 1 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.211448Z',0),
  ('BPNL00000003COJN',0,'84b0aff7-dae9-4acd-98db-61d1431e3a4f','P0369','Nockenwellenpositionssensor B, Zylinderreihe 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät','2022-05-11T11:16:18.216338Z',0),
  ('BPNL00000003COJN',0,'9a77093b-1f97-40fd-aeea-b9a8a6782e0d','P0370','Zeitpunktreferenz, hohe Signalauflösung A - Fehlfunktion','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.220927Z',0),
  ('BPNL00000003COJN',0,'c7abb5ca-22aa-4928-8776-4ba7c459fe19','P0371','Zeitpunktreferenz, hohe Signalauflösung A - Signalrate zu hoch','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.225711Z',0),
  ('BPNL00000003COJN',0,'d2f3b9b4-5501-41e8-86c9-0b9b8e395018','P0372','Zeitpunktreferenz, hohe Signalauflösung A - Signalrate zu niedrig','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.230974Z',0),
  ('BPNL00000003COJN',0,'e01cfc27-16a4-4660-81b1-f7c50341ff7c','P0373','Zeitpunktreferenz, hohe Signalauflösung A - intermittierende/sporadische Signale','Kabelbaum, schlechte Kontaktierung, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.236252Z',0),
  ('BPNL00000003COJN',0,'c1da9813-0f5d-4a3a-b644-5d77878b2aea','P0374','Zeitpunktreferenz, hohe Signalauflösung A - keine Signale','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.258718Z',0),
  ('BPNL00000003COJN',0,'4731508a-79a7-43a4-a6e4-3d7f12eb790a','P0375','Zeitpunktreferenz, hohe Signalauflösung B - Fehlfunktion','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.271378Z',0),
  ('BPNL00000003COJN',0,'7211dd50-7cfc-4d81-88a4-5a3478077358','P0376','Zeitpunktreferenz, hohe Signalauflösung B - Signalrate zu hoch','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.276135Z',0),
  ('BPNL00000003COJN',0,'46b25f35-7831-4857-9c93-cf1fbaaa5ef5','P0377','Zeitpunktreferenz, hohe Signalauflösung B - Signalrate zu niedrig','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.281274Z',0),
  ('BPNL00000003COJN',0,'ee4c9282-0376-4280-852b-a091022a09e6','P0378','Zeitpunktreferenz, hohe Signalauflösung B - intermittierende/sporadische Signale','Kabelbaum, schlechte Kontaktierung, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.286329Z',0),
  ('BPNL00000003COJN',0,'e581f26e-77ca-4bea-a1d6-d5dd7e4238f2','P0379','Zeitpunktreferenz, hohe Signalauflösung B - keine Signale','Kabelbaum, Kurbelwinkel-/Drehzahl-/Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.290684Z',0),
  ('BPNL00000003COJN',0,'6d86844c-2d84-4cda-8dc3-0de4914931e9','P037D','Überwachungsfunktion Glühkerzen - Fehlfunktion Stromkreis','Kabelbaum, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:18.295235Z',0),
  ('BPNL00000003COJN',0,'83b3dcd2-9e0d-412f-86b0-72e1494dfbde','P037E','Überwachungsfunktion Glühkerzen - Signal zu niedrig','Kabelbaum, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:18.299580Z',0),
  ('BPNL00000003COJN',0,'4bf4dcb0-ccf7-47f4-8c42-9c3873973def','P037F','Überwachungsfunktion Glühkerzen - Signal zu hoch','Kabelbaum, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:18.303870Z',0),
  ('BPNL00000003COJN',0,'2c07c270-88ef-4830-be3b-5922b29af399','P0380','Glühkerzen, Stromkreis A - Fehlfunktion','Kabelbaum, Vorglührelais, Sicherung, Glühkerzen, Motorsteuergerät','2022-05-11T11:16:18.308354Z',0),
  ('BPNL00000003COJN',0,'7c428714-432a-4cb3-81ce-c3673cbefcf4','P0381','Vorglühkontrollleuchte - Fehlfunktion Stromkreis','Kabelbaum, Vorglühkontrollleuchte, Motorsteuergerät','2022-05-11T11:16:18.312457Z',0),
  ('BPNL00000003COJN',0,'f1927c91-f580-4080-850d-9ee88a9409ac','P0382','Glühkerzen, Stromkreis B - Fehlfunktion','Kabelbaum, Vorglührelais, Sicherung, Glühkerzen, Motorsteuergerät','2022-05-11T11:16:18.317096Z',0),
  ('BPNL00000003COJN',0,'1041c5eb-0ec5-4bd4-99b3-06152644c9a1','P0383','Glühkerzen-Steuergerät - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Glühkerzen-Steuergerät','2022-05-11T11:16:18.325775Z',0),
  ('BPNL00000003COJN',0,'707f6abf-f5ec-42ba-865c-81449c189cab','P0384','Glühkerzen-Steuergerät - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Glühkerzen-Steuergerät','2022-05-11T11:16:18.330141Z',0),
  ('BPNL00000003COJN',0,'5c012fd0-af7f-4d2b-a236-0a4cea09c73d','P0385','Kurbelwinkelsensor B - Fehlfunktion Stromkreis','Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:18.336843Z',0),
  ('BPNL00000003COJN',0,'4c444b6b-da72-454e-ac72-bf0c71d25afa','P0386','Kurbelwinkelsensor B - Bereichs-/Funktionsfehler','Sensor/Impulsgeber lose, Luftspalt, Kabelbaum, Kurbelwinkelsensor','2022-05-11T11:16:18.348038Z',0),
  ('BPNL00000003COJN',0,'33d7c2b1-2767-4bc7-886b-8b031e032f28','P0387','Kurbelwinkelsensor B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:18.354280Z',0),
  ('BPNL00000003COJN',0,'e8426e76-252a-4b6b-9019-041550ba1b96','P0388','Kurbelwinkelsensor B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:18.359381Z',0),
  ('BPNL00000003COJN',0,'d0bee939-83b3-4771-b77e-d07e409cfc33','P0389','Kurbelwinkelsensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kurbelwinkelsensor, Motorsteuergerät','2022-05-11T11:16:18.363649Z',0),
  ('BPNL00000003COJN',0,'1d9eed93-f21a-4506-b051-7b30737404dd','P0390','Nockenwellenpositionssensor B, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.371100Z',0),
  ('BPNL00000003COJN',0,'9ffd7804-8250-4a6f-94bf-805166b647ee','P0391','Nockenwellenpositionssensor B, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Nockenwellenpositionssensor','2022-05-11T11:16:18.377116Z',0),
  ('BPNL00000003COJN',0,'1e6d3708-c173-47d9-8d3e-74b69be65a6f','P0392','Nockenwellenpositionssensor B, Zylinderreihe 2 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.385701Z',0),
  ('BPNL00000003COJN',0,'453628ef-04b8-4de1-b030-78d170b2e8a7','P0393','Nockenwellenpositionssensor B, Zylinderreihe 2 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Nockenwellenpositionssensor, Motorsteuergerät','2022-05-11T11:16:18.390672Z',0),
  ('BPNL00000003COJN',0,'8bbfc6e2-88fc-4c4e-9315-d2debce1a89c','P0394','Nockenwellenpositionssensor B, Zylinderreihe 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät','2022-05-11T11:16:18.402765Z',0),
  ('BPNL00000003COJN',0,'69f4bd76-3149-46d9-8cd4-39160d055751','P0395','Zylinderdrucksensor, Zylinder 1 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.407889Z',0),
  ('BPNL00000003COJN',0,'28ca98df-d264-42f7-b717-356707b3716c','P0396','Zylinderdrucksensor, Zylinder 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.416158Z',0),
  ('BPNL00000003COJN',0,'785e4099-7bfc-499d-8208-7ec3584562e6','P0397','Zylinderdrucksensor, Zylinder 1 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.420898Z',0),
  ('BPNL00000003COJN',0,'c8743617-6181-498e-9a69-031e1a0b058c','P0398','Zylinderdrucksensor, Zylinder 1 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.425475Z',0),
  ('BPNL00000003COJN',0,'ab67034a-009f-4127-a056-652a1a86d3ca','P0399','Zylinderdrucksensor, Zylinder 1 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.432863Z',0),
  ('BPNL00000003COJN',0,'550b94e4-832e-44ce-9a4c-a041c4b92f36','P039A','Zylinder 1 - Druck zu niedrig','-','2022-05-11T11:16:18.440282Z',0),
  ('BPNL00000003COJN',0,'cd34bfe1-da3e-4559-a077-40ba63d5ec30','P039B','Zylinder 1 - Druck zu hoch','-','2022-05-11T11:16:18.446278Z',0),
  ('BPNL00000003COJN',0,'cff0123a-26c8-4952-9d56-35e1c4b9a96e','P039C','Zylinder 1 - Druckabweichung niedrig','-','2022-05-11T11:16:18.454382Z',0),
  ('BPNL00000003COJN',0,'dab2c9df-b1e3-45da-a112-82e100213337','P039D','Zylinder 1 - Druckabweichung hoch','-','2022-05-11T11:16:18.466249Z',0),
  ('BPNL00000003COJN',0,'b1c62814-6f13-488a-b48a-055d71b8639b','P039E','Zylinder 1 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.472128Z',0),
  ('BPNL00000003COJN',0,'3816c59c-da10-472c-a6ed-6170903c9aec','P039F','Zylinderdrucksensor, Zylinder 2 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.478266Z',0),
  ('BPNL00000003COJN',0,'532476ab-04d2-4606-8e53-f5b7b566e6d5','P03A0','Zylinderdrucksensor, Zylinder 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.483971Z',0),
  ('BPNL00000003COJN',0,'f6eda89a-cb5b-48da-a245-2926d39b980e','P03A1','Zylinderdrucksensor, Zylinder 2 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.489995Z',0),
  ('BPNL00000003COJN',0,'ac59bd79-8365-4868-82c8-07518372cc50','P03A2','Zylinderdrucksensor, Zylinder 2 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.495906Z',0),
  ('BPNL00000003COJN',0,'a7d6a0e1-e1d4-486f-9fa1-555ebadd4dd9','P03A3','Zylinderdrucksensor, Zylinder 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.504076Z',0),
  ('BPNL00000003COJN',0,'077e395e-d75e-434f-98ce-d96b87edcd02','P03A4','Zylinder 2 - Druck zu niedrig','-','2022-05-11T11:16:18.508855Z',0),
  ('BPNL00000003COJN',0,'35f047b7-fc47-45dd-9d82-45507ebed9f7','P03A5','Zylinder 2 - Druck zu hoch','-','2022-05-11T11:16:18.513581Z',0),
  ('BPNL00000003COJN',0,'84241482-f166-4d16-8f13-14b690309957','P03A6','Zylinder 2 - Druckabweichung niedrig','-','2022-05-11T11:16:18.530559Z',0),
  ('BPNL00000003COJN',0,'e160c5c3-e57d-4207-8ccd-0e65505595f4','P03A7','Zylinder 2 - Druckabweichung hoch','-','2022-05-11T11:16:18.536470Z',0),
  ('BPNL00000003COJN',0,'f48e26a0-42b6-4067-b192-498bdf7fe8c0','P03A8','Zylinder 2 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.541056Z',0),
  ('BPNL00000003COJN',0,'79ea93c4-c250-4ebb-b631-116d54ad5536','P03A9','Zylinderdrucksensor, Zylinder 3 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.551632Z',0),
  ('BPNL00000003COJN',0,'4ae8c0a7-0d58-4d64-9c9b-f72d63f78c8d','P03AA','Zylinderdrucksensor, Zylinder 3 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.557423Z',0),
  ('BPNL00000003COJN',0,'c4394a39-b823-400d-8aea-084a9a447e9f','P03AB','Zylinderdrucksensor, Zylinder 3 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.570113Z',0),
  ('BPNL00000003COJN',0,'dc118d7a-1f22-4f6f-b850-9d07ce91256e','P03AC','Zylinderdrucksensor, Zylinder 3 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.575247Z',0),
  ('BPNL00000003COJN',0,'1b6b476d-8a4f-4d9d-96c2-5935e313230b','P03AD','Zylinderdrucksensor, Zylinder 3 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.580623Z',0),
  ('BPNL00000003COJN',0,'6bdd10e0-5f28-4cee-b21d-b0ec9343dfbf','P03AE','Zylinder 3 - Druck zu niedrig','-','2022-05-11T11:16:18.589526Z',0),
  ('BPNL00000003COJN',0,'c1e54965-db11-4b96-a48b-c912224c8928','P03AF','Zylinder 3 - Druck zu hoch','-','2022-05-11T11:16:18.594194Z',0),
  ('BPNL00000003COJN',0,'ebf975a9-6b00-4a1b-ac48-72ba598e8fdd','P03B0','Zylinder 3 - Druckabweichung niedrig','-','2022-05-11T11:16:18.600488Z',0),
  ('BPNL00000003COJN',0,'1f332049-4d5d-4d5a-bedf-3946437a5d79','P03B1','Zylinder 3 - Druckabweichung hoch','-','2022-05-11T11:16:18.605915Z',0),
  ('BPNL00000003COJN',0,'ece122fd-f6b3-4819-afc2-bd04a7c0338e','P03B2','Zylinder 3 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.610426Z',0),
  ('BPNL00000003COJN',0,'c3baf365-e4f7-48ce-bb0c-2576eca63154','P03B3','Zylinderdrucksensor, Zylinder 4 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.618795Z',0),
  ('BPNL00000003COJN',0,'70f8dcac-8473-4953-a044-13a913d5162b','P03B4','Zylinderdrucksensor, Zylinder 4 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.623279Z',0),
  ('BPNL00000003COJN',0,'eb45abc3-17ec-4de0-91b7-a6a3a122252f','P03B5','Zylinderdrucksensor, Zylinder 4 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.627624Z',0),
  ('BPNL00000003COJN',0,'93a90a31-6340-4baa-825d-42c56b41beb5','P03B6','Zylinderdrucksensor, Zylinder 4 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.632210Z',0),
  ('BPNL00000003COJN',0,'115c43f9-7d3a-40a0-b61b-62aaf3449c33','P03B7','Zylinderdrucksensor, Zylinder 4 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.636755Z',0),
  ('BPNL00000003COJN',0,'1c374b70-bc7c-483a-b07c-059652dd481d','P03B8','Zylinder 4 - Druck zu niedrig','-','2022-05-11T11:16:18.642194Z',0),
  ('BPNL00000003COJN',0,'69c3f796-a177-4fce-9394-d462d6b6bda8','P03B9','Zylinder 4 - Druck zu hoch','-','2022-05-11T11:16:18.651448Z',0),
  ('BPNL00000003COJN',0,'7f6b7175-269f-42f9-ab5a-7e18adf6b505','P03BA','Zylinder 4 - Druckabweichung niedrig','-','2022-05-11T11:16:18.655951Z',0),
  ('BPNL00000003COJN',0,'e7f588ce-0c0b-40e2-9cb8-1ed9b8d70a29','P03BB','Zylinder 4 - Druckabweichung hoch','-','2022-05-11T11:16:18.662288Z',0),
  ('BPNL00000003COJN',0,'4acb8117-6c99-4885-b7a0-94259a27ff0c','P03BC','Zylinder 4 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.667006Z',0),
  ('BPNL00000003COJN',0,'72b06d8c-1b3e-4f57-a244-4662ac792ff3','P03BD','Zylinderdrucksensor, Zylinder 5 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.671342Z',0),
  ('BPNL00000003COJN',0,'b0b0a0ad-0f7a-4d1d-b35a-50cc315f0028','P03BE','Zylinderdrucksensor, Zylinder 5 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.676052Z',0),
  ('BPNL00000003COJN',0,'b9af600d-1d14-4429-b0a7-f603540ea4be','P03BF','Zylinderdrucksensor, Zylinder 5 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.680558Z',0),
  ('BPNL00000003COJN',0,'90cb6d18-81da-4549-8106-773cef58ee0d','P03C0','Zylinderdrucksensor, Zylinder 5 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.687052Z',0),
  ('BPNL00000003COJN',0,'9947128c-bca3-4568-92d5-36cacfd37acf','P03C1','Zylinderdrucksensor, Zylinder 5 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.691688Z',0),
  ('BPNL00000003COJN',0,'2bfd51f3-5110-4b3b-87b2-a06b614d6f39','P03C2','Zylinder 5 - Druck zu niedrig','-','2022-05-11T11:16:18.696106Z',0),
  ('BPNL00000003COJN',0,'59578d90-7aeb-4c0c-92a8-6e2747291b32','P03C3','Zylinder 5 - Druck zu hoch','-','2022-05-11T11:16:18.701374Z',0),
  ('BPNL00000003COJN',0,'e7860aef-a6d4-4cb1-9a06-dbb649f1a732','P03C4','Zylinder 5 - Druckabweichung niedrig','-','2022-05-11T11:16:18.706057Z',0),
  ('BPNL00000003COJN',0,'b17ae86a-4e73-47d9-a0f1-0f8c511f1194','P03C5','Zylinder 5 - Druckabweichung hoch','-','2022-05-11T11:16:18.722371Z',0),
  ('BPNL00000003COJN',0,'9f995698-e27e-4308-b087-6975208cabc1','P03C7','Zylinderdrucksensor, Zylinder 6 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.735141Z',0),
  ('BPNL00000003COJN',0,'33c428a1-7419-4b01-a8b5-d7365415bfbe','P03C8','Zylinderdrucksensor, Zylinder 6 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.740302Z',0),
  ('BPNL00000003COJN',0,'93855366-035e-4704-a18a-08998d97f318','P03C9','Zylinderdrucksensor, Zylinder 6 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.745205Z',0),
  ('BPNL00000003COJN',0,'d3ffe17d-0c31-49a8-a26a-86ab282c6b99','P03CA','Zylinderdrucksensor, Zylinder 6 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.750698Z',0),
  ('BPNL00000003COJN',0,'81fc95d2-0a69-42e9-94f3-4fec4dca0ac1','P03CB','Zylinderdrucksensor, Zylinder 6 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.760236Z',0),
  ('BPNL00000003COJN',0,'42552b64-f3d5-4821-9227-ef7d0669c6a7','P03CC','Zylinder 6 - Druck zu niedrig','-','2022-05-11T11:16:18.765519Z',0),
  ('BPNL00000003COJN',0,'933d7b64-c00c-437d-9b24-56ee27f1ef28','P03CD','Zylinder 6 - Druck zu hoch','-','2022-05-11T11:16:18.770316Z',0),
  ('BPNL00000003COJN',0,'ee2c379d-1ea8-4ac2-be12-7781d8842792','P03CE','Zylinder 6 - Druckabweichung niedrig','-','2022-05-11T11:16:18.775352Z',0),
  ('BPNL00000003COJN',0,'d8483752-a9c1-4e71-ba86-1935d659f7fb','P03CF','Zylinder 6 - Druckabweichung hoch','-','2022-05-11T11:16:18.779813Z',0),
  ('BPNL00000003COJN',0,'b4bf749e-6d65-40d0-875c-aec8f7a5cf98','P03D0','Zylinder 6 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.784880Z',0),
  ('BPNL00000003COJN',0,'400a4491-0e3b-48cd-a045-6224f319e0c7','P03D1','Zylinderdrucksensor, Zylinder 7 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.789373Z',0),
  ('BPNL00000003COJN',0,'250a6785-207e-4020-903e-cb260863b097','P03D2','Zylinderdrucksensor, Zylinder 7 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.794228Z',0),
  ('BPNL00000003COJN',0,'08680504-457b-4dbd-a609-74845737b082','P03D3','Zylinderdrucksensor, Zylinder 7 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.799057Z',0),
  ('BPNL00000003COJN',0,'a5c9681b-3846-4267-aefc-78d7b7f17e42','P03D4','Zylinderdrucksensor, Zylinder 7 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.804183Z',0),
  ('BPNL00000003COJN',0,'773605d7-be42-4979-891d-f8fba880c4f2','P03D5','Zylinderdrucksensor, Zylinder 7 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.809253Z',0),
  ('BPNL00000003COJN',0,'38616d96-a71d-4646-848f-38bf83e25dfb','P03D6','Zylinder 7 - Druck zu niedrig','-','2022-05-11T11:16:18.814866Z',0),
  ('BPNL00000003COJN',0,'2a7a919d-00c7-4a35-bb18-e024425493eb','P03D7','Zylinder 7 - Druck zu hoch','-','2022-05-11T11:16:18.819557Z',0),
  ('BPNL00000003COJN',0,'213b27d7-ec96-4c25-ae85-0bb17ff5a578','P03D8','Zylinder 7 - Druckabweichung niedrig','-','2022-05-11T11:16:18.825600Z',0),
  ('BPNL00000003COJN',0,'19ce2042-f42a-48c9-9b46-28355ed2a2e2','P03D9','Zylinder 7 - Druckabweichung hoch','-','2022-05-11T11:16:18.831245Z',0),
  ('BPNL00000003COJN',0,'e358f035-3e87-45e0-bda0-6abf34155390','P03DA','Zylinder 7 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.837081Z',0),
  ('BPNL00000003COJN',0,'9562bac0-feb5-447b-a276-6c50cd7a6942','P03DB','Zylinderdrucksensor, Zylinder 8 - Fehlfunktion Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.842169Z',0),
  ('BPNL00000003COJN',0,'db733467-02e2-4d9d-85d4-a094899e9687','P03DC','Zylinderdrucksensor, Zylinder 8 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.847211Z',0),
  ('BPNL00000003COJN',0,'dece605f-2578-47c8-abc3-8662a0859dbc','P03DD','Zylinderdrucksensor, Zylinder 8 - Signal zu niedrig','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.852535Z',0),
  ('BPNL00000003COJN',0,'8cfbdaef-700c-4dc3-bd77-73486c1db3ff','P03DE','Zylinderdrucksensor, Zylinder 8 - Signal zu hoch','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.857528Z',0),
  ('BPNL00000003COJN',0,'037c766c-8b0a-4a7f-b52a-abe94286ceec','P03DF','Zylinderdrucksensor, Zylinder 8 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Zylinderdrucksensor, Motorsteuergerät','2022-05-11T11:16:18.862235Z',0),
  ('BPNL00000003COJN',0,'ac397364-38a2-4b47-9d96-63557ac68807','P03E0','Zylinder 8 - Druck zu niedrig','-','2022-05-11T11:16:18.867119Z',0),
  ('BPNL00000003COJN',0,'74d76775-42e6-4e82-83aa-d4592d3f723a','P03E1','Zylinder 8 - Druck zu hoch','-','2022-05-11T11:16:18.872348Z',0),
  ('BPNL00000003COJN',0,'0a69f34f-229d-4664-b42e-a23a1b7bf3d3','P03E2','Zylinder 8 - Druckabweichung niedrig','-','2022-05-11T11:16:18.877404Z',0),
  ('BPNL00000003COJN',0,'1436f13e-728e-4034-8bdc-c86babee3f6b','P03E3','Zylinder 8 - Druckabweichung hoch','-','2022-05-11T11:16:18.882243Z',0),
  ('BPNL00000003COJN',0,'f10ce8f3-dafc-4bca-8bf1-46b346a2f010','P03E4','Zylinder 8 - Funktionsfehler Verbrennungsgrad','-','2022-05-11T11:16:18.887668Z',0),
  ('BPNL00000003COJN',0,'c065c083-c0e0-421f-945c-564ca76501ca','P0400','Abgasrückführung - Fehlfunktion Flussrate','Schlauch undicht/blockiert, Grundeinstellung nicht durchgeführt (falls erforderlich), Kabelbaum, AGR-Ventil, AGR-Magnetspule, Motorsteuergerät','2022-05-11T11:16:18.892203Z',0),
  ('BPNL00000003COJN',0,'8af29758-0e1f-4e05-93d1-2489cdfb36df','P0401','Abgasrückführung - unzureichende Flussrate festgestellt','Schlauch undicht/blockiert, Grundeinstellung nicht durchgeführt (falls erforderlich), Kabelbaum, AGR-Ventil, AGR-Magnetspule, Motorsteuergerät','2022-05-11T11:16:18.897723Z',0),
  ('BPNL00000003COJN',0,'3be62313-6091-4e56-99ab-a6ccfc7b876e','P0402','Abgasrückführung - übermäßige Flussrate festgestellt','Schlauch undicht/blockiert, Grundeinstellung nicht durchgeführt (falls erforderlich), Kabelbaum, AGR-Ventil, AGR-Magnetspule, Motorsteuergerät','2022-05-11T11:16:18.902650Z',0),
  ('BPNL00000003COJN',0,'fa5d4be4-b71a-454b-bf5c-308531298269','P0403','Abgasrückführung - Fehlfunktion Stromkreis','Kabelbaum, AGR-Magnetspule, Motorsteuergerät','2022-05-11T11:16:18.907406Z',0),
  ('BPNL00000003COJN',0,'7fa7ae5e-b9ed-4e0c-8206-3cb518555233','P0404','Abgasrückführung - Bereichs-/Funktionsfehler','Schlauch undicht/blockiert, Kabelbaum, AGR-Stellventil/-Magnetspule','2022-05-11T11:16:18.913179Z',0),
  ('BPNL00000003COJN',0,'58dbd615-07ee-42cf-ae1c-212d221f7f5f','P0405','AGR-Ventilstellungssensor A - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:18.919134Z',0),
  ('BPNL00000003COJN',0,'44359261-30a0-409f-a5a3-bef4cff584a6','P0406','AGR-Ventilstellungssensor A - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:18.923986Z',0),
  ('BPNL00000003COJN',0,'db3e8d4a-7533-4eab-b0c7-e27756c66730','P0407','AGR-Ventilstellungssensor B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:18.929414Z',0),
  ('BPNL00000003COJN',0,'0ef2cf3e-ba8e-4c89-a470-52d922c72083','P0408','AGR-Ventilstellungssensor B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:18.934051Z',0),
  ('BPNL00000003COJN',0,'9051c725-aa36-47bf-857c-71be02634f47','P0409','AGR-Sensor A - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:18.939188Z',0),
  ('BPNL00000003COJN',0,'f645e9ac-12c3-4e5e-96c0-f4b37b195118','P040A','AGR-Temperatursensor A - Fehlfunktion Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.944328Z',0),
  ('BPNL00000003COJN',0,'20f36ae3-b09a-450f-896f-36cd0c1077c2','P040B','AGR-Temperatursensor A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.952109Z',0),
  ('BPNL00000003COJN',0,'13180eb6-6066-4765-a77d-91aa8835dd4c','P040C','AGR-Temperatursensor A - Signal zu niedrig','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.957212Z',0),
  ('BPNL00000003COJN',0,'837264e6-ccf6-4363-ab2e-10300ae78b3b','P040D','AGR-Temperatursensor A - Signal zu hoch','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.962192Z',0),
  ('BPNL00000003COJN',0,'f44f0572-eb6c-42cf-8da9-0fee1a21c995','P040E','AGR-Temperatursensor A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.966780Z',0),
  ('BPNL00000003COJN',0,'810c09c7-7888-4ae2-aa99-824c074dff88','P040F','AGR-Temperatursensor A/B - Bezugsfehler','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:18.972286Z',0),
  ('BPNL00000003COJN',0,'3a0c27d5-ca5d-4343-bac7-e2c666bcadd8','P0410','Sekundärlufteinblasung - Fehlfunktion','Kabelbaum, Sekundärluftventil, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:18.976973Z',0),
  ('BPNL00000003COJN',0,'4920be8f-215f-4d45-aaa0-805e96d8810f','P0411','Sekundärlufteinblasung - falsche Flussrate festgestellt','Sekundärluftpumpe, Sekundärluftventil, Sekundärluftschläuche','2022-05-11T11:16:18.981397Z',0),
  ('BPNL00000003COJN',0,'d3843fd1-449b-4492-8a70-cc1b1c96807e','P0412','Sekundärluft-Magnetventil A - Fehlfunktion Stromkreis','Kabelbaum, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:18.986866Z',0),
  ('BPNL00000003COJN',0,'20793f7f-0e52-44c4-a750-4833e7395108','P07A2','Getriebereibelement A - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.317655Z',0),
  ('BPNL00000003COJN',0,'a04f94f2-2a46-4c79-b3e2-00e734043d54','P0413','Sekundärluft-Magnetventil A - offener Stromkreis','Kabelbaum unterbrochen, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:18.991459Z',0),
  ('BPNL00000003COJN',0,'0b1c6f3d-9f3c-48eb-8608-d8fb8820e7b2','P0414','Sekundärluft-Magnetventil A - Kurzschluss','Kurzschluss im Kabelbaum, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:18.996499Z',0),
  ('BPNL00000003COJN',0,'e3ab122a-1a71-4e9f-88d1-3f0f93d980ee','P0415','Sekundärluft-Magnetventil B - Fehlfunktion Stromkreis','Kabelbaum, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.001420Z',0),
  ('BPNL00000003COJN',0,'479854a9-eb53-4da6-b31f-5ea28297f1c2','P0416','Sekundärluft-Magnetventil B - offener Stromkreis','Kabelbaum unterbrochen, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.006453Z',0),
  ('BPNL00000003COJN',0,'30c9f36f-e5f5-452b-80f7-2be24964aa5e','P0417','Sekundärluft-Magnetventil B - Kurzschluss','Kurzschluss im Kabelbaum, Sekundärluft-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.012100Z',0),
  ('BPNL00000003COJN',0,'9514b5f2-d586-477e-b19e-11b6566838c4','P0418','Sekundärluftpumpenrelais A - Fehlfunktion Stromkreis','Kabelbaum, Sekundärluftpumpenrelais, Motorsteuergerät','2022-05-11T11:16:19.018645Z',0),
  ('BPNL00000003COJN',0,'a0529f2d-6b08-4b27-9da7-e87165bddfeb','P0419','Sekundärluftpumpenrelais B - Fehlfunktion Stromkreis','Kabelbaum, Sekundärluftpumpenrelais, Motorsteuergerät','2022-05-11T11:16:19.023421Z',0),
  ('BPNL00000003COJN',0,'c423eeff-7a96-4d76-89f0-5269b7d3bbc5','P041A','AGR-Temperatursensor B - Fehlfunktion Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.032207Z',0),
  ('BPNL00000003COJN',0,'ce717f7a-0143-4ebc-92b3-5b2e47000b09','P041B','AGR-Temperatursensor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.037487Z',0),
  ('BPNL00000003COJN',0,'b3f5f29b-755f-4d35-b6b6-c9b6a88ffd65','P041C','AGR-Temperatursensor B - Signal zu niedrig','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.042814Z',0),
  ('BPNL00000003COJN',0,'925de6ab-c30d-44a6-891e-c4626ee648b0','P041D','AGR-Temperatursensor B - Signal zu hoch','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.048158Z',0),
  ('BPNL00000003COJN',0,'2ee40704-aa41-4c14-988c-5f602616632c','P041E','AGR-Temperatursensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.052931Z',0),
  ('BPNL00000003COJN',0,'c30d0de6-7182-4618-83bf-f25a6e827383','P041F','Sekundärluft-Umschaltventil A - Signal zu niedrig','Kabelbaum, Sekundärluft-Umschaltventil, Motorsteuergerät','2022-05-11T11:16:19.058538Z',0),
  ('BPNL00000003COJN',0,'1c1a0208-8d45-4207-ac3d-c09f61af6398','P0420','Katalysatoranlage, Zylinderreihe 1 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.064118Z',0),
  ('BPNL00000003COJN',0,'ddaf59af-99a1-444b-9789-85069baea65e','P0421','Startkatalysator, Zylinderreihe 1 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.068461Z',0),
  ('BPNL00000003COJN',0,'80c040bc-26b8-4f57-a179-91bc71fdfe95','P0422','Hauptkatalysator, Zylinderreihe 1 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.072630Z',0),
  ('BPNL00000003COJN',0,'6ff6ca1c-accc-4fd8-99b1-cd44701e8811','P0423','Beheizter Katalysator, Zylinderreihe 1 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.077370Z',0),
  ('BPNL00000003COJN',0,'a92bdb85-4d59-44c6-b9cb-d9ae60918bd3','P0424','Beheizter Katalysator, Zylinderreihe 1 - Temperatur unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.083435Z',0),
  ('BPNL00000003COJN',0,'c0c5a7d0-5c0f-4544-9b39-0aaa47bfa78b','P0425','Katalysator-Temperatursensor, Zylinderreihe 1','Kabelbaum, schlechte Kontaktierung, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.087871Z',0),
  ('BPNL00000003COJN',0,'9667fb45-7c62-4c65-b94f-10e533c8521d','P0426','Katalysator-Temperatursensor, Zylinderreihe 1 - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Katalysator-Temperatursensor','2022-05-11T11:16:19.093395Z',0),
  ('BPNL00000003COJN',0,'80d7d8e6-ce8e-4580-ad5b-9ffb3c7aae39','P0427','Katalysator-Temperatursensor, Zylinderreihe 1 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.097966Z',0),
  ('BPNL00000003COJN',0,'3d93144a-7790-4291-8066-8e47e266325f','P0428','Katalysator-Temperatursensor, Zylinderreihe 1 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.105443Z',0),
  ('BPNL00000003COJN',0,'5b4f8e62-c943-4dc6-9c50-a769bdb9bd9b','P0429','Katalysator-Heizelement, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Relais, Motorsteuergerät','2022-05-11T11:16:19.111670Z',0),
  ('BPNL00000003COJN',0,'ce48c0e9-7278-49b9-887a-23bd3010d826','P042A','Katalysator-Temperatursensor 2, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.116996Z',0),
  ('BPNL00000003COJN',0,'df68bab3-d744-418d-aa35-10259f7597c4','P042B','Katalysator-Temperatursensor 2, Zylinderreihe 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.121442Z',0),
  ('BPNL00000003COJN',0,'9e5e340f-2d4e-457c-b4b9-735ed539f480','P042C','Katalysator-Temperatursensor 2, Zylinderreihe 1 - Signal zu niedrig','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.126139Z',0),
  ('BPNL00000003COJN',0,'7e0ffe22-046c-49b3-b724-b64ed257628a','P042D','Katalysator-Temperatursensor 2, Zylinderreihe 1 - Signal zu hoch','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.131627Z',0),
  ('BPNL00000003COJN',0,'58acc934-c4c7-4bd4-919b-f9a3382f0a9e','P042E','AGR-Ventilstellglied A - Stellglied klemmt in geöffneter Stellung','Kabelbaum, AGR-Ventilstellglied, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.136781Z',0),
  ('BPNL00000003COJN',0,'1900f81a-c015-4174-a3dd-97ec9110dc68','P042F','AGR-Ventilstellglied A - Stellglied klemmt in geschlossener Stellung','Kabelbaum, AGR-Ventilstellglied, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.141581Z',0),
  ('BPNL00000003COJN',0,'c1f7d811-436b-420d-abb3-c25316534147','P0430','Katalysatoranlage, Zylinderreihe 2 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.147854Z',0),
  ('BPNL00000003COJN',0,'bcaab1e8-b573-48da-81a1-7043a17998b8','P0431','Startkatalysator, Zylinderreihe 2 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.156020Z',0),
  ('BPNL00000003COJN',0,'87c8ccc2-9b2f-4fff-9e5a-9eecf2e682f7','P0432','Hauptkatalysator, Zylinderreihe 2 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.160978Z',0),
  ('BPNL00000003COJN',0,'8f89ede1-675e-40af-bb30-b62b29d48660','P0433','Beheizter Katalysator, Zylinderreihe 2 - Wirkungsgrad unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.165645Z',0),
  ('BPNL00000003COJN',0,'cb5a4aa6-c4ec-422a-9fae-c1961f5df2c6','P0434','Beheizter Katalysator, Zylinderreihe 2 - Temperatur unter Schwellenwert','Katalysator, Kabelbaum, beheizte Lambdasonde 2','2022-05-11T11:16:19.170311Z',0),
  ('BPNL00000003COJN',0,'02ec4d4c-72b7-45fa-9729-83de9e31b03d','P0435','Katalysator-Temperatursensor, Zylinderreihe 2','Kabelbaum, schlechte Kontaktierung, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.174642Z',0),
  ('BPNL00000003COJN',0,'2c384303-b083-4527-8188-2e6941c68780','P0436','Katalysator-Temperatursensor, Zylinderreihe 2 - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Katalysator-Temperatursensor','2022-05-11T11:16:19.178929Z',0),
  ('BPNL00000003COJN',0,'95a3ed2a-ac9c-428c-a8d0-511ee8f95f00','P0437','Katalysator-Temperatursensor, Zylinderreihe 2 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.183068Z',0),
  ('BPNL00000003COJN',0,'b7d7d365-8707-4ba4-8b74-1cfbfdef0db4','P0438','Katalysator-Temperatursensor, Zylinderreihe 2 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.188202Z',0),
  ('BPNL00000003COJN',0,'ef047745-00c3-45a2-ac02-8e1b630fa64e','P0439','Katalysator-Heizelement, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Relais, Motorsteuergerät','2022-05-11T11:16:19.192912Z',0),
  ('BPNL00000003COJN',0,'2f1900cd-ff63-41be-b821-9d948bc302e7','P043A','Katalysator-Temperatursensor 2, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.197487Z',0),
  ('BPNL00000003COJN',0,'502e3751-5d40-4eda-9abb-4722aacc3df5','P043B','Katalysator-Temperatursensor 2, Zylinderreihe 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.206032Z',0),
  ('BPNL00000003COJN',0,'c5cde05c-bea6-4110-9559-14a0fd3fc01d','P043C','Katalysator-Temperatursensor 2, Zylinderreihe 2 - Signal zu niedrig','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.210606Z',0),
  ('BPNL00000003COJN',0,'f8d43156-9741-434f-85fe-f85e8c4561c8','P043D','Katalysator-Temperatursensor 2, Zylinderreihe 2 - Signal zu hoch','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.215265Z',0),
  ('BPNL00000003COJN',0,'89d2a3c9-1cf9-4e6f-9521-aa628024f41c','P043E','Kontrollbohrung für Kraftstoffdampfauffangsystem-Dichtheitsprüfung - geringe Flussrate','Kabelbaum, Steuergerät für Kraftstoffdampfauffangsystem-Dichtheitsprüfung, Schlauchanschlüsse, Motorsteuergerät','2022-05-11T11:16:19.220538Z',0),
  ('BPNL00000003COJN',0,'4172ce6c-85c9-4d22-9ae8-eaada7865ee9','P043F','Kontrollbohrung für Kraftstoffdampfauffangsystem-Dichtheitsprüfung - übermäßige Flussrate festgestellt','Kabelbaum, Steuergerät für Kraftstoffdampfauffangsystem-Dichtheitsprüfung, Schlauchanschlüsse, Motorsteuergerät','2022-05-11T11:16:19.226633Z',0),
  ('BPNL00000003COJN',0,'7519ce66-5fa2-4d85-adc8-8fbeda1784ab','P0440','Kraftstoffdampf-Auffangssystem - Fehlfunktion','Schlauchverbindung(en), einlassseitige Undichtigkeit, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.232091Z',0),
  ('BPNL00000003COJN',0,'51ebc852-8973-4458-9d85-6247c80accad','P0441','Kraftstoffdampf-Auffangssystem - falsche Flussrate festgestellt','Schlauchverbindung(en), einlassseitige Undichtigkeit, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.236763Z',0),
  ('BPNL00000003COJN',0,'a07bb997-2fb2-4dc1-8cf5-5c160602e2b1','P0442','Kraftstoffdampf-Auffangssystem - kleine Undichtigkeit festgestellt','Schlauchverbindung(en), einlassseitige Undichtigkeit, Kraftstoffdampf-Aktivkohlefilter, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.242980Z',0),
  ('BPNL00000003COJN',0,'281029e1-540d-48dc-bc8d-8168d8f8d42e','P0443','Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.250798Z',0),
  ('BPNL00000003COJN',0,'378be2d0-61f2-4cd9-a66c-fbaedf8e11a0','P0444','Kraftstoffdampf-Aktivkohlefilter-Magnetventil - offener Stromkreis','Kabelbaum unterbrochen, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.255857Z',0),
  ('BPNL00000003COJN',0,'b0ce81f8-9b50-4dba-954f-93579ba5c76f','P0445','Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Kurzschluss','Kurzschluss im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.260451Z',0),
  ('BPNL00000003COJN',0,'84f5748e-7e87-45fe-8df9-c6b75113aedf','P0446','Kraftstoffdampf-Auffangssystem, Belüftungsregelung - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.265444Z',0),
  ('BPNL00000003COJN',0,'bd7d668a-4709-42f4-be1d-56984008d885','P0447','Kraftstoffdampf-Auffangssystem, Belüftungsregelung - offener Stromkreis','Kabelbaum unterbrochen, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.270177Z',0),
  ('BPNL00000003COJN',0,'4724c368-fe2e-4586-9a86-72bb739d610b','P0448','Kraftstoffdampf-Auffangssystem, Belüftungsregelung - Kurzschluss','Kurzschluss im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.274549Z',0),
  ('BPNL00000003COJN',0,'b482c5a4-6765-4264-9e1f-8efafd6bcac7','P0449','Kraftstoffdampf-Auffangssystem, Entlüftungsventil - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.279453Z',0),
  ('BPNL00000003COJN',0,'a20fe560-0545-42c6-8237-79135093a914','P044A','AGR-Sensor C - Fehlfunktion Stromkreis','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.284011Z',0),
  ('BPNL00000003COJN',0,'9f8c92e3-8476-4f4d-94d7-70cd69e30a61','P044B','AGR-Sensor C - Bereichs-/Funktionsfehler','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.288565Z',0),
  ('BPNL00000003COJN',0,'15cfdccf-21c5-4975-9b58-2846a5aea6ed','P044C','AGR-Ventilstellungssensor C - Signal zu niedrig','Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:19.293396Z',0),
  ('BPNL00000003COJN',0,'f93a5ba8-7ed5-45c6-8aa7-b2f92cd38464','P044D','AGR-Sensor C - Signal zu hoch','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.298910Z',0),
  ('BPNL00000003COJN',0,'3b7d6b0e-9fe2-453c-882d-d33ed371f312','P044E','AGR-Sensor C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.310648Z',0),
  ('BPNL00000003COJN',0,'f48b62fe-e9a9-4fc1-96ef-ea4e7f14a24e','P044F','Sekundärluft-Umschaltventil A - Signal zu hoch','Kabelbaum, Sekundärluft-Umschaltventil, Motorsteuergerät','2022-05-11T11:16:19.315692Z',0),
  ('BPNL00000003COJN',0,'ece1a906-af90-4c9f-8648-142b34d6f4a5','P0450','Kraftstoffdampf-Auffangssystem-Drucksensor - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffdampf-Auffangssystem-Drucksensor, Motorsteuergerät','2022-05-11T11:16:19.321339Z',0),
  ('BPNL00000003COJN',0,'b0484eb9-3ab2-4e23-bf0c-6e0078f5b8f1','P0451','Kraftstoffdampf-Auffangssystem-Drucksensor - Bereichs-/Funktionsfehler','Kraftstoffdampf-Auffangssystem-Drucksensor','2022-05-11T11:16:19.335011Z',0),
  ('BPNL00000003COJN',0,'288589d1-07a4-4fd3-9c71-46c9b4cd1b2c','P0452','Kraftstoffdampf-Auffangssystem-Drucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffdampf-Auffangssystem-Drucksensor, Motorsteuergerät','2022-05-11T11:16:19.340540Z',0),
  ('BPNL00000003COJN',0,'2951e2ce-83e2-4941-961f-a870009bee87','P0453','Kraftstoffdampf-Auffangssystem-Drucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffdampf-Auffangssystem-Drucksensor, Motorsteuergerät','2022-05-11T11:16:19.345929Z',0),
  ('BPNL00000003COJN',0,'62ef6317-06a5-444d-ba8b-55034bfbf28f','P0454','Kraftstoffdampf-Auffangssystem-Drucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstoffdampf-Auffangssystem-Drucksensor, Motorsteuergerät','2022-05-11T11:16:19.353692Z',0),
  ('BPNL00000003COJN',0,'a8c70ee9-4dc6-401b-93d8-004f9d34187f','P0455','Kraftstoffdampf-Auffangssystem - große Undichtigkeit festgestellt','Schlauchverbindung(en), einlassseitige Undichtigkeit, Kraftstoffdampf-Aktivkohlefilter, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.378370Z',0),
  ('BPNL00000003COJN',0,'00a65a34-1eb6-4d1d-8602-7fb013cf69da','P0456','Kraftstoffdampf-Auffangssystem - kleinste Undichtigkeit festgestellt','Mechanische Fehlfunktion, Schlauchverbindung(en), Kraftstoffdampf-Auffangssystem-Drucksensor','2022-05-11T11:16:19.383554Z',0),
  ('BPNL00000003COJN',0,'77ca4a2c-0c1c-48ac-8785-28e1267e8d0b','P0457','Kraftstoffdampf-Auffangssystem - Undichtigkeit festgestellt (Tankdeckel undicht/fehlt)','Mechanische Fehlfunktion, Schlauchverbindung(en), Kraftstoffdampf-Auffangssystem-Drucksensor','2022-05-11T11:16:19.388259Z',0),
  ('BPNL00000003COJN',0,'c54b3c37-5ddd-4171-9954-e82a96fa1bf8','P0458','Kraftstoffdampf-Auffangssystem, Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.427304Z',0),
  ('BPNL00000003COJN',0,'a6d2116a-361c-45a6-9350-5905ca3013c0','P0459','Kraftstoffdampf-Auffangssystem, Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.433375Z',0),
  ('BPNL00000003COJN',0,'97e91663-7973-40a5-8f09-ace1da5993d0','P045A','AGR-Ventilstellglied B - Fehlfunktion Stromkreis','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.438324Z',0),
  ('BPNL00000003COJN',0,'6ec94de3-9d4a-44c8-ab98-4803e5abee50','P045B','AGR-Ventil B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, AGR-Ventil, Motorsteuergerät','2022-05-11T11:16:19.443436Z',0),
  ('BPNL00000003COJN',0,'fc8547f9-7dfa-4e91-868e-17f3f71f199e','P045C','AGR-Ventilstellglied B - Signal zu niedrig','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.449203Z',0),
  ('BPNL00000003COJN',0,'b2d90d0f-d6fd-4ec4-ab28-935199798f35','P045D','AGR-Ventilstellglied B - Signal zu hoch','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.454824Z',0),
  ('BPNL00000003COJN',0,'6de218fb-cb59-4d44-92dc-08abca03e635','P045E','AGR-Ventilstellglied B - Stellglied klemmt in geöffneter Stellung','Kabelbaum, AGR-Ventilstellglied, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.463954Z',0),
  ('BPNL00000003COJN',0,'3a39c169-8c4a-404f-8a9d-eafca7630782','P045F','AGR-Ventil B - Ventil klemmt in geschlossener Stellung','Kabelbaum, AGR-Ventil, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.469170Z',0),
  ('BPNL00000003COJN',0,'a6b50611-5ed5-4e05-9acd-61939ce882b0','P0460','Kraftstoffstandsensor - Fehlfunktion Stromkreis','Kabelbaum, Kraftstoffstandsensor, Motorsteuergerät','2022-05-11T11:16:19.474406Z',0),
  ('BPNL00000003COJN',0,'a868207b-cb26-4065-881b-77a16c984df9','P0461','Kraftstoffstandsensor - Bereichs-/Funktionsfehler','Kabelbaum, Kraftstoffstandsensor','2022-05-11T11:16:19.478972Z',0),
  ('BPNL00000003COJN',0,'b146b5e1-0a4e-4c62-8eed-464f377a492c','P0462','Kraftstoffstandsensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffstandsensor, Motorsteuergerät','2022-05-11T11:16:19.485134Z',0),
  ('BPNL00000003COJN',0,'7487d61a-c302-4746-9c00-76518deed272','P0463','Kraftstoffstandsensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffstandsensor, Motorsteuergerät','2022-05-11T11:16:19.500327Z',0),
  ('BPNL00000003COJN',0,'8c727f51-d68d-4a94-ac89-104b0cb22ded','P0464','Kraftstoffstandsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kraftstoffstandsensor, Motorsteuergerät','2022-05-11T11:16:19.506584Z',0),
  ('BPNL00000003COJN',0,'4ca1c812-eb49-4a1d-935f-e61350c0cd0a','P0465','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Fehlfunktion Stromkreis','Kabelbaum, Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.522354Z',0),
  ('BPNL00000003COJN',0,'3c2dbc68-373a-42aa-a673-748b20a79b3e','P0466','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Bereichs-/Funktionsfehler','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.527886Z',0),
  ('BPNL00000003COJN',0,'1a6c32fc-17b4-433f-8aa4-dbd0c7508d36','P0467','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.533207Z',0),
  ('BPNL00000003COJN',0,'3426e81a-85ec-415c-9c0f-4b69c1f51025','P0468','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.537664Z',0),
  ('BPNL00000003COJN',0,'2a07a93b-3800-463c-b93c-be6b98310748','P0469','Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Strömungssensor Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:19.542121Z',0),
  ('BPNL00000003COJN',0,'625b7f93-6f03-4e51-8fa0-cd0a31a1eee7','P046A','Katalysator-Temperatursensor 1/2, Zylinderreihe 1 - Bezugsfehler','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.549967Z',0),
  ('BPNL00000003COJN',0,'73a95e5f-4a39-4dea-b669-e16abfbe0336','P046B','Katalysator-Temperatursensor 1/2, Zylinderreihe 2 - Bezugsfehler','Kabelbaum, Katalysator-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:19.554815Z',0),
  ('BPNL00000003COJN',0,'3509c70c-6661-4d2a-a02b-fe538d84b54d','P046C','AGR-Ventilstellungssensor A - Bereichs-/Funktionsfehler','Kabelbaum, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:19.582227Z',0),
  ('BPNL00000003COJN',0,'f17aa9e8-0ce7-41a1-9230-5ce2447ef867','P046D','AGR-Sensor A - zeitweilig unterbrochener Betrieb/zeitweilige Unterbrechungen','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.590143Z',0),
  ('BPNL00000003COJN',0,'b6da8bab-ac5d-4c06-abaf-14d876398e0f','P046E','AGR-Sensor B - Bereichs-/Funktionsfehler','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.595135Z',0),
  ('BPNL00000003COJN',0,'16b59a5c-d930-412f-af12-2ab974c886b4','P046F','AGR-Sensor B - zeitweilig unterbrochener Betrieb/zeitweilige Unterbrechungen','Kabelbaum, AGR-Sensor, Motorsteuergerät','2022-05-11T11:16:19.613354Z',0),
  ('BPNL00000003COJN',0,'0093f04a-f094-422c-a78a-5c5cea32ce7c','P0470','Abgasdrucksensor - Fehlfunktion Stromkreis','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.627620Z',0),
  ('BPNL00000003COJN',0,'b314ef62-9028-4f9b-a80f-573ec6fac695','P0471','Abgasdrucksensor - Bereichs-/Funktionsfehler','Abgasdrucksensor','2022-05-11T11:16:19.635954Z',0),
  ('BPNL00000003COJN',0,'761446eb-cb90-4bae-8778-90fc4b708683','P0472','Abgasdrucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.640763Z',0),
  ('BPNL00000003COJN',0,'6f672368-5262-4a44-84d3-ba1f4a09d2e2','P0473','Abgasdrucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.645327Z',0),
  ('BPNL00000003COJN',0,'ba3867a8-4e08-4523-8fcd-632c9384fce6','P0474','Abgasdrucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.650292Z',0),
  ('BPNL00000003COJN',0,'4938daf1-13e6-4c5b-9f81-e375eb1bd1c2','P0475','Abgasdruckregelventil - Fehlfunktion Stromkreis','Kabelbaum, Abgasdruckregelventil, Motorsteuergerät','2022-05-11T11:16:19.663420Z',0),
  ('BPNL00000003COJN',0,'7cb386c9-e769-4bda-a5b9-8df030c0d491','P0476','Abgasdruckregelventil - Bereichs-/Funktionsfehler','Abgasdruckregelventil','2022-05-11T11:16:19.668633Z',0),
  ('BPNL00000003COJN',0,'a976f7ae-4802-4d08-b1c7-21f1ca4c6537','P0477','Abgasdruckregelventil - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Abgasdruckregelventil, Motorsteuergerät','2022-05-11T11:16:19.678088Z',0),
  ('BPNL00000003COJN',0,'002f2c81-7313-4723-8b11-9065ba7dee82','P0478','Abgasdruckregelventil - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Abgasdruckregelventil, Motorsteuergerät','2022-05-11T11:16:19.683007Z',0),
  ('BPNL00000003COJN',0,'d7f06612-13e9-42cd-9d64-0b0b8fbfb5ab','P0479','Abgasdruckregelventil - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Abgasdruckregelventil, Motorsteuergerät','2022-05-11T11:16:19.692417Z',0),
  ('BPNL00000003COJN',0,'1266967f-aa37-48a8-a4e0-fcb13e358abf','P047A','Abgasdrucksensor B - Stromkreis','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.697181Z',0),
  ('BPNL00000003COJN',0,'3abe9bc1-84aa-4ff9-b451-54befddfcdf0','P047B','Abgasdrucksensor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.705004Z',0),
  ('BPNL00000003COJN',0,'b8c12f50-c7eb-4c3d-acb7-003ce8cb2e2e','P047C','Abgasdrucksensor B - Signal zu niedrig','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.709860Z',0),
  ('BPNL00000003COJN',0,'fc984771-2f1d-46b2-abc4-d08d79eda2e8','P047D','Abgasdrucksensor B - Signal zu hoch','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.714557Z',0),
  ('BPNL00000003COJN',0,'08156265-c32b-4f04-98d9-f4013154bce4','P047E','Abgasdrucksensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Abgasdrucksensor, Motorsteuergerät','2022-05-11T11:16:19.719519Z',0),
  ('BPNL00000003COJN',0,'69eee2b1-87a2-4d41-8b56-3028307dd952','P047F','Abgasdruckregelventil - Ventil klemmt in geöffneter Stellung','Kabelbaum, Abgasdruckregelventil, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.724769Z',0),
  ('BPNL00000003COJN',0,'36a37c46-213c-4a2e-a035-97ec3e76c481','P0480','Kühlerlüftermotor 1 - Fehlfunktion Stromkreis','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.738240Z',0),
  ('BPNL00000003COJN',0,'ba75c9dd-d75c-473e-9f1b-95f41ce40a0a','P0481','Kühlerlüftermotor 2 - Fehlfunktion Stromkreis','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.751361Z',0),
  ('BPNL00000003COJN',0,'ad3ddac9-a9b1-42e2-a3e3-dfa5bcf6cbf2','P0482','Kühlerlüftermotor 3 - Fehlfunktion Stromkreis','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.756674Z',0),
  ('BPNL00000003COJN',0,'94096367-0ffb-412f-b7d5-5eb9b51e8aca','P0483','Kühlerlüftermotor, Plausibilitätsprüfung - Fehlfunktion','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.761842Z',0),
  ('BPNL00000003COJN',0,'a7c4354e-537a-4f61-b36b-027e2f89716e','P0484','Kühlerlüftermotor - übermäßige Stromaufnahme','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.766400Z',0),
  ('BPNL00000003COJN',0,'115c00f6-2708-470b-9131-d06687a7fb40','P0485','Kühlerlüftermotor, Versorgungsspannung/Masse - Fehlfunktion Stromkreis','Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:19.771360Z',0),
  ('BPNL00000003COJN',0,'eec9a395-862c-4993-88bf-cd2295685b25','P0486','AGR-Ventilstellungssensor B - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, AGR-Ventilstellungssensor, Motorsteuergerät','2022-05-11T11:16:19.786883Z',0),
  ('BPNL00000003COJN',0,'75bae499-a77b-4fd3-988b-f9a94fd0fb59','P0487','Abgasrückführung, Drosselklappenregelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät','2022-05-11T11:16:19.792334Z',0),
  ('BPNL00000003COJN',0,'d22eef0c-4260-4905-92f2-f9731f34397e','P0488','Abgasrückführung, Drosselklappenregelung - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät','2022-05-11T11:16:19.803070Z',0),
  ('BPNL00000003COJN',0,'8d3d0b2b-cbc5-4716-b9f3-6cd42d5d0300','P0489','Abgasrückführung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, AGR-Ventil','2022-05-11T11:16:19.824468Z',0),
  ('BPNL00000003COJN',0,'325f62af-3d38-4890-a1f2-6d9f9504c0c9','P048A','Abgasstromsteuerungsstellglied - Stellglied klemmt in geschlossener Stellung','Kabelbaum, Abgasstromsteuerungsstellglied, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:19.830295Z',0),
  ('BPNL00000003COJN',0,'78188ca0-a25c-4bb8-8f5c-2c22a87fc934','P048B','Abgasstromsteuerung-Stellgliedpositionssensor/-schalter - Fehlfunktion Stromkreis','Kabelbaum, Abgasstromsteuerung-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:19.836288Z',0),
  ('BPNL00000003COJN',0,'a8ac7b58-b4c2-4426-ac36-31f94726fbf3','P048C','Abgasstromsteuerung-Stellgliedpositionssensor/-schalter - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Abgasstromsteuerung-Stellgliedpositionssensor, Motorsteuergerät','2022-05-11T11:16:19.844019Z',0),
  ('BPNL00000003COJN',0,'a1c5d349-3d4d-4b70-9576-609a682581bf','P048D','Abgasdruckregelventil-Stellungssensor/-schalter - Signal zu niedrig','Kabelbaum, Abgasdruckregelventil-Stellungssensor/-schalter, Motorsteuergerät','2022-05-11T11:16:19.848426Z',0),
  ('BPNL00000003COJN',0,'bc474d1d-9486-44ec-9de4-49e34e2b77fc','P048E','Abgasdruckregelventil-Stellungssensor/-schalter - Signal zu hoch','Kabelbaum, Abgasdruckregelventil-Stellungssensor, Motorsteuergerät','2022-05-11T11:16:19.858961Z',0),
  ('BPNL00000003COJN',0,'4c53ba9d-4a19-4a50-94f8-0e51b1085fb3','P048F','Abgasstromsteuerung-Stellgliedpositionssensor/-schalter - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Abgasstromsteuerung-Stellgliedpositionssensor/-schalter, Motorsteuergerät','2022-05-11T11:16:19.863642Z',0),
  ('BPNL00000003COJN',0,'2c8ab3db-db9a-4367-b65e-3d2f4bb9b50e','P0490','Abgasrückführung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, AGR-Ventil','2022-05-11T11:16:19.867911Z',0),
  ('BPNL00000003COJN',0,'00a1bda0-24fe-4026-9094-ea8eab5879f1','P0491','Sekundärlufteinblasung, Zylinderreihe 1 - Fehlfunktion','Kabelbaum, Sekundärluft-Magnetventil, Schlauchanschlüsse, mechanische Fehlfunktion','2022-05-11T11:16:19.878274Z',0),
  ('BPNL00000003COJN',0,'f03338ef-d6e8-4ddf-960b-8e002287b92e','P0492','Sekundärlufteinblasung, Zylinderreihe 2 - Fehlfunktion','Kabelbaum, Sekundärluft-Magnetventil, Schlauchanschlüsse, mechanische Fehlfunktion','2022-05-11T11:16:19.882956Z',0),
  ('BPNL00000003COJN',0,'de60533c-20d8-4343-b73b-2fa82e3092c6','P0493','Überdrehzahl Kühlerlüftermotor (Kupplung blockiert)','Kühlerlüftermotor-Kupplung, mechanische Fehlfunktion','2022-05-11T11:16:19.893903Z',0),
  ('BPNL00000003COJN',0,'e23e26c6-5e21-450a-a61b-7850508613a4','P0494','Drehzahl Kühlerlüftermotor - zu niedrig','Kabelbaum, Relais, Kühlerlüftermotor, mechanische Fehlfunktion','2022-05-11T11:16:19.898530Z',0),
  ('BPNL00000003COJN',0,'08824ff9-7afd-4b7e-9932-b1e53b3874d8','P0495','Drehzahl Kühlerlüftermotor - zu hoch','Kabelbaum, Relais, Kühlerlüftermotor, mechanische Fehlfunktion','2022-05-11T11:16:19.904446Z',0),
  ('BPNL00000003COJN',0,'89d2cd77-5328-4995-86f1-c4ed202c9b96','P0496','Kraftstoffdampf-Auffangssystem - übermäßige Dampfabsaugung','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, mechanische Fehlfunktion','2022-05-11T11:16:19.926763Z',0),
  ('BPNL00000003COJN',0,'143d00b8-ff5d-431f-ad72-891d3d7f3b4b','P0497','Kraftstoffdampf-Auffangssystem - geringe Dampfabsaugung','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Schläuche verstopft, mechanische Fehlfunktion','2022-05-11T11:16:19.942994Z',0),
  ('BPNL00000003COJN',0,'ace52632-5dde-475b-9ec9-a1dc5b0b5195','P0498','Kraftstoffdampf-Auffangssystem, Belüftungsregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.948321Z',0),
  ('BPNL00000003COJN',0,'4af5dc14-4408-4922-a19a-0d1388b42f68','P0499','Kraftstoffdampf-Auffangssystem, Belüftungsregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil','2022-05-11T11:16:19.956125Z',0),
  ('BPNL00000003COJN',0,'e6b6cc42-b94f-4fc1-87d7-951db91495be','P049A','AGR-Ventilstellglied B - Fehlfunktion Flussrate','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.961387Z',0),
  ('BPNL00000003COJN',0,'bba7e0e6-2343-475f-9794-9c6b956df346','P049B','Abgasrückführung B - unzureichende Flussrate festgestellt','Kabelbaum, AGR-Ventilstellglied, auslassseitige Verstopfung, Luftmassenmesser, Saugrohrdrucksensor, Luftmengenmesser, Motorsteuergerät','2022-05-11T11:16:19.965473Z',0),
  ('BPNL00000003COJN',0,'43abfca6-92d8-4a14-9572-70c0ca2b1d0d','P049C','AGR-Ventilstellglied B - übermäßige Flussrate festgestellt','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.973584Z',0),
  ('BPNL00000003COJN',0,'eb3d3a9e-fed6-43e5-b307-5f89cac87180','P049D','AGR-Ventilstellglied A - Grenzwert der Parameteradaption überschritten','Kabelbaum, AGR-Ventilstellglied, Motorsteuergerät','2022-05-11T11:16:19.977904Z',0),
  ('BPNL00000003COJN',0,'ffebed0b-a4d7-4b71-9636-f481dd91bdd6','P049E','AGR-Ventil B - Grenzwert der Parameteradaption überschritten','Kabelbaum, AGR-Ventil, Motorsteuergerät','2022-05-11T11:16:19.982333Z',0),
  ('BPNL00000003COJN',0,'9e745fc9-7d17-4e67-98ca-f8e0d50c994e','P049F','Abgasdruckregelventil B','-','2022-05-11T11:16:19.987045Z',0),
  ('BPNL00000003COJN',0,'f1db46bc-b805-41e6-9e0e-780714fb2f12','P04A0','Abgasdruckregelventil B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:19.991662Z',0),
  ('BPNL00000003COJN',0,'7f4fd238-4b9e-4a0c-8ca0-c68da5a664bf','P04A1','Abgasdruckregelventil B - Signal zu niedrig','-','2022-05-11T11:16:19.996104Z',0),
  ('BPNL00000003COJN',0,'2fd233f1-f75f-4b00-8a6b-0414108259ee','P04A2','Abgasdruckregelventil B - Signal zu hoch','-','2022-05-11T11:16:20.000506Z',0),
  ('BPNL00000003COJN',0,'1f74e478-9407-4a0c-9716-c55b302e42c1','P04A3','Abgasdruckregelventil B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:20.005387Z',0),
  ('BPNL00000003COJN',0,'fb4d9031-633c-4695-8ec8-698ebef04bd4','P04A4','Abgasdruckregelventil B - Ventil klemmt in geöffneter Stellung','-','2022-05-11T11:16:20.009915Z',0),
  ('BPNL00000003COJN',0,'965dfc10-6768-484b-bdaf-76b99e5b9d04','P04A5','Abgasdruckregelventil B - Ventil klemmt in geschlossener Stellung','-','2022-05-11T11:16:20.014564Z',0),
  ('BPNL00000003COJN',0,'912b8b51-a8f5-4eff-a0fc-8d24be5d7245','P04A6','Abgasdruckregelventil-Stellungssensor/-schalter B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:20.025767Z',0),
  ('BPNL00000003COJN',0,'05510394-cd6c-4d6c-82a7-c44b5cec6846','P04A7','Abgasdruckregelventil-Stellungssensor/-schalter B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:20.031113Z',0),
  ('BPNL00000003COJN',0,'0c93307f-2a73-41fe-be5a-f2b1ef9d2352','P04A8','Abgasdruckregelventil-Stellungssensor/-schalter B - Signal zu niedrig','-','2022-05-11T11:16:20.035925Z',0),
  ('BPNL00000003COJN',0,'dc398d6a-d0b6-42fa-9c2f-6a636b6f5c76','P04A9','Abgasdruckregelventil-Stellungssensor/-schalter B - Signal zu hoch','-','2022-05-11T11:16:20.040633Z',0),
  ('BPNL00000003COJN',0,'d64b761a-3dcc-4e24-a43c-83b55efef5d1','P04AA','Abgasdruckregelventil-Stellungssensor/-schalter B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:20.046094Z',0),
  ('BPNL00000003COJN',0,'fa723b57-d4d1-45ad-a9af-8da8eaaf3018','P04AB','Kraftstoffdampf-Aktivkohlefilter-Magnetventil B - offener Stromkreis','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:20.050822Z',0),
  ('BPNL00000003COJN',0,'e4de2215-78e5-4f5d-848d-1278745f3c92','P04AC','Kraftstoffdampf-Aktivkohlefilter-Magnetventil B - Signal zu niedrig','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:20.056038Z',0),
  ('BPNL00000003COJN',0,'e2aae939-84e9-4d3f-9ba4-81820adf24e9','P04AD','Kraftstoffdampf-Aktivkohlefilter-Magnetventil B - Signal zu hoch','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:20.061047Z',0),
  ('BPNL00000003COJN',0,'9212cc18-f972-45b1-a469-0d46852c1b3b','P04AE','Kraftstoffdampf-Aktivkohlefilter-Magnetventil B - beeinträchtigte Funktion oder Ventil klemmt in geöffneter Stellung','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:20.065604Z',0),
  ('BPNL00000003COJN',0,'36e1dd03-607c-4242-9686-9b5b6e22f528','P04AF','Kraftstoffdampf-Aktivkohlefilter-Magnetventil B - Kraftstoffdampfauffangsystem-Magnetventil klemmt in geschlossener Stellung','Kabelbaum, Kraftstoffdampf-Aktivkohlefilter-Magnetventil, Motorsteuergerät','2022-05-11T11:16:20.070041Z',0),
  ('BPNL00000003COJN',0,'9064e165-427d-4c61-a38c-87f87d175014','P04B0','Regelventil zur Rückgewinnung der Betankungsdämpfe - offener Stromkreis','Kabelbaum, Regelventil zur Rückgewinnung der Betankungsdämpfe','2022-05-11T11:16:20.074554Z',0),
  ('BPNL00000003COJN',0,'fad221a5-5832-46d1-8fd5-d47b0920740d','P04B1','Regelventil zur Rückgewinnung der Betankungsdämpfe - Signal zu niedrig','Kabelbaum, Regelventil zur Rückgewinnung der Betankungsdämpfe','2022-05-11T11:16:20.078978Z',0),
  ('BPNL00000003COJN',0,'f74ad032-06a0-4ad9-8f9b-c36d1227c623','P04B2','Regelventil zur Rückgewinnung der Betankungsdämpfe - Signal zu hoch','Kabelbaum, Regelventil zur Rückgewinnung der Betankungsdämpfe','2022-05-11T11:16:20.083807Z',0),
  ('BPNL00000003COJN',0,'27bca94f-f151-4757-a91a-96afd0ae82d2','P04B3','Regelventil zur Rückgewinnung der Betankungsdämpfe - beeinträchtigte Funktion oder Ventil klemmt in geöffneter Stellung','Kabelbaum, Regelventil zur Rückgewinnung der Betankungsdämpfe','2022-05-11T11:16:20.089508Z',0),
  ('BPNL00000003COJN',0,'708cc39d-9d77-4910-8747-6eda419732ac','P04B4','Regelventil zur Rückgewinnung der Betankungsdämpfe - Ventil klemmt in geschlossener Stellung','Kabelbaum, Regelventil zur Rückgewinnung der Betankungsdämpfe','2022-05-11T11:16:20.094011Z',0),
  ('BPNL00000003COJN',0,'ed19da97-e248-47a9-ac2d-9f4d31e7c0fb','P04B5','Tankklappe - Tankklappe klemmt in geöffneter Stellung','-','2022-05-11T11:16:20.098683Z',0),
  ('BPNL00000003COJN',0,'389dc8a6-d705-4afc-8241-ab5537037fee','P04B6','Tankklappe - Tankklappe klemmt in geschlossener Stellung','-','2022-05-11T11:16:20.103420Z',0),
  ('BPNL00000003COJN',0,'3010d0c3-9bb8-43a8-a611-38a3cbece8b9','P04B7','Tankklappensensor/-schalter - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Tankklappensensor/-schalter','2022-05-11T11:16:20.107874Z',0),
  ('BPNL00000003COJN',0,'7a07a34f-d0d5-416a-9c83-6f848771b59a','P04B8','Tankklappensensor/-schalter - Fehlfunktion Stromkreis','Kabelbaum, Tankklappensensor/-schalter','2022-05-11T11:16:20.112529Z',0),
  ('BPNL00000003COJN',0,'4a446b3d-128a-4797-9c17-cd3305265367','P04B9','Tankklappensensor/-schalter - Signal zu niedrig','Kabelbaum, Tankklappensensor/-schalter','2022-05-11T11:16:20.117121Z',0),
  ('BPNL00000003COJN',0,'8dc2615e-08c6-4170-a44c-903b710fa1c5','P04BB','Tankklappenverriegelungssteuerung - offener Stromkreis','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.127075Z',0),
  ('BPNL00000003COJN',0,'300a1704-be52-41cc-8027-667d5837bf73','P04BC','Tankklappenverriegelungssteuerung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.131666Z',0),
  ('BPNL00000003COJN',0,'1345d085-1699-4938-8500-250f451fc48f','P04BD','Tankklappenverriegelungssteuerung - Signal zu niedrig','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.136904Z',0),
  ('BPNL00000003COJN',0,'67850de4-15f2-403e-a703-ecef424583a4','P04BE','Tankklappenverriegelungssteuerung - Signal zu hoch','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.141695Z',0),
  ('BPNL00000003COJN',0,'ec1e46bc-d1ee-4fd0-8824-2911dfe26d4f','P04BF','Tankklappenentriegelungssteuerung - offener Stromkreis','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.146584Z',0),
  ('BPNL00000003COJN',0,'d4639a56-6af7-4f4f-bf46-018193204e33','P04C0','Tankklappenentriegelungssteuerung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.151148Z',0),
  ('BPNL00000003COJN',0,'f14f76c8-7c32-4236-b49e-15a1c6446765','P04C1','Tankklappenentriegelungssteuerung - Signal zu niedrig','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.155532Z',0),
  ('BPNL00000003COJN',0,'d2255eeb-a45c-4c7a-a643-f91b8bd94a99','P04C2','Tankklappenentriegelungssteuerung - Signal zu hoch','Kabelbaum, Tankklappen-Stellglied','2022-05-11T11:16:20.161455Z',0),
  ('BPNL00000003COJN',0,'f101f7bc-51b1-4f54-b5eb-356baeae9218','P04C3','Tankklappenverriegelungsstellungssensor/-schalter - Fehlfunktion Stromkreis','Kabelbaum, Tankklappenverriegelungsstellungssensor/-schalter','2022-05-11T11:16:20.165868Z',0),
  ('BPNL00000003COJN',0,'38583508-8194-453e-a747-7802c432d7d8','P04C4','Tankklappenverriegelungsstellungssensor/-schalter - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Tankklappenverriegelungsstellungssensor/-schalter','2022-05-11T11:16:20.170392Z',0),
  ('BPNL00000003COJN',0,'f90c3b6c-e030-4f5e-b470-9e001c65bdcc','P04C5','Tankklappenverriegelungsstellungssensor/-schalter - Signal zu niedrig','Kabelbaum, Tankklappenverriegelungsstellungssensor/-schalter','2022-05-11T11:16:20.176461Z',0),
  ('BPNL00000003COJN',0,'d0e4e122-b7bd-4766-ae51-bafb022608e8','P04C6','Tankklappenverriegelungsstellungssensor/-schalter - Signal zu hoch','Kabelbaum, Tankklappenverriegelungsstellungssensor/-schalter','2022-05-11T11:16:20.181675Z',0),
  ('BPNL00000003COJN',0,'843ea8f8-98c8-48d5-8890-004b24b3d9e2','P04C7','Tankklappenverriegelungsstellungssensor/-schalter - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Tankklappenverriegelungsstellungssensor/-schalter','2022-05-11T11:16:20.186480Z',0),
  ('BPNL00000003COJN',0,'b6f07dc9-4f14-465c-9445-e8919ac710fd','P04C8','Tankklappensensor/-schalter für Öffnungsanforderung - Fehlfunktion Stromkreis','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.191658Z',0),
  ('BPNL00000003COJN',0,'7e3f80b4-2e95-4bb1-b1dc-e6400e4b5434','P04C9','Tankklappensensor/-schalter für Öffnungsanforderung - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.197740Z',0),
  ('BPNL00000003COJN',0,'4c417198-671a-4a50-8994-beb7886f1b9c','P04CA','Tankklappensensor/-schalter für Öffnungsanforderung - Signal wechselt nicht aus Pegelzustand "Low"','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.203334Z',0),
  ('BPNL00000003COJN',0,'37432d4b-ac7e-4da6-b443-1dc4b41f21a6','P04CB','Tankklappensensor/-schalter für Öffnungsanforderung - Signal wechselt nicht aus Pegelzustand "High"','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.214829Z',0),
  ('BPNL00000003COJN',0,'b40ebb2c-1bae-4d4e-a35d-fd0afa935d11','P04CC','Tankklappensensor/-schalter für Öffnungsanforderung - intermittierendes/sporadisches Signal','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.220493Z',0),
  ('BPNL00000003COJN',0,'778a6b00-05f3-40f7-a78f-9f7c0a866d7e','P04CD','Tankklappensensor/-schalter für Öffnungsanforderung - ständig aktiviert','Kabelbaum, Tankklappensensor/-schalter für Öffnungsanforderung','2022-05-11T11:16:20.225445Z',0),
  ('BPNL00000003COJN',0,'1c124c17-557d-4929-a52b-985d242b595e','P04CE','AGR-Temperatursensor C - Fehlfunktion Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.230629Z',0),
  ('BPNL00000003COJN',0,'801517a7-2988-451c-8f81-4dfa104489c4','P04CF','AGR-Temperatursensor C - Fehlfunktion Stromkreis','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.235275Z',0),
  ('BPNL00000003COJN',0,'7349cbb8-d403-46f6-aad0-9909405b5555','P04D0','AGR-Temperatursensor C - Signal zu niedrig','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.240124Z',0),
  ('BPNL00000003COJN',0,'2d93e4fb-4cdf-42c6-a232-54b503c42cbe','P04D1','AGR-Temperatursensor C - Signal zu hoch','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.244865Z',0),
  ('BPNL00000003COJN',0,'2544fbca-25ca-47cc-921a-eecf5a208e0a','P04D2','AGR-Temperatursensor C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, AGR-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.249616Z',0),
  ('BPNL00000003COJN',0,'57dc9bbe-0272-4d56-b889-68450547d663','P04D3','Abgasbremse - Fehlfunktion Eingangsstromkreis','Kabelbaum','2022-05-11T11:16:20.254351Z',0),
  ('BPNL00000003COJN',0,'0956402e-1557-4b1f-b39a-b965a3d14d3b','P04D4','Abgasbremse - Bereichs-/Funktionsfehler Eingangsstromkreis','Kabelbaum','2022-05-11T11:16:20.259459Z',0),
  ('BPNL00000003COJN',0,'2d7f61c0-8c26-4d10-b009-81607add484d','P04D5','Abgasbremse - Eingangssignal zu niedrig','Kabelbaum','2022-05-11T11:16:20.264100Z',0),
  ('BPNL00000003COJN',0,'8ea770db-3601-49b7-a40a-f12fe3c66845','P04D6','Abgasbremse - Eingangssignal zu hoch','Kabelbaum','2022-05-11T11:16:20.269214Z',0),
  ('BPNL00000003COJN',0,'3037fcd0-3861-41a9-8bab-f0fdd7cca9bd','P04D7','Abgasbremse - zeitweilige Stromkreisunterbrechungen','Kabelbaum','2022-05-11T11:16:20.273989Z',0),
  ('BPNL00000003COJN',0,'ee9bd5c9-6184-4a8d-9e3f-72092efdfef0','P04D8','Übermäßige Vorlaufphase bis zum Erreichen eines geschlossenen Wirkungsablaufs im AGR-Regelkreis','-','2022-05-11T11:16:20.279642Z',0),
  ('BPNL00000003COJN',0,'eb8feadd-85a3-4bc1-ab33-32b5b25e63c0','P04D9','Geschlossener AGR-Regelkreis, Grenzwert erreicht - geringe Flussrate festgestellt','-','2022-05-11T11:16:20.284208Z',0),
  ('BPNL00000003COJN',0,'e047d457-8a47-482b-b6a8-d6f52c17d884','P04DA','Geschlossener AGR-Regelkreis, Grenzwert erreicht - übermäßige Flussrate festgestellt','-','2022-05-11T11:16:20.291370Z',0),
  ('BPNL00000003COJN',0,'f6ff6ffd-2e23-40db-9ee5-eb3925fcbaf1','P04DB','Kurbelgehäuseentlüftung abgetrennt','-','2022-05-11T11:16:20.298187Z',0),
  ('BPNL00000003COJN',0,'85d73458-d9de-49e8-8fe5-e280b783d047','P0500','Fahrgeschwindigkeitssensor - Fehlfunktion Stromkreis','Kabelbaum, Fahrgeschwindigkeitssensor, Motorsteuergerät','2022-05-11T11:16:20.303273Z',0),
  ('BPNL00000003COJN',0,'42688bb1-49ee-4985-a831-6d8459b58f5c','P0501','Fahrgeschwindigkeitssensor - Bereichs-/Funktionsfehler','Kabelbaum, Tachometer, Fahrgeschwindigkeitssensor, CAN-Datenbus','2022-05-11T11:16:20.308749Z',0),
  ('BPNL00000003COJN',0,'3b1691e5-7853-43c2-80dc-550c43fa721b','P0502','Fahrgeschwindigkeitssensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Fahrgeschwindigkeitssensor, Motorsteuergerät','2022-05-11T11:16:20.315280Z',0),
  ('BPNL00000003COJN',0,'a7650640-7c83-441e-b92d-e3146b660923','P0503','Fahrgeschwindigkeitssensor - Eingangssignal zeitweilig unterbrochen/zu hoch','Kabelbaum, schlechte Kontaktierung, angeschlossene Systeme, Instrumententafel, Fahrgeschwindigkeitssensor','2022-05-11T11:16:20.320102Z',0),
  ('BPNL00000003COJN',0,'afee8a16-b3e7-4ebb-84b1-0d2d1414feaf','P0504','Bremspedalschalter A/B - Bezugsfehler','Kabelbaum, mechanische Fehlfunktion','2022-05-11T11:16:20.324613Z',0),
  ('BPNL00000003COJN',0,'1c5e1b84-0491-4f42-935e-1053a44c2229','P0505','Leerlaufregelung - Fehlfunktion','Kabelbaum, Leerlaufsteller/Leerlaufregelventil, Drosselklappenmotor, Drosselklappe schwergängig/klemmt, Motorsteuergerät','2022-05-11T11:16:20.329709Z',0),
  ('BPNL00000003COJN',0,'60304b5a-b514-4fe7-8fb2-ce4cc5c7a3b7','P0506','Leerlaufregelung - Drehzahl unter Sollwert','Kabelbaum, Leerlaufsteller/Leerlaufregelventil, Drosselklappenmotor, Drosselklappe schwergängig/klemmt, Motorsteuergerät','2022-05-11T11:16:20.335257Z',0),
  ('BPNL00000003COJN',0,'3fc027d5-9e79-4020-a6b2-f5c8ac4de999','P0507','Leerlaufregelung - Drehzahl über Sollwert','Kabelbaum, Leerlaufsteller/Leerlaufregelventil, Drosselklappenmotor, Drosselklappe schwergängig/klemmt, Motorsteuergerät','2022-05-11T11:16:20.343892Z',0),
  ('BPNL00000003COJN',0,'a27e7902-441b-45c1-8c3c-b717f30b4df1','P0508','Leerlaufluftregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.348638Z',0),
  ('BPNL00000003COJN',0,'048df4b6-7acd-4186-83cd-a7cbada9a07b','P0509','Leerlaufluftregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.353407Z',0),
  ('BPNL00000003COJN',0,'d17b87ee-cea9-4fd8-a984-243fbb4dcdb5','P050A','Leerlaufregelventil, Kaltstart - beeinträchtigte Funktion','Kabelbaum, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.359192Z',0),
  ('BPNL00000003COJN',0,'3ff6deb3-acd7-48ac-a891-7f792cbc9cdf','P0561','Systemspannung - nicht konstant','Kabelbaum, schlechte Kontaktierung, Batterie, Generator','2022-05-11T11:16:20.930028Z',0),
  ('BPNL00000003COJN',0,'047def8d-968e-4fbe-b1e9-078d877aeaee','P050B','Zündzeitpunkt, Kaltstart - beeinträchtigte Funktion','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:20.364836Z',0),
  ('BPNL00000003COJN',0,'4d32c06d-b4ed-4719-b682-52ca77bb53ac','P050C','Kühlmitteltemperatursensor, Kaltstart - beeinträchtigte Funktion','Kabelbaum, Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.369679Z',0),
  ('BPNL00000003COJN',0,'75bbbb5d-0f43-48b9-b9f2-7f305522d3bf','P050D','Unrunder Leerlauf nach Kaltstart','Kabelbaum, Leerlaufregelventil, Falschluft im Saugrohr, Motorsteuergerät','2022-05-11T11:16:20.374213Z',0),
  ('BPNL00000003COJN',0,'8ace6d01-2168-46f1-a47f-df66b52843d9','P050E','Abgastemperatur, Kaltstart - Signal außerhalb Bereich','Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.378711Z',0),
  ('BPNL00000003COJN',0,'672c3e8f-852b-42af-bd52-fade06f61c56','P050F','Bremskraftverstärker-Drucksensor - Signal zu niedrig','Kabelbaum, Bremskraftverstärker-Drucksensor','2022-05-11T11:16:20.384243Z',0),
  ('BPNL00000003COJN',0,'602b07ad-e5e1-4b49-9cb4-6ed5d2d0d91b','P0510','Leerlaufschalter - Fehlfunktion Stromkreis','Kabelbaum, Leerlaufschalter, Motorsteuergerät','2022-05-11T11:16:20.392006Z',0),
  ('BPNL00000003COJN',0,'bff267e7-b925-4903-bd1a-a63b45f0cece','P0511','Leerlaufluftregelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.400604Z',0),
  ('BPNL00000003COJN',0,'9613de38-bdf5-49d5-adc7-c6282f911b55','P0512','Stromkreis Anforderungssignal "Anlasser" - Fehlfunktion','Kabelbaum, Wegfahrsperre, Relais','2022-05-11T11:16:20.409721Z',0),
  ('BPNL00000003COJN',0,'be2c92f0-be3f-4870-8752-f726d8536dd8','P0513','Falscher Wegfahrsperren-Schlüssel','Wegfahrsperre','2022-05-11T11:16:20.421738Z',0),
  ('BPNL00000003COJN',0,'2be308b2-0265-413d-b6c0-92d8b305b4ec','P0514','Batterie-Temperatursensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Batterie-Temperatursensor','2022-05-11T11:16:20.429706Z',0),
  ('BPNL00000003COJN',0,'587c0dd3-2a36-4203-930b-6683e82c5106','P0515','Batterie-Temperatursensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Batterie-Temperatursensor','2022-05-11T11:16:20.434799Z',0),
  ('BPNL00000003COJN',0,'d740fb8d-1741-4a86-8999-6a55e97a7765','P0516','Batterie-Temperatursensor - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Batterie-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.439443Z',0),
  ('BPNL00000003COJN',0,'1ff3956f-1b17-43b2-a084-858ec3486327','P0517','Batterie-Temperatursensor - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Batterie-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.444039Z',0),
  ('BPNL00000003COJN',0,'acb79181-ed60-47d4-a592-75f1e38324c7','P0518','Leerlaufluftregelung - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.455783Z',0),
  ('BPNL00000003COJN',0,'332bee05-01b4-47ec-916b-ab9f798085c5','P0519','Leerlaufluftregelung - Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Leerlaufregelventil, Motorsteuergerät','2022-05-11T11:16:20.461060Z',0),
  ('BPNL00000003COJN',0,'5db903d5-347c-41f4-8449-97cf8587bde1','P051A','Kurbelgehäuse-Drucksensor - Fehlfunktion Stromkreis','Kabelbaum, Kurbelgehäuse-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.465624Z',0),
  ('BPNL00000003COJN',0,'ab755d9f-ba91-4466-a709-ceef9014fc70','P051B','Kurbelgehäuse-Drucksensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kurbelgehäuse-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.482927Z',0),
  ('BPNL00000003COJN',0,'46608bce-ac13-4578-9a30-68a53e16886a','P051C','Kurbelgehäuse-Drucksensor - Signal zu niedrig','Kabelbaum, Kurbelgehäuse-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.488305Z',0),
  ('BPNL00000003COJN',0,'ac102946-485a-4835-bc58-9690bcc775ff','P051D','Kurbelgehäuse-Drucksensor - Signal zu hoch','Kabelbaum, Kurbelgehäuse-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.492965Z',0),
  ('BPNL00000003COJN',0,'f00a7ca2-a577-46c7-93dd-df554e2edab5','P051E','Kurbelgehäuse-Drucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Kurbelgehäuse-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.499248Z',0),
  ('BPNL00000003COJN',0,'288f00a1-b39a-4161-ba6d-d54e876cc42e','P051F','Kurbelgehäuseentlüftungsfilter - Kurbelgehäuseentlüftungsfilter teilweise verstopft','-','2022-05-11T11:16:20.506212Z',0),
  ('BPNL00000003COJN',0,'2ef04cda-006d-43b9-a3f2-9224038ff8f5','P0520','Motoröldrucksensor/-schalter - Fehlfunktion Stromkreis','Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.512002Z',0),
  ('BPNL00000003COJN',0,'f696678b-a9c7-456d-878c-5a2c52dffa0c','P0521','Motoröldrucksensor/-schalter - Bereichs-/Funktionsfehler','Motoröldrucksensor/-schalter','2022-05-11T11:16:20.517532Z',0),
  ('BPNL00000003COJN',0,'0a9598cc-3f03-4bb5-b1a7-0e13d3573ca8','P0522','Motoröldrucksensor/-schalter - Spannung zu niedrig','Kurzschluss an Masse im Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.522412Z',0),
  ('BPNL00000003COJN',0,'1aac6150-9d4e-44bc-b01f-63cbc1132f39','P0523','Motoröldrucksensor/-schalter - Spannung zu hoch','Kurzschluss an Plus im Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.526792Z',0),
  ('BPNL00000003COJN',0,'519b6e05-00de-46f0-9521-844de0123f9d','P0524','Motoröldruck zu niedrig','Mechanische Fehlfunktion','2022-05-11T11:16:20.531745Z',0),
  ('BPNL00000003COJN',0,'5024db42-bd20-4c1a-b461-6327c2c8a74a','P0525','Geschwindigkeitsregelsystem, Stellgliedsteuerung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Geschwindigkeitsregelungsstellglied','2022-05-11T11:16:20.536295Z',0),
  ('BPNL00000003COJN',0,'2122f45a-9005-40d8-b57a-f6f7894cf32c','P0526','Kühlerlüftermotor-Drehzahlsensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Kühlerlüftermotor-Drehzahlsensor, Motorsteuergerät','2022-05-11T11:16:20.541256Z',0),
  ('BPNL00000003COJN',0,'847c08b9-328c-4003-a14f-1ff6ce66876a','P0527','Kühlerlüftermotor-Drehzahlsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Kühlerlüftermotor-Drehzahlsensor','2022-05-11T11:16:20.545813Z',0),
  ('BPNL00000003COJN',0,'140bf3eb-79c7-4c92-bb71-f3f64e82d23f','P0528','Kühlerlüftermotor-Drehzahlsensor - kein Signal','Kabelbaum, schlechte Kontaktierung, Kühlerlüftermotor-Drehzahlsensor, Motorsteuergerät','2022-05-11T11:16:20.550356Z',0),
  ('BPNL00000003COJN',0,'32749498-a84f-4330-8bbc-6a28d52d57e5','P0529','Kühlerlüftermotor-Drehzahlsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät','2022-05-11T11:16:20.554772Z',0),
  ('BPNL00000003COJN',0,'9cca22b1-a343-4ae7-98ac-d0cc2d7d1b33','P052A','Nockenwellenverstellung - Kaltstart, Zylinderreihe 1 - übermäßige Frühverstellung','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, Nockenwellensteller, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:20.559664Z',0),
  ('BPNL00000003COJN',0,'d60c8985-9ced-447f-87c0-de3f2a2b1629','P052B','Nockenwellenverstellung - Kaltstart, Zylinderreihe 1 - übermäßige Spätverstellung','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, Nockenwellensteller, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:20.564161Z',0),
  ('BPNL00000003COJN',0,'0ad9e953-27a1-4c58-9043-b663cce480dc','P052C','Nockenwellenverstellung - Kaltstart, Zylinderreihe 2 - übermäßige Frühverstellung','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, Nockenwellensteller, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:20.568761Z',0),
  ('BPNL00000003COJN',0,'ff9aa764-394f-4eb9-9b86-85336613cedf','P052D','Nockenwellenverstellung - Kaltstart, Zylinderreihe 2 - übermäßige Spätverstellung','Kabelbaum, Kurbelwinkelsensor, Nockenwellenpositionssensor, Nockenwellensteller, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:20.578687Z',0),
  ('BPNL00000003COJN',0,'efc8bdf4-034b-43fb-a818-f271fc2bedf8','P052E','Kurbelgehäuseentlüftung-Regelventil - beeinträchtigte Funktion','-','2022-05-11T11:16:20.584470Z',0),
  ('BPNL00000003COJN',0,'fef54cfe-f727-4802-b212-0d902363d8b8','P052F','Glühkerzen-Steuergerät - Fehlfunktion Systemspannung','Kabelbaum, Glühkerzen-Steuergerät','2022-05-11T11:16:20.593123Z',0),
  ('BPNL00000003COJN',0,'780a3157-1335-453e-bb2a-7348e2455578','P0530','Klimaanlagen-Kältemitteldrucksensor - Fehlfunktion Stromkreis','Kabelbaum, Klimaanlagen-Kältemitteldrucksensor, Motorsteuergerät','2022-05-11T11:16:20.601522Z',0),
  ('BPNL00000003COJN',0,'65e5fd6f-d4e4-44a1-a252-3a46288bebed','P0531','Klimaanlagen-Kältemitteldrucksensor - Bereichs-/Funktionsfehler','Klimaanlagen-Kältemitteldrucksensor','2022-05-11T11:16:20.608195Z',0),
  ('BPNL00000003COJN',0,'f5b3f22e-5b73-4d26-8479-a1e4120da830','P0532','Klimaanlagen-Kältemitteldrucksensor - Eingangssignal zu niedrig','Kältemitteldruck zu niedrig (falsche Kältemittelmenge), Kabelbaum, Klimaanlagen-Kältemitteldrucksensor, Motorsteuergerät','2022-05-11T11:16:20.616849Z',0),
  ('BPNL00000003COJN',0,'7979c159-3ded-4c52-9fc7-a54f8682e1b9','P0533','Klimaanlagen-Kältemitteldrucksensor - Eingangssignal zu hoch','Kältemitteldruck zu hoch (fehlerhafte Kühlung/falsche Kältemittelmenge), Kabelbaum, Klimaanlagen-Kältemitteldrucksensor, Motorsteuergerät','2022-05-11T11:16:20.623466Z',0),
  ('BPNL00000003COJN',0,'f6ec1011-0508-4592-974d-6948e9252438','P0534','Kältemittelverlust','Kältemittelkreislauf undicht, Kabelbaum, Klimaanlagen-Kältemitteldrucksensor','2022-05-11T11:16:20.628794Z',0),
  ('BPNL00000003COJN',0,'a4690cf5-e3e8-4d7b-9205-1d0e5ee9b7bb','P0535','Klimaverdampfer-Temperatursensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Klimaverdampfer-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.633777Z',0),
  ('BPNL00000003COJN',0,'0ea41166-4fcd-4a3a-9f8f-46c28dddf11a','P0536','Klimaverdampfer-Temperatursensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Klimaverdampfer-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.638794Z',0),
  ('BPNL00000003COJN',0,'fd9ca397-53d3-4be7-a30c-b1454c82eb60','P0537','Klimaverdampfer-Temperatursensor - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Klimaverdampfer-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.650662Z',0),
  ('BPNL00000003COJN',0,'15d4bec6-2d0e-4fed-850f-af290617960f','P0538','Klimaverdampfer-Temperatursensor - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Klimaverdampfer-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.664226Z',0),
  ('BPNL00000003COJN',0,'56c2618d-7f56-42d7-b502-f3a098c42cda','P0539','Klimaverdampfer-Temperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Klimaverdampfer-Temperatursensor, Motorsteuergerät','2022-05-11T11:16:20.668794Z',0),
  ('BPNL00000003COJN',0,'18591071-e664-4f68-8e87-c3c3d5169fc3','P053A','Kurbelgehäuseentlüftungsheizer - offener Stromkreis','Kabelbaum, Kurbelgehäuseentlüftungsheizer, Motorsteuergerät','2022-05-11T11:16:20.673071Z',0),
  ('BPNL00000003COJN',0,'72639ece-46b5-4cd2-b3ec-4d5ec63fc943','P053B','Kurbelgehäuseentlüftungsheizer - Signal zu niedrig','Kabelbaum, Kurbelgehäuseentlüftungsheizer, Motorsteuergerät','2022-05-11T11:16:20.678614Z',0),
  ('BPNL00000003COJN',0,'f8932e87-18d1-4a93-8bd9-d593ac63bd68','P053C','Kurbelgehäuseentlüftungsheizer - Signal zu hoch','Kabelbaum, Kurbelgehäuseentlüftungsheizer, Motorsteuergerät','2022-05-11T11:16:20.682973Z',0),
  ('BPNL00000003COJN',0,'03f59c9e-c74c-4336-917f-df39174715b7','P053D','Kurbelgehäuseentlüftungsheizer - beeinträchtigte Funktion','Kabelbaum, Kurbelgehäuseentlüftungsheizer, Motorsteuergerät','2022-05-11T11:16:20.687442Z',0),
  ('BPNL00000003COJN',0,'d833540e-8807-4446-92c9-61b7350af0f3','P053F','Kaltstart-Kraftstoffdruck - beeinträchtigte Funktion','-','2022-05-11T11:16:20.691822Z',0),
  ('BPNL00000003COJN',0,'d6b8a2f4-d0fe-41c0-b224-3d38d29f8117','P0540','Ansaugluftheizer A - Fehlfunktion Stromkreis','Kabelbaum, Relais, Ansaugluftheizer','2022-05-11T11:16:20.701446Z',0),
  ('BPNL00000003COJN',0,'a795e1e2-5f6a-4443-af79-06ca67a95d54','P0541','Ansaugluftheizer A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Ansaugluftheizer','2022-05-11T11:16:20.705879Z',0),
  ('BPNL00000003COJN',0,'dd2dea2e-2d51-4cd8-88cd-eaea98b611bc','P0542','Ansaugluftheizer A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Ansaugluftheizer','2022-05-11T11:16:20.710543Z',0),
  ('BPNL00000003COJN',0,'1db047dc-84bf-47c8-bdb7-5b2b8757fd30','P0543','Ansaugluftheizer A - offener Stromkreis','Kabelbaum, Ansaugluftheizer','2022-05-11T11:16:20.714870Z',0),
  ('BPNL00000003COJN',0,'5f73572a-3e49-4255-85df-13db1f3f02d2','P0544','Abgastemperatursensor 1, Zylinderreihe 1 - Fehlfunktion Stromkreis','Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.729369Z',0),
  ('BPNL00000003COJN',0,'576ffd09-64f5-4742-a197-8c0f47ce1d2b','P0545','Abgastemperatursensor 1, Zylinderreihe 1 - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.734218Z',0),
  ('BPNL00000003COJN',0,'6b5fb874-8dd9-4a68-8499-5d47a2a4999e','P0546','Abgastemperatursensor 1, Zylinderreihe 1 - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.739299Z',0),
  ('BPNL00000003COJN',0,'a7cb1de7-70b9-4f8e-8e41-97b67e139c87','P0547','Abgastemperatursensor 1, Zylinderreihe 2 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.744252Z',0),
  ('BPNL00000003COJN',0,'b5aa8666-80bb-4256-83a6-3c6539ccc2c2','P0548','Abgastemperatursensor 1, Zylinderreihe 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.748677Z',0),
  ('BPNL00000003COJN',0,'65435a1d-268a-4b69-aecd-39ff831d8f47','P0549','Abgastemperatursensor 1, Zylinderreihe 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Abgastemperatursensor, Motorsteuergerät','2022-05-11T11:16:20.753040Z',0),
  ('BPNL00000003COJN',0,'3931112e-e504-4c35-bc6b-b96e1d73af16','P054A','Nockenwellenpositionssensor B, Kaltstart - übermäßige Frühverstellung','Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:20.757327Z',0),
  ('BPNL00000003COJN',0,'cf764d7a-520a-4718-8dc7-37b9d0ae7e61','P054B','Nockenwellenpositionssensor B, Kaltstart - übermäßige Spätverstellung','Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:20.779389Z',0),
  ('BPNL00000003COJN',0,'e0e46317-a061-4227-9982-df4456e7958c','P054C','Nockenwellenpositionssensor B, Kaltstart - übermäßige Frühverstellung','Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:20.785186Z',0),
  ('BPNL00000003COJN',0,'8b41bedf-677e-49f4-9b63-8003120f9298','P054D','Nockenwellenpositionssensor B, Kaltstart - übermäßige Spätverstellung','Kabelbaum, Nockenwellenpositionssensor','2022-05-11T11:16:20.790001Z',0),
  ('BPNL00000003COJN',0,'96c3b071-78a1-4fdb-959d-b91ea54eefc4','P054E','Leerlaufregelung - Kraftstoffmenge unter Sollwert','-','2022-05-11T11:16:20.794928Z',0),
  ('BPNL00000003COJN',0,'8597f0f7-9356-4db7-b0ec-a618fbf36bc2','P054F','Leerlaufregelung - Kraftstoffmenge über Sollwert','-','2022-05-11T11:16:20.802293Z',0),
  ('BPNL00000003COJN',0,'94083df0-10a9-4ea2-9965-400b53e70502','P0550','Servolenkungsdrucksensor/-schalter - Fehlfunktion Stromkreis','Kabelbaum, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.814139Z',0),
  ('BPNL00000003COJN',0,'27924fd7-3fa4-4526-bc3e-ccd627fb8eec','P0551','Servolenkungsdrucksensor/-schalter - Bereichs-/Funktionsfehler','Servolenkung, Servolenkungsdrucksensor/-schalter','2022-05-11T11:16:20.818742Z',0),
  ('BPNL00000003COJN',0,'a5e7c21b-dbc0-4084-9ff2-3ed205fcfb93','P0552','Servolenkungsdrucksensor/-schalter - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.823089Z',0),
  ('BPNL00000003COJN',0,'1a473dee-cef0-47a8-ba81-4b61aa31b219','P0553','Servolenkungsdrucksensor/-schalter - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.827462Z',0),
  ('BPNL00000003COJN',0,'6712cb02-0311-478e-b30b-b47c24d30462','P0554','Servolenkungsdrucksensor/-schalter - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.831695Z',0),
  ('BPNL00000003COJN',0,'7ab3df4c-b8d0-44a9-b37b-e6f3df450b08','P0555','Bremskraftverstärker-Drucksensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Bremskraftverstärker-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.853939Z',0),
  ('BPNL00000003COJN',0,'cab38c5a-b643-46ae-a1aa-0296d422c96c','P0556','Bremskraftverstärker-Drucksensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Bremskraftverstärker-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.859216Z',0),
  ('BPNL00000003COJN',0,'3dc4a434-8427-4825-97b5-10ea6c8357d8','P0557','Bremskraftverstärker-Drucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Bremskraftverstärker-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.863608Z',0),
  ('BPNL00000003COJN',0,'b9c260b8-568a-4d04-887a-00b6d283d695','P0558','Bremskraftverstärker-Drucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Bremskraftverstärker-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.880462Z',0),
  ('BPNL00000003COJN',0,'92ccf408-83c6-4e20-8f20-94a61869f378','P0559','Bremskraftverstärker-Drucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Bremskraftverstärker-Drucksensor, Motorsteuergerät','2022-05-11T11:16:20.895117Z',0),
  ('BPNL00000003COJN',0,'0a1735f2-250a-4eb9-b3c9-566f25443a57','P055A','Motoröldrucksensor/-schalter B - Fehlfunktion Stromkreis','Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.899736Z',0),
  ('BPNL00000003COJN',0,'175482d2-7175-4dcf-ba02-b07725d82d75','P055B','Motoröldrucksensor/-schalter B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.911026Z',0),
  ('BPNL00000003COJN',0,'26f67110-abe9-423a-8812-989242d043e5','P055C','Motoröldrucksensor/-schalter B - Signal zu niedrig','Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.915916Z',0),
  ('BPNL00000003COJN',0,'f4827d8d-fa99-48ff-bc20-b912e8381a9e','P055D','Motoröldrucksensor/-schalter B - Signal zu hoch','Kabelbaum, Motoröldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:20.920188Z',0),
  ('BPNL00000003COJN',0,'a764b439-8c2c-4a9a-b8dc-e829190e6f9a','P0560','Systemspannung - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Batterie, Generator','2022-05-11T11:16:20.925148Z',0),
  ('BPNL00000003COJN',0,'448f40df-3917-4120-a703-64f75d841c7f','P06E4','Steuergerät-Wecksignal (Wake-Up-Befehl) - Signalfehler','-','2022-05-11T11:16:22.470143Z',0),
  ('BPNL00000003COJN',0,'5c76d73c-4360-4b7f-919e-a56129d87af4','P0562','Systemspannung - zu niedrig','Kabelbaum, schlechte Kontaktierung, Batterie, Generator','2022-05-11T11:16:20.934396Z',0),
  ('BPNL00000003COJN',0,'1d491818-aea0-4549-ad98-34272cb97edc','P0563','Systemspannung - zu hoch','Generator','2022-05-11T11:16:20.939215Z',0),
  ('BPNL00000003COJN',0,'082d1435-63d6-43eb-84a1-8daa5de9bdb1','P0564','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal A - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:20.943818Z',0),
  ('BPNL00000003COJN',0,'9660fd65-d071-492b-b3a1-d0ab5a9f9568','P0565','Geschwindigkeitsregelung-Hauptschalter, Signal "EIN" - Fehlfunktion','Kabelbaum, Geschwindigkeitsregelung-Hauptschalter, Motorsteuergerät','2022-05-11T11:16:20.952285Z',0),
  ('BPNL00000003COJN',0,'e1d86478-c0a7-4797-b636-7a0560c6770d','P0566','Geschwindigkeitsregelung-Hauptschalter, Signal "AUS" - Fehlfunktion','Kabelbaum, Geschwindigkeitsregelung-Hauptschalter, Motorsteuergerät','2022-05-11T11:16:20.956906Z',0),
  ('BPNL00000003COJN',0,'213962f1-e879-4c61-a487-bd1102ca5072','P0567','Geschwindigkeitsregelung-Wählschalter, Signal "WIEDEREINREGELN" (RESUME) - Fehlfunktion','Kabelbaum, Geschwindigkeitsregelung-Wählschalter, Motorsteuergerät','2022-05-11T11:16:20.961736Z',0),
  ('BPNL00000003COJN',0,'4604e06e-6e4e-4594-821f-06f8d2bc6a67','P0568','Geschwindigkeitsregelung-Hauptschalter, Signal "SPEICHERN" (SET) - Fehlfunktion','Kabelbaum, Geschwindigkeitsregelung-Hauptschalter, Motorsteuergerät','2022-05-11T11:16:20.966474Z',0),
  ('BPNL00000003COJN',0,'ffc9b543-c4e7-4835-a60a-7d21340b3ec1','P0569','Geschwindigkeitsregelung-Wählschalter, Signal "VERZÖGERN" (COAST) - Fehlfunktion','Kabelbaum, Geschwindigkeitsregelung-Wählschalter, Motorsteuergerät','2022-05-11T11:16:20.972794Z',0),
  ('BPNL00000003COJN',0,'9f56be3d-30dc-4895-bb02-bebdc38c1aaf','P056A','Fehlerhaftes Geschwindigkeitsregelungssignal "Abstandsvergrößerung"','Kabelbaum, Abstandsregler-Steuergerät für Geschwindigkeitsregelung, Motorsteuergerät','2022-05-11T11:16:20.990621Z',0),
  ('BPNL00000003COJN',0,'004300ad-dfff-4c96-ac15-77d38f04c2dd','P056B','Fehlerhaftes Geschwindigkeitsregelungssignal "Abstandsverringerung"','Kabelbaum, Abstandsregler-Steuergerät für Geschwindigkeitsregelung, Motorsteuergerät','2022-05-11T11:16:20.995898Z',0),
  ('BPNL00000003COJN',0,'2ab7a033-07e4-479b-bbf7-82be71f5d538','P056C','Geschwindigkeitsregelung, Abschaltsignal (Cancel)','-','2022-05-11T11:16:21.001300Z',0),
  ('BPNL00000003COJN',0,'77c7bd31-1411-4eb0-97b2-db9c7d614ff3','P0570','Geschwindigkeitsregelsystem, Signal Fahrpedalsensor - Fehlfunktion','Kabelbaum, Fahrpedalsensor, Motorsteuergerät','2022-05-11T11:16:21.021566Z',0),
  ('BPNL00000003COJN',0,'8688eb25-0f5f-48c5-af83-83407aca9658','P0571','Geschwindigkeitsregelungs-/Bremspedalschalter A - Fehlfunktion Stromkreis','Kabelbaum, Geschwindigkeitsregelungs-/Bremspedalschalter, Motorsteuergerät','2022-05-11T11:16:21.026743Z',0),
  ('BPNL00000003COJN',0,'089af2e9-8b31-454c-9fa6-4662b1d76f43','P0572','Geschwindigkeitsregelungs-/Bremspedalschalter A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Geschwindigkeitsregelungs-/Bremspedalschalter, Motorsteuergerät','2022-05-11T11:16:21.032011Z',0),
  ('BPNL00000003COJN',0,'a0797316-15f8-4138-acd6-10df2ae81bb6','P0573','Geschwindigkeitsregelungs-/Bremspedalschalter A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Geschwindigkeitsregelungs-/Bremspedalschalter, Motorsteuergerät','2022-05-11T11:16:21.036808Z',0),
  ('BPNL00000003COJN',0,'14643ebf-d812-41a0-a001-f74add24aade','P0574','Geschwindigkeitsregelsystem - Fahrgeschwindigkeit zu hoch','Mechanische Fehlfunktion','2022-05-11T11:16:21.046879Z',0),
  ('BPNL00000003COJN',0,'15313ec8-0e4c-4504-a7ae-75d9dc0a5796','P0575','Geschwindigkeitsregelsystem - Fehlfunktion Eingangsstromkreis','Kabelbaum, schlechte Kontaktierung, mechanische Fehlfunktion, Motorsteuergerät','2022-05-11T11:16:21.052141Z',0),
  ('BPNL00000003COJN',0,'f8600c34-4966-4666-8a94-0a2a10274e94','P0576','Geschwindigkeitsregelsystem - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum','2022-05-11T11:16:21.066821Z',0),
  ('BPNL00000003COJN',0,'f9134e81-1d91-420e-b1ac-4d1f232e3a56','P0577','Geschwindigkeitsregelsystem - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum','2022-05-11T11:16:21.072077Z',0),
  ('BPNL00000003COJN',0,'c6de4f9c-930c-460f-a2a1-f8a1b2534e08','P0578','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal A - keine Signaländerung im Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.077052Z',0),
  ('BPNL00000003COJN',0,'dc18f57b-0788-4254-b943-9cad2cee7bf7','P0579','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.099568Z',0),
  ('BPNL00000003COJN',0,'140b77e8-1b81-40a6-8f2a-48089f3d718e','P057A','Bremspedalsensor - offener Stromkreis','Kabelbaum, Bremspedalsensor, Motorsteuergerät','2022-05-11T11:16:21.105138Z',0),
  ('BPNL00000003COJN',0,'75f9d745-e6db-4c41-9dea-047ecbcec634','P057B','Bremspedalsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Bremspedalsensor, Motorsteuergerät','2022-05-11T11:16:21.111626Z',0),
  ('BPNL00000003COJN',0,'77614fbf-34d5-49c7-8390-9a45c2d2bd54','P057C','Bremspedalsensor - Signal zu niedrig','Kabelbaum, Bremspedalsensor, Motorsteuergerät','2022-05-11T11:16:21.116781Z',0),
  ('BPNL00000003COJN',0,'fcfe6d51-2420-4cda-8cb7-955a12818c21','P057D','Bremspedalsensor - Signal zu hoch','Kabelbaum, Bremspedalsensor, Motorsteuergerät','2022-05-11T11:16:21.121995Z',0),
  ('BPNL00000003COJN',0,'5d036dfa-edfb-45c7-9a46-421dc6dca27f','P057E','Bremspedalsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Bremspedalsensor, Motorsteuergerät','2022-05-11T11:16:21.127875Z',0),
  ('BPNL00000003COJN',0,'36aafda0-0c5b-4196-bfad-d213ae6d3b4f','P0580','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.132546Z',0),
  ('BPNL00000003COJN',0,'3c3d5e2e-fd1d-4aa9-8495-f0730397eb6b','P0581','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.139463Z',0),
  ('BPNL00000003COJN',0,'32d86397-c809-4a5e-a538-cffb32b3cedf','P0582','Geschwindigkeitsregelsystem, Unterdruckregelung - offener Stromkreis','Kabelbaum, Unterdruckregelventil','2022-05-11T11:16:21.144761Z',0),
  ('BPNL00000003COJN',0,'c63f5b71-7a20-4ca5-91dc-e53ae2a5a9e4','P0583','Geschwindigkeitsregelsystem, Unterdruckregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Unterdruckregelventil','2022-05-11T11:16:21.152538Z',0),
  ('BPNL00000003COJN',0,'db6931c1-1593-4dca-9d4d-db307e8d77e1','P0584','Geschwindigkeitsregelsystem, Unterdruckregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Unterdruckregelventil','2022-05-11T11:16:21.159580Z',0),
  ('BPNL00000003COJN',0,'7125831d-4d78-4e68-9fb4-e0cab89eec81','P0585','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignale A/B - Bezugsfehler','Mechanische Fehlfunktion','2022-05-11T11:16:21.164169Z',0),
  ('BPNL00000003COJN',0,'81fe12fd-7852-4b0f-8aad-a6a788a5cfd1','P0586','Geschwindigkeitsregelsystem, Belüftungsregelung - offener Stromkreis','Kabelbaum, Belüftungsregelventil','2022-05-11T11:16:21.178598Z',0),
  ('BPNL00000003COJN',0,'d7c2e770-655f-4228-b4c2-24352ab78c53','P0587','Geschwindigkeitsregelsystem, Belüftungsregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Belüftungsregelventil','2022-05-11T11:16:21.197373Z',0),
  ('BPNL00000003COJN',0,'ef6ba967-ebcc-4375-bd30-8acbd51e2ea7','P0588','Geschwindigkeitsregelsystem, Belüftungsregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Belüftungsregelventil','2022-05-11T11:16:21.207269Z',0),
  ('BPNL00000003COJN',0,'7ad0d0b5-9067-4619-b204-9b322e9c4532','P0589','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal B - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.220319Z',0),
  ('BPNL00000003COJN',0,'e1f9120e-6c8c-4375-86cd-e03eeed160f9','P0590','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal B - keine Signaländerung im Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.225110Z',0),
  ('BPNL00000003COJN',0,'89002513-aab3-4b83-920b-65d3290b4c61','P0591','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.230346Z',0),
  ('BPNL00000003COJN',0,'5ab21afe-5f82-40c6-ba24-8d5b83c22c0e','P0592','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.236094Z',0),
  ('BPNL00000003COJN',0,'34673b76-41b0-4b6d-8995-a550f50df107','P0593','Geschwindigkeitsregelsystem, Multifunktionsschalter Eingangssignal B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Multifunktionsschalter, mechanische Fehlfunktion','2022-05-11T11:16:21.241681Z',0),
  ('BPNL00000003COJN',0,'cf2f572c-d7e8-4d48-8601-fe2c5d59b1bd','P0594','Geschwindigkeitsregelsystem, Stellgliedsteuerung - offener Stromkreis','Kabelbaum, Stellglied','2022-05-11T11:16:21.246562Z',0),
  ('BPNL00000003COJN',0,'dfe21262-e16b-4906-9e6f-18283b8900db','P0595','Geschwindigkeitsregelsystem, Stellgliedsteuerung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Stellglied','2022-05-11T11:16:21.251085Z',0),
  ('BPNL00000003COJN',0,'7e99b51f-9576-4d54-8f2a-cd8e3570ee7c','P0596','Geschwindigkeitsregelsystem, Stellgliedsteuerung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Stellglied','2022-05-11T11:16:21.255144Z',0),
  ('BPNL00000003COJN',0,'b14ff05d-d28b-4d1e-bc65-ea081a31af3c','P0597','Thermostatheizregelung - offener Stromkreis','Kabelbaum, Relais, Thermostatheizer','2022-05-11T11:16:21.259667Z',0),
  ('BPNL00000003COJN',0,'8a40a23d-1986-45a5-8c34-d355d9ccb65b','P0598','Thermostatheizregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Relais, Thermostatheizer','2022-05-11T11:16:21.264121Z',0),
  ('BPNL00000003COJN',0,'6eb4e753-4f26-4611-884f-b09411ace070','P0599','Thermostatheizregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Relais, Thermostatheizer','2022-05-11T11:16:21.268469Z',0),
  ('BPNL00000003COJN',0,'fc0ccb9c-9581-43d8-97d8-1a2e6d280976','P0600','CAN-Datenbus - Fehlfunktion','Kabelbaum, angeschlossenes System, Motorsteuergerät','2022-05-11T11:16:21.273144Z',0),
  ('BPNL00000003COJN',0,'1a595ba2-88f9-4c5c-979f-bffd0d8dc731','P0601','Motorsteuergerät - Speicher Prüfsummenfehler','Motorsteuergerät','2022-05-11T11:16:21.278201Z',0),
  ('BPNL00000003COJN',0,'d97ec2ae-5ef7-43fe-91bc-7e82c864a735','P0602','Motorsteuergerät - Programmierungsfehler','Motorsteuergerät','2022-05-11T11:16:21.282735Z',0),
  ('BPNL00000003COJN',0,'f2fab4a7-eac6-4c5c-b3cf-0fe153876542','P0603','Motorsteuergerät - Fehler Dauerspeicher (KAM)','Motorsteuergerät','2022-05-11T11:16:21.287023Z',0),
  ('BPNL00000003COJN',0,'787a1f85-4e75-4f6a-8aa0-fb28584f1187','P0604','Motorsteuergerät - Fehler RAM-Speicher','Motorsteuergerät','2022-05-11T11:16:21.292073Z',0),
  ('BPNL00000003COJN',0,'8a1c0fb0-2f7c-482f-9195-090a21ac3fce','P0605','Motorsteuergerät - Fehler ROM-Speicher','Motorsteuergerät','2022-05-11T11:16:21.296714Z',0),
  ('BPNL00000003COJN',0,'d58e0092-8d73-4609-85c2-33c6fdc8361d','P0606','Motorsteuergerät/Antriebsstrangsteuergerät - Fehler Mikroprozessor','Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.301921Z',0),
  ('BPNL00000003COJN',0,'459e4629-0598-40f9-aae3-853a4889f8e4','P0607','Motorsteuergerät - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.306414Z',0),
  ('BPNL00000003COJN',0,'85995314-e80b-4aea-9943-e740d7ad6457','P0608','Motorsteuergerät, Ausgangssignal Fahrgeschwindigkeitssensor A - Fehlfunktion','Motorsteuergerät','2022-05-11T11:16:21.310889Z',0),
  ('BPNL00000003COJN',0,'593b6031-97f4-4dba-80e5-87a52cb5ef6b','P0609','Motorsteuergerät, Ausgangssignal Fahrgeschwindigkeitssensor B - Fehlfunktion','Motorsteuergerät','2022-05-11T11:16:21.315536Z',0),
  ('BPNL00000003COJN',0,'d4271b11-3cab-4e0a-b3ab-24835ddf9dff','P060A','Motorsteuergerät, Funktionsfehler Überwachungsprozessor','Motorsteuergerät','2022-05-11T11:16:21.322868Z',0),
  ('BPNL00000003COJN',0,'01c1b93b-e0db-48b1-b20c-0854b07ebfac','P060B','Motorsteuergerät, Funktionsfehler Signalverarbeitung im Analog-Digital-Wandler','Motorsteuergerät','2022-05-11T11:16:21.327466Z',0),
  ('BPNL00000003COJN',0,'227798ff-0062-4faa-aafe-7e573fd51012','P060C','Motorsteuergerät, Zentralprozessor - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.332131Z',0),
  ('BPNL00000003COJN',0,'272ae4e0-2046-4521-b401-eacf42693ddb','P060D','Motorsteuergerät, Fahrpedalstellung - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.338611Z',0),
  ('BPNL00000003COJN',0,'6cbdd6d9-2eaa-4202-937d-0ca989292b4e','P060E','Motorsteuergerät, Drosselklappenstellung - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.343121Z',0),
  ('BPNL00000003COJN',0,'32ab0792-e3f2-49a0-bf90-82ef7c3f236b','P060F','Motorsteuergerät, Kühlmitteltemperatur - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.347756Z',0),
  ('BPNL00000003COJN',0,'2102bf80-ae87-4187-8314-59dcbdd439a2','P0610','Motorsteuergerät - Fehler Fahrzeugoptionen','Motorsteuergerät','2022-05-11T11:16:21.352005Z',0),
  ('BPNL00000003COJN',0,'077f842c-9a51-4fe5-af7d-8a059697da96','P0611','Einspritz-Steuergerät - beeinträchtigte Funktion','Einspritz-Steuergerät','2022-05-11T11:16:21.356527Z',0),
  ('BPNL00000003COJN',0,'8d6cce34-11dc-4e77-841d-b802a62254b7','P0612','Einspritz-Steuergerät - Stromkreis Steuerrelais','Kabelbaum, Relais, Einspritz-Steuergerät','2022-05-11T11:16:21.361015Z',0),
  ('BPNL00000003COJN',0,'69968afd-8db5-4482-9542-a6d14f26310a','P0613','Getriebesteuergerät - Rechnerfehler','Getriebesteuergerät','2022-05-11T11:16:21.365722Z',0),
  ('BPNL00000003COJN',0,'df8e05dc-ccec-4ea9-adaa-65aff12a5e8b','P0614','Motorsteuergerät/Getriebesteuergerät - keine Übereinstimmung','Motorsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.370142Z',0),
  ('BPNL00000003COJN',0,'3ff07dbd-7de8-437a-b408-918e3883fd18','P0615','Anlassermotorrelais - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Anlassermotorrelais, Motorsteuergerät','2022-05-11T11:16:21.374698Z',0),
  ('BPNL00000003COJN',0,'67a02f17-10c6-437f-a956-86fe88c6b265','P0616','Anlassermotorrelais - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Anlassermotorrelais, Motorsteuergerät','2022-05-11T11:16:21.380586Z',0),
  ('BPNL00000003COJN',0,'c85dcf16-4c11-48a0-a6bc-41c7fdcc3770','P0617','Anlassermotorrelais - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Anlassermotorrelais, Motorsteuergerät','2022-05-11T11:16:21.385033Z',0),
  ('BPNL00000003COJN',0,'79a42a3c-fac5-4a39-8d89-0afea7df2fe7','P0618','Alternativkraftstoff-Steuergerät - Fehler Dauerspeicher (KAM)','Alternativkraftstoff-Steuergerät','2022-05-11T11:16:21.389796Z',0),
  ('BPNL00000003COJN',0,'c4f12734-f52d-4e26-a59c-f7d71b77b583','P0619','Alternativkraftstoff-Steuergerät - Fehler RAM-/ROM-Speicher','Alternativkraftstoff-Steuergerät','2022-05-11T11:16:21.394331Z',0),
  ('BPNL00000003COJN',0,'a2d2206f-9036-4914-a4f6-ffa155c452ee','P061A','Motorsteuergerät, Motordrehmoment - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.399105Z',0),
  ('BPNL00000003COJN',0,'30c22e67-8adb-4def-b80c-4c1a05c14a9c','P061B','Motorsteuergerät, Drehmomentberechnung - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.403528Z',0),
  ('BPNL00000003COJN',0,'e1bb91fa-3a67-42e6-b48b-365a354850a1','P061C','Motorsteuergerät, Motordrehzahl - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.407586Z',0),
  ('BPNL00000003COJN',0,'7e162298-d505-4cdc-a869-7fbaa81f981d','P061D','Motorsteuergerät, angesaugte Luftmasse - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.411755Z',0),
  ('BPNL00000003COJN',0,'57f943f6-187c-4fdd-bedd-30f0b18dbf0e','P061E','Motorsteuergerät, Bremspedalschalter/-sensor - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.415945Z',0),
  ('BPNL00000003COJN',0,'7f486ae9-b3f2-4c4c-9a4b-5ce3ba68295b','P061F','Motorsteuergerät, Drosselklappen-Controller - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.420435Z',0),
  ('BPNL00000003COJN',0,'5a5bffcb-c7d9-4bda-b242-cf77fe183584','P0620','Generator, Regelung - Fehlfunktion Stromkreis','Kabelbaum, Generator, Batterie, Motorsteuergerät','2022-05-11T11:16:21.425761Z',0),
  ('BPNL00000003COJN',0,'110dcf05-2b90-47c8-b00f-6a34b756ece1','P0621','Ladekontrollleuchte - Fehlfunktion Stromkreis','Kabelbaum, Ladekontrollleuchte, Motorsteuergerät','2022-05-11T11:16:21.430986Z',0),
  ('BPNL00000003COJN',0,'6c0227c7-1d9a-4417-9789-b121fdfa9c28','P0622','Generatorfeldstärkeregelung - Fehlfunktion Stromkreis','Kabelbaum, Generator, Batterie, Motorsteuergerät','2022-05-11T11:16:21.435891Z',0),
  ('BPNL00000003COJN',0,'e9be81f6-4423-4865-bec7-e4dbcf1d97eb','P0623','Ladekontrollleuchte, Regelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Glühlampe, Motorsteuergerät','2022-05-11T11:16:21.440662Z',0),
  ('BPNL00000003COJN',0,'0169c590-fd6f-4b54-b2ae-5e93fde568ae','P0624','Tankdeckel-Warnleuchte, Regelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Glühlampe, Motorsteuergerät','2022-05-11T11:16:21.445392Z',0),
  ('BPNL00000003COJN',0,'d2a764ec-d1a0-4e45-8709-8d765c904317','P0625','Generatorfeldwicklungsklemme - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Generator','2022-05-11T11:16:21.449936Z',0),
  ('BPNL00000003COJN',0,'7dccb013-4376-4572-b8de-6264781c0177','P0626','Generatorfeldwicklungsklemme - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Generator','2022-05-11T11:16:21.454222Z',0),
  ('BPNL00000003COJN',0,'26093fce-6e5c-4f4f-90ec-5e5930403d0c','P0627','Kraftstoffpumpenregelung - offener Stromkreis','Kabelbaum, Relais, Kraftstoffpumpe','2022-05-11T11:16:21.458736Z',0),
  ('BPNL00000003COJN',0,'d7d47ac1-e55a-4d8d-86bf-ac66246cf818','P0628','Kraftstoffpumpenregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Relais, Kraftstoffpumpe','2022-05-11T11:16:21.462977Z',0),
  ('BPNL00000003COJN',0,'a24f904d-f34e-4055-ad16-ca6eff0f7afd','P0629','Kraftstoffpumpenregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Relais, Kraftstoffpumpe','2022-05-11T11:16:21.467096Z',0),
  ('BPNL00000003COJN',0,'45630d29-df7c-4e2b-aac6-65111e542e40','P062A','Kraftstoffpumpe A - Bereichs-/Funktionsfehler Steuerstromkreis','Kabelbaum, Kraftstoffpumpe, Motorsteuergerät','2022-05-11T11:16:21.471498Z',0),
  ('BPNL00000003COJN',0,'a30f9304-d823-48b9-addc-418086d28bee','P062B','Motorsteuergerät, Einspritzregelung - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.476337Z',0),
  ('BPNL00000003COJN',0,'ddee36b0-ea97-466b-866b-bcf5d653fb06','P062C','Motorsteuergerät, Fahrgeschwindigkeit - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.480540Z',0),
  ('BPNL00000003COJN',0,'2b51db88-0c57-438a-b5cd-0426a4fc2fe4','P062D','Einspritz-Steuergerät, Zylinderreihe 1 - beeinträchtigte Funktion','Kabelbaum, Einspritz-Steuergerät, Motorsteuergerät','2022-05-11T11:16:21.485527Z',0),
  ('BPNL00000003COJN',0,'aabf14de-6526-41b3-b5a7-f38bd4dff3b1','P062E','Einspritz-Steuergerät, Zylinderreihe 2 - beeinträchtigte Funktion','Kabelbaum, Einspritz-Steuergerät, Motorsteuergerät','2022-05-11T11:16:21.490070Z',0),
  ('BPNL00000003COJN',0,'947087d2-7c57-47f0-b07b-952ee9c53b4a','P062F','Motorsteuergerät, Fehler EEPROM-Speicher','Motorsteuergerät','2022-05-11T11:16:21.494413Z',0),
  ('BPNL00000003COJN',0,'6ffd0843-a501-43b9-8092-3a8cfd6bf02c','P0630','VIN nicht einprogrammiert oder nicht erkannt (keine Übereinstimmung) - Motorsteuergerät/Antriebsstrangsteuergerät','Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.503805Z',0),
  ('BPNL00000003COJN',0,'3888e854-2ecd-4ba9-a6b6-eb573c18b424','P0631','VIN nicht einprogrammiert oder nicht erkannt (keine Übereinstimmung) - Getriebesteuergerät','Getriebesteuergerät','2022-05-11T11:16:21.508262Z',0),
  ('BPNL00000003COJN',0,'29feb905-9eb5-46d2-97ea-b4c86b657caa','P0632','Kilometerzähler nicht programmiert - Motorsteuergerät/Antriebsstrangsteuergerät','Programmierung, Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.512724Z',0),
  ('BPNL00000003COJN',0,'7d4d12e4-07be-4424-bc0f-910dcfa4406a','P0633','Wegfahrsperren-Schlüssel nicht programmiert - Motorsteuergerät/Antriebsstrangsteuergerät','Programmierung, Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.517755Z',0),
  ('BPNL00000003COJN',0,'430b2803-fcd5-44b4-809f-1ae5dece077a','P0634','Antriebsstrangsteuergerät/Motorsteuergerät/Getriebesteuergerät - interne Gerätetemperatur zu hoch','Mechanische Fehlfunktion, Antriebsstrangsteuergerät/Motorsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.523308Z',0),
  ('BPNL00000003COJN',0,'669ad6b3-024c-476f-98fa-3827242b3a4e','P0635','Servolenkungsregelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:21.528166Z',0),
  ('BPNL00000003COJN',0,'31f4b2d1-859b-49f6-ac3a-05fb5581c49b','P0636','Servolenkungsregelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:21.536662Z',0),
  ('BPNL00000003COJN',0,'e4fba063-061a-44af-9db3-b4342c2e18b4','P0637','Servolenkungsregelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Servolenkungsdrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:21.541414Z',0),
  ('BPNL00000003COJN',0,'109387dc-7686-4aed-ba20-47dcf512eae5','P0638','Elektronisches Drosselklappensystem (E-GAS), Zylinderreihe 1 - Bereichs-/Funktionsfehler','Grundeinstellung nicht durchgeführt (falls erforderlich), Leerlaufsteller/Drosselklappenmotor, Fahrpedalsensor','2022-05-11T11:16:21.546987Z',0),
  ('BPNL00000003COJN',0,'a4cf5d7a-d765-4604-bbe6-3abb7a73e99a','P0639','Elektronisches Drosselklappensystem (E-GAS), Zylinderreihe 2 - Bereichs-/Funktionsfehler','Kabelbaum, Drosselklappen-Regeleinheit','2022-05-11T11:16:21.551587Z',0),
  ('BPNL00000003COJN',0,'10879ca0-f36a-4479-9fef-2b47e89bccc9','P063A','Überwachungsfunktion Generatorspannung - Fehlfunktion Stromkreis','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.558622Z',0),
  ('BPNL00000003COJN',0,'b64ef1e5-ecc6-4ead-ae72-a54309a0d168','P063B','Überwachungsfunktion Generatorspannung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.563341Z',0),
  ('BPNL00000003COJN',0,'b0793428-143d-4f16-b374-3ec5bd45881c','P063C','Überwachungsfunktion Generatorspannung - Signal zu niedrig','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.573311Z',0),
  ('BPNL00000003COJN',0,'0186dba4-f445-4078-88f9-ddbf0bd8a62c','P063D','Überwachungsfunktion Generatorspannung - Signal zu hoch','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.586077Z',0),
  ('BPNL00000003COJN',0,'83015a3c-e350-42c9-8e0b-8224a5d8c67e','P063E','Drosselklappen-Regeleinheit, automatische Konfiguration - keine Eingangsdaten verfügbar','Kabelbaum, Drosselklappen-Regeleinheit, Motorsteuergerät','2022-05-11T11:16:21.607859Z',0),
  ('BPNL00000003COJN',0,'268709ca-7cf5-4022-b699-f5cda40e8994','P063F','Kühlmitteltemperatursensor, automatische Konfiguration - keine Eingangsdaten verfügbar','Kabelbaum, Kühlmitteltemperatursensor, Motorsteuergerät','2022-05-11T11:16:21.612911Z',0),
  ('BPNL00000003COJN',0,'9debe10e-8dd7-4de9-b43d-4a0f95a6d326','P0640','Ansaugluftheizer-Regelung - Fehlfunktion Stromkreis','Kabelbaum, Relais, Ansaugluftheizer','2022-05-11T11:16:21.617611Z',0),
  ('BPNL00000003COJN',0,'219464a6-f49c-4741-8ce6-29f795ab872c','P0641','Bezugsspannung Sensor A - offener Stromkreis','Kabelbaum','2022-05-11T11:16:21.622130Z',0),
  ('BPNL00000003COJN',0,'582594ff-749d-4c46-9bcd-3e25d7452f17','P0642','Bezugsspannung Sensor A - Signal zu niedrig','Kabelbaum','2022-05-11T11:16:21.627100Z',0),
  ('BPNL00000003COJN',0,'01aae9ef-afba-4ccb-8af5-3a761b50f71e','P0643','Bezugsspannung Sensor A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum','2022-05-11T11:16:21.631214Z',0),
  ('BPNL00000003COJN',0,'71acc5c6-eb2f-43f9-b497-ef2b3bfb1c53','P0644','Fahrer-Infodisplay, serielle Datenübertragung - Fehlfunktion Stromkreis','Kabelbaum, CAN-Datenbus, Motorsteuergerät','2022-05-11T11:16:21.636675Z',0),
  ('BPNL00000003COJN',0,'a0885b22-00d4-4f8f-b167-d688e0aa92f8','P0645','Klimakompressorkupplungsrelais - Fehlfunktion Stromkreis','Kabelbaum, Klimakompressorkupplungsrelais','2022-05-11T11:16:21.641710Z',0),
  ('BPNL00000003COJN',0,'28a6b79f-b351-448a-88f5-6b9dce6cc0d2','P0646','Klimakompressorkupplungsrelais - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Klimakompressorkupplungsrelais','2022-05-11T11:16:21.648939Z',0),
  ('BPNL00000003COJN',0,'c8d2a4fe-8687-4448-b3d9-4bed54030581','P0647','Klimakompressorkupplungsrelais - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Klimakompressorkupplungsrelais','2022-05-11T11:16:21.656496Z',0),
  ('BPNL00000003COJN',0,'d82ca4d0-671f-4a69-9604-99b5bfdff391','P0648','Wegfahrsperren-Kontrollleuchte, Regelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Glühlampe, Motorsteuergerät','2022-05-11T11:16:21.662114Z',0),
  ('BPNL00000003COJN',0,'ee7686aa-167a-4ab2-bbf8-03480159928b','P0649','Geschwindigkeitsregelungs-Kontrollleuchte, Regelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Glühlampe, Motorsteuergerät','2022-05-11T11:16:21.667347Z',0),
  ('BPNL00000003COJN',0,'dac177dc-9cfc-4333-bf14-194bc70b28ed','P064A','Kraftstoffpumpen-Steuergerät - Fehlfunktion','Kabelbaum, Kraftstoffpumpe, Motorsteuergerät','2022-05-11T11:16:21.671914Z',0),
  ('BPNL00000003COJN',0,'0ffc1647-0314-4d79-8633-fa895e9fac63','P064B','Nebenabtriebs-Steuergerät - Fehlfunktion','Kabelbaum, Nebenabtriebs-Steuergerät, Motorsteuergerät','2022-05-11T11:16:21.684250Z',0),
  ('BPNL00000003COJN',0,'2ab6acb0-ea98-4366-a60d-52e494e4d066','P064C','Glühkerzen-Steuergerät - Fehlfunktion','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.692955Z',0),
  ('BPNL00000003COJN',0,'582e542e-9369-4979-bc2c-4a95fa0e3887','P064D','Motorsteuergerät, Prozessor beheizte Lambdasonde, Zylinderreihe 1 - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.698817Z',0),
  ('BPNL00000003COJN',0,'2aba0d84-b16d-4706-a008-27d6b3a36c56','P064E','Motorsteuergerät, Prozessor Lambdasonde, Zylinderreihe 2 - beeinträchtigte Funktion','Motorsteuergerät','2022-05-11T11:16:21.703358Z',0),
  ('BPNL00000003COJN',0,'a6d6fc5c-f640-4a67-91ac-14b0b231023b','P064F','Unzulässige Software - unzulässige Kalibrationswerte aufgrund herstellerfremder Tuning-Teile festgestellt','Unzulässige Software','2022-05-11T11:16:21.709785Z',0),
  ('BPNL00000003COJN',0,'d41a27a6-f7b8-4463-8cfc-e086ed434960','P0650','Motorstörungswarnleuchte, Regelung - Fehlfunktion Stromkreis','Kabelbaum, Motorstörungswarnleuchte, Motorsteuergerät','2022-05-11T11:16:21.718551Z',0),
  ('BPNL00000003COJN',0,'2684a582-cd47-43bc-8f9f-d3b157081639','P0651','Bezugsspannung Sensor B - offener Stromkreis','Kabelbaum','2022-05-11T11:16:21.724987Z',0),
  ('BPNL00000003COJN',0,'a4b575d4-7b1b-4df6-aed0-e57e89e83113','P0652','Bezugsspannung Sensor B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum','2022-05-11T11:16:21.729896Z',0),
  ('BPNL00000003COJN',0,'f0dc5f63-9238-4404-92be-17103d0a97a2','P0653','Bezugsspannung Sensor B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum','2022-05-11T11:16:21.734945Z',0),
  ('BPNL00000003COJN',0,'4f00cf3c-dec6-4e0a-a9dc-065df49f8934','P0654','Motordrehzahl, Ausgangssignal - Fehlfunktion Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:21.740913Z',0),
  ('BPNL00000003COJN',0,'95218485-04fe-429f-8c2f-16473a914b91','P0655','Ausgangssignal Motorüberhitzungswarnleuchte - Fehlfunktion Stromkreis','Kabelbaum, Motorüberhitzungswarnleuchte, Motorsteuergerät','2022-05-11T11:16:21.745300Z',0),
  ('BPNL00000003COJN',0,'f0fa7e48-09a5-4fa2-b24d-032def26ec4d','P0656','Ausgangssignal Kraftstoffstand - Fehlfunktion Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:21.750058Z',0),
  ('BPNL00000003COJN',0,'d6f3904b-cabb-42d0-a49c-2fd35506e68d','P0657','Versorgungsspannung Stellglied - offener Stromkreis','Kabelbaum','2022-05-11T11:16:21.759184Z',0),
  ('BPNL00000003COJN',0,'5eb5663b-8763-44c0-adcf-aa3625de7404','P0658','Versorgungsspannung Stellglied - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Stellglied','2022-05-11T11:16:21.764134Z',0),
  ('BPNL00000003COJN',0,'38872ddd-bfbc-4879-a41a-4d412d833aeb','P0659','Versorgungsspannung Stellglied - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Stellglied','2022-05-11T11:16:21.769673Z',0),
  ('BPNL00000003COJN',0,'d9380c02-6f0e-4b55-889e-bb1346f13640','P065A','Generator - beeinträchtigte Funktion','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.777385Z',0),
  ('BPNL00000003COJN',0,'6b1690f2-fa1e-4307-a306-e70dd497c1e8','P065B','Generator - Bereichs-/Funktionsfehler Steuerstromkreis','Kabelbaum, Generator, Motorsteuergerät','2022-05-11T11:16:21.781908Z',0),
  ('BPNL00000003COJN',0,'f497907e-e3a7-4cf6-9255-70514abe3054','P065C','Generator - mechanische Fehlfunktion/beeinträchtigte Funktion','Generator','2022-05-11T11:16:21.786740Z',0),
  ('BPNL00000003COJN',0,'7b5d8472-fa12-4ca7-9a40-a484d93339dc','P065D','Warnleuchte für Reduktionsmitteleinspritzung - Fehlfunktion Stromkreis','Kabelbaum, Warnleuchte für Reduktionsmitteleinspritzung, Motorsteuergerät','2022-05-11T11:16:21.791094Z',0),
  ('BPNL00000003COJN',0,'c422f1c8-aae3-4fbb-be4f-6585fe68eba9','P065E','Schaltsaugrohr-Stellglied, Zylinderreihe 1 - beeinträchtigte Funktion','Kabelbaum, Schaltsaugrohr-Stellglied, Motorsteuergerät','2022-05-11T11:16:21.796335Z',0),
  ('BPNL00000003COJN',0,'d1bcaef3-2980-47c6-b4e0-74c5fac9a15c','P065F','Schaltsaugrohr-Stellglied Zylinderreihe 2 - beeinträchtigte Funktion','Kabelbaum, Schaltsaugrohr-Stellglied, Motorsteuergerät','2022-05-11T11:16:21.801591Z',0),
  ('BPNL00000003COJN',0,'32bc5a24-5ae4-4489-b882-a879768efb99','P0660','Schaltsaugrohr-Magnetventil, Zylinderreihe 1 - offener Stromkreis','Kabelbaum, Schaltsaugrohr-Magnetventil','2022-05-11T11:16:21.805858Z',0),
  ('BPNL00000003COJN',0,'6ca8597f-83e1-4846-9ad8-333cd1bb2f23','P0661','Schaltsaugrohr-Magnetventil, Zylinderreihe 1 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltsaugrohr-Magnetventil','2022-05-11T11:16:21.810129Z',0),
  ('BPNL00000003COJN',0,'e8c22852-2ff2-4067-a010-a83709f7992d','P0662','Schaltsaugrohr-Magnetventil, Zylinderreihe 1 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltsaugrohr-Magnetventil','2022-05-11T11:16:21.814599Z',0),
  ('BPNL00000003COJN',0,'a294ef15-279f-4198-856f-a30712203690','P0663','Schaltsaugrohr-Magnetventil, Zylinderreihe 2 - offener Stromkreis','Kabelbaum, Schaltsaugrohr-Magnetventil','2022-05-11T11:16:21.818942Z',0),
  ('BPNL00000003COJN',0,'977e85a9-3fb0-4806-badb-ba05e854c59e','P0664','Schaltsaugrohr-Magnetventil, Zylinderreihe 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltsaugrohr-Magnetventil','2022-05-11T11:16:21.823626Z',0),
  ('BPNL00000003COJN',0,'1a7c0fcd-ec7d-4cde-b4c7-4f4456606c69','P0665','Schaltsaugrohr-Magnetventil, Zylinderreihe 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Ansaugkrümmer','2022-05-11T11:16:21.828020Z',0),
  ('BPNL00000003COJN',0,'ddd8fd90-018e-4c07-a4f3-e014e9bccc76','P0666','Sensor interne Gerätetemperatur für Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät - Fehlfunktion Stromkreis','Schlechte Kontaktierung, Sensor interne Gerätetemperatur, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.832414Z',0),
  ('BPNL00000003COJN',0,'6c8f6f6e-a154-493f-b6d2-aa6686d30221','P0667','Sensor interne Gerätetemperatur für Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät - Bereichs-/Funktionsfehler','Schlechte Kontaktierung, Sensor interne Gerätetemperatur, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.838362Z',0),
  ('BPNL00000003COJN',0,'6631997d-eed8-4a9b-a72c-3f5770e95a20','P0668','Sensor interne Gerätetemperatur für Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät - Signal zu niedrig','Interner Kurzschluss an Masse, Sensor interne Gerätetemperatur, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.843019Z',0),
  ('BPNL00000003COJN',0,'b555bb6c-01ee-4403-b4fe-becccfa15272','P0669','Sensor interne Gerätetemperatur für Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät - Signal zu hoch','Interner Kurzschluss an Plus, Sensor interne Gerätetemperatur, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:21.848205Z',0),
  ('BPNL00000003COJN',0,'5f78bf16-f4c8-4234-9777-37db628c9a23','P066A','Glühkerze, Zylinder 1 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.852942Z',0),
  ('BPNL00000003COJN',0,'aa3f29aa-2f37-4c37-a8e2-b280e30a6d82','P066B','Glühkerze, Zylinder 1 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.858623Z',0),
  ('BPNL00000003COJN',0,'2e2e9c8d-3316-4199-98b3-8b27ffe83aa0','P066C','Glühkerze, Zylinder 2 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.862828Z',0),
  ('BPNL00000003COJN',0,'80b921e6-a1a9-4815-b8d3-273cf12ee1e5','P066D','Glühkerze, Zylinder 2 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.867329Z',0),
  ('BPNL00000003COJN',0,'36aaa7ac-c8a1-4205-a279-97fb3769eee9','P066E','Glühkerze, Zylinder 3 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.871668Z',0),
  ('BPNL00000003COJN',0,'6db52112-0d64-4e75-9978-9bde38527c9e','P066F','Glühkerze, Zylinder 3 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.875725Z',0),
  ('BPNL00000003COJN',0,'b1aeaa27-0333-485b-8617-b254c782181b','P0670','Glühkerzen-Steuergerät - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.881051Z',0),
  ('BPNL00000003COJN',0,'7ff65238-ea72-4562-9845-1d44a41acb55','P0671','Glühkerze, Zylinder 1 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.886195Z',0),
  ('BPNL00000003COJN',0,'6a93a213-a6c4-4ecc-8096-977603e022b2','P0672','Glühkerze, Zylinder 2 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.891149Z',0),
  ('BPNL00000003COJN',0,'e10ca709-6ec8-46ae-a987-ed2025b29c7c','P0673','Glühkerze, Zylinder 3 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.895770Z',0),
  ('BPNL00000003COJN',0,'3d4c36fd-5efd-428a-b9a9-bb915df8e7d8','P0674','Glühkerze, Zylinder 4 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.900381Z',0),
  ('BPNL00000003COJN',0,'faa29ed0-0def-471b-8994-7ba3b7488db4','P0675','Glühkerze, Zylinder 5 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.905184Z',0),
  ('BPNL00000003COJN',0,'ae464ff4-5321-4206-9380-5d90cc7d8658','P0676','Glühkerze, Zylinder 6 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.909666Z',0),
  ('BPNL00000003COJN',0,'823ccb4f-4e43-42e9-bdcb-958767698637','P0677','Glühkerze, Zylinder 7 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.914329Z',0),
  ('BPNL00000003COJN',0,'36101bf6-926b-4453-aa20-e5e0a089c010','P0678','Glühkerze, Zylinder 8 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.920620Z',0),
  ('BPNL00000003COJN',0,'cb3cf373-50ae-44d2-8660-30d159c4d526','P0679','Glühkerze, Zylinder 9 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.925330Z',0),
  ('BPNL00000003COJN',0,'8a3130f9-25ca-4cde-9ee0-b3d578180fe9','P067A','Glühkerze, Zylinder 4 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.930477Z',0),
  ('BPNL00000003COJN',0,'31ad8305-1fb3-4732-9f8b-5a0fc5651b76','P067B','Glühkerze, Zylinder 4 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.937923Z',0),
  ('BPNL00000003COJN',0,'afa46d6f-f26b-4ba2-98b2-d7369e56bdf8','P067C','Glühkerze, Zylinder 5 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.944181Z',0),
  ('BPNL00000003COJN',0,'2e05fb5f-7dc4-4275-9b42-44ba6aabd3dd','P067D','Glühkerze, Zylinder 5 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.948608Z',0),
  ('BPNL00000003COJN',0,'e3371aa3-701c-4798-9b18-faa757b1a5aa','P067E','Glühkerze, Zylinder 6 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.954690Z',0),
  ('BPNL00000003COJN',0,'d4cb02fd-4950-4312-a12c-9a37f16d1ff8','P067F','Glühkerze, Zylinder 6 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.958948Z',0),
  ('BPNL00000003COJN',0,'d81e4574-777e-4799-814a-bfa2f8ca14e3','P0680','Glühkerze, Zylinder 10 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.963473Z',0),
  ('BPNL00000003COJN',0,'2e065c6a-6ba5-4107-8650-5808bfc7f418','P0681','Glühkerze, Zylinder 11 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.968089Z',0),
  ('BPNL00000003COJN',0,'a4faea40-80dc-4d62-8338-0e205ab20d85','P06E5','Glühkerzen-Steuergerät - beeinträchtigte Funktion','Kabelbaum, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.474590Z',0),
  ('BPNL00000003COJN',0,'46c148d7-f755-4bad-84e7-b85a5e8a3aa2','P0682','Glühkerze, Zylinder 12 - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Relais, Glühkerzen-Steuergerät, Glühkerze, Motorsteuergerät','2022-05-11T11:16:21.972770Z',0),
  ('BPNL00000003COJN',0,'6a8e703a-e16c-4388-b567-d2eed3aa691b','P0683','Kommunikationsfehler Glühkerzen-Steuergerät an Motorsteuergerät/Antriebsstrangsteuergerät','Kabelbaum, schlechte Kontaktierung, Glühkerzen-Steuergerät, Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.977893Z',0),
  ('BPNL00000003COJN',0,'d3f96c53-22c6-40d3-abee-adc7f6d41b28','P0684','Kommunikationsfehler Glühkerzen-Steuergerät an Motorsteuergerät/Antriebsstrangsteuergerät - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Glühkerzen-Steuergerät, Motorsteuergerät/Antriebsstrangsteuergerät','2022-05-11T11:16:21.983061Z',0),
  ('BPNL00000003COJN',0,'e4edf1e0-cb14-480a-8d94-17377a531e4e','P0685','Motorsteuerungsrelais - offener Stromkreis','Kabelbaum, Motorsteuerungsrelais','2022-05-11T11:16:21.988133Z',0),
  ('BPNL00000003COJN',0,'89c8d7b0-dc05-4e94-b9dd-1cb3cdb00563','P0686','Motorsteuerungsrelais - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:21.992564Z',0),
  ('BPNL00000003COJN',0,'152c5d09-fb5f-4681-9973-423f5877affb','P0687','Motorsteuerungsrelais - Kurzschluss an Masse','Kurzschluss an Masse im Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:21.998792Z',0),
  ('BPNL00000003COJN',0,'8818fece-6229-46ad-a90b-14d736806b6b','P0688','Motorsteuerungsrelais - Kurzschluss an Plus','Kurzschluss an Plus im Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:22.003431Z',0),
  ('BPNL00000003COJN',0,'a0314fef-fca8-4298-8b0d-d9a0d7973f4d','P0689','Motorsteuerungsrelais - Signal zu niedrig im Stromkreis Relaisschaltzustandserfassung','Kurzschluss an Masse im Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:22.007803Z',0),
  ('BPNL00000003COJN',0,'b1b071ba-d575-44d7-ac32-82ea5d0bb690','P068A','Motorsteuerungsrelais - Frühabschaltung','Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:22.012563Z',0),
  ('BPNL00000003COJN',0,'9a97f80b-3192-4c72-aacc-38fbb1955df2','P068B','Motorsteuerungsrelais - Ausschaltverzögerung','Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:22.017813Z',0),
  ('BPNL00000003COJN',0,'f34fd7b2-83cc-4dc2-8983-5dd0de8b08a6','P068C','Glühkerze, Zylinder 7 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.022575Z',0),
  ('BPNL00000003COJN',0,'89233980-d36c-47fa-a903-5b6d5878572c','P068D','Glühkerze, Zylinder 7 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.026998Z',0),
  ('BPNL00000003COJN',0,'ee9eb6dd-317f-443c-a679-b99d413b2849','P068E','Glühkerze, Zylinder 8 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.032111Z',0),
  ('BPNL00000003COJN',0,'a155d844-5391-41f3-a506-e95b4d7ce674','P068F','Glühkerze, Zylinder 8 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.036530Z',0),
  ('BPNL00000003COJN',0,'b5582824-13fb-46db-ae1a-543cab66432f','P0690','Motorsteuerungsrelais - Signal zu hoch im Stromkreis Relaisschaltzustandserfassung','Kurzschluss an Plus im Kabelbaum, Motorsteuerungsrelais, Motorsteuergerät','2022-05-11T11:16:22.042579Z',0),
  ('BPNL00000003COJN',0,'ed2b4116-b1e7-4104-a87c-e98c49d6a592','P0691','Kühlerlüftermotor 1 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:22.047477Z',0),
  ('BPNL00000003COJN',0,'b29d41d3-2b89-49d3-b9a0-71b8b03af4a1','P0692','Kühlerlüftermotor 1 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:22.052251Z',0),
  ('BPNL00000003COJN',0,'929307f5-5aab-4fd8-9b2d-2db8ccbc905e','P0693','Kühlerlüftermotor 2 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:22.062706Z',0),
  ('BPNL00000003COJN',0,'77fb7653-3c37-40ec-bad5-07ce645eab6c','P0694','Kühlerlüftermotor 2 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kühlerlüftermotor, Motorsteuergerät','2022-05-11T11:16:22.069888Z',0),
  ('BPNL00000003COJN',0,'72cccd92-784a-4ae2-a49b-7f9db838aaf5','P0695','Kühlerlüftermotor 3 - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kühlerlüftermotor','2022-05-11T11:16:22.074425Z',0),
  ('BPNL00000003COJN',0,'2ec3ba7e-7ca5-4c55-a500-d4b8e31f0812','P0696','Kühlerlüftermotor 3 - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kühlerlüftermotor','2022-05-11T11:16:22.078900Z',0),
  ('BPNL00000003COJN',0,'e94836ff-2cac-4f29-af3b-1925603818e1','P0697','Bezugsspannung Sensor C - offener Stromkreis','Kabelbaum','2022-05-11T11:16:22.083307Z',0),
  ('BPNL00000003COJN',0,'98e9282a-ee12-4e81-ab56-3b6f53d00fa5','P0698','Bezugsspannung Sensor C - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum','2022-05-11T11:16:22.087823Z',0),
  ('BPNL00000003COJN',0,'8d1cfaf2-e5f5-4ae3-bd9f-e1ab4b349703','P0699','Bezugsspannung Sensor C - Signal zu hoch','Kurzschluss an Plus im Kabelbaum','2022-05-11T11:16:22.092760Z',0),
  ('BPNL00000003COJN',0,'6f9d24c2-c946-47ac-bbcb-dfdeea0e3e8c','P069A','Glühkerze, Zylinder 9 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.097950Z',0),
  ('BPNL00000003COJN',0,'0618ce35-c87e-4b23-8a3e-b84f2586be56','P069B','Glühkerze, Zylinder 9 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.102433Z',0),
  ('BPNL00000003COJN',0,'21d9c77f-9652-40d5-adef-31d2393ed7eb','P069C','Glühkerze, Zylinder 10 - Signal zu niedrig','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.108196Z',0),
  ('BPNL00000003COJN',0,'c23a46c0-8aad-4b41-960d-50b6eaf87a79','P069D','Glühkerze, Zylinder 10 - Signal zu hoch','Kabelbaum, Glühkerze, Motorsteuergerät','2022-05-11T11:16:22.113238Z',0),
  ('BPNL00000003COJN',0,'566ab6be-8179-469e-be10-d5cb2f331c65','P069E','Kraftstoffpumpen-Steuergerät - Aktivierung der Motorstörungswarnleuchte angefordert','Kabelbaum, Kraftstoffpumpe, Kraftstoffpumpen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.118041Z',0),
  ('BPNL00000003COJN',0,'7e561329-8447-4f13-83da-4e0b2068d3c6','P069F','Drosselklappensystem-Warnleuchte - Fehlfunktion Stromkreis','Kabelbaum, Warnleuchte, Motorsteuergerät','2022-05-11T11:16:22.127142Z',0),
  ('BPNL00000003COJN',0,'47c7ad98-afdb-44e5-b9c7-9b6d64abd4ba','P06A0','Variable Klimakompressorregelung - Fehlfunktion Stromkreis','Kabelbaum, Klimaanlagen-Steuergerät, Klimakompressor-Hubraumsteuerungsmagnetventil, Motorsteuergerät','2022-05-11T11:16:22.132555Z',0),
  ('BPNL00000003COJN',0,'380325a7-b84c-4491-af53-5168c2abd763','P06A1','Variable Klimakompressorregelung - Signal zu niedrig','Kabelbaum, Klimaanlagen-Steuergerät, Klimakompressor-Hubraumsteuerungsmagnetventil, Motorsteuergerät','2022-05-11T11:16:22.137229Z',0),
  ('BPNL00000003COJN',0,'7b0469c1-beed-4932-a1d3-21952855445f','P06A2','Variable Klimakompressorregelung - Signal zu hoch','Kabelbaum, Klimaanlagen-Steuergerät, Klimakompressor-Hubraumsteuerungsmagnetventil, Motorsteuergerät','2022-05-11T11:16:22.141652Z',0),
  ('BPNL00000003COJN',0,'c622a11b-4a66-4439-b3c3-4b6c8ee190f0','P06A3','Bezugsspannung Sensor D - offener Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.151710Z',0),
  ('BPNL00000003COJN',0,'bfcc969d-65c4-4491-93ec-cf1a6d9c023b','P06A4','Bezugsspannung Sensor D - Signal zu niedrig','Kabelbaum, Kurzschluss im Sensor, Motorsteuergerät','2022-05-11T11:16:22.155980Z',0),
  ('BPNL00000003COJN',0,'591de8a3-07ab-47fb-bfa7-b2c7822593f4','P06A5','Bezugsspannung Sensor D - Signal zu hoch','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.160505Z',0),
  ('BPNL00000003COJN',0,'96aae3f9-5bb1-4c81-91b9-4ddf2dbe56d1','P06A6','Bezugsspannung Sensor A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.167406Z',0),
  ('BPNL00000003COJN',0,'6d0bf345-158d-4391-988a-e261cf05e45c','P06A7','Bezugsspannung Sensor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.171811Z',0),
  ('BPNL00000003COJN',0,'82ae659a-2290-4fbd-90a1-5af68091ee03','P06A8','Bezugsspannung Sensor C - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.176483Z',0),
  ('BPNL00000003COJN',0,'a8ad6f28-718c-4e28-a274-a5dfe527fbd6','P06A9','Bezugsspannung Sensor D - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motorsteuergerät','2022-05-11T11:16:22.181482Z',0),
  ('BPNL00000003COJN',0,'5ec011d5-c3b9-43ff-8737-9b232b83800b','P06AA','Motorsteuergerät/Getriebesteuergerät B - interne Gerätetemperatur zu hoch','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.187581Z',0),
  ('BPNL00000003COJN',0,'e27046cd-c125-4f7f-8768-29f151a39c05','P06AB','Motorsteuergerät/Getriebesteuergerät, Sensor interne Gerätetemperatur B - Fehlfunktion Stromkreis','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.192128Z',0),
  ('BPNL00000003COJN',0,'6a1d42c9-34e7-4fe8-ad9f-bf1d29a825ca','P06AC','Motorsteuergerät/Getriebesteuergerät, Sensor interne Gerätetemperatur B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.197911Z',0),
  ('BPNL00000003COJN',0,'6edfc9f5-cdf1-423e-89fa-eaa421598f09','P06AD','Motorsteuergerät/Getriebesteuergerät, Sensor interne Gerätetemperatur B - Signal zu niedrig','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.202178Z',0),
  ('BPNL00000003COJN',0,'7c9d382b-c67d-4643-8d9e-1f4bd8a4ea54','P06AE','Motorsteuergerät/Getriebesteuergerät, Sensor interne Gerätetemperatur B - Signal zu hoch','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.206787Z',0),
  ('BPNL00000003COJN',0,'3170d470-de2d-4aae-94e5-c2abfa3a8847','P06AF','Drehmomentregelung - Betriebsmodus "Motorzwangsabschaltung"','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.211814Z',0),
  ('BPNL00000003COJN',0,'40859d23-3421-4950-8ca7-b49dfcd73354','P06B0','Sensor-Versorgungsspannung A - offener Stromkreis','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.216305Z',0),
  ('BPNL00000003COJN',0,'c5b6c5fe-970b-4a33-9fbe-d39b26beb3cc','P06B1','Sensor-Versorgungsspannung A - Signal zu niedrig','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.220821Z',0),
  ('BPNL00000003COJN',0,'5971fe18-c372-4a00-b8bb-ade53e34c47e','P06B2','Sensor-Versorgungsspannung A - Signal zu hoch','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.225176Z',0),
  ('BPNL00000003COJN',0,'fa4254b5-b13b-4fc6-bbeb-1e077637635d','P06B3','Sensor-Versorgungsspannung B - offener Stromkreis','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.229705Z',0),
  ('BPNL00000003COJN',0,'2ff37546-5668-452f-9689-408d290b6645','P06B4','Sensor-Versorgungsspannung B - Signal zu niedrig','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.234104Z',0),
  ('BPNL00000003COJN',0,'dcf9db1f-b26d-445b-bafe-482ff605bfd9','P06B5','Sensor-Versorgungsspannung B - Signal zu hoch','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.238605Z',0),
  ('BPNL00000003COJN',0,'e5525baf-2ae9-4207-bb55-f531d2e5d2f4','P06B6','Internes Steuergerät, Prozessor Klopfsensor 1 - beeinträchtigte Funktion','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.243234Z',0),
  ('BPNL00000003COJN',0,'6e0bf8a0-503a-4046-b952-ef0760d63dac','P06B7','Internes Steuergerät, Prozessor Klopfsensor 2 - beeinträchtigte Funktion','Kabelbaum, Motorsteuergerät, Getriebesteuergerät','2022-05-11T11:16:22.248997Z',0),
  ('BPNL00000003COJN',0,'e0b66276-9f4c-465d-b0bc-1801b39a65e6','P06B8','Internes Steuergerät, Festwertspeicher - Fehler','-','2022-05-11T11:16:22.253665Z',0),
  ('BPNL00000003COJN',0,'e1773a03-3c06-4312-98ab-f238b4c88787','P06B9','Glühkerze, Zylinder 1 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.258637Z',0),
  ('BPNL00000003COJN',0,'fd6157f8-97c1-4fb2-a538-248ba4d74cee','P06BA','Glühkerze, Zylinder 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.263651Z',0),
  ('BPNL00000003COJN',0,'18d777f5-69a9-4fb6-be93-57397288eea1','P06BB','Glühkerze, Zylinder 3 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.268112Z',0),
  ('BPNL00000003COJN',0,'b8a1107e-a436-46f5-a8f4-f2f8d9b66562','P06BC','Glühkerze, Zylinder 4 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.272604Z',0),
  ('BPNL00000003COJN',0,'eca9b9fc-9858-4e84-a6fa-367020ce3c04','P06BD','Glühkerze, Zylinder 5 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.276967Z',0),
  ('BPNL00000003COJN',0,'e154a343-e946-4c9b-baf2-58dbd682e9f4','P06BE','Glühkerze, Zylinder 6 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.281661Z',0),
  ('BPNL00000003COJN',0,'766e9f52-bd44-4d7f-8453-10e354ba38f8','P06BF','Glühkerze, Zylinder 7 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.286410Z',0),
  ('BPNL00000003COJN',0,'6fa9897c-4994-418c-b24f-bd38ef48452a','P06C0','Glühkerze, Zylinder 8 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.291523Z',0),
  ('BPNL00000003COJN',0,'c7697326-fed8-49b1-adcf-fe88c37b2646','P06C1','Glühkerze, Zylinder 9 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.296338Z',0),
  ('BPNL00000003COJN',0,'4c19d22b-d30a-412f-8815-deda43b421f8','P06C2','Glühkerze, Zylinder 10 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.301332Z',0),
  ('BPNL00000003COJN',0,'19c4a278-3d1b-4201-b201-3727836c70fb','P06C3','Glühkerze, Zylinder 11 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.306253Z',0),
  ('BPNL00000003COJN',0,'c80e5a3c-f288-43c0-a249-cc00d31c8aa7','P06C4','Glühkerze, Zylinder 12 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Glühkerze','2022-05-11T11:16:22.310430Z',0),
  ('BPNL00000003COJN',0,'513af2bc-5ea3-4f2f-a23e-962f6a11d4f2','P06C5','Glühkerze, Zylinder 1 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.314719Z',0),
  ('BPNL00000003COJN',0,'f12f71c3-708f-4ea1-ab3a-7111f2a801ef','P06C6','Glühkerze, Zylinder 2 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.319331Z',0),
  ('BPNL00000003COJN',0,'905be911-1c3e-4acd-bc96-f7d6af70572c','P06C7','Glühkerze, Zylinder 3 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.324292Z',0),
  ('BPNL00000003COJN',0,'57ad1ab3-66cd-4285-a6b7-c7d695b2f3ce','P06C8','Glühkerze, Zylinder 4 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.329074Z',0),
  ('BPNL00000003COJN',0,'cb56cb5b-c393-4912-a503-2d111fddb8b2','P06C9','Glühkerze, Zylinder 5 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.333999Z',0),
  ('BPNL00000003COJN',0,'4b79cf9f-f698-4473-9047-8108d1be7828','P06CA','Glühkerze, Zylinder 6 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.338741Z',0),
  ('BPNL00000003COJN',0,'9a02d5fe-db13-4d44-92e0-1adb60a2ba63','P06CB','Glühkerze, Zylinder 7 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.343035Z',0),
  ('BPNL00000003COJN',0,'0040a213-9d91-44bf-92d0-58e48e096d77','P06CC','Glühkerze, Zylinder 8 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.347098Z',0),
  ('BPNL00000003COJN',0,'e64eff8a-d7c3-40ad-be0d-e40931db3dd0','P06CD','Glühkerze, Zylinder 9 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.351516Z',0),
  ('BPNL00000003COJN',0,'167451d4-123e-452f-a943-0a1791a2f1e5','P06CE','Glühkerze, Zylinder 10 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.355918Z',0),
  ('BPNL00000003COJN',0,'1fe53d8f-47f3-4e8b-9de7-4171f219ef20','P06CF','Glühkerze, Zylinder 11 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.361929Z',0),
  ('BPNL00000003COJN',0,'86ca3241-7868-490d-b548-4486d3e5c323','P06D0','Glühkerze, Zylinder 12 - Fehlfunktion','Kabelbaum, Glühkerze','2022-05-11T11:16:22.366662Z',0),
  ('BPNL00000003COJN',0,'265edace-89e5-4eb1-ae52-97eae36afcc9','P06D1','Internes Steuergerät, Zünddauerregelung - beeinträchtigte Funktion','-','2022-05-11T11:16:22.382135Z',0),
  ('BPNL00000003COJN',0,'34a5494e-2c23-4abd-8c28-e9e14ccf930f','P06D2','Bezugsspannung Sensor E - offener Stromkreis','Kabelbaum','2022-05-11T11:16:22.390671Z',0),
  ('BPNL00000003COJN',0,'b80d780e-59fc-4e2c-80ed-75c5365c02c2','P06D3','Bezugsspannung Sensor E - Signal zu niedrig','Kabelbaum','2022-05-11T11:16:22.396716Z',0),
  ('BPNL00000003COJN',0,'7ae4f11c-3d02-4a9b-99bb-c622a535ba62','P06D4','Bezugsspannung Sensor E - Signal zu hoch','Kabelbaum','2022-05-11T11:16:22.401109Z',0),
  ('BPNL00000003COJN',0,'ea08b959-2bef-44f6-9d97-75593a71d2b7','P06D5','Bezugsspannung Sensor E - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum','2022-05-11T11:16:22.406291Z',0),
  ('BPNL00000003COJN',0,'18169df9-35a5-4288-b01a-23ba4809d655','P06D6','Bezugsspannung Sensor F - offener Stromkreis','Kabelbaum','2022-05-11T11:16:22.410634Z',0),
  ('BPNL00000003COJN',0,'50863dad-20d1-44ee-95a6-c3d718cb47c5','P06D7','Bezugsspannung Sensor F - Signal zu niedrig','Kabelbaum','2022-05-11T11:16:22.414766Z',0),
  ('BPNL00000003COJN',0,'f74aa0d5-ae92-4986-8979-8bee16cb9556','P06D8','Bezugsspannung Sensor F - Signal zu hoch','Kabelbaum','2022-05-11T11:16:22.418820Z',0),
  ('BPNL00000003COJN',0,'45f85c03-b4ee-44f4-99f9-df4ea4d39439','P06D9','Bezugsspannung Sensor F - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum','2022-05-11T11:16:22.422846Z',0),
  ('BPNL00000003COJN',0,'2f10f2b5-348a-4c4a-aa18-55d53346621d','P06DA','Motoröldruckregelung - offener Stromkreis','Kabelbaum','2022-05-11T11:16:22.427499Z',0),
  ('BPNL00000003COJN',0,'795524c4-d32d-40ae-8a05-1643c6df2f8d','P06DB','Motoröldruckregelung - Signal zu niedrig','Kabelbaum','2022-05-11T11:16:22.431421Z',0),
  ('BPNL00000003COJN',0,'991060f7-b533-43bd-9cb4-880127a884ab','P06DC','Motoröldruckregelung - Signal zu hoch','Kabelbaum','2022-05-11T11:16:22.435695Z',0),
  ('BPNL00000003COJN',0,'e5a3b41f-3b3d-4871-a18b-dde9d627dc8b','P06DD','Motoröldruckregelung - Funktionsfehler Stromkreis','Kabelbaum','2022-05-11T11:16:22.439832Z',0),
  ('BPNL00000003COJN',0,'af959693-38be-44a2-acb3-4010f43ca90c','P06DE','Motoröldruckregelung - Fehlfunktion Steuerstromkreis, Signal "EIN"','Kabelbaum','2022-05-11T11:16:22.443978Z',0),
  ('BPNL00000003COJN',0,'4f3f9a67-6907-48cc-b810-5e761ca6ff18','P06DF','Glühkerzen-Steuergerät - Speicher Prüfsummenfehler','-','2022-05-11T11:16:22.448689Z',0),
  ('BPNL00000003COJN',0,'5b54c42c-b166-4058-8fad-f57702657d8c','P06E0','Glühkerze, Zylinder 11 - Signal Steuerstromkreis zu niedrig','Kabelbaum, Glühkerze, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.452997Z',0),
  ('BPNL00000003COJN',0,'974c526d-5ce1-4a22-b412-7544ed55fa0a','P06E1','Glühkerze, Zylinder 11 - Signal Steuerstromkreis zu hoch','Kabelbaum, Glühkerze, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.457420Z',0),
  ('BPNL00000003COJN',0,'ed1e568d-df02-49c1-90f2-9e010969b6bf','P06E2','Glühkerze, Zylinder 12 - Signal Steuerstromkreis zu niedrig','Kabelbaum, Glühkerze, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.461662Z',0),
  ('BPNL00000003COJN',0,'c02445c8-08ee-4688-8e5c-08d4c547fd17','P06E3','Glühkerze, Zylinder 12 - Signal Steuerstromkreis zu hoch','Kabelbaum, Glühkerze, Glühkerzen-Steuergerät, Motorsteuergerät','2022-05-11T11:16:22.465977Z',0),
  ('BPNL00000003COJN',0,'f1b6c298-2365-4dff-bff7-d014b68ab876','P0700','Getrieberegelung, Anforderungssignal "Motorstörungswarnleuchte" - Fehlfunktion Stromkreis','Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.481913Z',0),
  ('BPNL00000003COJN',0,'f25649c7-844e-4c12-adba-a1793b20c579','P0701','Getrieberegelung - Bereichs-/Funktionsfehler','Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.486557Z',0),
  ('BPNL00000003COJN',0,'ea1535c4-1a50-46dd-89c3-ad13d57c5dc9','P0702','Getrieberegelung - elektrischer Teil','Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.491768Z',0),
  ('BPNL00000003COJN',0,'f45a299b-cd31-4fef-a0f9-f35faf131360','P0703','Bremsschalter B - Fehlfunktion Stromkreis','Kabelbaum, Bremsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.497245Z',0),
  ('BPNL00000003COJN',0,'8995a818-6702-445a-a1ee-7fd1cbe48066','P0704','Kupplungspedalschalter - Fehlfunktion Stromkreis','Kabelbaum, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.501975Z',0),
  ('BPNL00000003COJN',0,'eadea80c-ed0a-4810-8e74-42ca8f409721','P0705','Fahrstufensensor, Eingangssignale für Fahrstufen P/R/N/D/L - Fehlfunktion Stromkreis','Kabelbaum, Fahrstufensensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.506775Z',0),
  ('BPNL00000003COJN',0,'29a3f5b1-d0a0-477f-9177-168fb8ea69c9','P0706','Fahrstufensensor - Bereichs-/Funktionsfehler','Kabelbaum, Fahrstufensensor','2022-05-11T11:16:22.511292Z',0),
  ('BPNL00000003COJN',0,'73bc3468-b8ed-471e-802a-538859a16c77','P0707','Fahrstufensensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Fahrstufensensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.515469Z',0),
  ('BPNL00000003COJN',0,'2bf4b4e6-6f65-4ca8-92c5-e4a3b1e31300','P0708','Fahrstufensensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Fahrstufensensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.520035Z',0),
  ('BPNL00000003COJN',0,'3af355e7-387f-4cdd-afd0-aeb8be5161a9','P0709','Fahrstufensensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Fahrstufensensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.526365Z',0),
  ('BPNL00000003COJN',0,'33d78778-8f41-40a0-a31a-fbe96dd42da3','P070A','Getriebeölstandsensor - Fehlfunktion Stromkreis','Kabelbaum, Getriebeölstandsensor, Motorsteuergerät','2022-05-11T11:16:22.531226Z',0),
  ('BPNL00000003COJN',0,'c9c07810-f738-46b3-8e52-fe77c0e93311','P070B','Getriebeölstandsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Getriebeölstandsensor, Motorsteuergerät','2022-05-11T11:16:22.536007Z',0),
  ('BPNL00000003COJN',0,'45326e7e-9d2a-4b37-a6a2-44cda7a5aacc','P070C','Getriebeölstandsensor - Signal zu niedrig','Kabelbaum, Getriebeölstandsensor, Motorsteuergerät','2022-05-11T11:16:22.540610Z',0),
  ('BPNL00000003COJN',0,'1b958fce-2ad5-4dc7-820c-8431524755fe','P070D','Getriebeölstandsensor - Signal zu hoch','Kabelbaum, Getriebeölstandsensor, Motorsteuergerät','2022-05-11T11:16:22.545257Z',0),
  ('BPNL00000003COJN',0,'961c5fce-e231-450f-9b8c-6cd04c39ed3c','P070E','Getriebeölstandsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Getriebeölstandsensor, Motorsteuergerät','2022-05-11T11:16:22.549591Z',0),
  ('BPNL00000003COJN',0,'46010c46-c58a-44d4-8f1b-dd032c4e9d64','P070F','Getriebeölstand - zu niedrig','Getriebeölstand - zu niedrig','2022-05-11T11:16:22.553661Z',0),
  ('BPNL00000003COJN',0,'6119dc91-6b5c-4924-a426-a7e3ce7006c3','P0710','Getriebeöltemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Getriebeöltemperatursensor, Motorsteuergerät, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.557901Z',0),
  ('BPNL00000003COJN',0,'173c9be3-aa5e-45b9-8939-47033e8345f6','P0711','Getriebeöltemperatursensor - Bereichs-/Funktionsfehler','Kabelbaum, Getriebeöltemperatursensor','2022-05-11T11:16:22.565731Z',0),
  ('BPNL00000003COJN',0,'d5c2ab8c-8a50-460c-9c20-3e654d44d1ae','P0712','Getriebeöltemperatursensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.570066Z',0),
  ('BPNL00000003COJN',0,'a1115d3f-e329-40e8-aabc-23980e2672e3','P0713','Getriebeöltemperatursensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.574346Z',0),
  ('BPNL00000003COJN',0,'a80d2bf3-52fa-481b-ad60-a0a93e1fa60a','P0714','Getriebeöltemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.578732Z',0),
  ('BPNL00000003COJN',0,'b9b1febf-2098-4d6e-92a7-330c84cd5b8f','P0715','Turbinenwellen-Drehzahlsensor - Fehlfunktion Stromkreis','Kabelbaum, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.583368Z',0),
  ('BPNL00000003COJN',0,'633ae79d-9069-4721-9bed-b778b1ee2d4f','P0716','Turbinenwellen-Drehzahlsensor - Bereichs-/Funktionsfehler','Kabelbaum, Turbinenwellen-Drehzahlsensor','2022-05-11T11:16:22.588412Z',0),
  ('BPNL00000003COJN',0,'c03bb34a-252c-43da-acfe-1c080bd68632','P0717','Turbinenwellen-Drehzahlsensor - kein Signal','Kabelbaum, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.592669Z',0),
  ('BPNL00000003COJN',0,'e2dc893a-0c2d-4505-b4f6-51e3ab4740bf','P0718','Turbinenwellen-Drehzahlsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.596922Z',0),
  ('BPNL00000003COJN',0,'2fd24161-7c98-4304-8472-6708a620f826','P0719','Bremsschalter B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Bremsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.601031Z',0),
  ('BPNL00000003COJN',0,'9eee17f3-a7d2-4d56-97c1-b1337abbcec6','P071A','Getriebebetriebswählschalter A - Fehlfunktion Stromkreis','Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.605692Z',0),
  ('BPNL00000003COJN',0,'1a457084-14c6-4170-a648-18f1993d69e4','P071B','Getriebebetriebswählschalter A - Signal zu niedrig','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.609496Z',0),
  ('BPNL00000003COJN',0,'6b6ea30e-9893-46a4-8886-016be06b235a','P071C','Getriebebetriebswählschalter A - Signal zu hoch','Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.613512Z',0),
  ('BPNL00000003COJN',0,'49815f09-993c-4202-95bb-09cf60fd2253','P071D','Getriebebetriebswählschalter B - Fehlfunktion Stromkreis','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.617896Z',0),
  ('BPNL00000003COJN',0,'4adad985-9dd3-47a1-90a3-69a03bb79e73','P071E','Getriebebetriebswählschalter B - Signal zu niedrig','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.622173Z',0),
  ('BPNL00000003COJN',0,'2e641b22-2986-42de-9843-56aa31520e71','P071F','Getriebebetriebswählschalter B - Signal zu hoch','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät','2022-05-11T11:16:22.626219Z',0),
  ('BPNL00000003COJN',0,'6e51b814-fea0-42b1-a196-7e8da38a8a65','P0720','Ausgangswellen-Drehzahlsensor - Fehlfunktion Stromkreis','Kabelbaum, Fahrgeschwindigkeitssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.631046Z',0),
  ('BPNL00000003COJN',0,'a64d013e-30fa-488e-9cec-29a06ab148df','P0721','Ausgangswellen-Drehzahlsensor - Bereichs-/Funktionsfehler','Kabelbaum, Fahrgeschwindigkeitssensor','2022-05-11T11:16:22.635543Z',0),
  ('BPNL00000003COJN',0,'830b2ca0-66d9-4e7f-8c8e-8686844f507e','P0722','Ausgangswellen-Drehzahlsensor - kein Signal','Kabelbaum, Fahrgeschwindigkeitssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.639872Z',0),
  ('BPNL00000003COJN',0,'493b79ce-484f-452a-b8d3-02fe822345b7','P0723','Ausgangswellen-Drehzahlsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Fahrgeschwindigkeitssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.644021Z',0),
  ('BPNL00000003COJN',0,'7f85cc14-2563-407f-8034-d97f850eae55','P0724','Bremsschalter B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Bremsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.648219Z',0),
  ('BPNL00000003COJN',0,'4d79afee-21e4-40fa-9440-7f340fdec140','P0725','Eingangssignal Motordrehzahl - Fehlfunktion Stromkreis','Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.654758Z',0),
  ('BPNL00000003COJN',0,'9ec75aed-68df-4e2d-a3b0-5f4936fdc877','P0726','Eingangssignal Motordrehzahl - Bereichs-/Funktionsfehler','Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor','2022-05-11T11:16:22.658709Z',0),
  ('BPNL00000003COJN',0,'fca33ef7-9085-4936-9f58-14fab5e3738d','P0727','Eingangssignal Motordrehzahl - kein Signal','Kabelbaum, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.663006Z',0),
  ('BPNL00000003COJN',0,'e6b87474-e912-4e9a-8f74-1eb2dc9959c4','P0728','Eingangssignal Motordrehzahl - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kurbelwinkelsensor/Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.667150Z',0),
  ('BPNL00000003COJN',0,'c22b217d-2240-4a41-8d31-de1121b59808','P0729','Gang 6 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.671407Z',0),
  ('BPNL00000003COJN',0,'4325c7c7-5007-485f-88d9-f36a62b19152','P072A','Getriebe - klemmt in Neutralstellung','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.675775Z',0),
  ('BPNL00000003COJN',0,'89f35742-5cc0-4e91-92f1-105f948be2c7','P072B','Getriebe - klemmt im RW-Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.679840Z',0),
  ('BPNL00000003COJN',0,'1b573bf3-c769-49cd-9df0-09ddc170439a','P072C','Getriebe - klemmt im 1. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.683974Z',0),
  ('BPNL00000003COJN',0,'3ea33d40-3c2e-4512-9a1b-d3b32314f1bc','P072D','Getriebe - klemmt im 2. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.689504Z',0),
  ('BPNL00000003COJN',0,'f109c73b-2c91-4323-ab54-6372f541e0fc','P072E','Getriebe - klemmt im 3. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.693917Z',0),
  ('BPNL00000003COJN',0,'b8d76668-c650-4561-a557-f70e8fca0f21','P072F','Getriebe - klemmt im 4. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.699616Z',0),
  ('BPNL00000003COJN',0,'ea2011d2-8bce-41c1-8de8-f326559cd956','P0730','Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.703734Z',0),
  ('BPNL00000003COJN',0,'04b30e64-d630-48c2-93f2-8492a5845658','P0731','Gang 1 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.708341Z',0),
  ('BPNL00000003COJN',0,'4d26670f-5de4-4bfe-b35e-972ff577b6f7','P0732','Gang 2 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.712802Z',0),
  ('BPNL00000003COJN',0,'4dd152a9-322a-4da7-939f-00e38c8e2084','P0733','Gang 3 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.717586Z',0),
  ('BPNL00000003COJN',0,'a49d2adb-b686-4adc-bdcc-71a63bfc8cf8','P0734','Gang 4 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.729712Z',0),
  ('BPNL00000003COJN',0,'598ab1bd-5868-4ead-bd3d-14ad56c48198','P0735','Gang 5 - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.739773Z',0),
  ('BPNL00000003COJN',0,'32b4b422-ce1a-457e-9ede-6213484de156','P0736','Rückwärtsgang - Übersetzungsverhältnis falsch','Kabelbaum, Fahrstufensensor/-schalter, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:22.745124Z',0),
  ('BPNL00000003COJN',0,'372b777d-66a9-4764-af8f-9c01521ac346','P0737','Motordrehzahl Getriebesteuergerät - Ausgangsstromkreis','Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:22.749885Z',0),
  ('BPNL00000003COJN',0,'50922382-23a4-4b7e-a794-0857d1043cad','P0738','Motordrehzahl Getriebesteuergerät - Signal Ausgangsstromkreis zu niedrig','Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:22.755019Z',0),
  ('BPNL00000003COJN',0,'cc75c485-c197-43f0-b9b2-b770b8fa46e0','P0739','Motordrehzahl Getriebesteuergerät - Signal Ausgangsstromkreis zu hoch','Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:22.759532Z',0),
  ('BPNL00000003COJN',0,'b50e502e-1c77-4962-8528-8a45c3d8504e','P073A','Getriebe - klemmt im 5. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.764301Z',0),
  ('BPNL00000003COJN',0,'337ace09-31c0-4ec4-9d16-904d85a8f3b6','P073B','Getriebe - klemmt im 6. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.769035Z',0),
  ('BPNL00000003COJN',0,'f95d91f1-c59e-4dc6-8c64-90bec8a665b8','P073C','Getriebe - klemmt im 7. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.773492Z',0),
  ('BPNL00000003COJN',0,'603a28f6-6ba6-44e9-a4ae-e671b8cc981d','P073D','Getriebe - schaltet nicht in Neutralstellung','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.777620Z',0),
  ('BPNL00000003COJN',0,'984c62a5-4947-44d3-8f85-d8cf8e98a8ea','P073E','Getriebe - schaltet nicht in den RW-Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.787178Z',0),
  ('BPNL00000003COJN',0,'b12e03ab-bc9c-47f4-837e-cadbc9fc46d1','P073F','Getriebe - schaltet nicht in den 1. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.791903Z',0),
  ('BPNL00000003COJN',0,'b64efc3c-5072-4d05-b361-f0d3bff91256','P0740','Wandlerüberbrückungskupplung-Magnetventil - Fehlfunktion Stromkreis','Kabelbaum, Wandlerüberbrückungskupplung-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.796206Z',0),
  ('BPNL00000003COJN',0,'f074e975-c1c8-42c6-845b-6c475e91fa0d','P0741','Wandlerüberbrückungskupplung-Magnetventil - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Wandlerüberbrückungskupplung-Magnetventil','2022-05-11T11:16:22.800262Z',0),
  ('BPNL00000003COJN',0,'7be3847e-e320-46d6-8f28-95e98de32130','P0742','Wandlerüberbrückungskupplung-Magnetventil - ständig aktiviert','Kabelbaum, Wandlerüberbrückungskupplung-Magnetventil','2022-05-11T11:16:22.804845Z',0),
  ('BPNL00000003COJN',0,'cef5e7e7-5f52-4897-ba91-52a173661d5b','P0743','Wandlerüberbrückungskupplung-Magnetventil - elektrischer Teil','Kabelbaum, Wandlerüberbrückungskupplung-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.812021Z',0),
  ('BPNL00000003COJN',0,'8a189399-f6fa-4039-98ef-5cbd886b3c58','P0744','Wandlerüberbrückungskupplung-Magnetventil - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Wandlerüberbrückungskupplung-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.816263Z',0),
  ('BPNL00000003COJN',0,'d8f6aea1-83d0-4cb9-af14-fa55208e68c6','P0745','Getriebeöldruck-Magnetventil - Fehlfunktion Stromkreis','Kabelbaum, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.821653Z',0),
  ('BPNL00000003COJN',0,'a5d13afc-4e57-49ce-a898-a8bdc0208474','P0746','Getriebeöldruck-Magnetventil - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Getriebeöldruck-Magnetventil','2022-05-11T11:16:22.830145Z',0),
  ('BPNL00000003COJN',0,'e7a9bbdd-25eb-4dfa-adad-436abbad4e6e','P0747','Getriebeöldruck-Magnetventil - ständig aktiviert','Kabelbaum, Getriebeöldruck-Magnetventil','2022-05-11T11:16:22.836531Z',0),
  ('BPNL00000003COJN',0,'82da1a1c-5707-488c-ad9c-8a84762ade54','P0748','Getriebeöldruck-Magnetventil - elektrischer Teil','Kabelbaum, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.840833Z',0),
  ('BPNL00000003COJN',0,'502a60d5-ff9f-4b23-b0df-80cb8012485a','P0749','Getriebeöldruck-Magnetventil - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.848901Z',0),
  ('BPNL00000003COJN',0,'34d6c79a-76dc-4a0e-8965-86104e0e205e','P074A','Getriebe - schaltet nicht in den 2. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.853915Z',0),
  ('BPNL00000003COJN',0,'4f9b2142-2e93-4513-994d-568e16336007','P074B','Getriebe - schaltet nicht in den 3. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.859196Z',0),
  ('BPNL00000003COJN',0,'35d7c540-963b-4e0e-bd06-de7af8861ed9','P074C','Getriebe - schaltet nicht in den 4. Gang','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.865966Z',0),
  ('BPNL00000003COJN',0,'a79f06d3-11f6-49d9-97a9-719c4d3259e1','P074D','Getriebe - schaltet nicht in den 5. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.870739Z',0),
  ('BPNL00000003COJN',0,'b078d351-b9ed-41c0-b643-6b3e8b9cb49d','P074E','Getriebe - schaltet nicht in den 6. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.875104Z',0),
  ('BPNL00000003COJN',0,'3054a99d-0139-4c70-9d5b-5de9f26a0edc','P074F','Getriebe - schaltet nicht in den 7. Gang','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.879704Z',0),
  ('BPNL00000003COJN',0,'fb90d79d-bd84-420c-9dee-e6e995b4f37b','P0750','Fahrbereich-Magnetventil A - Fehlfunktion Stromkreis','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.883734Z',0),
  ('BPNL00000003COJN',0,'c00e93e8-94f5-4502-98dc-df02bd19ab66','P0751','Fahrbereich-Magnetventil A - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.887994Z',0),
  ('BPNL00000003COJN',0,'20091f72-0d3c-49fa-8e42-7749b6bc3f43','P0752','Fahrbereich-Magnetventil A - ständig aktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.892448Z',0),
  ('BPNL00000003COJN',0,'4ee771f5-bb60-49a3-8efe-2a5f34bd7aae','P0753','Fahrbereich-Magnetventil A - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.899690Z',0),
  ('BPNL00000003COJN',0,'485525f2-e579-43af-a403-d167bfdec824','P0754','Fahrbereich-Magnetventil A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.904266Z',0),
  ('BPNL00000003COJN',0,'d388538e-595a-4472-bab0-213ef34f3b56','P0755','Fahrbereich-Magnetventil B - Fehlfunktion Stromkreis','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.908757Z',0),
  ('BPNL00000003COJN',0,'70ac501d-97d1-4bb2-8874-c98e805ca5b9','P0756','Fahrbereich-Magnetventil B - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.913521Z',0),
  ('BPNL00000003COJN',0,'dbf0754e-0464-4977-bab3-28a4514774bc','P0757','Fahrbereich-Magnetventil B - ständig aktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.918153Z',0),
  ('BPNL00000003COJN',0,'48f2a228-18ec-4dfd-952a-bb26068a14e3','P0758','Fahrbereich-Magnetventil B - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.922702Z',0),
  ('BPNL00000003COJN',0,'464a4b62-b1e1-4618-ac95-26b78b0843b2','P0759','Fahrbereich-Magnetventil B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.927115Z',0),
  ('BPNL00000003COJN',0,'ef0d63b4-ad7c-4052-be4a-9904bd871cec','P075A','Fahrbereich-Magnetventil G - Fehlfunktion','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Motorsteuergerät','2022-05-11T11:16:22.931598Z',0),
  ('BPNL00000003COJN',0,'4f22c5a6-5e3c-44dc-8210-4f911ceef5de','P075B','Fahrbereich-Magnetventil G - beeinträchtigte Funktion oder ständig deaktiviert','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.935700Z',0),
  ('BPNL00000003COJN',0,'67789930-dc9d-464a-a6be-34b7c770b0bf','P075C','Fahrbereich-Magnetventil G - Magnetventil ständig aktiviert','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Motorsteuergerät','2022-05-11T11:16:22.940432Z',0),
  ('BPNL00000003COJN',0,'c819ad75-4ce6-4441-afc0-f66d6e45a882','P075D','Fahrbereich-Magnetventil G - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.945958Z',0),
  ('BPNL00000003COJN',0,'414940fc-30e6-408c-b052-aa1ee5a05adf','P075E','Fahrbereich-Magnetventil G - zeitweilig unterbrochener Betrieb','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:22.950357Z',0),
  ('BPNL00000003COJN',0,'d25f77d3-e50b-4b9c-b08e-961b22f982fe','P075F','Getriebeölstand - zu hoch','Getriebeölstand - zu hoch','2022-05-11T11:16:22.954364Z',0),
  ('BPNL00000003COJN',0,'4187223b-9fa7-4b16-85a9-eb7c89943516','P0760','Fahrbereich-Magnetventil C - Fehlfunktion Stromkreis','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.964619Z',0),
  ('BPNL00000003COJN',0,'3da94c49-6c3b-4996-8a1a-49ecfce4e350','P0761','Fahrbereich-Magnetventil C - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.969543Z',0),
  ('BPNL00000003COJN',0,'ccdbfff4-789d-4eea-a833-03f46ed64db3','P0762','Fahrbereich-Magnetventil C - ständig aktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.974285Z',0),
  ('BPNL00000003COJN',0,'a4752f2a-3d7c-48e7-9a12-ade61a29d2c0','P0763','Fahrbereich-Magnetventil C - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.980130Z',0),
  ('BPNL00000003COJN',0,'1e983974-d1a4-45d6-9c4d-e2463b2a1b65','P0764','Fahrbereich-Magnetventil C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.984765Z',0),
  ('BPNL00000003COJN',0,'5c46cc2b-3148-44fe-9e6f-a1a7651cb844','P0765','Fahrbereich-Magnetventil D - Fehlfunktion Stromkreis','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:22.989411Z',0),
  ('BPNL00000003COJN',0,'2c23908c-d247-4f15-884f-5f8cceae1e15','P0766','Fahrbereich-Magnetventil D - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.993974Z',0),
  ('BPNL00000003COJN',0,'cf8a42b2-38dc-4357-ad35-9c709755fddb','P0767','Fahrbereich-Magnetventil D - ständig aktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:22.998836Z',0),
  ('BPNL00000003COJN',0,'1c7b703c-0407-4405-a30d-d42d21775926','P0768','Fahrbereich-Magnetventil D - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.003108Z',0),
  ('BPNL00000003COJN',0,'d2aacee4-8066-4ee0-bb6c-5db2c4a4a6d9','P0769','Fahrbereich-Magnetventil D - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.007329Z',0),
  ('BPNL00000003COJN',0,'7d64338b-758b-42d2-a008-4c600d19c0c8','P076A','Fahrbereich-Magnetventil H - Fehlfunktion','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.011853Z',0),
  ('BPNL00000003COJN',0,'3d7166d4-786d-4330-bb41-f16078950557','P076B','Fahrbereich-Magnetventil H - beeinträchtigte Funktion oder ständig deaktiviert','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.016067Z',0),
  ('BPNL00000003COJN',0,'3f2e7131-8ab1-4ab2-8eea-f3da09f62c4c','P076C','Fahrbereich-Magnetventil H - Magnetventil ständig aktiviert','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.020468Z',0),
  ('BPNL00000003COJN',0,'529c17d4-ab61-4d5a-91fa-193f724b6c61','P076D','Fahrbereich-Magnetventil H - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.024985Z',0),
  ('BPNL00000003COJN',0,'f0748278-126d-4ecd-8b0d-d8d34f86a393','P076E','Fahrbereich-Magnetventil H - zeitweilig unterbrochener Betrieb','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.029389Z',0),
  ('BPNL00000003COJN',0,'2edcd87e-740b-4cf9-883e-15ee1c7fbb9c','P076F','Getriebe - unzulässiges Übersetzungsverhältnis im 7. Gang','Mechanische Fehlfunktion Getriebe, Fahrgeschwindigkeitssensor, unzulässige Reifengröße','2022-05-11T11:16:23.034479Z',0),
  ('BPNL00000003COJN',0,'649a125a-7384-43d1-bfd6-ccaf403aa863','P0770','Fahrbereich-Magnetventil E - Fehlfunktion Stromkreis','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.038849Z',0),
  ('BPNL00000003COJN',0,'377c410e-9063-474f-8ab0-83a19069bf72','P0771','Fahrbereich-Magnetventil E - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:23.043863Z',0),
  ('BPNL00000003COJN',0,'5e6a31f0-c6e1-4461-9e73-142b070256f3','P0772','Fahrbereich-Magnetventil E - ständig aktiviert','Kabelbaum, Fahrbereich-Magnetventil','2022-05-11T11:16:23.047997Z',0),
  ('BPNL00000003COJN',0,'25a11a89-0068-428e-bcb8-354b2662cbb7','P0773','Fahrbereich-Magnetventil E - elektrischer Teil','Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.052423Z',0),
  ('BPNL00000003COJN',0,'69725f4d-3e72-40b7-97b9-785461dac2a5','P0774','Fahrbereich-Magnetventil E - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.057824Z',0),
  ('BPNL00000003COJN',0,'efc19fa2-7d28-48e1-a7cb-0885026114b9','P0775','Druckregel-Magnetventil B - Fehlfunktion','Druckregel-Magnetventil','2022-05-11T11:16:23.067805Z',0),
  ('BPNL00000003COJN',0,'312b9182-c2c2-4c32-932d-ed76ba276b19','P0776','Druckregel-Magnetventil B - Fehlfunktion oder ständig deaktiviert','Kabelbaum, Druckregel-Magnetventil','2022-05-11T11:16:23.072311Z',0),
  ('BPNL00000003COJN',0,'56dc6715-b46c-444d-a8b2-7aff50de30c1','P0777','Druckregel-Magnetventil B - ständig aktiviert','Kabelbaum, Druckregel-Magnetventil','2022-05-11T11:16:23.076954Z',0),
  ('BPNL00000003COJN',0,'49b2c97a-6938-4794-8f4c-d74d6d780b6e','P0778','Druckregel-Magnetventil B - elektrische Fehlfunktion','Kabelbaum, Druckregel-Magnetventil','2022-05-11T11:16:23.081369Z',0),
  ('BPNL00000003COJN',0,'23b5329c-ec96-4b0e-89d6-def96b866ad9','P0779','Druckregel-Magnetventil B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil','2022-05-11T11:16:23.086028Z',0),
  ('BPNL00000003COJN',0,'95975698-e578-4f21-a2e2-3cfc4ed8c314','P077A','Ausgangsdrehzahlsensor - Signalverlust Drehsinn','-','2022-05-11T11:16:23.091415Z',0),
  ('BPNL00000003COJN',0,'dd099f32-337c-40b8-b153-310292aaf8d8','P077B','Ausgangsdrehzahlsensor - Drehsinnfehler','-','2022-05-11T11:16:23.102278Z',0),
  ('BPNL00000003COJN',0,'2faff758-21b8-4457-96df-4b623cb48ae1','P077C','Ausgangsdrehzahlsensor - Signal zu niedrig','Kabelbaum, Ausgangsdrehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.106857Z',0),
  ('BPNL00000003COJN',0,'4b53913f-367c-4cbb-9f3d-7699e723197b','P077D','Ausgangsdrehzahlsensor - Signal zu hoch','Kabelbaum, Ausgangsdrehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.111424Z',0),
  ('BPNL00000003COJN',0,'6bffd0be-06e1-4d7a-bea2-32cc84e31b67','P077E','Getriebeöltemperaturmesssystem - Bezugsfehler mehrere Sensoren','Kabelbaum, Getriebeöltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.115459Z',0),
  ('BPNL00000003COJN',0,'1a8c0c67-b634-4ed2-bd82-94e46f222205','P077F','Rückwärtsgang 2 - Übersetzungsverhältnis falsch','-','2022-05-11T11:16:23.119784Z',0),
  ('BPNL00000003COJN',0,'648f9035-02fa-4ed1-a63a-6253e56b205a','P0780','Gangwahl - fehlerhafter Gangwechsel','Kabelbaum, Fahrstufensensor, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:23.124576Z',0),
  ('BPNL00000003COJN',0,'911e630d-93b9-4d5b-87b8-9b73c5eb7319','P0781','Gangwahl, 1-2 - fehlerhafter Gangwechsel','Kabelbaum, Fahrstufensensor, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:23.129264Z',0),
  ('BPNL00000003COJN',0,'9f21ff3c-cbfe-4551-8d0b-6f7788a29bd4','P0782','Gangwahl, 2-3 - fehlerhafter Gangwechsel','Kabelbaum, Fahrstufensensor, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:23.134138Z',0),
  ('BPNL00000003COJN',0,'0c8b89e8-085a-4cca-a350-31655edf4267','P0783','Gangwahl, 3-4 - fehlerhafter Gangwechsel','Kabelbaum, Fahrstufensensor, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:23.142442Z',0),
  ('BPNL00000003COJN',0,'b3ac30bd-2394-4347-be82-06dcfd3f6ed8','P0784','Gangwahl, 4-5 - fehlerhafter Gangwechsel','Kabelbaum, Fahrstufensensor, Fahrbereich-Magnetventile, mechanische Getriebestörung','2022-05-11T11:16:23.147227Z',0),
  ('BPNL00000003COJN',0,'91427b86-ebee-4844-8f83-6e0f4200cc50','P0785','Schaltzeitpunkt-Magnetventil - Fehlfunktion Stromkreis','Kabelbaum, Schaltzeitpunkt-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.151746Z',0),
  ('BPNL00000003COJN',0,'1b356bf3-34e1-4685-851b-e4e90f443c55','P0786','Schaltzeitpunkt-Magnetventil - Bereichs-/Funktionsfehler','Kabelbaum, Schaltzeitpunkt-Magnetventil','2022-05-11T11:16:23.159678Z',0),
  ('BPNL00000003COJN',0,'b8f5a2fc-017a-43db-9f7b-ca18305e146d','P0787','Schaltzeitpunkt-Magnetventil - zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltzeitpunkt-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.164100Z',0),
  ('BPNL00000003COJN',0,'8db647a8-f0d1-4f8a-b21c-913ec69f05e8','P0788','Schaltzeitpunkt-Magnetventil - zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltzeitpunkt-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.168818Z',0),
  ('BPNL00000003COJN',0,'a08816a0-ba07-43e7-b21e-21415c59a0a4','P0789','Schaltzeitpunkt-Magnetventil - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schaltzeitpunkt-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.173300Z',0),
  ('BPNL00000003COJN',0,'e780b6ee-bf84-4374-b44b-bc27aa6b4ae4','P078A','Fahrbereich-Magnetventil, Zündzeitpunkt B - Fehlfunktion','Kabelbaum, Schaltmagnetventil, mechanische Getriebestörung, Motorsteuergerät','2022-05-11T11:16:23.177686Z',0),
  ('BPNL00000003COJN',0,'7611781c-f9b2-4d17-b716-2ffe31867898','P078B','Fahrbereich-Magnetventil B - Bereichs-/Funktionsfehler','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.182311Z',0),
  ('BPNL00000003COJN',0,'3cebeb6d-1344-46b0-a866-204290ac85cc','P078C','Fahrbereich-Magnetventil B, Schaltzeiten - Signal zu niedrig','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.187194Z',0),
  ('BPNL00000003COJN',0,'0e1779e1-40cb-4090-80d3-cb825ca4ad98','P078D','Fahrbereich-Magnetventil, Zündzeitpunkt B - Signal zu hoch','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.192067Z',0),
  ('BPNL00000003COJN',0,'bb0edc50-a715-433f-8248-9f71162c396c','P078E','Fahrbereich-Magnetventil B - zeitweilig unterbrochener Betrieb','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.201685Z',0),
  ('BPNL00000003COJN',0,'3afc10b0-4bb0-47a2-b528-a0d487c5dcf8','P078F','Getriebebetriebswählschalter C - Fehlfunktion Stromkreis','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.206163Z',0),
  ('BPNL00000003COJN',0,'9dce47a7-473f-4311-babc-06742d6058ea','P0790','Getriebebetriebswählschalter - Fehlfunktion Stromkreis','Kabelbaum, Getriebebetriebswählschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.211100Z',0),
  ('BPNL00000003COJN',0,'035d47e1-d9a7-43b3-97a6-5091c23f7a08','P0791','Getriebezwischenwellen-Drehzahlsensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.226664Z',0),
  ('BPNL00000003COJN',0,'63a2671d-4376-4067-8dbf-4a51b679e48c','P0792','Getriebezwischenwellen-Drehzahlsensor - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.232805Z',0),
  ('BPNL00000003COJN',0,'da2693f6-b411-4432-80e0-79db42be0bdc','P0793','Getriebezwischenwellen-Drehzahlsensor - kein Signal','Kabelbaum, schlechte Kontaktierung, Kurzschluss an Masse, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.237345Z',0),
  ('BPNL00000003COJN',0,'8bc4d9b3-6d68-4be7-a3e8-5ce3935a3fb5','P0794','Getriebezwischenwellen-Drehzahlsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.241757Z',0),
  ('BPNL00000003COJN',0,'b1d0a145-ffac-4005-a0c8-31183c66aa9d','P0795','Getriebeöldruck-Magnetventil C - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.246226Z',0),
  ('BPNL00000003COJN',0,'360689db-6fd7-489a-a7ca-5f43fae14e6f','P0796','Getriebeöldruck-Magnetventil C - Fehlfunktion oder ständig deaktiviert','Kabelbaum, schlechte Kontaktierung, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.250267Z',0),
  ('BPNL00000003COJN',0,'5d9615c4-c873-4aa0-9098-dc75ba18d2e3','P0797','Getriebeöldruck-Magnetventil C - ständig aktiviert','Kabelbaum, schlechte Kontaktierung, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.257510Z',0),
  ('BPNL00000003COJN',0,'245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d','P0798','Getriebeöldruck-Magnetventil C - elektrische Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Getriebeöldruck-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.263798Z',0),
  ('BPNL00000003COJN',0,'4edbdade-e1fe-4ddb-b020-7005c42fc6d3','P0799','Getriebeöldruck-Magnetventil C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.270998Z',0),
  ('BPNL00000003COJN',0,'18e05c7c-7625-46be-bbb4-73910690a1af','P07A3','Getriebereibelement A - ständig aktiviert','-','2022-05-11T11:16:23.323348Z',0),
  ('BPNL00000003COJN',0,'19702e99-d697-4f7d-86cd-583783227f14','P07A4','Getriebereibelement B - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.330261Z',0),
  ('BPNL00000003COJN',0,'7a743afd-e10b-4c6a-9d11-cb7fafecedc6','P07A5','Getriebereibelement B - ständig aktiviert','-','2022-05-11T11:16:23.334466Z',0),
  ('BPNL00000003COJN',0,'0b01295a-e41f-48d7-a683-13e9f83e206a','P07A6','Getriebereibelement C - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.343154Z',0),
  ('BPNL00000003COJN',0,'d7a3238f-3250-4dd3-84b0-9fe2334d43f7','P07A7','Getriebereibelement C - ständig aktiviert','-','2022-05-11T11:16:23.347725Z',0),
  ('BPNL00000003COJN',0,'88b6b33e-f83a-429d-9f96-367e9a9ed857','P07A8','Getriebereibelement D - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.351943Z',0),
  ('BPNL00000003COJN',0,'ce857396-eee0-4e4b-865b-66adee70d526','P07A9','Getriebereibelement D - ständig aktiviert','-','2022-05-11T11:16:23.356540Z',0),
  ('BPNL00000003COJN',0,'d8ab5304-cc9c-4d0f-bca8-d42f8185d9d4','P07AA','Getriebereibelement E - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.371840Z',0),
  ('BPNL00000003COJN',0,'2567de9d-519a-4aaa-a00c-3b3f9d451837','P07AB','Getriebereibelement E - ständig aktiviert','-','2022-05-11T11:16:23.392002Z',0),
  ('BPNL00000003COJN',0,'5c23129d-4292-4089-9588-b858a4e702b4','P07AC','Getriebereibelement F - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.396801Z',0),
  ('BPNL00000003COJN',0,'98c312a3-e166-48f4-8c5c-319ff3681152','P07AD','Getriebereibelement F - ständig aktiviert','-','2022-05-11T11:16:23.401764Z',0),
  ('BPNL00000003COJN',0,'d434462c-a69d-4fb5-b1d4-c45d90c95c75','P07AE','Getriebereibelement G - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.405764Z',0),
  ('BPNL00000003COJN',0,'2af42aea-09ae-4d3d-8e0e-33861a82525f','P07AF','Getriebereibelement G - ständig aktiviert','-','2022-05-11T11:16:23.410446Z',0),
  ('BPNL00000003COJN',0,'6495db32-3b0c-43f8-bf9e-51a4f1a03e9e','P07B0','Getriebereibelement H - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:23.414958Z',0),
  ('BPNL00000003COJN',0,'6aa332fc-0cbe-4683-9810-ca9a06a54152','P07B1','Getriebereibelement H - ständig aktiviert','-','2022-05-11T11:16:23.419703Z',0),
  ('BPNL00000003COJN',0,'c2fb9b96-a724-4030-b52e-ebb4c22f8f19','P07B2','Getriebe-Parkstellungssensor/-schalter A - offener Stromkreis','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.424023Z',0),
  ('BPNL00000003COJN',0,'dd20f521-4a59-45a4-bbfb-024d16ca9006','P07B3','Getriebe-Parkstellungssensor/-schalter A - Signal zu niedrig','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.435604Z',0),
  ('BPNL00000003COJN',0,'ad753904-5447-4994-b8bf-1bd9814c57ae','P07B4','Getriebe-Parkstellungssensor/-schalter A - Signal zu hoch','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.439665Z',0),
  ('BPNL00000003COJN',0,'7ae2c94c-db7b-4fb8-b3eb-a98aef296210','P07B5','Getriebe-Parkstellungssensor/-schalter A - Signal zu niedrig/Funktionsfehler Stromkreis','Kabelbaum, Getriebegangstellungsschalter','2022-05-11T11:16:23.443689Z',0),
  ('BPNL00000003COJN',0,'65e1c1e6-4374-4947-b267-1cc4bfc30763','P07B6','Getriebe-Parkstellungssensor/-schalter A - Signal zu hoch/Funktionsfehler Stromkreis','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.447574Z',0),
  ('BPNL00000003COJN',0,'9309df50-cb8e-43b8-b373-e939f2f26059','P07B7','Getriebe-Parkstellungssensor/-schalter A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.451880Z',0),
  ('BPNL00000003COJN',0,'64a1e346-c2b8-401f-aaf2-21cfaae1db9a','P07B8','Getriebe-Parkstellungssensor/-schalter B - offener Stromkreis','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.455799Z',0),
  ('BPNL00000003COJN',0,'47b32e19-c0a1-4412-af70-2880b90f8302','P07B9','Getriebe-Parkstellungssensor/-schalter B - Signal zu niedrig','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.459951Z',0),
  ('BPNL00000003COJN',0,'6ea8fb81-f6f4-420b-ab1d-cc88779fd893','P07BA','Getriebe-Parkstellungssensor/-schalter B - Signal zu hoch','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.465320Z',0),
  ('BPNL00000003COJN',0,'6d857d29-b563-47e7-80c3-dd21783d9a6b','P07BB','Getriebe-Parkstellungssensor/-schalter B - Signal zu niedrig/Funktionsfehler Stromkreis','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.469442Z',0),
  ('BPNL00000003COJN',0,'769e3b03-c5bf-4e65-90ea-6680505b8d8b','P07BC','Getriebe-Parkstellungssensor/-schalter B - Signal zu hoch/Funktionsfehler Stromkreis','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.473189Z',0),
  ('BPNL00000003COJN',0,'1857727e-7930-4781-93b0-8ed4f8b5661a','P07BD','Getriebe-Parkstellungssensor/-schalter B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.477188Z',0),
  ('BPNL00000003COJN',0,'36e5147b-bf76-4966-9817-3e84cc58f46d','P07BE','Getriebe-Parkstellungssensor/-schalter A/B - Bezugsfehler','Kabelbaum, Getriebe-Parkstellungssensor/-schalter','2022-05-11T11:16:23.481154Z',0),
  ('BPNL00000003COJN',0,'6c3c97ba-f4b1-4d2d-bc8b-0c1ee2a91349','P07BF','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor A - Signal zu niedrig','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.485224Z',0),
  ('BPNL00000003COJN',0,'0285ef37-6aec-47e9-9669-7ac413fd53fc','P07C0','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor A - Signal zu hoch','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.489368Z',0),
  ('BPNL00000003COJN',0,'c77ff9e9-6e3a-43dc-a704-f8477dfdd934','P07C1','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor B - Signal zu niedrig','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.493268Z',0),
  ('BPNL00000003COJN',0,'95d2ddc2-0d75-419b-928a-fe7526e43a1b','P07C2','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor B - Signal zu hoch','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.497349Z',0),
  ('BPNL00000003COJN',0,'829a238f-68d2-4181-93a1-9769d54170f5','P07C3','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor C - Signal zu niedrig','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.501449Z',0),
  ('BPNL00000003COJN',0,'732fc5ce-e3d9-4c68-a6cc-909d03ea6a82','P07C4','Eingangswellen-Drehzahlsensor/Turbinenwellen-Drehzahlsensor C - Signal zu hoch','Kabelbaum, Eingangswellen-Drehzahlsensor, Turbinenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.506069Z',0),
  ('BPNL00000003COJN',0,'409790bb-85f4-43bf-9da9-b3832b4460a7','P07C5','Getriebezwischenwellen-Drehzahlsensor A - Signal zu niedrig','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.510110Z',0),
  ('BPNL00000003COJN',0,'b75be035-fc73-467e-acd4-256366f7099e','P07C6','Getriebezwischenwellen-Drehzahlsensor A - Signal zu hoch','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.514357Z',0),
  ('BPNL00000003COJN',0,'fde5fd7b-0286-4c0e-bfff-50f2dfdf486a','P07C7','Getriebezwischenwellen-Drehzahlsensor B - Signal zu niedrig','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.518760Z',0),
  ('BPNL00000003COJN',0,'6a7c8351-3cf9-4829-8be7-82af1d45c3bc','P07C8','Getriebezwischenwellen-Drehzahlsensor B - Signal zu hoch','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.522706Z',0),
  ('BPNL00000003COJN',0,'3bb8a192-bb3b-476d-a90c-c8a810cad110','P07C9','Getriebezwischenwellen-Drehzahlsensor C - Signal zu niedrig','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.527085Z',0),
  ('BPNL00000003COJN',0,'64497acc-a0a7-494b-b951-2e4ecdca18ef','P07CA','Getriebezwischenwellen-Drehzahlsensor C - Signal zu hoch','Kabelbaum, Zwischenwellen-Drehzahlsensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.531483Z',0),
  ('BPNL00000003COJN',0,'7f11548d-b3d1-420d-bbdb-fbda14c2dc5c','P07CB','Getriebeölthermostat - beeinträchtigte Funktion','Kabelbaum, Getriebeölthermostat, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.536336Z',0),
  ('BPNL00000003COJN',0,'898c7264-ce00-4cc1-aed1-f402c7a6c8cf','P0800','Verteilergetriebe-Regelsystem, Anforderungssignal "Motorstörungswarnleuchte" - Fehlfunktion Stromkreis','Kabelbaum, mechanische Fehlfunktion','2022-05-11T11:16:23.540573Z',0),
  ('BPNL00000003COJN',0,'e5b5c041-d418-49b6-8535-d6e246fbf395','P0801','Stromkreis Rückwärtsgangssperre - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung','2022-05-11T11:16:23.544994Z',0),
  ('BPNL00000003COJN',0,'c0bf192e-0fb2-492d-8da6-9442dc580dcc','P0802','Getrieberegelung, Anforderungssignal "Motorstörungswarnleuchte" - offener Stromkreis','Kabelbaum, mechanische Fehlfunktion','2022-05-11T11:16:23.549593Z',0),
  ('BPNL00000003COJN',0,'c35fca50-1bec-468c-b24f-a559fd24d786','P0803','Magnetventil 1-4-Hochschaltung (Gangüberspringung) - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Magnetventil Hochschaltung','2022-05-11T11:16:23.556616Z',0),
  ('BPNL00000003COJN',0,'ed0785be-72d7-4ee3-b892-36e5e1dc1460','P0804','Warnleuchte 1-4-Hochschaltung (Gangüberspringung) - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung','2022-05-11T11:16:23.560989Z',0),
  ('BPNL00000003COJN',0,'ea22ce40-2239-43cd-a593-f9157be76753','P0805','Kupplungsstellungssensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.566217Z',0),
  ('BPNL00000003COJN',0,'138724e0-a4d1-40cf-8150-9d4230d6f915','P0806','Kupplungsstellungssensor - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.572056Z',0),
  ('BPNL00000003COJN',0,'d175b612-bc80-40a0-b351-b0a70dba28ea','P0807','Kupplungsstellungssensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.576207Z',0),
  ('BPNL00000003COJN',0,'4c6e6d45-d91c-426b-9495-a64177ea0e66','P0808','Kupplungsstellungssensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.580304Z',0),
  ('BPNL00000003COJN',0,'3d553162-de3a-4b39-b5ec-ab9b1f77c917','P0809','Kupplungsstellungssensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.585885Z',0),
  ('BPNL00000003COJN',0,'16d1bb92-f604-491d-af16-31e122f24517','P080A','Kupplungsstellung nicht erfasst','Kabelbaum, Kupplungspedalsensor, Motorsteuergerät','2022-05-11T11:16:23.590330Z',0),
  ('BPNL00000003COJN',0,'35dd291e-fd1e-44d1-8d7b-9237076e3404','P080B','Fahrbereich-Magnetventil, Hochschaltung/Gangüberspringung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.594642Z',0),
  ('BPNL00000003COJN',0,'14fbcafc-5e08-4bbc-9e43-27b38d5fe7dc','P080C','Fahrbereich-Magnetventil, Hochschaltung/Gangüberspringung - Signal zu niedrig','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.598848Z',0),
  ('BPNL00000003COJN',0,'e6a73802-8eb0-4d26-ac73-557a54645a80','P080D','Fahrbereich-Magnetventil, Hochschaltung/Gangüberspringung - Signal zu hoch','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:23.603175Z',0),
  ('BPNL00000003COJN',0,'0d94feb5-3b22-4eba-803a-133610984702','P0810','Steuerfehler Kupplungsstellung','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.607167Z',0),
  ('BPNL00000003COJN',0,'c0d88fea-18a3-406a-955e-bca893cd2b89','P0811','Übermäßiger Kupplungsschlupf','Kabelbaum, schlechte Kontaktierung, mechanische Fehlfunktion, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.611236Z',0),
  ('BPNL00000003COJN',0,'a8710acc-1b05-41bb-824f-7de0d54b85b4','P0812','Rückwärtsgang - Fehlfunktion Eingangsstromkreis','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.615374Z',0),
  ('BPNL00000003COJN',0,'cf9d0908-cb0a-47cb-a2a8-674ab0f0c32d','P0813','Rückwärtsgang - Fehlfunktion Ausgangsstromkreis','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.619529Z',0),
  ('BPNL00000003COJN',0,'7099b0ee-b410-4425-857f-49543247e74e','P0814','Fahrstufen-Anzeige - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Fahrstufensensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.623660Z',0),
  ('BPNL00000003COJN',0,'0137d1a6-309c-4f39-a617-23504e6581b7','P0815','Getriebegangwählschalter, Hochschaltung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebegangwählschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.628859Z',0),
  ('BPNL00000003COJN',0,'aa6b0ea4-1167-4e02-bf08-206b62b163af','P0816','Getriebegangwählschalter, Rückschaltung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebegangwählschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.635788Z',0),
  ('BPNL00000003COJN',0,'828cb4f1-2c31-4876-b55b-4bc294f3b2ca','P0817','Stromkreis Anlasssperre - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.640757Z',0),
  ('BPNL00000003COJN',0,'3439fc7a-1c5c-4bbe-a127-f81c5d5ca666','P0818','Trennschalter Antriebsstrang - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Schalter Hochschaltung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.645262Z',0),
  ('BPNL00000003COJN',0,'6c107668-e770-450e-9416-e0f61be3d66f','P0819','Getriebegangwählschalter, Hochschaltung/Rückschaltung - Bezugsfehler zu Fahrstufe','Kabelbaum, schlechte Kontaktierung, Getriebegangwählschalter, mechanische Getriebestörung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.652417Z',0),
  ('BPNL00000003COJN',0,'033e1d12-5602-4eda-b146-d2b4cc32c31a','P081A','Stromkreis Anlasssperre - Signal zu niedrig','Kabelbaum, Anlassermotorrelais, Motorsteuergerät','2022-05-11T11:16:23.660755Z',0),
  ('BPNL00000003COJN',0,'1b9c2cfa-24b8-405d-9a14-89a3cf2976e4','P081B','Stromkreis Anlasssperre - Signal zu hoch','Kabelbaum, Anlassermotorrelais, Motorsteuergerät','2022-05-11T11:16:23.666267Z',0),
  ('BPNL00000003COJN',0,'527e1f17-3ae0-4f16-91c8-c5a0200edf14','P081C','Eingangssignal Parkstellung - Fehlfunktion Stromkreis','Kabelbaum, Park-/Getriebeleerlaufschalter, Fahrstufensensor, Motorsteuergerät','2022-05-11T11:16:23.670981Z',0),
  ('BPNL00000003COJN',0,'7f6efaca-2edb-4561-b47d-b4075c297386','P081D','Eingangssignal Neutralstellung - Fehlfunktion Stromkreis','Kabelbaum, Park-/Getriebeleerlaufschalter, Fahrstufensensor, Motorsteuergerät','2022-05-11T11:16:23.676448Z',0),
  ('BPNL00000003COJN',0,'f5b48510-2efc-41ab-81d5-001b489c7db0','P081E','Getriebekupplung B - übermäßiger Kupplungsschlupf','Mechanische Fehlfunktion Getriebe','2022-05-11T11:16:23.680676Z',0),
  ('BPNL00000003COJN',0,'b370e449-215f-439e-8d20-badafb727109','P0820','Schalthebelstellungssensor X-Y-Position - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.684769Z',0),
  ('BPNL00000003COJN',0,'3788bc08-456f-4106-992d-ef7367ab45c6','P0821','Schalthebelstellungssensor X-Position - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.689181Z',0),
  ('BPNL00000003COJN',0,'eccd703f-ed6d-4ca1-9722-531bddb24b06','P0822','Schalthebelstellungssensor Y-Position - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.693335Z',0),
  ('BPNL00000003COJN',0,'f2490dde-a0ed-4287-b2a7-9a0918d063bc','P0823','Schalthebelstellungssensor X-Position - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.697880Z',0),
  ('BPNL00000003COJN',0,'b412d926-1577-44bc-a1c8-74c42e67f77d','P0824','Schalthebelstellungssensor Y-Position - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.702096Z',0),
  ('BPNL00000003COJN',0,'c5814024-95d3-48fc-8308-a8ef30893c68','P0825','Zug-/Druckschalter Schalthebelstellung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Zug-/Druckschalter Schalthebelstellung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.706574Z',0),
  ('BPNL00000003COJN',0,'7c78cb59-67c6-4645-8268-f86c17d192a9','P0826','Getriebegangwählschalter, Hochschaltung/Rückschaltung - Fehlfunktion Stromkreis','Kabelbaum, Getriebegangwählschalter','2022-05-11T11:16:23.710917Z',0),
  ('BPNL00000003COJN',0,'58d6815f-d5c0-41c7-a100-cbc2de264c23','P0827','Getriebegangwählschalter, Hochschaltung/Rückschaltung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebegangwählschalter','2022-05-11T11:16:23.716699Z',0),
  ('BPNL00000003COJN',0,'cfab8603-475c-439a-b926-94c9de52c960','P0828','Getriebegangwählschalter, Hochschaltung/Rückschaltung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebegangwählschalter','2022-05-11T11:16:23.724143Z',0),
  ('BPNL00000003COJN',0,'da464db5-74f9-4216-a473-098ca1863f3f','P0829','5-6-Hochschaltung','Mechanische Fehlfunktion','2022-05-11T11:16:23.738355Z',0),
  ('BPNL00000003COJN',0,'9bf20e0e-a116-462d-bb98-ec7d59a3fc24','P082A','Schalthebelstellung X-Position - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:23.746699Z',0),
  ('BPNL00000003COJN',0,'2cbbe7e9-8759-48d1-81b5-14dcd99cebd3','P082B','Schalthebelstellung X-Position - Signal zu niedrig','-','2022-05-11T11:16:23.750857Z',0),
  ('BPNL00000003COJN',0,'8e299336-5a53-4223-86d4-165a9dae49ee','P082C','Schalthebelstellung X-Position - Signal zu hoch','-','2022-05-11T11:16:23.754918Z',0),
  ('BPNL00000003COJN',0,'0e427589-093f-4019-a31e-73628716f7fb','P082D','Schalthebel X-Position - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:23.759158Z',0),
  ('BPNL00000003COJN',0,'df7752f8-4344-42d1-811f-cb11fc5c035d','P082E','Schalthebel X-Position - Signal zu niedrig','-','2022-05-11T11:16:23.764473Z',0),
  ('BPNL00000003COJN',0,'3560e78a-8383-4c0c-a9ff-69c749d3736f','P082F','Schalthebel X-Position - Signal zu hoch','-','2022-05-11T11:16:23.769748Z',0),
  ('BPNL00000003COJN',0,'b401f1b7-fec7-426b-a555-5d62ea01fe1a','P0830','Kupplungspedalschalter A - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.774717Z',0),
  ('BPNL00000003COJN',0,'20b58c84-130a-4a7f-84b2-3256976e3067','P0831','Kupplungspedalschalter A - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.778760Z',0),
  ('BPNL00000003COJN',0,'f45e328c-e9d9-4ae9-b8df-b66ce038635a','P0832','Kupplungspedalschalter A - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.783167Z',0),
  ('BPNL00000003COJN',0,'2bb7a118-620e-4782-9892-514e6f8c246d','P0833','Kupplungspedalschalter B - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.789285Z',0),
  ('BPNL00000003COJN',0,'ee120c13-c5fd-441e-a758-406e0de45302','P0834','Kupplungspedalschalter B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.793809Z',0),
  ('BPNL00000003COJN',0,'8b5e5d82-c096-4be9-bb86-069ae5f9b7dc','P0835','Kupplungspedalschalter B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Kupplungspedalschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.800630Z',0),
  ('BPNL00000003COJN',0,'48f07ef2-3631-4207-8fc6-6b22192ac79a','P0836','Allradantriebsschalter - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Allradantriebsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.805721Z',0),
  ('BPNL00000003COJN',0,'74125319-ed21-40cb-9aad-ce8696c45494','P0837','Allradantriebsschalter - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Allradantriebsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.810207Z',0),
  ('BPNL00000003COJN',0,'643c22e4-ec3c-4794-9586-46b6e48456a7','P0838','Allradantriebsschalter - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Allradantriebsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.814666Z',0),
  ('BPNL00000003COJN',0,'7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431','P0839','Allradantriebsschalter - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Allradantriebsschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.820389Z',0),
  ('BPNL00000003COJN',0,'3b5fcee1-abb3-47cd-8458-154784579250','P083A','Getriebeöldrucksensor/-schalter G - Fehlfunktion Stromkreis','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.824794Z',0),
  ('BPNL00000003COJN',0,'b9ae306b-d968-4c59-bd2c-2a314b53bcf6','P083B','Getriebeöldrucksensor/-schalter G - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.828953Z',0),
  ('BPNL00000003COJN',0,'d2b4bc2b-3d99-435b-afc8-55a736aec24a','P083C','Getriebeöldrucksensor/-schalter G - Signal zu niedrig','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.833440Z',0),
  ('BPNL00000003COJN',0,'93ad8f06-a597-4895-840a-fe6f358b1f00','P083D','Getriebeöldrucksensor/-schalter G - Signal zu hoch','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.837590Z',0),
  ('BPNL00000003COJN',0,'e28296fe-b9ca-4d2f-8feb-11b6467e2a82','P083E','Getriebeöldrucksensor/-schalter G - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.841833Z',0),
  ('BPNL00000003COJN',0,'acdfa76b-12a8-4869-8284-4d19fdfb5302','P083F','Kupplungspedalschalter A/B - Bezugsfehler','Kabelbaum, Kupplungspedalschalter, Kupplungspedalschalter falsch eingestellt, Motorsteuergerät','2022-05-11T11:16:23.846880Z',0),
  ('BPNL00000003COJN',0,'b21b9a96-6f7f-4d63-a393-553761a32325','P0840','Getriebeöldrucksensor A - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.851308Z',0),
  ('BPNL00000003COJN',0,'bf340b9f-411b-4727-9e44-452d22cb274e','P0841','Getriebeöldrucksensor A - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.861871Z',0),
  ('BPNL00000003COJN',0,'7d7ac01c-f6b0-42c7-97f1-732d321e7d99','P0842','Getriebeöldrucksensor A - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.872711Z',0),
  ('BPNL00000003COJN',0,'9be36d44-5062-47da-aebf-baa1e95aa50c','P0843','Getriebeöldrucksensor A - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.883226Z',0),
  ('BPNL00000003COJN',0,'9d8b2b23-968c-4f1f-9af7-6383d4fabb4e','P0844','Getriebeöldrucksensor A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.893970Z',0),
  ('BPNL00000003COJN',0,'39d6c618-d07f-41d2-9745-e0d0f564aa86','P0845','Getriebeöldrucksensor B - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.904329Z',0),
  ('BPNL00000003COJN',0,'c1f402e4-ff66-4ba6-896c-75ce577e7b1b','P0846','Getriebeöldrucksensor B - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.912969Z',0),
  ('BPNL00000003COJN',0,'cffc36e2-81cf-4cab-b9f8-f7808e7d3449','P0847','Getriebeöldrucksensor B - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.924438Z',0),
  ('BPNL00000003COJN',0,'49a307e5-6587-44e2-ae56-bba3089a1e92','P0848','Getriebeöldrucksensor B - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.934215Z',0),
  ('BPNL00000003COJN',0,'a99159b8-0f6a-42d9-9e4f-c67023182530','P0849','Getriebeöldrucksensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.950672Z',0),
  ('BPNL00000003COJN',0,'05bebe39-0ee0-4508-94ff-b50c79148bd8','P084A','Getriebeöldrucksensor/-schalter H - Fehlfunktion Stromkreis','Kabelbaum, Getriebeöldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:23.962905Z',0),
  ('BPNL00000003COJN',0,'de0c002f-ca3f-45ff-8a0a-293764b14d81','P084B','Getriebeöldrucksensor/-schalter H - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.968123Z',0),
  ('BPNL00000003COJN',0,'3e3a7f86-7daf-4696-9768-37c8d4b95dd2','P084C','Getriebeöldrucksensor/-schalter H - Signal zu niedrig','Kabelbaum, Getriebeöldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:23.973409Z',0),
  ('BPNL00000003COJN',0,'014c143d-6b6c-49f1-876f-3cbe4c1b53b9','P084D','Getriebeöldrucksensor/-schalter H - Signal zu hoch','Kabelbaum, Getriebeöldrucksensor/-schalter, Motorsteuergerät','2022-05-11T11:16:23.979129Z',0),
  ('BPNL00000003COJN',0,'aa1a3477-ce1c-44bf-bcd7-14681c56ca6c','P084E','Getriebeöldrucksensor/-schalter H - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät','2022-05-11T11:16:23.983756Z',0),
  ('BPNL00000003COJN',0,'bc26dead-dec5-4fbb-ad50-b68191a2541a','P084F','Park-/Getriebeleerlaufschalter - Ausgangsstromkreis','-','2022-05-11T11:16:23.990971Z',0),
  ('BPNL00000003COJN',0,'43c64478-d407-472d-ae62-92b7b306a6ac','P0850','Park-/Getriebeleerlaufschalter - Fehlfunktion Eingangsstromkreis','Kabelbaum, Park-/Getriebeleerlaufschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:23.995274Z',0),
  ('BPNL00000003COJN',0,'77b62ccc-b591-4696-ade9-e16bf59a34c7','P0851','Park-/Getriebeleerlaufschalter - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Park-/Getriebeleerlaufschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.000203Z',0),
  ('BPNL00000003COJN',0,'e9a5fb2c-4284-4699-abed-906136db7d67','P0852','Park-/Getriebeleerlaufschalter - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Park-/Getriebeleerlaufschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.008733Z',0),
  ('BPNL00000003COJN',0,'75735713-7847-4112-a84d-7886b705fac3','P0853','Getriebefahrschalter - Fehlfunktion Eingangsstromkreis','Kabelbaum, Getriebefahrschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.014620Z',0),
  ('BPNL00000003COJN',0,'c5307a3e-bd03-4c7d-883a-09ddb943341e','P0854','Getriebefahrschalter - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebefahrschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.019107Z',0),
  ('BPNL00000003COJN',0,'67bf41f6-ef09-446e-b930-d0219afa0a57','P0855','Getriebefahrschalter - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebefahrschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.023245Z',0),
  ('BPNL00000003COJN',0,'abf40028-1d34-41ed-b94b-bc088c1a64ae','P0856','Eingangssignal Antriebsschlupfregelung - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.028337Z',0),
  ('BPNL00000003COJN',0,'0f7d3b74-5650-45c0-9bd2-ff7ff8405fc6','P0857','Eingangssignal Antriebsschlupfregelung - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.033884Z',0),
  ('BPNL00000003COJN',0,'e545892d-349a-410c-a721-643b74f36191','P0858','Eingangssignal Antriebsschlupfregelung - zu niedrig','Kurzschluss an Masse im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.039856Z',0),
  ('BPNL00000003COJN',0,'90f669b6-e417-408a-bd79-a4e0f8a25dfe','P0859','Eingangssignal Antriebsschlupfregelung - zu hoch','Kurzschluss an Plus im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.050704Z',0),
  ('BPNL00000003COJN',0,'97952a28-6038-40dc-a1dc-f8a81d0518fe','P085A','Getriebeschaltstufen-Steuergerät B, Datenkommunikationsverbindung - Fehlfunktion','Kabelbaum, Schaltsteuergerät, Motorsteuergerät','2022-05-11T11:16:24.057833Z',0),
  ('BPNL00000003COJN',0,'0ab9a132-1199-4d21-b096-59f927f3d8e2','P085B','Getriebeschaltstufen-Steuergerät B, Datenkommunikationsverbindung - Signal zu niedrig','Kabelbaum, Schaltsteuergerät, Motorsteuergerät','2022-05-11T11:16:24.062730Z',0),
  ('BPNL00000003COJN',0,'2d307902-d5ea-4a18-bd1e-d9419bf112d4','P085C','Getriebeschaltstufen-Steuergerät B, Datenkommunikationsverbindung - Signal zu hoch','Kabelbaum, Schaltsteuergerät, Motorsteuergerät','2022-05-11T11:16:24.070081Z',0),
  ('BPNL00000003COJN',0,'9c10dd92-d63d-4c71-a7d2-f3a8f1d00611','P085D','Getriebeschaltstufen-Steuergerät A - beeinträchtigte Funktion','-','2022-05-11T11:16:24.083390Z',0),
  ('BPNL00000003COJN',0,'c86cb189-be54-4843-a0f7-2684ceefae3b','P085E','Getriebeschaltstufen-Steuergerät B - beeinträchtigte Funktion','-','2022-05-11T11:16:24.093670Z',0),
  ('BPNL00000003COJN',0,'ca9d7959-b260-4d1e-b536-156fec3a812b','P0860','Datenkommunikationsverbindung Schaltsteuergerät - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Schaltsteuergerät, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.099185Z',0),
  ('BPNL00000003COJN',0,'b2d1a7a4-babc-45e3-8afd-8207f00a18e6','P0861','Datenkommunikationsverbindung Schaltsteuergerät - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltsteuergerät, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.116252Z',0),
  ('BPNL00000003COJN',0,'7128628c-3a1c-4ae4-80c6-e5e07c5ea1df','P0862','Datenkommunikationsverbindung Schaltsteuergerät - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltsteuergerät, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.121821Z',0),
  ('BPNL00000003COJN',0,'ea1658db-20dc-4483-8fd6-ce1e5bdf29ef','P0863','Getriebesteuergerät, Kommunikation - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebesteuergerät','2022-05-11T11:16:24.133482Z',0),
  ('BPNL00000003COJN',0,'b09b4c68-9eb0-4335-ae59-6dc778e0c027','P0864','Getriebesteuergerät, Kommunikation - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebesteuergerät','2022-05-11T11:16:24.137855Z',0),
  ('BPNL00000003COJN',0,'98f67b9a-73b1-4086-8107-64a51301d67a','P0865','Getriebesteuergerät, Kommunikation - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:24.144845Z',0),
  ('BPNL00000003COJN',0,'fa5bdd9c-5efc-4ddd-b7c9-251f5d0ab838','P0866','Getriebesteuergerät, Kommunikation - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:24.150056Z',0),
  ('BPNL00000003COJN',0,'76ebbdfb-94f1-41b7-a0fa-20ed0b822419','P0867','Getriebeöldrucksensor','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.157658Z',0),
  ('BPNL00000003COJN',0,'b2c2650a-bee5-4cb0-b5a8-253ff34dea05','P0868','Getriebeöldrucksensor - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.163975Z',0),
  ('BPNL00000003COJN',0,'43e2aef7-100f-4601-8792-ba3aa4c0f191','P0869','Getriebeöldrucksensor - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.170814Z',0),
  ('BPNL00000003COJN',0,'5da6bda1-c7cb-451d-bda6-3c96bc5cae14','P086A','Neutralstellungssensor - offener Stromkreis','Kabelbaum, Neutralstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.176004Z',0),
  ('BPNL00000003COJN',0,'5063e2c1-7586-4977-8c21-0f9f24e7b39f','P086B','Neutralstellungssensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Neutralstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.186352Z',0),
  ('BPNL00000003COJN',0,'0f826a3c-8694-4406-8e6a-c30c4b9099b1','P086C','Neutralstellungssensor - Signal zu niedrig','Kabelbaum, Neutralstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.195111Z',0),
  ('BPNL00000003COJN',0,'3c9e6b69-ce38-4979-bca3-aa25ef86f0a9','P086D','Neutralstellungssensor - Signal zu hoch','Kabelbaum, Neutralstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.199865Z',0),
  ('BPNL00000003COJN',0,'30dd35c8-d442-4322-829d-fd9acba0f724','P086E','Neutralstellungssensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Neutralstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.204564Z',0),
  ('BPNL00000003COJN',0,'61a839f9-b3a1-4b92-b1db-96c6608e93be','P0870','Getriebeöldrucksensor C - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.216460Z',0),
  ('BPNL00000003COJN',0,'fe957d35-63e8-4620-ad6e-1e4addf0878c','P0871','Getriebeöldrucksensor C - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.232964Z',0),
  ('BPNL00000003COJN',0,'6ee4fa34-1756-41b1-a52b-b31a2f552338','P0872','Getriebeöldrucksensor C - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.250777Z',0),
  ('BPNL00000003COJN',0,'a3dd19e2-bedf-4b35-ab42-6a8c6e32c493','P0873','Getriebeöldrucksensor C - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.263095Z',0),
  ('BPNL00000003COJN',0,'d1e5acfd-e750-4d8a-ac7b-19ea09fd197c','P0874','Getriebeöldrucksensor C - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.272304Z',0),
  ('BPNL00000003COJN',0,'a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1','P0875','Getriebeöldrucksensor D - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.282447Z',0),
  ('BPNL00000003COJN',0,'120f6046-96d3-4e30-a967-ebdb72fd4be8','P0876','Getriebeöldrucksensor D - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.292475Z',0),
  ('BPNL00000003COJN',0,'2269185a-7af9-47d4-95f3-8bfdd77c1161','P0877','Getriebeöldrucksensor D - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.321290Z',0),
  ('BPNL00000003COJN',0,'5306579d-53be-429c-81ea-26567a9157d2','P0878','Getriebeöldrucksensor D - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.330756Z',0),
  ('BPNL00000003COJN',0,'a7b8b6fe-4e7c-4a70-962e-430a6b446f84','P0879','Getriebeöldrucksensor D - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.341617Z',0),
  ('BPNL00000003COJN',0,'b4ec3e4a-54d4-4c65-a061-57be553d0b77','P087A','Kupplungsstellungssensor B - Fehlfunktion Stromkreis','Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.355825Z',0),
  ('BPNL00000003COJN',0,'451f2ebf-54c9-45f1-9062-c95ce8010afa','P087B','Kupplungsstellungssensor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.360105Z',0),
  ('BPNL00000003COJN',0,'3b76fcad-e73c-462e-8e32-24717e00b0cb','P087C','Kupplungsstellungssensor B - Signal zu niedrig','Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.368500Z',0),
  ('BPNL00000003COJN',0,'d3ffc515-edcd-44af-8723-612242eb9daf','P087D','Kupplungsstellungssensor B - Signal zu hoch','Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.372839Z',0),
  ('BPNL00000003COJN',0,'de18145c-9bdb-474e-bdcb-be64ff36bc1c','P087E','Kupplungsstellungssensor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Kupplungsstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.378039Z',0),
  ('BPNL00000003COJN',0,'65f9f3be-5d2a-4364-9d5f-7209ad6285d3','P0880','Getriebesteuergerät - Signalfehler Versorgungseingangskreis','Kabelbaum, schlechte Kontaktierung, Getriebesteuergerät','2022-05-11T11:16:24.382562Z',0),
  ('BPNL00000003COJN',0,'29c6f51e-3fd9-42ab-aedd-80ddd316aff7','P0881','Getriebesteuergerät - Bereichs-/Funktionsfehler Versorgungseingangssignal','Kabelbaum, schlechte Kontaktierung, Getriebesteuergerät','2022-05-11T11:16:24.387330Z',0),
  ('BPNL00000003COJN',0,'c8aba69b-d281-4257-8ea9-967e9df526d0','P0882','Getriebesteuergerät - Versorgungseingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:24.396536Z',0),
  ('BPNL00000003COJN',0,'135b9454-b82d-48c0-aedd-f011caae37c7','P0883','Getriebesteuergerät - Versorgungseingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebesteuergerät','2022-05-11T11:16:24.401524Z',0),
  ('BPNL00000003COJN',0,'533e70c0-d0e1-4890-a5f6-7616e8c3d4c8','P0A1E','Steuergerät für Starter/Generator','Kabelbaum, Steuergerät für Starter/Generator','2022-05-11T11:16:25.464336Z',0),
  ('BPNL00000003COJN',0,'607eb948-a701-44fd-bf85-2cd8a5f08cfe','P0884','Getriebesteuergerät, Versorgungseingangssignal - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebesteuergerät','2022-05-11T11:16:24.406395Z',0),
  ('BPNL00000003COJN',0,'62c98dd4-7a04-4f61-bf12-fa3e8af38539','P0885','Versorgungsrelais Getriebesteuergerät, Regelung - offener Stromkreis','Kabelbaum, schlechte Kontaktierung, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.411063Z',0),
  ('BPNL00000003COJN',0,'8bd45a5e-322b-4a4e-99c6-d84cb5a1d141','P0886','Versorgungsrelais Getriebesteuergerät, Regelung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.424501Z',0),
  ('BPNL00000003COJN',0,'25b54f37-9398-41e4-94e4-2c42445bbf5e','P0887','Versorgungsrelais Getriebesteuergerät, Regelung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.437407Z',0),
  ('BPNL00000003COJN',0,'932567e0-acf1-44ab-9a11-54ebffba9baa','P0888','Versorgungsrelais Getriebesteuergerät, Fehlfunktion im Stromkreis Relaisschaltzustandserfassung','Kabelbaum, schlechte Kontaktierung, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.447511Z',0),
  ('BPNL00000003COJN',0,'b98964ed-4ed5-407f-a63f-ba2da0e4adc2','P0889','Versorgungsrelais Getriebesteuergerät, Bereichs-/Funktionsfehler im Stromkreis Relaisschaltzustandserfassung','Kabelbaum, schlechte Kontaktierung, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.452479Z',0),
  ('BPNL00000003COJN',0,'c7f3c497-4312-4775-930c-0c9b1c6a3044','P088A','Getriebeölfilter - Filter verschmutzt','-','2022-05-11T11:16:24.457845Z',0),
  ('BPNL00000003COJN',0,'4743125e-e675-41ab-8c62-b16460c7904d','P088B','Getriebeölfilter - Filter stark verschmutzt','-','2022-05-11T11:16:24.466110Z',0),
  ('BPNL00000003COJN',0,'d0631ae4-99aa-404e-ad76-d6009c94ff2c','P0890','Versorgungsrelais Getriebesteuergerät, Signal zu niedrig im Stromkreis Relaisschaltzustandserfassung','Kurzschluss an Masse im Kabelbaum, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.477305Z',0),
  ('BPNL00000003COJN',0,'c2b87a3e-6d13-478f-9f69-63c5253313f7','P0891','Versorgungsrelais Getriebesteuergerät, Signal zu hoch im Stromkreis Relaisschaltzustandserfassung','Kurzschluss an Plus im Kabelbaum, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.495581Z',0),
  ('BPNL00000003COJN',0,'8a0db450-a2b3-4500-95fe-699f0ef29974','P0892','Versorgungsrelais Getriebesteuergerät, sporadische Fehlfunktion im Stromkreis Relaisschaltzustandserfassung','Kabelbaum, schlechte Kontaktierung, Versorgungsrelais Getriebesteuergerät, Getriebesteuergerät','2022-05-11T11:16:24.514678Z',0),
  ('BPNL00000003COJN',0,'f86ed4e7-9bf9-4065-ab65-fd302017ddce','P0893','Mehrere Gangräder gleichzeitig im Eingriff','Mechanische Fehlfunktion','2022-05-11T11:16:24.519763Z',0),
  ('BPNL00000003COJN',0,'420e8daa-e35d-4d8e-ae59-5d1d690f987e','P0894','Bauteilbedingter Getriebeschlupf','Mechanische Fehlfunktion','2022-05-11T11:16:24.529642Z',0),
  ('BPNL00000003COJN',0,'c2151b78-0d37-402d-bbe5-7dbbe4b3fdb6','P0895','Schaltzeit zu kurz','Mechanische Fehlfunktion','2022-05-11T11:16:24.538361Z',0),
  ('BPNL00000003COJN',0,'8ac80921-8acf-45ae-92f8-56b6c2c15097','P0896','Schaltzeit zu lang','Mechanische Fehlfunktion','2022-05-11T11:16:24.543278Z',0),
  ('BPNL00000003COJN',0,'7c164d72-40c5-45e1-bbd6-0efef5fab9da','P0897','Getriebeölwechsel erforderlich','Mechanische Fehlfunktion','2022-05-11T11:16:24.548009Z',0),
  ('BPNL00000003COJN',0,'50bd97f9-5eb1-4b84-b0e7-7476ede6a02a','P0898','Getrieberegelung - Anforderungssignal "Motorstörungswarnleuchte" - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, schlechte Kontaktierung','2022-05-11T11:16:24.556090Z',0),
  ('BPNL00000003COJN',0,'089792e2-0d31-472b-8b1e-a77c4b1dfff5','P0899','Getrieberegelung - Anforderungssignal "Motorstörungswarnleuchte" - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, schlechte Kontaktierung','2022-05-11T11:16:24.569097Z',0),
  ('BPNL00000003COJN',0,'8997d399-daf0-4918-bb5a-9752a3108c6e','P089A','Schalthebelstellungssensor X-Position 2 - Fehlfunktion Stromkreis','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.582748Z',0),
  ('BPNL00000003COJN',0,'3a98d3b7-33f2-4ebe-b8bd-f55ee6f04c57','P089B','Schalthebelstellungssensor X-Position 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.587425Z',0),
  ('BPNL00000003COJN',0,'71bd3ede-ad9d-4705-8478-c8764e87cb38','P089C','Schalthebelstellungssensor X-Position 2 - Signal zu niedrig','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.616251Z',0),
  ('BPNL00000003COJN',0,'0e9b2055-a431-4f42-afae-9736b9a33544','P089D','Schalthebelstellungssensor X-Position 2 - Signal zu hoch','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.621374Z',0),
  ('BPNL00000003COJN',0,'682efef6-a4d6-4d42-bed1-dd9e74129da3','P089E','Schalthebelstellungssensor X-Position 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.626219Z',0),
  ('BPNL00000003COJN',0,'2e909828-9c7c-4f64-82c6-5e2f9df8875d','P089F','Schalthebelstellungssensor Y-Position 2 - Fehlfunktion Stromkreis','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.631028Z',0),
  ('BPNL00000003COJN',0,'0f6d0462-2f7f-4f89-b8a1-39df560ca6dd','P08A0','Schalthebelstellungssensor Y-Position 2 - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.635577Z',0),
  ('BPNL00000003COJN',0,'7650e614-c530-48bf-b97e-1d80478f8f04','P08A1','Schalthebelstellungssensor Y-Position 2 - Signal zu niedrig','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.639767Z',0),
  ('BPNL00000003COJN',0,'e8e2dd6f-f52d-4fe3-a898-0f6932161798','P08A2','Schalthebelstellungssensor Y-Position 2 - Signal zu hoch','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.644407Z',0),
  ('BPNL00000003COJN',0,'6ce66440-c3f0-4c2f-a407-954ed95a916c','P08A3','Schalthebelstellungssensor Y-Position 2 - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.648865Z',0),
  ('BPNL00000003COJN',0,'30fd9377-056c-4384-b8e7-62990cc80c63','P08A4','Schalthebelstellungssensor X-Position 1/2 - Bezugsfehler','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.653301Z',0),
  ('BPNL00000003COJN',0,'e06b8ed7-32fd-407d-b32a-d3a945466b37','P08A5','Schalthebelstellungssensor Y-Position 1/2 - Bezugsfehler','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.657772Z',0),
  ('BPNL00000003COJN',0,'d1685c34-4022-4ba5-9fcb-447cffc3d3bf','P08A6','Schalthebelstellungssensorik - Bezugsfehler mehrere Sensoren','Kabelbaum, Schalthebelstellungssensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.662132Z',0),
  ('BPNL00000003COJN',0,'5efa4635-1e79-41a9-9c0c-85975570f2c6','P0900','Kupplungsstellglied - offener Stromkreis','Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.666587Z',0),
  ('BPNL00000003COJN',0,'8dd2d190-e509-4a20-8db8-704271c89a42','P0901','Kupplungsstellglied - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.671353Z',0),
  ('BPNL00000003COJN',0,'97f7fc7b-2735-49c9-89fd-6037853a139f','P0902','Kupplungsstellglied - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.676006Z',0),
  ('BPNL00000003COJN',0,'e903b201-0ff6-4060-8cda-b37f5283b3ac','P0903','Kupplungsstellglied - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.681023Z',0),
  ('BPNL00000003COJN',0,'2d409bac-c4f0-4152-ba1e-1648d0d2e8d0','P0904','Stromkreis Neutralgassenstellung - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.686352Z',0),
  ('BPNL00000003COJN',0,'7f5d6eb9-9bb6-46c6-8947-40e5cfbb1887','P0905','Stromkreis Neutralgassenstellung - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.690875Z',0),
  ('BPNL00000003COJN',0,'12025200-6aa3-4dcb-9138-669cd02341ab','P0A95','Hybridantriebsbatteriepack - Hochspannungssicherung','-','2022-05-11T11:16:26.008940Z',0),
  ('BPNL00000003COJN',0,'1fb23c66-236c-451b-be1f-57770aa5aa8f','P0906','Stromkreis Neutralgassenstellung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.695498Z',0),
  ('BPNL00000003COJN',0,'9322c7cb-320d-42e5-aa79-c7f36935fd65','P0907','Stromkreis Neutralgassenstellung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.700444Z',0),
  ('BPNL00000003COJN',0,'026421ba-5bce-45da-bd25-474386630895','P0908','Stromkreis Neutralgassenstellung - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.705244Z',0),
  ('BPNL00000003COJN',0,'3aa21a53-c04b-4ccf-b6a3-abb095d21de0','P0909','Steuerfehler Neutralgassenstellung','Mechanische Fehlfunktion','2022-05-11T11:16:24.709784Z',0),
  ('BPNL00000003COJN',0,'f08ccdac-06f1-468a-98a4-96198e5e5b7d','P090A','Kupplungsstellglied B - offener Stromkreis','Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.713865Z',0),
  ('BPNL00000003COJN',0,'7aff899c-cd3d-4d7b-bdf0-10d1961e2a8f','P090B','Kupplungsstellglied B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.718227Z',0),
  ('BPNL00000003COJN',0,'60dd4b96-6374-4415-a5f7-d81fa90df8dd','P090C','Kupplungsstellglied B - Signal zu niedrig','Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.722764Z',0),
  ('BPNL00000003COJN',0,'9c8f4578-6144-46fa-87b7-bb30b16239cf','P090D','Kupplungsstellglied B - Signal zu hoch','Kabelbaum, Kupplungsstellglied, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.730725Z',0),
  ('BPNL00000003COJN',0,'ea183614-dd10-42de-be71-8c27ef1f80c7','P0910','Stellglied Neutralgassenstellung - offener Stromkreis','Kabelbaum, Stellglied Neutralgassenstellung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.735423Z',0),
  ('BPNL00000003COJN',0,'e078d511-012f-4f2b-b975-8dc8e02408b0','P0911','Stellglied Neutralgassenstellung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Stellglied Neutralgassenstellung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.740247Z',0),
  ('BPNL00000003COJN',0,'55b6226a-c090-4ad1-84fb-77c093bdd12b','P0912','Stellglied Neutralgassenstellung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Stellglied Neutralgassenstellung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.744401Z',0),
  ('BPNL00000003COJN',0,'b0025386-e7ce-41cf-bfec-4d4294fa284c','P0913','Stellglied Neutralgassenstellung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Stellglied Neutralgassenstellung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.748858Z',0),
  ('BPNL00000003COJN',0,'4881a830-f318-4f86-83d4-a3bf78a4da24','P0914','Stromkreis Schaltgassenstellung - Fehlfunktion','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.753051Z',0),
  ('BPNL00000003COJN',0,'48346b94-9cd2-411c-b2e7-76671f862a00','P0915','Stromkreis Schaltgassenstellung - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.757355Z',0),
  ('BPNL00000003COJN',0,'2ae5ccce-85b8-4c88-9ead-819d5bb8fd26','P0916','Stromkreis Schaltgassenstellung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.761760Z',0),
  ('BPNL00000003COJN',0,'8d92567c-00ac-4a3f-98dd-393f410de062','P0917','Stromkreis Schaltgassenstellung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.766601Z',0),
  ('BPNL00000003COJN',0,'781cf868-8c62-416a-90ec-3835cc0bf1dd','P0918','Stromkreis Schaltgassenstellung - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.772075Z',0),
  ('BPNL00000003COJN',0,'8376e4c1-5210-4cf1-ae3f-d5fa3354bd82','P0919','Schaltgassensteuerung - Fehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.776900Z',0),
  ('BPNL00000003COJN',0,'c8eac661-21b6-444e-9615-c220e7251612','P0920','Stellglied Schaltvorgang-Vorwärtsbewegung - offener Stromkreis','Kabelbaum, Stellglied Schaltvorgang-Vorwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.785021Z',0),
  ('BPNL00000003COJN',0,'28ab6e65-2fa3-4d08-a2db-7bbae603361f','P0921','Stellglied Schaltvorgang-Vorwärtsbewegung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Stellglied Schaltvorgang-Vorwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.790252Z',0),
  ('BPNL00000003COJN',0,'381eb988-de7e-46be-87a0-ca9e84750e5b','P0922','Stellglied Schaltvorgang-Vorwärtsbewegung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Stellglied Schaltvorgang-Vorwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.795698Z',0),
  ('BPNL00000003COJN',0,'1682abea-6bf9-4918-91d5-0058868ae58d','P0923','Stellglied Schaltvorgang-Vorwärtsbewegung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Stellglied Schaltvorgang-Vorwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.800610Z',0),
  ('BPNL00000003COJN',0,'827e7a8e-4738-4c1b-9bd9-980b856d62df','P0924','Stellglied Schaltvorgang-Rückwärtsbewegung - offener Stromkreis','Kabelbaum, Stellglied Schaltvorgang-Rückwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.805094Z',0),
  ('BPNL00000003COJN',0,'e61360bd-c9f0-4586-a1ba-87ecd10d1aac','P0925','Stellglied Schaltvorgang-Rückwärtsbewegung - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, schlechte Kontaktierung, Stellglied Schaltvorgang-Rückwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.810591Z',0),
  ('BPNL00000003COJN',0,'10df8781-99aa-44e1-a731-b4eab2a468b4','P0926','Stellglied Schaltvorgang-Rückwärtsbewegung - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Stellglied Schaltvorgang-Rückwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.820444Z',0),
  ('BPNL00000003COJN',0,'4ae80ef4-1382-4d24-95e1-2cfaca881c65','P0927','Stellglied Schaltvorgang-Rückwärtsbewegung - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Stellglied Schaltvorgang-Rückwärtsbewegung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.824928Z',0),
  ('BPNL00000003COJN',0,'42e0d3e4-d7aa-456d-94cc-ea046c96ccb7','P0928','Schaltsperren-Magnetschalter - offener Stromkreis','Kabelbaum, Schaltsperren-Magnetschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.829487Z',0),
  ('BPNL00000003COJN',0,'23a5d12d-16fe-4c05-9590-4dde12d52a3d','P0929','Schaltsperren-Magnetschalter - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Schaltsperren-Magnetschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.835042Z',0),
  ('BPNL00000003COJN',0,'c119c9d2-f06a-48a2-a8fa-f120a48c7029','P092A','Steuerstromkreis Schaltsperren-Magnetschalter/-Stellglied B - offener Stromkreis','-','2022-05-11T11:16:24.840995Z',0),
  ('BPNL00000003COJN',0,'1cab03ea-ebe6-4d20-8aed-25e4a5f08c15','P092B','Steuerstromkreis Schaltsperren-Magnetschalter/-Stellglied B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:24.845629Z',0),
  ('BPNL00000003COJN',0,'95205d26-3211-4e96-90d4-f8191088bc06','P092C','Steuerstromkreis Schaltsperren-Magnetschalter/-Stellglied B - Signal zu niedrig','-','2022-05-11T11:16:24.850197Z',0),
  ('BPNL00000003COJN',0,'7d493350-ef81-45c6-9bc7-d71ab29936aa','P092D','Steuerstromkreis Schaltsperren-Magnetschalter/-Stellglied B - Signal zu hoch','-','2022-05-11T11:16:24.854870Z',0),
  ('BPNL00000003COJN',0,'56e0bebb-9c5b-4c1d-9794-522b86d7ce36','P0930','Schaltsperren-Magnetschalter - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltsperren-Magnetschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.859270Z',0),
  ('BPNL00000003COJN',0,'71370ed1-77e3-49f1-a8d4-557a4a501d29','P0931','Schaltsperren-Magnetschalter - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltsperren-Magnetschalter, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.863853Z',0),
  ('BPNL00000003COJN',0,'2932ea90-5a90-4a50-99fa-80a77abf1f6c','P0932','Hydraulikdrucksensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Hydraulikdrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.869738Z',0),
  ('BPNL00000003COJN',0,'70f1817f-3c57-420f-8391-082a6416ba86','P0933','Hydraulikdrucksensor - Bereichs-/Funktionsfehler','Kabelbaum, Hydraulikdrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.874104Z',0),
  ('BPNL00000003COJN',0,'6dccf861-c16e-4940-9c8a-85bbeffbb61a','P0934','Hydraulikdrucksensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Hydraulikdrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.879257Z',0),
  ('BPNL00000003COJN',0,'84bbf43b-fc6c-47c8-ae15-784b47aa9f34','P0935','Hydraulikdrucksensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Hydraulikdrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.884444Z',0),
  ('BPNL00000003COJN',0,'69ad8ebc-8b63-459b-922d-d3a3d00ca465','P0936','Hydraulikdrucksensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Hydraulikdrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.894781Z',0),
  ('BPNL00000003COJN',0,'5e0a12b3-72ec-4625-b194-eaa3925ea084','P0937','Hydrauliköltemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Hydrauliköltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.899336Z',0),
  ('BPNL00000003COJN',0,'adcf3d32-6a5f-413d-87c5-54508e73704e','P0938','Hydrauliköltemperatursensor - Bereichs-/Funktionsfehler','Kabelbaum, Hydrauliköltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.905670Z',0),
  ('BPNL00000003COJN',0,'403927ae-cdfa-4d1b-a54e-dcd66e401cee','P0939','Hydrauliköltemperatursensor - Eingangssignal zu niedrig','Kurzschluss an Masse im Kabelbaum, Hydrauliköltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.911880Z',0),
  ('BPNL00000003COJN',0,'0c9fd115-95c0-4fa7-a37a-973e51216fa6','P0940','Hydrauliköltemperatursensor - Eingangssignal zu hoch','Kurzschluss an Plus im Kabelbaum, Hydrauliköltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.916422Z',0),
  ('BPNL00000003COJN',0,'491f290d-8d58-41cf-a48e-71f56d95a0b1','P0941','Hydrauliköltemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Hydrauliköltemperatursensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.924887Z',0),
  ('BPNL00000003COJN',0,'697ac72e-74dc-48b8-841d-7dc6d5cdfa3e','P0942','Hydraulikeinheit','Mechanische Fehlfunktion','2022-05-11T11:16:24.929576Z',0),
  ('BPNL00000003COJN',0,'47113b15-32c6-404b-85c4-d05f2381d174','P0943','Hydraulikeinheit - Zyklusdauer zu kurz','Mechanische Fehlfunktion','2022-05-11T11:16:24.934161Z',0),
  ('BPNL00000003COJN',0,'cc47a55c-254f-406e-9233-aeba9af10a39','P0944','Hydraulikeinheit - Druckverlust','Mechanische Fehlfunktion','2022-05-11T11:16:24.941068Z',0),
  ('BPNL00000003COJN',0,'238dbfd3-bdb1-4604-8efa-9ae0574ebcc6','P0945','Hydraulikpumpenrelais - offener Stromkreis','Kabelbaum, Hydraulikpumpenrelais, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.945559Z',0),
  ('BPNL00000003COJN',0,'4f0d7fd4-3bf9-431e-9e9c-67cbe2c907bc','P0946','Hydraulikpumpenrelais - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Hydraulikpumpenrelais, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.953644Z',0),
  ('BPNL00000003COJN',0,'5793859e-5c51-4fd1-abc0-fc39706e328c','P0947','Hydraulikpumpenrelais - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Hydraulikpumpenrelais, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.959509Z',0),
  ('BPNL00000003COJN',0,'9c17590b-d993-445d-b3a0-ebec07b393f6','P0948','Hydraulikpumpenrelais - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Hydraulikpumpenrelais, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.966839Z',0),
  ('BPNL00000003COJN',0,'83766785-7dc3-4488-a1c7-ef6abb945d57','P0949','Automatische Getriebeschaltung (Schaltgetriebe) - adaptive Datenerfassung nicht ausgeführt','Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.971496Z',0),
  ('BPNL00000003COJN',0,'fdc6e7dd-fa58-45dc-b62d-dfaf6fa35222','P0950','Automatische Getriebeschaltung (Schaltgetriebe), Regelung - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.976423Z',0),
  ('BPNL00000003COJN',0,'6b0e00f1-49b4-4cc9-ad03-e6520f0bf152','P0951','Automatische Getriebeschaltung (Schaltgetriebe), Regelung - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.981510Z',0),
  ('BPNL00000003COJN',0,'f35deab4-1752-4f5c-a2fa-ecba884c2b88','P0952','Automatische Getriebeschaltung (Schaltgetriebe), Regelung - Signal zu niedrig','Kabelbaum, schlechte Kontaktierung, Kurzschluss an Masse, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.986480Z',0),
  ('BPNL00000003COJN',0,'514e44fe-3aca-48e5-8beb-31b60b5be919','P0953','Automatische Getriebeschaltung (Schaltgetriebe), Regelung - Signal zu hoch','Kabelbaum, schlechte Kontaktierung, Kurzschluss an Plus, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:24.999241Z',0),
  ('BPNL00000003COJN',0,'505b430e-0f3e-4b21-9956-ac2f5a443c7d','P0954','Automatische Getriebeschaltung (Schaltgetriebe), Regelung - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.004175Z',0),
  ('BPNL00000003COJN',0,'66cf227c-2f9b-455c-aee8-aada17b93490','P0955','Automatische Getriebeschaltung (Schaltgetriebe), Modus - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.008888Z',0),
  ('BPNL00000003COJN',0,'1cc63521-2624-48a2-b957-004f9896f5ab','P0956','Automatische Getriebeschaltung (Schaltgetriebe), Modus - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.014209Z',0),
  ('BPNL00000003COJN',0,'5669e084-6246-4df9-9b24-ef8fd8fc1986','P0957','Automatische Getriebeschaltung (Schaltgetriebe), Modus - Signal zu niedrig','Kabelbaum, schlechte Kontaktierung, Kurzschluss an Masse, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.018668Z',0),
  ('BPNL00000003COJN',0,'1d61e155-307c-489f-8c93-5e85076f3b65','P0958','Automatische Getriebeschaltung (Schaltgetriebe), Modus - Signal zu hoch','Kabelbaum, schlechte Kontaktierung, Kurzschluss an Plus, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.024613Z',0),
  ('BPNL00000003COJN',0,'71b0f0a7-fa56-4a5f-8b5d-828f1c26cd27','P0959','Automatische Getriebeschaltung (Schaltgetriebe), Modus - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.029039Z',0),
  ('BPNL00000003COJN',0,'4e117b6a-7447-4bad-b80f-3171a12d48a0','P0960','Druckregel-Magnetventil A - offener Stromkreis','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.033672Z',0),
  ('BPNL00000003COJN',0,'569a979b-225c-457a-ae13-dca7d6e960f9','P0961','Druckregel-Magnetventil A - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.039149Z',0),
  ('BPNL00000003COJN',0,'e79fde9a-b513-4776-8bf5-f657cd115215','P0962','Druckregel-Magnetventil A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.043937Z',0),
  ('BPNL00000003COJN',0,'16d111be-7665-4df1-b05b-28263b73ffb2','P0963','Druckregel-Magnetventil A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.048972Z',0),
  ('BPNL00000003COJN',0,'17c3482a-e09e-4f36-a030-62600bb6342f','P0964','Druckregel-Magnetventil B - offener Stromkreis','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.053861Z',0),
  ('BPNL00000003COJN',0,'602e271e-2049-4009-9293-8fde7e54b601','P0965','Druckregel-Magnetventil B - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.058770Z',0),
  ('BPNL00000003COJN',0,'b9b4186d-7fad-4940-acb7-1fd9f2086bb4','P0966','Druckregel-Magnetventil B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.063104Z',0),
  ('BPNL00000003COJN',0,'142d3993-aea7-44ce-82ff-6b9a4aabd3fd','P0967','Druckregel-Magnetventil B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.067363Z',0),
  ('BPNL00000003COJN',0,'b6d7a908-c602-4735-86cd-1f7d8b20ec08','P0968','Druckregel-Magnetventil C - offener Stromkreis','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.071531Z',0),
  ('BPNL00000003COJN',0,'0d67621d-e2d6-4457-bd6f-d40df681f43f','P0969','Druckregel-Magnetventil C - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.075976Z',0),
  ('BPNL00000003COJN',0,'a0ce43dc-4793-43d6-9684-47ced2b8d0ab','P0970','Druckregel-Magnetventil C - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.080805Z',0),
  ('BPNL00000003COJN',0,'201c7452-6897-4483-937f-0e0c9febd745','P0971','Druckregel-Magnetventil C - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Druckregel-Magnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.085272Z',0),
  ('BPNL00000003COJN',0,'f6a082dd-e61c-4a7f-9bc0-82a83b61262d','P0972','Fahrbereich-Magnetventil A - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.098176Z',0),
  ('BPNL00000003COJN',0,'3985b6cd-629e-4591-8249-f9c51080ca33','P0973','Fahrbereich-Magnetventil A - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.102729Z',0),
  ('BPNL00000003COJN',0,'272e4473-e29e-43ba-b48c-76b5781a8e06','P0974','Fahrbereich-Magnetventil A - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.107400Z',0),
  ('BPNL00000003COJN',0,'601912fc-bf31-45ff-aadc-c89b176924ff','P0975','Fahrbereich-Magnetventil B - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.111929Z',0),
  ('BPNL00000003COJN',0,'8207e31e-42c4-41ce-98f3-3bb69a3a117d','P0976','Fahrbereich-Magnetventil B - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.116533Z',0),
  ('BPNL00000003COJN',0,'4416db34-641b-4eb2-ac0b-a84eaa3452d4','P0977','Fahrbereich-Magnetventil B - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.120729Z',0),
  ('BPNL00000003COJN',0,'c46248b7-e326-48dd-901a-a740393bbd88','P0978','Fahrbereich-Magnetventil C - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.125371Z',0),
  ('BPNL00000003COJN',0,'40d70704-35f8-4960-81da-c94a7cc2b34e','P0979','Fahrbereich-Magnetventil C - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.129903Z',0),
  ('BPNL00000003COJN',0,'4b37c6a4-c3f2-4636-8df3-84981427212c','P0980','Fahrbereich-Magnetventil C - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.134270Z',0),
  ('BPNL00000003COJN',0,'618c736d-5684-43d2-a237-89195221a7da','P0981','Fahrbereich-Magnetventil D - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.144313Z',0),
  ('BPNL00000003COJN',0,'69136838-c18a-4541-8528-77df5bb6a0f2','P0982','Fahrbereich-Magnetventil D - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.149363Z',0),
  ('BPNL00000003COJN',0,'d4231e4a-0d7a-4a04-8c9a-bc409e2136b1','P0983','Fahrbereich-Magnetventil D - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.153642Z',0),
  ('BPNL00000003COJN',0,'55bc3ae2-f25b-4dda-ae7f-d1a1becaebdc','P0984','Fahrbereich-Magnetventil E - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.158453Z',0),
  ('BPNL00000003COJN',0,'939a2e9a-c92b-4112-a3cb-e26cc56b7b35','P0985','Fahrbereich-Magnetventil E - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.163045Z',0),
  ('BPNL00000003COJN',0,'4254330d-9928-4339-883c-c7dc31e8c036','P0986','Fahrbereich-Magnetventil E - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.167242Z',0),
  ('BPNL00000003COJN',0,'abb6b44a-a2f9-460d-a25d-70adc1875522','P0987','Getriebeöldrucksensor E - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.171540Z',0),
  ('BPNL00000003COJN',0,'948fc8e7-dd15-42e5-924e-425ed93734c5','P0988','Getriebeöldrucksensor E - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.181332Z',0),
  ('BPNL00000003COJN',0,'f196e5ea-68b7-4ea4-859d-094bfd9f19cf','P0989','Getriebeöldrucksensor E - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.191217Z',0),
  ('BPNL00000003COJN',0,'d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e','P0990','Getriebeöldrucksensor E - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.201563Z',0),
  ('BPNL00000003COJN',0,'b0aa3cbf-52fb-4430-a1e9-9680e7023454','P0991','Getriebeöldrucksensor E - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.212245Z',0),
  ('BPNL00000003COJN',0,'0184daef-b371-4913-96ec-e2187979a8db','P0992','Getriebeöldrucksensor F - Fehlfunktion Stromkreis','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.221769Z',0),
  ('BPNL00000003COJN',0,'07331b5d-b704-432a-8e51-eb5f82ce376a','P0993','Getriebeöldrucksensor F - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.232147Z',0),
  ('BPNL00000003COJN',0,'06da6ba1-b5a0-466e-921e-a5cefe012206','P0B79','Hybridantriebsbatterie-Spannungssensor M - Signal zu niedrig','-','2022-05-11T11:16:27.093604Z',0),
  ('BPNL00000003COJN',0,'31af4d53-3eee-46fa-bc15-ff9399588050','P0994','Getriebeöldrucksensor F - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.242071Z',0),
  ('BPNL00000003COJN',0,'3da07f86-d887-44e1-8fd3-ce3ad8d074e0','P0995','Getriebeöldrucksensor F - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.250414Z',0),
  ('BPNL00000003COJN',0,'df11e4f7-ba6d-4879-974a-e4ff71cf749d','P0996','Getriebeöldrucksensor F - zeitweilige Stromkreisunterbrechungen','Kabelbaum, schlechte Kontaktierung, Getriebeöldrucksensor, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.260574Z',0),
  ('BPNL00000003COJN',0,'ac291ab0-29b1-4c17-be8c-1476cb02a572','P0997','Fahrbereich-Magnetventil F - Bereichs-/Funktionsfehler','Kabelbaum, schlechte Kontaktierung, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.268781Z',0),
  ('BPNL00000003COJN',0,'9adcc527-ddba-4474-a6c3-3ffd6fba5c3e','P0998','Fahrbereich-Magnetventil F - Signal zu niedrig','Kurzschluss an Masse im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.273240Z',0),
  ('BPNL00000003COJN',0,'8f0c7c03-5234-483f-a8f9-40b89809827b','P0999','Fahrbereich-Magnetventil F - Signal zu hoch','Kurzschluss an Plus im Kabelbaum, Schaltmagnetventil, Motorsteuergerät/Antriebsstrangsteuergerät/Getriebesteuergerät','2022-05-11T11:16:25.277634Z',0),
  ('BPNL00000003COJN',0,'93d7f4cb-d26a-4ee2-bf0e-9e3e434a34c1','P099A','Fahrbereich-Magnetventil G - Bereichs-/Funktionsfehler Steuerstromkreis','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.281840Z',0),
  ('BPNL00000003COJN',0,'976e277c-6745-4eb4-ba21-f09b7e7bcd2b','P099B','Fahrbereich-Magnetventil G - Signal Steuerstromkreis zu niedrig','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.287066Z',0),
  ('BPNL00000003COJN',0,'7b803fd8-7b46-4ff5-a759-b6a93e83f39f','P099C','Fahrbereich-Magnetventil G - Signal Steuerstromkreis zu hoch','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.291549Z',0),
  ('BPNL00000003COJN',0,'223fa84c-724a-4431-82be-ccd74ea7042a','P099D','Fahrbereich-Magnetventil H - Bereichs-/Funktionsfehler Steuerstromkreis','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.296576Z',0),
  ('BPNL00000003COJN',0,'97b0d801-c21a-4abd-82b1-825f7dae8979','P099E','Fahrbereich-Magnetventil H - Signal Steuerstromkreis zu niedrig','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.301401Z',0),
  ('BPNL00000003COJN',0,'a864932d-6585-40df-b56a-601232d7de87','P099F','Fahrbereich-Magnetventil H - Signal Steuerstromkreis zu hoch','Kabelbaum, Schaltmagnetventil, Getriebesteuergerät, Motorsteuergerät','2022-05-11T11:16:25.305637Z',0),
  ('BPNL00000003COJN',0,'333461b6-99c6-47b4-b86e-d5a2a6e02d87','P0A00','Spannungswandler-Kühlmitteltemperatursensor - Fehlfunktion Stromkreis','Kabelbaum, Spannungswandler-Kühlmitteltemperatursensor','2022-05-11T11:16:25.311224Z',0),
  ('BPNL00000003COJN',0,'5b31c15b-0efb-45c6-9e63-edd77ada86f1','P0A01','Spannungswandler-Kühlmitteltemperatursensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Spannungswandler-Kühlmitteltemperatursensor','2022-05-11T11:16:25.315401Z',0),
  ('BPNL00000003COJN',0,'c541910b-1446-4e12-a435-5abb903c324d','P0A02','Spannungswandler-Kühlmitteltemperatursensor - Signal zu niedrig','Kabelbaum, Spannungswandler-Kühlmitteltemperatursensor','2022-05-11T11:16:25.320767Z',0),
  ('BPNL00000003COJN',0,'3f456852-d9b4-4e54-9e34-25353703118f','P0A03','Spannungswandler-Kühlmitteltemperatursensor - Signal zu hoch','Kabelbaum, Spannungswandler-Kühlmitteltemperatursensor','2022-05-11T11:16:25.324975Z',0),
  ('BPNL00000003COJN',0,'c9041a1c-8c1b-497a-94a8-e137457557c5','P0A04','Spannungswandler-Kühlmitteltemperatursensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Spannungswandler-Kühlmitteltemperatursensor','2022-05-11T11:16:25.329527Z',0),
  ('BPNL00000003COJN',0,'30b992b3-22cd-406e-9c0d-7d745bef3bc4','P0A05','Spannungswandler-Kühlmittelpumpensteuerung A - offener Stromkreis','Kabelbaum, Spannungswandler-Kühlmittelpumpe','2022-05-11T11:16:25.333990Z',0),
  ('BPNL00000003COJN',0,'a35ec0cd-78e5-44a8-bd18-5a6864091a12','P0A06','Spannungswandler-Kühlmittelpumpensteuerung A - Signal zu niedrig','Kabelbaum, Spannungswandler-Kühlmittelpumpe','2022-05-11T11:16:25.338986Z',0),
  ('BPNL00000003COJN',0,'0b2cd780-7366-470a-973f-88b009338914','P0A07','Spannungswandler-Kühlmittelpumpensteuerung A - Signal zu hoch','Kabelbaum, Spannungswandler-Kühlmittelpumpe','2022-05-11T11:16:25.343660Z',0),
  ('BPNL00000003COJN',0,'9927a2cc-5b35-439e-a4c6-9205e5d663e4','P0A08','Betriebsstatus DC/DC-Wandler - Fehlfunktion Stromkreis','-','2022-05-11T11:16:25.348114Z',0),
  ('BPNL00000003COJN',0,'3a872964-9bee-4c76-9fa4-6b8d5ad82d53','P0A09','Betriebsstatus DC/DC-Wandler - Signal zu niedrig','-','2022-05-11T11:16:25.352512Z',0),
  ('BPNL00000003COJN',0,'1260d854-14f2-4929-b3f3-dcacb062c6c1','P0A0A','Hochspannungsanlage - Fehlfunktion Verriegelungsstromkreis','-','2022-05-11T11:16:25.357565Z',0),
  ('BPNL00000003COJN',0,'abe447ef-5b03-4d7d-9c39-2e64871d6a14','P0A0B','Hochspannungsanlage - Funktionsfehler Verriegelungsstromkreis','-','2022-05-11T11:16:25.361925Z',0),
  ('BPNL00000003COJN',0,'0e81d60d-e849-475f-94a5-3d4d26b600ab','P0A0C','Hochspannungsanlage - Signal zu niedrig im Verriegelungsstromkreis','-','2022-05-11T11:16:25.366661Z',0),
  ('BPNL00000003COJN',0,'3f9d64f2-8512-4b2d-92e3-bc82bb89b5cb','P0A0D','Hochspannungsanlage - Signal zu hoch im Verriegelungsstromkreis','-','2022-05-11T11:16:25.371346Z',0),
  ('BPNL00000003COJN',0,'6a88e9cd-f3ab-4ac2-b185-21d2324c7b7b','P0A0E','Hochspannungsanlage - zeitweilige Unterbrechungen im Verriegelungsstromkreis','-','2022-05-11T11:16:25.375559Z',0),
  ('BPNL00000003COJN',0,'9bf583ad-4408-440e-8ed0-db6c0ee4fe4a','P0A0F','Hybridantriebssystem - Motorstartversuch nicht erfolgreich','-','2022-05-11T11:16:25.381674Z',0),
  ('BPNL00000003COJN',0,'742804ce-b934-4f7e-afbb-018f1bc28e79','P0A10','Betriebsstatus DC/DC-Wandler - Signal zu hoch','-','2022-05-11T11:16:25.385932Z',0),
  ('BPNL00000003COJN',0,'873c92b3-be2c-421f-95e1-bbf2d518a0fb','P0A11','Freigabe DC/DC-Wandler - offener Stromkreis','-','2022-05-11T11:16:25.390294Z',0),
  ('BPNL00000003COJN',0,'b528613f-991b-48f5-acde-a88649e2a15d','P0A12','Freigabe DC/DC-Wandler - Signal zu niedrig','-','2022-05-11T11:16:25.395871Z',0),
  ('BPNL00000003COJN',0,'8b057c80-6bea-477d-8d51-02e8b642fd67','P0A13','Freigabe DC/DC-Wandler - Signal zu hoch','-','2022-05-11T11:16:25.400761Z',0),
  ('BPNL00000003COJN',0,'b1a60f40-2d23-4f22-9d71-038130d35b75','P0A14','Motoraufhängungssteuerung A - offener Stromkreis','-','2022-05-11T11:16:25.405835Z',0),
  ('BPNL00000003COJN',0,'07651fb4-da0f-43fe-b146-d25db79dc388','P0A15','Motoraufhängungssteuerung A - Signal zu niedrig','-','2022-05-11T11:16:25.411261Z',0),
  ('BPNL00000003COJN',0,'8c44c474-5c0d-4215-9a40-3807992d0307','P0A16','Motoraufhängungssteuerung A - Signal zu hoch','-','2022-05-11T11:16:25.415566Z',0),
  ('BPNL00000003COJN',0,'75b47b66-5b2c-4360-8a79-527c99d755ef','P0A17','Motordrehmomentsensor - Fehlfunktion Stromkreis','Kabelbaum, Motordrehmomentsensor','2022-05-11T11:16:25.420145Z',0),
  ('BPNL00000003COJN',0,'0cef4959-6d5c-4cfe-b2ab-69102ce798ab','P0A18','Motordrehmomentsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Motordrehmomentsensor','2022-05-11T11:16:25.424892Z',0),
  ('BPNL00000003COJN',0,'6c3eea3d-14f8-4c4f-9b51-a04d391134d5','P0A19','Motordrehmomentsensor - Signal zu niedrig','Kabelbaum, Motordrehmomentsensor','2022-05-11T11:16:25.433797Z',0),
  ('BPNL00000003COJN',0,'b32431cb-e087-4b2f-913b-bd026a9a398a','P0A1A','Generator-Steuergerät','Kabelbaum, Generator-Steuergerät','2022-05-11T11:16:25.439046Z',0),
  ('BPNL00000003COJN',0,'42f59a96-5dd3-45e2-99fc-7c0e0165544e','P0A1B','Steuergerät für Antriebsmotor A','Kabelbaum, Antriebsmotor-Steuergerät','2022-05-11T11:16:25.450239Z',0),
  ('BPNL00000003COJN',0,'30a5f87f-a37e-405b-9b93-d17df7fc635c','P0A1C','Steuergerät für Antriebsmotor B','Kabelbaum, Antriebsmotor-Steuergerät','2022-05-11T11:16:25.455182Z',0),
  ('BPNL00000003COJN',0,'bef4f3c2-e346-4064-a0a0-80e4485e0239','P0A1D','Hybridantriebsteuergerät','Kabelbaum, Hybridantriebsteuergerät','2022-05-11T11:16:25.459737Z',0),
  ('BPNL00000003COJN',0,'af9f21d1-2788-4eb5-ad8a-ae2ebab04d8b','P0A1F','Batterieleistungs-Steuergerät','Kabelbaum, Batterieleistungs-Steuergerät','2022-05-11T11:16:25.468961Z',0),
  ('BPNL00000003COJN',0,'d0015155-7523-42d9-adc9-f19a0549b605','P0A20','Motordrehmomentsensor - Signal zu hoch','Kabelbaum, Motordrehmomentsensor','2022-05-11T11:16:25.473463Z',0),
  ('BPNL00000003COJN',0,'885e84f4-11fc-4481-b892-a221bc47d599','P0A21','Motordrehmomentsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Motordrehmomentsensor','2022-05-11T11:16:25.477986Z',0),
  ('BPNL00000003COJN',0,'ab37d1c8-5d1e-4169-beb8-b24f9a0e9828','P0A22','Generatordrehmomentsensor - Fehlfunktion Stromkreis','Kabelbaum, Generatordrehmomentsensor','2022-05-11T11:16:25.482608Z',0),
  ('BPNL00000003COJN',0,'8c9e5cef-ab86-4a4b-8478-c0f1ad0d1ffd','P0A23','Generatordrehmomentsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Generatordrehmomentsensor','2022-05-11T11:16:25.487261Z',0),
  ('BPNL00000003COJN',0,'dcaedc3d-8d93-4d75-99a5-48f865d664d3','P0A24','Generatordrehmomentsensor - Signal zu niedrig','Kabelbaum, Generatordrehmomentsensor','2022-05-11T11:16:25.491698Z',0),
  ('BPNL00000003COJN',0,'8da41c39-b41e-4116-9d76-1cb36d947faf','P0A25','Generatordrehmomentsensor - Signal zu hoch','Kabelbaum, Generatordrehmomentsensor','2022-05-11T11:16:25.497093Z',0),
  ('BPNL00000003COJN',0,'50700215-703d-4d01-8acf-fedac0fa40de','P0A26','Generatordrehmomentsensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Generatordrehmomentsensor','2022-05-11T11:16:25.502383Z',0),
  ('BPNL00000003COJN',0,'777f2979-1a4f-4b5e-91a9-f704e218071a','P0A27','Hybridantriebsbatterie Betriebszustand OFF - Fehlfunktion Stromkreis','-','2022-05-11T11:16:25.508530Z',0),
  ('BPNL00000003COJN',0,'f06c38e2-108c-465a-b3d5-8eea639e163b','P0A28','Hybridantriebsbatterie Betriebszustand OFF - Signal zu niedrig','-','2022-05-11T11:16:25.513681Z',0),
  ('BPNL00000003COJN',0,'a841c00c-ba7d-40e8-8e24-bf2daee6bee9','P0A29','Hybridantriebsbatterie Betriebszustand OFF - Signal zu hoch','-','2022-05-11T11:16:25.517709Z',0),
  ('BPNL00000003COJN',0,'fe9ce47f-d610-4575-a9ae-efda0a0640de','P0A2A','Temperatursensor für Antriebsmotor A - offener Stromkreis','-','2022-05-11T11:16:25.522361Z',0),
  ('BPNL00000003COJN',0,'a9141a4f-117b-4111-9cba-556529362cc7','P0A2B','Temperatursensor für Antriebsmotor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.527058Z',0),
  ('BPNL00000003COJN',0,'ed049d37-4e15-45e1-9ba9-157ea355a9aa','P0A2C','Temperatursensor für Antriebsmotor A - Signal zu niedrig','-','2022-05-11T11:16:25.532196Z',0),
  ('BPNL00000003COJN',0,'17a2bd63-0513-4a6f-91c8-da535a29840e','P0A2D','Temperatursensor für Antriebsmotor A - Signal zu hoch','-','2022-05-11T11:16:25.536939Z',0),
  ('BPNL00000003COJN',0,'37d64261-38a5-42db-85c8-6cc38bad5b22','P0A2E','Temperatursensor für Antriebsmotor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:25.541510Z',0),
  ('BPNL00000003COJN',0,'771e38b5-6700-414f-874e-ada772b9ac99','P0A2F','Temperatursensor für Antriebsmotor A - Überhitzung','-','2022-05-11T11:16:25.546300Z',0),
  ('BPNL00000003COJN',0,'912d30ee-96ac-4617-848c-ed4fe4632da0','P0A30','Temperatursensor für Antriebsmotor B - offener Stromkreis','-','2022-05-11T11:16:25.551520Z',0),
  ('BPNL00000003COJN',0,'9ad6141c-0bc1-494e-82ed-bd7db5ff7fdd','P0A31','Temperatursensor für Antriebsmotor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.555890Z',0),
  ('BPNL00000003COJN',0,'75a03c9a-cf8a-4232-9d6b-f16e62d82a48','P0A32','Temperatursensor für Antriebsmotor B - Signal zu niedrig','-','2022-05-11T11:16:25.560338Z',0),
  ('BPNL00000003COJN',0,'b0f62f12-c73a-4925-aa49-68b1b1e5d9ba','P0A33','Temperatursensor für Antriebsmotor B - Signal zu hoch','-','2022-05-11T11:16:25.564622Z',0),
  ('BPNL00000003COJN',0,'f407ce07-ea9d-4f1a-9d5c-dafb5baada00','P0A34','Temperatursensor für Antriebsmotor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:25.569131Z',0),
  ('BPNL00000003COJN',0,'1687511c-e60c-4c7b-a4b3-6a2403e60842','P0A35','Temperatursensor für Antriebsmotor B - Überhitzung','-','2022-05-11T11:16:25.573831Z',0),
  ('BPNL00000003COJN',0,'4c7341b5-f45c-435c-a196-f157a85450e1','P0A36','Generator-Temperatursensor - Fehlfunktion Stromkreis','-','2022-05-11T11:16:25.578440Z',0),
  ('BPNL00000003COJN',0,'8d9ff626-2ebf-49bf-ad7e-c90ee3855d56','P0A37','Generator-Temperatursensor - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.582756Z',0),
  ('BPNL00000003COJN',0,'e6799ec1-92fa-4a4e-a207-73e344f311ac','P0A38','Generator-Temperatursensor - Signal zu niedrig','-','2022-05-11T11:16:25.587041Z',0),
  ('BPNL00000003COJN',0,'3d13b119-a83f-4b66-b88b-bcb70a2f10a4','P0A39','Generator-Temperatursensor - Signal zu hoch','-','2022-05-11T11:16:25.592128Z',0),
  ('BPNL00000003COJN',0,'9460ee45-a7d4-4e00-a46d-18e3b4d78f5b','P0A3A','Generator-Temperatursensor - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:25.597180Z',0),
  ('BPNL00000003COJN',0,'06aea8b0-5b06-4d11-a72d-682c7f9561ce','P0A3B','Generator - Überhitzung','-','2022-05-11T11:16:25.602440Z',0),
  ('BPNL00000003COJN',0,'eb121d97-1799-48b8-81ff-e769d0065840','P0A3C','Inverter für Antriebsmotor A - Überhitzung','-','2022-05-11T11:16:25.607622Z',0),
  ('BPNL00000003COJN',0,'ab983e54-f659-4704-879c-41a431c84505','P0A3D','Inverter für Antriebsmotor B - Überhitzung','-','2022-05-11T11:16:25.612538Z',0),
  ('BPNL00000003COJN',0,'d02ee964-2861-421e-851e-940565d1ad8f','P0A3E','Inverter für Generator - Überhitzung','-','2022-05-11T11:16:25.617012Z',0),
  ('BPNL00000003COJN',0,'3f4c2861-459e-400c-bb8c-adfb29c67877','P0A3F','Stellungssensor für Antriebsmotor A - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.621818Z',0),
  ('BPNL00000003COJN',0,'5cf8f321-0871-4cac-a1cc-b73ad9e8bb6e','P0A40','Stellungssensor für Antriebsmotor A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.626401Z',0),
  ('BPNL00000003COJN',0,'f6c66192-cf5f-4e2e-b98e-665938894472','P0A41','Stellungssensor für Antriebsmotor A - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.630868Z',0),
  ('BPNL00000003COJN',0,'78225dab-f8e0-49a2-8ca3-a14735aa0412','P0A42','Stellungssensor für Antriebsmotor A - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.635669Z',0),
  ('BPNL00000003COJN',0,'bbfc4cf1-1c45-4fdb-a486-29eb6ee84f5c','P0A43','Stellungssensor für Antriebsmotor A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.640398Z',0),
  ('BPNL00000003COJN',0,'05e9c267-c1eb-4f94-8e7d-93c274ebdda7','P0A44','Stellungssensor für Antriebsmotor A - Stromkreis Überdrehzahlkontrolle','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.645382Z',0),
  ('BPNL00000003COJN',0,'cc594afa-635e-4c73-acb9-da25f8a77bb4','P0A45','Stellungssensor für Antriebsmotor B - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.649749Z',0),
  ('BPNL00000003COJN',0,'81d16efd-885b-4bff-ad84-c06ad0c38dd5','P0A46','Stellungssensor für Antriebsmotor B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.654761Z',0),
  ('BPNL00000003COJN',0,'86d16141-1ac0-4aa1-a5a0-738cc5cb8b2c','P0A47','Stellungssensor für Antriebsmotor B - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.659121Z',0),
  ('BPNL00000003COJN',0,'aef0cb0c-e668-4286-b89e-64b20c234742','P0A48','Stellungssensor für Antriebsmotor B - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.663466Z',0),
  ('BPNL00000003COJN',0,'13b3ac16-aa8f-48a5-82fa-3e66c8124659','P0A49','Stellungssensor für Antriebsmotor B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.667731Z',0),
  ('BPNL00000003COJN',0,'6baad905-6fa2-47d0-97b3-43bd3aec75fe','P0A4A','Stellungssensor für Antriebsmotor B - Stromkreis Überdrehzahlkontrolle','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:25.672049Z',0),
  ('BPNL00000003COJN',0,'dbc3b827-ef80-42a4-bcab-763ede9ccb20','P0A4B','Generator-Stellungssensor - Fehlfunktion Stromkreis','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.676463Z',0),
  ('BPNL00000003COJN',0,'52c2b573-e920-4476-9b2b-6d3b8239d6b0','P0A4C','Generator-Stellungssensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.682712Z',0),
  ('BPNL00000003COJN',0,'1f649ff2-a771-4de1-9211-3e8536e6d727','P0A4D','Generator-Stellungssensor - Signal zu niedrig','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.687375Z',0),
  ('BPNL00000003COJN',0,'a86de4df-0612-4147-95e5-d17883ed6812','P0A4E','Generator-Stellungssensor - Signal zu hoch','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.692025Z',0),
  ('BPNL00000003COJN',0,'2971274d-cba1-47b0-ae07-d031ee3b7303','P0A4F','Generator-Stellungssensor - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.696281Z',0),
  ('BPNL00000003COJN',0,'6b0cc0c2-9da3-4e1b-a948-bbc1fc162b5d','P0A50','Generator-Stellungssensor - Stromkreis Überdrehzahlkontrolle','Kabelbaum, Generator-Stellungssensor','2022-05-11T11:16:25.701860Z',0),
  ('BPNL00000003COJN',0,'f25e4e79-b5a3-46bd-b218-0f852166a875','P0A51','Stromsensor für Antriebsmotor A - offener Stromkreis','-','2022-05-11T11:16:25.706322Z',0),
  ('BPNL00000003COJN',0,'11c712dd-d9db-425c-b4d7-4a74d6a4bd5a','P0A52','Stromsensor für Antriebsmotor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.710792Z',0),
  ('BPNL00000003COJN',0,'8c94c512-9607-4d03-853d-37985bd74a79','P0A53','Stromsensor für Antriebsmotor A - Signal zu niedrig','-','2022-05-11T11:16:25.716530Z',0),
  ('BPNL00000003COJN',0,'27cd0f6b-1aec-45a4-af5c-34d46e03e6a9','P0A54','Stromsensor für Antriebsmotor A - Signal zu hoch','-','2022-05-11T11:16:25.720657Z',0),
  ('BPNL00000003COJN',0,'32e8ce1b-3eb9-4dc2-a32d-9880df775c0b','P0A55','Stromsensor für Antriebsmotor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:25.725511Z',0),
  ('BPNL00000003COJN',0,'f17b0682-0263-4687-aba1-7c8bf8fdf553','P0A56','Stromsensor für Antriebsmotor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.729596Z',0),
  ('BPNL00000003COJN',0,'7fb5e10b-2316-4f73-aba0-a7d095595d6c','P0A57','Stromsensor für Antriebsmotor B - Signal zu niedrig','-','2022-05-11T11:16:25.734376Z',0),
  ('BPNL00000003COJN',0,'9dd2a7ea-a5c3-443a-8fa0-27630f565252','P0A58','Stromsensor für Antriebsmotor B - Signal zu hoch','-','2022-05-11T11:16:25.738946Z',0),
  ('BPNL00000003COJN',0,'5175fc10-e0ae-44e1-94e5-3775a7157bff','P0A59','Generator-Stromsensor - Fehlfunktion Stromkreis','Kabelbaum, Generator-Stromsensor','2022-05-11T11:16:25.744443Z',0),
  ('BPNL00000003COJN',0,'b1472723-4a03-4936-bba1-6e2dd8230d30','P0A5A','Generator-Stromsensor - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Generator-Stromsensor','2022-05-11T11:16:25.748523Z',0),
  ('BPNL00000003COJN',0,'a741056b-0267-4175-887c-a700fbcfa01b','P0A5B','Generator-Stromsensor - Signal zu niedrig','Kabelbaum, Generator-Stromsensor','2022-05-11T11:16:25.752848Z',0),
  ('BPNL00000003COJN',0,'cd8d4452-6cc1-4ee7-b1e4-8a6b43b71c3d','P0A5C','Generator-Stromsensor - Signal zu hoch','Kabelbaum, Generator-Stromsensor','2022-05-11T11:16:25.756970Z',0),
  ('BPNL00000003COJN',0,'2289d890-fe4b-4e48-8a43-eeef1e90e7d4','P0A5D','Antriebsmotor A - Fehlfunktion Stromphase U','-','2022-05-11T11:16:25.761069Z',0),
  ('BPNL00000003COJN',0,'4fba8ccf-c9fe-4167-a78c-9aa9892f910b','P0A5E','Antriebsmotor A - Stromstärke zu niedrig in Phasenleitung U','-','2022-05-11T11:16:25.765586Z',0),
  ('BPNL00000003COJN',0,'04a583f6-6215-4885-abfc-9cd9f5f6adb2','P0A5F','Antriebsmotor A - Stromstärke zu hoch in Phasenleitung U','-','2022-05-11T11:16:25.769689Z',0),
  ('BPNL00000003COJN',0,'7009b401-215e-445d-a92b-d6cf486997ac','P0A60','Antriebsmotor A - Fehlfunktion Stromphase V','-','2022-05-11T11:16:25.774116Z',0),
  ('BPNL00000003COJN',0,'83b9b750-86ff-4897-9c8e-aefb189c4434','P0A61','Antriebsmotor A - Stromstärke zu niedrig in Phasenleitung V','-','2022-05-11T11:16:25.778675Z',0),
  ('BPNL00000003COJN',0,'c0f20149-520c-4f18-bb6c-f176cebb6052','P0A62','Antriebsmotor A - Stromstärke zu hoch in Phasenleitung V','-','2022-05-11T11:16:25.783645Z',0),
  ('BPNL00000003COJN',0,'747f99a5-24ae-4bc9-b298-708a34bc87bd','P0A63','Antriebsmotor A - Fehlfunktion Stromphase W','-','2022-05-11T11:16:25.790627Z',0),
  ('BPNL00000003COJN',0,'7a8cdb1a-6eb6-4bd9-aeb5-c4955130b86c','P0A64','Antriebsmotor A - Stromstärke zu niedrig in Phasenleitung W','-','2022-05-11T11:16:25.794928Z',0),
  ('BPNL00000003COJN',0,'f07abff7-33f8-4ccc-9ce7-54c9f9126179','P0A65','Antriebsmotor A - Stromstärke zu hoch in Phasenleitung W','-','2022-05-11T11:16:25.799202Z',0),
  ('BPNL00000003COJN',0,'ad153f00-f436-431a-8000-78adcf13d9c8','P0A66','Antriebsmotor B - Fehlfunktion Stromphase U','-','2022-05-11T11:16:25.804280Z',0),
  ('BPNL00000003COJN',0,'d2d4067c-978b-4174-a7d9-961076d2cd6c','P0A67','Antriebsmotor B - Stromstärke zu niedrig in Phasenleitung U','-','2022-05-11T11:16:25.808886Z',0),
  ('BPNL00000003COJN',0,'fbb7043b-799e-4c76-9e80-1e4bcfbd3609','P0A68','Antriebsmotor B - Stromstärke zu hoch in Phasenleitung U','-','2022-05-11T11:16:25.812968Z',0),
  ('BPNL00000003COJN',0,'a7cb0b3c-27dc-426d-b499-e3731f546024','P0A69','Antriebsmotor B - Fehlfunktion Stromphase V','-','2022-05-11T11:16:25.817002Z',0),
  ('BPNL00000003COJN',0,'d694d527-5e33-48bc-b819-154ecb43dc23','P0A6A','Antriebsmotor B - Stromstärke zu niedrig in Phasenleitung V','-','2022-05-11T11:16:25.821328Z',0),
  ('BPNL00000003COJN',0,'f49709be-3630-4d48-b493-f2f3d8c54e65','P0A6B','Antriebsmotor B - Stromstärke zu hoch in Phasenleitung V','-','2022-05-11T11:16:25.825639Z',0),
  ('BPNL00000003COJN',0,'df8fc294-9f24-4ab4-9988-579517ebbb9c','P0A6C','Antriebsmotor B - Fehlfunktion Stromphase W','-','2022-05-11T11:16:25.829893Z',0),
  ('BPNL00000003COJN',0,'d1e10209-ccd7-4a95-9340-e7044252204f','P0A6D','Antriebsmotor B - Stromstärke zu niedrig in Phasenleitung W','-','2022-05-11T11:16:25.834091Z',0),
  ('BPNL00000003COJN',0,'df9ae099-8a3f-4e10-9698-2e8ac7d17614','P0A6E','Antriebsmotor B - Stromstärke zu hoch in Phasenleitung W','-','2022-05-11T11:16:25.838401Z',0),
  ('BPNL00000003COJN',0,'362aff87-cefe-40fd-94ad-42d5760ae9be','P0A6F','Generator - Fehlfunktion Stromphase U','-','2022-05-11T11:16:25.842625Z',0),
  ('BPNL00000003COJN',0,'be95f364-322b-4a48-9fbc-5fa7b7ea046b','P0A70','Generator - Stromstärke zu niedrig in Phasenleitung U','-','2022-05-11T11:16:25.847059Z',0),
  ('BPNL00000003COJN',0,'f0240418-5dc0-4c44-8e3d-9c499bf3d134','P0A71','Generator - Stromstärke zu hoch in Phasenleitung U','-','2022-05-11T11:16:25.851263Z',0),
  ('BPNL00000003COJN',0,'eae38abc-0510-46ef-95a3-a1cb921250b6','P0A72','Generator - Fehlfunktion Stromphase V','-','2022-05-11T11:16:25.855295Z',0),
  ('BPNL00000003COJN',0,'319725d1-9878-4480-813d-1daf927912f5','P0A73','Generator - Stromstärke zu niedrig in Phasenleitung V','-','2022-05-11T11:16:25.859276Z',0),
  ('BPNL00000003COJN',0,'bc02639f-15b4-4131-a374-7284b7652005','P0A74','Generator - Stromstärke zu hoch in Phasenleitung V','-','2022-05-11T11:16:25.863624Z',0),
  ('BPNL00000003COJN',0,'0dd42d47-78d0-4d73-8352-e42132b877aa','P0A75','Generator - Fehlfunktion Stromphase W','-','2022-05-11T11:16:25.868457Z',0),
  ('BPNL00000003COJN',0,'08c0931f-9703-4180-acff-7dcdb4e44643','P0A76','Generator - Stromstärke zu niedrig in Phasenleitung W','-','2022-05-11T11:16:25.872369Z',0),
  ('BPNL00000003COJN',0,'09a1832c-cba5-4bcc-9d40-af993b59d233','P0A77','Generator - Stromstärke zu hoch in Phasenleitung W','-','2022-05-11T11:16:25.876498Z',0),
  ('BPNL00000003COJN',0,'3f33d508-9bb7-4d22-ba4c-babb43bb9e48','P0A78','Inverter für Antriebsmotor A - beeinträchtigte Funktion','-','2022-05-11T11:16:25.880986Z',0),
  ('BPNL00000003COJN',0,'c3fef299-967a-463f-b795-fcd9120bc166','P0A79','Inverter für Antriebsmotor B - beeinträchtigte Funktion','-','2022-05-11T11:16:25.885253Z',0),
  ('BPNL00000003COJN',0,'11e51af4-6e38-4fc0-bf4a-a6e304c93f32','P0A7A','Inverter für Generator - beeinträchtigte Funktion','-','2022-05-11T11:16:25.889959Z',0),
  ('BPNL00000003COJN',0,'34623560-e41e-4dfd-b905-f5fa4d4374c7','P0A7B','Batterieleistungs-Steuergerät - Aktivierung der Motorstörungswarnleuchte angefordert','-','2022-05-11T11:16:25.895104Z',0),
  ('BPNL00000003COJN',0,'ed536ef0-b1df-4bf4-a6d3-8431055747f4','P0A7C','Spannungswandler - Überhitzung','-','2022-05-11T11:16:25.899839Z',0),
  ('BPNL00000003COJN',0,'1f673416-2236-4f3e-b5b2-55f230a063cb','P0A7D','Hybridantriebsbatteriepack - Batterie entladen','-','2022-05-11T11:16:25.904522Z',0),
  ('BPNL00000003COJN',0,'f8d50ed4-2d10-4343-90cd-eceeb8caead4','P0A7E','Hybridantriebsbatteriepack - Überhitzung','-','2022-05-11T11:16:25.909610Z',0),
  ('BPNL00000003COJN',0,'1cbb3492-758b-4821-baec-96fe001ee7ec','P0A7F','Hybridantriebsbatteriepack - Verschleiß','-','2022-05-11T11:16:25.914049Z',0),
  ('BPNL00000003COJN',0,'16568f8a-ce33-4a6d-b4be-01f9c3227b82','P0A80','Hybridantriebsbatteriepack','Hybridantriebsbatteriepack erneuern','2022-05-11T11:16:25.918173Z',0),
  ('BPNL00000003COJN',0,'9b9e6d86-80a8-4080-87a5-f2b15f03988b','P0A81','Hybridantriebsbatteriepack-Kühlgebläse 1 - offener Steuerstromkreis','-','2022-05-11T11:16:25.922638Z',0),
  ('BPNL00000003COJN',0,'47e32efa-be81-45f8-97ab-43de4a9673ec','P0A82','Hybridantriebsbatteriepack-Kühlgebläse 1 - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:25.927128Z',0),
  ('BPNL00000003COJN',0,'ab7e8b7d-7264-4031-8e12-59060f986991','P0A83','Hybridantriebsbatteriepack-Kühlgebläse 1 - ständig aktiviert','-','2022-05-11T11:16:25.931212Z',0),
  ('BPNL00000003COJN',0,'96133e1f-d943-4450-9ca6-dd9a4f37fc22','P0A84','Hybridantriebsbatteriepack-Kühlgebläse 1 - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:25.935314Z',0),
  ('BPNL00000003COJN',0,'da74f91d-9cb0-4ea9-9d9a-b557809e91be','P0A85','Hybridantriebsbatteriepack-Kühlgebläse 1 - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:25.939864Z',0),
  ('BPNL00000003COJN',0,'27d649be-0e77-4f35-b893-fd583fa8f153','P0A86','14-V-Versorgungsmodul-Stromsensor - Fehlfunktion Stromkreis','-','2022-05-11T11:16:25.944415Z',0),
  ('BPNL00000003COJN',0,'1caaedfa-c44c-47d3-94da-bcf7816345f7','P0A87','14-V-Versorgungsmodul-Stromsensor - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:25.948675Z',0),
  ('BPNL00000003COJN',0,'7c8c8f30-6df8-4909-aea1-149c59ab2ae8','P0A88','14-V-Versorgungsmodul-Stromsensor - Signal zu niedrig','-','2022-05-11T11:16:25.953105Z',0),
  ('BPNL00000003COJN',0,'9db0dc5d-3e27-42f1-8096-ddd923042299','P0A89','14-V-Versorgungsmodul-Stromsensor - Signal zu hoch','-','2022-05-11T11:16:25.957136Z',0),
  ('BPNL00000003COJN',0,'0674f4f6-3ebf-456c-b41f-04d9b0f5b0d8','P0A8A','14-V-Versorgungsmodul-Stromsensor - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:25.961477Z',0),
  ('BPNL00000003COJN',0,'24e48a1d-78ec-4017-9224-7f32835353b9','P0A8B','14-V-Versorgungsmodul - Systemspannung','-','2022-05-11T11:16:25.965891Z',0),
  ('BPNL00000003COJN',0,'2ac39989-85ed-4b85-8f22-ff7aef69790c','P0A8C','14-V-Versorgungsmodul - schwankende Systemspannung','-','2022-05-11T11:16:25.969953Z',0),
  ('BPNL00000003COJN',0,'60e6d000-dc72-46b2-ac66-950a014f6af2','P0A8D','14-V-Versorgungsmodul - Systemspannung zu niedrig','-','2022-05-11T11:16:25.974263Z',0),
  ('BPNL00000003COJN',0,'51b99cf7-bb71-4d05-b109-5871ff138955','P0A8E','14-V-Versorgungsmodul - Systemspannung zu hoch','-','2022-05-11T11:16:25.978710Z',0),
  ('BPNL00000003COJN',0,'2880e3ec-d3ff-4afc-9c6a-279d000deda3','P0A8F','14-V-Versorgungsmodul - Funktionsfehler','-','2022-05-11T11:16:25.982835Z',0),
  ('BPNL00000003COJN',0,'a1d8f586-4e22-4126-8907-906da699cdc0','P0A90','Antriebsmotor A - beeinträchtigte Funktion','Kabelbaum, Antriebsmotor','2022-05-11T11:16:25.986858Z',0),
  ('BPNL00000003COJN',0,'8706650f-b465-43d2-accf-a2d354b0a0b5','P0A91','Antriebsmotor B - beeinträchtigte Funktion','Kabelbaum, Antriebsmotor','2022-05-11T11:16:25.990740Z',0),
  ('BPNL00000003COJN',0,'7befdaa2-289d-4206-a5e1-ca757684f5dc','P0A92','Hybridantrieb-Generator - beeinträchtigte Funktion','-','2022-05-11T11:16:25.994633Z',0),
  ('BPNL00000003COJN',0,'d65a85cc-0f0d-4dcd-a82e-3fe75089970e','P0A93','Inverter A - Kühlleistung','-','2022-05-11T11:16:25.999121Z',0),
  ('BPNL00000003COJN',0,'6387577d-3567-4566-9a51-92d8646a0dae','P0A94','DC/DC-Wandler - beeinträchtigte Funktion','-','2022-05-11T11:16:26.003139Z',0),
  ('BPNL00000003COJN',0,'771d2baf-2e63-4f7b-99e4-b08b0194344c','P0A96','Hybridantriebsbatteriepack-Kühlgebläse 2 - offener Steuerstromkreis','-','2022-05-11T11:16:26.013673Z',0),
  ('BPNL00000003COJN',0,'57dde74e-d7db-4727-838c-4f47ee35ac7e','P0A97','Hybridantriebsbatteriepack-Kühlgebläse 2 - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:26.018088Z',0),
  ('BPNL00000003COJN',0,'6051dd5e-5ed4-4cb4-a292-353688f8ea83','P0A98','Hybridantriebsbatteriepack-Kühlgebläse 2 - ständig aktiviert','-','2022-05-11T11:16:26.022228Z',0),
  ('BPNL00000003COJN',0,'150d71ca-3775-4916-a055-21e396936d74','P0A99','Hybridantriebsbatteriepack-Kühlgebläse 2 - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.026759Z',0),
  ('BPNL00000003COJN',0,'e0e2d11c-62dc-496b-bdac-1960c835b514','P0A9A','Hybridantriebsbatteriepack-Kühlgebläse 2 - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.031407Z',0),
  ('BPNL00000003COJN',0,'caa955f8-728d-4850-ac52-afd4a650e2ad','P0A9B','Hybridantriebsbatterie-Temperatursensor A - Stromkreis','-','2022-05-11T11:16:26.035544Z',0),
  ('BPNL00000003COJN',0,'89f2d1a9-0642-406e-927a-f10bb25b5fba','P0A9C','Hybridantriebsbatterie-Temperatursensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.039758Z',0),
  ('BPNL00000003COJN',0,'43fa8c59-15ed-4a78-b0bb-34e50140e513','P0A9D','Hybridantriebsbatterie-Temperatursensor A - Signal zu niedrig','-','2022-05-11T11:16:26.043967Z',0),
  ('BPNL00000003COJN',0,'2d572f86-1219-4578-b608-6ba9fe900e45','P0A9E','Hybridantriebsbatterie-Temperatursensor A - Signal zu hoch','-','2022-05-11T11:16:26.048626Z',0),
  ('BPNL00000003COJN',0,'1e5a1d8f-0107-4bfb-868d-1644d2c7212c','P0A9F','Hybridantriebsbatterie-Temperatursensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.053323Z',0),
  ('BPNL00000003COJN',0,'662f8ef3-3927-48e6-a469-9529427461c8','P0AA0','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.057910Z',0),
  ('BPNL00000003COJN',0,'4595987d-0767-4266-a51b-4954051f7e98','P0AA1','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Stromkreis permanent geschlossen','-','2022-05-11T11:16:26.062278Z',0),
  ('BPNL00000003COJN',0,'db62dcda-45e4-4f8f-bdeb-eca351f14fee','P0AA2','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Stromkreis permanent geöffnet','-','2022-05-11T11:16:26.066724Z',0),
  ('BPNL00000003COJN',0,'298a9d50-af74-488c-8591-a7898cdef11c','P0AA3','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.071079Z',0),
  ('BPNL00000003COJN',0,'72b91c77-fbe7-40bc-9a2e-b7c378a6d3e8','P0AA4','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Stromkreis permanent geschlossen','-','2022-05-11T11:16:26.081372Z',0),
  ('BPNL00000003COJN',0,'7aa24b14-d531-4335-a272-4770cf01834a','P0AA5','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Stromkreis permanent geöffnet','-','2022-05-11T11:16:26.085729Z',0),
  ('BPNL00000003COJN',0,'52c619b3-8f02-471c-ade2-2d128a2cf2f4','P0AA6','Hybridantriebsbatterie-Spannungssystem - fehlerhafte Isolation','-','2022-05-11T11:16:26.094357Z',0),
  ('BPNL00000003COJN',0,'c139cd9b-edce-438e-a392-6aeae9df2913','P0AA7','Hybridantriebsbatterie-Spannungstrennungssensor - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.098733Z',0),
  ('BPNL00000003COJN',0,'23ca61e9-dcc9-4aad-abf4-2f7b8f86f606','P0AA8','Hybridantriebsbatterie-Spannungstrennungssensor - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.103383Z',0),
  ('BPNL00000003COJN',0,'2696fcdb-1cea-483f-b8f6-f2162ef925ef','P0AA9','Hybridantriebsbatterie-Spannungstrennungssensor - Signal zu niedrig','-','2022-05-11T11:16:26.110410Z',0),
  ('BPNL00000003COJN',0,'30317c87-5dde-472d-90c3-2aed5238aac9','P0AAA','Hybridantriebsbatterie-Spannungstrennungssensor - Signal zu hoch','-','2022-05-11T11:16:26.114613Z',0),
  ('BPNL00000003COJN',0,'3d879c0d-f9bb-4ea8-9dd2-42a0b4a05da6','P0AAB','Hybridantriebsbatterie-Spannungstrennungssensor - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.118583Z',0),
  ('BPNL00000003COJN',0,'315fa9af-b666-49a3-be12-520b58da01cf','P0AAC','Hybridantriebsbatteriepack-Lufttemperatursensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.122654Z',0),
  ('BPNL00000003COJN',0,'965718c6-03a1-4943-b8a0-72eef9e26d26','P0AAD','Hybridantriebsbatteriepack-Lufttemperatursensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.126602Z',0),
  ('BPNL00000003COJN',0,'52d2fa66-8d0a-40bb-9a44-a1bd66d52423','P0AAE','Hybridantriebsbatteriepack-Lufttemperatursensor A - Signal zu niedrig','-','2022-05-11T11:16:26.130690Z',0),
  ('BPNL00000003COJN',0,'7fdb9b2a-ab43-495a-923c-12e39a3e32a7','P0AAF','Hybridantriebsbatteriepack-Lufttemperatursensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.134683Z',0),
  ('BPNL00000003COJN',0,'b3d96f71-a594-4ed3-8db4-dc59b46e2aae','P0AB0','Hybridantriebsbatteriepack-Stromsensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.138745Z',0),
  ('BPNL00000003COJN',0,'233168ab-d25d-48aa-a562-0d8427458c72','P0AB1','Hybridantriebsbatteriepack-Lufttemperatursensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.149228Z',0),
  ('BPNL00000003COJN',0,'95e00b88-122f-4e8a-a250-5234d44ffba8','P0AB2','Hybridantriebsbatteriepack-Lufttemperatursensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.154353Z',0),
  ('BPNL00000003COJN',0,'884c7a10-0302-42ef-ac65-2c396e3138e4','P0AB3','Hybridantriebsbatteriepack-Lufttemperatursensor B - Signal zu niedrig','-','2022-05-11T11:16:26.159289Z',0),
  ('BPNL00000003COJN',0,'71fbea8b-7fe9-4ea2-bbe6-76fa8cc6ad49','P0AB4','Hybridantriebsbatteriepack-Lufttemperatursensor B - Signal zu hoch','-','2022-05-11T11:16:26.163446Z',0),
  ('BPNL00000003COJN',0,'75bb9878-a27f-43d0-9da1-4f2a5bfd04d5','P0AB5','Hybridantriebsbatteriepack-Lufttemperatursensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.170407Z',0),
  ('BPNL00000003COJN',0,'ba2c20e4-1483-4b76-9559-a49cd9d7fa4d','P0AB6','Motoraufhängungssteuerung B - offener Stromkreis','-','2022-05-11T11:16:26.175146Z',0),
  ('BPNL00000003COJN',0,'52b68dde-8cb0-46f9-9968-a345e4e86657','P0AB7','Motoraufhängungssteuerung B - Signal zu niedrig','-','2022-05-11T11:16:26.180157Z',0),
  ('BPNL00000003COJN',0,'4deca5e0-fcb5-466d-9ee9-8f96cfcde89c','P0AB8','Motoraufhängungssteuerung B - Signal zu hoch','-','2022-05-11T11:16:26.185436Z',0),
  ('BPNL00000003COJN',0,'b8635941-86b4-4dcc-8d97-cc12e5084e2c','P0AB9','Hybridantriebssystem - beeinträchtigte Funktion','-','2022-05-11T11:16:26.190043Z',0),
  ('BPNL00000003COJN',0,'4025cc5d-79c6-4e89-9c5b-eb60aeadcbf7','P0ABA','Hybridantriebsbatteriepack-Spannungssensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.194352Z',0),
  ('BPNL00000003COJN',0,'7d46f1cf-e8ce-40a4-acc4-396e2ad140d9','P0ABB','Hybridantriebsbatteriepack-Spannungssensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.198742Z',0),
  ('BPNL00000003COJN',0,'b964e44f-d078-4e0c-ae7d-2aa5608014a6','P0ABC','Hybridantriebsbatteriepack-Spannungssensor A - Signal zu niedrig','-','2022-05-11T11:16:26.202993Z',0),
  ('BPNL00000003COJN',0,'c36407e3-5d53-4ab9-a801-165519017c84','P0ABD','Hybridantriebsbatteriepack-Spannungssensor A - Signal zu hoch','-','2022-05-11T11:16:26.207258Z',0),
  ('BPNL00000003COJN',0,'e35ebdb3-5e90-4747-81cd-a08fa8cfc6fc','P0ABE','Hybridantriebsbatteriepack-Spannungssensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.214587Z',0),
  ('BPNL00000003COJN',0,'36f380f6-7bb7-4cc0-92f5-043de3f6e8b0','P0ABF','Hybridantriebsbatteriepack-Stromsensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.219849Z',0),
  ('BPNL00000003COJN',0,'669c3cef-3eb1-4ffa-be94-6473fce7bffb','P0AC0','Hybridantriebsbatteriepack-Stromsensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.224685Z',0),
  ('BPNL00000003COJN',0,'3ae11f87-8a0c-4150-b7ae-b4127d426542','P0AC1','Hybridantriebsbatteriepack-Stromsensor A - Signal zu niedrig','-','2022-05-11T11:16:26.229025Z',0),
  ('BPNL00000003COJN',0,'ecdd681a-6309-416a-af2b-c8e6e9ab9459','P0AC2','Hybridantriebsbatteriepack-Stromsensor A - Signal zu hoch','-','2022-05-11T11:16:26.233658Z',0),
  ('BPNL00000003COJN',0,'0d96a589-ec27-4745-9d96-7c03871cdae4','P0AC3','Hybridantriebsbatteriepack-Stromsensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.238085Z',0),
  ('BPNL00000003COJN',0,'bde59576-92c0-475e-bf22-ebb77f978b34','P0AC4','Hybridantriebsteuergerät - Aktivierung der Motorstörungswarnleuchte angefordert','-','2022-05-11T11:16:26.242654Z',0),
  ('BPNL00000003COJN',0,'2af7cdb7-b6cf-4869-9a7b-9ca671931807','P0AC5','Hybridantriebsbatterie-Temperatursensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.248620Z',0),
  ('BPNL00000003COJN',0,'6b684779-c9df-4557-ac31-f116bd32aa03','P0AC6','Hybridantriebsbatterie-Temperatursensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.253376Z',0),
  ('BPNL00000003COJN',0,'53a15dab-bed4-437f-852d-6afd80896c41','P0AC7','Hybridantriebsbatterie-Temperatursensor B - Signal zu niedrig','-','2022-05-11T11:16:26.258555Z',0),
  ('BPNL00000003COJN',0,'2ecc088b-b215-4a3a-89fe-f5511fa13d1f','P0AC8','Hybridantriebsbatterie-Temperatursensor B - Signal zu hoch','-','2022-05-11T11:16:26.263931Z',0),
  ('BPNL00000003COJN',0,'63a22a98-3a72-4008-9506-6c1e854a6490','P0AC9','Hybridantriebsbatterie-Temperatursensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.268815Z',0),
  ('BPNL00000003COJN',0,'efcc4d65-6e7a-4b70-9725-573a954160fe','P0ACA','Hybridantriebsbatterie-Temperatursensor C - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.273708Z',0),
  ('BPNL00000003COJN',0,'e7f37578-37d4-4ed4-a41c-fee7b1bfb1d2','P0ACB','Hybridantriebsbatterie-Temperatursensor C - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.278722Z',0),
  ('BPNL00000003COJN',0,'37a8c938-706c-4159-ae2f-7f486ca8cb31','P0ACC','Hybridantriebsbatterie-Temperatursensor C - Signal zu niedrig','-','2022-05-11T11:16:26.282911Z',0),
  ('BPNL00000003COJN',0,'60f9b2cb-b691-4afb-825c-dd2fde5daada','P0ACD','Hybridantriebsbatterie-Temperatursensor C - Signal zu hoch','-','2022-05-11T11:16:26.287076Z',0),
  ('BPNL00000003COJN',0,'fa916a16-4c44-4d59-b9c1-76958512e0c4','P0ACE','Hybridantriebsbatterie-Temperatursensor C - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.291064Z',0),
  ('BPNL00000003COJN',0,'2f66cb0b-c241-41f0-b410-1a6991e25666','P0ACF','Hybridantriebsbatteriepack-Kühlgebläse 3 - offener Steuerstromkreis','-','2022-05-11T11:16:26.295317Z',0),
  ('BPNL00000003COJN',0,'49825d41-ee64-43b2-8be2-0cf083c3d2ee','P0AD0','Hybridantriebsbatteriepack-Kühlgebläse 3 - Fehlfunktion oder ständig deaktiviert','-','2022-05-11T11:16:26.299907Z',0),
  ('BPNL00000003COJN',0,'f1208c69-ad39-419a-85aa-784c797e8565','P0AD1','Hybridantriebsbatteriepack-Kühlgebläse 3 - ständig aktiviert','-','2022-05-11T11:16:26.304252Z',0),
  ('BPNL00000003COJN',0,'d3e5be01-2252-4260-a477-ca348d8824b1','P0AD2','Hybridantriebsbatteriepack-Kühlgebläse 3 - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.308618Z',0),
  ('BPNL00000003COJN',0,'93c61cdd-58cb-45ca-afb0-6e4beaa05ccc','P0AD3','Hybridantriebsbatteriepack-Kühlgebläse 3 - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.314020Z',0),
  ('BPNL00000003COJN',0,'4c74634a-adfa-4f77-8cd8-4c4cf9f2bc48','P0AD4','Hybridantriebsbatteriepack-Kühlsystem - unzureichender Luftstrom','-','2022-05-11T11:16:26.324669Z',0),
  ('BPNL00000003COJN',0,'48ffacb4-d2ac-4ecc-ab0d-e7b46efaa879','P0AD5','Hybridantriebsbatteriepack-Luftströmungsventil A - offener Steuerstromkreis','-','2022-05-11T11:16:26.328930Z',0),
  ('BPNL00000003COJN',0,'eb2be4b4-35cc-4465-bf6a-0201c2fbe971','P0AD6','Hybridantriebsbatteriepack-Luftströmungsventil A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.333320Z',0),
  ('BPNL00000003COJN',0,'f0ac6459-0848-4706-865e-90fbef9e04fc','P0AD7','Hybridantriebsbatteriepack-Luftströmungsventil A - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.337857Z',0),
  ('BPNL00000003COJN',0,'8420ab20-edee-4051-8be3-5d3a91800688','P0AD8','Hybridantriebsbatteriepack-Luftströmungsventil A - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.342548Z',0),
  ('BPNL00000003COJN',0,'a9c3e405-535e-4e9a-bbbf-b770b5d039b2','P0AD9','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - offener Steuerstromkreis','-','2022-05-11T11:16:26.346747Z',0),
  ('BPNL00000003COJN',0,'ff4d1c89-ca68-4fc1-aceb-e01a8c7d51a8','P0ADA','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Bereichs-/Funktionsfehler Steuerstromkreis','-','2022-05-11T11:16:26.351279Z',0),
  ('BPNL00000003COJN',0,'54b6ecbb-9585-455c-aabf-1a9d2ab549b3','P0ADB','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.355668Z',0),
  ('BPNL00000003COJN',0,'e5994b7b-e253-4af2-9c8c-12de66735618','P0ADC','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.360456Z',0),
  ('BPNL00000003COJN',0,'e21b18de-8fa6-4b1b-ab4c-6caa1edf29af','P0ADD','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - offener Steuerstromkreis','-','2022-05-11T11:16:26.364941Z',0),
  ('BPNL00000003COJN',0,'bc85f632-dde8-4e0d-9795-a0333ca46cad','P0ADE','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Bereichs-/Funktionsfehler Steuerstromkreis','-','2022-05-11T11:16:26.369542Z',0),
  ('BPNL00000003COJN',0,'c2c013ea-c136-4d0e-a719-efe4dba2f34a','P0ADF','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.373952Z',0),
  ('BPNL00000003COJN',0,'76288c87-9b57-4321-9d68-c2d683e440f7','P0AE0','Hybridantriebsbatterie-Schaltschütz (positive Kontakte) - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.378683Z',0),
  ('BPNL00000003COJN',0,'8a4b3686-5f3a-4b9f-8efc-ab858cb7a8e5','P0AE1','Hybridantriebsbatterie-Vorladungsschaltschütz - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.383313Z',0),
  ('BPNL00000003COJN',0,'d6891056-f2d8-4cb7-943e-dde63f4113c3','P0AE2','Hybridantriebsbatterie-Vorladungsschaltschütz - Stromkreis permanent geschlossen','-','2022-05-11T11:16:26.390037Z',0),
  ('BPNL00000003COJN',0,'7b5643d8-7191-4785-8bc1-3442030876fc','P0AE3','Hybridantriebsbatterie-Vorladungsschaltschütz - Stromkreis permanent geöffnet','-','2022-05-11T11:16:26.398286Z',0),
  ('BPNL00000003COJN',0,'b78c6350-4818-40e5-9904-faa51c605148','P0AE4','Hybridantriebsbatterie-Vorladungsschaltschütz - Fehlfunktion Steuerstromkreis','-','2022-05-11T11:16:26.402731Z',0),
  ('BPNL00000003COJN',0,'0970653b-1790-4e87-af5b-383faabab5ce','P0AE5','Hybridantriebsbatterie-Vorladungsschaltschütz - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.406757Z',0),
  ('BPNL00000003COJN',0,'e68f1f12-f1e6-491e-8979-b3332e2e0294','P0AE6','Hybridantriebsbatterie-Vorladungsschaltschütz - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.410756Z',0),
  ('BPNL00000003COJN',0,'8559b9d1-a217-4cb6-ab19-bd0550952df6','P0AE7','Hybridantriebsbatterie-Vorladungsschaltschütz - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.415986Z',0),
  ('BPNL00000003COJN',0,'91d631ac-21f2-4c7f-b974-d219d57dace0','P0AE8','Hybridantriebsbatterie-Temperatursensor D - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.420499Z',0),
  ('BPNL00000003COJN',0,'97af8ee6-f284-4fa0-8808-702bcbb1c11a','P0AE9','Hybridantriebsbatterie-Temperatursensor D - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.424348Z',0),
  ('BPNL00000003COJN',0,'88143c2f-1164-41b4-80b6-b68e470a2a8f','P0AEA','Hybridantriebsbatterie-Temperatursensor D - Signal zu niedrig','-','2022-05-11T11:16:26.429077Z',0),
  ('BPNL00000003COJN',0,'79839ea3-fa12-454c-b410-1da67868a42c','P0AEB','Hybridantriebsbatterie-Temperatursensor D - Signal zu hoch','-','2022-05-11T11:16:26.434722Z',0),
  ('BPNL00000003COJN',0,'1362156f-bcc7-4ee1-8133-8561397bbf12','P0AEC','Hybridantriebsbatterie-Temperatursensor D - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.439072Z',0),
  ('BPNL00000003COJN',0,'cb16ea78-8b3c-4359-894f-c4c8c4aa28e1','P0AED','Temperatursensor für Antriebsmotor-Inverter A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.443408Z',0),
  ('BPNL00000003COJN',0,'bde3cd6f-1935-46d6-8c15-70e9a942879c','P0AEE','Temperatursensor für Antriebsmotor-Inverter A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.447495Z',0),
  ('BPNL00000003COJN',0,'a1de567f-79b4-49cf-8b4d-1d71a6ef156c','P0AEF','Temperatursensor für Antriebsmotor-Inverter A - Signal zu niedrig','-','2022-05-11T11:16:26.451779Z',0),
  ('BPNL00000003COJN',0,'5cdbed0c-a3ad-4afe-8aa5-9c90e60ed2d5','P0AF0','Temperatursensor für Antriebsmotor-Inverter A - Signal zu hoch','-','2022-05-11T11:16:26.456111Z',0),
  ('BPNL00000003COJN',0,'096a1171-1c49-45ef-b73d-f81a63d81387','P0AF1','Temperatursensor für Antriebsmotor-Inverter A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.460452Z',0),
  ('BPNL00000003COJN',0,'4b847746-01b2-4bdc-ac37-71642058d62f','P0AF2','Temperatursensor für Antriebsmotor-Inverter B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.464911Z',0),
  ('BPNL00000003COJN',0,'a6cf5a1f-78d9-48d4-8a0d-c75671f37d67','P0AF3','Temperatursensor für Antriebsmotor-Inverter B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.469173Z',0),
  ('BPNL00000003COJN',0,'c96eade7-e794-4d85-aeb8-5dbb97b91b13','P0AF4','Temperatursensor für Antriebsmotor-Inverter B - Signal zu niedrig',' ','2022-05-11T11:16:26.473795Z',0),
  ('BPNL00000003COJN',0,'c93506b8-4d29-4816-929e-0db57ce46236','P0AF5','Temperatursensor für Antriebsmotor-Inverter B - Signal zu hoch','-','2022-05-11T11:16:26.478149Z',0),
  ('BPNL00000003COJN',0,'f4e40085-2e7b-4650-a70c-a95a4d642a5f','P0AF6','Temperatursensor für Antriebsmotor-Inverter B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.482994Z',0),
  ('BPNL00000003COJN',0,'c7550b95-ab3f-462f-a7d1-049ebd77a5f4','P0AF7','14-V-Versorgungsmodul - interne Gerätetemperatur zu hoch','-','2022-05-11T11:16:26.487761Z',0),
  ('BPNL00000003COJN',0,'6e2de2ba-6c36-4b5c-a565-a94682b29527','P0AF8','Hybridantriebsbatteriesystem - Fehlfunktion Spannungsversorgung','-','2022-05-11T11:16:26.492136Z',0),
  ('BPNL00000003COJN',0,'a24e9025-5e56-4eff-a682-62f13d21355d','P0AF9','Hybridantriebsbatteriesystem - schwankende Systemspannung','-','2022-05-11T11:16:26.496683Z',0),
  ('BPNL00000003COJN',0,'2349ec91-bf1d-4bb0-9af1-a9e3f77ad1fb','P0AFA','Hybridantriebsbatteriesystem - Spannung zu niedrig','-','2022-05-11T11:16:26.501682Z',0),
  ('BPNL00000003COJN',0,'81c6fa25-6148-48b2-81ba-a5770350cefb','P0AFB','Hybridantriebsbatteriesystem - Spannung zu hoch','-','2022-05-11T11:16:26.506462Z',0),
  ('BPNL00000003COJN',0,'f8579d01-7c50-4eeb-b6a9-7f396588e10f','P0AFC','Hybridantriebsbatteriepack-Sensormodul','-','2022-05-11T11:16:26.510831Z',0),
  ('BPNL00000003COJN',0,'74bc733f-3455-4381-b888-1b7f10dac314','P0AFD','Hybridantriebsbatteriepack - Batterietemperatur zu niedrig','-','2022-05-11T11:16:26.514985Z',0),
  ('BPNL00000003COJN',0,'21a3d3c6-e856-4934-86ee-0b42718e62b9','P0AFE','Hybridantriebsbatteriesystem - Spannung zu niedrig für Aufwärtswandlung (Hochsetzsteller)','-','2022-05-11T11:16:26.519862Z',0),
  ('BPNL00000003COJN',0,'0a703660-a0ca-49d0-9dad-2e28299a649f','P0AFF','Hybridantriebsbatteriesystem - Spannung zu niedrig für Abwärtswandlung (Tiefsetzsteller)','-','2022-05-11T11:16:26.523972Z',0),
  ('BPNL00000003COJN',0,'189a05a0-7a03-4c72-b312-70a6369545e3','P0B00','Getriebe-Systemdruckhilfspumpenmotor - Fehlfunktion Stromphase U','-','2022-05-11T11:16:26.528099Z',0),
  ('BPNL00000003COJN',0,'a3a247b2-d845-48b5-9f35-0642121ad491','P0B01','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu niedrig in Phasenleitung U','-','2022-05-11T11:16:26.532189Z',0),
  ('BPNL00000003COJN',0,'fa5de2c8-3023-4250-95a0-52c17f9c5d0a','P0B02','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu hoch in Phasenleitung U','-','2022-05-11T11:16:26.536074Z',0),
  ('BPNL00000003COJN',0,'b8c3572a-9efd-40e0-b060-30770865c228','P0B03','Getriebe-Systemdruckhilfspumpenmotor - Fehlfunktion Stromphase V','-','2022-05-11T11:16:26.540503Z',0),
  ('BPNL00000003COJN',0,'2b89cf4d-f475-4838-9923-91e4a41369cb','P0B04','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu niedrig in Phasenleitung V','-','2022-05-11T11:16:26.544714Z',0),
  ('BPNL00000003COJN',0,'c57208f5-c3aa-4c57-86b2-f6dd422f79d3','P0B05','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu hoch in Phasenleitung V','-','2022-05-11T11:16:26.548825Z',0),
  ('BPNL00000003COJN',0,'9c2883c5-250f-4dcd-9780-670f4c4e447f','P0B06','Getriebe-Systemdruckhilfspumpenmotor - Fehlfunktion Stromphase W','-','2022-05-11T11:16:26.553034Z',0),
  ('BPNL00000003COJN',0,'7cc3345a-12f9-4ad3-b947-eaf3ce72e5be','P0B07','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu niedrig in Phasenleitung W','-','2022-05-11T11:16:26.557161Z',0),
  ('BPNL00000003COJN',0,'876fccbc-efe3-427d-b176-d7e95edf06f5','P0B08','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu hoch in Phasenleitung W','-','2022-05-11T11:16:26.562620Z',0),
  ('BPNL00000003COJN',0,'92837b57-2bfe-4e5e-bf04-51fc423a43e9','P0B09','Getriebe-Systemdruckhilfspumpenmotor - Fehlfunktion Versorgungsspannung','-','2022-05-11T11:16:26.566862Z',0),
  ('BPNL00000003COJN',0,'1741f60d-12f1-4088-9c36-0eefa6c03058','P0B0A','Getriebe-Systemdruckhilfspumpenmotor - Versorgungsspannung zu niedrig','-','2022-05-11T11:16:26.571284Z',0),
  ('BPNL00000003COJN',0,'c0ba36f0-8ee8-4d9b-8e14-19c73b16db02','P0B0B','Getriebe-Systemdruckhilfspumpenmotor - Versorgungsspannung zu hoch','Kabelbaum, Getriebe-Systemdruckhilfspumpenmotor','2022-05-11T11:16:26.575610Z',0),
  ('BPNL00000003COJN',0,'8ef53a24-2a81-4b65-9a36-563b5cc6568a','P0B0C','Getriebe-Systemdruckhilfspumpe - Undichtigkeit in Hydraulikanlage','-','2022-05-11T11:16:26.579597Z',0),
  ('BPNL00000003COJN',0,'6351d4f8-94f8-440c-a076-5aa415292364','P0B0D','Steuergerät für Getriebe-Systemdruckhilfspumpe - Fehlfunktion','Kabelbaum, Steuergerät für Getriebe-Systemdruckhilfspumpe','2022-05-11T11:16:26.583656Z',0),
  ('BPNL00000003COJN',0,'17d5466c-6d36-42a4-9913-11688b7c34c3','P0B0E','Hybridantriebsbatteriepack-Stromsensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.588035Z',0),
  ('BPNL00000003COJN',0,'20fa0275-af93-420d-8d50-9a789631916b','P0B0F','Hybridantriebsbatteriepack-Stromsensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.592201Z',0),
  ('BPNL00000003COJN',0,'206a776b-ad32-4d19-8bc5-839b9f0a0a7e','P0B10','Hybridantriebsbatteriepack-Stromsensor B - Signal zu niedrig','-','2022-05-11T11:16:26.596188Z',0),
  ('BPNL00000003COJN',0,'759fdb73-1503-479c-8d18-2988c41351f2','P0B11','Hybridantriebsbatteriepack-Stromsensor B - Signal zu hoch','-','2022-05-11T11:16:26.600385Z',0),
  ('BPNL00000003COJN',0,'e08f262a-7e8f-4b07-bbfe-20e12f6fb426','P0B12','Hybridantriebsbatteriepack-Stromsensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.604879Z',0),
  ('BPNL00000003COJN',0,'21da4642-868c-43e2-92f2-2eb606228b98','P0B13','Hybridantriebsbatteriepack-Stromsensor - Bezug A/B','-','2022-05-11T11:16:26.608854Z',0),
  ('BPNL00000003COJN',0,'d129880c-9156-44a0-b864-6efb14a7c824','P0B14','Hybridantriebsbatteriepack-Spannungssensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.613317Z',0),
  ('BPNL00000003COJN',0,'81400c65-a976-4096-b0d0-30be06a23f59','P0B15','Hybridantriebsbatteriepack-Spannungssensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.617424Z',0),
  ('BPNL00000003COJN',0,'9414e20d-bcf0-4efa-a592-b64b3b7d39de','P0B16','Hybridantriebsbatteriepack-Spannungssensor B - Signal zu niedrig','-','2022-05-11T11:16:26.628500Z',0),
  ('BPNL00000003COJN',0,'8e975d1b-935f-4081-80a3-93f224b93028','P0B17','Hybridantriebsbatteriepack-Spannungssensor B - Signal zu hoch','-','2022-05-11T11:16:26.632817Z',0),
  ('BPNL00000003COJN',0,'29ff1828-fcb5-4239-88ee-093be50bf391','P0B18','Hybridantriebsbatteriepack-Spannungssensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.636942Z',0),
  ('BPNL00000003COJN',0,'63c8ed99-b432-4993-b5ad-bfc3029719eb','P0B19','Hybridantriebsbatteriepack-Spannungssensor C - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.641236Z',0),
  ('BPNL00000003COJN',0,'b2e46a27-307f-4459-ba4d-c8c8fcf53c07','P0B1A','Hybridantriebsbatteriepack-Spannungssensor C - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.645690Z',0),
  ('BPNL00000003COJN',0,'382ab9cc-8178-4b94-8f63-f7eb3df76640','P0B1B','Hybridantriebsbatteriepack-Spannungssensor C - Signal zu niedrig','-','2022-05-11T11:16:26.650096Z',0),
  ('BPNL00000003COJN',0,'31f435f5-bd07-4727-a062-688a9b2ba20f','P0B1C','Hybridantriebsbatteriepack-Spannungssensor C - Signal zu hoch','-','2022-05-11T11:16:26.654556Z',0),
  ('BPNL00000003COJN',0,'6aee64aa-29d3-4248-aa1e-6dcb88367d2c','P0B1D','Hybridantriebsbatteriepack-Spannungssensor C - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.658804Z',0),
  ('BPNL00000003COJN',0,'1b778ecb-7c03-4cdd-950d-5d51dfae9572','P0B1E','Hybridantriebsbatteriepack-Spannungssensor D - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.664020Z',0),
  ('BPNL00000003COJN',0,'a10e475c-47e8-4f42-b261-fea5e3629ea1','P0B1F','Hybridantriebsbatteriepack-Spannungssensor D - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.668546Z',0),
  ('BPNL00000003COJN',0,'c324265b-4161-4444-8c25-1622a128fb2b','P0B20','Hybridantriebsbatteriepack-Spannungssensor D - Signal zu niedrig','-','2022-05-11T11:16:26.673856Z',0),
  ('BPNL00000003COJN',0,'3bf5f036-21b4-4f42-98cc-8f09622165d4','P0B21','Hybridantriebsbatteriepack-Spannungssensor D - Signal zu hoch','-','2022-05-11T11:16:26.678129Z',0),
  ('BPNL00000003COJN',0,'dc358d54-034c-4a6d-9ebe-b803f74be43d','P0B22','Hybridantriebsbatteriepack-Spannungssensor D - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.682467Z',0),
  ('BPNL00000003COJN',0,'3aaec84b-3cf4-49fa-afbf-611f33567c4d','P0B23','Hybridantriebsbatterie A - Fehlfunktion Spannungsversorgung','-','2022-05-11T11:16:26.686893Z',0),
  ('BPNL00000003COJN',0,'8b538682-4146-403d-924b-cca3ef61bb25','P0B24','Hybridantriebsbatterie A - schwankende Spannung','-','2022-05-11T11:16:26.690782Z',0),
  ('BPNL00000003COJN',0,'5cfb59c1-e355-4b0f-be20-59c4158acd8c','P0B25','Hybridantriebsbatterie A - Spannung zu niedrig','-','2022-05-11T11:16:26.695148Z',0),
  ('BPNL00000003COJN',0,'e8fa9f24-9f54-49a6-9320-8ddf2551ddb4','P0B26','Hybridantriebsbatterie A - Spannung zu hoch','-','2022-05-11T11:16:26.703213Z',0),
  ('BPNL00000003COJN',0,'782881de-cb75-48dc-af67-44c9ad5a7930','P0B27','Hybridantriebsbatterie B - Fehlfunktion Spannungsversorgung','-','2022-05-11T11:16:26.707754Z',0),
  ('BPNL00000003COJN',0,'4068c7e4-1370-4a81-b95f-82c30e137c43','P0B28','Hybridantriebsbatterie B - schwankende Spannung','-','2022-05-11T11:16:26.712721Z',0),
  ('BPNL00000003COJN',0,'87d99e18-2c4a-41f2-817b-bfa1f3840b92','P0B29','Hybridantriebsbatterie B - Spannung zu niedrig','-','2022-05-11T11:16:26.716930Z',0),
  ('BPNL00000003COJN',0,'a90c3580-75e5-4adf-b241-c17d62ec8177','P0B2A','Hybridantriebsbatterie B - Spannung zu hoch','-','2022-05-11T11:16:26.721721Z',0),
  ('BPNL00000003COJN',0,'672feda2-669a-4809-a83d-66e06f7b630b','P0B2B','Hybridantriebsbatterie C - Fehlfunktion Spannungsversorgung','-','2022-05-11T11:16:26.726134Z',0),
  ('BPNL00000003COJN',0,'17a9b9a6-0afa-494d-b0c5-003cab8f42e1','P0B2C','Hybridantriebsbatterie C - schwankende Spannung','-','2022-05-11T11:16:26.730956Z',0),
  ('BPNL00000003COJN',0,'24e22647-78c4-482f-9be7-64b4d166dd61','P0B2D','Hybridantriebsbatterie C - Spannung zu niedrig','-','2022-05-11T11:16:26.736090Z',0),
  ('BPNL00000003COJN',0,'b3d3f218-e950-4995-980b-c29e180eb8fd','P0B2E','Hybridantriebsbatterie C - Spannung zu hoch','-','2022-05-11T11:16:26.740504Z',0),
  ('BPNL00000003COJN',0,'34b76379-2548-436a-89b8-506864e1a826','P0B2F','Hybridantriebsbatterie D - Fehlfunktion Spannungsversorgung','-','2022-05-11T11:16:26.746147Z',0),
  ('BPNL00000003COJN',0,'46fa7083-2217-41f6-acd2-bbab17360f70','P0B30','Hybridantriebsbatterie D - schwankende Spannung','-','2022-05-11T11:16:26.751299Z',0),
  ('BPNL00000003COJN',0,'7ba22413-5ede-46b0-a21e-ef4698282ec7','P0B31','Hybridantriebsbatterie D - Spannung zu niedrig','-','2022-05-11T11:16:26.756997Z',0),
  ('BPNL00000003COJN',0,'5f2b2692-c612-491a-816a-5638ef5b427d','P0B32','Hybridantriebsbatterie D - Spannung zu hoch','-','2022-05-11T11:16:26.761113Z',0),
  ('BPNL00000003COJN',0,'e27333b7-8414-4ab1-9f7c-83082a2471d4','P0B33','Hybridantriebsbatteriepack-Isolator - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.765738Z',0),
  ('BPNL00000003COJN',0,'1da127be-7ece-4029-af4b-646fceb556f4','P0B34','Hybridantriebsbatteriepack-Isolator - Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.770359Z',0),
  ('BPNL00000003COJN',0,'88b4e92e-a0e3-40b4-8d0f-891192f5ac21','P0B35','Hybridantriebsbatteriepack-Isolator - Signal zu niedrig','-','2022-05-11T11:16:26.774860Z',0),
  ('BPNL00000003COJN',0,'09e599f9-ec47-4832-9dbb-4f0d48b353a6','P0B36','Hybridantriebsbatteriepack-Isolator - Signal zu hoch','-','2022-05-11T11:16:26.779853Z',0),
  ('BPNL00000003COJN',0,'64c799ce-5119-4966-b54c-af54b7aa43c1','P0B37','Hybridantriebsbatteriepack-Isolator - offener Stromkreis','-','2022-05-11T11:16:26.786641Z',0),
  ('BPNL00000003COJN',0,'6684bcb8-551a-46ae-a65e-c18401c93538','P0B38','Spannungswandler-Kühlmittelpumpenmotor B - offener Steuerstromkreis','-','2022-05-11T11:16:26.790885Z',0),
  ('BPNL00000003COJN',0,'2df23f63-c5ee-4fd6-a3f5-ec2089c82335','P0B39','Spannungswandler-Kühlmittelpumpenmotor B - Signal Steuerstromkreis zu niedrig','-','2022-05-11T11:16:26.798471Z',0),
  ('BPNL00000003COJN',0,'38bb3838-fe23-448b-bf1b-b17f6501f5d4','P0B3A','Spannungswandler-Kühlmittelpumpenmotor B - Signal Steuerstromkreis zu hoch','-','2022-05-11T11:16:26.803077Z',0),
  ('BPNL00000003COJN',0,'f04b4cf5-4011-4103-b5ee-2db3bac0b06e','P0B3B','Hybridantriebsbatterie-Spannungssensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.807762Z',0),
  ('BPNL00000003COJN',0,'2f2301b0-67bd-491c-9e1e-4f8a29d4a01a','P0B3C','Hybridantriebsbatterie-Spannungssensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.812029Z',0),
  ('BPNL00000003COJN',0,'6a3dfdc1-3b3b-4dec-92b6-9d628a51364e','P0B3D','Hybridantriebsbatterie-Spannungssensor A - Signal zu niedrig','-','2022-05-11T11:16:26.816752Z',0),
  ('BPNL00000003COJN',0,'5e5ea9ad-bdba-44b9-88db-aa77213a0c17','P0B3E','Hybridantriebsbatterie-Spannungssensor A - Signal zu hoch','-','2022-05-11T11:16:26.821915Z',0),
  ('BPNL00000003COJN',0,'2fadd73f-546d-4190-8a69-9c202f780726','P0B3F','Hybridantriebsbatterie-Spannungssensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.826420Z',0),
  ('BPNL00000003COJN',0,'6752c97f-cfaa-48b7-bd92-479072be56c4','P0B40','Hybridantriebsbatterie-Spannungssensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.830678Z',0),
  ('BPNL00000003COJN',0,'ac92c7c2-99af-4f71-83b1-f9532f81e91d','P0B41','Hybridantriebsbatterie-Spannungssensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.834963Z',0),
  ('BPNL00000003COJN',0,'0b7d163a-c556-47dc-8461-0ae44e84f30c','P0B42','Hybridantriebsbatterie-Spannungssensor B - Signal zu niedrig','-','2022-05-11T11:16:26.839113Z',0),
  ('BPNL00000003COJN',0,'1562ef90-9628-4229-90ca-4b8256288263','P0B43','Hybridantriebsbatterie-Spannungssensor B - Signal zu hoch','-','2022-05-11T11:16:26.843476Z',0),
  ('BPNL00000003COJN',0,'c2e72fd1-371b-4416-98f7-e56369141dd0','P0B44','Hybridantriebsbatterie-Spannungssensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.847641Z',0),
  ('BPNL00000003COJN',0,'907afca9-4d8a-4da5-a81b-51ae5c23f832','P0B45','Hybridantriebsbatterie-Spannungssensor C - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.851849Z',0),
  ('BPNL00000003COJN',0,'b89e211e-2f52-4c37-b933-f2b4ab6a42d9','P0B46','Hybridantriebsbatterie-Spannungssensor C - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.855877Z',0),
  ('BPNL00000003COJN',0,'c91b5582-ae26-4d19-a2dd-4dbef5efd47a','P0B47','Hybridantriebsbatterie-Spannungssensor C - Signal zu niedrig','-','2022-05-11T11:16:26.860191Z',0),
  ('BPNL00000003COJN',0,'8ca77085-11ea-48db-b3e1-97193065f8f1','P0B48','Hybridantriebsbatterie-Spannungssensor C - Signal zu hoch','-','2022-05-11T11:16:26.864548Z',0),
  ('BPNL00000003COJN',0,'07cc7684-2fb1-4d4f-8055-f6233b60d4f3','P0B49','Hybridantriebsbatterie-Spannungssensor C - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.868890Z',0),
  ('BPNL00000003COJN',0,'34646c5f-88f8-4d8a-9641-4cf1601e204a','P0B4A','Hybridantriebsbatterie-Spannungssensor D - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.873672Z',0),
  ('BPNL00000003COJN',0,'4dd130c3-664c-4537-b8ad-986c5702654c','P0B4B','Hybridantriebsbatterie-Spannungssensor D - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.877834Z',0),
  ('BPNL00000003COJN',0,'8a5c70b1-d148-4f2c-9783-51175f9aa507','P0B4C','Hybridantriebsbatterie-Spannungssensor D - Signal zu niedrig','-','2022-05-11T11:16:26.882515Z',0),
  ('BPNL00000003COJN',0,'78471ce9-1eba-48b8-8c62-028754200890','P0B4D','Hybridantriebsbatterie-Spannungssensor D - Signal zu hoch','-','2022-05-11T11:16:26.886811Z',0),
  ('BPNL00000003COJN',0,'2f78e179-2ca7-49ec-b97e-c1dda9d17f04','P0B4E','Hybridantriebsbatterie-Spannungssensor D - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.890902Z',0),
  ('BPNL00000003COJN',0,'6df1715e-08c1-4333-8c59-b6681b1cfea3','P0B4F','Hybridantriebsbatterie-Spannungssensor E - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.895267Z',0),
  ('BPNL00000003COJN',0,'aad768b7-b1d0-47d4-bc9e-323b4fb2b263','P0B50','Hybridantriebsbatterie-Spannungssensor E - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.899393Z',0),
  ('BPNL00000003COJN',0,'516c16f8-ef42-45b2-aba8-214cfe511191','P0B51','Hybridantriebsbatterie-Spannungssensor E - Signal zu niedrig','-','2022-05-11T11:16:26.903978Z',0),
  ('BPNL00000003COJN',0,'e056390e-0be4-470f-8e86-444de7ce28e4','P0B52','Hybridantriebsbatterie-Spannungssensor E - Signal zu hoch','-','2022-05-11T11:16:26.908212Z',0),
  ('BPNL00000003COJN',0,'2edf45f5-88a1-4263-8eb6-eea4267194d5','P0B53','Hybridantriebsbatterie-Spannungssensor E - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.912571Z',0),
  ('BPNL00000003COJN',0,'f86f179a-64ad-4a95-adf1-373d9906bda4','P0B54','Hybridantriebsbatterie-Spannungssensor F - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.916611Z',0),
  ('BPNL00000003COJN',0,'fb96cf73-5e21-4260-a834-b36d16cac20b','P0B55','Hybridantriebsbatterie-Spannungssensor F - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.920666Z',0),
  ('BPNL00000003COJN',0,'f5b90085-3640-4caf-921f-fed65d947cc4','P0B56','Hybridantriebsbatterie-Spannungssensor F - Signal zu niedrig','-','2022-05-11T11:16:26.925960Z',0),
  ('BPNL00000003COJN',0,'5de7d8c6-26ed-4c51-b901-a2bb823e8f7f','P0B57','Hybridantriebsbatterie-Spannungssensor F - Signal zu hoch','-','2022-05-11T11:16:26.930440Z',0),
  ('BPNL00000003COJN',0,'609062ed-e916-4df8-9024-178ead67e407','P0B58','Hybridantriebsbatterie-Spannungssensor F - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.934908Z',0),
  ('BPNL00000003COJN',0,'4aca5df1-5261-4056-9a9a-8ba314ea2c9d','P0B59','Hybridantriebsbatterie-Spannungssensor G - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.939719Z',0),
  ('BPNL00000003COJN',0,'de28dcd9-b645-417d-ac7a-b0500183e135','P0B5A','Hybridantriebsbatterie-Spannungssensor G - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.944204Z',0),
  ('BPNL00000003COJN',0,'7c5fc3f0-02df-4ea3-af44-1088fa303902','P0B5B','Hybridantriebsbatterie-Spannungssensor G - Signal zu niedrig','-','2022-05-11T11:16:26.948363Z',0),
  ('BPNL00000003COJN',0,'3ffd1860-ced9-4a5a-8e10-a835e0fd1718','P0B5C','Hybridantriebsbatterie-Spannungssensor G - Signal zu hoch','-','2022-05-11T11:16:26.952501Z',0),
  ('BPNL00000003COJN',0,'83a20cd7-06c9-4ba6-8345-273b4685590b','P0B5D','Hybridantriebsbatterie-Spannungssensor G - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.956779Z',0),
  ('BPNL00000003COJN',0,'9e60e7b5-c656-4f61-8c62-7081b9d23e24','P0B5E','Hybridantriebsbatterie-Spannungssensor H - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.961164Z',0),
  ('BPNL00000003COJN',0,'1d5f4e2b-255e-451a-b22e-db2e539692f9','P0B5F','Hybridantriebsbatterie-Spannungssensor H - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.965343Z',0),
  ('BPNL00000003COJN',0,'b4121dca-fdda-41b2-a959-c114662f194d','P0B60','Hybridantriebsbatterie-Spannungssensor H - Signal zu niedrig','-','2022-05-11T11:16:26.970308Z',0),
  ('BPNL00000003COJN',0,'375476a3-d7c2-4e35-8e87-8ec9cd4a7256','P0B61','Hybridantriebsbatterie-Spannungssensor H - Signal zu hoch','-','2022-05-11T11:16:26.974854Z',0),
  ('BPNL00000003COJN',0,'a43bbe6d-18b5-48b6-ad75-581d30bb5711','P0B62','Hybridantriebsbatterie-Spannungssensor H - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:26.979761Z',0),
  ('BPNL00000003COJN',0,'ff6360be-f3c6-4a15-877f-5cea4fb6c6ba','P0B63','Hybridantriebsbatterie-Spannungssensor I - Fehlfunktion Stromkreis','-','2022-05-11T11:16:26.984461Z',0),
  ('BPNL00000003COJN',0,'928621ca-bc79-43a6-8820-0649e990a406','P0B64','Hybridantriebsbatterie-Spannungssensor I - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:26.989642Z',0),
  ('BPNL00000003COJN',0,'99a8c642-4add-4034-82a8-67736ad708dd','P0B65','Hybridantriebsbatterie-Spannungssensor I - Signal zu niedrig','-','2022-05-11T11:16:26.993846Z',0),
  ('BPNL00000003COJN',0,'fa08673b-7e47-4913-86f2-162f9cbb35dc','P0B66','Hybridantriebsbatterie-Spannungssensor I - Signal zu hoch','-','2022-05-11T11:16:26.998352Z',0),
  ('BPNL00000003COJN',0,'fa07981d-f79b-4865-a043-a1d8b1f51694','P0B67','Hybridantriebsbatterie-Spannungssensor I - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.002437Z',0),
  ('BPNL00000003COJN',0,'f06d036b-572a-45be-b210-ccb76c59ac36','P0B68','Hybridantriebsbatterie-Spannungssensor J - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.007121Z',0),
  ('BPNL00000003COJN',0,'eb67f038-dea9-4cf3-b714-86b06be57dce','P0B69','Hybridantriebsbatterie-Spannungssensor J - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.012043Z',0),
  ('BPNL00000003COJN',0,'198fbdce-0d46-4417-ac5f-0e74843b6eb3','P0B6A','Hybridantriebsbatterie-Spannungssensor J - Signal zu niedrig','-','2022-05-11T11:16:27.016427Z',0),
  ('BPNL00000003COJN',0,'c9165cdf-7390-4e6d-be2b-ba2b9f52dd89','P0B6B','Hybridantriebsbatterie-Spannungssensor J - Signal zu hoch','-','2022-05-11T11:16:27.021529Z',0),
  ('BPNL00000003COJN',0,'542aa737-921f-4af8-9058-adb7d01ef728','P0B6C','Hybridantriebsbatterie-Spannungssensor J - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.026650Z',0),
  ('BPNL00000003COJN',0,'5cf65f8a-6537-4300-874b-129c21e7c81b','P0B6D','Hybridantriebsbatterie-Spannungssensor K - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.031101Z',0),
  ('BPNL00000003COJN',0,'9a882b00-bef9-4ead-9745-bf31ed78df68','P0B6E','Hybridantriebsbatterie-Spannungssensor K - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.035333Z',0),
  ('BPNL00000003COJN',0,'f8bc1b62-9734-4dec-baf6-51d669c193f1','P0B6F','Hybridantriebsbatterie-Spannungssensor K - Signal zu niedrig','-','2022-05-11T11:16:27.041778Z',0),
  ('BPNL00000003COJN',0,'b7d5b5d7-e102-4ce6-9e4c-4e42812865e5','P0B70','Hybridantriebsbatterie-Spannungssensor K - Signal zu hoch','-','2022-05-11T11:16:27.046670Z',0),
  ('BPNL00000003COJN',0,'6a8a19c5-4267-4f8d-b605-0723bb96d508','P0B71','Hybridantriebsbatterie-Spannungssensor K - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.052062Z',0),
  ('BPNL00000003COJN',0,'d29ab7d3-e05a-4c96-8e6c-08464ace8f19','P0B72','Hybridantriebsbatterie-Spannungssensor L - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.057100Z',0),
  ('BPNL00000003COJN',0,'e762ca78-8063-4e61-b531-135995d536c3','P0B73','Hybridantriebsbatterie-Spannungssensor L - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.062664Z',0),
  ('BPNL00000003COJN',0,'4f1ceebe-3992-4ba4-8024-0071a40e32d6','P0B74','Hybridantriebsbatterie-Spannungssensor L - Signal zu niedrig','-','2022-05-11T11:16:27.067242Z',0),
  ('BPNL00000003COJN',0,'72fef1c7-8135-4450-83cf-6548c6b43de2','P0B75','Hybridantriebsbatterie-Spannungssensor L - Signal zu hoch','-','2022-05-11T11:16:27.071691Z',0),
  ('BPNL00000003COJN',0,'3ad667fe-6053-4c7a-af8b-8f45b8efa873','P0B76','Hybridantriebsbatterie-Spannungssensor L - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.076335Z',0),
  ('BPNL00000003COJN',0,'ed64a957-157a-42b8-8869-df26c7eb6f95','P0B77','Hybridantriebsbatterie-Spannungssensor M - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.080298Z',0),
  ('BPNL00000003COJN',0,'0484ed9c-175a-4700-bbb4-74a4024a1b95','P0B78','Hybridantriebsbatterie-Spannungssensor M - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.084390Z',0),
  ('BPNL00000003COJN',0,'4982e366-b29b-4ec4-86a4-8cf0f9df4047','P0B7A','Hybridantriebsbatterie-Spannungssensor M - Signal zu hoch','-','2022-05-11T11:16:27.098555Z',0),
  ('BPNL00000003COJN',0,'7a4bd88a-1243-4cc5-9296-1e8eddb23bcc','P0B7B','Hybridantriebsbatterie-Spannungssensor M - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.103110Z',0),
  ('BPNL00000003COJN',0,'99982a18-b0c1-47a4-990b-5410908c89b9','P0B7C','Hybridantriebsbatterie-Spannungssensor N - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.107091Z',0),
  ('BPNL00000003COJN',0,'f9aa8741-a400-4f53-bdc3-f6485076a7e9','P0B7D','Hybridantriebsbatterie-Spannungssensor N - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.111284Z',0),
  ('BPNL00000003COJN',0,'39b4559a-5382-42e9-83f2-1331a922c576','P0B7E','Hybridantriebsbatterie-Spannungssensor N - Signal zu niedrig','-','2022-05-11T11:16:27.115654Z',0),
  ('BPNL00000003COJN',0,'bd9ab6ab-ce1c-41a4-9975-1923f85449e7','P0B7F','Hybridantriebsbatterie-Spannungssensor N - Signal zu hoch','-','2022-05-11T11:16:27.120368Z',0),
  ('BPNL00000003COJN',0,'dfd1334e-eb52-4e0d-84c6-d7bc14e0ab4a','P0B80','Hybridantriebsbatterie-Spannungssensor N - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.132614Z',0),
  ('BPNL00000003COJN',0,'8773b1fb-0bcd-4cab-8ce0-28b8f2a2b6b0','P0B81','Hybridantriebsbatterie-Spannungssensor O - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.138703Z',0),
  ('BPNL00000003COJN',0,'d70bea17-27e1-4581-93a2-650791f26344','P0B82','Hybridantriebsbatterie-Spannungssensor O - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.142933Z',0),
  ('BPNL00000003COJN',0,'c34177d5-8b71-4f69-869a-3e1bc3fa2e01','P0B83','Hybridantriebsbatterie-Spannungssensor O - Signal zu niedrig','-','2022-05-11T11:16:27.147123Z',0),
  ('BPNL00000003COJN',0,'da0435ff-4dcf-4674-89f5-c9106a4debee','P0B84','Hybridantriebsbatterie-Spannungssensor O - Signal zu hoch','-','2022-05-11T11:16:27.151219Z',0),
  ('BPNL00000003COJN',0,'39a2ddcf-53fd-4098-ae04-f7c2026cd029','P0B85','Hybridantriebsbatterie-Spannungssensor O - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.155731Z',0),
  ('BPNL00000003COJN',0,'96eb00cf-a838-49a7-92ee-e33bf6d0b0c5','P0B86','Hybridantriebsbatterie-Spannungssensor P - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.160072Z',0),
  ('BPNL00000003COJN',0,'5bfc58bb-a2fb-4b98-ae35-eadb699eca5c','P0B87','Hybridantriebsbatterie-Spannungssensor P - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.164832Z',0),
  ('BPNL00000003COJN',0,'028c0f84-6788-4c9b-aac6-ea56ce93a7b8','P0B88','Hybridantriebsbatterie-Spannungssensor P - Signal zu niedrig','-','2022-05-11T11:16:27.169401Z',0),
  ('BPNL00000003COJN',0,'ba73bf8b-cd3a-4f46-bc61-2fc81ed60583','P0B89','Hybridantriebsbatterie-Spannungssensor P - Signal zu hoch','-','2022-05-11T11:16:27.174143Z',0),
  ('BPNL00000003COJN',0,'d09c9dd4-7af2-424e-a460-a4b143de33c5','P0B8A','Hybridantriebsbatterie-Spannungssensor P - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.178585Z',0),
  ('BPNL00000003COJN',0,'bbd8569a-1d3f-4fc0-b80e-1c06f6fdb363','P0B8B','Hybridantriebsbatterie-Spannungssensor Q - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.182932Z',0),
  ('BPNL00000003COJN',0,'3c0f42af-9950-4392-94da-163f6e3f0e6d','P0B8C','Hybridantriebsbatterie-Spannungssensor Q - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.187279Z',0),
  ('BPNL00000003COJN',0,'a45b4e30-d136-4c01-94ff-b4af1cd33170','P0B8D','Hybridantriebsbatterie-Spannungssensor Q - Signal zu niedrig','-','2022-05-11T11:16:27.192287Z',0),
  ('BPNL00000003COJN',0,'f9aaa98b-c4c4-4980-b310-9d10afa556e2','P0B8E','Hybridantriebsbatterie-Spannungssensor Q - Signal zu hoch','-','2022-05-11T11:16:27.197650Z',0),
  ('BPNL00000003COJN',0,'97315b83-41fe-448b-90e4-2e5335a56c0f','P0B8F','Hybridantriebsbatterie-Spannungssensor Q - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.201887Z',0),
  ('BPNL00000003COJN',0,'6804347b-b487-4df6-b1ea-2664400e7eb8','P0B90','Hybridantriebsbatterie-Spannungssensor R - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.206082Z',0),
  ('BPNL00000003COJN',0,'785bb095-2bd8-4732-bda8-57d5a800dc2c','P0B91','Hybridantriebsbatterie-Spannungssensor R - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.210536Z',0),
  ('BPNL00000003COJN',0,'4b687a79-3a8e-4f4f-8117-2624161e141d','P0B92','Hybridantriebsbatterie-Spannungssensor R - Signal zu niedrig','-','2022-05-11T11:16:27.214700Z',0),
  ('BPNL00000003COJN',0,'c5c5b0c8-6bf3-4387-9aed-7aa233e5957f','P0B93','Hybridantriebsbatterie-Spannungssensor R - Signal zu hoch','-','2022-05-11T11:16:27.219003Z',0),
  ('BPNL00000003COJN',0,'ae1fa333-d8cd-46bd-8f14-7ffd403b8d0d','P0B94','Hybridantriebsbatterie-Spannungssensor R - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.225499Z',0),
  ('BPNL00000003COJN',0,'2ed7761c-adb4-4383-83b1-249f746e56cd','P0B95','Hybridantriebsbatterie-Spannungssensor S - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.236562Z',0),
  ('BPNL00000003COJN',0,'e290b81c-033e-4b0c-b98d-43943039a042','P0B96','Hybridantriebsbatterie-Spannungssensor S - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.240762Z',0),
  ('BPNL00000003COJN',0,'714d5ee8-2ed5-424a-b672-196a92c3f687','P0B97','Hybridantriebsbatterie-Spannungssensor S - Signal zu niedrig','-','2022-05-11T11:16:27.245841Z',0),
  ('BPNL00000003COJN',0,'76dcdab3-a24c-48f1-8513-35e09231afea','P0B98','Hybridantriebsbatterie-Spannungssensor S - Signal zu hoch','-','2022-05-11T11:16:27.250623Z',0),
  ('BPNL00000003COJN',0,'6f88a49c-bd9c-443e-84c6-45634a39c98d','P0B99','Hybridantriebsbatterie-Spannungssensor S - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.255Z',0),
  ('BPNL00000003COJN',0,'3bed924d-93f3-4f09-90a0-7157f2b078c0','P0B9A','Hybridantriebsbatterie-Spannungssensor T - Stromkreis','-','2022-05-11T11:16:27.259676Z',0),
  ('BPNL00000003COJN',0,'280b6085-1d95-4b03-a500-3a0f6cf98189','P0B9B','Hybridantriebsbatterie-Spannungssensor T - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.264369Z',0),
  ('BPNL00000003COJN',0,'1e229ed9-ff2d-46ef-b3bf-750ffdc47d11','P0B9C','Hybridantriebsbatterie-Spannungssensor T - Signal zu niedrig','-','2022-05-11T11:16:27.269134Z',0),
  ('BPNL00000003COJN',0,'fb0fa89a-85c9-4328-b741-fb72da9de30b','P0B9D','Hybridantriebsbatterie-Spannungssensor T - Signal zu hoch','-','2022-05-11T11:16:27.273882Z',0),
  ('BPNL00000003COJN',0,'910e56c0-4f3d-48f9-a269-a490bc8c42d2','P0B9E','Hybridantriebsbatterie-Spannungssensor T - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.281900Z',0),
  ('BPNL00000003COJN',0,'f3d89906-17ef-47ca-a185-3530cab9db78','P0B9F','Hybridantriebsbatterie-Spannungssensor U - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.286886Z',0),
  ('BPNL00000003COJN',0,'d4234824-eb79-4caf-a8ed-9d8bc665ebaa','P0BA0','Hybridantriebsbatterie-Spannungssensor U - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.291160Z',0),
  ('BPNL00000003COJN',0,'c229715f-51c8-4344-af12-882eac002695','P0BA1','Hybridantriebsbatterie-Spannungssensor U - Signal zu niedrig','-','2022-05-11T11:16:27.295551Z',0),
  ('BPNL00000003COJN',0,'6d9ade6a-a5b3-448f-b4a9-eebf75e3c720','P0BA2','Hybridantriebsbatterie-Spannungssensor U - Signal zu hoch','-','2022-05-11T11:16:27.300535Z',0),
  ('BPNL00000003COJN',0,'80fcdba7-b1b0-4d1f-99a3-587ea2fb65f2','P0BA3','Hybridantriebsbatterie-Spannungssensor U - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.306966Z',0),
  ('BPNL00000003COJN',0,'97745c05-1a1e-4259-93aa-757a94f0132b','P0BA4','Hybridantriebsbatterie-Spannungssensor V - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.311510Z',0),
  ('BPNL00000003COJN',0,'6574e2bc-e6e2-4de0-828c-410c67a711a4','P0BA5','Hybridantriebsbatterie-Spannungssensor V - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.318467Z',0),
  ('BPNL00000003COJN',0,'5da371ad-b7a8-4300-b2c5-244f548d98c0','P0BA6','Hybridantriebsbatterie-Spannungssensor V - Signal zu niedrig','-','2022-05-11T11:16:27.322951Z',0),
  ('BPNL00000003COJN',0,'9966a3fa-6337-4058-b399-0e1267ca42eb','P0BA7','Hybridantriebsbatterie-Spannungssensor V - Signal zu hoch','-','2022-05-11T11:16:27.328628Z',0),
  ('BPNL00000003COJN',0,'aca35411-8b8d-45da-b3d8-9c9eb7d678ea','P0BA8','Hybridantriebsbatterie-Spannungssensor V - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.333345Z',0),
  ('BPNL00000003COJN',0,'23a839f6-b212-4169-af94-e5687016031a','P0BA9','Hybridantriebsbatterie-Spannungssensor W - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.338297Z',0),
  ('BPNL00000003COJN',0,'95483f5f-cceb-4663-b24d-12e014cd1d7f','P0BAA','Hybridantriebsbatterie-Spannungssensor W - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.342975Z',0),
  ('BPNL00000003COJN',0,'713264d8-6194-4f5f-8724-dfeedea92c55','P0BAB','Hybridantriebsbatterie-Spannungssensor W - Signal zu niedrig','-','2022-05-11T11:16:27.352359Z',0),
  ('BPNL00000003COJN',0,'fbc04790-aae6-478e-9cd4-44c530c6938e','P0BAC','Hybridantriebsbatterie-Spannungssensor W - Signal zu hoch','-','2022-05-11T11:16:27.362699Z',0),
  ('BPNL00000003COJN',0,'97329d36-c5e5-4770-a8d5-daac15cb02f4','P0BAD','Hybridantriebsbatterie-Spannungssensor W - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.372442Z',0),
  ('BPNL00000003COJN',0,'70371610-f494-4ba0-aa92-25a85d6be8e9','P0BAE','Hybridantriebsbatterie-Spannungssensor X - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.381360Z',0),
  ('BPNL00000003COJN',0,'300a0bbe-ff75-42c1-857a-40d665284086','P0BAF','Hybridantriebsbatterie-Spannungssensor X - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.389719Z',0),
  ('BPNL00000003COJN',0,'9cac79b9-300a-4562-93f7-73a31c332911','P0BB0','Hybridantriebsbatterie-Spannungssensor X - Signal zu niedrig','-','2022-05-11T11:16:27.411063Z',0),
  ('BPNL00000003COJN',0,'e2b4e0d7-31c8-4d92-a9b8-5922171492b2','P0BB1','Hybridantriebsbatterie-Spannungssensor X - Signal zu hoch','-','2022-05-11T11:16:27.424018Z',0),
  ('BPNL00000003COJN',0,'5489a270-d4d8-47dd-8fce-19ad886b2273','P0BB2','Hybridantriebsbatterie-Spannungssensor X - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.428787Z',0),
  ('BPNL00000003COJN',0,'5334358f-be9a-4bf8-8a8a-e75d228e8359','P0BB3','Hybridantriebsbatterie-Spannungssensor Y - Stromkreis','-','2022-05-11T11:16:27.434793Z',0),
  ('BPNL00000003COJN',0,'6841de79-ed44-4560-841d-d50e31719bdc','P0BB4','Hybridantriebsbatterie-Spannungssensor Y - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.438750Z',0),
  ('BPNL00000003COJN',0,'d6a37e94-ea7b-4c1a-a6cd-1781b27d68f2','P0BB5','Hybridantriebsbatterie-Spannungssensor Y - Signal zu niedrig','-','2022-05-11T11:16:27.443091Z',0),
  ('BPNL00000003COJN',0,'59174476-84c1-4544-9cb2-11985798ecad','P0BB6','Hybridantriebsbatterie-Spannungssensor Y - Signal zu hoch','-','2022-05-11T11:16:27.448459Z',0),
  ('BPNL00000003COJN',0,'1a193967-4cf3-469c-bfc3-9254068ce976','P0BB7','Hybridantriebsbatterie-Spannungssensor Y - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.454204Z',0),
  ('BPNL00000003COJN',0,'04031075-bca0-4081-ba71-573089431146','P0BB8','Hybridantriebsbatterie-Spannungssensor Z - Stromkreis','-','2022-05-11T11:16:27.458722Z',0),
  ('BPNL00000003COJN',0,'1a6a0d9b-6383-44a7-9eee-f39f198695f1','P0BB9','Hybridantriebsbatterie-Spannungssensor Z - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.462635Z',0),
  ('BPNL00000003COJN',0,'33a73fde-5e7a-4618-b61b-129cc9dfa2f9','P0BBA','Hybridantriebsbatterie-Spannungssensor Z - Signal zu niedrig','-','2022-05-11T11:16:27.467434Z',0),
  ('BPNL00000003COJN',0,'7159d71c-0d33-4f47-9d83-e9c9be8031ef','P0BBB','Hybridantriebsbatterie-Spannungssensor Z - Signal zu hoch','-','2022-05-11T11:16:27.472285Z',0),
  ('BPNL00000003COJN',0,'d372eaf1-241c-4bb8-973f-720492126f78','P0BBC','Hybridantriebsbatterie-Spannungssensor Z - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.476817Z',0),
  ('BPNL00000003COJN',0,'577891bb-7ae7-4b0e-8359-55b211fa0c00','P0BBD','Hybridantriebsbatteriepack - Grenzwert der Spannungsabweichungen überschritten','-','2022-05-11T11:16:27.480987Z',0),
  ('BPNL00000003COJN',0,'b5a4904d-a21c-465d-83c5-7a8e8b1c37b6','P0BBE','Hybridantriebsbatteriepack - Spannungsabweichung','-','2022-05-11T11:16:27.485718Z',0),
  ('BPNL00000003COJN',0,'9f44ded6-3b13-4e94-9a63-cadff6d66d8e','P0BBF','Hybridantriebsbatteriepack-Kühlgebläse - Fehlfunktion Versorgungsspannung','-','2022-05-11T11:16:27.490220Z',0),
  ('BPNL00000003COJN',0,'7b65054a-aa2f-46cc-a6d9-cc3a86a95682','P0BC0','Hybridantriebsbatteriepack-Kühlgebläse - Versorgungsspannung zu niedrig','-','2022-05-11T11:16:27.494363Z',0),
  ('BPNL00000003COJN',0,'40af1cfa-98fc-42a4-87b0-1b95a72cca7e','P0BC1','Hybridantriebsbatteriepack-Kühlgebläse - Versorgungsspannung zu hoch','-','2022-05-11T11:16:27.498705Z',0),
  ('BPNL00000003COJN',0,'d6a79ae6-9346-4d2e-bf03-ffa41af0f43e','P0BC2','Hybridantriebsbatterie-Temperatursensor E - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.504606Z',0),
  ('BPNL00000003COJN',0,'16f8d396-86dc-4601-93a1-b55abe4062a9','P0BC3','Hybridantriebsbatterie-Temperatursensor E - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.509142Z',0),
  ('BPNL00000003COJN',0,'d9d28d54-649b-4864-8033-8c097043ea7d','P0BC4','Hybridantriebsbatterie-Temperatursensor E - Signal zu niedrig','-','2022-05-11T11:16:27.514237Z',0),
  ('BPNL00000003COJN',0,'47f46280-68ec-40b7-947c-6410e6958530','P0BC5','Hybridantriebsbatterie-Temperatursensor E - Signal zu hoch','-','2022-05-11T11:16:27.518865Z',0),
  ('BPNL00000003COJN',0,'331c7629-d379-472c-955e-0dbae57ae344','P0BC6','Hybridantriebsbatterie-Temperatursensor E - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.524211Z',0),
  ('BPNL00000003COJN',0,'c7418ba1-b323-47cf-8187-f3d0e3b004ee','P0BC7','Hybridantriebsbatteriepack-Kühlgebläsesensor - offener Stromkreis','-','2022-05-11T11:16:27.529138Z',0),
  ('BPNL00000003COJN',0,'0e9d545c-6ac5-49b2-8dc8-5ecd06447d52','P0BC8','Hybridantriebsbatteriepack-Kühlgebläsesensor - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.534283Z',0),
  ('BPNL00000003COJN',0,'2a72227f-07e0-44f9-bb09-dc7b330e7c37','P0BC9','Hybridantriebsbatteriepack-Kühlgebläsesensor - Signal zu niedrig','-','2022-05-11T11:16:27.538779Z',0),
  ('BPNL00000003COJN',0,'c0f5176e-2f09-4de0-8819-55800c2b7d47','P0BCA','Hybridantriebsbatteriepack-Kühlgebläsesensor - Signal zu hoch','-','2022-05-11T11:16:27.543445Z',0),
  ('BPNL00000003COJN',0,'8fa613c2-222c-4131-bc59-7b2ba3fc4535','P0BCB','Hybridantriebsbatteriepack-Kühlgebläsesensor - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.547806Z',0),
  ('BPNL00000003COJN',0,'de42f85d-29d7-4378-8203-53224d789f46','P0BCC','Generator-Temperatursensor - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.552588Z',0),
  ('BPNL00000003COJN',0,'fa17443d-2a55-486f-b6ab-0275804bd6fb','P0BCD','Temperatursensor für Generator-Inverter - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.556812Z',0),
  ('BPNL00000003COJN',0,'d995afbd-a609-4c97-9d04-957dc1b71c32','P0BCE','Temperatursensor für Generator-Inverter - Signal zu niedrig','-','2022-05-11T11:16:27.561166Z',0),
  ('BPNL00000003COJN',0,'db4bb2d5-4eb7-46bc-b17c-cdc3d4f9ea0c','P0BCF','Generator-Temperatursensor - Signal zu hoch','-','2022-05-11T11:16:27.566631Z',0),
  ('BPNL00000003COJN',0,'72bd1c2f-0e6e-49d3-9808-65e3060603d2','P0BD0','Temperatursensor für Generator-Inverter - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.571156Z',0),
  ('BPNL00000003COJN',0,'1e2d7f6e-3452-4ed4-998c-8b81a5fbe23c','P0BD1','Temperatursensor für Antriebsmotor-Inverter C - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.575430Z',0),
  ('BPNL00000003COJN',0,'bf3e5edd-d1bf-435b-90de-61324f7482d5','P0BD2','Temperatursensor für Antriebsmotor-Inverter C - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.580029Z',0),
  ('BPNL00000003COJN',0,'e486ccf7-dd23-4655-a9a9-ea5c14605d86','P0BD3','Temperatursensor für Antriebsmotor-Inverter C - Signal zu niedrig','-','2022-05-11T11:16:27.584706Z',0),
  ('BPNL00000003COJN',0,'cd26486b-4b9e-477f-ba2f-4ea339fbb2ab','P0BD4','Temperatursensor für Antriebsmotor-Inverter C - Signal zu hoch','-','2022-05-11T11:16:27.588959Z',0),
  ('BPNL00000003COJN',0,'e5f25483-caad-4b61-aeff-300ec6743ac8','P0BD5','Temperatursensor für Antriebsmotor-Inverter C - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.594548Z',0),
  ('BPNL00000003COJN',0,'f75f6789-5c9c-40f1-8867-af1ba21a4560','P0BD6','Temperatursensor für Antriebsmotor-Inverter D - Stromkreis','-','2022-05-11T11:16:27.599011Z',0),
  ('BPNL00000003COJN',0,'b2ddd1e2-36c7-411e-bd13-17e310e3ce3b','P0BD7','Temperatursensor für Antriebsmotor-Inverter D - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.602978Z',0),
  ('BPNL00000003COJN',0,'d705d96e-ad18-42bb-916b-240c0fb8b8f4','P0BD8','Temperatursensor für Antriebsmotor-Inverter D - Signal zu niedrig','-','2022-05-11T11:16:27.607338Z',0),
  ('BPNL00000003COJN',0,'c43e71cd-690d-40f5-b1aa-679c412e7997','P0BD9','Temperatursensor für Antriebsmotor-Inverter D - Signal zu hoch','-','2022-05-11T11:16:27.611725Z',0),
  ('BPNL00000003COJN',0,'6847a624-9894-4851-965a-7239a3705f56','P0BDA','Temperatursensor für Antriebsmotor-Inverter D - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.615901Z',0),
  ('BPNL00000003COJN',0,'b0074f4e-ffc8-4a69-acf0-0c33ac13c3b1','P0BDB','Temperatursensor für Antriebsmotor-Inverter E - Fehlfunktion Stromkreis','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.620163Z',0),
  ('BPNL00000003COJN',0,'660d4047-7f9c-40a1-a148-dc9d8759a598','P0BDC','Temperatursensor für Antriebsmotor-Inverter E - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.624661Z',0),
  ('BPNL00000003COJN',0,'65af5e91-6a54-45b3-9fa6-d3f13f3274bc','P0BDD','Temperatursensor für Antriebsmotor-Inverter E - Signal zu niedrig','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.629883Z',0),
  ('BPNL00000003COJN',0,'c7b5c16d-8d5c-42ac-a9d2-1934f998ef03','P0BDE','Temperatursensor für Antriebsmotor-Inverter E - Signal zu hoch','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.634390Z',0),
  ('BPNL00000003COJN',0,'fb3d19ee-dfa9-44f0-adaf-79330b105c30','P0BDF','Temperatursensor für Antriebsmotor-Inverter E - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.638712Z',0),
  ('BPNL00000003COJN',0,'1ee3fb3f-bec9-4ee5-85d8-2ea6a646e5ef','P0BE0','Temperatursensor für Antriebsmotor-Inverter F - Fehlfunktion Stromkreis','Kabelbaum, Temperatursensor für Antriebsmotor-Inverter','2022-05-11T11:16:27.642930Z',0),
  ('BPNL00000003COJN',0,'e16bfff5-b12c-4b0b-9ab8-db39cc31628e','P0BE1','Temperatursensor für Antriebsmotor-Inverter F - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.647488Z',0),
  ('BPNL00000003COJN',0,'5f02e1fb-0796-42d6-971c-a771eb0ce708','P0BE2','Temperatursensor für Antriebsmotor-Inverter F - Signal zu niedrig','-','2022-05-11T11:16:27.651636Z',0),
  ('BPNL00000003COJN',0,'8b78cb7d-ff48-4099-98d9-e3f58426f921','P0BE3','Temperatursensor für Antriebsmotor-Inverter F - Signal zu hoch','-','2022-05-11T11:16:27.658405Z',0),
  ('BPNL00000003COJN',0,'72b2fd45-0b56-4c03-a208-c9ef07fd5856','P0BE4','Temperatursensor für Antriebsmotor-Inverter F - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:27.662944Z',0),
  ('BPNL00000003COJN',0,'e28312bf-34b9-46e0-be23-8be680533293','P0BE5','Antriebsmotor A, Stromsensor für Phasenleitung U - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.667211Z',0),
  ('BPNL00000003COJN',0,'e830e145-2588-4b80-a8a4-48d353454099','P0BE6','Antriebsmotor A, Stromsensor für Phasenleitung U - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.671600Z',0),
  ('BPNL00000003COJN',0,'e846a50e-e7ad-44f8-bffa-aa57f6f98ea7','P0BE7','Antriebsmotor A, Stromsensor für Phasenleitung U - Signal zu niedrig','-','2022-05-11T11:16:27.676407Z',0),
  ('BPNL00000003COJN',0,'330f8c11-49ca-4eb1-a935-bbfd2f531f64','P0BE8','Antriebsmotor A, Stromsensor für Phasenleitung U - Signal zu hoch','-','2022-05-11T11:16:27.681015Z',0),
  ('BPNL00000003COJN',0,'7850915f-a8a3-4158-a8e8-6156302d8449','P0BE9','Antriebsmotor A, Stromsensor für Phasenleitung V - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.685482Z',0),
  ('BPNL00000003COJN',0,'412dd280-9bf1-476d-b4bc-419973ef878c','P0BEA','Antriebsmotor A, Stromsensor für Phasenleitung V - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.690170Z',0),
  ('BPNL00000003COJN',0,'599fe5fc-bc00-476c-9678-2098538cdc5c','P0BEB','Antriebsmotor A, Stromsensor für Phasenleitung V - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.694691Z',0),
  ('BPNL00000003COJN',0,'5ed85717-4802-4e32-a333-7b8c7508c28d','P0BEC','Antriebsmotor A, Stromsensor für Phasenleitung V - Signal zu hoch','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.699898Z',0),
  ('BPNL00000003COJN',0,'15dca0bb-9e84-41fd-80f1-4fc06d057c71','P0BED','Antriebsmotor A, Stromsensor für Phasenleitung W - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.704448Z',0),
  ('BPNL00000003COJN',0,'1868b15c-1380-415d-8c6d-99cf75720141','P0BEE','Antriebsmotor A, Stromsensor für Phasenleitung W - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.709032Z',0),
  ('BPNL00000003COJN',0,'8ba820a2-2c83-4dcb-b166-5e279dbc011a','P0BEF','Antriebsmotor A, Stromsensor für Phasenleitung W - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.713205Z',0),
  ('BPNL00000003COJN',0,'8d573932-9b80-47bb-9171-1646db12d2ec','P0BF0','Antriebsmotor A, Stromsensor für Phasenleitung W - Signal zu hoch','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.717512Z',0),
  ('BPNL00000003COJN',0,'002d2984-80a8-475b-9153-a757788badd2','P0BF1','Antriebsmotor B, Stromsensor für Phasenleitung U - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.721751Z',0),
  ('BPNL00000003COJN',0,'63c0169c-97b9-46ea-881e-ff0915c63166','P0BF2','Antriebsmotor B, Stromsensor für Phasenleitung U - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.725595Z',0),
  ('BPNL00000003COJN',0,'de826b41-654f-43db-b0c2-6b1cf9d1148e','P0BF3','Antriebsmotor B, Stromsensor für Phasenleitung U - Signal zu niedrig','-','2022-05-11T11:16:27.730309Z',0),
  ('BPNL00000003COJN',0,'139bb6a0-5a2b-4a37-8ccf-db22ec73d9a2','P0BF4','Antriebsmotor B, Stromsensor für Phasenleitung U - Signal zu hoch','-','2022-05-11T11:16:27.734479Z',0),
  ('BPNL00000003COJN',0,'3f5f29bb-92a0-4b6c-aeef-344a620449aa','P0BF5','Antriebsmotor B, Stromsensor für Phasenleitung V - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.739108Z',0),
  ('BPNL00000003COJN',0,'2ca63d58-2294-4837-8022-d4971408fb8b','P0BF6','Antriebsmotor B, Stromsensor für Phasenleitung V - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.743360Z',0),
  ('BPNL00000003COJN',0,'82d416aa-ae63-408a-8fd0-eb298cabc821','P0BF7','Antriebsmotor B, Stromsensor für Phasenleitung V - Signal zu niedrig','-','2022-05-11T11:16:27.748079Z',0),
  ('BPNL00000003COJN',0,'e96a9abd-c14b-4dc0-b07b-e9ab06f7cacf','P0BF8','Antriebsmotor B, Stromsensor für Phasenleitung V - Signal zu hoch','-','2022-05-11T11:16:27.752519Z',0),
  ('BPNL00000003COJN',0,'5c5b6aa9-c85e-4a4c-9269-6f73312d3e7c','P0BF9','Antriebsmotor B, Stromsensor für Phasenleitung W - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.768114Z',0),
  ('BPNL00000003COJN',0,'007d82f6-8d83-4060-86de-194483bf5acc','P0BFA','Antriebsmotor B, Stromsensor für Phasenleitung W - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.772707Z',0),
  ('BPNL00000003COJN',0,'914f6a03-b9c9-4dbc-951a-cbfbe4ad19ea','P0BFB','Antriebsmotor B, Stromsensor für Phasenleitung W - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.777071Z',0),
  ('BPNL00000003COJN',0,'c3fa5dec-fd2e-461e-9929-84f7fd1952dc','P0BFC','Antriebsmotor B, Stromsensor für Phasenleitung W - Signal zu hoch','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.782147Z',0),
  ('BPNL00000003COJN',0,'a715e78f-9b00-4655-905e-7b4b2941a294','P0BFD','Antriebsmotor A, Stromsensor für Phasenleitungen U/V/W - Bezugsfehler','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.787560Z',0),
  ('BPNL00000003COJN',0,'cbbb52ca-398b-4f91-9e02-d06c4bc7cf9a','P0BFE','Antriebsmotor B, Stromsensor für Phasenleitungen U/V/W - Bezugsfehler','Kabelbaum, Antriebsmotor-Stromsensor','2022-05-11T11:16:27.791915Z',0),
  ('BPNL00000003COJN',0,'4a90871b-4c48-4e8d-b7b6-3c2849bd8926','P0BFF','Antriebsmotor A - Fehlfunktion Stromstärke','Kabelbaum, Antriebsmotor','2022-05-11T11:16:27.796442Z',0),
  ('BPNL00000003COJN',0,'fb478a1e-8092-4236-9bfc-0344d585e842','P0C00','Antriebsmotor A - Stromstärke zu niedrig','-','2022-05-11T11:16:27.803336Z',0),
  ('BPNL00000003COJN',0,'7c7132fc-74d1-496e-af5e-fad3ce1d2a2c','P0C01','Antriebsmotor A - Stromstärke zu hoch','-','2022-05-11T11:16:27.807514Z',0),
  ('BPNL00000003COJN',0,'bb3561f0-210c-4e4a-91e4-5973c76dcc2d','P0C02','Antriebsmotor B - Stromstärke','-','2022-05-11T11:16:27.811564Z',0),
  ('BPNL00000003COJN',0,'c853533e-e778-4cf1-8ede-80e82e9eac34','P0C03','Antriebsmotor B - Stromstärke zu niedrig','-','2022-05-11T11:16:27.815924Z',0),
  ('BPNL00000003COJN',0,'8f5e8e86-2002-42b5-9845-dba11dc9e3a3','P0C04','Antriebsmotor B - Stromstärke zu hoch','-','2022-05-11T11:16:27.820557Z',0),
  ('BPNL00000003COJN',0,'1406acc3-b4af-45e9-9b0a-c02af9fabe35','P0C05','Antriebsmotor A, Stromkreis Phase U/V/W - offener Stromkreis','-','2022-05-11T11:16:27.824831Z',0),
  ('BPNL00000003COJN',0,'68993c0c-8e83-4ad7-89df-1a3a2defa0bb','P0C06','Antriebsmotor A, Stromkreis Phase U/V/W - Signal zu niedrig','-','2022-05-11T11:16:27.828979Z',0),
  ('BPNL00000003COJN',0,'98bf34c0-93aa-4249-aed3-aaeac645ceec','P0C07','Antriebsmotor A, Stromkreis Phase U/V/W - Signal zu hoch','-','2022-05-11T11:16:27.833220Z',0),
  ('BPNL00000003COJN',0,'bb5deb2e-af47-4026-a659-8d3665aaf22f','P0C08','Antriebsmotor B, Stromkreis Phase U/V/W - offener Stromkreis','-','2022-05-11T11:16:27.837400Z',0),
  ('BPNL00000003COJN',0,'b5c0ed7a-054d-4625-8dfb-f50e7185334b','P0C09','Antriebsmotor B, Stromkreis Phase U/V/W - Signal zu niedrig','-','2022-05-11T11:16:27.841933Z',0),
  ('BPNL00000003COJN',0,'050d0af8-505d-4925-9e3b-51cefc3fe974','P0C0A','Antriebsmotor B, Stromkreis Phase U/V/W - Signal zu hoch','-','2022-05-11T11:16:27.846229Z',0),
  ('BPNL00000003COJN',0,'7be08aaa-72ba-4fdd-b82a-af648e7f8b95','P0C0B','Inverter für Antriebsmotor A - Fehlfunktion Versorgungsspannung','-','2022-05-11T11:16:27.850707Z',0),
  ('BPNL00000003COJN',0,'ea91407e-c0f2-4a97-ac51-b178cd891cb6','P0C0C','Inverter für Antriebsmotor A - Versorgungsspannung zu niedrig','-','2022-05-11T11:16:27.854905Z',0),
  ('BPNL00000003COJN',0,'b5f04bf0-621a-44b8-82f3-dac0c8bfa103','P0C0D','Inverter für Antriebsmotor A - Versorgungsspannung zu hoch','-','2022-05-11T11:16:27.859032Z',0),
  ('BPNL00000003COJN',0,'e8c4f1a1-3520-41db-856a-22f388b2e11a','P0C0E','Inverter für Antriebsmotor B - Fehlfunktion Versorgungsspannung','-','2022-05-11T11:16:27.863188Z',0),
  ('BPNL00000003COJN',0,'7c229172-3958-4560-be5a-d98b9d948f17','P0C0F','Inverter für Antriebsmotor B - Versorgungsspannung zu niedrig','-','2022-05-11T11:16:27.867600Z',0),
  ('BPNL00000003COJN',0,'1bdb56a4-5651-4905-b3da-4d30db25062b','P0C10','Inverter für Antriebsmotor B - Versorgungsspannung zu hoch','-','2022-05-11T11:16:27.872346Z',0),
  ('BPNL00000003COJN',0,'d5d476be-6cf2-41ea-b11a-984964996153','P0C11','Inverter für Antriebsmotor A, Stromkreis Phase U - Überhitzung','-','2022-05-11T11:16:27.876896Z',0),
  ('BPNL00000003COJN',0,'c9cfe716-71f7-4823-a3d1-38f42213e11f','P0C12','Inverter für Antriebsmotor A, Stromkreis Phase V - Überhitzung','-','2022-05-11T11:16:27.881295Z',0),
  ('BPNL00000003COJN',0,'a1bc96dd-285b-4635-b104-7609878bb7ec','P0C13','Inverter für Antriebsmotor A, Stromkreis Phase W - Überhitzung','-','2022-05-11T11:16:27.886175Z',0),
  ('BPNL00000003COJN',0,'cd963686-c861-4b13-ad65-3c24013803da','P0C14','Inverter für Antriebsmotor B, Stromkreis Phase U - Überhitzung','-','2022-05-11T11:16:27.890869Z',0),
  ('BPNL00000003COJN',0,'8e68229e-4adf-4632-9804-c25cd247968b','P0C15','Inverter für Antriebsmotor B, Stromkreis Phase V - Überhitzung','-','2022-05-11T11:16:27.895385Z',0),
  ('BPNL00000003COJN',0,'8860ed5d-92ce-44e5-a70b-d0315ac9ced5','P0C16','Inverter für Antriebsmotor B, Stromkreis Phase W - Überhitzung','-','2022-05-11T11:16:27.899521Z',0),
  ('BPNL00000003COJN',0,'6c23c575-6d6d-48e0-93e9-d7cb38cfc164','P0C17','Stellungssensor für Antriebsmotor A - Kalibrationswerte nicht erfasst','-','2022-05-11T11:16:27.904120Z',0),
  ('BPNL00000003COJN',0,'500a6b7f-d4f3-46de-aaf5-ba39cbc1e42f','P0C18','Stellungssensor für Antriebsmotor B - Kalibrationswerte nicht erfasst','-','2022-05-11T11:16:27.908495Z',0),
  ('BPNL00000003COJN',0,'3b1aa7ca-927f-47ae-8470-fa4268132d6a','P0C19','Antriebsmotor A - Funktionsfehler abgegebenes Drehmoment','-','2022-05-11T11:16:27.913282Z',0),
  ('BPNL00000003COJN',0,'f1cf7b12-d133-41c0-a592-9c96d95e1dce','P0C1A','Antriebsmotor B - Funktionsfehler abgegebenes Drehmoment','-','2022-05-11T11:16:27.918671Z',0),
  ('BPNL00000003COJN',0,'0160bf40-5108-4426-b112-1e1e9d4887ee','P0C1B','Steuergerät für Getriebe-Systemdruckhilfspumpe - interne Gerätetemperatur zu hoch','-','2022-05-11T11:16:27.923709Z',0),
  ('BPNL00000003COJN',0,'f3a40918-03ad-44ae-82ae-d82ec1ced021','P0C1C','Steuergerät für Getriebe-Systemdruckhilfspumpe, Sensor interne Gerätetemperatur - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.928501Z',0),
  ('BPNL00000003COJN',0,'ba335887-a532-4a5c-9f37-5d138f65e2e6','P0C1D','Steuergerät für Getriebe-Systemdruckhilfspumpe, Sensor interne Gerätetemperatur - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:27.932962Z',0),
  ('BPNL00000003COJN',0,'66feea9d-17cf-4bf1-b119-3a8a51fafcf9','P0C1E','Steuergerät für Getriebe-Systemdruckhilfspumpe, Sensor interne Gerätetemperatur - Signal zu niedrig','-','2022-05-11T11:16:27.937166Z',0),
  ('BPNL00000003COJN',0,'4e565bb4-7709-432c-b1c0-e7958d70201d','P0C1F','Steuergerät für Getriebe-Systemdruckhilfspumpe, Sensor interne Gerätetemperatur - Signal zu hoch','-','2022-05-11T11:16:27.941263Z',0),
  ('BPNL00000003COJN',0,'8441d520-2f34-4055-81b9-ca30cda1c560','P0C20','Getriebe-Systemdruckhilfspumpe, Stromkreis Phase U/V/W - offener Stromkreis','-','2022-05-11T11:16:27.945359Z',0),
  ('BPNL00000003COJN',0,'775bcecc-1a3a-4dac-8e70-a6b466ee28ff','P0C21','Getriebe-Systemdruckhilfspumpe, Stromkreis Phase U/V/W - Signal zu niedrig','-','2022-05-11T11:16:27.949638Z',0),
  ('BPNL00000003COJN',0,'fe3647e8-cdab-4426-8ab4-f235388b31ad','P0C22','Getriebe-Systemdruckhilfspumpe, Stromkreis Phase U/V/W - Signal zu hoch','-','2022-05-11T11:16:27.953677Z',0),
  ('BPNL00000003COJN',0,'63d0424f-2d73-4dd9-b54d-6e9c57b4cd9e','P0C23','Steuergerät für Getriebe-Systemdruckhilfspumpe - offener Stromkreis','-','2022-05-11T11:16:27.957981Z',0),
  ('BPNL00000003COJN',0,'739c0ccf-a80f-4513-8a92-4e631939c6a7','P0C24','Steuergerät für Getriebe-Systemdruckhilfspumpe - Signal zu niedrig','-','2022-05-11T11:16:27.962735Z',0),
  ('BPNL00000003COJN',0,'f448ad01-378b-46b1-9c89-7481b8afb943','P0C25','Steuergerät für Getriebe-Systemdruckhilfspumpe - Signal zu hoch','-','2022-05-11T11:16:27.967626Z',0),
  ('BPNL00000003COJN',0,'5a69f81a-1238-4180-8650-34f5e8ab8370','P0C26','Getriebe-Systemdruckhilfspumpenmotor - kein Strom','-','2022-05-11T11:16:27.977503Z',0),
  ('BPNL00000003COJN',0,'b3d5f24f-0940-418e-a112-03568297ec74','P0C27','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu niedrig','-','2022-05-11T11:16:27.982573Z',0),
  ('BPNL00000003COJN',0,'dc2a9ced-6efd-4dcf-bc5c-4cec06b5cdbe','P0C28','Getriebe-Systemdruckhilfspumpenmotor - Stromstärke zu hoch','-','2022-05-11T11:16:27.986898Z',0),
  ('BPNL00000003COJN',0,'1d845f10-11b4-447b-b0ab-fed2ef8f93b9','P0C29','Getriebe-Systemdruckhilfspumpe, Treiberstromkreis - Fehlfunktion Stromkreis','-','2022-05-11T11:16:27.991228Z',0),
  ('BPNL00000003COJN',0,'d275da75-9ccd-4e54-b260-0eb669939566','P0C2A','Getriebe-Systemdruckhilfspumpenmotor - Pumpenmotor läuft nicht','-','2022-05-11T11:16:27.995687Z',0),
  ('BPNL00000003COJN',0,'bdf4c6c0-aecd-446d-89fb-5497a8acfc70','P0C2B','Steuergerät für Getriebe-Systemdruckhilfspumpe - Fehlfunktion Rücksignal-Stromkreis','-','2022-05-11T11:16:28.000288Z',0),
  ('BPNL00000003COJN',0,'f82dc804-075f-4a9f-8d9c-284e488a9114','P0C2C','Steuergerät für Getriebe-Systemdruckhilfspumpe - Bereichs-/Funktionsfehler Rückmeldesignal','-','2022-05-11T11:16:28.004595Z',0),
  ('BPNL00000003COJN',0,'5ed81d8e-8339-492c-a40f-1fd8b661af7b','P0C2D','Steuergerät für Getriebe-Systemdruckhilfspumpe - Rückmeldesignal zu niedrig','-','2022-05-11T11:16:28.008988Z',0),
  ('BPNL00000003COJN',0,'cecb2e09-c007-4523-a56c-b422a0becee5','P0C2E','Steuergerät für Getriebe-Systemdruckhilfspumpe - Rückmeldesignal zu hoch','-','2022-05-11T11:16:28.014229Z',0),
  ('BPNL00000003COJN',0,'82a6c621-bf41-4f3c-b21c-c2b009003c6a','P0C2F','Internes Steuergerät, Antriebsmotor/Generator, Drehzahlsensor - beeinträchtigte Funktion','-','2022-05-11T11:16:28.018288Z',0),
  ('BPNL00000003COJN',0,'1455e2bc-9a18-46a0-9412-5d9428943bbf','P0C30','Hybridantriebsbatteriepack - Ladezustand hoch','-','2022-05-11T11:16:28.022697Z',0),
  ('BPNL00000003COJN',0,'b15304ad-a9c4-49d1-881c-fc73afdc2a17','P0C31','Kühlsystem Inverter B - beeinträchtigte Funktion','-','2022-05-11T11:16:28.027030Z',0),
  ('BPNL00000003COJN',0,'2d4cd80d-dde3-46ae-989a-ad8bc81669e0','P0C32','Hybridantriebsbatteriepack-Kühlsystem - beeinträchtigte Funktion','-','2022-05-11T11:16:28.031503Z',0),
  ('BPNL00000003COJN',0,'21fc9262-54db-4206-b493-39e45cc3ddd3','P0C33','Hybridantriebsbatterie-Temperatursensor F - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.036191Z',0),
  ('BPNL00000003COJN',0,'4df57232-0cb8-4eeb-bd6e-da2c22400020','P0C34','Hybridantriebsbatterie-Temperatursensor F - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.040510Z',0),
  ('BPNL00000003COJN',0,'ac7dd30b-d293-470a-9571-35b660df2f71','P0C35','Hybridantriebsbatterie-Temperatursensor F - Signal zu niedrig','-','2022-05-11T11:16:28.044666Z',0),
  ('BPNL00000003COJN',0,'3ec41e32-2103-4426-86fd-6412e8ab4f77','P0C36','Hybridantriebsbatterie-Temperatursensor F - Signal zu hoch','-','2022-05-11T11:16:28.049333Z',0),
  ('BPNL00000003COJN',0,'787573ac-56cb-47ba-88e1-e0fb1e02bdbf','P0C37','Hybridantriebsbatterie-Temperatursensor F - zeitweilige Stromkreisunterbrechungen',' ','2022-05-11T11:16:28.053765Z',0),
  ('BPNL00000003COJN',0,'cb1e01b4-cc43-44bd-b194-798283d2fc2e','P0C38','DC/DC-Wandler-Temperatursensor A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.058082Z',0),
  ('BPNL00000003COJN',0,'3aada6bf-3590-4d9e-8fd2-02ac5608c230','P0C39','DC/DC-Wandler-Temperatursensor A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.063795Z',0),
  ('BPNL00000003COJN',0,'2d715e22-a547-4715-91af-78a9e73fb845','P0C3A','DC/DC-Wandler-Temperatursensor A - Signal zu niedrig','-','2022-05-11T11:16:28.068115Z',0),
  ('BPNL00000003COJN',0,'c8e29cfc-4ea4-4aa7-98be-106998989d72','P0C3B','DC/DC-Wandler-Temperatursensor A - Signal zu hoch','-','2022-05-11T11:16:28.072886Z',0),
  ('BPNL00000003COJN',0,'192d46e1-7ff8-4916-84a0-c4391e2a368b','P0C3C','DC/DC-Wandler-Temperatursensor A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.077135Z',0),
  ('BPNL00000003COJN',0,'283149c5-b778-4d7a-8d3b-59966aab24a8','P0C3D','DC/DC-Wandler-Temperatursensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.081541Z',0),
  ('BPNL00000003COJN',0,'3feb28e7-0ae0-42ea-ab7c-23759cadd44a','P0C3E','DC/DC-Wandler-Temperatursensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.086216Z',0),
  ('BPNL00000003COJN',0,'a57cb512-cd53-4bb9-8fc6-1781c739bdef','P0C3F','DC/DC-Wandler-Temperatursensor B - Signal zu niedrig','-','2022-05-11T11:16:28.090724Z',0),
  ('BPNL00000003COJN',0,'798590d0-1aa1-43df-8292-3a5192605536','P0C40','DC/DC-Wandler-Temperatursensor B - Signal zu hoch','-','2022-05-11T11:16:28.095014Z',0),
  ('BPNL00000003COJN',0,'65612aab-9bd4-4736-ac95-178a21aa23c7','P0C41','DC/DC-Wandler-Temperatursensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.099734Z',0),
  ('BPNL00000003COJN',0,'caeb03e9-bcae-4046-899e-58353b9a43cf','P0C42','Hybridantriebsbatteriepack-Kühlmitteltemperatursensor - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.104087Z',0),
  ('BPNL00000003COJN',0,'84f7104e-f792-4d4c-81dd-18281c9a4b68','P0C43','Hybridantriebsbatteriepack-Kühlmitteltemperatursensor - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.108413Z',0),
  ('BPNL00000003COJN',0,'eb61d9c6-a951-4b5f-8e1d-c18cc2310dc1','P0C44','Hybridantriebsbatteriepack-Kühlmitteltemperatursensor - Signal zu niedrig','-','2022-05-11T11:16:28.112990Z',0),
  ('BPNL00000003COJN',0,'fbb83d4b-d4fb-4b53-9105-98f712cd0112','P0C45','Hybridantriebsbatteriepack-Kühlmitteltemperatursensor - Signal zu hoch','-','2022-05-11T11:16:28.117357Z',0),
  ('BPNL00000003COJN',0,'4a1e3464-6aee-4b71-9a2f-d9516dbff3fd','P0C46','Hybridantriebsbatteriepack-Kühlmitteltemperatursensor - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.122087Z',0),
  ('BPNL00000003COJN',0,'039f345a-f072-4685-9925-a6814ba5deb2','P0C47','Hybridantriebsbatteriepack-Kühlmittelpumpensteuerung - offener Stromkreis','-','2022-05-11T11:16:28.126197Z',0),
  ('BPNL00000003COJN',0,'e8226e91-eaad-44c5-99e9-a4bb9f58f56b','P0C48','Hybridantriebsbatteriepack-Kühlmittelpumpensteuerung - Signal zu niedrig','-','2022-05-11T11:16:28.130114Z',0),
  ('BPNL00000003COJN',0,'fefd40b8-a217-4091-94dc-96d4c97cff63','P0C49','Hybridantriebsbatteriepack-Kühlmittelpumpensteuerung - Signal zu hoch','-','2022-05-11T11:16:28.134126Z',0),
  ('BPNL00000003COJN',0,'de403799-bdaa-4462-9711-37499eb7447a','P0C4A','Hybridantriebsbatteriepack-Kühlmittelpumpensteuerung - beeinträchtigte Funktion','-','2022-05-11T11:16:28.140567Z',0),
  ('BPNL00000003COJN',0,'018391cb-da14-47c4-bd4f-64cc44404c2c','P0C4B','Hybridantriebsbatteriepack-Kühlmittelpumpe - keine Versorgungsspannung','-','2022-05-11T11:16:28.145083Z',0),
  ('BPNL00000003COJN',0,'48c9f284-5106-43e7-a90e-750b8e9b56e6','P0C4C','Hybridantriebsbatteriepack-Kühlmittelpumpe - Versorgungsspannung zu niedrig','-','2022-05-11T11:16:28.149824Z',0),
  ('BPNL00000003COJN',0,'322f2d91-faeb-43ef-a27c-24e21898bb3b','P0C4D','Hybridantriebsbatteriepack-Kühlmittelpumpe - Versorgungsspannung zu hoch','-','2022-05-11T11:16:28.155805Z',0),
  ('BPNL00000003COJN',0,'80febd50-7eeb-4470-b2ca-41d4ad169379','P0C4E','Antriebsmotor A - Grenzwert der Stellungsparameteradaption überschritten','-','2022-05-11T11:16:28.160311Z',0),
  ('BPNL00000003COJN',0,'e7790f6c-446b-4599-aecb-33f52cade715','P0C4F','Antriebsmotor B - Grenzwert der Stellungsparameteradaption überschritten','-','2022-05-11T11:16:28.165409Z',0),
  ('BPNL00000003COJN',0,'f0084385-02d5-43ca-921b-a75651f2d46f','P0C50','Stellungssensor für Antriebsmotor A, Stromkreis A - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.170141Z',0),
  ('BPNL00000003COJN',0,'f6f1445d-7888-46f6-8bf7-91d5c50949e0','P0C51','Stellungssensor für Antriebsmotor A, Stromkreis A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.174460Z',0),
  ('BPNL00000003COJN',0,'0fbda0ec-8efe-4f54-9d1a-fdad0a354bd3','P0C52','Stellungssensor für Antriebsmotor A, Stromkreis A - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.178953Z',0),
  ('BPNL00000003COJN',0,'d14c3892-6330-4ee0-b27c-3aed699ff867','P0C53','Stellungssensor für Antriebsmotor A, Stromkreis A - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.184566Z',0),
  ('BPNL00000003COJN',0,'b4215cac-294a-4c62-a714-5387ef91170a','P0C54','Stellungssensor für Antriebsmotor A, Stromkreis A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.192562Z',0),
  ('BPNL00000003COJN',0,'1778a774-4abe-4d33-a255-e9fe1630f8c4','P0C55','Stellungssensor für Antriebsmotor B, Stromkreis A - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.198322Z',0),
  ('BPNL00000003COJN',0,'2e2738cc-afe9-43ae-a126-0e9eddcedd5b','P0C56','Stellungssensor für Antriebsmotor B, Stromkreis A - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.202739Z',0),
  ('BPNL00000003COJN',0,'53357435-5037-4117-84f8-6d5224db0ee7','P0C57','Stellungssensor für Antriebsmotor B, Stromkreis A - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.207337Z',0),
  ('BPNL00000003COJN',0,'e9985b9c-50de-4b5e-826b-4e072785ed5e','P0C58','Stellungssensor für Antriebsmotor B, Stromkreis A - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.211900Z',0),
  ('BPNL00000003COJN',0,'427be9f7-b209-44e1-8dfa-a96883c3fe46','P0C59','Stellungssensor für Antriebsmotor B, Stromkreis A - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.217959Z',0),
  ('BPNL00000003COJN',0,'21b298f6-9f8e-4e69-83eb-82a444a42695','P0C5A','Stellungssensor für Antriebsmotor A, Stromkreis B - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.222552Z',0),
  ('BPNL00000003COJN',0,'911ec8d6-263f-4264-8b6c-88f49277573a','P0C5B','Stellungssensor für Antriebsmotor A, Stromkreis B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.226944Z',0),
  ('BPNL00000003COJN',0,'a38c36bc-077c-48db-bc8e-a65a1e789070','P0C5C','Stellungssensor für Antriebsmotor A, Stromkreis B - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.231778Z',0),
  ('BPNL00000003COJN',0,'c27beb40-378e-451a-a2f3-dfa49808a25a','P0C5D','Stellungssensor für Antriebsmotor A, Stromkreis B - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.236190Z',0),
  ('BPNL00000003COJN',0,'4769aaa0-aaff-4799-9744-640b7035b766','P0C5E','Stellungssensor für Antriebsmotor A, Stromkreis B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.241054Z',0),
  ('BPNL00000003COJN',0,'761655fa-eae3-40e5-b3b1-1257dc7f0788','P0C5F','Stellungssensor für Antriebsmotor B, Stromkreis B - Fehlfunktion Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.246075Z',0),
  ('BPNL00000003COJN',0,'d915bc8f-1f31-4d41-8abc-200d41fecdea','P0C60','Stellungssensor für Antriebsmotor B, Stromkreis B - Bereichs-/Funktionsfehler Stromkreis','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.250910Z',0),
  ('BPNL00000003COJN',0,'40e5f357-dc26-4ec9-9840-bea664f5cba2','P0C61','Stellungssensor für Antriebsmotor B, Stromkreis B - Signal zu niedrig','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.255194Z',0),
  ('BPNL00000003COJN',0,'1d4b276f-abf1-46f8-b469-8b9caa4adcb6','P0C62','Stellungssensor für Antriebsmotor B, Stromkreis B - Signal zu hoch','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.259825Z',0),
  ('BPNL00000003COJN',0,'be387638-12e8-44b8-9225-77d5d81cda0a','P0C63','Stellungssensor für Antriebsmotor B, Stromkreis B - zeitweilige Stromkreisunterbrechungen','Kabelbaum, Antriebsmotor-Stellungssensor','2022-05-11T11:16:28.264189Z',0),
  ('BPNL00000003COJN',0,'065774a0-802a-46d1-8797-26804621b09e','P0C64','Generator-Stellungssensor, Stromkreis A - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.268640Z',0),
  ('BPNL00000003COJN',0,'a36e50e9-62e1-4d70-9242-74a645f85ab6','P0C65','Generator-Stellungssensor, Stromkreis A - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.273769Z',0),
  ('BPNL00000003COJN',0,'e89bd445-6a5e-4960-94e3-e0f37788d73b','P0C66','Generator-Stellungssensor, Stromkreis A - Signal zu niedrig','-','2022-05-11T11:16:28.278Z',0),
  ('BPNL00000003COJN',0,'3e93c26f-91f3-4a54-876c-0036ea52f183','P0C67','Generator-Stellungssensor, Stromkreis A - Signal zu hoch','-','2022-05-11T11:16:28.283141Z',0),
  ('BPNL00000003COJN',0,'765bd3f1-892c-4f6b-a128-189c5bf7fdea','P0C68','Generator-Stellungssensor, Stromkreis A - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.287890Z',0),
  ('BPNL00000003COJN',0,'db8b35d9-ba57-46f4-81fc-156eed2b8557','P0C69','Generator-Stellungssensor, Stromkreis B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.291992Z',0),
  ('BPNL00000003COJN',0,'2cfbdfc0-6385-4bef-8ae2-04e9ad465749','P0C6A','Generator-Stellungssensor, Stromkreis B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.296540Z',0),
  ('BPNL00000003COJN',0,'eef9b8d3-d74a-4bdf-b130-c88de871a5c7','P0C6B','Generator-Stellungssensor, Stromkreis B - Signal zu niedrig','-','2022-05-11T11:16:28.301160Z',0),
  ('BPNL00000003COJN',0,'ae1d8462-6a02-42b4-845d-1138385dd3b3','P0C6C','Generator-Stellungssensor, Stromkreis B - Signal zu hoch','-','2022-05-11T11:16:28.306294Z',0),
  ('BPNL00000003COJN',0,'6d585325-05d7-4de6-a91d-6598571cadb0','P0C6D','Generator-Stellungssensor, Stromkreis B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.310893Z',0),
  ('BPNL00000003COJN',0,'5b654f79-9cc6-4efe-be13-9bf0960f0265','P0C6E','Hybridantriebsbatterie-Temperatursensor - Bezug A/B','-','2022-05-11T11:16:28.316226Z',0),
  ('BPNL00000003COJN',0,'2583a289-637f-4483-a118-a87af219ccd0','P0C6F','Hybridantriebsbatterie-Temperatursensor - Bezug B/C','-','2022-05-11T11:16:28.320659Z',0),
  ('BPNL00000003COJN',0,'391c4cf2-3665-4a3b-b793-aa8a1a265f81','P0C70','Hybridantriebsbatterie-Temperatursensor - Bezug C/D','-','2022-05-11T11:16:28.324958Z',0),
  ('BPNL00000003COJN',0,'e51d825b-a00d-4f6f-86a3-9dca514b5710','P0C71','Hybridantriebsbatterie-Temperatursensor - Bezug D/E','-','2022-05-11T11:16:28.328908Z',0),
  ('BPNL00000003COJN',0,'0bb8d772-8d87-4b2b-8371-31e0b6b02ee5','P0C72','Hybridantriebsbatterie-Temperatursensor - Bezug E/F','-','2022-05-11T11:16:28.332895Z',0),
  ('BPNL00000003COJN',0,'4c0b8327-d757-44f7-9fd2-f987880a6b13','P0C73','Steuerung Spannungswandler-Kühlmittelpumpenmotor A - beeinträchtigte Funktion','-','2022-05-11T11:16:28.337930Z',0),
  ('BPNL00000003COJN',0,'21520775-1382-449d-aa92-183e193f1d3a','P0C74','Steuerung Spannungswandler-Kühlmittelpumpenmotor B - beeinträchtigte Funktion','-','2022-05-11T11:16:28.342628Z',0),
  ('BPNL00000003COJN',0,'49a8a8c7-6130-4e64-88bf-12ea0aed318e','P0C75','Hybridantriebsbatteriesystem - Entladungsdauer zu kurz','-','2022-05-11T11:16:28.347953Z',0),
  ('BPNL00000003COJN',0,'39820f2a-2b62-426e-aa13-dfaca543efcd','P0C76','Hybridantriebsbatteriesystem - Entladungsdauer zu lang','-','2022-05-11T11:16:28.352127Z',0),
  ('BPNL00000003COJN',0,'71b38d63-afa4-4392-890f-2825092c359b','P0C77','Hybridantriebsbatteriesystem - Vorladungsdauer zu kurz','-','2022-05-11T11:16:28.356262Z',0),
  ('BPNL00000003COJN',0,'e4b0575b-6cad-437b-bf4c-b83eaad1d1c6','P0C78','Hybridantriebsbatteriesystem - Vorladungsdauer zu lang','-','2022-05-11T11:16:28.360793Z',0),
  ('BPNL00000003COJN',0,'e4339ddf-a3f5-4a3e-bead-e167b770d0e3','P0C79','Inverter für Antriebsmotor A - Spannung zu hoch','-','2022-05-11T11:16:28.365252Z',0),
  ('BPNL00000003COJN',0,'f7c7c2a7-dc15-41d6-9b51-7ce9d0d41916','P0C7A','Inverter für Antriebsmotor B - Spannung zu hoch','-','2022-05-11T11:16:28.371563Z',0),
  ('BPNL00000003COJN',0,'21c9787e-db1f-4752-82d9-aa58678d469b','P0C7B','Inverter für Generator - Spannung zu hoch','-','2022-05-11T11:16:28.375708Z',0),
  ('BPNL00000003COJN',0,'4f34ab59-8c08-4031-aac2-4230a2b7c457','P0C7C','Hybridantriebsbatterie-Temperatursensor G - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.379855Z',0),
  ('BPNL00000003COJN',0,'3a053f45-1d72-4acb-8037-e61c23479b85','P0C7D','Hybridantriebsbatterie-Temperatursensor G - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.384364Z',0),
  ('BPNL00000003COJN',0,'8ad30612-57c9-4780-be46-3f4e4c681a3d','P0C7E','Hybridantriebsbatterie-Temperatursensor G - Signal zu niedrig','-','2022-05-11T11:16:28.389548Z',0),
  ('BPNL00000003COJN',0,'83184f89-20ea-4f8f-a4b2-30ad9f33c4a6','P0C7F','Hybridantriebsbatterie-Temperatursensor G - Signal zu hoch','-','2022-05-11T11:16:28.393591Z',0),
  ('BPNL00000003COJN',0,'8419b51e-ea29-4944-ba94-f9e2f9165429','P0C80','Hybridantriebsbatterie-Temperatursensor G - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.397606Z',0),
  ('BPNL00000003COJN',0,'ffdbcccb-2635-4402-8d77-22547abd95ad','P0C81','Hybridantriebsbatterie-Temperatursensor H - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.401816Z',0),
  ('BPNL00000003COJN',0,'f9efa364-b1d6-4f70-9534-322e2bd87d0f','P0C82','Hybridantriebsbatterie-Temperatursensor H - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.406509Z',0),
  ('BPNL00000003COJN',0,'8ae9029d-986c-42a4-bc34-16906cfcf954','P0C83','Hybridantriebsbatterie-Temperatursensor H - Signal zu niedrig','-','2022-05-11T11:16:28.411107Z',0),
  ('BPNL00000003COJN',0,'ff65aaa4-1020-4a29-898e-4aa8c2dfb25e','P0C84','Hybridantriebsbatterie-Temperatursensor H - Signal zu hoch','-','2022-05-11T11:16:28.415566Z',0),
  ('BPNL00000003COJN',0,'35f3d310-a68b-4b6d-8a7f-4d79b2d8a8aa','P0C85','Hybridantriebsbatterie-Temperatursensor H - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.419968Z',0),
  ('BPNL00000003COJN',0,'e3174a4a-5549-42ed-92ef-a0e3a33fb7a6','P0C86','Hybridantriebsbatterie-Temperatursensor - Bezug F/G','-','2022-05-11T11:16:28.424142Z',0),
  ('BPNL00000003COJN',0,'c2b50580-1a98-4938-936b-d31960c6677f','P0C87','Hybridantriebsbatterie-Temperatursensor - Bezug G/H','-','2022-05-11T11:16:28.428357Z',0),
  ('BPNL00000003COJN',0,'f7428ca9-88f4-4f57-9704-0ac84b83e151','P0C88','Hybridantriebsbatterie-Temperatursensor I - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.432710Z',0),
  ('BPNL00000003COJN',0,'0c94f358-765a-462e-8cac-a71ab7cc6293','P0C89','Hybridantriebsbatterie-Temperatursensor I - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.436836Z',0),
  ('BPNL00000003COJN',0,'672b7896-3b6c-477e-ac90-a2c6144b4238','P0C8A','Hybridantriebsbatterie-Temperatursensor I - Signal zu niedrig','-','2022-05-11T11:16:28.441692Z',0),
  ('BPNL00000003COJN',0,'85d39938-2115-4e79-9ce5-cf96c63d2526','P0C8B','Hybridantriebsbatterie-Temperatursensor I - Signal zu hoch','-','2022-05-11T11:16:28.445771Z',0),
  ('BPNL00000003COJN',0,'3bc2b862-d23b-4dff-ba4a-6e1011708a99','P0C8C','Hybridantriebsbatterie-Temperatursensor I - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.450260Z',0),
  ('BPNL00000003COJN',0,'fa6bdcb2-92a9-4261-9396-72332f214b9c','P0C8D','Hybridantriebsbatterie-Temperatursensor J - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.454807Z',0),
  ('BPNL00000003COJN',0,'456268cb-6a94-49c2-a811-832067f5a9c2','P0C8E','Hybridantriebsbatterie-Temperatursensor J - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.459066Z',0),
  ('BPNL00000003COJN',0,'69ecc910-e8b8-4e28-83c0-5906d991b36f','P0C8F','Hybridantriebsbatterie-Temperatursensor J - Signal zu niedrig','-','2022-05-11T11:16:28.463494Z',0),
  ('BPNL00000003COJN',0,'774edab2-8e7d-4e74-a353-4e2835bb684e','P0C90','Hybridantriebsbatterie-Temperatursensor J - Signal zu hoch','-','2022-05-11T11:16:28.467455Z',0),
  ('BPNL00000003COJN',0,'6b3b707a-eeb2-4b62-bd97-cf1fd70971ee','P0C91','Hybridantriebsbatterie-Temperatursensor J - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.471611Z',0),
  ('BPNL00000003COJN',0,'e42b2352-cceb-4a1f-92ae-06c41d172441','P0C92','Hybridantriebsbatterie-Temperatursensor K - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.475483Z',0),
  ('BPNL00000003COJN',0,'54f46b26-9918-44cf-981b-a05209194916','P0C93','Hybridantriebsbatterie-Temperatursensor K - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.479596Z',0),
  ('BPNL00000003COJN',0,'3f5c9e85-ca8f-4922-abc6-4a10e0a85563','P0C94','Hybridantriebsbatterie-Temperatursensor K - Signal zu niedrig','-','2022-05-11T11:16:28.484509Z',0),
  ('BPNL00000003COJN',0,'132d7f7b-0ca0-4459-b599-498b5d9542de','P0C95','Hybridantriebsbatterie-Temperatursensor K - Signal zu hoch','-','2022-05-11T11:16:28.489770Z',0),
  ('BPNL00000003COJN',0,'6d9898c3-ad32-4b68-892b-018419f44617','P0C96','Hybridantriebsbatterie-Temperatursensor K - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.495757Z',0),
  ('BPNL00000003COJN',0,'c863af5e-0594-4091-8b37-e00d4186f458','P0C97','Hybridantriebsbatterie-Temperatursensor L - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.500165Z',0),
  ('BPNL00000003COJN',0,'f4998d90-ac4d-49f2-b644-d7c8d1ccac2e','P0C98','Hybridantriebsbatterie-Temperatursensor L - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.504542Z',0),
  ('BPNL00000003COJN',0,'6fcba8b5-d4be-4de1-b8bc-d8e42fa54ac9','P0C99','Hybridantriebsbatterie-Temperatursensor L - Signal zu niedrig','-','2022-05-11T11:16:28.508471Z',0),
  ('BPNL00000003COJN',0,'00eed518-eb6f-46ff-aca4-0831176209af','P0C9A','Hybridantriebsbatterie-Temperatursensor L - Signal zu hoch','-','2022-05-11T11:16:28.512932Z',0),
  ('BPNL00000003COJN',0,'132f0ec0-e06d-4a34-99ad-cafe743956c8','P0C9B','Hybridantriebsbatterie-Temperatursensor L - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.517204Z',0),
  ('BPNL00000003COJN',0,'3bc6f68f-1841-4e28-af91-138cf5cb6efb','P0C9C','14-V-Versorgungsmodul-Stromsensor B - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.523013Z',0),
  ('BPNL00000003COJN',0,'c4d8d04e-09c7-4c66-8825-abaa4358798c','P0C9D','14-V-Versorgungsmodul-Stromsensor B - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.527314Z',0),
  ('BPNL00000003COJN',0,'a482aa52-c56f-4c95-ba1e-e4c6d5d9fc95','P0C9E','14-V-Versorgungsmodul-Stromsensor B - Signal zu niedrig','-','2022-05-11T11:16:28.531478Z',0),
  ('BPNL00000003COJN',0,'26499f28-fe07-4d7e-99a6-98ebeb5580a7','P0C9F','14-V-Versorgungsmodul-Stromsensor B - Signal zu hoch','-','2022-05-11T11:16:28.535378Z',0),
  ('BPNL00000003COJN',0,'f5a6ac84-045f-483c-a55d-2cbee6845ab7','P0CA0','14-V-Versorgungsmodul-Stromsensor B - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.539381Z',0),
  ('BPNL00000003COJN',0,'00bfa88d-efa3-443f-8ee3-e66a12679d8c','P0CA1','Antriebsmotor-Steuergerät - Aktivierung der Motorstörungswarnleuchte angefordert','-','2022-05-11T11:16:28.544311Z',0),
  ('BPNL00000003COJN',0,'c92e6845-f51d-4735-bce7-5eba88534427','P0CA2','DC/DC-Wandler, Spannungswert der Abwärtswandlung - beeinträchtigte Funktion','-','2022-05-11T11:16:28.548296Z',0),
  ('BPNL00000003COJN',0,'c90ca204-6005-493a-9a0b-1294112448d5','P0CA3','DC/DC-Wandler, Spannungswert der Aufwärtswandlung - beeinträchtigte Funktion','-','2022-05-11T11:16:28.552938Z',0),
  ('BPNL00000003COJN',0,'1598ba17-c24f-4b34-9816-fad33ce8e433','P0CA4','Hybridantriebsbatteriesystem - Ladespannung zu hoch','-','2022-05-11T11:16:28.557149Z',0),
  ('BPNL00000003COJN',0,'ea1dee8b-7c32-46bd-a759-2653339c55b7','P0CA5','Hybridantriebsbatteriesystem - Entladespannung zu hoch','-','2022-05-11T11:16:28.562583Z',0),
  ('BPNL00000003COJN',0,'cd9ae890-4d5e-4ff4-b1bf-01c712f86417','P0CA6','Hybridantriebsbatteriesystem - Ladestrom zu hoch','-','2022-05-11T11:16:28.567321Z',0),
  ('BPNL00000003COJN',0,'cf7f5026-a572-4739-9be5-31034fed73d4','P0CA7','Hybridantriebsbatteriesystem - Entladestrom zu hoch','-','2022-05-11T11:16:28.571828Z',0),
  ('BPNL00000003COJN',0,'88d0fbcc-78a7-40e5-bb90-c28cb4f2df3e','P0CA8','Hybridantriebsbatterie-Temperatursensor M - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.575780Z',0),
  ('BPNL00000003COJN',0,'d446c4e2-31c8-44f2-a8a8-cedcd92c861d','P0CA9','Hybridantriebsbatterie-Temperatursensor M - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.579725Z',0),
  ('BPNL00000003COJN',0,'9a156f13-192d-4817-bfc1-d46d93436369','P0CAA','Hybridantriebsbatterie-Temperatursensor M - Signal zu niedrig','-','2022-05-11T11:16:28.584094Z',0),
  ('BPNL00000003COJN',0,'551acbbb-c5b3-48d9-804f-f26b484d85ef','P0CAB','Hybridantriebsbatterie-Temperatursensor M - Signal zu hoch','-','2022-05-11T11:16:28.589190Z',0),
  ('BPNL00000003COJN',0,'bda70ec8-5807-4486-8a5c-92c32f7389a2','P0CAC','Hybridantriebsbatterie-Temperatursensor M - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.593972Z',0),
  ('BPNL00000003COJN',0,'66575707-fff0-42ed-b38d-fae1f036fb24','P0CAD','Hybridantriebsbatterie-Temperatursensor N - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.598203Z',0),
  ('BPNL00000003COJN',0,'143e9967-b366-4ac5-904d-a102b01b98a7','P0CAE','Hybridantriebsbatterie-Temperatursensor N - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.602472Z',0),
  ('BPNL00000003COJN',0,'17c3a33d-1dc3-42c8-8c83-bf8770cb342b','P0CAF','Hybridantriebsbatterie-Temperatursensor N - Signal zu niedrig','-','2022-05-11T11:16:28.607460Z',0),
  ('BPNL00000003COJN',0,'1680b0ce-72f8-44e7-b93d-873e9089b338','P0CB0','Hybridantriebsbatterie-Temperatursensor N - Signal zu hoch','-','2022-05-11T11:16:28.613545Z',0),
  ('BPNL00000003COJN',0,'12849ec9-bfb4-4774-b638-e4e611a7f1de','P0CB1','Hybridantriebsbatterie-Temperatursensor N - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.617842Z',0),
  ('BPNL00000003COJN',0,'a29270a0-817f-4789-8eaf-9bed2449fc69','P0CB2','Hybridantriebsbatterie-Temperatursensor O - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.622112Z',0),
  ('BPNL00000003COJN',0,'ea56a2d0-b631-4440-8ec2-9b7c8fd04df2','P0CB3','Hybridantriebsbatterie-Temperatursensor O - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.626886Z',0),
  ('BPNL00000003COJN',0,'ee3318a4-a44d-496b-86d5-16693d56c996','P0CB4','Hybridantriebsbatterie-Temperatursensor O - Signal zu niedrig','-','2022-05-11T11:16:28.631102Z',0),
  ('BPNL00000003COJN',0,'a3815ab0-966e-4d3e-a43b-6285db823afd','P0CB5','Hybridantriebsbatterie-Temperatursensor O - Signal zu hoch','-','2022-05-11T11:16:28.636651Z',0),
  ('BPNL00000003COJN',0,'461d0a31-7050-4a4d-a28e-00a9d28e37d6','P0CB6','Hybridantriebsbatterie-Temperatursensor O - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.641367Z',0),
  ('BPNL00000003COJN',0,'5d7afaf9-261f-4adb-ba20-b4fc23479e74','P0CB7','Hybridantriebsbatterie-Temperatursensor P - Fehlfunktion Stromkreis','-','2022-05-11T11:16:28.646464Z',0),
  ('BPNL00000003COJN',0,'587d9c4c-0019-4373-bbbf-975e4e8ff21b','P0CB8','Hybridantriebsbatterie-Temperatursensor P - Bereichs-/Funktionsfehler Stromkreis','-','2022-05-11T11:16:28.650654Z',0),
  ('BPNL00000003COJN',0,'663db63d-9ed3-423b-a92f-7ca50e60c35a','P0CB9','Hybridantriebsbatterie-Temperatursensor P - Signal zu niedrig','-','2022-05-11T11:16:28.654909Z',0),
  ('BPNL00000003COJN',0,'6c426c45-2aef-47b3-a243-a447af634590','P0CBA','Hybridantriebsbatterie-Temperatursensor P - Signal zu hoch','-','2022-05-11T11:16:28.659499Z',0),
  ('BPNL00000003COJN',0,'2301fc84-a404-4776-b383-5c6ef47f8017','P0CBB','Hybridantriebsbatterie-Temperatursensor P - zeitweilige Stromkreisunterbrechungen','-','2022-05-11T11:16:28.664441Z',0),
  ('BPNL00000003COJN',0,'df0027d1-8a90-4220-9861-eb6233a20e23','P1290','Außentemperatursensor - zeitweilige Stromkreisunterbrechungen ','Kabelbaum, schlechte Kontaktierung, Außentemperatursensor, Motorsteuergerät','2022-05-11T11:16:28.668948Z',0),
  ('BPNL00000003COJN',0,'e625c4fb-52dd-48fb-b7c9-d5e7a1d5b230','P1246','Turbo-/Kompressorlader B - Bereichs-/Funktionsfehler Stromkreis ','Kabelbaum, Turbolader-/Motoraufladungskompressor-Bypassventil','2022-05-11T11:16:28.673580Z',0);

CREATE TABLE IF NOT EXISTS "dtc"."part" (
  "bpnl" varchar(17) NOT NULL,
  "number" INT NOT NULL,
  "entityGuid" VARCHAR(64) NOT NULL PRIMARY KEY,
  "enDenomination" VARCHAR(256) NOT NULL,
  "classification" VARCHAR(256) NOT NULL,
  "category" VARCHAR(256) NOT NULL,
  "enDaClass" VARCHAR(256) NOT NULL,
  FOREIGN KEY ("bpnl","number") REFERENCES "dtc"."meta"("bpnl","number")
);
MERGE INTO "dtc"."part" VALUES
 ('BPNL00000003COJN',0,'2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','fuel','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'ddd15703-21c8-4eac-b6f4-8c640c6180da','wiring harness','Electrical.Wiring harness','Other','Electrical')
,('BPNL00000003COJN',0,'b0443218-47e1-4b2d-b4fb-1272a39b8499','camshaft','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'07f4ef9d-607c-4c83-80ec-47c25fe7d248','engine control module','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'c7e230da-3c22-4915-9ad9-968f874536a5','wheel','Chassis.Driveline & axles','Part','Chassis')
,('BPNL00000003COJN',0,'096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','fuel system','Powertrain.Engine & emissions control','System','Powertrain')
,('BPNL00000003COJN',0,'501ffd87-ef29-4656-ac28-1ea0ae57c1c8','crankshaft','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'bc2d7f80-422d-45a6-ab28-77ac441a63c4','oxygen sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'4b055876-e210-4e43-aea3-9167e5afb724','turbocharger','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'eb2b00dc-23f3-4e11-9fc9-1649f318061a','pipe','Introduction.Reference term','Part','Introduction')
,('BPNL00000003COJN',0,'10cedc5f-717a-4800-b837-d250cce7c101','throttle valve','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'ec084e0d-f7d9-4df5-a7bc-59dd124addb5','exhaust pressure sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'fde257b6-7136-4cc2-b4af-bfde06b540eb','charge air cooler','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','radiator','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'223f4787-af72-40d1-986e-51d048898c9d','line','Introduction.Reference term','Part','Introduction')
,('BPNL00000003COJN',0,'76c3968c-c2ef-4f37-8d33-4709f0ba3747','fuel pump','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'371fcc76-3fe4-4c3a-9d47-5cb0dae54592','coolant','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'83f24db5-32e0-4c1a-9d85-c649de5dfd50','coolant temperature','Body.Interior','Other','Body')
,('BPNL00000003COJN',0,'79fcc528-14cd-49f5-be1d-496f5c5374c4','fuel temperature sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'c05aee12-fd6f-4169-b89e-3f5c233e22e9','fuel pressure sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'6c26c1ab-90d8-4c91-a4d0-39d60c92575d','intake air temperature sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'3f29763e-aa51-4e87-8667-86c39fed8251','coolant pump','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','hose','Introduction.Reference term','Part','Introduction')
,('BPNL00000003COJN',0,'554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','starter','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'e3ea9640-04f4-412f-aaa2-1013bcc905e6','coolant thermostat','HVAC.hvac','Part','HVAC')
,('BPNL00000003COJN',0,'517477d3-2d79-494d-a8ca-b1da9a1f19ca','accelerator pedal','Body.Interior','Part','Body')
,('BPNL00000003COJN',0,'e6be2370-6497-41bf-9f99-de8aead8f30f','automatic transmission','Powertrain.Transmission','Part','Powertrain')
,('BPNL00000003COJN',0,'9a72a020-72dd-4415-ae04-451f61db3142','automatic transmission fluid','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'17261ec2-82c2-449b-a58d-588b74f5a2f5','transmission oil','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'60fde6ac-3155-44ab-9636-7d4886fd8857','injection pump','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'53a63aa3-6cec-483f-90c9-7f9dbbc2d997','secondary air injection','Powertrain.Engine & emissions control','System','Powertrain')
,('BPNL00000003COJN',0,'ee818f0f-e1cb-45d0-bfab-cd049fd923ba','fuel filler flap','Body.Openings & closings','Part','Body')
,('BPNL00000003COJN',0,'e311aa83-ccf4-48c8-a436-b43b7f61ef81','cylinder head','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'342347b7-d78b-4c9f-b9be-6422977d8a79','oil temperature','Powertrain.Engine & emissions control','Other','Powertrain')
,('BPNL00000003COJN',0,'ba39189f-6f18-4a54-94bd-c9301ba54540','engine oil temperature sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'caeda0e4-11eb-4112-9649-9ba2a4309803','transmission oil temperature sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'ab4fa3f4-0b8a-4e1d-a2db-06fdc4d3492f','fuel line','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'489b0e63-83f1-49ad-9f8a-12b2bfc23e27','diesel','Powertrain.Engine & emissions control','Function','Powertrain')
,('BPNL00000003COJN',0,'b9ad5d42-0f1b-4191-89ae-c64064a7c51c','seal','Introduction.Reference term','Part','Introduction')
,('BPNL00000003COJN',0,'bc3192c5-05aa-4af1-be4e-8bfdeb121029','ignition coil','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'8a3a2fd6-164b-43ba-ad8e-d3ae60cffc5a','spark plug','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'237ff6b9-7d8c-4183-8004-fc8d787b44eb','exhaust gas recirculation','Powertrain.Engine & emissions control','System','Powertrain')
,('BPNL00000003COJN',0,'771bf47d-a099-4ec6-aa41-02108ece7713','catalytic converter','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'9fbf6ee7-8258-42ff-b771-21a2b09d17c8','fuel filler cap','Body.Openings & closings','Part','Body')
,('BPNL00000003COJN',0,'3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','pressure regulating valve','Powertrain.Transmission','Part','Powertrain')
,('BPNL00000003COJN',0,'d3999613-30a5-44f1-bcb8-1391bef45b96','clutch','Powertrain.Transmission','Part','Powertrain')
,('BPNL00000003COJN',0,'5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','brake','Chassis.Brakes','Part','Chassis')
,('BPNL00000003COJN',0,'81f51ca9-0756-405c-ab5f-5adcaecf9800','speedometer','Body.Interior','Part','Body')
,('BPNL00000003COJN',0,'5f6476fc-4170-418c-84fb-d90f638fd6d1','brake pedal','Body.Interior','Part','Body')
,('BPNL00000003COJN',0,'70f129e3-3b50-4dd6-bd00-87963cb0b902','exhaust temperature sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'f17c0261-97fb-428e-885c-7a166e377074','brake booster','Chassis.Brakes','Part','Chassis')
,('BPNL00000003COJN',0,'35c03704-58f7-4a6d-80ae-8a3ac8b9823d','crankcase','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','oil pressure','Powertrain.Engine & emissions control','Function','Powertrain')
,('BPNL00000003COJN',0,'8f816264-0682-4b77-888e-dec7441f4477','engine oil pressure sensor','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'372d22f7-9309-4327-8a3c-65e7cb5f6e9d','refrigerant','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','refrigerant pressure sensor','HVAC.hvac','Part','HVAC')
,('BPNL00000003COJN',0,'64825d27-435c-408f-abc7-e883b44a1c99','air conditioning evaporator','HVAC.hvac','Part','HVAC')
,('BPNL00000003COJN',0,'0fd91106-bcc8-4ed3-aedd-f5b31159952d','crankcase ventilation system','Powertrain.Engine & emissions control','System','Powertrain')
,('BPNL00000003COJN',0,'aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','steering','Chassis.Driveline & axles','System','Chassis')
,('BPNL00000003COJN',0,'6458b11b-b13f-414f-a9e9-6d5a5552275b','power steering','Body.Interior','Function','Body')
,('BPNL00000003COJN',0,'17949107-a0d3-42da-997c-5b70f0831444','drivetrain','Chassis.Driveline & axles','Part','Chassis')
,('BPNL00000003COJN',0,'6d091762-f46c-416d-918f-ae79abe71255','reductant','General information.Liquids','Operating fluid','General information')
,('BPNL00000003COJN',0,'f1c7bc64-98ae-453d-8c3e-8ace35c4de67','intake manifold','Powertrain.Engine & emissions control','Part','Powertrain')
,('BPNL00000003COJN',0,'29f2db9a-61c3-47b5-8376-32e46d943b81','engine timing','Powertrain.Engine & emissions control','Function','Powertrain')
,('BPNL00000003COJN',0,'f124db40-9975-4d9b-8e04-81cd3ed8d363','clutch pedal','Body.Interior','Part','Body')
,('BPNL00000003COJN',0,'4879502b-7bac-4c9e-8d4c-c91a8c061be7','oil level','Powertrain.Engine & emissions control','Other','Powertrain')
,('BPNL00000003COJN',0,'985fa8af-cac7-44ab-9049-ccaefee4f866','tire','Chassis.Driveline & axles','Part','Chassis')
,('BPNL00000003COJN',0,'1e227dc6-6e8b-4443-abd7-e1b4268e6aa7','transfer case','Powertrain.Transmission','Part','Powertrain')
,('BPNL00000003COJN',0,'44d897e1-fc5e-4667-84a7-ed4414165e33','gear shift lever','Body.Interior','Part','Body')
,('BPNL00000003COJN',0,'6346d078-65fc-4166-bb2a-33c7c3febc9a','all-wheel drive','Chassis.Driveline & axles','Function','Chassis')
,('BPNL00000003COJN',0,'b8094194-ffc5-4091-908d-9fcace16dc71','traction control system','Electrical.Chassis & brakes','System','Electrical')
,('BPNL00000003COJN',0,'e837e90d-d57f-4271-a606-3965b0e9f9b9','hydraulic pump','General information.Others','Part','General information')
,('BPNL00000003COJN',0,'4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','manual transmission','Powertrain.Transmission','Part','Powertrain')
;
CREATE TABLE IF NOT EXISTS "dtc"."content_part" (
  "part_entityGuid" VARCHAR(64) NOT NULL,
  "dtc_id" VARCHAR(64) NOT NULL,
  FOREIGN KEY ("dtc_id") REFERENCES "dtc"."content"("id"),
  FOREIGN KEY ("part_entityGuid") REFERENCES "dtc"."part"("entityGuid")
);
MERGE INTO "dtc"."content_part" KEY ("dtc_id","part_entityGuid") VALUES
 ('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9573c2a6-9c2e-4983-818b-89bd76032735')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9573c2a6-9c2e-4983-818b-89bd76032735')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','2be3578e-2b51-4b8d-92b6-2fc752314a13')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2be3578e-2b51-4b8d-92b6-2fc752314a13')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9fe16ce0-410c-4fb0-b840-93e8a0cd8eee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9fe16ce0-410c-4fb0-b840-93e8a0cd8eee')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f3898483-6c89-4e45-b187-90fcee2554a6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f3898483-6c89-4e45-b187-90fcee2554a6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','6e4d5a1c-a464-4de2-a999-e8deac78d797')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6e4d5a1c-a464-4de2-a999-e8deac78d797')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','2afd3fda-a5c5-4df2-8283-3f2dec03909b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2afd3fda-a5c5-4df2-8283-3f2dec03909b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a531794c-eb14-4e3d-bf0f-24ccd4f2ddd6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a531794c-eb14-4e3d-bf0f-24ccd4f2ddd6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8ed80f96-405a-4c25-a6c1-33e59879e32e')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8ed80f96-405a-4c25-a6c1-33e59879e32e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8ed80f96-405a-4c25-a6c1-33e59879e32e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','68d0417e-c15d-4704-89c8-e175a9d383fa')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','68d0417e-c15d-4704-89c8-e175a9d383fa')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','68d0417e-c15d-4704-89c8-e175a9d383fa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5c1c7c9-b6d5-4b8e-b196-dee5041e210c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','a5c1c7c9-b6d5-4b8e-b196-dee5041e210c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a5c1c7c9-b6d5-4b8e-b196-dee5041e210c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ae77ed6-c6d5-49b5-8df2-bb264bd95cfd')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','7ae77ed6-c6d5-49b5-8df2-bb264bd95cfd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7ae77ed6-c6d5-49b5-8df2-bb264bd95cfd')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','dc5195a0-0ec0-455d-b449-5cb339f7852e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','dc5195a0-0ec0-455d-b449-5cb339f7852e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dc5195a0-0ec0-455d-b449-5cb339f7852e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dc5195a0-0ec0-455d-b449-5cb339f7852e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','0abb4b66-5176-4715-b21d-da7449963331')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0abb4b66-5176-4715-b21d-da7449963331')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','0abb4b66-5176-4715-b21d-da7449963331')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0abb4b66-5176-4715-b21d-da7449963331')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aa7325ea-d430-4926-a75b-33f63b93a1a6')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','aa7325ea-d430-4926-a75b-33f63b93a1a6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa7325ea-d430-4926-a75b-33f63b93a1a6')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','67784149-f6c7-4f89-8c2e-6f3818a3c99c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','f9c933e0-d9b3-4602-8cba-de28afe1a9eb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2107d2d7-cdc8-4444-bd0f-a87a00e0c070')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','2107d2d7-cdc8-4444-bd0f-a87a00e0c070')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2107d2d7-cdc8-4444-bd0f-a87a00e0c070')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','5f6f4500-2c02-4898-8b7c-0bd8b9e34dc7')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1322a79c-9f88-4e39-ac76-489da82de0f9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a48bf23c-c92d-47d7-9209-9edcc8199d11')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','a48bf23c-c92d-47d7-9209-9edcc8199d11')
,('501ffd87-ef29-4656-ac28-1ea0ae57c1c8','a48bf23c-c92d-47d7-9209-9edcc8199d11')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ccc94bf-796c-4cfa-9e59-a9d306a64775')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','7ccc94bf-796c-4cfa-9e59-a9d306a64775')
,('501ffd87-ef29-4656-ac28-1ea0ae57c1c8','7ccc94bf-796c-4cfa-9e59-a9d306a64775')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','28bf8789-074a-4f19-9afe-b5e303eca9bf')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','28bf8789-074a-4f19-9afe-b5e303eca9bf')
,('501ffd87-ef29-4656-ac28-1ea0ae57c1c8','28bf8789-074a-4f19-9afe-b5e303eca9bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0bd5f518-6876-4d6c-9083-d5ab78fb5972')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','0bd5f518-6876-4d6c-9083-d5ab78fb5972')
,('501ffd87-ef29-4656-ac28-1ea0ae57c1c8','0bd5f518-6876-4d6c-9083-d5ab78fb5972')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','99184a27-f88c-4d30-9cd9-532a9467088d')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','99184a27-f88c-4d30-9cd9-532a9467088d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','99184a27-f88c-4d30-9cd9-532a9467088d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ce7f4a42-4c61-456f-a56c-448bf054be37')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ce7f4a42-4c61-456f-a56c-448bf054be37')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ce7f4a42-4c61-456f-a56c-448bf054be37')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ece1c117-b26a-4416-8a83-668009aeb93f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ece1c117-b26a-4416-8a83-668009aeb93f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ece1c117-b26a-4416-8a83-668009aeb93f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8cf9da91-c3df-467e-a4df-c4ea0268ce6b')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8cf9da91-c3df-467e-a4df-c4ea0268ce6b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8cf9da91-c3df-467e-a4df-c4ea0268ce6b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fb5da26b-f060-40f3-b03e-d3436301972f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','fb5da26b-f060-40f3-b03e-d3436301972f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fb5da26b-f060-40f3-b03e-d3436301972f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f1c535de-b6ae-45d2-9218-2bc0a0a929d0')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','f1c535de-b6ae-45d2-9218-2bc0a0a929d0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f1c535de-b6ae-45d2-9218-2bc0a0a929d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','01cd77a0-0632-4efc-ba4e-83b056ec8d5f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','01cd77a0-0632-4efc-ba4e-83b056ec8d5f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','01cd77a0-0632-4efc-ba4e-83b056ec8d5f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','3a43175e-069f-4db9-b9ca-4eb06ac1acb7')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','fb9384ab-3068-4fba-9e55-833e5d056274')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','74a7c7a6-b6bc-4453-a5ce-5c4080f4cba3')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','74a7c7a6-b6bc-4453-a5ce-5c4080f4cba3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','74a7c7a6-b6bc-4453-a5ce-5c4080f4cba3')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ec88ab7d-9728-472a-83d4-b4b71ff31fd2')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','3f7863b1-3670-4f57-9df4-a62b5a811a59')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','78e67690-e1fd-446c-b81b-5ffd643b7c9d')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','78e67690-e1fd-446c-b81b-5ffd643b7c9d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cf16993b-996e-4bcd-b5d9-f1784b89a0e7')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','cf16993b-996e-4bcd-b5d9-f1784b89a0e7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','810a040d-f2e8-4fce-b207-ed0352f15ee4')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','810a040d-f2e8-4fce-b207-ed0352f15ee4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','90a8a87f-44a4-4299-8d1f-38c1f40b288a')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','90a8a87f-44a4-4299-8d1f-38c1f40b288a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7632a54a-3a75-48e2-bc7a-d746eee601cb')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','7632a54a-3a75-48e2-bc7a-d746eee601cb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7632a54a-3a75-48e2-bc7a-d746eee601cb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','86ef1dcc-1d8b-42f8-8b5a-2df129a1e356')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','86ef1dcc-1d8b-42f8-8b5a-2df129a1e356')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','86ef1dcc-1d8b-42f8-8b5a-2df129a1e356')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c84dff8e-50d7-45f4-a530-887ab66e2e1f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','c84dff8e-50d7-45f4-a530-887ab66e2e1f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c84dff8e-50d7-45f4-a530-887ab66e2e1f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','abfd397e-add2-4f88-bd05-ad32ed7ce128')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','abfd397e-add2-4f88-bd05-ad32ed7ce128')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','abfd397e-add2-4f88-bd05-ad32ed7ce128')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','233dd0a1-dc39-413b-a6e1-da519ac3f007')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','233dd0a1-dc39-413b-a6e1-da519ac3f007')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','233dd0a1-dc39-413b-a6e1-da519ac3f007')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e86f9dda-1fcd-4d6a-9bc7-020b10bd5660')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','e86f9dda-1fcd-4d6a-9bc7-020b10bd5660')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e86f9dda-1fcd-4d6a-9bc7-020b10bd5660')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1ca18631-05d8-4d85-b6f0-a0c6b44d5123')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1ca18631-05d8-4d85-b6f0-a0c6b44d5123')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','1ca18631-05d8-4d85-b6f0-a0c6b44d5123')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9d0f8036-9ce3-4bec-9bab-6a0bb917d700')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9d0f8036-9ce3-4bec-9bab-6a0bb917d700')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','9d0f8036-9ce3-4bec-9bab-6a0bb917d700')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cea56ff4-5b91-4eb2-befe-6e43dab43d53')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cea56ff4-5b91-4eb2-befe-6e43dab43d53')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','cea56ff4-5b91-4eb2-befe-6e43dab43d53')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8439e2a5-7452-4df5-be12-8d85b2de021f')
,('4b055876-e210-4e43-aea3-9167e5afb724','8439e2a5-7452-4df5-be12-8d85b2de021f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8439e2a5-7452-4df5-be12-8d85b2de021f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','60cfdcb1-c381-49c6-969a-cb40eb45c658')
,('4b055876-e210-4e43-aea3-9167e5afb724','60cfdcb1-c381-49c6-969a-cb40eb45c658')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','60cfdcb1-c381-49c6-969a-cb40eb45c658')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','40ad9c4f-edc0-4758-b800-08e4f49aa2f7')
,('4b055876-e210-4e43-aea3-9167e5afb724','40ad9c4f-edc0-4758-b800-08e4f49aa2f7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','40ad9c4f-edc0-4758-b800-08e4f49aa2f7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c35326d-06f8-475f-ac21-b8881cef8bc1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c35326d-06f8-475f-ac21-b8881cef8bc1')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6c35326d-06f8-475f-ac21-b8881cef8bc1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','93533ba2-6156-4b63-8182-8fa88a7f7c7c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','93533ba2-6156-4b63-8182-8fa88a7f7c7c')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','93533ba2-6156-4b63-8182-8fa88a7f7c7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','19341da2-31ee-4b34-986a-81acfcbb8049')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','19341da2-31ee-4b34-986a-81acfcbb8049')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','19341da2-31ee-4b34-986a-81acfcbb8049')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1f512c34-059c-4d89-8817-3d24363bc14e')
,('4b055876-e210-4e43-aea3-9167e5afb724','1f512c34-059c-4d89-8817-3d24363bc14e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','92d2748d-a2d1-48ce-a6fc-eefb4136782e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','92d2748d-a2d1-48ce-a6fc-eefb4136782e')
,('4b055876-e210-4e43-aea3-9167e5afb724','92d2748d-a2d1-48ce-a6fc-eefb4136782e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','92d2748d-a2d1-48ce-a6fc-eefb4136782e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','c0f05974-b9af-4520-8b6d-2ddb74213cc5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0f05974-b9af-4520-8b6d-2ddb74213cc5')
,('4b055876-e210-4e43-aea3-9167e5afb724','c0f05974-b9af-4520-8b6d-2ddb74213cc5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c0f05974-b9af-4520-8b6d-2ddb74213cc5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e49ae8d-261c-48cc-852b-b114b1dc3518')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1e49ae8d-261c-48cc-852b-b114b1dc3518')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e49ae8d-261c-48cc-852b-b114b1dc3518')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d4d32443-dce9-41d6-b94d-4a092fba75f1')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','d4d32443-dce9-41d6-b94d-4a092fba75f1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d4d32443-dce9-41d6-b94d-4a092fba75f1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d4ce1ea-2842-43a3-9c79-78cb06443c9f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8d4ce1ea-2842-43a3-9c79-78cb06443c9f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8d4ce1ea-2842-43a3-9c79-78cb06443c9f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fddb281d-7e69-42fe-9659-30d6c04cc881')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','fddb281d-7e69-42fe-9659-30d6c04cc881')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fddb281d-7e69-42fe-9659-30d6c04cc881')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8c14505b-61ca-48c4-814f-5f942df82737')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','8c14505b-61ca-48c4-814f-5f942df82737')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eae34c6d-66e4-43ed-b1c0-e23a86143afd')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','eae34c6d-66e4-43ed-b1c0-e23a86143afd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','150822f7-36a3-486e-960c-4491c82119f4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','150822f7-36a3-486e-960c-4491c82119f4')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','150822f7-36a3-486e-960c-4491c82119f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d8112a2b-38fa-41e6-9ba9-f1aaaea37b49')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d8112a2b-38fa-41e6-9ba9-f1aaaea37b49')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d8112a2b-38fa-41e6-9ba9-f1aaaea37b49')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e81e39a8-d354-48b5-ae6b-74640d3bd450')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e81e39a8-d354-48b5-ae6b-74640d3bd450')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','e81e39a8-d354-48b5-ae6b-74640d3bd450')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b29324a0-37c1-4b13-ad0b-e9334bb52890')
,('4b055876-e210-4e43-aea3-9167e5afb724','b29324a0-37c1-4b13-ad0b-e9334bb52890')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','81410616-b3da-4708-8926-fc0d9112e33d')
,('4b055876-e210-4e43-aea3-9167e5afb724','81410616-b3da-4708-8926-fc0d9112e33d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8575816-f79e-469c-9c3e-bd30a3ea2cad')
,('4b055876-e210-4e43-aea3-9167e5afb724','c8575816-f79e-469c-9c3e-bd30a3ea2cad')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c2f28205-c609-4613-87f6-3f399679fb56')
,('4b055876-e210-4e43-aea3-9167e5afb724','c2f28205-c609-4613-87f6-3f399679fb56')
,('c7e230da-3c22-4915-9ad9-968f874536a5','3a6399b6-d380-4e1e-859d-fc89720f830d')
,('4b055876-e210-4e43-aea3-9167e5afb724','3a6399b6-d380-4e1e-859d-fc89720f830d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d83105fe-1ca5-4ad8-8437-1ce16788c9b8')
,('4b055876-e210-4e43-aea3-9167e5afb724','d83105fe-1ca5-4ad8-8437-1ce16788c9b8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d83105fe-1ca5-4ad8-8437-1ce16788c9b8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b3dbaf74-067b-4fe0-be4e-707bc6ea084b')
,('4b055876-e210-4e43-aea3-9167e5afb724','b3dbaf74-067b-4fe0-be4e-707bc6ea084b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b3dbaf74-067b-4fe0-be4e-707bc6ea084b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e3dedf70-cc72-4725-b282-ba91f9f2f38f')
,('4b055876-e210-4e43-aea3-9167e5afb724','e3dedf70-cc72-4725-b282-ba91f9f2f38f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e3dedf70-cc72-4725-b282-ba91f9f2f38f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','95002715-7aef-42f9-bf26-f608d7c73d01')
,('4b055876-e210-4e43-aea3-9167e5afb724','95002715-7aef-42f9-bf26-f608d7c73d01')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95002715-7aef-42f9-bf26-f608d7c73d01')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','863796d0-bab0-455a-9c5d-90cd52a04d5c')
,('4b055876-e210-4e43-aea3-9167e5afb724','863796d0-bab0-455a-9c5d-90cd52a04d5c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','863796d0-bab0-455a-9c5d-90cd52a04d5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aeb9af89-2f5a-4ed5-a69e-413f9b800ba5')
,('4b055876-e210-4e43-aea3-9167e5afb724','aeb9af89-2f5a-4ed5-a69e-413f9b800ba5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aeb9af89-2f5a-4ed5-a69e-413f9b800ba5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ddb133dd-9d61-477b-8064-9987896d017a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ddb133dd-9d61-477b-8064-9987896d017a')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','ddb133dd-9d61-477b-8064-9987896d017a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','846a483f-f909-48a2-a75c-b286ac7c5aca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','846a483f-f909-48a2-a75c-b286ac7c5aca')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','846a483f-f909-48a2-a75c-b286ac7c5aca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee3f0074-4267-4475-89ac-d5061c3eea9a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee3f0074-4267-4475-89ac-d5061c3eea9a')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','ee3f0074-4267-4475-89ac-d5061c3eea9a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','536bcb5b-7b0c-421f-9486-d585e9389ad3')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','536bcb5b-7b0c-421f-9486-d585e9389ad3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9529663b-0342-44a5-bb6d-a47bc1d8d7fe')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','9529663b-0342-44a5-bb6d-a47bc1d8d7fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','60df1659-1deb-4161-876c-e58ac24463d5')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','60df1659-1deb-4161-876c-e58ac24463d5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','851225f7-c73b-42aa-b731-f8e87427b213')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','851225f7-c73b-42aa-b731-f8e87427b213')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','851225f7-c73b-42aa-b731-f8e87427b213')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','614ba012-09f8-434b-a1d6-91478db1a564')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','614ba012-09f8-434b-a1d6-91478db1a564')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','614ba012-09f8-434b-a1d6-91478db1a564')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3857335a-658d-4a0e-8a93-797938a38982')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3857335a-658d-4a0e-8a93-797938a38982')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','3857335a-658d-4a0e-8a93-797938a38982')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6bd47091-6cd3-4c0f-874b-2592c97c2fe7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6bd47091-6cd3-4c0f-874b-2592c97c2fe7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','045640ae-4bd9-4030-88d4-55cef7c953f3')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','045640ae-4bd9-4030-88d4-55cef7c953f3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','045640ae-4bd9-4030-88d4-55cef7c953f3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','361caea1-6534-4e29-9912-7cba5fa18966')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','361caea1-6534-4e29-9912-7cba5fa18966')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','361caea1-6534-4e29-9912-7cba5fa18966')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','257528fc-df94-4abf-9f75-f32d2159f340')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','257528fc-df94-4abf-9f75-f32d2159f340')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','257528fc-df94-4abf-9f75-f32d2159f340')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','489fffcb-ef37-455e-baf8-5029f7edfc80')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','489fffcb-ef37-455e-baf8-5029f7edfc80')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','489fffcb-ef37-455e-baf8-5029f7edfc80')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e40f416e-7600-455b-87c3-b171d350be07')
,('4b055876-e210-4e43-aea3-9167e5afb724','e40f416e-7600-455b-87c3-b171d350be07')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e40f416e-7600-455b-87c3-b171d350be07')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9b747d4c-c718-4508-9059-4c8e4dea7c4c')
,('4b055876-e210-4e43-aea3-9167e5afb724','9b747d4c-c718-4508-9059-4c8e4dea7c4c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9b747d4c-c718-4508-9059-4c8e4dea7c4c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d40025d2-eff9-47ec-a32f-5e09d4598bfd')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d40025d2-eff9-47ec-a32f-5e09d4598bfd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e60a2a03-f7e4-4e13-a6cc-96cc47139c42')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','e60a2a03-f7e4-4e13-a6cc-96cc47139c42')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2723cc1a-4f5b-4016-bbc3-d053e2b2b87b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2723cc1a-4f5b-4016-bbc3-d053e2b2b87b')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','2723cc1a-4f5b-4016-bbc3-d053e2b2b87b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7612c27c-bf40-4c6d-81a2-4fb8c6a552df')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7612c27c-bf40-4c6d-81a2-4fb8c6a552df')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','7612c27c-bf40-4c6d-81a2-4fb8c6a552df')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','68bec88b-3d75-446c-8977-fd76127aa47f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','68bec88b-3d75-446c-8977-fd76127aa47f')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','68bec88b-3d75-446c-8977-fd76127aa47f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b7d79d5-ed84-48c3-9af1-89736af2cfce')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b7d79d5-ed84-48c3-9af1-89736af2cfce')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ed31cc31-11e6-4c01-94c0-350711852d72')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ed31cc31-11e6-4c01-94c0-350711852d72')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','ae80ed19-ce83-4165-94a5-8bd06458af55')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ae80ed19-ce83-4165-94a5-8bd06458af55')
,('10cedc5f-717a-4800-b837-d250cce7c101','ae80ed19-ce83-4165-94a5-8bd06458af55')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','d56a6498-1080-4f0e-abc6-d6367d21aec2')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a32f0f61-864c-4ada-902e-d5bf7549faeb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a32f0f61-864c-4ada-902e-d5bf7549faeb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a32f0f61-864c-4ada-902e-d5bf7549faeb')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','1f05e7ad-6798-4963-b237-ec18d64ea579')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1f05e7ad-6798-4963-b237-ec18d64ea579')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1f05e7ad-6798-4963-b237-ec18d64ea579')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','1f05e7ad-6798-4963-b237-ec18d64ea579')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','749ff365-ec70-4581-bd0e-915aba9e90d6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','749ff365-ec70-4581-bd0e-915aba9e90d6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','749ff365-ec70-4581-bd0e-915aba9e90d6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4206e43-70dd-4e95-8c45-e398c95e1502')
,('4b055876-e210-4e43-aea3-9167e5afb724','e4206e43-70dd-4e95-8c45-e398c95e1502')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e4206e43-70dd-4e95-8c45-e398c95e1502')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','72da8143-f705-4120-a0f0-b33c94228fa7')
,('4b055876-e210-4e43-aea3-9167e5afb724','72da8143-f705-4120-a0f0-b33c94228fa7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','72da8143-f705-4120-a0f0-b33c94228fa7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','14acc4da-bfa9-4d09-a8d1-c87fa9151288')
,('4b055876-e210-4e43-aea3-9167e5afb724','14acc4da-bfa9-4d09-a8d1-c87fa9151288')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','14acc4da-bfa9-4d09-a8d1-c87fa9151288')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','feb20cff-8c93-475a-82b8-ed4fceb516fe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','feb20cff-8c93-475a-82b8-ed4fceb516fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b6249ee0-2869-41bd-9c15-f2014a199d03')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b6249ee0-2869-41bd-9c15-f2014a199d03')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82d63b77-def8-470d-8146-f0d4d7e045c3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82d63b77-def8-470d-8146-f0d4d7e045c3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d129486-9488-405e-bc9b-77e17caef249')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','25ff5ebf-5eb8-4a96-8358-2a75c3ff574d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','25ff5ebf-5eb8-4a96-8358-2a75c3ff574d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f37c9b50-2bff-4f95-9a1c-3aebfea203b0')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','f37c9b50-2bff-4f95-9a1c-3aebfea203b0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f37c9b50-2bff-4f95-9a1c-3aebfea203b0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cdad595d-7ca9-4619-b424-3d7bcda6e09f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','cdad595d-7ca9-4619-b424-3d7bcda6e09f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cdad595d-7ca9-4619-b424-3d7bcda6e09f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6da13010-0525-4d92-b9f8-d880697e6381')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','6da13010-0525-4d92-b9f8-d880697e6381')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6da13010-0525-4d92-b9f8-d880697e6381')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d120aa8-7d14-4948-a7a7-e57b07c33cc7')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8d120aa8-7d14-4948-a7a7-e57b07c33cc7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8d120aa8-7d14-4948-a7a7-e57b07c33cc7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6bbebb13-100e-4338-9f0a-2c092e5f741b')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','6bbebb13-100e-4338-9f0a-2c092e5f741b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6bbebb13-100e-4338-9f0a-2c092e5f741b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48d54926-2a3b-4112-86e2-9f042e684049')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','48d54926-2a3b-4112-86e2-9f042e684049')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','48d54926-2a3b-4112-86e2-9f042e684049')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48d54926-2a3b-4112-86e2-9f042e684049')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5f1475ee-b8f7-4a93-b374-639ecb15dc64')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','5f1475ee-b8f7-4a93-b374-639ecb15dc64')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','5f1475ee-b8f7-4a93-b374-639ecb15dc64')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5f1475ee-b8f7-4a93-b374-639ecb15dc64')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82390642-7053-449a-84fe-d618f6a72941')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','82390642-7053-449a-84fe-d618f6a72941')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','82390642-7053-449a-84fe-d618f6a72941')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82390642-7053-449a-84fe-d618f6a72941')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','405849b7-ce12-4592-ab7b-882559c245b7')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','405849b7-ce12-4592-ab7b-882559c245b7')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','405849b7-ce12-4592-ab7b-882559c245b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','405849b7-ce12-4592-ab7b-882559c245b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0c1782f-a3ee-4485-ae9a-d8d8d3210932')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','b0c1782f-a3ee-4485-ae9a-d8d8d3210932')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','b0c1782f-a3ee-4485-ae9a-d8d8d3210932')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0c1782f-a3ee-4485-ae9a-d8d8d3210932')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','640bf5b7-a7d1-41d3-aad6-aba2244dff21')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','640bf5b7-a7d1-41d3-aad6-aba2244dff21')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','640bf5b7-a7d1-41d3-aad6-aba2244dff21')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','640bf5b7-a7d1-41d3-aad6-aba2244dff21')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ad3895a7-d478-4ae4-b0e6-d5e07bbd42ea')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ad3895a7-d478-4ae4-b0e6-d5e07bbd42ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ad3895a7-d478-4ae4-b0e6-d5e07bbd42ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0a568dfa-7f5c-4c22-955f-5d353419379c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','0a568dfa-7f5c-4c22-955f-5d353419379c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0a568dfa-7f5c-4c22-955f-5d353419379c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a6923afe-3518-4431-ad9a-798a779dd563')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','a6923afe-3518-4431-ad9a-798a779dd563')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a6923afe-3518-4431-ad9a-798a779dd563')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','100773ae-8df1-403e-b033-6cdfbb04265c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','100773ae-8df1-403e-b033-6cdfbb04265c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','100773ae-8df1-403e-b033-6cdfbb04265c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8890ef3e-dfd5-4b02-87e2-ba7f6eaa3ea2')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8890ef3e-dfd5-4b02-87e2-ba7f6eaa3ea2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8890ef3e-dfd5-4b02-87e2-ba7f6eaa3ea2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1da96b7a-9f56-441f-9b6c-9bdea20847c0')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1da96b7a-9f56-441f-9b6c-9bdea20847c0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1da96b7a-9f56-441f-9b6c-9bdea20847c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fbe83272-5992-4760-8c8b-b38563992052')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','fbe83272-5992-4760-8c8b-b38563992052')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fbe83272-5992-4760-8c8b-b38563992052')
,('223f4787-af72-40d1-986e-51d048898c9d','44502186-3f5b-4eea-9368-6230dc63d8b3')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','44502186-3f5b-4eea-9368-6230dc63d8b3')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','44502186-3f5b-4eea-9368-6230dc63d8b3')
,('223f4787-af72-40d1-986e-51d048898c9d','9a36811c-c087-4c81-adf6-16d8ae822318')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9a36811c-c087-4c81-adf6-16d8ae822318')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','9a36811c-c087-4c81-adf6-16d8ae822318')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','1c0d685b-7724-4da8-8532-b914e49d95e6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','89fc21d9-668d-4226-a1f0-6636b7594a91')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89fc21d9-668d-4226-a1f0-6636b7594a91')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','89fc21d9-668d-4226-a1f0-6636b7594a91')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','030e96da-f1ad-489b-b6d4-fa92d58f4b1c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a046ad0a-0d90-4396-b68f-3156bf5c50b6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a046ad0a-0d90-4396-b68f-3156bf5c50b6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a046ad0a-0d90-4396-b68f-3156bf5c50b6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','5bf1b629-6265-43f1-9d21-4e4710e847aa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5bf1b629-6265-43f1-9d21-4e4710e847aa')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5bf1b629-6265-43f1-9d21-4e4710e847aa')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','958e5bbb-de00-4e3f-a78c-be16269a1512')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','958e5bbb-de00-4e3f-a78c-be16269a1512')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','958e5bbb-de00-4e3f-a78c-be16269a1512')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','fb836830-1486-4666-a64b-ee3a980e950e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','fb836830-1486-4666-a64b-ee3a980e950e')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','fb836830-1486-4666-a64b-ee3a980e950e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fb836830-1486-4666-a64b-ee3a980e950e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fb836830-1486-4666-a64b-ee3a980e950e')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','fb836830-1486-4666-a64b-ee3a980e950e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','25e0f1e0-51b5-4be0-8257-712f5d8a409c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','25e0f1e0-51b5-4be0-8257-712f5d8a409c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','25e0f1e0-51b5-4be0-8257-712f5d8a409c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','1bd1b130-de7c-44ca-96e9-383416dddef8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1bd1b130-de7c-44ca-96e9-383416dddef8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1bd1b130-de7c-44ca-96e9-383416dddef8')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c337a3a1-f9ef-4dfb-a233-87a10ab09595')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c337a3a1-f9ef-4dfb-a233-87a10ab09595')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c337a3a1-f9ef-4dfb-a233-87a10ab09595')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c8ae69d9-ff83-4b31-ad99-d09473de35b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8ae69d9-ff83-4b31-ad99-d09473de35b7')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','c8ae69d9-ff83-4b31-ad99-d09473de35b7')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','c8ae69d9-ff83-4b31-ad99-d09473de35b7')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e3eaefee-d687-45d3-9d1a-effe42d70104')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e3eaefee-d687-45d3-9d1a-effe42d70104')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','e3eaefee-d687-45d3-9d1a-effe42d70104')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','e3eaefee-d687-45d3-9d1a-effe42d70104')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9af6737-b420-48e2-a02c-74f49edfe461')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9af6737-b420-48e2-a02c-74f49edfe461')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','b9af6737-b420-48e2-a02c-74f49edfe461')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6812b049-f376-4519-aea8-228796feb87f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6812b049-f376-4519-aea8-228796feb87f')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','6812b049-f376-4519-aea8-228796feb87f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e695c37d-c0c3-4de6-bb8e-df462773d1b6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e695c37d-c0c3-4de6-bb8e-df462773d1b6')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','e695c37d-c0c3-4de6-bb8e-df462773d1b6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48309e9c-42c2-4bb0-96f0-007363d6ee2c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48309e9c-42c2-4bb0-96f0-007363d6ee2c')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','48309e9c-42c2-4bb0-96f0-007363d6ee2c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa63dbb5-5673-4a2f-9977-801d273135ec')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fa63dbb5-5673-4a2f-9977-801d273135ec')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','fa63dbb5-5673-4a2f-9977-801d273135ec')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dc231a2a-ee57-4128-915a-9225d0cbcdcc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dc231a2a-ee57-4128-915a-9225d0cbcdcc')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','dc231a2a-ee57-4128-915a-9225d0cbcdcc')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','0479b799-62a8-4e7f-abce-38e3993c4258')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0479b799-62a8-4e7f-abce-38e3993c4258')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0479b799-62a8-4e7f-abce-38e3993c4258')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','eebd7e89-8b15-4b99-a8a5-dded98b836c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eebd7e89-8b15-4b99-a8a5-dded98b836c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eebd7e89-8b15-4b99-a8a5-dded98b836c6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9bb65bea-081a-40f3-b250-7ae3f191bda8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9bb65bea-081a-40f3-b250-7ae3f191bda8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9bb65bea-081a-40f3-b250-7ae3f191bda8')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','26c4675c-0401-4993-8902-de335b52a055')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','26c4675c-0401-4993-8902-de335b52a055')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','26c4675c-0401-4993-8902-de335b52a055')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9f98f506-4006-43a3-b3ca-eea20b27d1ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f98f506-4006-43a3-b3ca-eea20b27d1ab')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9f98f506-4006-43a3-b3ca-eea20b27d1ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ebb67702-014a-4bd1-94ef-36f9d1060e7c')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','ebb67702-014a-4bd1-94ef-36f9d1060e7c')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','ebb67702-014a-4bd1-94ef-36f9d1060e7c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ebb67702-014a-4bd1-94ef-36f9d1060e7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8af1839c-aeda-4d7f-9669-4cf86126f8f8')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','8af1839c-aeda-4d7f-9669-4cf86126f8f8')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','8af1839c-aeda-4d7f-9669-4cf86126f8f8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8af1839c-aeda-4d7f-9669-4cf86126f8f8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fe03af7d-251f-470c-96f6-47cffb66217d')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','fe03af7d-251f-470c-96f6-47cffb66217d')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','fe03af7d-251f-470c-96f6-47cffb66217d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fe03af7d-251f-470c-96f6-47cffb66217d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e5f51d0-60c8-43f7-8d18-659fbf114e54')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','2e5f51d0-60c8-43f7-8d18-659fbf114e54')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','2e5f51d0-60c8-43f7-8d18-659fbf114e54')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e5f51d0-60c8-43f7-8d18-659fbf114e54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f2092661-e72e-477e-9918-5f12d35577b8')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','f2092661-e72e-477e-9918-5f12d35577b8')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','f2092661-e72e-477e-9918-5f12d35577b8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f2092661-e72e-477e-9918-5f12d35577b8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5a2991e9-ca4b-48c2-8174-3da70cadd677')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5a2991e9-ca4b-48c2-8174-3da70cadd677')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','5a2991e9-ca4b-48c2-8174-3da70cadd677')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b6e3d50e-f2c3-46a7-85df-3eb0a4265d9b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b6e3d50e-f2c3-46a7-85df-3eb0a4265d9b')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','b6e3d50e-f2c3-46a7-85df-3eb0a4265d9b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','311a4bb3-62f2-4f8f-9d9e-779def7dbf91')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','311a4bb3-62f2-4f8f-9d9e-779def7dbf91')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','311a4bb3-62f2-4f8f-9d9e-779def7dbf91')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1f2ffb46-9951-4624-9dfc-eadf173c9ded')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1f2ffb46-9951-4624-9dfc-eadf173c9ded')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','1f2ffb46-9951-4624-9dfc-eadf173c9ded')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6e8234ee-4f40-437a-8345-3e72536dac4f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6e8234ee-4f40-437a-8345-3e72536dac4f')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','6e8234ee-4f40-437a-8345-3e72536dac4f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','060f54da-d9be-410f-93c2-f9cddeb9404e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','060f54da-d9be-410f-93c2-f9cddeb9404e')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','060f54da-d9be-410f-93c2-f9cddeb9404e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','78fbb848-3b61-43a4-9ac4-7f3290ac9fbc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','78fbb848-3b61-43a4-9ac4-7f3290ac9fbc')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','78fbb848-3b61-43a4-9ac4-7f3290ac9fbc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','78ba1c7d-de3c-40b3-a075-f7908a90a898')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','78ba1c7d-de3c-40b3-a075-f7908a90a898')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','78ba1c7d-de3c-40b3-a075-f7908a90a898')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0d93ae2a-e911-4418-8710-a8b1e7be3af0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0d93ae2a-e911-4418-8710-a8b1e7be3af0')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','0d93ae2a-e911-4418-8710-a8b1e7be3af0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0abaef3-16c3-4858-b0f9-37f043b9c9f0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c0abaef3-16c3-4858-b0f9-37f043b9c9f0')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','c0abaef3-16c3-4858-b0f9-37f043b9c9f0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4946d83-2348-48d5-a68f-f4ee3a48521c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e4946d83-2348-48d5-a68f-f4ee3a48521c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df4a0b02-c9c1-40ac-8932-5478a9dba419')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','aeb44d8f-8441-44eb-abfa-cc5d3e211f08')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','aeb44d8f-8441-44eb-abfa-cc5d3e211f08')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aeb44d8f-8441-44eb-abfa-cc5d3e211f08')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','aeb44d8f-8441-44eb-abfa-cc5d3e211f08')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aeb44d8f-8441-44eb-abfa-cc5d3e211f08')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','f4a05875-61b2-4ef7-a77c-cb9cf727c3d0')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','f4a05875-61b2-4ef7-a77c-cb9cf727c3d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f4a05875-61b2-4ef7-a77c-cb9cf727c3d0')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','f4a05875-61b2-4ef7-a77c-cb9cf727c3d0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f4a05875-61b2-4ef7-a77c-cb9cf727c3d0')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','abd1338f-f0db-4222-ab74-a24cdf3f8fc3')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','abd1338f-f0db-4222-ab74-a24cdf3f8fc3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','abd1338f-f0db-4222-ab74-a24cdf3f8fc3')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','abd1338f-f0db-4222-ab74-a24cdf3f8fc3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','abd1338f-f0db-4222-ab74-a24cdf3f8fc3')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','51eb36ba-b06f-498f-b355-46b8c267b220')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','51eb36ba-b06f-498f-b355-46b8c267b220')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','51eb36ba-b06f-498f-b355-46b8c267b220')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','51eb36ba-b06f-498f-b355-46b8c267b220')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','51eb36ba-b06f-498f-b355-46b8c267b220')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','16e0415d-7c77-4030-8c18-289d46c95711')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','16e0415d-7c77-4030-8c18-289d46c95711')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16e0415d-7c77-4030-8c18-289d46c95711')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','16e0415d-7c77-4030-8c18-289d46c95711')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16e0415d-7c77-4030-8c18-289d46c95711')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','c8d98fa2-b6c9-40ad-967a-7b5650f9b02c')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','c8d98fa2-b6c9-40ad-967a-7b5650f9b02c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8d98fa2-b6c9-40ad-967a-7b5650f9b02c')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','c8d98fa2-b6c9-40ad-967a-7b5650f9b02c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c8d98fa2-b6c9-40ad-967a-7b5650f9b02c')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','ec3595c2-5cf6-4525-9507-8b259eba98be')
,('3f29763e-aa51-4e87-8667-86c39fed8251','ec3595c2-5cf6-4525-9507-8b259eba98be')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','ec3595c2-5cf6-4525-9507-8b259eba98be')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','e2de828f-3131-4a2f-95de-335ffedeadbf')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','e2de828f-3131-4a2f-95de-335ffedeadbf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e2de828f-3131-4a2f-95de-335ffedeadbf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e2de828f-3131-4a2f-95de-335ffedeadbf')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','0d2fb0be-a134-47b3-bbd3-fc74868facca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0d2fb0be-a134-47b3-bbd3-fc74868facca')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','0d2fb0be-a134-47b3-bbd3-fc74868facca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1395a665-5d9f-4cef-a555-26d29621dbea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','85b363d9-6a69-4922-b101-9847be43d550')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ceddb26-e521-433f-bbd7-fd370676fd66')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','990d25fc-dcfb-477c-bc15-4b66875cc1e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b3f3f267-46de-461d-880e-1dc1409d0c18')
,('4b055876-e210-4e43-aea3-9167e5afb724','b3f3f267-46de-461d-880e-1dc1409d0c18')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','562768a3-2b3b-4a80-a3d0-55fc0e63e095')
,('4b055876-e210-4e43-aea3-9167e5afb724','562768a3-2b3b-4a80-a3d0-55fc0e63e095')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3a3def8f-e64e-4963-8b59-29be9c5289f0')
,('4b055876-e210-4e43-aea3-9167e5afb724','3a3def8f-e64e-4963-8b59-29be9c5289f0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f1f327dd-dd38-4af8-a8a0-97c5b02492f7')
,('4b055876-e210-4e43-aea3-9167e5afb724','f1f327dd-dd38-4af8-a8a0-97c5b02492f7')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','42b2e3a9-0681-4b35-893d-5c3e4774aa21')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','42b2e3a9-0681-4b35-893d-5c3e4774aa21')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','42b2e3a9-0681-4b35-893d-5c3e4774aa21')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','42b2e3a9-0681-4b35-893d-5c3e4774aa21')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a07ba4e0-9886-424e-af8f-e35f2b5267af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a07ba4e0-9886-424e-af8f-e35f2b5267af')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ab2f63a7-2dcd-44cb-a898-39d5dec00f65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab2f63a7-2dcd-44cb-a898-39d5dec00f65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab2f63a7-2dcd-44cb-a898-39d5dec00f65')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','80368835-bb71-4ae3-a5e8-2fda18a4fed4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','80368835-bb71-4ae3-a5e8-2fda18a4fed4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','80368835-bb71-4ae3-a5e8-2fda18a4fed4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','3ababf27-68b7-4dd2-8e26-4aedcb1a5066')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3ababf27-68b7-4dd2-8e26-4aedcb1a5066')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3ababf27-68b7-4dd2-8e26-4aedcb1a5066')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','99486432-50d1-4e3f-a35f-94fa7d6464cf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','99486432-50d1-4e3f-a35f-94fa7d6464cf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','99486432-50d1-4e3f-a35f-94fa7d6464cf')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','df395823-5d77-4486-bbb6-f6ce6d97fabc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df395823-5d77-4486-bbb6-f6ce6d97fabc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df395823-5d77-4486-bbb6-f6ce6d97fabc')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','5d644929-d66d-4a05-90e0-1e1a08958c95')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5d644929-d66d-4a05-90e0-1e1a08958c95')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5d644929-d66d-4a05-90e0-1e1a08958c95')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab7479ec-20d4-4b2f-ba3b-bbff202af943')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab7479ec-20d4-4b2f-ba3b-bbff202af943')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','ab7479ec-20d4-4b2f-ba3b-bbff202af943')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','27dd30bf-22a9-4948-a0d2-11071eb64cf1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','27dd30bf-22a9-4948-a0d2-11071eb64cf1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a3a367e4-fb6f-4dc5-b223-fd7182e54bb3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a3a367e4-fb6f-4dc5-b223-fd7182e54bb3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b94bff44-6a49-4822-98e7-d68a3ad71c40')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b94bff44-6a49-4822-98e7-d68a3ad71c40')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','947a0b2b-8c4c-4441-b9d3-712b0ce42ed0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','947a0b2b-8c4c-4441-b9d3-712b0ce42ed0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65b9ef0d-09a4-4539-9006-05d19b5ab944')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','65b9ef0d-09a4-4539-9006-05d19b5ab944')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7fb81607-a071-4273-91d8-38530b60347f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7fb81607-a071-4273-91d8-38530b60347f')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','c8916b45-df9f-4ea3-b37b-436b788e439d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8916b45-df9f-4ea3-b37b-436b788e439d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c8916b45-df9f-4ea3-b37b-436b788e439d')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','fa99df80-6dc5-454f-a876-36f255436286')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa99df80-6dc5-454f-a876-36f255436286')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','cb83a996-bd43-404a-8544-9baebc0b84bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb83a996-bd43-404a-8544-9baebc0b84bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cb83a996-bd43-404a-8544-9baebc0b84bf')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','1e36d638-fe7c-4492-ad6b-d9c476b41918')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e36d638-fe7c-4492-ad6b-d9c476b41918')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e36d638-fe7c-4492-ad6b-d9c476b41918')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','6f29f7ab-7b2b-4ecc-955e-de459be1e368')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6f29f7ab-7b2b-4ecc-955e-de459be1e368')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6f29f7ab-7b2b-4ecc-955e-de459be1e368')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee6c8b9f-e370-478c-92f7-9fe488ecb2e3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee6c8b9f-e370-478c-92f7-9fe488ecb2e3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b44ce451-3de6-458b-a5bc-2dd960ff5e9d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b44ce451-3de6-458b-a5bc-2dd960ff5e9d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bfc2e8f3-f13d-451c-883b-cf9e306bf5c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bfc2e8f3-f13d-451c-883b-cf9e306bf5c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6d6ae25a-16f6-4e21-9075-c7d0775e677a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6d6ae25a-16f6-4e21-9075-c7d0775e677a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','80d19c0d-ab6e-46c9-a847-b103b07cdf12')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','80d19c0d-ab6e-46c9-a847-b103b07cdf12')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a41b43c0-e9bf-481a-983a-5789c4da219c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a41b43c0-e9bf-481a-983a-5789c4da219c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','125ae090-ff2a-43df-967d-b4ac6aa5999b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','125ae090-ff2a-43df-967d-b4ac6aa5999b')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','125ae090-ff2a-43df-967d-b4ac6aa5999b')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','af2c7fb1-c6aa-4cc7-9a37-cb161795eb7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','39a3017a-aaaa-4fcd-9fdc-33ccfd66d60a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','39a3017a-aaaa-4fcd-9fdc-33ccfd66d60a')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','39a3017a-aaaa-4fcd-9fdc-33ccfd66d60a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','515ccc09-a04b-46e3-9ba9-cda36e81e21c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','515ccc09-a04b-46e3-9ba9-cda36e81e21c')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','515ccc09-a04b-46e3-9ba9-cda36e81e21c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ef70a032-c44d-4752-b3fc-96fae88c3034')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ef70a032-c44d-4752-b3fc-96fae88c3034')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','ef70a032-c44d-4752-b3fc-96fae88c3034')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','450e3c0a-b8d8-4258-8525-a99160db3461')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','450e3c0a-b8d8-4258-8525-a99160db3461')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','450e3c0a-b8d8-4258-8525-a99160db3461')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','450e3c0a-b8d8-4258-8525-a99160db3461')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','a3ee636d-c622-4789-849b-83c24548e3f4')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','a3ee636d-c622-4789-849b-83c24548e3f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a3ee636d-c622-4789-849b-83c24548e3f4')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','a3ee636d-c622-4789-849b-83c24548e3f4')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','b7b405aa-4607-4996-99d5-9c564e289556')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','b7b405aa-4607-4996-99d5-9c564e289556')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b7b405aa-4607-4996-99d5-9c564e289556')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','b7b405aa-4607-4996-99d5-9c564e289556')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','27f773db-c54f-4b5d-947e-2f1ddd5e156b')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','27f773db-c54f-4b5d-947e-2f1ddd5e156b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','27f773db-c54f-4b5d-947e-2f1ddd5e156b')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','27f773db-c54f-4b5d-947e-2f1ddd5e156b')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','2262acc1-1983-4f8f-b02a-1cc89d3ffd57')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','2262acc1-1983-4f8f-b02a-1cc89d3ffd57')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2262acc1-1983-4f8f-b02a-1cc89d3ffd57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2262acc1-1983-4f8f-b02a-1cc89d3ffd57')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','fa8ff1f8-4a25-497d-830d-db3fe2d8a487')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','fa8ff1f8-4a25-497d-830d-db3fe2d8a487')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa8ff1f8-4a25-497d-830d-db3fe2d8a487')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fa8ff1f8-4a25-497d-830d-db3fe2d8a487')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','d215e86f-2cf1-40a6-a936-4c9296f68bcb')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','d215e86f-2cf1-40a6-a936-4c9296f68bcb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d215e86f-2cf1-40a6-a936-4c9296f68bcb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d215e86f-2cf1-40a6-a936-4c9296f68bcb')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','d215e86f-2cf1-40a6-a936-4c9296f68bcb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','273b1864-df66-43c8-8169-91f43e9092c0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','273b1864-df66-43c8-8169-91f43e9092c0')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','273b1864-df66-43c8-8169-91f43e9092c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6df7d462-19b7-4f98-b7c2-4d9c336e6e97')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6df7d462-19b7-4f98-b7c2-4d9c336e6e97')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','6df7d462-19b7-4f98-b7c2-4d9c336e6e97')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','e754c5e6-6e57-47a9-9bd2-89d615ac6645')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','e754c5e6-6e57-47a9-9bd2-89d615ac6645')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e754c5e6-6e57-47a9-9bd2-89d615ac6645')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e754c5e6-6e57-47a9-9bd2-89d615ac6645')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','63b55dbf-4ad2-4d97-bd16-3e9c148f1900')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','63b55dbf-4ad2-4d97-bd16-3e9c148f1900')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','63b55dbf-4ad2-4d97-bd16-3e9c148f1900')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','63b55dbf-4ad2-4d97-bd16-3e9c148f1900')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','11dc6c5a-4d9a-4bcb-9c3f-5d0ea754aa1e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','11dc6c5a-4d9a-4bcb-9c3f-5d0ea754aa1e')
,('10cedc5f-717a-4800-b837-d250cce7c101','11dc6c5a-4d9a-4bcb-9c3f-5d0ea754aa1e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','11dc6c5a-4d9a-4bcb-9c3f-5d0ea754aa1e')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','6e5da891-9277-4994-9320-827f35f2e080')
,('10cedc5f-717a-4800-b837-d250cce7c101','6e5da891-9277-4994-9320-827f35f2e080')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','81202c52-fe77-4d2f-a9ea-a40681a25e8f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','81202c52-fe77-4d2f-a9ea-a40681a25e8f')
,('10cedc5f-717a-4800-b837-d250cce7c101','81202c52-fe77-4d2f-a9ea-a40681a25e8f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','81202c52-fe77-4d2f-a9ea-a40681a25e8f')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','e11a7b8f-480d-4aa1-9da2-1cb903f89277')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e11a7b8f-480d-4aa1-9da2-1cb903f89277')
,('10cedc5f-717a-4800-b837-d250cce7c101','e11a7b8f-480d-4aa1-9da2-1cb903f89277')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e11a7b8f-480d-4aa1-9da2-1cb903f89277')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','45dfb1ac-4d11-4ac5-9d9d-9c30b17a108e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','45dfb1ac-4d11-4ac5-9d9d-9c30b17a108e')
,('10cedc5f-717a-4800-b837-d250cce7c101','45dfb1ac-4d11-4ac5-9d9d-9c30b17a108e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','45dfb1ac-4d11-4ac5-9d9d-9c30b17a108e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','05bef5b0-5382-44fc-b7f7-02a1605607ce')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','05bef5b0-5382-44fc-b7f7-02a1605607ce')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','05bef5b0-5382-44fc-b7f7-02a1605607ce')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','05bef5b0-5382-44fc-b7f7-02a1605607ce')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','05bef5b0-5382-44fc-b7f7-02a1605607ce')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','d802499c-9703-4ccb-a592-728dc295d315')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','d802499c-9703-4ccb-a592-728dc295d315')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d802499c-9703-4ccb-a592-728dc295d315')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','d802499c-9703-4ccb-a592-728dc295d315')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e6a138ff-07f0-4e5e-8c85-c8a11cb2306c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e6a138ff-07f0-4e5e-8c85-c8a11cb2306c')
,('6c26c1ab-90d8-4c91-a4d0-39d60c92575d','e6a138ff-07f0-4e5e-8c85-c8a11cb2306c')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','494a8e3e-b698-4444-aaa4-d2f371997b0b')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','494a8e3e-b698-4444-aaa4-d2f371997b0b')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','494a8e3e-b698-4444-aaa4-d2f371997b0b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d67793d6-e401-45d6-bc41-c338c134607c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f4168eed-09fb-4709-92fd-ea7ef9f49cd5')
,('4b055876-e210-4e43-aea3-9167e5afb724','f4168eed-09fb-4709-92fd-ea7ef9f49cd5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f4168eed-09fb-4709-92fd-ea7ef9f49cd5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5c249be6-5963-4705-b64d-8196858a7321')
,('4b055876-e210-4e43-aea3-9167e5afb724','5c249be6-5963-4705-b64d-8196858a7321')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5c249be6-5963-4705-b64d-8196858a7321')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e5080842-f427-486a-bc46-6e0341af4905')
,('4b055876-e210-4e43-aea3-9167e5afb724','e5080842-f427-486a-bc46-6e0341af4905')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e5080842-f427-486a-bc46-6e0341af4905')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c853c740-2a67-4e86-a75e-c2ccc8def438')
,('4b055876-e210-4e43-aea3-9167e5afb724','c853c740-2a67-4e86-a75e-c2ccc8def438')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c853c740-2a67-4e86-a75e-c2ccc8def438')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0151b5ea-5e47-47a3-9060-d4101dba8e4b')
,('4b055876-e210-4e43-aea3-9167e5afb724','0151b5ea-5e47-47a3-9060-d4101dba8e4b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0151b5ea-5e47-47a3-9060-d4101dba8e4b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5bed5b1e-ba37-4223-9b84-320852369ac3')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','5bed5b1e-ba37-4223-9b84-320852369ac3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9cdaf7e8-119f-48aa-961b-ccdf321e424f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9cdaf7e8-119f-48aa-961b-ccdf321e424f')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','9cdaf7e8-119f-48aa-961b-ccdf321e424f')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','d93d9398-4e46-4dc7-9e29-de9c2597ae7b')
,('9a72a020-72dd-4415-ae04-451f61db3142','d93d9398-4e46-4dc7-9e29-de9c2597ae7b')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d93d9398-4e46-4dc7-9e29-de9c2597ae7b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a237e958-dc23-43c4-9b4a-c24178867e6b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a237e958-dc23-43c4-9b4a-c24178867e6b')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','a237e958-dc23-43c4-9b4a-c24178867e6b')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','d0e2f6c7-de4d-4d4b-9242-b4ec8a23842e')
,('9a72a020-72dd-4415-ae04-451f61db3142','d0e2f6c7-de4d-4d4b-9242-b4ec8a23842e')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d0e2f6c7-de4d-4d4b-9242-b4ec8a23842e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e10cdabe-3f5c-4450-83c9-c7fd4988bce9')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','e10cdabe-3f5c-4450-83c9-c7fd4988bce9')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','84dc90dc-19a1-407b-b498-7c80a42bf4dd')
,('9a72a020-72dd-4415-ae04-451f61db3142','84dc90dc-19a1-407b-b498-7c80a42bf4dd')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','84dc90dc-19a1-407b-b498-7c80a42bf4dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','954b7d53-ad0a-4e38-b1eb-67cb3636732e')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','954b7d53-ad0a-4e38-b1eb-67cb3636732e')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','cfbc6e1c-4c5b-4e7a-8a05-f717588cdc69')
,('9a72a020-72dd-4415-ae04-451f61db3142','cfbc6e1c-4c5b-4e7a-8a05-f717588cdc69')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','cfbc6e1c-4c5b-4e7a-8a05-f717588cdc69')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8874f97-5c6b-4ec5-8896-a1a16d7d5038')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c8874f97-5c6b-4ec5-8896-a1a16d7d5038')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','c8874f97-5c6b-4ec5-8896-a1a16d7d5038')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','e3048c9a-b6d4-4428-b54b-38e3e3dbe4e6')
,('9a72a020-72dd-4415-ae04-451f61db3142','e3048c9a-b6d4-4428-b54b-38e3e3dbe4e6')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','e3048c9a-b6d4-4428-b54b-38e3e3dbe4e6')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','192b65bf-a83b-4a6d-9bf9-0a5ac0a1baad')
,('9a72a020-72dd-4415-ae04-451f61db3142','192b65bf-a83b-4a6d-9bf9-0a5ac0a1baad')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','192b65bf-a83b-4a6d-9bf9-0a5ac0a1baad')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15d00f3b-bc1d-4219-bb53-1961ea0646dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','15d00f3b-bc1d-4219-bb53-1961ea0646dc')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','15d00f3b-bc1d-4219-bb53-1961ea0646dc')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','077f4e8a-efaf-4c20-bfd9-3a15f6dca769')
,('9a72a020-72dd-4415-ae04-451f61db3142','077f4e8a-efaf-4c20-bfd9-3a15f6dca769')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','077f4e8a-efaf-4c20-bfd9-3a15f6dca769')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d1b25663-47a0-45db-ae96-f77ca8a79e9e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d1b25663-47a0-45db-ae96-f77ca8a79e9e')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d1b25663-47a0-45db-ae96-f77ca8a79e9e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','47d67ef5-8611-4fbc-a56e-3af2a465aba1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','47d67ef5-8611-4fbc-a56e-3af2a465aba1')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','47d67ef5-8611-4fbc-a56e-3af2a465aba1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','383d737a-36e5-47d1-ab62-f0129493b7f7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','383d737a-36e5-47d1-ab62-f0129493b7f7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','432ed19c-6a94-4df7-ba79-dcb8e69197af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','432ed19c-6a94-4df7-ba79-dcb8e69197af')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','432ed19c-6a94-4df7-ba79-dcb8e69197af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','23bcdeb0-e297-4ca8-905e-b0361178ada4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','23bcdeb0-e297-4ca8-905e-b0361178ada4')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','23bcdeb0-e297-4ca8-905e-b0361178ada4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c25f65c6-e14c-4fee-8352-90cad1ee2c90')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c25f65c6-e14c-4fee-8352-90cad1ee2c90')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','c25f65c6-e14c-4fee-8352-90cad1ee2c90')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31f261b4-5d9d-48a4-9225-be43da0f6bb7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31f261b4-5d9d-48a4-9225-be43da0f6bb7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','31f261b4-5d9d-48a4-9225-be43da0f6bb7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f1b5cc6-29db-45cb-b18c-4bb87c157e1a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9f1b5cc6-29db-45cb-b18c-4bb87c157e1a')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','9f1b5cc6-29db-45cb-b18c-4bb87c157e1a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0da75bc4-6c7b-4195-8790-972b22bafa44')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0da75bc4-6c7b-4195-8790-972b22bafa44')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','0da75bc4-6c7b-4195-8790-972b22bafa44')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ba51750-9718-48b9-b816-34e95d10a510')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ba51750-9718-48b9-b816-34e95d10a510')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','0ba51750-9718-48b9-b816-34e95d10a510')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e577aeee-bf4d-4426-bd26-ca19ca5faec3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e577aeee-bf4d-4426-bd26-ca19ca5faec3')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','e577aeee-bf4d-4426-bd26-ca19ca5faec3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c26fb52-1977-45b6-84de-2cf978bc72d9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c26fb52-1977-45b6-84de-2cf978bc72d9')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6c26fb52-1977-45b6-84de-2cf978bc72d9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','55f53a34-9668-4789-8c9d-97940ab717f8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','55f53a34-9668-4789-8c9d-97940ab717f8')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','55f53a34-9668-4789-8c9d-97940ab717f8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6eeabecc-c3f2-4d4a-831c-cbac0651c2f7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6eeabecc-c3f2-4d4a-831c-cbac0651c2f7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6eeabecc-c3f2-4d4a-831c-cbac0651c2f7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','59880b94-ea44-4159-b557-ac1c3a2b5460')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','59880b94-ea44-4159-b557-ac1c3a2b5460')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8696cbc0-5f4e-4f9e-b11e-cab93f0ce197')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8696cbc0-5f4e-4f9e-b11e-cab93f0ce197')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','8696cbc0-5f4e-4f9e-b11e-cab93f0ce197')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16f2c7c0-b270-42d6-b930-2019185ed9a4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16f2c7c0-b270-42d6-b930-2019185ed9a4')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','16f2c7c0-b270-42d6-b930-2019185ed9a4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','4b0abec1-90e8-4118-b5f5-81893906aa15')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','4b0abec1-90e8-4118-b5f5-81893906aa15')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','4b0abec1-90e8-4118-b5f5-81893906aa15')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f7cee725-0aaa-486c-acad-09d3c6c05a5f')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','f7cee725-0aaa-486c-acad-09d3c6c05a5f')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','f7cee725-0aaa-486c-acad-09d3c6c05a5f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b4b1116a-e826-4f77-8098-cc156c03346a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b4b1116a-e826-4f77-8098-cc156c03346a')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','b4b1116a-e826-4f77-8098-cc156c03346a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b190de6e-5cbe-4c3e-a7e4-0463f53ee868')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b190de6e-5cbe-4c3e-a7e4-0463f53ee868')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','b190de6e-5cbe-4c3e-a7e4-0463f53ee868')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b4e434f3-1dfa-4195-90f1-4dc7abd2ec83')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','b4e434f3-1dfa-4195-90f1-4dc7abd2ec83')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','98bfe826-54ef-4f39-a591-1dc63c62bb67')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','98bfe826-54ef-4f39-a591-1dc63c62bb67')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6492f5cf-0dfd-44f3-8404-fcc3230d8375')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6492f5cf-0dfd-44f3-8404-fcc3230d8375')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','33889341-8a57-41ab-b965-31ecd347a65b')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','33889341-8a57-41ab-b965-31ecd347a65b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9971985a-d4bd-4975-9486-50731608c997')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9971985a-d4bd-4975-9486-50731608c997')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','9971985a-d4bd-4975-9486-50731608c997')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15c99179-8011-4e77-a6fa-8cdec786c1ba')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','15c99179-8011-4e77-a6fa-8cdec786c1ba')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','15c99179-8011-4e77-a6fa-8cdec786c1ba')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d787e99f-8767-4751-931d-a7315ead79be')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d787e99f-8767-4751-931d-a7315ead79be')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','399986ac-0a66-457a-bca9-8f69e00778e1')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','399986ac-0a66-457a-bca9-8f69e00778e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b80da6f-ad57-47d3-87e3-d7d3b8e8c1eb')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','7b80da6f-ad57-47d3-87e3-d7d3b8e8c1eb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','72c49c53-7ae0-4c8d-9a24-16871bb1a89e')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','72c49c53-7ae0-4c8d-9a24-16871bb1a89e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','40f5021c-c229-4cbe-9928-572735271694')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','40f5021c-c229-4cbe-9928-572735271694')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','40f5021c-c229-4cbe-9928-572735271694')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','068d4b13-6cf2-4cd0-af04-704744ff44e0')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','068d4b13-6cf2-4cd0-af04-704744ff44e0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d19677a6-3f36-4bf3-a7ad-cfaa2438d484')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d19677a6-3f36-4bf3-a7ad-cfaa2438d484')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d19677a6-3f36-4bf3-a7ad-cfaa2438d484')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5f00a83d-cc0a-49dc-998b-fe29f91e5536')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5f00a83d-cc0a-49dc-998b-fe29f91e5536')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','5f00a83d-cc0a-49dc-998b-fe29f91e5536')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c00ae8c6-7d95-445f-8710-5488a5e976fb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c00ae8c6-7d95-445f-8710-5488a5e976fb')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','c00ae8c6-7d95-445f-8710-5488a5e976fb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4d6f5096-a554-4832-936b-76c6f92e6e22')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4d6f5096-a554-4832-936b-76c6f92e6e22')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','4d6f5096-a554-4832-936b-76c6f92e6e22')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b4b5b910-e67e-4189-a5ee-af769b8681bb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b4b5b910-e67e-4189-a5ee-af769b8681bb')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','b4b5b910-e67e-4189-a5ee-af769b8681bb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c364064-5d2b-47d2-954f-f574cef85c64')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','1c364064-5d2b-47d2-954f-f574cef85c64')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4ee4e6db-2a9b-4a3f-8a32-e6b8473dc474')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4ee4e6db-2a9b-4a3f-8a32-e6b8473dc474')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','4ee4e6db-2a9b-4a3f-8a32-e6b8473dc474')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d15b34ab-90b3-4dbc-9a4a-82ef04e9a450')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d15b34ab-90b3-4dbc-9a4a-82ef04e9a450')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d15b34ab-90b3-4dbc-9a4a-82ef04e9a450')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8a8a9b38-8bc6-4647-9a02-4cb21a8ccb72')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8a8a9b38-8bc6-4647-9a02-4cb21a8ccb72')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','8a8a9b38-8bc6-4647-9a02-4cb21a8ccb72')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','34908a76-ec71-4b98-9526-9ca1a300da5b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','34908a76-ec71-4b98-9526-9ca1a300da5b')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','34908a76-ec71-4b98-9526-9ca1a300da5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4b39f96b-9f58-451d-9a5f-5c9171348473')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4b39f96b-9f58-451d-9a5f-5c9171348473')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','4b39f96b-9f58-451d-9a5f-5c9171348473')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5ab6e26-5863-4d44-9fe7-a9e4c932d3f1')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','c5ab6e26-5863-4d44-9fe7-a9e4c932d3f1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e8f2c09b-a99b-4cac-9100-8b0b60fdabf0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e8f2c09b-a99b-4cac-9100-8b0b60fdabf0')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','e8f2c09b-a99b-4cac-9100-8b0b60fdabf0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d5fc7aea-d488-402c-a612-dff919a0dd36')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d5fc7aea-d488-402c-a612-dff919a0dd36')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','d5fc7aea-d488-402c-a612-dff919a0dd36')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c281655b-e283-431a-bf77-857e7aaf7b7a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c281655b-e283-431a-bf77-857e7aaf7b7a')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','c281655b-e283-431a-bf77-857e7aaf7b7a')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a33ef62a-f394-4f67-a55e-ee8508df19f3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a33ef62a-f394-4f67-a55e-ee8508df19f3')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','05b499b2-f7c3-464a-8910-be6f70227bbc')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','05b499b2-f7c3-464a-8910-be6f70227bbc')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','05b499b2-f7c3-464a-8910-be6f70227bbc')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','526abcc0-bd14-47ea-854c-caa32a3c16f7')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','526abcc0-bd14-47ea-854c-caa32a3c16f7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','526abcc0-bd14-47ea-854c-caa32a3c16f7')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','a8d784da-aeb0-40d0-b2d0-027d3816e920')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a8d784da-aeb0-40d0-b2d0-027d3816e920')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','8f9f801c-7680-46f6-82dc-093e7fc1e35a')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','8f9f801c-7680-46f6-82dc-093e7fc1e35a')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','316fba3e-8bfe-4ac4-8830-6d2274311ada')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','316fba3e-8bfe-4ac4-8830-6d2274311ada')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','316fba3e-8bfe-4ac4-8830-6d2274311ada')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','984bdad6-fcff-471f-8c0a-fec936846147')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','984bdad6-fcff-471f-8c0a-fec936846147')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','984bdad6-fcff-471f-8c0a-fec936846147')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','212d8f0c-3c0a-467c-b005-3af424137012')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','212d8f0c-3c0a-467c-b005-3af424137012')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b18e2c57-64f6-4821-b129-53b2a5d85d39')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b18e2c57-64f6-4821-b129-53b2a5d85d39')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b18e2c57-64f6-4821-b129-53b2a5d85d39')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','32da1947-8888-4e6f-b434-7a68b589d0de')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a26228b2-5970-4576-a577-6dc2619fbdc4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a26228b2-5970-4576-a577-6dc2619fbdc4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a26228b2-5970-4576-a577-6dc2619fbdc4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e494dda0-d1b7-4065-9089-5ee1d0a7d023')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e494dda0-d1b7-4065-9089-5ee1d0a7d023')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e494dda0-d1b7-4065-9089-5ee1d0a7d023')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6b34f373-4cd8-49d2-a504-6a155ec22d57')
,('e311aa83-ccf4-48c8-a436-b43b7f61ef81','6b34f373-4cd8-49d2-a504-6a155ec22d57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6b34f373-4cd8-49d2-a504-6a155ec22d57')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','29586396-0525-4b2c-8be2-b444fac4f2d8')
,('e311aa83-ccf4-48c8-a436-b43b7f61ef81','29586396-0525-4b2c-8be2-b444fac4f2d8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','29586396-0525-4b2c-8be2-b444fac4f2d8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ae0e1d27-44e6-41b6-adfc-c70c8a54a326')
,('e311aa83-ccf4-48c8-a436-b43b7f61ef81','ae0e1d27-44e6-41b6-adfc-c70c8a54a326')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ae0e1d27-44e6-41b6-adfc-c70c8a54a326')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df402391-1762-48cc-aeda-90245426b792')
,('e311aa83-ccf4-48c8-a436-b43b7f61ef81','df402391-1762-48cc-aeda-90245426b792')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df402391-1762-48cc-aeda-90245426b792')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','be26aef4-f42c-4ed5-a57f-00071808a4a6')
,('e311aa83-ccf4-48c8-a436-b43b7f61ef81','be26aef4-f42c-4ed5-a57f-00071808a4a6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','be26aef4-f42c-4ed5-a57f-00071808a4a6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','cbf8e65e-30ed-4ccb-855d-2d1c983ec24f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cbf8e65e-30ed-4ccb-855d-2d1c983ec24f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cbf8e65e-30ed-4ccb-855d-2d1c983ec24f')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','cbf8e65e-30ed-4ccb-855d-2d1c983ec24f')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','7b286643-d150-413b-8ea9-e8a9ed6e51c6')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','7b286643-d150-413b-8ea9-e8a9ed6e51c6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','18cef877-90e3-4ed9-9b99-584a7d8685e0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','18cef877-90e3-4ed9-9b99-584a7d8685e0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','18cef877-90e3-4ed9-9b99-584a7d8685e0')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','18cef877-90e3-4ed9-9b99-584a7d8685e0')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','eb41499f-ab1a-47f4-b14f-9f6637e840d6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eb41499f-ab1a-47f4-b14f-9f6637e840d6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eb41499f-ab1a-47f4-b14f-9f6637e840d6')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','eb41499f-ab1a-47f4-b14f-9f6637e840d6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','69b9f100-c6aa-4e17-8f43-5d025e696cdf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69b9f100-c6aa-4e17-8f43-5d025e696cdf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69b9f100-c6aa-4e17-8f43-5d025e696cdf')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','69b9f100-c6aa-4e17-8f43-5d025e696cdf')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','63255ca9-fe29-48f5-95d4-c498a78e1243')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','63255ca9-fe29-48f5-95d4-c498a78e1243')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','63255ca9-fe29-48f5-95d4-c498a78e1243')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','63255ca9-fe29-48f5-95d4-c498a78e1243')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','615d2ca6-ed4f-4ddb-852e-bd0b0613d5d4')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','615d2ca6-ed4f-4ddb-852e-bd0b0613d5d4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','62039bbf-eba3-49ae-aee2-db276ac00216')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','62039bbf-eba3-49ae-aee2-db276ac00216')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','62039bbf-eba3-49ae-aee2-db276ac00216')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','62039bbf-eba3-49ae-aee2-db276ac00216')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','acc38a00-011e-4224-b755-28e75d8a70cd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','acc38a00-011e-4224-b755-28e75d8a70cd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','acc38a00-011e-4224-b755-28e75d8a70cd')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','acc38a00-011e-4224-b755-28e75d8a70cd')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','deb460cd-642a-4632-a224-e0bee1ae0e1e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','deb460cd-642a-4632-a224-e0bee1ae0e1e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','deb460cd-642a-4632-a224-e0bee1ae0e1e')
,('79fcc528-14cd-49f5-be1d-496f5c5374c4','deb460cd-642a-4632-a224-e0bee1ae0e1e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','d8c4eb64-869a-4ac1-8c49-2a7dd90dcc46')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d8c4eb64-869a-4ac1-8c49-2a7dd90dcc46')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d8c4eb64-869a-4ac1-8c49-2a7dd90dcc46')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','d8c4eb64-869a-4ac1-8c49-2a7dd90dcc46')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f1bcc08a-5e12-4f93-9d16-c6db15030e13')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f1bcc08a-5e12-4f93-9d16-c6db15030e13')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f1bcc08a-5e12-4f93-9d16-c6db15030e13')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','f1bcc08a-5e12-4f93-9d16-c6db15030e13')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a972a916-dbb3-4aed-9a68-eba91a0cb40c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a972a916-dbb3-4aed-9a68-eba91a0cb40c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a972a916-dbb3-4aed-9a68-eba91a0cb40c')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','a972a916-dbb3-4aed-9a68-eba91a0cb40c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b92b2385-c31c-4eec-a569-1f60cdb4370d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b92b2385-c31c-4eec-a569-1f60cdb4370d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b92b2385-c31c-4eec-a569-1f60cdb4370d')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','b92b2385-c31c-4eec-a569-1f60cdb4370d')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','edbceb99-c956-4522-b44c-5052313876db')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','edbceb99-c956-4522-b44c-5052313876db')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','edbceb99-c956-4522-b44c-5052313876db')
,('c05aee12-fd6f-4169-b89e-3f5c233e22e9','edbceb99-c956-4522-b44c-5052313876db')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','53a20db7-f8b6-460c-ae00-934416886cee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','53a20db7-f8b6-460c-ae00-934416886cee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','53a20db7-f8b6-460c-ae00-934416886cee')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c5098f56-3191-4bd4-962d-0d4529d7b146')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5098f56-3191-4bd4-962d-0d4529d7b146')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','318f603f-a0f9-4a38-ab68-ad8131a8e86e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','318f603f-a0f9-4a38-ab68-ad8131a8e86e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','952ddd1c-6497-4084-82f7-66b9358429da')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','952ddd1c-6497-4084-82f7-66b9358429da')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','951a8754-3e97-442a-baff-fce605e8bb20')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','951a8754-3e97-442a-baff-fce605e8bb20')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','4118344b-7fa6-4220-b075-6a68c61af0fb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4118344b-7fa6-4220-b075-6a68c61af0fb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4118344b-7fa6-4220-b075-6a68c61af0fb')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','4118344b-7fa6-4220-b075-6a68c61af0fb')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','6c1de8d4-bc83-4c68-a8b7-7166d574462b')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','6c1de8d4-bc83-4c68-a8b7-7166d574462b')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','64f7e36a-8e01-46ff-a937-ef3914ebc3b3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','64f7e36a-8e01-46ff-a937-ef3914ebc3b3')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','64f7e36a-8e01-46ff-a937-ef3914ebc3b3')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','02d9daeb-317a-4804-a84f-c760d3ab42c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','02d9daeb-317a-4804-a84f-c760d3ab42c4')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','02d9daeb-317a-4804-a84f-c760d3ab42c4')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','9d8aee51-7d81-47a1-9699-f26a0ca12e75')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9d8aee51-7d81-47a1-9699-f26a0ca12e75')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9d8aee51-7d81-47a1-9699-f26a0ca12e75')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','9d8aee51-7d81-47a1-9699-f26a0ca12e75')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dbc5fe37-a3df-4110-8d40-4aa60eb950ba')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dbc5fe37-a3df-4110-8d40-4aa60eb950ba')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aa1a27ac-175a-4c3a-a731-9586edf2b39d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa1a27ac-175a-4c3a-a731-9586edf2b39d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1d538b20-b902-4ff5-9046-486dc1f931be')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1d538b20-b902-4ff5-9046-486dc1f931be')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b50abdab-e8b1-43a9-aa45-3eece2d8895e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b50abdab-e8b1-43a9-aa45-3eece2d8895e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c3743ac-811b-4ebd-8e29-ef508a6b38a3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4c3743ac-811b-4ebd-8e29-ef508a6b38a3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3540f6f5-86a4-4a0b-80dc-9564ff986755')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3540f6f5-86a4-4a0b-80dc-9564ff986755')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','acc4d229-cf63-4ae4-b9c7-4e2922099f61')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','acc4d229-cf63-4ae4-b9c7-4e2922099f61')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a061c64b-b8f3-4d0c-8c83-a85b8dc78540')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a061c64b-b8f3-4d0c-8c83-a85b8dc78540')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fc6d0548-9260-4b48-947e-2848628c87c8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fc6d0548-9260-4b48-947e-2848628c87c8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','201fe420-40dd-4bd5-8c53-c9d9592c8ae4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','201fe420-40dd-4bd5-8c53-c9d9592c8ae4')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','a20b8b8b-a483-4a58-9438-b435d2765587')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','88a9b695-0674-4b7d-8d6e-79380e5bb0f2')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','f5d1eceb-369c-4336-814d-f0d311244c5b')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','9211c10c-111c-4b41-a6e0-2e73bab64abd')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','58a0d3d7-a5e8-4b7b-9c2b-b83e82b126ba')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','827c8b7f-462c-4853-ac9f-5db3b6c96f0a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','012f9c48-371e-46eb-a847-f6cfe78b5070')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','012f9c48-371e-46eb-a847-f6cfe78b5070')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4fbe3058-82f0-40ed-aca4-8cf0a9ed0881')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4fbe3058-82f0-40ed-aca4-8cf0a9ed0881')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','44650803-2d27-439c-a935-a15f77f3a32b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','44650803-2d27-439c-a935-a15f77f3a32b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b841dc96-ea53-4738-a157-ceecd19c8c39')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b841dc96-ea53-4738-a157-ceecd19c8c39')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','835c6687-55a5-4267-8413-e5d4dd679d88')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','835c6687-55a5-4267-8413-e5d4dd679d88')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ba94156c-1a3d-4d1a-96c3-34107da9ea73')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ba94156c-1a3d-4d1a-96c3-34107da9ea73')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ba94156c-1a3d-4d1a-96c3-34107da9ea73')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','88d49731-7ea7-4d52-8ef3-fabb2411e44e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','88d49731-7ea7-4d52-8ef3-fabb2411e44e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','88d49731-7ea7-4d52-8ef3-fabb2411e44e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','0facf145-6333-46e2-b18d-258b5fd95f41')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','0facf145-6333-46e2-b18d-258b5fd95f41')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0facf145-6333-46e2-b18d-258b5fd95f41')
,('e3ea9640-04f4-412f-aaa2-1013bcc905e6','0facf145-6333-46e2-b18d-258b5fd95f41')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1f11882d-ae8b-4f62-a598-ace5a46d8e16')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','85fa34cf-1e11-42ac-8316-5086c6b6e8b0')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','9d6ef26a-9867-4c86-bc5a-95e4e4b6eaae')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','80af8ad1-e3af-4451-af8b-c922274e22de')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','c1e7a7be-2e52-45c0-88e7-728d78fc9fdc')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','b0673a21-eed8-4e64-a6f6-5e4ded396a9d')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','4562cf5f-e2b5-4174-b088-9e8545bea857')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4562cf5f-e2b5-4174-b088-9e8545bea857')
,('10cedc5f-717a-4800-b837-d250cce7c101','4562cf5f-e2b5-4174-b088-9e8545bea857')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4562cf5f-e2b5-4174-b088-9e8545bea857')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','df7d0016-e2a2-43a8-9b36-4dfa70950093')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','54e9c741-8402-4a83-aa9d-844067c15cf0')
,('10cedc5f-717a-4800-b837-d250cce7c101','54e9c741-8402-4a83-aa9d-844067c15cf0')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','a43dabc3-20b1-4f08-9d39-1318481c50d6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a43dabc3-20b1-4f08-9d39-1318481c50d6')
,('10cedc5f-717a-4800-b837-d250cce7c101','a43dabc3-20b1-4f08-9d39-1318481c50d6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a43dabc3-20b1-4f08-9d39-1318481c50d6')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','1c9556da-c1af-4208-bd50-4292dfaa1948')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c9556da-c1af-4208-bd50-4292dfaa1948')
,('10cedc5f-717a-4800-b837-d250cce7c101','1c9556da-c1af-4208-bd50-4292dfaa1948')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1c9556da-c1af-4208-bd50-4292dfaa1948')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','d595b8a0-5b99-414b-afd0-d9dd54a0a3db')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d595b8a0-5b99-414b-afd0-d9dd54a0a3db')
,('10cedc5f-717a-4800-b837-d250cce7c101','d595b8a0-5b99-414b-afd0-d9dd54a0a3db')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d595b8a0-5b99-414b-afd0-d9dd54a0a3db')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','b851ae87-bb6a-40d2-8a75-c3fc62574c56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b851ae87-bb6a-40d2-8a75-c3fc62574c56')
,('10cedc5f-717a-4800-b837-d250cce7c101','b851ae87-bb6a-40d2-8a75-c3fc62574c56')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b851ae87-bb6a-40d2-8a75-c3fc62574c56')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','4d720e81-77f3-4dea-990f-a6ffde98a39f')
,('10cedc5f-717a-4800-b837-d250cce7c101','4d720e81-77f3-4dea-990f-a6ffde98a39f')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','b809c933-2b3a-4686-8e58-1a4361767722')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b809c933-2b3a-4686-8e58-1a4361767722')
,('10cedc5f-717a-4800-b837-d250cce7c101','b809c933-2b3a-4686-8e58-1a4361767722')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b809c933-2b3a-4686-8e58-1a4361767722')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','a03460c2-afc6-4355-9606-7d74b2f9793e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a03460c2-afc6-4355-9606-7d74b2f9793e')
,('10cedc5f-717a-4800-b837-d250cce7c101','a03460c2-afc6-4355-9606-7d74b2f9793e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a03460c2-afc6-4355-9606-7d74b2f9793e')
,('e6be2370-6497-41bf-9f99-de8aead8f30f','5fd6ff2e-0fc3-4ebb-a1c2-c2c8118746a6')
,('9a72a020-72dd-4415-ae04-451f61db3142','5fd6ff2e-0fc3-4ebb-a1c2-c2c8118746a6')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','5fd6ff2e-0fc3-4ebb-a1c2-c2c8118746a6')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','16c83da0-fe08-48a6-bbbf-88da78e8a8da')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16c83da0-fe08-48a6-bbbf-88da78e8a8da')
,('10cedc5f-717a-4800-b837-d250cce7c101','16c83da0-fe08-48a6-bbbf-88da78e8a8da')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16c83da0-fe08-48a6-bbbf-88da78e8a8da')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f8f96e1d-f137-42d2-b716-c13db0546ef2')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','f8f96e1d-f137-42d2-b716-c13db0546ef2')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','f8f96e1d-f137-42d2-b716-c13db0546ef2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f8f96e1d-f137-42d2-b716-c13db0546ef2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bcf9ff83-3c92-4b60-9ff8-75b3bfa5ab90')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','bcf9ff83-3c92-4b60-9ff8-75b3bfa5ab90')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','bcf9ff83-3c92-4b60-9ff8-75b3bfa5ab90')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bcf9ff83-3c92-4b60-9ff8-75b3bfa5ab90')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7193bd6e-5360-44a8-8493-6f3454467b46')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','7193bd6e-5360-44a8-8493-6f3454467b46')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','7193bd6e-5360-44a8-8493-6f3454467b46')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7193bd6e-5360-44a8-8493-6f3454467b46')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','38aa7627-73e1-4dfb-aaf0-071e394c9bc8')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','38aa7627-73e1-4dfb-aaf0-071e394c9bc8')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','38aa7627-73e1-4dfb-aaf0-071e394c9bc8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','38aa7627-73e1-4dfb-aaf0-071e394c9bc8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','953bffcb-f674-4e76-befd-9dc0d3024ca9')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','953bffcb-f674-4e76-befd-9dc0d3024ca9')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','953bffcb-f674-4e76-befd-9dc0d3024ca9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','953bffcb-f674-4e76-befd-9dc0d3024ca9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','caf6720d-a85b-4bab-b215-0965575b93ec')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','caf6720d-a85b-4bab-b215-0965575b93ec')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','caf6720d-a85b-4bab-b215-0965575b93ec')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','caf6720d-a85b-4bab-b215-0965575b93ec')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f48c972c-29f9-47e7-9950-dd3bac82b0e4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f48c972c-29f9-47e7-9950-dd3bac82b0e4')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','f48c972c-29f9-47e7-9950-dd3bac82b0e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f48c972c-29f9-47e7-9950-dd3bac82b0e4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','31fedcec-35a2-4898-ad6b-e67ee5383096')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31fedcec-35a2-4898-ad6b-e67ee5383096')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','31fedcec-35a2-4898-ad6b-e67ee5383096')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31fedcec-35a2-4898-ad6b-e67ee5383096')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c7fb7b34-b572-489b-b7ce-1942ca084ddd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c7fb7b34-b572-489b-b7ce-1942ca084ddd')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','c7fb7b34-b572-489b-b7ce-1942ca084ddd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c7fb7b34-b572-489b-b7ce-1942ca084ddd')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','67239727-486f-40bc-a569-3434d9b05596')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','67239727-486f-40bc-a569-3434d9b05596')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','67239727-486f-40bc-a569-3434d9b05596')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','67239727-486f-40bc-a569-3434d9b05596')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','402f3357-bab3-40a3-a5ae-9ffb80d964d7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','402f3357-bab3-40a3-a5ae-9ffb80d964d7')
,('4b055876-e210-4e43-aea3-9167e5afb724','402f3357-bab3-40a3-a5ae-9ffb80d964d7')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a4105f56-02b1-4aa9-a7a1-d7334b8aa72d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4105f56-02b1-4aa9-a7a1-d7334b8aa72d')
,('4b055876-e210-4e43-aea3-9167e5afb724','a4105f56-02b1-4aa9-a7a1-d7334b8aa72d')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','ebfa2fd5-5880-4123-964e-5f11fad4f107')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','ebfa2fd5-5880-4123-964e-5f11fad4f107')
,('4b055876-e210-4e43-aea3-9167e5afb724','ebfa2fd5-5880-4123-964e-5f11fad4f107')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','506b1bf3-34db-4dd2-bf7f-30dd5ab7062f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','506b1bf3-34db-4dd2-bf7f-30dd5ab7062f')
,('4b055876-e210-4e43-aea3-9167e5afb724','506b1bf3-34db-4dd2-bf7f-30dd5ab7062f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','506b1bf3-34db-4dd2-bf7f-30dd5ab7062f')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','8e69cfee-463c-412b-a7af-0b15e4362917')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8e69cfee-463c-412b-a7af-0b15e4362917')
,('4b055876-e210-4e43-aea3-9167e5afb724','8e69cfee-463c-412b-a7af-0b15e4362917')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8e69cfee-463c-412b-a7af-0b15e4362917')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','82aae5a7-771e-49c6-9c8c-1fe06a6dc41f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82aae5a7-771e-49c6-9c8c-1fe06a6dc41f')
,('4b055876-e210-4e43-aea3-9167e5afb724','82aae5a7-771e-49c6-9c8c-1fe06a6dc41f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82aae5a7-771e-49c6-9c8c-1fe06a6dc41f')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','710f9962-79cb-41fd-9e61-09657b137786')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','710f9962-79cb-41fd-9e61-09657b137786')
,('4b055876-e210-4e43-aea3-9167e5afb724','710f9962-79cb-41fd-9e61-09657b137786')
,('3f29763e-aa51-4e87-8667-86c39fed8251','710f9962-79cb-41fd-9e61-09657b137786')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','710f9962-79cb-41fd-9e61-09657b137786')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','464de1f9-edb4-4c2b-9cbd-501fc599ec42')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','464de1f9-edb4-4c2b-9cbd-501fc599ec42')
,('4b055876-e210-4e43-aea3-9167e5afb724','464de1f9-edb4-4c2b-9cbd-501fc599ec42')
,('3f29763e-aa51-4e87-8667-86c39fed8251','464de1f9-edb4-4c2b-9cbd-501fc599ec42')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','464de1f9-edb4-4c2b-9cbd-501fc599ec42')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','b75ae314-d602-42e1-b1bc-0a0f8e93e39b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b75ae314-d602-42e1-b1bc-0a0f8e93e39b')
,('4b055876-e210-4e43-aea3-9167e5afb724','b75ae314-d602-42e1-b1bc-0a0f8e93e39b')
,('3f29763e-aa51-4e87-8667-86c39fed8251','b75ae314-d602-42e1-b1bc-0a0f8e93e39b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b75ae314-d602-42e1-b1bc-0a0f8e93e39b')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','94099871-47be-446f-8566-895beb065f64')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','94099871-47be-446f-8566-895beb065f64')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','94099871-47be-446f-8566-895beb065f64')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','9bc6ffff-c493-42e5-a94c-6d45f2c9679b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9bc6ffff-c493-42e5-a94c-6d45f2c9679b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9bc6ffff-c493-42e5-a94c-6d45f2c9679b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ea7968ed-c2aa-4955-94e9-84206d665aaf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea7968ed-c2aa-4955-94e9-84206d665aaf')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','ea7968ed-c2aa-4955-94e9-84206d665aaf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ea7968ed-c2aa-4955-94e9-84206d665aaf')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','f7b2f281-c9c5-4232-895c-e25414b9d7b1')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','f7b2f281-c9c5-4232-895c-e25414b9d7b1')
,('4b055876-e210-4e43-aea3-9167e5afb724','f7b2f281-c9c5-4232-895c-e25414b9d7b1')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','0408ea81-34f1-43fd-bf07-f5c2701209b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0408ea81-34f1-43fd-bf07-f5c2701209b4')
,('4b055876-e210-4e43-aea3-9167e5afb724','0408ea81-34f1-43fd-bf07-f5c2701209b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0408ea81-34f1-43fd-bf07-f5c2701209b4')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','e4bfbf2e-4492-4b4b-946f-fe277d0e5811')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4bfbf2e-4492-4b4b-946f-fe277d0e5811')
,('4b055876-e210-4e43-aea3-9167e5afb724','e4bfbf2e-4492-4b4b-946f-fe277d0e5811')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e4bfbf2e-4492-4b4b-946f-fe277d0e5811')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9c82718-cda1-49c5-84c5-fd28bc87c069')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9c82718-cda1-49c5-84c5-fd28bc87c069')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b360fad-632c-4e30-b599-df3826d411af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7b360fad-632c-4e30-b599-df3826d411af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bc860121-b797-4956-a0cd-4c363a3e3f37')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bc860121-b797-4956-a0cd-4c363a3e3f37')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b1dacf79-8cc9-45da-a803-b222c99c3282')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b1dacf79-8cc9-45da-a803-b222c99c3282')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bcfff0d2-3ca9-4968-b349-313d4e7fd799')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bcfff0d2-3ca9-4968-b349-313d4e7fd799')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7bea41af-3a79-4e0a-a66e-c71a81b0da28')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','7bea41af-3a79-4e0a-a66e-c71a81b0da28')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','7bea41af-3a79-4e0a-a66e-c71a81b0da28')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7bea41af-3a79-4e0a-a66e-c71a81b0da28')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dc77d718-615a-4d14-b97f-81f7227872af')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','dc77d718-615a-4d14-b97f-81f7227872af')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','dc77d718-615a-4d14-b97f-81f7227872af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dc77d718-615a-4d14-b97f-81f7227872af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9bb63f70-d978-45ce-9650-4964897fbe04')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','9bb63f70-d978-45ce-9650-4964897fbe04')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','9bb63f70-d978-45ce-9650-4964897fbe04')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9bb63f70-d978-45ce-9650-4964897fbe04')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d367cda6-cb13-4f75-af60-c57730e76c25')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','d367cda6-cb13-4f75-af60-c57730e76c25')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','d367cda6-cb13-4f75-af60-c57730e76c25')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d367cda6-cb13-4f75-af60-c57730e76c25')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','24f76020-4e68-4244-8a72-99cfe66da21d')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','24f76020-4e68-4244-8a72-99cfe66da21d')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','24f76020-4e68-4244-8a72-99cfe66da21d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','24f76020-4e68-4244-8a72-99cfe66da21d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36b022a6-77e0-4851-bea9-f777535d7077')
,('fde257b6-7136-4cc2-b4af-bfde06b540eb','36b022a6-77e0-4851-bea9-f777535d7077')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','36b022a6-77e0-4851-bea9-f777535d7077')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36b022a6-77e0-4851-bea9-f777535d7077')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b11614c-bb5f-4677-a749-34ff2aa1c596')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b11614c-bb5f-4677-a749-34ff2aa1c596')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','84ef0a1a-35c7-4975-99b6-99cf072df070')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','84ef0a1a-35c7-4975-99b6-99cf072df070')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','84ef0a1a-35c7-4975-99b6-99cf072df070')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','62b9f909-3691-4ac2-9a5c-685877937d4a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea8cc16e-9395-4ef3-a14d-33ba32962499')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','ea8cc16e-9395-4ef3-a14d-33ba32962499')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ea8cc16e-9395-4ef3-a14d-33ba32962499')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','974509e2-24a4-4807-9776-439805fc89cf')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','974509e2-24a4-4807-9776-439805fc89cf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','974509e2-24a4-4807-9776-439805fc89cf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','668da4dd-12ca-4bb3-ac5d-bc0d2ae58b98')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','668da4dd-12ca-4bb3-ac5d-bc0d2ae58b98')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','668da4dd-12ca-4bb3-ac5d-bc0d2ae58b98')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e55f315-5772-42e8-ac67-2ae08925081c')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','1e55f315-5772-42e8-ac67-2ae08925081c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e55f315-5772-42e8-ac67-2ae08925081c')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','4c305715-6294-4645-b9c6-3653fa0020d1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ce465d1-421a-4abe-a770-e2787852cf17')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','2ce465d1-421a-4abe-a770-e2787852cf17')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ce465d1-421a-4abe-a770-e2787852cf17')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','911aa5d5-adae-4ef4-9eab-d5fb5d52489e')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','911aa5d5-adae-4ef4-9eab-d5fb5d52489e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','911aa5d5-adae-4ef4-9eab-d5fb5d52489e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','56ec7fde-4494-4b9f-a327-b565a55b6b12')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','56ec7fde-4494-4b9f-a327-b565a55b6b12')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','56ec7fde-4494-4b9f-a327-b565a55b6b12')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','56ec7fde-4494-4b9f-a327-b565a55b6b12')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','255bb712-ac52-4e6d-9fbd-b714e5007223')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','255bb712-ac52-4e6d-9fbd-b714e5007223')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','255bb712-ac52-4e6d-9fbd-b714e5007223')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','255bb712-ac52-4e6d-9fbd-b714e5007223')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','766a6be0-48e4-4835-a7f4-5fde84293f8e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','766a6be0-48e4-4835-a7f4-5fde84293f8e')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','766a6be0-48e4-4835-a7f4-5fde84293f8e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','766a6be0-48e4-4835-a7f4-5fde84293f8e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','3618d7b1-99a3-46d9-8e6a-b7de917df18c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3618d7b1-99a3-46d9-8e6a-b7de917df18c')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','3618d7b1-99a3-46d9-8e6a-b7de917df18c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3618d7b1-99a3-46d9-8e6a-b7de917df18c')
,('c7e230da-3c22-4915-9ad9-968f874536a5','a20640bf-2dce-49b1-8925-eb0e6754f381')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a20640bf-2dce-49b1-8925-eb0e6754f381')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a20640bf-2dce-49b1-8925-eb0e6754f381')
,('c7e230da-3c22-4915-9ad9-968f874536a5','9af80401-f3b2-4cb5-ba01-7b2e7dd3caa6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9af80401-f3b2-4cb5-ba01-7b2e7dd3caa6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9af80401-f3b2-4cb5-ba01-7b2e7dd3caa6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','326c2eea-b5b3-4eb2-8ae6-f81428836736')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','326c2eea-b5b3-4eb2-8ae6-f81428836736')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','326c2eea-b5b3-4eb2-8ae6-f81428836736')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','326c2eea-b5b3-4eb2-8ae6-f81428836736')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','71b2cf35-46f8-4334-a429-75735caa7b23')
,('60fde6ac-3155-44ab-9636-7d4886fd8857','71b2cf35-46f8-4334-a429-75735caa7b23')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','71b2cf35-46f8-4334-a429-75735caa7b23')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30346380-1921-4d06-8055-95b5e01c3f95')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','30346380-1921-4d06-8055-95b5e01c3f95')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bc50c463-e0f3-49f3-92b6-cb162dbe815b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bc50c463-e0f3-49f3-92b6-cb162dbe815b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c64ecd0e-06a9-48d8-8e58-8dee17e25502')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c64ecd0e-06a9-48d8-8e58-8dee17e25502')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','c64ecd0e-06a9-48d8-8e58-8dee17e25502')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c64ecd0e-06a9-48d8-8e58-8dee17e25502')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb2f7195-f868-4f04-85a9-43793e0c0520')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cb2f7195-f868-4f04-85a9-43793e0c0520')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0c4520b1-7039-4255-8da8-994b3517a19f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0c4520b1-7039-4255-8da8-994b3517a19f')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','70596009-1b0d-42b9-9c63-148d8ccc890b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','70596009-1b0d-42b9-9c63-148d8ccc890b')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','70596009-1b0d-42b9-9c63-148d8ccc890b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','70596009-1b0d-42b9-9c63-148d8ccc890b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c709d41b-b7c7-4e54-8985-7f0d51370261')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c709d41b-b7c7-4e54-8985-7f0d51370261')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','923df6dc-8d20-4e51-9a69-b93814d4d1fe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','923df6dc-8d20-4e51-9a69-b93814d4d1fe')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a5339bba-f781-4056-856a-7795ed418324')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5339bba-f781-4056-856a-7795ed418324')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','a5339bba-f781-4056-856a-7795ed418324')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a5339bba-f781-4056-856a-7795ed418324')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','64922167-64f1-4214-890e-cd85ac82283b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','64922167-64f1-4214-890e-cd85ac82283b')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','64922167-64f1-4214-890e-cd85ac82283b')
,('223f4787-af72-40d1-986e-51d048898c9d','f61897c7-f14e-49e6-9263-034850aae324')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f61897c7-f14e-49e6-9263-034850aae324')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','f61897c7-f14e-49e6-9263-034850aae324')
,('ab4fa3f4-0b8a-4e1d-a2db-06fdc4d3492f','f61897c7-f14e-49e6-9263-034850aae324')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','17027cb2-0bc5-4313-8e49-62b54b1260cb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','17027cb2-0bc5-4313-8e49-62b54b1260cb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ef1a298-bdeb-4e5a-a700-73f2c7a262ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ef1a298-bdeb-4e5a-a700-73f2c7a262ca')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','d90137a4-d8a1-40ac-b6cb-9a03c6088ef0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d90137a4-d8a1-40ac-b6cb-9a03c6088ef0')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','d90137a4-d8a1-40ac-b6cb-9a03c6088ef0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d90137a4-d8a1-40ac-b6cb-9a03c6088ef0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d8971efd-984b-4b23-9fa8-60ea6071471a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d8971efd-984b-4b23-9fa8-60ea6071471a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4fd43e75-816e-4095-aa16-e7b3e0bf15cd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4fd43e75-816e-4095-aa16-e7b3e0bf15cd')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9e592066-7a3f-4541-8906-a64868644993')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9e592066-7a3f-4541-8906-a64868644993')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','9e592066-7a3f-4541-8906-a64868644993')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9e592066-7a3f-4541-8906-a64868644993')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','27558182-709a-4c53-b1aa-bb1fac7161d8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','27558182-709a-4c53-b1aa-bb1fac7161d8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3439a8b-710a-49c1-b833-e78d140f5a07')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d3439a8b-710a-49c1-b833-e78d140f5a07')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','6521dc1e-1bcf-4e3b-b97c-2d6ef41b47dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6521dc1e-1bcf-4e3b-b97c-2d6ef41b47dc')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','6521dc1e-1bcf-4e3b-b97c-2d6ef41b47dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6521dc1e-1bcf-4e3b-b97c-2d6ef41b47dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','83fe7875-cd69-4e95-b728-01493c3500d6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','83fe7875-cd69-4e95-b728-01493c3500d6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','eda05e7a-a2eb-4ffc-ae6b-ee7ef81f07b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eda05e7a-a2eb-4ffc-ae6b-ee7ef81f07b4')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','eda05e7a-a2eb-4ffc-ae6b-ee7ef81f07b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eda05e7a-a2eb-4ffc-ae6b-ee7ef81f07b4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','fb08a77f-5925-4537-8a0c-a64964240fa1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fb08a77f-5925-4537-8a0c-a64964240fa1')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','fb08a77f-5925-4537-8a0c-a64964240fa1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fb08a77f-5925-4537-8a0c-a64964240fa1')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','48b19e76-e44f-471b-8b3c-2cd3ad56e4c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48b19e76-e44f-471b-8b3c-2cd3ad56e4c0')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','48b19e76-e44f-471b-8b3c-2cd3ad56e4c0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48b19e76-e44f-471b-8b3c-2cd3ad56e4c0')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','d762f6e1-e709-4d36-83b2-c96bb91ac892')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d762f6e1-e709-4d36-83b2-c96bb91ac892')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','d762f6e1-e709-4d36-83b2-c96bb91ac892')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d762f6e1-e709-4d36-83b2-c96bb91ac892')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b44712c-f10c-4159-9098-5e67bba738b3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7b44712c-f10c-4159-9098-5e67bba738b3')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','0581cc3b-c541-4a61-9ebc-b0018992a85e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0581cc3b-c541-4a61-9ebc-b0018992a85e')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','0581cc3b-c541-4a61-9ebc-b0018992a85e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0581cc3b-c541-4a61-9ebc-b0018992a85e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0828cbf3-ab47-4d15-97e9-4f5f6497d897')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0828cbf3-ab47-4d15-97e9-4f5f6497d897')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eb8f5cc5-2c4c-4cff-86ea-5c6aec1c56ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eb8f5cc5-2c4c-4cff-86ea-5c6aec1c56ea')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','758cd62c-870d-47a4-9f41-afc3120c64c3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','758cd62c-870d-47a4-9f41-afc3120c64c3')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','758cd62c-870d-47a4-9f41-afc3120c64c3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','758cd62c-870d-47a4-9f41-afc3120c64c3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','350ddfb6-be30-46ff-b00b-eb80c534d799')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','350ddfb6-be30-46ff-b00b-eb80c534d799')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3aecb69c-da8a-4953-8df3-b7d84ebf84cb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3aecb69c-da8a-4953-8df3-b7d84ebf84cb')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b07775c9-d9da-4e42-abdd-1a1deda8b36c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b07775c9-d9da-4e42-abdd-1a1deda8b36c')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','b07775c9-d9da-4e42-abdd-1a1deda8b36c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b07775c9-d9da-4e42-abdd-1a1deda8b36c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e1796c45-4f19-4262-b91e-625f446e95d0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e1796c45-4f19-4262-b91e-625f446e95d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cbbc26dc-fc9e-43f5-9ccf-6b6c49deb937')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cbbc26dc-fc9e-43f5-9ccf-6b6c49deb937')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9b873b55-9ccf-41ea-b196-edbe9bebe9b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9b873b55-9ccf-41ea-b196-edbe9bebe9b1')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','9b873b55-9ccf-41ea-b196-edbe9bebe9b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9b873b55-9ccf-41ea-b196-edbe9bebe9b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3301b4e8-198d-438f-996f-8a1e480dc919')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3301b4e8-198d-438f-996f-8a1e480dc919')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fd53204a-542b-40ef-b996-5948d6db46df')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fd53204a-542b-40ef-b996-5948d6db46df')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','3a4aa387-168c-4816-8f9e-cc17739dcc03')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3a4aa387-168c-4816-8f9e-cc17739dcc03')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','3a4aa387-168c-4816-8f9e-cc17739dcc03')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3a4aa387-168c-4816-8f9e-cc17739dcc03')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aeedbd51-ca12-436b-8de9-b4b38a282455')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aeedbd51-ca12-436b-8de9-b4b38a282455')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bb0a5e46-c254-49a4-9df9-5420128c9e32')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bb0a5e46-c254-49a4-9df9-5420128c9e32')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6df0833f-7a52-498f-92f9-a37213f23d09')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','d3f34f51-9a21-4afd-b25a-89b171bc18c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3f34f51-9a21-4afd-b25a-89b171bc18c7')
,('ba39189f-6f18-4a54-94bd-c9301ba54540','d3f34f51-9a21-4afd-b25a-89b171bc18c7')
,('4b055876-e210-4e43-aea3-9167e5afb724','3671949f-d155-40f9-a7f9-832b2d657abc')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','8407e715-c0c4-4736-b63f-ebf89799552c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','8407e715-c0c4-4736-b63f-ebf89799552c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8407e715-c0c4-4736-b63f-ebf89799552c')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','ab4af604-ca93-422b-bce6-064e68d5966a')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ab4af604-ca93-422b-bce6-064e68d5966a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab4af604-ca93-422b-bce6-064e68d5966a')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','e8b84cd0-38f0-43ea-961d-8115a6275f85')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e8b84cd0-38f0-43ea-961d-8115a6275f85')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e8b84cd0-38f0-43ea-961d-8115a6275f85')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','5b6afee6-e04c-41d3-aa9c-7be7252c2279')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','5b6afee6-e04c-41d3-aa9c-7be7252c2279')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5b6afee6-e04c-41d3-aa9c-7be7252c2279')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','6ce294d0-5f05-4b56-9c5f-5cab89894957')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','6ce294d0-5f05-4b56-9c5f-5cab89894957')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ce294d0-5f05-4b56-9c5f-5cab89894957')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a4dcddb0-5fb4-41a7-b0de-8e6e3d0e78b4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a4dcddb0-5fb4-41a7-b0de-8e6e3d0e78b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a4dcddb0-5fb4-41a7-b0de-8e6e3d0e78b4')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','77128e6c-d775-4153-91cf-55d6c836d6ca')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','77128e6c-d775-4153-91cf-55d6c836d6ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','77128e6c-d775-4153-91cf-55d6c836d6ca')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','b277f70f-de06-49b8-a5a8-d164e415255c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b277f70f-de06-49b8-a5a8-d164e415255c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b277f70f-de06-49b8-a5a8-d164e415255c')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','579c8fb7-1020-41da-af71-55022c307153')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','579c8fb7-1020-41da-af71-55022c307153')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','579c8fb7-1020-41da-af71-55022c307153')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a58b1943-853e-45a4-b509-910dd50ef338')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a58b1943-853e-45a4-b509-910dd50ef338')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a58b1943-853e-45a4-b509-910dd50ef338')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a03d5986-0ac5-434d-9d7a-aac67e2aa0f5')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a03d5986-0ac5-434d-9d7a-aac67e2aa0f5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a03d5986-0ac5-434d-9d7a-aac67e2aa0f5')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','e5187657-186c-4a21-973e-5017760fd28a')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e5187657-186c-4a21-973e-5017760fd28a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e5187657-186c-4a21-973e-5017760fd28a')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','ee4de5fe-f4f8-4515-8911-5d6ce3105bc0')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ee4de5fe-f4f8-4515-8911-5d6ce3105bc0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee4de5fe-f4f8-4515-8911-5d6ce3105bc0')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','b0983a46-1b49-4d39-b087-31d78bb974e4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b0983a46-1b49-4d39-b087-31d78bb974e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0983a46-1b49-4d39-b087-31d78bb974e4')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','5f022b0c-df94-4943-9508-bce17f3997c4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','5f022b0c-df94-4943-9508-bce17f3997c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5f022b0c-df94-4943-9508-bce17f3997c4')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','1c810df6-a713-4fbc-8628-40df12660274')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','1c810df6-a713-4fbc-8628-40df12660274')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1c810df6-a713-4fbc-8628-40df12660274')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','95ab1938-05ac-47e2-880a-88635ec35ab9')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','95ab1938-05ac-47e2-880a-88635ec35ab9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95ab1938-05ac-47e2-880a-88635ec35ab9')
,('c7e230da-3c22-4915-9ad9-968f874536a5','c7a2c62f-e40d-4f0a-9d7f-77541ba1e1a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c7a2c62f-e40d-4f0a-9d7f-77541ba1e1a9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c7a2c62f-e40d-4f0a-9d7f-77541ba1e1a9')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','49a7a528-9a6f-4802-a413-b32a20b0e2c7')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','49a7a528-9a6f-4802-a413-b32a20b0e2c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','49a7a528-9a6f-4802-a413-b32a20b0e2c7')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','7343f893-4b07-44c8-bc91-6736a76f3f1d')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','7343f893-4b07-44c8-bc91-6736a76f3f1d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7343f893-4b07-44c8-bc91-6736a76f3f1d')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','aa6284fa-f8f6-44ea-bea6-14687e4a76a3')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','aa6284fa-f8f6-44ea-bea6-14687e4a76a3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa6284fa-f8f6-44ea-bea6-14687e4a76a3')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','8563f1e1-b92d-4276-9a1c-a1c6da5288a2')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','8563f1e1-b92d-4276-9a1c-a1c6da5288a2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8563f1e1-b92d-4276-9a1c-a1c6da5288a2')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','bdf768d8-9377-424d-956b-086e42794911')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','bdf768d8-9377-424d-956b-086e42794911')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bdf768d8-9377-424d-956b-086e42794911')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','da800b38-b043-4f2c-a1a7-e82cbddf94c8')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','da800b38-b043-4f2c-a1a7-e82cbddf94c8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','da800b38-b043-4f2c-a1a7-e82cbddf94c8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','68fafb02-e822-447b-b589-f99c5e9ba21e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','68fafb02-e822-447b-b589-f99c5e9ba21e')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','82607922-bff1-452b-a5bf-b691359c4c97')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82607922-bff1-452b-a5bf-b691359c4c97')
,('4b055876-e210-4e43-aea3-9167e5afb724','82607922-bff1-452b-a5bf-b691359c4c97')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82607922-bff1-452b-a5bf-b691359c4c97')
,('c7e230da-3c22-4915-9ad9-968f874536a5','65d6b3d5-3219-4f62-9b68-133456c62e49')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65d6b3d5-3219-4f62-9b68-133456c62e49')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','65d6b3d5-3219-4f62-9b68-133456c62e49')
,('c7e230da-3c22-4915-9ad9-968f874536a5','7add20f6-3754-4e91-a93a-477dd675f36e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7add20f6-3754-4e91-a93a-477dd675f36e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7add20f6-3754-4e91-a93a-477dd675f36e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','48e6d5a7-a961-4cd4-8ad6-af5d38946d2d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48e6d5a7-a961-4cd4-8ad6-af5d38946d2d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48e6d5a7-a961-4cd4-8ad6-af5d38946d2d')
,('c7e230da-3c22-4915-9ad9-968f874536a5','3196ecf4-123b-4417-90d2-b20bac00f68e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3196ecf4-123b-4417-90d2-b20bac00f68e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3196ecf4-123b-4417-90d2-b20bac00f68e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','0b50fabc-6951-4887-8ffc-5433778a26a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0b50fabc-6951-4887-8ffc-5433778a26a9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0b50fabc-6951-4887-8ffc-5433778a26a9')
,('c7e230da-3c22-4915-9ad9-968f874536a5','9ddacbf5-035d-4dd8-ad0c-77aa87678e48')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9ddacbf5-035d-4dd8-ad0c-77aa87678e48')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9ddacbf5-035d-4dd8-ad0c-77aa87678e48')
,('c7e230da-3c22-4915-9ad9-968f874536a5','5ac0b71a-4b11-4215-ae47-ed0ac357b1e5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5ac0b71a-4b11-4215-ae47-ed0ac357b1e5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5ac0b71a-4b11-4215-ae47-ed0ac357b1e5')
,('c7e230da-3c22-4915-9ad9-968f874536a5','a7b3bbd2-6d6e-4683-bfc5-db7d421dc2c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7b3bbd2-6d6e-4683-bfc5-db7d421dc2c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7b3bbd2-6d6e-4683-bfc5-db7d421dc2c6')
,('c7e230da-3c22-4915-9ad9-968f874536a5','20004931-781f-4840-a032-ddab769e6242')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','20004931-781f-4840-a032-ddab769e6242')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','20004931-781f-4840-a032-ddab769e6242')
,('c7e230da-3c22-4915-9ad9-968f874536a5','3c5003c0-e692-460b-9644-a4981d297484')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3c5003c0-e692-460b-9644-a4981d297484')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3c5003c0-e692-460b-9644-a4981d297484')
,('c7e230da-3c22-4915-9ad9-968f874536a5','cb475864-a2c0-4fb1-83bc-5e7cce14b642')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb475864-a2c0-4fb1-83bc-5e7cce14b642')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cb475864-a2c0-4fb1-83bc-5e7cce14b642')
,('c7e230da-3c22-4915-9ad9-968f874536a5','aca5ca20-1627-4f44-b6b7-a3d3f260a3fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aca5ca20-1627-4f44-b6b7-a3d3f260a3fe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aca5ca20-1627-4f44-b6b7-a3d3f260a3fe')
,('c7e230da-3c22-4915-9ad9-968f874536a5','2613c368-3f95-4ef9-8d5d-eb5fba2b21ad')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2613c368-3f95-4ef9-8d5d-eb5fba2b21ad')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2613c368-3f95-4ef9-8d5d-eb5fba2b21ad')
,('c7e230da-3c22-4915-9ad9-968f874536a5','cbfc092a-98a6-4915-a10b-36594afba760')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cbfc092a-98a6-4915-a10b-36594afba760')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cbfc092a-98a6-4915-a10b-36594afba760')
,('c7e230da-3c22-4915-9ad9-968f874536a5','ec04db38-b02c-4acf-9d96-fa0568a7c357')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ec04db38-b02c-4acf-9d96-fa0568a7c357')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ec04db38-b02c-4acf-9d96-fa0568a7c357')
,('c7e230da-3c22-4915-9ad9-968f874536a5','42a5e3ed-2cb8-4c8d-a1ba-b423de8c5a72')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','42a5e3ed-2cb8-4c8d-a1ba-b423de8c5a72')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','42a5e3ed-2cb8-4c8d-a1ba-b423de8c5a72')
,('c7e230da-3c22-4915-9ad9-968f874536a5','1f2cfaae-3ec8-4689-8d38-07c73c5f137b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1f2cfaae-3ec8-4689-8d38-07c73c5f137b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1f2cfaae-3ec8-4689-8d38-07c73c5f137b')
,('c7e230da-3c22-4915-9ad9-968f874536a5','d7f6286d-9346-40f1-98d0-8c033e03b48a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d7f6286d-9346-40f1-98d0-8c033e03b48a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d7f6286d-9346-40f1-98d0-8c033e03b48a')
,('c7e230da-3c22-4915-9ad9-968f874536a5','16f5f698-8523-4fbc-9ab4-6fba4c7d6afd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16f5f698-8523-4fbc-9ab4-6fba4c7d6afd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16f5f698-8523-4fbc-9ab4-6fba4c7d6afd')
,('c7e230da-3c22-4915-9ad9-968f874536a5','68f357fe-bcf8-46d7-aee0-6d8eb718ecee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','68f357fe-bcf8-46d7-aee0-6d8eb718ecee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','68f357fe-bcf8-46d7-aee0-6d8eb718ecee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','876630d6-82f2-4273-a959-6a0f9f397326')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','876630d6-82f2-4273-a959-6a0f9f397326')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5ff028d-f0c7-453c-9f87-2edaabd8b6a9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c5ff028d-f0c7-453c-9f87-2edaabd8b6a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','76f620b2-ae42-4628-b2cb-5bb7aae82988')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','76f620b2-ae42-4628-b2cb-5bb7aae82988')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','68e274a3-26ce-4be2-91b8-9e2bd27490af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','68e274a3-26ce-4be2-91b8-9e2bd27490af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','09444d18-e47b-4450-88ed-8fed9142ce97')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','09444d18-e47b-4450-88ed-8fed9142ce97')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1a654d7a-26e6-490c-b694-32dbad5caa5b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1a654d7a-26e6-490c-b694-32dbad5caa5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','85ab7b97-569f-45fd-b75c-e4f8046155ef')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','85ab7b97-569f-45fd-b75c-e4f8046155ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d40d5db2-14f7-4405-b59d-534942d86458')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d40d5db2-14f7-4405-b59d-534942d86458')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9b6f4fee-8355-4aaa-9ff0-52af37a866b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9b6f4fee-8355-4aaa-9ff0-52af37a866b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','177f8783-1c93-43bd-a4e1-eeb93e910407')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','177f8783-1c93-43bd-a4e1-eeb93e910407')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31f0c105-9343-40fc-a61b-3c2adc00ec8d')
,('489b0e63-83f1-49ad-9f8a-12b2bfc23e27','31f0c105-9343-40fc-a61b-3c2adc00ec8d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','be37cbf7-2df7-4026-9a1b-91dcb9d2e403')
,('489b0e63-83f1-49ad-9f8a-12b2bfc23e27','be37cbf7-2df7-4026-9a1b-91dcb9d2e403')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5934d4f-235a-4270-935f-72a86d8ecebb')
,('489b0e63-83f1-49ad-9f8a-12b2bfc23e27','a5934d4f-235a-4270-935f-72a86d8ecebb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e8f4ca6-1c22-4a28-b9d7-74ff8305201b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e8f4ca6-1c22-4a28-b9d7-74ff8305201b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3343248e-1fd0-430e-a2b0-09da734cfef8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3343248e-1fd0-430e-a2b0-09da734cfef8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c6b979dc-5943-4f32-8cc5-46e0504fb241')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c6b979dc-5943-4f32-8cc5-46e0504fb241')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2530d754-1b73-4804-b75f-29b789883f20')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2530d754-1b73-4804-b75f-29b789883f20')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3ff158f6-c9fa-400a-bb20-b4434b013bf0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3ff158f6-c9fa-400a-bb20-b4434b013bf0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','34858fa0-07c1-45bc-a90b-c208ecafb7cd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','34858fa0-07c1-45bc-a90b-c208ecafb7cd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3cc81d7d-6862-470c-99e0-a59cb5ff5d77')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3cc81d7d-6862-470c-99e0-a59cb5ff5d77')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0c15d7b1-e61d-4e16-bdf6-b99013d67669')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0c15d7b1-e61d-4e16-bdf6-b99013d67669')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','db6c6ce4-5bdf-46e0-8bf1-84012e798cd8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','db6c6ce4-5bdf-46e0-8bf1-84012e798cd8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','43c599be-b0c3-48d5-b8d7-091643795c4e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','43c599be-b0c3-48d5-b8d7-091643795c4e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e93c1718-e401-4f1a-a0f6-1f372fb57c64')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e93c1718-e401-4f1a-a0f6-1f372fb57c64')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','edb29727-3853-4542-85ba-cb1f78f0b4d9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','edb29727-3853-4542-85ba-cb1f78f0b4d9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','73a6dc03-088e-4c9c-ac6f-4b32a04f697d')
,('489b0e63-83f1-49ad-9f8a-12b2bfc23e27','73a6dc03-088e-4c9c-ac6f-4b32a04f697d')
,('b9ad5d42-0f1b-4191-89ae-c64064a7c51c','c434359d-a518-4d4e-b329-571adb3c4465')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c434359d-a518-4d4e-b329-571adb3c4465')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','c434359d-a518-4d4e-b329-571adb3c4465')
,('8a3a2fd6-164b-43ba-ad8e-d3ae60cffc5a','c434359d-a518-4d4e-b329-571adb3c4465')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d04fdabc-9a86-4e43-842b-6674b818e77d')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cb95a1e4-3b2e-4a29-b115-c098ae5bbc4e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31d19a2b-3042-4f3b-9559-562f6a394e5e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','95f80026-82a2-4bad-b228-4c1ca3147024')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','95f80026-82a2-4bad-b228-4c1ca3147024')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','95f80026-82a2-4bad-b228-4c1ca3147024')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','95f80026-82a2-4bad-b228-4c1ca3147024')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','95f80026-82a2-4bad-b228-4c1ca3147024')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95f80026-82a2-4bad-b228-4c1ca3147024')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5940df78-25b8-4ead-8766-ad62462fb6c4')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1cf4ce7f-9f27-491e-8b62-5cda81ecd7e1')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','25ddc856-f2c0-42d8-9d64-ef3bb8d438e7')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9a8d2c10-dba6-4837-b619-a65054344bbe')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','86a87b01-05a5-4654-8530-4ad6030c742c')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','86a87b01-05a5-4654-8530-4ad6030c742c')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','86a87b01-05a5-4654-8530-4ad6030c742c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','86a87b01-05a5-4654-8530-4ad6030c742c')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','86a87b01-05a5-4654-8530-4ad6030c742c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','86a87b01-05a5-4654-8530-4ad6030c742c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','980741eb-df1e-4284-94a9-0f6ccd3d418b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0bb751ee-9120-4f7d-aaee-2e9a62c3ac4b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','6cac6afe-01fd-4037-992a-205151ddf223')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','6cac6afe-01fd-4037-992a-205151ddf223')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','6cac6afe-01fd-4037-992a-205151ddf223')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6cac6afe-01fd-4037-992a-205151ddf223')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','6cac6afe-01fd-4037-992a-205151ddf223')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6cac6afe-01fd-4037-992a-205151ddf223')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e420e3fe-4b6a-4c55-9abc-5e5c5136c779')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','e420e3fe-4b6a-4c55-9abc-5e5c5136c779')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','7d559e62-df65-4b24-ab4c-d48652e7b4d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7d559e62-df65-4b24-ab4c-d48652e7b4d3')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','7d559e62-df65-4b24-ab4c-d48652e7b4d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','da979d51-f8c1-4a53-a798-8151b00ca074')
,('501ffd87-ef29-4656-ac28-1ea0ae57c1c8','da979d51-f8c1-4a53-a798-8151b00ca074')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c111d44b-908f-4e6a-bcf3-9eb4384bdc7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c111d44b-908f-4e6a-bcf3-9eb4384bdc7c')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','c111d44b-908f-4e6a-bcf3-9eb4384bdc7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89627489-9ee0-498f-addf-7f7399d12131')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','89627489-9ee0-498f-addf-7f7399d12131')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0a7ae0a6-16d8-4ead-83bc-19df15dda8d1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','033e86b2-1655-418c-b157-a2b0c6aae4cc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','033e86b2-1655-418c-b157-a2b0c6aae4cc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','51fc755f-72c4-4dfb-b4e2-683f59d7811d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b277db8f-6f2d-4ee6-9199-707263895355')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b277db8f-6f2d-4ee6-9199-707263895355')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e0a65c67-b5da-4fc4-86fc-0fb4c23437c9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e0a65c67-b5da-4fc4-86fc-0fb4c23437c9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','749be668-22c9-488f-9d68-76b25889afa6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','749be668-22c9-488f-9d68-76b25889afa6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a46e8179-9e48-483d-9374-dcf0bf72e456')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','21748edd-6575-41e2-b8b7-9dc17e987d89')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','db88885e-0f05-4bc6-b04e-0d4ad3c44b7b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','db88885e-0f05-4bc6-b04e-0d4ad3c44b7b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3c2cee55-a9a2-41c2-9236-c1faa27dc874')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3c2cee55-a9a2-41c2-9236-c1faa27dc874')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','534d9be2-ecab-429a-b2c1-7b66303fb697')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','534d9be2-ecab-429a-b2c1-7b66303fb697')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','97ae30bf-ff12-4faa-bb6a-6e679238d81d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','97ae30bf-ff12-4faa-bb6a-6e679238d81d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','21fd57c8-9ab7-471e-8731-2dc065c07a41')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','21fd57c8-9ab7-471e-8731-2dc065c07a41')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4947fc8b-c735-4d33-a967-9748d3dc1fb3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4947fc8b-c735-4d33-a967-9748d3dc1fb3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d288f32-4d63-43e7-9c88-e3e44d2074cc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3d288f32-4d63-43e7-9c88-e3e44d2074cc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ead712a2-6501-431f-8e8d-6f74a5c1643c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ead712a2-6501-431f-8e8d-6f74a5c1643c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ccfad552-3690-4cb8-8a55-28b38e3a7856')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ccfad552-3690-4cb8-8a55-28b38e3a7856')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b3bbb852-09ea-46de-95a8-67991dd97d87')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c50111e1-612f-4aaf-abc5-aca1173f841f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c50111e1-612f-4aaf-abc5-aca1173f841f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','afd0e9a7-92dd-4984-a793-0c0788a754a7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','afd0e9a7-92dd-4984-a793-0c0788a754a7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f0375df3-60b2-494a-b2ec-f8d34bdd24b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f0375df3-60b2-494a-b2ec-f8d34bdd24b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab1903b6-06d2-4aa5-acf7-485774a0a437')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab1903b6-06d2-4aa5-acf7-485774a0a437')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','00897772-da4c-4183-82a7-9977cb06e038')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d4966fdc-01fc-4433-a940-af4b6d74240b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d4966fdc-01fc-4433-a940-af4b6d74240b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','18dca0f5-10b1-421c-82cf-2f9ce8341c48')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','18dca0f5-10b1-421c-82cf-2f9ce8341c48')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e0d73834-c981-4ccc-811d-2600066901ee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e0d73834-c981-4ccc-811d-2600066901ee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','17871dba-5982-41d8-b654-370c30385a44')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','17871dba-5982-41d8-b654-370c30385a44')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d37f362b-705d-468e-99cf-9368c25a69b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d37f362b-705d-468e-99cf-9368c25a69b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','032d3af5-11dd-4402-8ff5-cff8835c103d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','032d3af5-11dd-4402-8ff5-cff8835c103d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b492814f-13b5-466a-9b6a-0c58edb69ee8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b492814f-13b5-466a-9b6a-0c58edb69ee8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f2bb7d01-4a00-4bdb-876e-3e2b4dd3cfee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f2bb7d01-4a00-4bdb-876e-3e2b4dd3cfee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36e5bea0-5d53-483f-ad35-9c7a4f3964af')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','36e5bea0-5d53-483f-ad35-9c7a4f3964af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36e5bea0-5d53-483f-ad35-9c7a4f3964af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c50068fd-61fb-46e2-b80b-4ba7902d68ef')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','c50068fd-61fb-46e2-b80b-4ba7902d68ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6aff0874-d6fa-43aa-95d5-df708b0d84ea')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','6aff0874-d6fa-43aa-95d5-df708b0d84ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6aff0874-d6fa-43aa-95d5-df708b0d84ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ce2329ca-2d41-43f9-9fcb-f8d943bb3e66')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ce2329ca-2d41-43f9-9fcb-f8d943bb3e66')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ce2329ca-2d41-43f9-9fcb-f8d943bb3e66')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1efe4ef2-358c-44a9-8d2e-a5c7b25caeb3')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1efe4ef2-358c-44a9-8d2e-a5c7b25caeb3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1efe4ef2-358c-44a9-8d2e-a5c7b25caeb3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1bbe0dcb-cccb-4616-9e68-0095cd5ade5b')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1bbe0dcb-cccb-4616-9e68-0095cd5ade5b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1bbe0dcb-cccb-4616-9e68-0095cd5ade5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d69bf7fc-4af6-4495-9a15-2c2071d05134')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','d69bf7fc-4af6-4495-9a15-2c2071d05134')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8cd6ac47-07c3-4aeb-b4f1-f710038e77b8')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8cd6ac47-07c3-4aeb-b4f1-f710038e77b8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8cd6ac47-07c3-4aeb-b4f1-f710038e77b8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a2893bb0-20a4-4ef1-b77c-71ad328c7c04')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','a2893bb0-20a4-4ef1-b77c-71ad328c7c04')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a2893bb0-20a4-4ef1-b77c-71ad328c7c04')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d8724bbf-6b66-472e-8a8e-14004bb5df1f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','d8724bbf-6b66-472e-8a8e-14004bb5df1f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d8724bbf-6b66-472e-8a8e-14004bb5df1f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','009ed54a-0f28-4305-bae1-c10f64b6d5f4')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','009ed54a-0f28-4305-bae1-c10f64b6d5f4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','009ed54a-0f28-4305-bae1-c10f64b6d5f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5b58755d-5472-4ed0-8975-a9bb2034b0c5')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','5b58755d-5472-4ed0-8975-a9bb2034b0c5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5b58755d-5472-4ed0-8975-a9bb2034b0c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b022b3a8-019d-4970-94fd-1cf72fc2468b')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','b022b3a8-019d-4970-94fd-1cf72fc2468b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b022b3a8-019d-4970-94fd-1cf72fc2468b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6079e284-420a-462a-9a33-0cc6fd86085d')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','6079e284-420a-462a-9a33-0cc6fd86085d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6079e284-420a-462a-9a33-0cc6fd86085d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b8f0a3ca-1d09-4be7-af72-f9b48dffb44c')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','b8f0a3ca-1d09-4be7-af72-f9b48dffb44c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b8f0a3ca-1d09-4be7-af72-f9b48dffb44c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ba84721-358b-4186-9d0a-439895a19e6b')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','2ba84721-358b-4186-9d0a-439895a19e6b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ba84721-358b-4186-9d0a-439895a19e6b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bb9f4883-aa00-4b46-b4d5-1d1704b5584d')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','bb9f4883-aa00-4b46-b4d5-1d1704b5584d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bb9f4883-aa00-4b46-b4d5-1d1704b5584d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3fd7cda4-9b1e-4b24-b41c-c1bd208f792a')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','3fd7cda4-9b1e-4b24-b41c-c1bd208f792a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3fd7cda4-9b1e-4b24-b41c-c1bd208f792a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','79fdb6dc-6596-442a-8934-bffbcb186e24')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','79fdb6dc-6596-442a-8934-bffbcb186e24')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','79fdb6dc-6596-442a-8934-bffbcb186e24')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cd9ef201-19b9-494f-94cc-16fef0a16b21')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','cd9ef201-19b9-494f-94cc-16fef0a16b21')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cd9ef201-19b9-494f-94cc-16fef0a16b21')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ae32d196-9ac4-49c4-8c69-a7c5cb478c89')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','ae32d196-9ac4-49c4-8c69-a7c5cb478c89')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ae32d196-9ac4-49c4-8c69-a7c5cb478c89')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d5fad3f0-b255-41e7-ba82-5283750c6359')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','d5fad3f0-b255-41e7-ba82-5283750c6359')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d5fad3f0-b255-41e7-ba82-5283750c6359')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ac4f510-0cce-4cce-8f80-d6d05a708643')
,('bc3192c5-05aa-4af1-be4e-8bfdeb121029','6ac4f510-0cce-4cce-8f80-d6d05a708643')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ac4f510-0cce-4cce-8f80-d6d05a708643')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ff34252e-8700-4134-90b7-5537057e1253')
,('096610eb-5d96-42b3-8fa7-81aaeb9bfdc7','ff34252e-8700-4134-90b7-5537057e1253')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bd9d7225-1463-4e46-9830-89087fc11b7f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','bd9d7225-1463-4e46-9830-89087fc11b7f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bd9d7225-1463-4e46-9830-89087fc11b7f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b4e8fee-9c58-4333-be29-0d121892b220')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','3b4e8fee-9c58-4333-be29-0d121892b220')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1829a363-298b-4974-ad2a-9cf6e5b068f9')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1829a363-298b-4974-ad2a-9cf6e5b068f9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1829a363-298b-4974-ad2a-9cf6e5b068f9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48f855a7-c1b9-46cf-ba40-88eefc64ee12')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','48f855a7-c1b9-46cf-ba40-88eefc64ee12')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48f855a7-c1b9-46cf-ba40-88eefc64ee12')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','84b0aff7-dae9-4acd-98db-61d1431e3a4f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','84b0aff7-dae9-4acd-98db-61d1431e3a4f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','84b0aff7-dae9-4acd-98db-61d1431e3a4f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9a77093b-1f97-40fd-aeea-b9a8a6782e0d')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','9a77093b-1f97-40fd-aeea-b9a8a6782e0d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9a77093b-1f97-40fd-aeea-b9a8a6782e0d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c7abb5ca-22aa-4928-8776-4ba7c459fe19')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','c7abb5ca-22aa-4928-8776-4ba7c459fe19')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c7abb5ca-22aa-4928-8776-4ba7c459fe19')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d2f3b9b4-5501-41e8-86c9-0b9b8e395018')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','d2f3b9b4-5501-41e8-86c9-0b9b8e395018')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d2f3b9b4-5501-41e8-86c9-0b9b8e395018')
,('c7e230da-3c22-4915-9ad9-968f874536a5','e01cfc27-16a4-4660-81b1-f7c50341ff7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e01cfc27-16a4-4660-81b1-f7c50341ff7c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','e01cfc27-16a4-4660-81b1-f7c50341ff7c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e01cfc27-16a4-4660-81b1-f7c50341ff7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c1da9813-0f5d-4a3a-b644-5d77878b2aea')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','c1da9813-0f5d-4a3a-b644-5d77878b2aea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c1da9813-0f5d-4a3a-b644-5d77878b2aea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4731508a-79a7-43a4-a6e4-3d7f12eb790a')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','4731508a-79a7-43a4-a6e4-3d7f12eb790a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4731508a-79a7-43a4-a6e4-3d7f12eb790a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7211dd50-7cfc-4d81-88a4-5a3478077358')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','7211dd50-7cfc-4d81-88a4-5a3478077358')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7211dd50-7cfc-4d81-88a4-5a3478077358')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','46b25f35-7831-4857-9c93-cf1fbaaa5ef5')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','46b25f35-7831-4857-9c93-cf1fbaaa5ef5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','46b25f35-7831-4857-9c93-cf1fbaaa5ef5')
,('c7e230da-3c22-4915-9ad9-968f874536a5','ee4c9282-0376-4280-852b-a091022a09e6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee4c9282-0376-4280-852b-a091022a09e6')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ee4c9282-0376-4280-852b-a091022a09e6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee4c9282-0376-4280-852b-a091022a09e6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e581f26e-77ca-4bea-a1d6-d5dd7e4238f2')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','e581f26e-77ca-4bea-a1d6-d5dd7e4238f2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e581f26e-77ca-4bea-a1d6-d5dd7e4238f2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6d86844c-2d84-4cda-8dc3-0de4914931e9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6d86844c-2d84-4cda-8dc3-0de4914931e9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','83b3dcd2-9e0d-412f-86b0-72e1494dfbde')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','83b3dcd2-9e0d-412f-86b0-72e1494dfbde')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4bf4dcb0-ccf7-47f4-8c42-9c3873973def')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4bf4dcb0-ccf7-47f4-8c42-9c3873973def')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2c07c270-88ef-4830-be3b-5922b29af399')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2c07c270-88ef-4830-be3b-5922b29af399')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7c428714-432a-4cb3-81ce-c3673cbefcf4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7c428714-432a-4cb3-81ce-c3673cbefcf4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f1927c91-f580-4080-850d-9ee88a9409ac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f1927c91-f580-4080-850d-9ee88a9409ac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1041c5eb-0ec5-4bd4-99b3-06152644c9a1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','707f6abf-f5ec-42ba-865c-81449c189cab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5c012fd0-af7f-4d2b-a236-0a4cea09c73d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5c012fd0-af7f-4d2b-a236-0a4cea09c73d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c444b6b-da72-454e-ac72-bf0c71d25afa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','33d7c2b1-2767-4bc7-886b-8b031e032f28')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','33d7c2b1-2767-4bc7-886b-8b031e032f28')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e8426e76-252a-4b6b-9019-041550ba1b96')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e8426e76-252a-4b6b-9019-041550ba1b96')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d0bee939-83b3-4771-b77e-d07e409cfc33')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d0bee939-83b3-4771-b77e-d07e409cfc33')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1d9eed93-f21a-4506-b051-7b30737404dd')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1d9eed93-f21a-4506-b051-7b30737404dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1d9eed93-f21a-4506-b051-7b30737404dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9ffd7804-8250-4a6f-94bf-805166b647ee')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','9ffd7804-8250-4a6f-94bf-805166b647ee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e6d3708-c173-47d9-8d3e-74b69be65a6f')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','1e6d3708-c173-47d9-8d3e-74b69be65a6f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e6d3708-c173-47d9-8d3e-74b69be65a6f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','453628ef-04b8-4de1-b030-78d170b2e8a7')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','453628ef-04b8-4de1-b030-78d170b2e8a7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','453628ef-04b8-4de1-b030-78d170b2e8a7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8bbfc6e2-88fc-4c4e-9315-d2debce1a89c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8bbfc6e2-88fc-4c4e-9315-d2debce1a89c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8bbfc6e2-88fc-4c4e-9315-d2debce1a89c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69f4bd76-3149-46d9-8cd4-39160d055751')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69f4bd76-3149-46d9-8cd4-39160d055751')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','28ca98df-d264-42f7-b717-356707b3716c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','28ca98df-d264-42f7-b717-356707b3716c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','785e4099-7bfc-499d-8208-7ec3584562e6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','785e4099-7bfc-499d-8208-7ec3584562e6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8743617-6181-498e-9a69-031e1a0b058c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c8743617-6181-498e-9a69-031e1a0b058c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab67034a-009f-4127-a056-652a1a86d3ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab67034a-009f-4127-a056-652a1a86d3ca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3816c59c-da10-472c-a6ed-6170903c9aec')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3816c59c-da10-472c-a6ed-6170903c9aec')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','532476ab-04d2-4606-8e53-f5b7b566e6d5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','532476ab-04d2-4606-8e53-f5b7b566e6d5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f6eda89a-cb5b-48da-a245-2926d39b980e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f6eda89a-cb5b-48da-a245-2926d39b980e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ac59bd79-8365-4868-82c8-07518372cc50')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ac59bd79-8365-4868-82c8-07518372cc50')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7d6a0e1-e1d4-486f-9fa1-555ebadd4dd9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7d6a0e1-e1d4-486f-9fa1-555ebadd4dd9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','79ea93c4-c250-4ebb-b631-116d54ad5536')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','79ea93c4-c250-4ebb-b631-116d54ad5536')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4ae8c0a7-0d58-4d64-9c9b-f72d63f78c8d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4ae8c0a7-0d58-4d64-9c9b-f72d63f78c8d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c4394a39-b823-400d-8aea-084a9a447e9f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c4394a39-b823-400d-8aea-084a9a447e9f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dc118d7a-1f22-4f6f-b850-9d07ce91256e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dc118d7a-1f22-4f6f-b850-9d07ce91256e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1b6b476d-8a4f-4d9d-96c2-5935e313230b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1b6b476d-8a4f-4d9d-96c2-5935e313230b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c3baf365-e4f7-48ce-bb0c-2576eca63154')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c3baf365-e4f7-48ce-bb0c-2576eca63154')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','70f8dcac-8473-4953-a044-13a913d5162b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','70f8dcac-8473-4953-a044-13a913d5162b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eb45abc3-17ec-4de0-91b7-a6a3a122252f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eb45abc3-17ec-4de0-91b7-a6a3a122252f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','93a90a31-6340-4baa-825d-42c56b41beb5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','93a90a31-6340-4baa-825d-42c56b41beb5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','115c43f9-7d3a-40a0-b61b-62aaf3449c33')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','115c43f9-7d3a-40a0-b61b-62aaf3449c33')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','72b06d8c-1b3e-4f57-a244-4662ac792ff3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','72b06d8c-1b3e-4f57-a244-4662ac792ff3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0b0a0ad-0f7a-4d1d-b35a-50cc315f0028')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0b0a0ad-0f7a-4d1d-b35a-50cc315f0028')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9af600d-1d14-4429-b0a7-f603540ea4be')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9af600d-1d14-4429-b0a7-f603540ea4be')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','90cb6d18-81da-4549-8106-773cef58ee0d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','90cb6d18-81da-4549-8106-773cef58ee0d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9947128c-bca3-4568-92d5-36cacfd37acf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9947128c-bca3-4568-92d5-36cacfd37acf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f995698-e27e-4308-b087-6975208cabc1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9f995698-e27e-4308-b087-6975208cabc1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','33c428a1-7419-4b01-a8b5-d7365415bfbe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','33c428a1-7419-4b01-a8b5-d7365415bfbe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','93855366-035e-4704-a18a-08998d97f318')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','93855366-035e-4704-a18a-08998d97f318')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3ffe17d-0c31-49a8-a26a-86ab282c6b99')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d3ffe17d-0c31-49a8-a26a-86ab282c6b99')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','81fc95d2-0a69-42e9-94f3-4fec4dca0ac1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','81fc95d2-0a69-42e9-94f3-4fec4dca0ac1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','400a4491-0e3b-48cd-a045-6224f319e0c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','400a4491-0e3b-48cd-a045-6224f319e0c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','250a6785-207e-4020-903e-cb260863b097')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','250a6785-207e-4020-903e-cb260863b097')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','08680504-457b-4dbd-a609-74845737b082')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','08680504-457b-4dbd-a609-74845737b082')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5c9681b-3846-4267-aefc-78d7b7f17e42')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a5c9681b-3846-4267-aefc-78d7b7f17e42')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','773605d7-be42-4979-891d-f8fba880c4f2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','773605d7-be42-4979-891d-f8fba880c4f2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9562bac0-feb5-447b-a276-6c50cd7a6942')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9562bac0-feb5-447b-a276-6c50cd7a6942')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','db733467-02e2-4d9d-85d4-a094899e9687')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','db733467-02e2-4d9d-85d4-a094899e9687')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dece605f-2578-47c8-abc3-8662a0859dbc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dece605f-2578-47c8-abc3-8662a0859dbc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8cfbdaef-700c-4dc3-bd77-73486c1db3ff')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8cfbdaef-700c-4dc3-bd77-73486c1db3ff')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','037c766c-8b0a-4a7f-b52a-abe94286ceec')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','037c766c-8b0a-4a7f-b52a-abe94286ceec')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','c065c083-c0e0-421f-945c-564ca76501ca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c065c083-c0e0-421f-945c-564ca76501ca')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','c065c083-c0e0-421f-945c-564ca76501ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c065c083-c0e0-421f-945c-564ca76501ca')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','8af29758-0e1f-4e05-93d1-2489cdfb36df')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8af29758-0e1f-4e05-93d1-2489cdfb36df')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','8af29758-0e1f-4e05-93d1-2489cdfb36df')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8af29758-0e1f-4e05-93d1-2489cdfb36df')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','3be62313-6091-4e56-99ab-a6ccfc7b876e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3be62313-6091-4e56-99ab-a6ccfc7b876e')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','3be62313-6091-4e56-99ab-a6ccfc7b876e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3be62313-6091-4e56-99ab-a6ccfc7b876e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa5d4be4-b71a-454b-bf5c-308531298269')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','fa5d4be4-b71a-454b-bf5c-308531298269')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fa5d4be4-b71a-454b-bf5c-308531298269')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','7fa7ae5e-b9ed-4e0c-8206-3cb518555233')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7fa7ae5e-b9ed-4e0c-8206-3cb518555233')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','7fa7ae5e-b9ed-4e0c-8206-3cb518555233')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','58dbd615-07ee-42cf-ae1c-212d221f7f5f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','58dbd615-07ee-42cf-ae1c-212d221f7f5f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','44359261-30a0-409f-a5a3-bef4cff584a6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','44359261-30a0-409f-a5a3-bef4cff584a6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','db3e8d4a-7533-4eab-b0c7-e27756c66730')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','db3e8d4a-7533-4eab-b0c7-e27756c66730')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ef2cf3e-ba8e-4c89-a470-52d922c72083')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ef2cf3e-ba8e-4c89-a470-52d922c72083')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9051c725-aa36-47bf-857c-71be02634f47')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9051c725-aa36-47bf-857c-71be02634f47')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f645e9ac-12c3-4e5e-96c0-f4b37b195118')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f645e9ac-12c3-4e5e-96c0-f4b37b195118')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','20f36ae3-b09a-450f-896f-36cd0c1077c2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','20f36ae3-b09a-450f-896f-36cd0c1077c2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','13180eb6-6066-4765-a77d-91aa8835dd4c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','13180eb6-6066-4765-a77d-91aa8835dd4c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','837264e6-ccf6-4363-ab2e-10300ae78b3b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','837264e6-ccf6-4363-ab2e-10300ae78b3b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f44f0572-eb6c-42cf-8da9-0fee1a21c995')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f44f0572-eb6c-42cf-8da9-0fee1a21c995')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','810c09c7-7888-4ae2-aa99-824c074dff88')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','810c09c7-7888-4ae2-aa99-824c074dff88')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3a0c27d5-ca5d-4343-bac7-e2c666bcadd8')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','3a0c27d5-ca5d-4343-bac7-e2c666bcadd8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3a0c27d5-ca5d-4343-bac7-e2c666bcadd8')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','4920be8f-215f-4d45-aaa0-805e96d8810f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3843fd1-449b-4492-8a70-cc1b1c96807e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d3843fd1-449b-4492-8a70-cc1b1c96807e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a04f94f2-2a46-4c79-b3e2-00e734043d54')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a04f94f2-2a46-4c79-b3e2-00e734043d54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0b1c6f3d-9f3c-48eb-8608-d8fb8820e7b2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0b1c6f3d-9f3c-48eb-8608-d8fb8820e7b2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e3ab122a-1a71-4e9f-88d1-3f0f93d980ee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e3ab122a-1a71-4e9f-88d1-3f0f93d980ee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','479854a9-eb53-4da6-b31f-5ea28297f1c2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','479854a9-eb53-4da6-b31f-5ea28297f1c2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30c9f36f-e5f5-452b-80f7-2be24964aa5e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','30c9f36f-e5f5-452b-80f7-2be24964aa5e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9514b5f2-d586-477e-b19e-11b6566838c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9514b5f2-d586-477e-b19e-11b6566838c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a0529f2d-6b08-4b27-9da7-e87165bddfeb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a0529f2d-6b08-4b27-9da7-e87165bddfeb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c423eeff-7a96-4d76-89f0-5269b7d3bbc5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c423eeff-7a96-4d76-89f0-5269b7d3bbc5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ce717f7a-0143-4ebc-92b3-5b2e47000b09')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ce717f7a-0143-4ebc-92b3-5b2e47000b09')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b3f5f29b-755f-4d35-b6b6-c9b6a88ffd65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b3f5f29b-755f-4d35-b6b6-c9b6a88ffd65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','925de6ab-c30d-44a6-891e-c4626ee648b0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','925de6ab-c30d-44a6-891e-c4626ee648b0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ee40704-aa41-4c14-988c-5f602616632c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ee40704-aa41-4c14-988c-5f602616632c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c30d0de6-7182-4618-83bf-f25a6e827383')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c30d0de6-7182-4618-83bf-f25a6e827383')
,('c7e230da-3c22-4915-9ad9-968f874536a5','1c1a0208-8d45-4207-ac3d-c09f61af6398')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c1a0208-8d45-4207-ac3d-c09f61af6398')
,('771bf47d-a099-4ec6-aa41-02108ece7713','1c1a0208-8d45-4207-ac3d-c09f61af6398')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','1c1a0208-8d45-4207-ac3d-c09f61af6398')
,('c7e230da-3c22-4915-9ad9-968f874536a5','ddaf59af-99a1-444b-9789-85069baea65e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ddaf59af-99a1-444b-9789-85069baea65e')
,('771bf47d-a099-4ec6-aa41-02108ece7713','ddaf59af-99a1-444b-9789-85069baea65e')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','ddaf59af-99a1-444b-9789-85069baea65e')
,('c7e230da-3c22-4915-9ad9-968f874536a5','80c040bc-26b8-4f57-a179-91bc71fdfe95')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','80c040bc-26b8-4f57-a179-91bc71fdfe95')
,('771bf47d-a099-4ec6-aa41-02108ece7713','80c040bc-26b8-4f57-a179-91bc71fdfe95')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','80c040bc-26b8-4f57-a179-91bc71fdfe95')
,('c7e230da-3c22-4915-9ad9-968f874536a5','6ff6ca1c-accc-4fd8-99b1-cd44701e8811')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ff6ca1c-accc-4fd8-99b1-cd44701e8811')
,('771bf47d-a099-4ec6-aa41-02108ece7713','6ff6ca1c-accc-4fd8-99b1-cd44701e8811')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','6ff6ca1c-accc-4fd8-99b1-cd44701e8811')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a92bdb85-4d59-44c6-b9cb-d9ae60918bd3')
,('771bf47d-a099-4ec6-aa41-02108ece7713','a92bdb85-4d59-44c6-b9cb-d9ae60918bd3')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','a92bdb85-4d59-44c6-b9cb-d9ae60918bd3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0c5a7d0-5c0f-4544-9b39-0aaa47bfa78b')
,('771bf47d-a099-4ec6-aa41-02108ece7713','c0c5a7d0-5c0f-4544-9b39-0aaa47bfa78b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c0c5a7d0-5c0f-4544-9b39-0aaa47bfa78b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9667fb45-7c62-4c65-b94f-10e533c8521d')
,('771bf47d-a099-4ec6-aa41-02108ece7713','9667fb45-7c62-4c65-b94f-10e533c8521d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','80d7d8e6-ce8e-4580-ad5b-9ffb3c7aae39')
,('771bf47d-a099-4ec6-aa41-02108ece7713','80d7d8e6-ce8e-4580-ad5b-9ffb3c7aae39')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','80d7d8e6-ce8e-4580-ad5b-9ffb3c7aae39')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d93144a-7790-4291-8066-8e47e266325f')
,('771bf47d-a099-4ec6-aa41-02108ece7713','3d93144a-7790-4291-8066-8e47e266325f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3d93144a-7790-4291-8066-8e47e266325f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5b4f8e62-c943-4dc6-9c50-a769bdb9bd9b')
,('771bf47d-a099-4ec6-aa41-02108ece7713','5b4f8e62-c943-4dc6-9c50-a769bdb9bd9b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5b4f8e62-c943-4dc6-9c50-a769bdb9bd9b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ce48c0e9-7278-49b9-887a-23bd3010d826')
,('771bf47d-a099-4ec6-aa41-02108ece7713','ce48c0e9-7278-49b9-887a-23bd3010d826')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ce48c0e9-7278-49b9-887a-23bd3010d826')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df68bab3-d744-418d-aa35-10259f7597c4')
,('771bf47d-a099-4ec6-aa41-02108ece7713','df68bab3-d744-418d-aa35-10259f7597c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df68bab3-d744-418d-aa35-10259f7597c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9e5e340f-2d4e-457c-b4b9-735ed539f480')
,('771bf47d-a099-4ec6-aa41-02108ece7713','9e5e340f-2d4e-457c-b4b9-735ed539f480')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9e5e340f-2d4e-457c-b4b9-735ed539f480')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7e0ffe22-046c-49b3-b724-b64ed257628a')
,('771bf47d-a099-4ec6-aa41-02108ece7713','7e0ffe22-046c-49b3-b724-b64ed257628a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7e0ffe22-046c-49b3-b724-b64ed257628a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','58acc934-c4c7-4bd4-919b-f9a3382f0a9e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','58acc934-c4c7-4bd4-919b-f9a3382f0a9e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1900f81a-c015-4174-a3dd-97ec9110dc68')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1900f81a-c015-4174-a3dd-97ec9110dc68')
,('c7e230da-3c22-4915-9ad9-968f874536a5','c1f7d811-436b-420d-abb3-c25316534147')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c1f7d811-436b-420d-abb3-c25316534147')
,('771bf47d-a099-4ec6-aa41-02108ece7713','c1f7d811-436b-420d-abb3-c25316534147')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','c1f7d811-436b-420d-abb3-c25316534147')
,('c7e230da-3c22-4915-9ad9-968f874536a5','bcaab1e8-b573-48da-81a1-7043a17998b8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bcaab1e8-b573-48da-81a1-7043a17998b8')
,('771bf47d-a099-4ec6-aa41-02108ece7713','bcaab1e8-b573-48da-81a1-7043a17998b8')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','bcaab1e8-b573-48da-81a1-7043a17998b8')
,('c7e230da-3c22-4915-9ad9-968f874536a5','87c8ccc2-9b2f-4fff-9e5a-9eecf2e682f7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','87c8ccc2-9b2f-4fff-9e5a-9eecf2e682f7')
,('771bf47d-a099-4ec6-aa41-02108ece7713','87c8ccc2-9b2f-4fff-9e5a-9eecf2e682f7')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','87c8ccc2-9b2f-4fff-9e5a-9eecf2e682f7')
,('c7e230da-3c22-4915-9ad9-968f874536a5','8f89ede1-675e-40af-bb30-b62b29d48660')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8f89ede1-675e-40af-bb30-b62b29d48660')
,('771bf47d-a099-4ec6-aa41-02108ece7713','8f89ede1-675e-40af-bb30-b62b29d48660')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','8f89ede1-675e-40af-bb30-b62b29d48660')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb5a4aa6-c4ec-422a-9fae-c1961f5df2c6')
,('771bf47d-a099-4ec6-aa41-02108ece7713','cb5a4aa6-c4ec-422a-9fae-c1961f5df2c6')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','cb5a4aa6-c4ec-422a-9fae-c1961f5df2c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','02ec4d4c-72b7-45fa-9729-83de9e31b03d')
,('771bf47d-a099-4ec6-aa41-02108ece7713','02ec4d4c-72b7-45fa-9729-83de9e31b03d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','02ec4d4c-72b7-45fa-9729-83de9e31b03d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2c384303-b083-4527-8188-2e6941c68780')
,('771bf47d-a099-4ec6-aa41-02108ece7713','2c384303-b083-4527-8188-2e6941c68780')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','95a3ed2a-ac9c-428c-a8d0-511ee8f95f00')
,('771bf47d-a099-4ec6-aa41-02108ece7713','95a3ed2a-ac9c-428c-a8d0-511ee8f95f00')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95a3ed2a-ac9c-428c-a8d0-511ee8f95f00')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b7d7d365-8707-4ba4-8b74-1cfbfdef0db4')
,('771bf47d-a099-4ec6-aa41-02108ece7713','b7d7d365-8707-4ba4-8b74-1cfbfdef0db4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b7d7d365-8707-4ba4-8b74-1cfbfdef0db4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ef047745-00c3-45a2-ac02-8e1b630fa64e')
,('771bf47d-a099-4ec6-aa41-02108ece7713','ef047745-00c3-45a2-ac02-8e1b630fa64e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ef047745-00c3-45a2-ac02-8e1b630fa64e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2f1900cd-ff63-41be-b821-9d948bc302e7')
,('771bf47d-a099-4ec6-aa41-02108ece7713','2f1900cd-ff63-41be-b821-9d948bc302e7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2f1900cd-ff63-41be-b821-9d948bc302e7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','502e3751-5d40-4eda-9abb-4722aacc3df5')
,('771bf47d-a099-4ec6-aa41-02108ece7713','502e3751-5d40-4eda-9abb-4722aacc3df5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','502e3751-5d40-4eda-9abb-4722aacc3df5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5cde05c-bea6-4110-9559-14a0fd3fc01d')
,('771bf47d-a099-4ec6-aa41-02108ece7713','c5cde05c-bea6-4110-9559-14a0fd3fc01d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c5cde05c-bea6-4110-9559-14a0fd3fc01d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f8d43156-9741-434f-85fe-f85e8c4561c8')
,('771bf47d-a099-4ec6-aa41-02108ece7713','f8d43156-9741-434f-85fe-f85e8c4561c8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f8d43156-9741-434f-85fe-f85e8c4561c8')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','89d2a3c9-1cf9-4e6f-9521-aa628024f41c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','89d2a3c9-1cf9-4e6f-9521-aa628024f41c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89d2a3c9-1cf9-4e6f-9521-aa628024f41c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','89d2a3c9-1cf9-4e6f-9521-aa628024f41c')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','4172ce6c-85c9-4d22-9ae8-eaada7865ee9')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','4172ce6c-85c9-4d22-9ae8-eaada7865ee9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4172ce6c-85c9-4d22-9ae8-eaada7865ee9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4172ce6c-85c9-4d22-9ae8-eaada7865ee9')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','7519ce66-5fa2-4d85-adc8-8fbeda1784ab')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','7519ce66-5fa2-4d85-adc8-8fbeda1784ab')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','51ebc852-8973-4458-9d85-6247c80accad')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','51ebc852-8973-4458-9d85-6247c80accad')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','a07bb997-2fb2-4dc1-8cf5-5c160602e2b1')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a07bb997-2fb2-4dc1-8cf5-5c160602e2b1')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','281029e1-540d-48dc-bc8d-8168d8f8d42e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','281029e1-540d-48dc-bc8d-8168d8f8d42e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','281029e1-540d-48dc-bc8d-8168d8f8d42e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','378be2d0-61f2-4cd9-a66c-fbaedf8e11a0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','378be2d0-61f2-4cd9-a66c-fbaedf8e11a0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','378be2d0-61f2-4cd9-a66c-fbaedf8e11a0')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b0ce81f8-9b50-4dba-954f-93579ba5c76f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0ce81f8-9b50-4dba-954f-93579ba5c76f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0ce81f8-9b50-4dba-954f-93579ba5c76f')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','84f5748e-7e87-45fe-8df9-c6b75113aedf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','84f5748e-7e87-45fe-8df9-c6b75113aedf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','84f5748e-7e87-45fe-8df9-c6b75113aedf')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','bd7d668a-4709-42f4-be1d-56984008d885')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bd7d668a-4709-42f4-be1d-56984008d885')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bd7d668a-4709-42f4-be1d-56984008d885')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','4724c368-fe2e-4586-9a86-72bb739d610b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4724c368-fe2e-4586-9a86-72bb739d610b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4724c368-fe2e-4586-9a86-72bb739d610b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b482c5a4-6765-4264-9e1f-8efafd6bcac7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b482c5a4-6765-4264-9e1f-8efafd6bcac7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b482c5a4-6765-4264-9e1f-8efafd6bcac7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a20fe560-0545-42c6-8237-79135093a914')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a20fe560-0545-42c6-8237-79135093a914')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f8c92e3-8476-4f4d-94d7-70cd69e30a61')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9f8c92e3-8476-4f4d-94d7-70cd69e30a61')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15cfdccf-21c5-4975-9b58-2846a5aea6ed')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','15cfdccf-21c5-4975-9b58-2846a5aea6ed')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f93a5ba8-7ed5-45c6-8aa7-b2f92cd38464')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f93a5ba8-7ed5-45c6-8aa7-b2f92cd38464')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b7d6b0e-9fe2-453c-882d-d33ed371f312')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b7d6b0e-9fe2-453c-882d-d33ed371f312')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f48b62fe-e9a9-4fc1-96ef-ea4e7f14a24e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f48b62fe-e9a9-4fc1-96ef-ea4e7f14a24e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ece1a906-af90-4c9f-8648-142b34d6f4a5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ece1a906-af90-4c9f-8648-142b34d6f4a5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ece1a906-af90-4c9f-8648-142b34d6f4a5')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b0484eb9-3ab2-4e23-bf0c-6e0078f5b8f1')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','288589d1-07a4-4fd3-9c71-46c9b4cd1b2c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','288589d1-07a4-4fd3-9c71-46c9b4cd1b2c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','288589d1-07a4-4fd3-9c71-46c9b4cd1b2c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','2951e2ce-83e2-4941-961f-a870009bee87')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2951e2ce-83e2-4941-961f-a870009bee87')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2951e2ce-83e2-4941-961f-a870009bee87')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','62ef6317-06a5-444d-ba8b-55034bfbf28f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','62ef6317-06a5-444d-ba8b-55034bfbf28f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','62ef6317-06a5-444d-ba8b-55034bfbf28f')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','a8c70ee9-4dc6-401b-93d8-004f9d34187f')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a8c70ee9-4dc6-401b-93d8-004f9d34187f')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','00a65a34-1eb6-4d1d-8602-7fb013cf69da')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','00a65a34-1eb6-4d1d-8602-7fb013cf69da')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','77ca4a2c-0c1c-48ac-8785-28e1267e8d0b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','77ca4a2c-0c1c-48ac-8785-28e1267e8d0b')
,('9fbf6ee7-8258-42ff-b771-21a2b09d17c8','77ca4a2c-0c1c-48ac-8785-28e1267e8d0b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c54b3c37-5ddd-4171-9954-e82a96fa1bf8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c54b3c37-5ddd-4171-9954-e82a96fa1bf8')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a6d2116a-361c-45a6-9350-5905ca3013c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a6d2116a-361c-45a6-9350-5905ca3013c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','97e91663-7973-40a5-8f09-ace1da5993d0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','97e91663-7973-40a5-8f09-ace1da5993d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ec94de3-9d4a-44c8-ab98-4803e5abee50')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ec94de3-9d4a-44c8-ab98-4803e5abee50')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fc8547f9-7dfa-4e91-868e-17f3f71f199e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fc8547f9-7dfa-4e91-868e-17f3f71f199e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b2d90d0f-d6fd-4ec4-ab28-935199798f35')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b2d90d0f-d6fd-4ec4-ab28-935199798f35')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6de218fb-cb59-4d44-92dc-08abca03e635')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6de218fb-cb59-4d44-92dc-08abca03e635')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3a39c169-8c4a-404f-8a9d-eafca7630782')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3a39c169-8c4a-404f-8a9d-eafca7630782')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a6b50611-5ed5-4e05-9acd-61939ce882b0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a6b50611-5ed5-4e05-9acd-61939ce882b0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a6b50611-5ed5-4e05-9acd-61939ce882b0')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a868207b-cb26-4065-881b-77a16c984df9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a868207b-cb26-4065-881b-77a16c984df9')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','b146b5e1-0a4e-4c62-8eed-464f377a492c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b146b5e1-0a4e-4c62-8eed-464f377a492c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b146b5e1-0a4e-4c62-8eed-464f377a492c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','7487d61a-c302-4746-9c00-76518deed272')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7487d61a-c302-4746-9c00-76518deed272')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7487d61a-c302-4746-9c00-76518deed272')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','8c727f51-d68d-4a94-ac89-104b0cb22ded')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8c727f51-d68d-4a94-ac89-104b0cb22ded')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8c727f51-d68d-4a94-ac89-104b0cb22ded')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','4ca1c812-eb49-4a1d-935f-e61350c0cd0a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4ca1c812-eb49-4a1d-935f-e61350c0cd0a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4ca1c812-eb49-4a1d-935f-e61350c0cd0a')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','3c2dbc68-373a-42aa-a673-748b20a79b3e')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','1a6c32fc-17b4-433f-8aa4-dbd0c7508d36')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1a6c32fc-17b4-433f-8aa4-dbd0c7508d36')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1a6c32fc-17b4-433f-8aa4-dbd0c7508d36')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','3426e81a-85ec-415c-9c0f-4b69c1f51025')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3426e81a-85ec-415c-9c0f-4b69c1f51025')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3426e81a-85ec-415c-9c0f-4b69c1f51025')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','2a07a93b-3800-463c-b93c-be6b98310748')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2a07a93b-3800-463c-b93c-be6b98310748')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2a07a93b-3800-463c-b93c-be6b98310748')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','625b7f93-6f03-4e51-8fa0-cd0a31a1eee7')
,('771bf47d-a099-4ec6-aa41-02108ece7713','625b7f93-6f03-4e51-8fa0-cd0a31a1eee7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','625b7f93-6f03-4e51-8fa0-cd0a31a1eee7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','73a95e5f-4a39-4dea-b669-e16abfbe0336')
,('771bf47d-a099-4ec6-aa41-02108ece7713','73a95e5f-4a39-4dea-b669-e16abfbe0336')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','73a95e5f-4a39-4dea-b669-e16abfbe0336')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3509c70c-6661-4d2a-a02b-fe538d84b54d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3509c70c-6661-4d2a-a02b-fe538d84b54d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f17aa9e8-0ce7-41a1-9230-5ce2447ef867')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f17aa9e8-0ce7-41a1-9230-5ce2447ef867')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b6da8bab-ac5d-4c06-abaf-14d876398e0f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b6da8bab-ac5d-4c06-abaf-14d876398e0f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16b59a5c-d930-412f-af12-2ab974c886b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16b59a5c-d930-412f-af12-2ab974c886b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0093f04a-f094-422c-a78a-5c5cea32ce7c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0093f04a-f094-422c-a78a-5c5cea32ce7c')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','0093f04a-f094-422c-a78a-5c5cea32ce7c')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','b314ef62-9028-4f9b-a80f-573ec6fac695')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','761446eb-cb90-4bae-8778-90fc4b708683')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','761446eb-cb90-4bae-8778-90fc4b708683')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','761446eb-cb90-4bae-8778-90fc4b708683')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6f672368-5262-4a44-84d3-ba1f4a09d2e2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6f672368-5262-4a44-84d3-ba1f4a09d2e2')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','6f672368-5262-4a44-84d3-ba1f4a09d2e2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ba3867a8-4e08-4523-8fcd-632c9384fce6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ba3867a8-4e08-4523-8fcd-632c9384fce6')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','ba3867a8-4e08-4523-8fcd-632c9384fce6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4938daf1-13e6-4c5b-9f81-e375eb1bd1c2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4938daf1-13e6-4c5b-9f81-e375eb1bd1c2')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','4938daf1-13e6-4c5b-9f81-e375eb1bd1c2')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','7cb386c9-e769-4bda-a5b9-8df030c0d491')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a976f7ae-4802-4d08-b1c7-21f1ca4c6537')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a976f7ae-4802-4d08-b1c7-21f1ca4c6537')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','a976f7ae-4802-4d08-b1c7-21f1ca4c6537')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','002f2c81-7313-4723-8b11-9065ba7dee82')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','002f2c81-7313-4723-8b11-9065ba7dee82')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','002f2c81-7313-4723-8b11-9065ba7dee82')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d7f06612-13e9-42cd-9d64-0b0b8fbfb5ab')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d7f06612-13e9-42cd-9d64-0b0b8fbfb5ab')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','d7f06612-13e9-42cd-9d64-0b0b8fbfb5ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1266967f-aa37-48a8-a4e0-fcb13e358abf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1266967f-aa37-48a8-a4e0-fcb13e358abf')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','1266967f-aa37-48a8-a4e0-fcb13e358abf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3abe9bc1-84aa-4ff9-b451-54befddfcdf0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3abe9bc1-84aa-4ff9-b451-54befddfcdf0')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','3abe9bc1-84aa-4ff9-b451-54befddfcdf0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b8c12f50-c7eb-4c3d-acb7-003ce8cb2e2e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b8c12f50-c7eb-4c3d-acb7-003ce8cb2e2e')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','b8c12f50-c7eb-4c3d-acb7-003ce8cb2e2e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fc984771-2f1d-46b2-abc4-d08d79eda2e8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fc984771-2f1d-46b2-abc4-d08d79eda2e8')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','fc984771-2f1d-46b2-abc4-d08d79eda2e8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','08156265-c32b-4f04-98d9-f4013154bce4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','08156265-c32b-4f04-98d9-f4013154bce4')
,('ec084e0d-f7d9-4df5-a7bc-59dd124addb5','08156265-c32b-4f04-98d9-f4013154bce4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69eee2b1-87a2-4d41-8b56-3028307dd952')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69eee2b1-87a2-4d41-8b56-3028307dd952')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','69eee2b1-87a2-4d41-8b56-3028307dd952')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36a37c46-213c-4a2e-a035-97ec3e76c481')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','36a37c46-213c-4a2e-a035-97ec3e76c481')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36a37c46-213c-4a2e-a035-97ec3e76c481')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ba75c9dd-d75c-473e-9f1b-95f41ce40a0a')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','ba75c9dd-d75c-473e-9f1b-95f41ce40a0a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ba75c9dd-d75c-473e-9f1b-95f41ce40a0a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ad3ddac9-a9b1-42e2-a3e3-dfa5bcf6cbf2')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','ad3ddac9-a9b1-42e2-a3e3-dfa5bcf6cbf2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ad3ddac9-a9b1-42e2-a3e3-dfa5bcf6cbf2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','94096367-0ffb-412f-b7d5-5eb9b51e8aca')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','94096367-0ffb-412f-b7d5-5eb9b51e8aca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','94096367-0ffb-412f-b7d5-5eb9b51e8aca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7c4354e-537a-4f61-b36b-027e2f89716e')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','a7c4354e-537a-4f61-b36b-027e2f89716e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7c4354e-537a-4f61-b36b-027e2f89716e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','115c00f6-2708-470b-9131-d06687a7fb40')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','115c00f6-2708-470b-9131-d06687a7fb40')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','115c00f6-2708-470b-9131-d06687a7fb40')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eec9a395-862c-4993-88bf-cd2295685b25')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eec9a395-862c-4993-88bf-cd2295685b25')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','75bae499-a77b-4fd3-988b-f9a94fd0fb59')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','75bae499-a77b-4fd3-988b-f9a94fd0fb59')
,('10cedc5f-717a-4800-b837-d250cce7c101','75bae499-a77b-4fd3-988b-f9a94fd0fb59')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','75bae499-a77b-4fd3-988b-f9a94fd0fb59')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d22eef0c-4260-4905-92f2-f9731f34397e')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','d22eef0c-4260-4905-92f2-f9731f34397e')
,('10cedc5f-717a-4800-b837-d250cce7c101','d22eef0c-4260-4905-92f2-f9731f34397e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d22eef0c-4260-4905-92f2-f9731f34397e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d3d0b2b-cbc5-4716-b9f3-6cd42d5d0300')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','8d3d0b2b-cbc5-4716-b9f3-6cd42d5d0300')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','325f62af-3d38-4890-a1f2-6d9f9504c0c9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','325f62af-3d38-4890-a1f2-6d9f9504c0c9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','78188ca0-a25c-4bb8-8f5c-2c22a87fc934')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','78188ca0-a25c-4bb8-8f5c-2c22a87fc934')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a8ac7b58-b4c2-4426-ac36-31f94726fbf3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a8ac7b58-b4c2-4426-ac36-31f94726fbf3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a1c5d349-3d4d-4b70-9576-609a682581bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a1c5d349-3d4d-4b70-9576-609a682581bf')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','a1c5d349-3d4d-4b70-9576-609a682581bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bc474d1d-9486-44ec-9de4-49e34e2b77fc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bc474d1d-9486-44ec-9de4-49e34e2b77fc')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','bc474d1d-9486-44ec-9de4-49e34e2b77fc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c53ba9d-4a19-4a50-94f8-0e51b1085fb3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4c53ba9d-4a19-4a50-94f8-0e51b1085fb3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2c8ab3db-db9a-4367-b65e-3d2f4bb9b50e')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','2c8ab3db-db9a-4367-b65e-3d2f4bb9b50e')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','00a1bda0-24fe-4026-9094-ea8eab5879f1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','00a1bda0-24fe-4026-9094-ea8eab5879f1')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','00a1bda0-24fe-4026-9094-ea8eab5879f1')
,('a10d9be0-7f9c-4d48-ae9c-c2101d7feb6e','f03338ef-d6e8-4ddf-960b-8e002287b92e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f03338ef-d6e8-4ddf-960b-8e002287b92e')
,('53a63aa3-6cec-483f-90c9-7f9dbbc2d997','f03338ef-d6e8-4ddf-960b-8e002287b92e')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','de60533c-20d8-4343-b73b-2fa82e3092c6')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','de60533c-20d8-4343-b73b-2fa82e3092c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e23e26c6-5e21-450a-a61b-7850508613a4')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','e23e26c6-5e21-450a-a61b-7850508613a4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','08824ff9-7afd-4b7e-9932-b1e53b3874d8')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','08824ff9-7afd-4b7e-9932-b1e53b3874d8')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','89d2cd77-5328-4995-86f1-c4ed202c9b96')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89d2cd77-5328-4995-86f1-c4ed202c9b96')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','143d00b8-ff5d-431f-ad72-891d3d7f3b4b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','143d00b8-ff5d-431f-ad72-891d3d7f3b4b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','ace52632-5dde-475b-9ec9-a1dc5b0b5195')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ace52632-5dde-475b-9ec9-a1dc5b0b5195')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','4af5dc14-4408-4922-a19a-0d1388b42f68')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4af5dc14-4408-4922-a19a-0d1388b42f68')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e6b6cc42-b94f-4fc1-87d7-951db91495be')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e6b6cc42-b94f-4fc1-87d7-951db91495be')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','bba7e0e6-2343-475f-9794-9c6b956df346')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bba7e0e6-2343-475f-9794-9c6b956df346')
,('237ff6b9-7d8c-4183-8004-fc8d787b44eb','bba7e0e6-2343-475f-9794-9c6b956df346')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bba7e0e6-2343-475f-9794-9c6b956df346')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','43abfca6-92d8-4a14-9572-70c0ca2b1d0d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','43abfca6-92d8-4a14-9572-70c0ca2b1d0d')
,('c7e230da-3c22-4915-9ad9-968f874536a5','eb3d3a9e-fed6-43e5-b307-5f89cac87180')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eb3d3a9e-fed6-43e5-b307-5f89cac87180')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eb3d3a9e-fed6-43e5-b307-5f89cac87180')
,('c7e230da-3c22-4915-9ad9-968f874536a5','ffebed0b-a4d7-4b71-9636-f481dd91bdd6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ffebed0b-a4d7-4b71-9636-f481dd91bdd6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ffebed0b-a4d7-4b71-9636-f481dd91bdd6')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','fa723b57-d4d1-45ad-a9af-8da8eaaf3018')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa723b57-d4d1-45ad-a9af-8da8eaaf3018')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fa723b57-d4d1-45ad-a9af-8da8eaaf3018')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e4de2215-78e5-4f5d-848d-1278745f3c92')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4de2215-78e5-4f5d-848d-1278745f3c92')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e4de2215-78e5-4f5d-848d-1278745f3c92')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','e2aae939-84e9-4d3f-9ba4-81820adf24e9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e2aae939-84e9-4d3f-9ba4-81820adf24e9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e2aae939-84e9-4d3f-9ba4-81820adf24e9')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','9212cc18-f972-45b1-a469-0d46852c1b3b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9212cc18-f972-45b1-a469-0d46852c1b3b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9212cc18-f972-45b1-a469-0d46852c1b3b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','36e1dd03-607c-4242-9686-9b5b6e22f528')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36e1dd03-607c-4242-9686-9b5b6e22f528')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36e1dd03-607c-4242-9686-9b5b6e22f528')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9064e165-427d-4c61-a38c-87f87d175014')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fad221a5-5832-46d1-8fd5-d47b0920740d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f74ad032-06a0-4ad9-8f9b-c36d1227c623')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','27bca94f-f151-4757-a91a-96afd0ae82d2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','708cc39d-9d77-4910-8747-6eda419732ac')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','3010d0c3-9bb8-43a8-a611-38a3cbece8b9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3010d0c3-9bb8-43a8-a611-38a3cbece8b9')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','7a07a34f-d0d5-416a-9c83-6f848771b59a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7a07a34f-d0d5-416a-9c83-6f848771b59a')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','4a446b3d-128a-4797-9c17-cd3305265367')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4a446b3d-128a-4797-9c17-cd3305265367')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','8dc2615e-08c6-4170-a44c-903b710fa1c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8dc2615e-08c6-4170-a44c-903b710fa1c5')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','300a1704-be52-41cc-8027-667d5837bf73')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','300a1704-be52-41cc-8027-667d5837bf73')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','1345d085-1699-4938-8500-250f451fc48f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1345d085-1699-4938-8500-250f451fc48f')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','67850de4-15f2-403e-a703-ecef424583a4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','67850de4-15f2-403e-a703-ecef424583a4')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','ec1e46bc-d1ee-4fd0-8824-2911dfe26d4f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ec1e46bc-d1ee-4fd0-8824-2911dfe26d4f')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','d4639a56-6af7-4f4f-bf46-018193204e33')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d4639a56-6af7-4f4f-bf46-018193204e33')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','f14f76c8-7c32-4236-b49e-15a1c6446765')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f14f76c8-7c32-4236-b49e-15a1c6446765')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','d2255eeb-a45c-4c7a-a643-f91b8bd94a99')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d2255eeb-a45c-4c7a-a643-f91b8bd94a99')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','f101f7bc-51b1-4f54-b5eb-356baeae9218')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f101f7bc-51b1-4f54-b5eb-356baeae9218')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','38583508-8194-453e-a747-7802c432d7d8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','38583508-8194-453e-a747-7802c432d7d8')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','f90c3b6c-e030-4f5e-b470-9e001c65bdcc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f90c3b6c-e030-4f5e-b470-9e001c65bdcc')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','d0e4e122-b7bd-4766-ae51-bafb022608e8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d0e4e122-b7bd-4766-ae51-bafb022608e8')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','843ea8f8-98c8-48d5-8890-004b24b3d9e2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','843ea8f8-98c8-48d5-8890-004b24b3d9e2')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','b6f07dc9-4f14-465c-9445-e8919ac710fd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b6f07dc9-4f14-465c-9445-e8919ac710fd')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','7e3f80b4-2e95-4bb1-b1dc-e6400e4b5434')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7e3f80b4-2e95-4bb1-b1dc-e6400e4b5434')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','4c417198-671a-4a50-8994-beb7886f1b9c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c417198-671a-4a50-8994-beb7886f1b9c')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','37432d4b-ac7e-4da6-b443-1dc4b41f21a6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','37432d4b-ac7e-4da6-b443-1dc4b41f21a6')
,('c7e230da-3c22-4915-9ad9-968f874536a5','b40ebb2c-1bae-4d4e-a35d-fd0afa935d11')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','b40ebb2c-1bae-4d4e-a35d-fd0afa935d11')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b40ebb2c-1bae-4d4e-a35d-fd0afa935d11')
,('ee818f0f-e1cb-45d0-bfab-cd049fd923ba','778a6b00-05f3-40f7-a78f-9f7c0a866d7e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','778a6b00-05f3-40f7-a78f-9f7c0a866d7e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c124c17-557d-4929-a52b-985d242b595e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1c124c17-557d-4929-a52b-985d242b595e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','801517a7-2988-451c-8f81-4dfa104489c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','801517a7-2988-451c-8f81-4dfa104489c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7349cbb8-d403-46f6-aad0-9909405b5555')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7349cbb8-d403-46f6-aad0-9909405b5555')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2d93e4fb-4cdf-42c6-a232-54b503c42cbe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2d93e4fb-4cdf-42c6-a232-54b503c42cbe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2544fbca-25ca-47cc-921a-eecf5a208e0a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2544fbca-25ca-47cc-921a-eecf5a208e0a')
,('5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','57dc9bbe-0272-4d56-b889-68450547d663')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','57dc9bbe-0272-4d56-b889-68450547d663')
,('5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','0956402e-1557-4b1f-b39a-b965a3d14d3b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0956402e-1557-4b1f-b39a-b965a3d14d3b')
,('5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','2d7f61c0-8c26-4d10-b009-81607add484d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2d7f61c0-8c26-4d10-b009-81607add484d')
,('5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','8ea770db-3601-49b7-a40a-f12fe3c66845')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8ea770db-3601-49b7-a40a-f12fe3c66845')
,('5054e7f8-25cc-4f79-ac9b-9cc0d7b39a25','3037fcd0-3861-41a9-8bab-f0fdd7cca9bd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3037fcd0-3861-41a9-8bab-f0fdd7cca9bd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','85d73458-d9de-49e8-8fe5-e280b783d047')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','85d73458-d9de-49e8-8fe5-e280b783d047')
,('81f51ca9-0756-405c-ab5f-5adcaecf9800','42688bb1-49ee-4985-a831-6d8459b58f5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','42688bb1-49ee-4985-a831-6d8459b58f5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b1691e5-7853-43c2-80dc-550c43fa721b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b1691e5-7853-43c2-80dc-550c43fa721b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7650640-7c83-441e-b92d-e3146b660923')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','afee8a16-b3e7-4ebb-84b1-0d2d1414feaf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','afee8a16-b3e7-4ebb-84b1-0d2d1414feaf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c5e1b84-0491-4f42-935e-1053a44c2229')
,('10cedc5f-717a-4800-b837-d250cce7c101','1c5e1b84-0491-4f42-935e-1053a44c2229')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1c5e1b84-0491-4f42-935e-1053a44c2229')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','60304b5a-b514-4fe7-8fb2-ce4cc5c7a3b7')
,('10cedc5f-717a-4800-b837-d250cce7c101','60304b5a-b514-4fe7-8fb2-ce4cc5c7a3b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','60304b5a-b514-4fe7-8fb2-ce4cc5c7a3b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3fc027d5-9e79-4020-a6b2-f5c8ac4de999')
,('10cedc5f-717a-4800-b837-d250cce7c101','3fc027d5-9e79-4020-a6b2-f5c8ac4de999')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3fc027d5-9e79-4020-a6b2-f5c8ac4de999')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a27e7902-441b-45c1-8c3c-b717f30b4df1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a27e7902-441b-45c1-8c3c-b717f30b4df1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','048df4b6-7acd-4186-83cd-a7cbada9a07b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','048df4b6-7acd-4186-83cd-a7cbada9a07b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d17b87ee-cea9-4fd8-a984-243fbb4dcdb5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d17b87ee-cea9-4fd8-a984-243fbb4dcdb5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3ff6deb3-acd7-48ac-a891-7f792cbc9cdf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','047def8d-968e-4fbe-b1e9-078d877aeaee')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','047def8d-968e-4fbe-b1e9-078d877aeaee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','047def8d-968e-4fbe-b1e9-078d877aeaee')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','4d32c06d-b4ed-4719-b682-52ca77bb53ac')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','4d32c06d-b4ed-4719-b682-52ca77bb53ac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4d32c06d-b4ed-4719-b682-52ca77bb53ac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4d32c06d-b4ed-4719-b682-52ca77bb53ac')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','75bbbb5d-0f43-48b9-b9f2-7f305522d3bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','75bbbb5d-0f43-48b9-b9f2-7f305522d3bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','75bbbb5d-0f43-48b9-b9f2-7f305522d3bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8ace6d01-2168-46f1-a47f-df66b52843d9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8ace6d01-2168-46f1-a47f-df66b52843d9')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','8ace6d01-2168-46f1-a47f-df66b52843d9')
,('f17c0261-97fb-428e-885c-7a166e377074','672c3e8f-852b-42af-bd52-fade06f61c56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','672c3e8f-852b-42af-bd52-fade06f61c56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','602b07ad-e5e1-4b49-9cb4-6ed5d2d0d91b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','602b07ad-e5e1-4b49-9cb4-6ed5d2d0d91b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bff267e7-b925-4903-bd1a-a63b45f0cece')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bff267e7-b925-4903-bd1a-a63b45f0cece')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9613de38-bdf5-49d5-adc7-c6282f911b55')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','9613de38-bdf5-49d5-adc7-c6282f911b55')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2be308b2-0265-413d-b6c0-92d8b305b4ec')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','587c0dd3-2a36-4203-930b-6683e82c5106')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d740fb8d-1741-4a86-8999-6a55e97a7765')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d740fb8d-1741-4a86-8999-6a55e97a7765')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1ff3956f-1b17-43b2-a084-858ec3486327')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1ff3956f-1b17-43b2-a084-858ec3486327')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','acb79181-ed60-47d4-a592-75f1e38324c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','acb79181-ed60-47d4-a592-75f1e38324c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','332bee05-01b4-47ec-916b-ab9f798085c5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','332bee05-01b4-47ec-916b-ab9f798085c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5db903d5-347c-41f4-8449-97cf8587bde1')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','5db903d5-347c-41f4-8449-97cf8587bde1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5db903d5-347c-41f4-8449-97cf8587bde1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab755d9f-ba91-4466-a709-ceef9014fc70')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','ab755d9f-ba91-4466-a709-ceef9014fc70')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ab755d9f-ba91-4466-a709-ceef9014fc70')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','46608bce-ac13-4578-9a30-68a53e16886a')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','46608bce-ac13-4578-9a30-68a53e16886a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','46608bce-ac13-4578-9a30-68a53e16886a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ac102946-485a-4835-bc58-9690bcc775ff')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','ac102946-485a-4835-bc58-9690bcc775ff')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ac102946-485a-4835-bc58-9690bcc775ff')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f00a7ca2-a577-46c7-93dd-df554e2edab5')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','f00a7ca2-a577-46c7-93dd-df554e2edab5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f00a7ca2-a577-46c7-93dd-df554e2edab5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ef04cda-006d-43b9-a3f2-9224038ff8f5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ef04cda-006d-43b9-a3f2-9224038ff8f5')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','2ef04cda-006d-43b9-a3f2-9224038ff8f5')
,('8f816264-0682-4b77-888e-dec7441f4477','2ef04cda-006d-43b9-a3f2-9224038ff8f5')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','f696678b-a9c7-456d-878c-5a2c52dffa0c')
,('8f816264-0682-4b77-888e-dec7441f4477','f696678b-a9c7-456d-878c-5a2c52dffa0c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0a9598cc-3f03-4bb5-b1a7-0e13d3573ca8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0a9598cc-3f03-4bb5-b1a7-0e13d3573ca8')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','0a9598cc-3f03-4bb5-b1a7-0e13d3573ca8')
,('8f816264-0682-4b77-888e-dec7441f4477','0a9598cc-3f03-4bb5-b1a7-0e13d3573ca8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1aac6150-9d4e-44bc-b01f-63cbc1132f39')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1aac6150-9d4e-44bc-b01f-63cbc1132f39')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','1aac6150-9d4e-44bc-b01f-63cbc1132f39')
,('8f816264-0682-4b77-888e-dec7441f4477','1aac6150-9d4e-44bc-b01f-63cbc1132f39')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','519b6e05-00de-46f0-9521-844de0123f9d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5024db42-bd20-4c1a-b461-6327c2c8a74a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2122f45a-9005-40d8-b57a-f6f7894cf32c')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','2122f45a-9005-40d8-b57a-f6f7894cf32c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2122f45a-9005-40d8-b57a-f6f7894cf32c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','847c08b9-328c-4003-a14f-1ff6ce66876a')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','847c08b9-328c-4003-a14f-1ff6ce66876a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','140bf3eb-79c7-4c92-bb71-f3f64e82d23f')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','140bf3eb-79c7-4c92-bb71-f3f64e82d23f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','140bf3eb-79c7-4c92-bb71-f3f64e82d23f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','32749498-a84f-4330-8bbc-6a28d52d57e5')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','32749498-a84f-4330-8bbc-6a28d52d57e5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','32749498-a84f-4330-8bbc-6a28d52d57e5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9cca22b1-a343-4ae7-98ac-d0cc2d7d1b33')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','9cca22b1-a343-4ae7-98ac-d0cc2d7d1b33')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9cca22b1-a343-4ae7-98ac-d0cc2d7d1b33')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d60c8985-9ced-447f-87c0-de3f2a2b1629')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','d60c8985-9ced-447f-87c0-de3f2a2b1629')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d60c8985-9ced-447f-87c0-de3f2a2b1629')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ad9e953-27a1-4c58-9043-b663cce480dc')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','0ad9e953-27a1-4c58-9043-b663cce480dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ad9e953-27a1-4c58-9043-b663cce480dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ff9aa764-394f-4eb9-9b86-85336613cedf')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','ff9aa764-394f-4eb9-9b86-85336613cedf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ff9aa764-394f-4eb9-9b86-85336613cedf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fef54cfe-f727-4802-b212-0d902363d8b8')
,('372d22f7-9309-4327-8a3c-65e7cb5f6e9d','780a3157-1335-453e-bb2a-7348e2455578')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','780a3157-1335-453e-bb2a-7348e2455578')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','780a3157-1335-453e-bb2a-7348e2455578')
,('9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','780a3157-1335-453e-bb2a-7348e2455578')
,('372d22f7-9309-4327-8a3c-65e7cb5f6e9d','65e5fd6f-d4e4-44a1-a252-3a46288bebed')
,('9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','65e5fd6f-d4e4-44a1-a252-3a46288bebed')
,('372d22f7-9309-4327-8a3c-65e7cb5f6e9d','f5b3f22e-5b73-4d26-8479-a1e4120da830')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f5b3f22e-5b73-4d26-8479-a1e4120da830')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f5b3f22e-5b73-4d26-8479-a1e4120da830')
,('9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','f5b3f22e-5b73-4d26-8479-a1e4120da830')
,('372d22f7-9309-4327-8a3c-65e7cb5f6e9d','7979c159-3ded-4c52-9fc7-a54f8682e1b9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7979c159-3ded-4c52-9fc7-a54f8682e1b9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7979c159-3ded-4c52-9fc7-a54f8682e1b9')
,('9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','7979c159-3ded-4c52-9fc7-a54f8682e1b9')
,('372d22f7-9309-4327-8a3c-65e7cb5f6e9d','f6ec1011-0508-4592-974d-6948e9252438')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f6ec1011-0508-4592-974d-6948e9252438')
,('9f2eddd8-eee8-4e92-9d54-af5d4fcfcdc1','f6ec1011-0508-4592-974d-6948e9252438')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4690cf5-e3e8-4d7b-9205-1d0e5ee9b7bb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a4690cf5-e3e8-4d7b-9205-1d0e5ee9b7bb')
,('64825d27-435c-408f-abc7-e883b44a1c99','a4690cf5-e3e8-4d7b-9205-1d0e5ee9b7bb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ea41166-4fcd-4a3a-9f8f-46c28dddf11a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ea41166-4fcd-4a3a-9f8f-46c28dddf11a')
,('64825d27-435c-408f-abc7-e883b44a1c99','0ea41166-4fcd-4a3a-9f8f-46c28dddf11a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fd9ca397-53d3-4be7-a30c-b1454c82eb60')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fd9ca397-53d3-4be7-a30c-b1454c82eb60')
,('64825d27-435c-408f-abc7-e883b44a1c99','fd9ca397-53d3-4be7-a30c-b1454c82eb60')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15d4bec6-2d0e-4fed-850f-af290617960f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','15d4bec6-2d0e-4fed-850f-af290617960f')
,('64825d27-435c-408f-abc7-e883b44a1c99','15d4bec6-2d0e-4fed-850f-af290617960f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','56c2618d-7f56-42d7-b502-f3a098c42cda')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','56c2618d-7f56-42d7-b502-f3a098c42cda')
,('64825d27-435c-408f-abc7-e883b44a1c99','56c2618d-7f56-42d7-b502-f3a098c42cda')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','18591071-e664-4f68-8e87-c3c3d5169fc3')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','18591071-e664-4f68-8e87-c3c3d5169fc3')
,('0fd91106-bcc8-4ed3-aedd-f5b31159952d','18591071-e664-4f68-8e87-c3c3d5169fc3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','18591071-e664-4f68-8e87-c3c3d5169fc3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','72639ece-46b5-4cd2-b3ec-4d5ec63fc943')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','72639ece-46b5-4cd2-b3ec-4d5ec63fc943')
,('0fd91106-bcc8-4ed3-aedd-f5b31159952d','72639ece-46b5-4cd2-b3ec-4d5ec63fc943')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','72639ece-46b5-4cd2-b3ec-4d5ec63fc943')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f8932e87-18d1-4a93-8bd9-d593ac63bd68')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','f8932e87-18d1-4a93-8bd9-d593ac63bd68')
,('0fd91106-bcc8-4ed3-aedd-f5b31159952d','f8932e87-18d1-4a93-8bd9-d593ac63bd68')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f8932e87-18d1-4a93-8bd9-d593ac63bd68')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','03f59c9e-c74c-4336-917f-df39174715b7')
,('35c03704-58f7-4a6d-80ae-8a3ac8b9823d','03f59c9e-c74c-4336-917f-df39174715b7')
,('0fd91106-bcc8-4ed3-aedd-f5b31159952d','03f59c9e-c74c-4336-917f-df39174715b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','03f59c9e-c74c-4336-917f-df39174715b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d6b8a2f4-d0fe-41c0-b224-3d38d29f8117')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a795e1e2-5f6a-4443-af79-06ca67a95d54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dd2dea2e-2d51-4cd8-88cd-eaea98b611bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1db047dc-84bf-47c8-bdb7-5b2b8757fd30')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5f73572a-3e49-4255-85df-13db1f3f02d2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5f73572a-3e49-4255-85df-13db1f3f02d2')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','5f73572a-3e49-4255-85df-13db1f3f02d2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','576ffd09-64f5-4742-a197-8c0f47ce1d2b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','576ffd09-64f5-4742-a197-8c0f47ce1d2b')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','576ffd09-64f5-4742-a197-8c0f47ce1d2b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6b5fb874-8dd9-4a68-8499-5d47a2a4999e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6b5fb874-8dd9-4a68-8499-5d47a2a4999e')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','6b5fb874-8dd9-4a68-8499-5d47a2a4999e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7cb1de7-70b9-4f8e-8e41-97b67e139c87')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7cb1de7-70b9-4f8e-8e41-97b67e139c87')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','a7cb1de7-70b9-4f8e-8e41-97b67e139c87')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b5aa8666-80bb-4256-83a6-3c6539ccc2c2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b5aa8666-80bb-4256-83a6-3c6539ccc2c2')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','b5aa8666-80bb-4256-83a6-3c6539ccc2c2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65435a1d-268a-4b69-aecd-39ff831d8f47')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','65435a1d-268a-4b69-aecd-39ff831d8f47')
,('70f129e3-3b50-4dd6-bd00-87963cb0b902','65435a1d-268a-4b69-aecd-39ff831d8f47')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3931112e-e504-4c35-bc6b-b96e1d73af16')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','3931112e-e504-4c35-bc6b-b96e1d73af16')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cf764d7a-520a-4718-8dc7-37b9d0ae7e61')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','cf764d7a-520a-4718-8dc7-37b9d0ae7e61')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e0e46317-a061-4227-9982-df4456e7958c')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','e0e46317-a061-4227-9982-df4456e7958c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8b41bedf-677e-49f4-9b63-8003120f9298')
,('b0443218-47e1-4b2d-b4fb-1272a39b8499','8b41bedf-677e-49f4-9b63-8003120f9298')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','94083df0-10a9-4ea2-9965-400b53e70502')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','94083df0-10a9-4ea2-9965-400b53e70502')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','94083df0-10a9-4ea2-9965-400b53e70502')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','94083df0-10a9-4ea2-9965-400b53e70502')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','27924fd7-3fa4-4526-bc3e-ccd627fb8eec')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','27924fd7-3fa4-4526-bc3e-ccd627fb8eec')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','a5e7c21b-dbc0-4084-9ff2-3ed205fcfb93')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','a5e7c21b-dbc0-4084-9ff2-3ed205fcfb93')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5e7c21b-dbc0-4084-9ff2-3ed205fcfb93')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a5e7c21b-dbc0-4084-9ff2-3ed205fcfb93')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','1a473dee-cef0-47a8-ba81-4b61aa31b219')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','1a473dee-cef0-47a8-ba81-4b61aa31b219')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1a473dee-cef0-47a8-ba81-4b61aa31b219')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1a473dee-cef0-47a8-ba81-4b61aa31b219')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','6712cb02-0311-478e-b30b-b47c24d30462')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','6712cb02-0311-478e-b30b-b47c24d30462')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6712cb02-0311-478e-b30b-b47c24d30462')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6712cb02-0311-478e-b30b-b47c24d30462')
,('f17c0261-97fb-428e-885c-7a166e377074','7ab3df4c-b8d0-44a9-b37b-e6f3df450b08')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ab3df4c-b8d0-44a9-b37b-e6f3df450b08')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7ab3df4c-b8d0-44a9-b37b-e6f3df450b08')
,('f17c0261-97fb-428e-885c-7a166e377074','cab38c5a-b643-46ae-a1aa-0296d422c96c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cab38c5a-b643-46ae-a1aa-0296d422c96c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cab38c5a-b643-46ae-a1aa-0296d422c96c')
,('f17c0261-97fb-428e-885c-7a166e377074','3dc4a434-8427-4825-97b5-10ea6c8357d8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3dc4a434-8427-4825-97b5-10ea6c8357d8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3dc4a434-8427-4825-97b5-10ea6c8357d8')
,('f17c0261-97fb-428e-885c-7a166e377074','b9c260b8-568a-4d04-887a-00b6d283d695')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9c260b8-568a-4d04-887a-00b6d283d695')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9c260b8-568a-4d04-887a-00b6d283d695')
,('f17c0261-97fb-428e-885c-7a166e377074','92ccf408-83c6-4e20-8f20-94a61869f378')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','92ccf408-83c6-4e20-8f20-94a61869f378')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','92ccf408-83c6-4e20-8f20-94a61869f378')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0a1735f2-250a-4eb9-b3c9-566f25443a57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0a1735f2-250a-4eb9-b3c9-566f25443a57')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','0a1735f2-250a-4eb9-b3c9-566f25443a57')
,('8f816264-0682-4b77-888e-dec7441f4477','0a1735f2-250a-4eb9-b3c9-566f25443a57')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','175482d2-7175-4dcf-ba02-b07725d82d75')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','175482d2-7175-4dcf-ba02-b07725d82d75')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','175482d2-7175-4dcf-ba02-b07725d82d75')
,('8f816264-0682-4b77-888e-dec7441f4477','175482d2-7175-4dcf-ba02-b07725d82d75')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','26f67110-abe9-423a-8812-989242d043e5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','26f67110-abe9-423a-8812-989242d043e5')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','26f67110-abe9-423a-8812-989242d043e5')
,('8f816264-0682-4b77-888e-dec7441f4477','26f67110-abe9-423a-8812-989242d043e5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f4827d8d-fa99-48ff-bc20-b912e8381a9e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f4827d8d-fa99-48ff-bc20-b912e8381a9e')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','f4827d8d-fa99-48ff-bc20-b912e8381a9e')
,('8f816264-0682-4b77-888e-dec7441f4477','f4827d8d-fa99-48ff-bc20-b912e8381a9e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a764b439-8c2c-4a9a-b8dc-e829190e6f9a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5c76d73c-4360-4b7f-919e-a56129d87af4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','082d1435-63d6-43eb-84a1-8daa5de9bdb1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9660fd65-d071-492b-b3a1-d0ab5a9f9568')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9660fd65-d071-492b-b3a1-d0ab5a9f9568')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e1d86478-c0a7-4797-b636-7a0560c6770d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e1d86478-c0a7-4797-b636-7a0560c6770d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','213962f1-e879-4c61-a487-bd1102ca5072')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','213962f1-e879-4c61-a487-bd1102ca5072')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4604e06e-6e4e-4594-821f-06f8d2bc6a67')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4604e06e-6e4e-4594-821f-06f8d2bc6a67')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ffc9b543-c4e7-4835-a60a-7d21340b3ec1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ffc9b543-c4e7-4835-a60a-7d21340b3ec1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f56be3d-30dc-4895-bb02-bebdc38c1aaf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9f56be3d-30dc-4895-bb02-bebdc38c1aaf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','004300ad-dfff-4c96-ac15-77d38f04c2dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','004300ad-dfff-4c96-ac15-77d38f04c2dd')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','77c7bd31-1411-4eb0-97b2-db9c7d614ff3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','77c7bd31-1411-4eb0-97b2-db9c7d614ff3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','77c7bd31-1411-4eb0-97b2-db9c7d614ff3')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','8688eb25-0f5f-48c5-af83-83407aca9658')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8688eb25-0f5f-48c5-af83-83407aca9658')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8688eb25-0f5f-48c5-af83-83407aca9658')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','089af2e9-8b31-454c-9fa6-4662b1d76f43')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','089af2e9-8b31-454c-9fa6-4662b1d76f43')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','089af2e9-8b31-454c-9fa6-4662b1d76f43')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','a0797316-15f8-4138-acd6-10df2ae81bb6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a0797316-15f8-4138-acd6-10df2ae81bb6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a0797316-15f8-4138-acd6-10df2ae81bb6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15313ec8-0e4c-4504-a7ae-75d9dc0a5796')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','15313ec8-0e4c-4504-a7ae-75d9dc0a5796')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f8600c34-4966-4666-8a94-0a2a10274e94')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f9134e81-1d91-420e-b1ac-4d1f232e3a56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c6de4f9c-930c-460f-a2a1-f8a1b2534e08')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dc18f57b-0788-4254-b943-9cad2cee7bf7')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','140b77e8-1b81-40a6-8f2a-48089f3d718e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','140b77e8-1b81-40a6-8f2a-48089f3d718e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','140b77e8-1b81-40a6-8f2a-48089f3d718e')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','75f9d745-e6db-4c41-9dea-047ecbcec634')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','75f9d745-e6db-4c41-9dea-047ecbcec634')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','75f9d745-e6db-4c41-9dea-047ecbcec634')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','77614fbf-34d5-49c7-8390-9a45c2d2bd54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','77614fbf-34d5-49c7-8390-9a45c2d2bd54')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','77614fbf-34d5-49c7-8390-9a45c2d2bd54')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','fcfe6d51-2420-4cda-8cb7-955a12818c21')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fcfe6d51-2420-4cda-8cb7-955a12818c21')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fcfe6d51-2420-4cda-8cb7-955a12818c21')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','5d036dfa-edfb-45c7-9a46-421dc6dca27f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5d036dfa-edfb-45c7-9a46-421dc6dca27f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5d036dfa-edfb-45c7-9a46-421dc6dca27f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36aafda0-0c5b-4196-bfad-d213ae6d3b4f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3c3d5e2e-fd1d-4aa9-8495-f0730397eb6b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','32d86397-c809-4a5e-a538-cffb32b3cedf')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','32d86397-c809-4a5e-a538-cffb32b3cedf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c63f5b71-7a20-4ca5-91dc-e53ae2a5a9e4')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','c63f5b71-7a20-4ca5-91dc-e53ae2a5a9e4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','db6931c1-1593-4dca-9d4d-db307e8d77e1')
,('3d141fff-3d6f-4f4f-8016-d8bd7a3316f9','db6931c1-1593-4dca-9d4d-db307e8d77e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','81fe12fd-7852-4b0f-8aad-a6a788a5cfd1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d7c2e770-655f-4228-b4c2-24352ab78c53')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ef6ba967-ebcc-4375-bd30-8acbd51e2ea7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ad0d0b5-9067-4619-b204-9b322e9c4532')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e1f9120e-6c8c-4375-86cd-e03eeed160f9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89002513-aab3-4b83-920b-65d3290b4c61')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5ab21afe-5f82-40c6-ba24-8d5b83c22c0e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','34673b76-41b0-4b6d-8995-a550f50df107')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cf2f572c-d7e8-4d48-8601-fe2c5d59b1bd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dfe21262-e16b-4906-9e6f-18283b8900db')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7e99b51f-9576-4d54-8f2a-cd8e3570ee7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b14ff05d-d28b-4d1e-bc65-ea081a31af3c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8a40a23d-1986-45a5-8c34-d355d9ccb65b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6eb4e753-4f26-4611-884f-b09411ace070')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fc0ccb9c-9581-43d8-97d8-1a2e6d280976')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fc0ccb9c-9581-43d8-97d8-1a2e6d280976')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1a595ba2-88f9-4c5c-979f-bffd0d8dc731')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d97ec2ae-5ef7-43fe-91bc-7e82c864a735')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f2fab4a7-eac6-4c5c-b3cf-0fe153876542')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','787a1f85-4e75-4f6a-8aa0-fb28584f1187')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8a1c0fb0-2f7c-482f-9195-090a21ac3fce')
,('17949107-a0d3-42da-997c-5b70f0831444','d58e0092-8d73-4609-85c2-33c6fdc8361d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d58e0092-8d73-4609-85c2-33c6fdc8361d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','459e4629-0598-40f9-aae3-853a4889f8e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','85995314-e80b-4aea-9943-e740d7ad6457')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','593b6031-97f4-4dba-80e5-87a52cb5ef6b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d4271b11-3cab-4e0a-b3ab-24835ddf9dff')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','01c1b93b-e0db-48b1-b20c-0854b07ebfac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','227798ff-0062-4faa-aafe-7e573fd51012')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','272ae4e0-2046-4521-b401-eacf42693ddb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','272ae4e0-2046-4521-b401-eacf42693ddb')
,('10cedc5f-717a-4800-b837-d250cce7c101','6cbdd6d9-2eaa-4202-937d-0ca989292b4e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6cbdd6d9-2eaa-4202-937d-0ca989292b4e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','32ab0792-e3f2-49a0-bf90-82ef7c3f236b')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','32ab0792-e3f2-49a0-bf90-82ef7c3f236b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','32ab0792-e3f2-49a0-bf90-82ef7c3f236b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2102bf80-ae87-4187-8314-59dcbdd439a2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d6cce34-11dc-4e77-841d-b802a62254b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df8e05dc-ccec-4ea9-adaa-65aff12a5e8b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3ff07dbd-7de8-437a-b408-918e3883fd18')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','3ff07dbd-7de8-437a-b408-918e3883fd18')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3ff07dbd-7de8-437a-b408-918e3883fd18')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','67a02f17-10c6-437f-a956-86fe88c6b265')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','67a02f17-10c6-437f-a956-86fe88c6b265')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','67a02f17-10c6-437f-a956-86fe88c6b265')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c85dcf16-4c11-48a0-a6bc-41c7fdcc3770')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','c85dcf16-4c11-48a0-a6bc-41c7fdcc3770')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c85dcf16-4c11-48a0-a6bc-41c7fdcc3770')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','79a42a3c-fac5-4a39-8d89-0afea7df2fe7')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','c4f12734-f52d-4e26-a59c-f7d71b77b583')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a2d2206f-9036-4914-a4f6-ffa155c452ee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','30c22e67-8adb-4def-b80c-4c1a05c14a9c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e1bb91fa-3a67-42e6-b48b-365a354850a1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7e162298-d505-4cdc-a869-7fbaa81f981d')
,('5f6476fc-4170-418c-84fb-d90f638fd6d1','57f943f6-187c-4fdd-bedd-30f0b18dbf0e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','57f943f6-187c-4fdd-bedd-30f0b18dbf0e')
,('10cedc5f-717a-4800-b837-d250cce7c101','7f486ae9-b3f2-4c4c-9a4b-5ce3ba68295b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7f486ae9-b3f2-4c4c-9a4b-5ce3ba68295b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5a5bffcb-c7d9-4bda-b242-cf77fe183584')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5a5bffcb-c7d9-4bda-b242-cf77fe183584')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','110dcf05-2b90-47c8-b00f-6a34b756ece1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','110dcf05-2b90-47c8-b00f-6a34b756ece1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c0227c7-1d9a-4417-9789-b121fdfa9c28')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c0227c7-1d9a-4417-9789-b121fdfa9c28')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e9be81f6-4423-4865-bec7-e4dbcf1d97eb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e9be81f6-4423-4865-bec7-e4dbcf1d97eb')
,('9fbf6ee7-8258-42ff-b771-21a2b09d17c8','0169c590-fd6f-4b54-b2ae-5e93fde568ae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0169c590-fd6f-4b54-b2ae-5e93fde568ae')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0169c590-fd6f-4b54-b2ae-5e93fde568ae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d2a764ec-d1a0-4e45-8709-8d765c904317')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7dccb013-4376-4572-b8de-6264781c0177')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','26093fce-6e5c-4f4f-90ec-5e5930403d0c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','26093fce-6e5c-4f4f-90ec-5e5930403d0c')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','26093fce-6e5c-4f4f-90ec-5e5930403d0c')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','d7d47ac1-e55a-4d8d-86bf-ac66246cf818')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d7d47ac1-e55a-4d8d-86bf-ac66246cf818')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','d7d47ac1-e55a-4d8d-86bf-ac66246cf818')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','a24f904d-f34e-4055-ad16-ca6eff0f7afd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a24f904d-f34e-4055-ad16-ca6eff0f7afd')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','a24f904d-f34e-4055-ad16-ca6eff0f7afd')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','45630d29-df7c-4e2b-aac6-65111e542e40')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','45630d29-df7c-4e2b-aac6-65111e542e40')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','45630d29-df7c-4e2b-aac6-65111e542e40')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','45630d29-df7c-4e2b-aac6-65111e542e40')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a30f9304-d823-48b9-addc-418086d28bee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ddee36b0-ea97-466b-866b-bcf5d653fb06')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2b51db88-0c57-438a-b5cd-0426a4fc2fe4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2b51db88-0c57-438a-b5cd-0426a4fc2fe4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aabf14de-6526-41b3-b5a7-f38bd4dff3b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aabf14de-6526-41b3-b5a7-f38bd4dff3b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','947087d2-7c57-47f0-b07b-952ee9c53b4a')
,('17949107-a0d3-42da-997c-5b70f0831444','6ffd0843-a501-43b9-8092-3a8cfd6bf02c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ffd0843-a501-43b9-8092-3a8cfd6bf02c')
,('17949107-a0d3-42da-997c-5b70f0831444','29feb905-9eb5-46d2-97ea-b4c86b657caa')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','29feb905-9eb5-46d2-97ea-b4c86b657caa')
,('17949107-a0d3-42da-997c-5b70f0831444','7d4d12e4-07be-4424-bc0f-910dcfa4406a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7d4d12e4-07be-4424-bc0f-910dcfa4406a')
,('17949107-a0d3-42da-997c-5b70f0831444','430b2803-fcd5-44b4-809f-1ae5dece077a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','430b2803-fcd5-44b4-809f-1ae5dece077a')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','669ad6b3-024c-476f-98fa-3827242b3a4e')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','669ad6b3-024c-476f-98fa-3827242b3a4e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','669ad6b3-024c-476f-98fa-3827242b3a4e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','669ad6b3-024c-476f-98fa-3827242b3a4e')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','31f4b2d1-859b-49f6-ac3a-05fb5581c49b')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','31f4b2d1-859b-49f6-ac3a-05fb5581c49b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31f4b2d1-859b-49f6-ac3a-05fb5581c49b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31f4b2d1-859b-49f6-ac3a-05fb5581c49b')
,('aa293ac1-cbf3-47de-aa2e-fa4c9d575bef','e4fba063-061a-44af-9db3-b4342c2e18b4')
,('6458b11b-b13f-414f-a9e9-6d5a5552275b','e4fba063-061a-44af-9db3-b4342c2e18b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4fba063-061a-44af-9db3-b4342c2e18b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e4fba063-061a-44af-9db3-b4342c2e18b4')
,('517477d3-2d79-494d-a8ca-b1da9a1f19ca','109387dc-7686-4aed-ba20-47dcf512eae5')
,('10cedc5f-717a-4800-b837-d250cce7c101','109387dc-7686-4aed-ba20-47dcf512eae5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4cf5d7a-d765-4604-bbe6-3abb7a73e99a')
,('10cedc5f-717a-4800-b837-d250cce7c101','a4cf5d7a-d765-4604-bbe6-3abb7a73e99a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','10879ca0-f36a-4479-9fef-2b47e89bccc9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','10879ca0-f36a-4479-9fef-2b47e89bccc9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b64ef1e5-ecc6-4ead-ae72-a54309a0d168')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b64ef1e5-ecc6-4ead-ae72-a54309a0d168')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0793428-143d-4f16-b374-3ec5bd45881c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0793428-143d-4f16-b374-3ec5bd45881c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0186dba4-f445-4078-88f9-ddbf0bd8a62c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0186dba4-f445-4078-88f9-ddbf0bd8a62c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','83015a3c-e350-42c9-8e0b-8224a5d8c67e')
,('10cedc5f-717a-4800-b837-d250cce7c101','83015a3c-e350-42c9-8e0b-8224a5d8c67e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','83015a3c-e350-42c9-8e0b-8224a5d8c67e')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','268709ca-7cf5-4022-b699-f5cda40e8994')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','268709ca-7cf5-4022-b699-f5cda40e8994')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','268709ca-7cf5-4022-b699-f5cda40e8994')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','268709ca-7cf5-4022-b699-f5cda40e8994')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9debe10e-8dd7-4de9-b43d-4a0f95a6d326')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','219464a6-f49c-4741-8ce6-29f795ab872c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','582594ff-749d-4c46-9bcd-3e25d7452f17')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','01aae9ef-afba-4ccb-8af5-3a761b50f71e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','71acc5c6-eb2f-43f9-b497-ef2b3bfb1c53')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','71acc5c6-eb2f-43f9-b497-ef2b3bfb1c53')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a0885b22-00d4-4f8f-b167-d688e0aa92f8')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','a0885b22-00d4-4f8f-b167-d688e0aa92f8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','28a6b79f-b351-448a-88f5-6b9dce6cc0d2')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','28a6b79f-b351-448a-88f5-6b9dce6cc0d2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8d2a4fe-8687-4448-b3d9-4bed54030581')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','c8d2a4fe-8687-4448-b3d9-4bed54030581')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d82ca4d0-671f-4a69-9604-99b5bfdff391')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d82ca4d0-671f-4a69-9604-99b5bfdff391')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee7686aa-167a-4ab2-bbf8-03480159928b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee7686aa-167a-4ab2-bbf8-03480159928b')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','dac177dc-9cfc-4333-bf14-194bc70b28ed')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dac177dc-9cfc-4333-bf14-194bc70b28ed')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','dac177dc-9cfc-4333-bf14-194bc70b28ed')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dac177dc-9cfc-4333-bf14-194bc70b28ed')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ffc1647-0314-4d79-8633-fa895e9fac63')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ffc1647-0314-4d79-8633-fa895e9fac63')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ab6acb0-ea98-4366-a60d-52e494e4d066')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ab6acb0-ea98-4366-a60d-52e494e4d066')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','582e542e-9369-4979-bc2c-4a95fa0e3887')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','582e542e-9369-4979-bc2c-4a95fa0e3887')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2aba0d84-b16d-4706-a008-27d6b3a36c56')
,('bc2d7f80-422d-45a6-ab28-77ac441a63c4','2aba0d84-b16d-4706-a008-27d6b3a36c56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d41a27a6-f7b8-4463-8cfc-e086ed434960')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d41a27a6-f7b8-4463-8cfc-e086ed434960')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2684a582-cd47-43bc-8f9f-d3b157081639')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4b575d4-7b1b-4df6-aed0-e57e89e83113')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f0dc5f63-9238-4404-92be-17103d0a97a2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4f00cf3c-dec6-4e0a-a9dc-065df49f8934')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4f00cf3c-dec6-4e0a-a9dc-065df49f8934')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','95218485-04fe-429f-8c2f-16473a914b91')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95218485-04fe-429f-8c2f-16473a914b91')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','f0fa7e48-09a5-4fa2-b24d-032def26ec4d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f0fa7e48-09a5-4fa2-b24d-032def26ec4d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f0fa7e48-09a5-4fa2-b24d-032def26ec4d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d6f3904b-cabb-42d0-a49c-2fd35506e68d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5eb5663b-8763-44c0-adcf-aa3625de7404')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','38872ddd-bfbc-4879-a41a-4d412d833aeb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d9380c02-6f0e-4b55-889e-bb1346f13640')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d9380c02-6f0e-4b55-889e-bb1346f13640')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6b1690f2-fa1e-4307-a306-e70dd497c1e8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6b1690f2-fa1e-4307-a306-e70dd497c1e8')
,('6d091762-f46c-416d-918f-ae79abe71255','7b5d8472-fa12-4ca7-9a40-a484d93339dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b5d8472-fa12-4ca7-9a40-a484d93339dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7b5d8472-fa12-4ca7-9a40-a484d93339dc')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','c422f1c8-aae3-4fbb-be4f-6585fe68eba9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c422f1c8-aae3-4fbb-be4f-6585fe68eba9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c422f1c8-aae3-4fbb-be4f-6585fe68eba9')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','d1bcaef3-2980-47c6-b4e0-74c5fac9a15c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d1bcaef3-2980-47c6-b4e0-74c5fac9a15c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d1bcaef3-2980-47c6-b4e0-74c5fac9a15c')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','32bc5a24-5ae4-4489-b882-a879768efb99')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','32bc5a24-5ae4-4489-b882-a879768efb99')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','6ca8597f-83e1-4846-9ad8-333cd1bb2f23')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ca8597f-83e1-4846-9ad8-333cd1bb2f23')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','e8c22852-2ff2-4067-a010-a83709f7992d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e8c22852-2ff2-4067-a010-a83709f7992d')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','a294ef15-279f-4198-856f-a30712203690')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a294ef15-279f-4198-856f-a30712203690')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','977e85a9-3fb0-4806-badb-ba05e854c59e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','977e85a9-3fb0-4806-badb-ba05e854c59e')
,('eb2b00dc-23f3-4e11-9fc9-1649f318061a','1a7c0fcd-ec7d-4cde-b4c7-4f4456606c69')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1a7c0fcd-ec7d-4cde-b4c7-4f4456606c69')
,('f1c7bc64-98ae-453d-8c3e-8ace35c4de67','1a7c0fcd-ec7d-4cde-b4c7-4f4456606c69')
,('17949107-a0d3-42da-997c-5b70f0831444','ddd8fd90-018e-4c07-a4f3-e014e9bccc76')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ddd8fd90-018e-4c07-a4f3-e014e9bccc76')
,('17949107-a0d3-42da-997c-5b70f0831444','6c8f6f6e-a154-493f-b6d2-aa6686d30221')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c8f6f6e-a154-493f-b6d2-aa6686d30221')
,('17949107-a0d3-42da-997c-5b70f0831444','6631997d-eed8-4a9b-a72c-3f5770e95a20')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6631997d-eed8-4a9b-a72c-3f5770e95a20')
,('17949107-a0d3-42da-997c-5b70f0831444','b555bb6c-01ee-4403-b4fe-becccfa15272')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b555bb6c-01ee-4403-b4fe-becccfa15272')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5f78bf16-f4c8-4234-9777-37db628c9a23')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5f78bf16-f4c8-4234-9777-37db628c9a23')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aa3f29aa-2f37-4c37-a8e2-b280e30a6d82')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa3f29aa-2f37-4c37-a8e2-b280e30a6d82')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e2e9c8d-3316-4199-98b3-8b27ffe83aa0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e2e9c8d-3316-4199-98b3-8b27ffe83aa0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','80b921e6-a1a9-4815-b8d3-273cf12ee1e5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','80b921e6-a1a9-4815-b8d3-273cf12ee1e5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36aaa7ac-c8a1-4205-a279-97fb3769eee9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36aaa7ac-c8a1-4205-a279-97fb3769eee9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6db52112-0d64-4e75-9978-9bde38527c9e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6db52112-0d64-4e75-9978-9bde38527c9e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b1aeaa27-0333-485b-8617-b254c782181b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b1aeaa27-0333-485b-8617-b254c782181b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ff65238-ea72-4562-9845-1d44a41acb55')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7ff65238-ea72-4562-9845-1d44a41acb55')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6a93a213-a6c4-4ecc-8096-977603e022b2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6a93a213-a6c4-4ecc-8096-977603e022b2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e10ca709-6ec8-46ae-a987-ed2025b29c7c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e10ca709-6ec8-46ae-a987-ed2025b29c7c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d4c36fd-5efd-428a-b9a9-bb915df8e7d8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3d4c36fd-5efd-428a-b9a9-bb915df8e7d8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','faa29ed0-0def-471b-8994-7ba3b7488db4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','faa29ed0-0def-471b-8994-7ba3b7488db4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ae464ff4-5321-4206-9380-5d90cc7d8658')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ae464ff4-5321-4206-9380-5d90cc7d8658')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','823ccb4f-4e43-42e9-bdcb-958767698637')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','823ccb4f-4e43-42e9-bdcb-958767698637')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36101bf6-926b-4453-aa20-e5e0a089c010')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','36101bf6-926b-4453-aa20-e5e0a089c010')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb3cf373-50ae-44d2-8660-30d159c4d526')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cb3cf373-50ae-44d2-8660-30d159c4d526')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8a3130f9-25ca-4cde-9ee0-b3d578180fe9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8a3130f9-25ca-4cde-9ee0-b3d578180fe9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31ad8305-1fb3-4732-9f8b-5a0fc5651b76')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31ad8305-1fb3-4732-9f8b-5a0fc5651b76')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','afa46d6f-f26b-4ba2-98b2-d7369e56bdf8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','afa46d6f-f26b-4ba2-98b2-d7369e56bdf8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e05fb5f-7dc4-4275-9b42-44ba6aabd3dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e05fb5f-7dc4-4275-9b42-44ba6aabd3dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e3371aa3-701c-4798-9b18-faa757b1a5aa')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e3371aa3-701c-4798-9b18-faa757b1a5aa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d4cb02fd-4950-4312-a12c-9a37f16d1ff8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d4cb02fd-4950-4312-a12c-9a37f16d1ff8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d81e4574-777e-4799-814a-bfa2f8ca14e3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d81e4574-777e-4799-814a-bfa2f8ca14e3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e065c6a-6ba5-4107-8650-5808bfc7f418')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e065c6a-6ba5-4107-8650-5808bfc7f418')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4faea40-80dc-4d62-8338-0e205ab20d85')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a4faea40-80dc-4d62-8338-0e205ab20d85')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','46c148d7-f755-4bad-84e7-b85a5e8a3aa2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','46c148d7-f755-4bad-84e7-b85a5e8a3aa2')
,('17949107-a0d3-42da-997c-5b70f0831444','6a8e703a-e16c-4388-b567-d2eed3aa691b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6a8e703a-e16c-4388-b567-d2eed3aa691b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6a8e703a-e16c-4388-b567-d2eed3aa691b')
,('17949107-a0d3-42da-997c-5b70f0831444','d3f96c53-22c6-40d3-abee-adc7f6d41b28')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3f96c53-22c6-40d3-abee-adc7f6d41b28')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d3f96c53-22c6-40d3-abee-adc7f6d41b28')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e4edf1e0-cb14-480a-8d94-17377a531e4e')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','e4edf1e0-cb14-480a-8d94-17377a531e4e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89c8d7b0-dc05-4e94-b9dd-1cb3cdb00563')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','89c8d7b0-dc05-4e94-b9dd-1cb3cdb00563')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','89c8d7b0-dc05-4e94-b9dd-1cb3cdb00563')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','152c5d09-fb5f-4681-9973-423f5877affb')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','152c5d09-fb5f-4681-9973-423f5877affb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','152c5d09-fb5f-4681-9973-423f5877affb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8818fece-6229-46ad-a90b-14d736806b6b')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','8818fece-6229-46ad-a90b-14d736806b6b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8818fece-6229-46ad-a90b-14d736806b6b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a0314fef-fca8-4298-8b0d-d9a0d7973f4d')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','a0314fef-fca8-4298-8b0d-d9a0d7973f4d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a0314fef-fca8-4298-8b0d-d9a0d7973f4d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b1b071ba-d575-44d7-ac32-82ea5d0bb690')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','b1b071ba-d575-44d7-ac32-82ea5d0bb690')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b1b071ba-d575-44d7-ac32-82ea5d0bb690')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9a97f80b-3192-4c72-aacc-38fbb1955df2')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','9a97f80b-3192-4c72-aacc-38fbb1955df2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9a97f80b-3192-4c72-aacc-38fbb1955df2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f34fd7b2-83cc-4dc2-8983-5dd0de8b08a6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f34fd7b2-83cc-4dc2-8983-5dd0de8b08a6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89233980-d36c-47fa-a903-5b6d5878572c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','89233980-d36c-47fa-a903-5b6d5878572c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee9eb6dd-317f-443c-a679-b99d413b2849')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee9eb6dd-317f-443c-a679-b99d413b2849')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a155d844-5391-41f3-a506-e95b4d7ce674')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a155d844-5391-41f3-a506-e95b4d7ce674')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b5582824-13fb-46db-ae1a-543cab66432f')
,('29f2db9a-61c3-47b5-8376-32e46d943b81','b5582824-13fb-46db-ae1a-543cab66432f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b5582824-13fb-46db-ae1a-543cab66432f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ed2b4116-b1e7-4104-a87c-e98c49d6a592')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','ed2b4116-b1e7-4104-a87c-e98c49d6a592')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ed2b4116-b1e7-4104-a87c-e98c49d6a592')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b29d41d3-2b89-49d3-b9a0-71b8b03af4a1')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','b29d41d3-2b89-49d3-b9a0-71b8b03af4a1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b29d41d3-2b89-49d3-b9a0-71b8b03af4a1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','929307f5-5aab-4fd8-9b2d-2db8ccbc905e')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','929307f5-5aab-4fd8-9b2d-2db8ccbc905e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','929307f5-5aab-4fd8-9b2d-2db8ccbc905e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','77fb7653-3c37-40ec-bad5-07ce645eab6c')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','77fb7653-3c37-40ec-bad5-07ce645eab6c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','77fb7653-3c37-40ec-bad5-07ce645eab6c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','72cccd92-784a-4ae2-a49b-7f9db838aaf5')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','72cccd92-784a-4ae2-a49b-7f9db838aaf5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ec3ba7e-7ca5-4c55-a500-d4b8e31f0812')
,('4bc53979-f1d4-4b58-ba83-9d3b90e46dc0','2ec3ba7e-7ca5-4c55-a500-d4b8e31f0812')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e94836ff-2cac-4f29-af3b-1925603818e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','98e9282a-ee12-4e81-ab56-3b6f53d00fa5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d1cfaf2-e5f5-4ae3-bd9f-e1ab4b349703')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6f9d24c2-c946-47ac-bbcb-dfdeea0e3e8c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6f9d24c2-c946-47ac-bbcb-dfdeea0e3e8c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0618ce35-c87e-4b23-8a3e-b84f2586be56')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0618ce35-c87e-4b23-8a3e-b84f2586be56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','21d9c77f-9652-40d5-adef-31d2393ed7eb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','21d9c77f-9652-40d5-adef-31d2393ed7eb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c23a46c0-8aad-4b41-960d-50b6eaf87a79')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c23a46c0-8aad-4b41-960d-50b6eaf87a79')
,('2eb7f6a1-f7fa-48e4-bb76-f73c73597b28','566ab6be-8179-469e-be10-d5cb2f331c65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','566ab6be-8179-469e-be10-d5cb2f331c65')
,('76c3968c-c2ef-4f37-8d33-4709f0ba3747','566ab6be-8179-469e-be10-d5cb2f331c65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','566ab6be-8179-469e-be10-d5cb2f331c65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7e561329-8447-4f13-83da-4e0b2068d3c6')
,('10cedc5f-717a-4800-b837-d250cce7c101','7e561329-8447-4f13-83da-4e0b2068d3c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7e561329-8447-4f13-83da-4e0b2068d3c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','47c7ad98-afdb-44e5-b9c7-9b6d64abd4ba')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','47c7ad98-afdb-44e5-b9c7-9b6d64abd4ba')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','380325a7-b84c-4491-af53-5168c2abd763')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','380325a7-b84c-4491-af53-5168c2abd763')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b0469c1-beed-4932-a1d3-21952855445f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7b0469c1-beed-4932-a1d3-21952855445f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c622a11b-4a66-4439-b3c3-4b6c8ee190f0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c622a11b-4a66-4439-b3c3-4b6c8ee190f0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bfcc969d-65c4-4491-93ec-cf1a6d9c023b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bfcc969d-65c4-4491-93ec-cf1a6d9c023b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','591de8a3-07ab-47fb-bfa7-b2c7822593f4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','591de8a3-07ab-47fb-bfa7-b2c7822593f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','96aae3f9-5bb1-4c81-91b9-4ddf2dbe56d1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','96aae3f9-5bb1-4c81-91b9-4ddf2dbe56d1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6d0bf345-158d-4391-988a-e261cf05e45c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6d0bf345-158d-4391-988a-e261cf05e45c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82ae659a-2290-4fbd-90a1-5af68091ee03')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82ae659a-2290-4fbd-90a1-5af68091ee03')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a8ad6f28-718c-4e28-a274-a5dfe527fbd6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a8ad6f28-718c-4e28-a274-a5dfe527fbd6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5ec011d5-c3b9-43ff-8737-9b232b83800b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5ec011d5-c3b9-43ff-8737-9b232b83800b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e27046cd-c125-4f7f-8768-29f151a39c05')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e27046cd-c125-4f7f-8768-29f151a39c05')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6a1d42c9-34e7-4fe8-ad9f-bf1d29a825ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6a1d42c9-34e7-4fe8-ad9f-bf1d29a825ca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6edfc9f5-cdf1-423e-89fa-eaa421598f09')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6edfc9f5-cdf1-423e-89fa-eaa421598f09')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7c9d382b-c67d-4643-8d9e-1f4bd8a4ea54')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7c9d382b-c67d-4643-8d9e-1f4bd8a4ea54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3170d470-de2d-4aae-94e5-c2abfa3a8847')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3170d470-de2d-4aae-94e5-c2abfa3a8847')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','40859d23-3421-4950-8ca7-b49dfcd73354')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','40859d23-3421-4950-8ca7-b49dfcd73354')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5b6c5fe-970b-4a33-9fbe-d39b26beb3cc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c5b6c5fe-970b-4a33-9fbe-d39b26beb3cc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5971fe18-c372-4a00-b8bb-ade53e34c47e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5971fe18-c372-4a00-b8bb-ade53e34c47e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa4254b5-b13b-4fc6-bbeb-1e077637635d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fa4254b5-b13b-4fc6-bbeb-1e077637635d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ff37546-5668-452f-9689-408d290b6645')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ff37546-5668-452f-9689-408d290b6645')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dcf9db1f-b26d-445b-bafe-482ff605bfd9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','dcf9db1f-b26d-445b-bafe-482ff605bfd9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e5525baf-2ae9-4207-bb55-f531d2e5d2f4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e5525baf-2ae9-4207-bb55-f531d2e5d2f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6e0bf8a0-503a-4046-b952-ef0760d63dac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6e0bf8a0-503a-4046-b952-ef0760d63dac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e1773a03-3c06-4312-98ab-f238b4c88787')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fd6157f8-97c1-4fb2-a538-248ba4d74cee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','18d777f5-69a9-4fb6-be93-57397288eea1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b8a1107e-a436-46f5-a8f4-f2f8d9b66562')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eca9b9fc-9858-4e84-a6fa-367020ce3c04')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e154a343-e946-4c9b-baf2-58dbd682e9f4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','766e9f52-bd44-4d7f-8453-10e354ba38f8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6fa9897c-4994-418c-b24f-bd38ef48452a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c7697326-fed8-49b1-adcf-fe88c37b2646')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c19d22b-d30a-412f-8815-deda43b421f8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','19c4a278-3d1b-4201-b201-3727836c70fb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c80e5a3c-f288-43c0-a249-cc00d31c8aa7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','513af2bc-5ea3-4f2f-a23e-962f6a11d4f2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f12f71c3-708f-4ea1-ab3a-7111f2a801ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','905be911-1c3e-4acd-bc96-f7d6af70572c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','57ad1ab3-66cd-4285-a6b7-c7d695b2f3ce')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cb56cb5b-c393-4912-a503-2d111fddb8b2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4b79cf9f-f698-4473-9047-8108d1be7828')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9a02d5fe-db13-4d44-92e0-1adb60a2ba63')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0040a213-9d91-44bf-92d0-58e48e096d77')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e64eff8a-d7c3-40ad-be0d-e40931db3dd0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','167451d4-123e-452f-a943-0a1791a2f1e5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1fe53d8f-47f3-4e8b-9de7-4171f219ef20')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','86ca3241-7868-490d-b548-4486d3e5c323')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','34a5494e-2c23-4abd-8c28-e9e14ccf930f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b80d780e-59fc-4e2c-80ed-75c5365c02c2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ae4f11c-3d02-4a9b-99bb-c622a535ba62')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea08b959-2bef-44f6-9d97-75593a71d2b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','18169df9-35a5-4288-b01a-23ba4809d655')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','50863dad-20d1-44ee-95a6-c3d718cb47c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f74aa0d5-ae92-4986-8979-8bee16cb9556')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','45f85c03-b4ee-44f4-99f9-df4ea4d39439')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2f10f2b5-348a-4c4a-aa18-55d53346621d')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','2f10f2b5-348a-4c4a-aa18-55d53346621d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','795524c4-d32d-40ae-8a05-1643c6df2f8d')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','795524c4-d32d-40ae-8a05-1643c6df2f8d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','991060f7-b533-43bd-9cb4-880127a884ab')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','991060f7-b533-43bd-9cb4-880127a884ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e5a3b41f-3b3d-4871-a18b-dde9d627dc8b')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','e5a3b41f-3b3d-4871-a18b-dde9d627dc8b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','af959693-38be-44a2-acb3-4010f43ca90c')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','af959693-38be-44a2-acb3-4010f43ca90c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5b54c42c-b166-4058-8fad-f57702657d8c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5b54c42c-b166-4058-8fad-f57702657d8c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','974c526d-5ce1-4a22-b412-7544ed55fa0a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','974c526d-5ce1-4a22-b412-7544ed55fa0a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ed1e568d-df02-49c1-90f2-9e010969b6bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ed1e568d-df02-49c1-90f2-9e010969b6bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c02445c8-08ee-4688-8e5c-08d4c547fd17')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c02445c8-08ee-4688-8e5c-08d4c547fd17')
,('17949107-a0d3-42da-997c-5b70f0831444','f1b6c298-2365-4dff-bff7-d014b68ab876')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f1b6c298-2365-4dff-bff7-d014b68ab876')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f1b6c298-2365-4dff-bff7-d014b68ab876')
,('17949107-a0d3-42da-997c-5b70f0831444','f25649c7-844e-4c12-adba-a1793b20c579')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f25649c7-844e-4c12-adba-a1793b20c579')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f25649c7-844e-4c12-adba-a1793b20c579')
,('17949107-a0d3-42da-997c-5b70f0831444','ea1535c4-1a50-46dd-89c3-ad13d57c5dc9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea1535c4-1a50-46dd-89c3-ad13d57c5dc9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ea1535c4-1a50-46dd-89c3-ad13d57c5dc9')
,('17949107-a0d3-42da-997c-5b70f0831444','f45a299b-cd31-4fef-a0f9-f35faf131360')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f45a299b-cd31-4fef-a0f9-f35faf131360')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f45a299b-cd31-4fef-a0f9-f35faf131360')
,('17949107-a0d3-42da-997c-5b70f0831444','8995a818-6702-445a-a1ee-7fd1cbe48066')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','8995a818-6702-445a-a1ee-7fd1cbe48066')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8995a818-6702-445a-a1ee-7fd1cbe48066')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8995a818-6702-445a-a1ee-7fd1cbe48066')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','8995a818-6702-445a-a1ee-7fd1cbe48066')
,('17949107-a0d3-42da-997c-5b70f0831444','eadea80c-ed0a-4810-8e74-42ca8f409721')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eadea80c-ed0a-4810-8e74-42ca8f409721')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eadea80c-ed0a-4810-8e74-42ca8f409721')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','29a3f5b1-d0a0-477f-9177-168fb8ea69c9')
,('17949107-a0d3-42da-997c-5b70f0831444','73bc3468-b8ed-471e-802a-538859a16c77')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','73bc3468-b8ed-471e-802a-538859a16c77')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','73bc3468-b8ed-471e-802a-538859a16c77')
,('17949107-a0d3-42da-997c-5b70f0831444','2bf4b4e6-6f65-4ca8-92c5-e4a3b1e31300')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2bf4b4e6-6f65-4ca8-92c5-e4a3b1e31300')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2bf4b4e6-6f65-4ca8-92c5-e4a3b1e31300')
,('17949107-a0d3-42da-997c-5b70f0831444','3af355e7-387f-4cdd-afd0-aeb8be5161a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3af355e7-387f-4cdd-afd0-aeb8be5161a9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3af355e7-387f-4cdd-afd0-aeb8be5161a9')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','33d78778-8f41-40a0-a31a-fbe96dd42da3')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','33d78778-8f41-40a0-a31a-fbe96dd42da3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','33d78778-8f41-40a0-a31a-fbe96dd42da3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','33d78778-8f41-40a0-a31a-fbe96dd42da3')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','c9c07810-f738-46b3-8e52-fe77c0e93311')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','c9c07810-f738-46b3-8e52-fe77c0e93311')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c9c07810-f738-46b3-8e52-fe77c0e93311')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c9c07810-f738-46b3-8e52-fe77c0e93311')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','45326e7e-9d2a-4b37-a6a2-44cda7a5aacc')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','45326e7e-9d2a-4b37-a6a2-44cda7a5aacc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','45326e7e-9d2a-4b37-a6a2-44cda7a5aacc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','45326e7e-9d2a-4b37-a6a2-44cda7a5aacc')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','1b958fce-2ad5-4dc7-820c-8431524755fe')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','1b958fce-2ad5-4dc7-820c-8431524755fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1b958fce-2ad5-4dc7-820c-8431524755fe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1b958fce-2ad5-4dc7-820c-8431524755fe')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','961c5fce-e231-450f-9b8c-6cd04c39ed3c')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','961c5fce-e231-450f-9b8c-6cd04c39ed3c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','961c5fce-e231-450f-9b8c-6cd04c39ed3c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','961c5fce-e231-450f-9b8c-6cd04c39ed3c')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','46010c46-c58a-44d4-8f1b-dd032c4e9d64')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','46010c46-c58a-44d4-8f1b-dd032c4e9d64')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('17949107-a0d3-42da-997c-5b70f0831444','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','6119dc91-6b5c-4924-a426-a7e3ce7006c3')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','173c9be3-aa5e-45b9-8939-47033e8345f6')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','173c9be3-aa5e-45b9-8939-47033e8345f6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','173c9be3-aa5e-45b9-8939-47033e8345f6')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','173c9be3-aa5e-45b9-8939-47033e8345f6')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('17949107-a0d3-42da-997c-5b70f0831444','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','d5c2ab8c-8a50-460c-9c20-3e654d44d1ae')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('17949107-a0d3-42da-997c-5b70f0831444','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','a1115d3f-e329-40e8-aabc-23980e2672e3')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('17949107-a0d3-42da-997c-5b70f0831444','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','a80d2bf3-52fa-481b-ad60-a0a93e1fa60a')
,('17949107-a0d3-42da-997c-5b70f0831444','b9b1febf-2098-4d6e-92a7-330c84cd5b8f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9b1febf-2098-4d6e-92a7-330c84cd5b8f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9b1febf-2098-4d6e-92a7-330c84cd5b8f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','633ae79d-9069-4721-9bed-b778b1ee2d4f')
,('17949107-a0d3-42da-997c-5b70f0831444','c03bb34a-252c-43da-acfe-1c080bd68632')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c03bb34a-252c-43da-acfe-1c080bd68632')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c03bb34a-252c-43da-acfe-1c080bd68632')
,('17949107-a0d3-42da-997c-5b70f0831444','e2dc893a-0c2d-4505-b4f6-51e3ab4740bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e2dc893a-0c2d-4505-b4f6-51e3ab4740bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e2dc893a-0c2d-4505-b4f6-51e3ab4740bf')
,('17949107-a0d3-42da-997c-5b70f0831444','2fd24161-7c98-4304-8472-6708a620f826')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2fd24161-7c98-4304-8472-6708a620f826')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2fd24161-7c98-4304-8472-6708a620f826')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9eee17f3-a7d2-4d56-97c1-b1337abbcec6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1a457084-14c6-4170-a648-18f1993d69e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1a457084-14c6-4170-a648-18f1993d69e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6b6ea30e-9893-46a4-8886-016be06b235a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','49815f09-993c-4202-95bb-09cf60fd2253')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','49815f09-993c-4202-95bb-09cf60fd2253')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4adad985-9dd3-47a1-90a3-69a03bb79e73')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4adad985-9dd3-47a1-90a3-69a03bb79e73')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e641b22-2986-42de-9843-56aa31520e71')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e641b22-2986-42de-9843-56aa31520e71')
,('17949107-a0d3-42da-997c-5b70f0831444','6e51b814-fea0-42b1-a196-7e8da38a8a65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6e51b814-fea0-42b1-a196-7e8da38a8a65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6e51b814-fea0-42b1-a196-7e8da38a8a65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a64d013e-30fa-488e-9cec-29a06ab148df')
,('17949107-a0d3-42da-997c-5b70f0831444','830b2ca0-66d9-4e7f-8c8e-8686844f507e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','830b2ca0-66d9-4e7f-8c8e-8686844f507e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','830b2ca0-66d9-4e7f-8c8e-8686844f507e')
,('17949107-a0d3-42da-997c-5b70f0831444','493b79ce-484f-452a-b8d3-02fe822345b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','493b79ce-484f-452a-b8d3-02fe822345b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','493b79ce-484f-452a-b8d3-02fe822345b7')
,('17949107-a0d3-42da-997c-5b70f0831444','7f85cc14-2563-407f-8034-d97f850eae55')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7f85cc14-2563-407f-8034-d97f850eae55')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7f85cc14-2563-407f-8034-d97f850eae55')
,('17949107-a0d3-42da-997c-5b70f0831444','4d79afee-21e4-40fa-9440-7f340fdec140')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4d79afee-21e4-40fa-9440-7f340fdec140')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4d79afee-21e4-40fa-9440-7f340fdec140')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9ec75aed-68df-4e2d-a3b0-5f4936fdc877')
,('17949107-a0d3-42da-997c-5b70f0831444','fca33ef7-9085-4936-9f58-14fab5e3738d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fca33ef7-9085-4936-9f58-14fab5e3738d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fca33ef7-9085-4936-9f58-14fab5e3738d')
,('17949107-a0d3-42da-997c-5b70f0831444','e6b87474-e912-4e9a-8f74-1eb2dc9959c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e6b87474-e912-4e9a-8f74-1eb2dc9959c4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e6b87474-e912-4e9a-8f74-1eb2dc9959c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c22b217d-2240-4a41-8d31-de1121b59808')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4325c7c7-5007-485f-88d9-f36a62b19152')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4325c7c7-5007-485f-88d9-f36a62b19152')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','89f35742-5cc0-4e91-92f1-105f948be2c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','89f35742-5cc0-4e91-92f1-105f948be2c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1b573bf3-c769-49cd-9df0-09ddc170439a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1b573bf3-c769-49cd-9df0-09ddc170439a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3ea33d40-3c2e-4512-9a1b-d3b32314f1bc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3ea33d40-3c2e-4512-9a1b-d3b32314f1bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f109c73b-2c91-4323-ab54-6372f541e0fc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f109c73b-2c91-4323-ab54-6372f541e0fc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b8d76668-c650-4561-a557-f70e8fca0f21')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b8d76668-c650-4561-a557-f70e8fca0f21')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea2011d2-8bce-41c1-8de8-f326559cd956')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','04b30e64-d630-48c2-93f2-8492a5845658')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4d26670f-5de4-4bfe-b35e-972ff577b6f7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4dd152a9-322a-4da7-939f-00e38c8e2084')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a49d2adb-b686-4adc-bdcc-71a63bfc8cf8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','598ab1bd-5868-4ead-bd3d-14ad56c48198')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','32b4b422-ce1a-457e-9ede-6213484de156')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','372b777d-66a9-4764-af8f-9c01521ac346')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','50922382-23a4-4b7e-a794-0857d1043cad')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cc75c485-c197-43f0-b9b2-b770b8fa46e0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b50e502e-1c77-4962-8528-8a45c3d8504e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b50e502e-1c77-4962-8528-8a45c3d8504e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','337ace09-31c0-4ec4-9d16-904d85a8f3b6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','337ace09-31c0-4ec4-9d16-904d85a8f3b6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f95d91f1-c59e-4dc6-8c64-90bec8a665b8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f95d91f1-c59e-4dc6-8c64-90bec8a665b8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','603a28f6-6ba6-44e9-a4ae-e671b8cc981d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','603a28f6-6ba6-44e9-a4ae-e671b8cc981d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','984c62a5-4947-44d3-8f85-d8cf8e98a8ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','984c62a5-4947-44d3-8f85-d8cf8e98a8ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b12e03ab-bc9c-47f4-837e-cadbc9fc46d1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b12e03ab-bc9c-47f4-837e-cadbc9fc46d1')
,('17949107-a0d3-42da-997c-5b70f0831444','b64efc3c-5072-4d05-b361-f0d3bff91256')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b64efc3c-5072-4d05-b361-f0d3bff91256')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b64efc3c-5072-4d05-b361-f0d3bff91256')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','b64efc3c-5072-4d05-b361-f0d3bff91256')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f074e975-c1c8-42c6-845b-6c475e91fa0d')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','f074e975-c1c8-42c6-845b-6c475e91fa0d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7be3847e-e320-46d6-8f28-95e98de32130')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','7be3847e-e320-46d6-8f28-95e98de32130')
,('17949107-a0d3-42da-997c-5b70f0831444','cef5e7e7-5f52-4897-ba91-52a173661d5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cef5e7e7-5f52-4897-ba91-52a173661d5b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cef5e7e7-5f52-4897-ba91-52a173661d5b')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','cef5e7e7-5f52-4897-ba91-52a173661d5b')
,('17949107-a0d3-42da-997c-5b70f0831444','8a189399-f6fa-4039-98ef-5cbd886b3c58')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8a189399-f6fa-4039-98ef-5cbd886b3c58')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8a189399-f6fa-4039-98ef-5cbd886b3c58')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','8a189399-f6fa-4039-98ef-5cbd886b3c58')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d8f6aea1-83d0-4cb9-af14-fa55208e68c6')
,('17949107-a0d3-42da-997c-5b70f0831444','d8f6aea1-83d0-4cb9-af14-fa55208e68c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d8f6aea1-83d0-4cb9-af14-fa55208e68c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d8f6aea1-83d0-4cb9-af14-fa55208e68c6')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','d8f6aea1-83d0-4cb9-af14-fa55208e68c6')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a5d13afc-4e57-49ce-a898-a8bdc0208474')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a5d13afc-4e57-49ce-a898-a8bdc0208474')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','a5d13afc-4e57-49ce-a898-a8bdc0208474')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','e7a9bbdd-25eb-4dfa-adad-436abbad4e6e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e7a9bbdd-25eb-4dfa-adad-436abbad4e6e')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','e7a9bbdd-25eb-4dfa-adad-436abbad4e6e')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','82da1a1c-5707-488c-ad9c-8a84762ade54')
,('17949107-a0d3-42da-997c-5b70f0831444','82da1a1c-5707-488c-ad9c-8a84762ade54')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','82da1a1c-5707-488c-ad9c-8a84762ade54')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','82da1a1c-5707-488c-ad9c-8a84762ade54')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','82da1a1c-5707-488c-ad9c-8a84762ade54')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','502a60d5-ff9f-4b23-b0df-80cb8012485a')
,('17949107-a0d3-42da-997c-5b70f0831444','502a60d5-ff9f-4b23-b0df-80cb8012485a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','502a60d5-ff9f-4b23-b0df-80cb8012485a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','502a60d5-ff9f-4b23-b0df-80cb8012485a')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','502a60d5-ff9f-4b23-b0df-80cb8012485a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','34d6c79a-76dc-4a0e-8965-86104e0e205e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','34d6c79a-76dc-4a0e-8965-86104e0e205e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4f9b2142-2e93-4513-994d-568e16336007')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4f9b2142-2e93-4513-994d-568e16336007')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','35d7c540-963b-4e0e-bd06-de7af8861ed9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','35d7c540-963b-4e0e-bd06-de7af8861ed9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a79f06d3-11f6-49d9-97a9-719c4d3259e1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a79f06d3-11f6-49d9-97a9-719c4d3259e1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b078d351-b9ed-41c0-b643-6b3e8b9cb49d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b078d351-b9ed-41c0-b643-6b3e8b9cb49d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3054a99d-0139-4c70-9d5b-5de9f26a0edc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3054a99d-0139-4c70-9d5b-5de9f26a0edc')
,('17949107-a0d3-42da-997c-5b70f0831444','fb90d79d-bd84-420c-9dee-e6e995b4f37b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fb90d79d-bd84-420c-9dee-e6e995b4f37b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fb90d79d-bd84-420c-9dee-e6e995b4f37b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c00e93e8-94f5-4502-98dc-df02bd19ab66')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','20091f72-0d3c-49fa-8e42-7749b6bc3f43')
,('17949107-a0d3-42da-997c-5b70f0831444','4ee771f5-bb60-49a3-8efe-2a5f34bd7aae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4ee771f5-bb60-49a3-8efe-2a5f34bd7aae')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4ee771f5-bb60-49a3-8efe-2a5f34bd7aae')
,('17949107-a0d3-42da-997c-5b70f0831444','485525f2-e579-43af-a403-d167bfdec824')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','485525f2-e579-43af-a403-d167bfdec824')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','485525f2-e579-43af-a403-d167bfdec824')
,('17949107-a0d3-42da-997c-5b70f0831444','d388538e-595a-4472-bab0-213ef34f3b56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d388538e-595a-4472-bab0-213ef34f3b56')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d388538e-595a-4472-bab0-213ef34f3b56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','70ac501d-97d1-4bb2-8874-c98e805ca5b9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dbf0754e-0464-4977-bab3-28a4514774bc')
,('17949107-a0d3-42da-997c-5b70f0831444','48f2a228-18ec-4dfd-952a-bb26068a14e3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48f2a228-18ec-4dfd-952a-bb26068a14e3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48f2a228-18ec-4dfd-952a-bb26068a14e3')
,('17949107-a0d3-42da-997c-5b70f0831444','464a4b62-b1e1-4618-ac95-26b78b0843b2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','464a4b62-b1e1-4618-ac95-26b78b0843b2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','464a4b62-b1e1-4618-ac95-26b78b0843b2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ef0d63b4-ad7c-4052-be4a-9904bd871cec')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ef0d63b4-ad7c-4052-be4a-9904bd871cec')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4f22c5a6-5e3c-44dc-8210-4f911ceef5de')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4f22c5a6-5e3c-44dc-8210-4f911ceef5de')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','67789930-dc9d-464a-a6be-34b7c770b0bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','67789930-dc9d-464a-a6be-34b7c770b0bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c819ad75-4ce6-4441-afc0-f66d6e45a882')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c819ad75-4ce6-4441-afc0-f66d6e45a882')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','414940fc-30e6-408c-b052-aa1ee5a05adf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','414940fc-30e6-408c-b052-aa1ee5a05adf')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d25f77d3-e50b-4b9c-b08e-961b22f982fe')
,('4879502b-7bac-4c9e-8d4c-c91a8c061be7','d25f77d3-e50b-4b9c-b08e-961b22f982fe')
,('17949107-a0d3-42da-997c-5b70f0831444','4187223b-9fa7-4b16-85a9-eb7c89943516')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4187223b-9fa7-4b16-85a9-eb7c89943516')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4187223b-9fa7-4b16-85a9-eb7c89943516')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3da94c49-6c3b-4996-8a1a-49ecfce4e350')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ccdbfff4-789d-4eea-a833-03f46ed64db3')
,('17949107-a0d3-42da-997c-5b70f0831444','a4752f2a-3d7c-48e7-9a12-ade61a29d2c0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a4752f2a-3d7c-48e7-9a12-ade61a29d2c0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a4752f2a-3d7c-48e7-9a12-ade61a29d2c0')
,('17949107-a0d3-42da-997c-5b70f0831444','1e983974-d1a4-45d6-9c4d-e2463b2a1b65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1e983974-d1a4-45d6-9c4d-e2463b2a1b65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1e983974-d1a4-45d6-9c4d-e2463b2a1b65')
,('17949107-a0d3-42da-997c-5b70f0831444','5c46cc2b-3148-44fe-9e6f-a1a7651cb844')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5c46cc2b-3148-44fe-9e6f-a1a7651cb844')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5c46cc2b-3148-44fe-9e6f-a1a7651cb844')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2c23908c-d247-4f15-884f-5f8cceae1e15')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cf8a42b2-38dc-4357-ad35-9c709755fddb')
,('17949107-a0d3-42da-997c-5b70f0831444','1c7b703c-0407-4405-a30d-d42d21775926')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1c7b703c-0407-4405-a30d-d42d21775926')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1c7b703c-0407-4405-a30d-d42d21775926')
,('17949107-a0d3-42da-997c-5b70f0831444','d2aacee4-8066-4ee0-bb6c-5db2c4a4a6d9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d2aacee4-8066-4ee0-bb6c-5db2c4a4a6d9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d2aacee4-8066-4ee0-bb6c-5db2c4a4a6d9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7d64338b-758b-42d2-a008-4c600d19c0c8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7d64338b-758b-42d2-a008-4c600d19c0c8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d7166d4-786d-4330-bb41-f16078950557')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3d7166d4-786d-4330-bb41-f16078950557')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3f2e7131-8ab1-4ab2-8eea-f3da09f62c4c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3f2e7131-8ab1-4ab2-8eea-f3da09f62c4c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','529c17d4-ab61-4d5a-91fa-193f724b6c61')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','529c17d4-ab61-4d5a-91fa-193f724b6c61')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f0748278-126d-4ecd-8b0d-d8d34f86a393')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f0748278-126d-4ecd-8b0d-d8d34f86a393')
,('985fa8af-cac7-44ab-9049-ccaefee4f866','2edcd87e-740b-4cf9-883e-15ee1c7fbb9c')
,('17949107-a0d3-42da-997c-5b70f0831444','649a125a-7384-43d1-bfd6-ccaf403aa863')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','649a125a-7384-43d1-bfd6-ccaf403aa863')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','649a125a-7384-43d1-bfd6-ccaf403aa863')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','377c410e-9063-474f-8ab0-83a19069bf72')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5e6a31f0-c6e1-4461-9e73-142b070256f3')
,('17949107-a0d3-42da-997c-5b70f0831444','25a11a89-0068-428e-bcb8-354b2662cbb7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','25a11a89-0068-428e-bcb8-354b2662cbb7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','25a11a89-0068-428e-bcb8-354b2662cbb7')
,('17949107-a0d3-42da-997c-5b70f0831444','69725f4d-3e72-40b7-97b9-785461dac2a5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69725f4d-3e72-40b7-97b9-785461dac2a5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69725f4d-3e72-40b7-97b9-785461dac2a5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','312b9182-c2c2-4c32-932d-ed76ba276b19')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','56dc6715-b46c-444d-a8b2-7aff50de30c1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','49b2c97a-6938-4794-8f4c-d74d6d780b6e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','23b5329c-ec96-4b0e-89d6-def96b866ad9')
,('17949107-a0d3-42da-997c-5b70f0831444','2faff758-21b8-4457-96df-4b623cb48ae1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2faff758-21b8-4457-96df-4b623cb48ae1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2faff758-21b8-4457-96df-4b623cb48ae1')
,('17949107-a0d3-42da-997c-5b70f0831444','4b53913f-367c-4cbb-9f3d-7699e723197b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4b53913f-367c-4cbb-9f3d-7699e723197b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4b53913f-367c-4cbb-9f3d-7699e723197b')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('17949107-a0d3-42da-997c-5b70f0831444','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('caeda0e4-11eb-4112-9649-9ba2a4309803','6bffd0be-06e1-4d7a-bea2-32cc84e31b67')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','648f9035-02fa-4ed1-a63a-6253e56b205a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','911e630d-93b9-4d5b-87b8-9b73c5eb7319')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9f21ff3c-cbfe-4551-8d0b-6f7788a29bd4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0c8b89e8-085a-4cca-a350-31655edf4267')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b3ac30bd-2394-4347-be82-06dcfd3f6ed8')
,('17949107-a0d3-42da-997c-5b70f0831444','91427b86-ebee-4844-8f83-6e0f4200cc50')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','91427b86-ebee-4844-8f83-6e0f4200cc50')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','91427b86-ebee-4844-8f83-6e0f4200cc50')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1b356bf3-34e1-4685-851b-e4e90f443c55')
,('17949107-a0d3-42da-997c-5b70f0831444','b8f5a2fc-017a-43db-9f7b-ca18305e146d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b8f5a2fc-017a-43db-9f7b-ca18305e146d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b8f5a2fc-017a-43db-9f7b-ca18305e146d')
,('17949107-a0d3-42da-997c-5b70f0831444','8db647a8-f0d1-4f8a-b21c-913ec69f05e8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8db647a8-f0d1-4f8a-b21c-913ec69f05e8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8db647a8-f0d1-4f8a-b21c-913ec69f05e8')
,('17949107-a0d3-42da-997c-5b70f0831444','a08816a0-ba07-43e7-b21e-21415c59a0a4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a08816a0-ba07-43e7-b21e-21415c59a0a4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a08816a0-ba07-43e7-b21e-21415c59a0a4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e780b6ee-bf84-4374-b44b-bc27aa6b4ae4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e780b6ee-bf84-4374-b44b-bc27aa6b4ae4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7611781c-f9b2-4d17-b716-2ffe31867898')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7611781c-f9b2-4d17-b716-2ffe31867898')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3cebeb6d-1344-46b0-a866-204290ac85cc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3cebeb6d-1344-46b0-a866-204290ac85cc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0e1779e1-40cb-4090-80d3-cb825ca4ad98')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0e1779e1-40cb-4090-80d3-cb825ca4ad98')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bb0edc50-a715-433f-8248-9f71162c396c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bb0edc50-a715-433f-8248-9f71162c396c')
,('17949107-a0d3-42da-997c-5b70f0831444','3afc10b0-4bb0-47a2-b528-a0d487c5dcf8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3afc10b0-4bb0-47a2-b528-a0d487c5dcf8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3afc10b0-4bb0-47a2-b528-a0d487c5dcf8')
,('17949107-a0d3-42da-997c-5b70f0831444','9dce47a7-473f-4311-babc-06742d6058ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9dce47a7-473f-4311-babc-06742d6058ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9dce47a7-473f-4311-babc-06742d6058ea')
,('17949107-a0d3-42da-997c-5b70f0831444','035d47e1-d9a7-43b3-97a6-5091c23f7a08')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','035d47e1-d9a7-43b3-97a6-5091c23f7a08')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','035d47e1-d9a7-43b3-97a6-5091c23f7a08')
,('17949107-a0d3-42da-997c-5b70f0831444','63a2671d-4376-4067-8dbf-4a51b679e48c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','63a2671d-4376-4067-8dbf-4a51b679e48c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','63a2671d-4376-4067-8dbf-4a51b679e48c')
,('17949107-a0d3-42da-997c-5b70f0831444','da2693f6-b411-4432-80e0-79db42be0bdc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','da2693f6-b411-4432-80e0-79db42be0bdc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','da2693f6-b411-4432-80e0-79db42be0bdc')
,('17949107-a0d3-42da-997c-5b70f0831444','8bc4d9b3-6d68-4be7-a3e8-5ce3935a3fb5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8bc4d9b3-6d68-4be7-a3e8-5ce3935a3fb5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8bc4d9b3-6d68-4be7-a3e8-5ce3935a3fb5')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','b1d0a145-ffac-4005-a0c8-31183c66aa9d')
,('17949107-a0d3-42da-997c-5b70f0831444','b1d0a145-ffac-4005-a0c8-31183c66aa9d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b1d0a145-ffac-4005-a0c8-31183c66aa9d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b1d0a145-ffac-4005-a0c8-31183c66aa9d')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','b1d0a145-ffac-4005-a0c8-31183c66aa9d')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','360689db-6fd7-489a-a7ca-5f43fae14e6f')
,('17949107-a0d3-42da-997c-5b70f0831444','360689db-6fd7-489a-a7ca-5f43fae14e6f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','360689db-6fd7-489a-a7ca-5f43fae14e6f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','360689db-6fd7-489a-a7ca-5f43fae14e6f')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','360689db-6fd7-489a-a7ca-5f43fae14e6f')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','5d9615c4-c873-4aa0-9098-dc75ba18d2e3')
,('17949107-a0d3-42da-997c-5b70f0831444','5d9615c4-c873-4aa0-9098-dc75ba18d2e3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5d9615c4-c873-4aa0-9098-dc75ba18d2e3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5d9615c4-c873-4aa0-9098-dc75ba18d2e3')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','5d9615c4-c873-4aa0-9098-dc75ba18d2e3')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d')
,('17949107-a0d3-42da-997c-5b70f0831444','245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','245fb1c4-5430-4cb1-bb7d-5c60eb87ee2d')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','4edbdade-e1fe-4ddb-b020-7005c42fc6d3')
,('17949107-a0d3-42da-997c-5b70f0831444','4edbdade-e1fe-4ddb-b020-7005c42fc6d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4edbdade-e1fe-4ddb-b020-7005c42fc6d3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4edbdade-e1fe-4ddb-b020-7005c42fc6d3')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','4edbdade-e1fe-4ddb-b020-7005c42fc6d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c2fb9b96-a724-4030-b52e-ebb4c22f8f19')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dd20f521-4a59-45a4-bbfb-024d16ca9006')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ad753904-5447-4994-b8bf-1bd9814c57ae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7ae2c94c-db7b-4fb8-b3eb-a98aef296210')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65e1c1e6-4374-4947-b267-1cc4bfc30763')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9309df50-cb8e-43b8-b373-e939f2f26059')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','64a1e346-c2b8-401f-aaf2-21cfaae1db9a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','47b32e19-c0a1-4412-af70-2880b90f8302')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ea8fb81-f6f4-420b-ab1d-cc88779fd893')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6d857d29-b563-47e7-80c3-dd21783d9a6b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','769e3b03-c5bf-4e65-90ea-6680505b8d8b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1857727e-7930-4781-93b0-8ed4f8b5661a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','36e5147b-bf76-4966-9817-3e84cc58f46d')
,('17949107-a0d3-42da-997c-5b70f0831444','6c3c97ba-f4b1-4d2d-bc8b-0c1ee2a91349')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c3c97ba-f4b1-4d2d-bc8b-0c1ee2a91349')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c3c97ba-f4b1-4d2d-bc8b-0c1ee2a91349')
,('17949107-a0d3-42da-997c-5b70f0831444','0285ef37-6aec-47e9-9669-7ac413fd53fc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0285ef37-6aec-47e9-9669-7ac413fd53fc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0285ef37-6aec-47e9-9669-7ac413fd53fc')
,('17949107-a0d3-42da-997c-5b70f0831444','c77ff9e9-6e3a-43dc-a704-f8477dfdd934')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c77ff9e9-6e3a-43dc-a704-f8477dfdd934')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c77ff9e9-6e3a-43dc-a704-f8477dfdd934')
,('17949107-a0d3-42da-997c-5b70f0831444','95d2ddc2-0d75-419b-928a-fe7526e43a1b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','95d2ddc2-0d75-419b-928a-fe7526e43a1b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','95d2ddc2-0d75-419b-928a-fe7526e43a1b')
,('17949107-a0d3-42da-997c-5b70f0831444','829a238f-68d2-4181-93a1-9769d54170f5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','829a238f-68d2-4181-93a1-9769d54170f5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','829a238f-68d2-4181-93a1-9769d54170f5')
,('17949107-a0d3-42da-997c-5b70f0831444','732fc5ce-e3d9-4c68-a6cc-909d03ea6a82')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','732fc5ce-e3d9-4c68-a6cc-909d03ea6a82')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','732fc5ce-e3d9-4c68-a6cc-909d03ea6a82')
,('17949107-a0d3-42da-997c-5b70f0831444','409790bb-85f4-43bf-9da9-b3832b4460a7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','409790bb-85f4-43bf-9da9-b3832b4460a7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','409790bb-85f4-43bf-9da9-b3832b4460a7')
,('17949107-a0d3-42da-997c-5b70f0831444','b75be035-fc73-467e-acd4-256366f7099e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b75be035-fc73-467e-acd4-256366f7099e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b75be035-fc73-467e-acd4-256366f7099e')
,('17949107-a0d3-42da-997c-5b70f0831444','fde5fd7b-0286-4c0e-bfff-50f2dfdf486a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fde5fd7b-0286-4c0e-bfff-50f2dfdf486a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fde5fd7b-0286-4c0e-bfff-50f2dfdf486a')
,('17949107-a0d3-42da-997c-5b70f0831444','6a7c8351-3cf9-4829-8be7-82af1d45c3bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6a7c8351-3cf9-4829-8be7-82af1d45c3bc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6a7c8351-3cf9-4829-8be7-82af1d45c3bc')
,('17949107-a0d3-42da-997c-5b70f0831444','3bb8a192-bb3b-476d-a90c-c8a810cad110')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3bb8a192-bb3b-476d-a90c-c8a810cad110')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3bb8a192-bb3b-476d-a90c-c8a810cad110')
,('17949107-a0d3-42da-997c-5b70f0831444','64497acc-a0a7-494b-b951-2e4ecdca18ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','64497acc-a0a7-494b-b951-2e4ecdca18ef')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','64497acc-a0a7-494b-b951-2e4ecdca18ef')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','7f11548d-b3d1-420d-bbdb-fbda14c2dc5c')
,('17949107-a0d3-42da-997c-5b70f0831444','7f11548d-b3d1-420d-bbdb-fbda14c2dc5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7f11548d-b3d1-420d-bbdb-fbda14c2dc5c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7f11548d-b3d1-420d-bbdb-fbda14c2dc5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','898c7264-ce00-4cc1-aed1-f402c7a6c8cf')
,('1e227dc6-6e8b-4443-abd7-e1b4268e6aa7','898c7264-ce00-4cc1-aed1-f402c7a6c8cf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e5b5c041-d418-49b6-8535-d6e246fbf395')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0bf192e-0fb2-492d-8da6-9442dc580dcc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c35fca50-1bec-468c-b24f-a559fd24d786')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ed0785be-72d7-4ee3-b892-36e5e1dc1460')
,('17949107-a0d3-42da-997c-5b70f0831444','ea22ce40-2239-43cd-a593-f9157be76753')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea22ce40-2239-43cd-a593-f9157be76753')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ea22ce40-2239-43cd-a593-f9157be76753')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','ea22ce40-2239-43cd-a593-f9157be76753')
,('17949107-a0d3-42da-997c-5b70f0831444','138724e0-a4d1-40cf-8150-9d4230d6f915')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','138724e0-a4d1-40cf-8150-9d4230d6f915')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','138724e0-a4d1-40cf-8150-9d4230d6f915')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','138724e0-a4d1-40cf-8150-9d4230d6f915')
,('17949107-a0d3-42da-997c-5b70f0831444','d175b612-bc80-40a0-b351-b0a70dba28ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d175b612-bc80-40a0-b351-b0a70dba28ea')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d175b612-bc80-40a0-b351-b0a70dba28ea')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','d175b612-bc80-40a0-b351-b0a70dba28ea')
,('17949107-a0d3-42da-997c-5b70f0831444','4c6e6d45-d91c-426b-9495-a64177ea0e66')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4c6e6d45-d91c-426b-9495-a64177ea0e66')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4c6e6d45-d91c-426b-9495-a64177ea0e66')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','4c6e6d45-d91c-426b-9495-a64177ea0e66')
,('17949107-a0d3-42da-997c-5b70f0831444','3d553162-de3a-4b39-b5ec-ab9b1f77c917')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3d553162-de3a-4b39-b5ec-ab9b1f77c917')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3d553162-de3a-4b39-b5ec-ab9b1f77c917')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','3d553162-de3a-4b39-b5ec-ab9b1f77c917')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','16d1bb92-f604-491d-af16-31e122f24517')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16d1bb92-f604-491d-af16-31e122f24517')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16d1bb92-f604-491d-af16-31e122f24517')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','16d1bb92-f604-491d-af16-31e122f24517')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','35dd291e-fd1e-44d1-8d7b-9237076e3404')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','35dd291e-fd1e-44d1-8d7b-9237076e3404')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','14fbcafc-5e08-4bbc-9e43-27b38d5fe7dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','14fbcafc-5e08-4bbc-9e43-27b38d5fe7dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e6a73802-8eb0-4d26-ac73-557a54645a80')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e6a73802-8eb0-4d26-ac73-557a54645a80')
,('17949107-a0d3-42da-997c-5b70f0831444','0d94feb5-3b22-4eba-803a-133610984702')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0d94feb5-3b22-4eba-803a-133610984702')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0d94feb5-3b22-4eba-803a-133610984702')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','0d94feb5-3b22-4eba-803a-133610984702')
,('17949107-a0d3-42da-997c-5b70f0831444','c0d88fea-18a3-406a-955e-bca893cd2b89')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0d88fea-18a3-406a-955e-bca893cd2b89')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c0d88fea-18a3-406a-955e-bca893cd2b89')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','c0d88fea-18a3-406a-955e-bca893cd2b89')
,('17949107-a0d3-42da-997c-5b70f0831444','a8710acc-1b05-41bb-824f-7de0d54b85b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a8710acc-1b05-41bb-824f-7de0d54b85b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a8710acc-1b05-41bb-824f-7de0d54b85b4')
,('17949107-a0d3-42da-997c-5b70f0831444','cf9d0908-cb0a-47cb-a2a8-674ab0f0c32d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cf9d0908-cb0a-47cb-a2a8-674ab0f0c32d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cf9d0908-cb0a-47cb-a2a8-674ab0f0c32d')
,('17949107-a0d3-42da-997c-5b70f0831444','7099b0ee-b410-4425-857f-49543247e74e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7099b0ee-b410-4425-857f-49543247e74e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7099b0ee-b410-4425-857f-49543247e74e')
,('17949107-a0d3-42da-997c-5b70f0831444','0137d1a6-309c-4f39-a617-23504e6581b7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0137d1a6-309c-4f39-a617-23504e6581b7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0137d1a6-309c-4f39-a617-23504e6581b7')
,('17949107-a0d3-42da-997c-5b70f0831444','aa6b0ea4-1167-4e02-bf08-206b62b163af')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aa6b0ea4-1167-4e02-bf08-206b62b163af')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa6b0ea4-1167-4e02-bf08-206b62b163af')
,('17949107-a0d3-42da-997c-5b70f0831444','828cb4f1-2c31-4876-b55b-4bc294f3b2ca')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','828cb4f1-2c31-4876-b55b-4bc294f3b2ca')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','828cb4f1-2c31-4876-b55b-4bc294f3b2ca')
,('17949107-a0d3-42da-997c-5b70f0831444','3439fc7a-1c5c-4bbe-a127-f81c5d5ca666')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3439fc7a-1c5c-4bbe-a127-f81c5d5ca666')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3439fc7a-1c5c-4bbe-a127-f81c5d5ca666')
,('17949107-a0d3-42da-997c-5b70f0831444','6c107668-e770-450e-9416-e0f61be3d66f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c107668-e770-450e-9416-e0f61be3d66f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6c107668-e770-450e-9416-e0f61be3d66f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','033e1d12-5602-4eda-b146-d2b4cc32c31a')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','033e1d12-5602-4eda-b146-d2b4cc32c31a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','033e1d12-5602-4eda-b146-d2b4cc32c31a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1b9c2cfa-24b8-405d-9a14-89a3cf2976e4')
,('554ec015-b06e-4f6b-b9b3-6e6e37cfb3b4','1b9c2cfa-24b8-405d-9a14-89a3cf2976e4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1b9c2cfa-24b8-405d-9a14-89a3cf2976e4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','527e1f17-3ae0-4f16-91c8-c5a0200edf14')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','527e1f17-3ae0-4f16-91c8-c5a0200edf14')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7f6efaca-2edb-4561-b47d-b4075c297386')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7f6efaca-2edb-4561-b47d-b4075c297386')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','f5b48510-2efc-41ab-81d5-001b489c7db0')
,('17949107-a0d3-42da-997c-5b70f0831444','b370e449-215f-439e-8d20-badafb727109')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','b370e449-215f-439e-8d20-badafb727109')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b370e449-215f-439e-8d20-badafb727109')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b370e449-215f-439e-8d20-badafb727109')
,('17949107-a0d3-42da-997c-5b70f0831444','3788bc08-456f-4106-992d-ef7367ab45c6')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','3788bc08-456f-4106-992d-ef7367ab45c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3788bc08-456f-4106-992d-ef7367ab45c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3788bc08-456f-4106-992d-ef7367ab45c6')
,('17949107-a0d3-42da-997c-5b70f0831444','eccd703f-ed6d-4ca1-9722-531bddb24b06')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','eccd703f-ed6d-4ca1-9722-531bddb24b06')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','eccd703f-ed6d-4ca1-9722-531bddb24b06')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','eccd703f-ed6d-4ca1-9722-531bddb24b06')
,('17949107-a0d3-42da-997c-5b70f0831444','f2490dde-a0ed-4287-b2a7-9a0918d063bc')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','f2490dde-a0ed-4287-b2a7-9a0918d063bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f2490dde-a0ed-4287-b2a7-9a0918d063bc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f2490dde-a0ed-4287-b2a7-9a0918d063bc')
,('17949107-a0d3-42da-997c-5b70f0831444','b412d926-1577-44bc-a1c8-74c42e67f77d')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','b412d926-1577-44bc-a1c8-74c42e67f77d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b412d926-1577-44bc-a1c8-74c42e67f77d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b412d926-1577-44bc-a1c8-74c42e67f77d')
,('17949107-a0d3-42da-997c-5b70f0831444','c5814024-95d3-48fc-8308-a8ef30893c68')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','c5814024-95d3-48fc-8308-a8ef30893c68')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5814024-95d3-48fc-8308-a8ef30893c68')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c5814024-95d3-48fc-8308-a8ef30893c68')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7c78cb59-67c6-4645-8268-f86c17d192a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','58d6815f-d5c0-41c7-a100-cbc2de264c23')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cfab8603-475c-439a-b926-94c9de52c960')
,('17949107-a0d3-42da-997c-5b70f0831444','b401f1b7-fec7-426b-a555-5d62ea01fe1a')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','b401f1b7-fec7-426b-a555-5d62ea01fe1a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b401f1b7-fec7-426b-a555-5d62ea01fe1a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b401f1b7-fec7-426b-a555-5d62ea01fe1a')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','b401f1b7-fec7-426b-a555-5d62ea01fe1a')
,('17949107-a0d3-42da-997c-5b70f0831444','20b58c84-130a-4a7f-84b2-3256976e3067')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','20b58c84-130a-4a7f-84b2-3256976e3067')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','20b58c84-130a-4a7f-84b2-3256976e3067')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','20b58c84-130a-4a7f-84b2-3256976e3067')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','20b58c84-130a-4a7f-84b2-3256976e3067')
,('17949107-a0d3-42da-997c-5b70f0831444','f45e328c-e9d9-4ae9-b8df-b66ce038635a')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','f45e328c-e9d9-4ae9-b8df-b66ce038635a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f45e328c-e9d9-4ae9-b8df-b66ce038635a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f45e328c-e9d9-4ae9-b8df-b66ce038635a')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','f45e328c-e9d9-4ae9-b8df-b66ce038635a')
,('17949107-a0d3-42da-997c-5b70f0831444','2bb7a118-620e-4782-9892-514e6f8c246d')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','2bb7a118-620e-4782-9892-514e6f8c246d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2bb7a118-620e-4782-9892-514e6f8c246d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2bb7a118-620e-4782-9892-514e6f8c246d')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','2bb7a118-620e-4782-9892-514e6f8c246d')
,('17949107-a0d3-42da-997c-5b70f0831444','ee120c13-c5fd-441e-a758-406e0de45302')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','ee120c13-c5fd-441e-a758-406e0de45302')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ee120c13-c5fd-441e-a758-406e0de45302')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ee120c13-c5fd-441e-a758-406e0de45302')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','ee120c13-c5fd-441e-a758-406e0de45302')
,('17949107-a0d3-42da-997c-5b70f0831444','8b5e5d82-c096-4be9-bb86-069ae5f9b7dc')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','8b5e5d82-c096-4be9-bb86-069ae5f9b7dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8b5e5d82-c096-4be9-bb86-069ae5f9b7dc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8b5e5d82-c096-4be9-bb86-069ae5f9b7dc')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','8b5e5d82-c096-4be9-bb86-069ae5f9b7dc')
,('6346d078-65fc-4166-bb2a-33c7c3febc9a','48f07ef2-3631-4207-8fc6-6b22192ac79a')
,('c7e230da-3c22-4915-9ad9-968f874536a5','48f07ef2-3631-4207-8fc6-6b22192ac79a')
,('17949107-a0d3-42da-997c-5b70f0831444','48f07ef2-3631-4207-8fc6-6b22192ac79a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48f07ef2-3631-4207-8fc6-6b22192ac79a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48f07ef2-3631-4207-8fc6-6b22192ac79a')
,('6346d078-65fc-4166-bb2a-33c7c3febc9a','74125319-ed21-40cb-9aad-ce8696c45494')
,('c7e230da-3c22-4915-9ad9-968f874536a5','74125319-ed21-40cb-9aad-ce8696c45494')
,('17949107-a0d3-42da-997c-5b70f0831444','74125319-ed21-40cb-9aad-ce8696c45494')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','74125319-ed21-40cb-9aad-ce8696c45494')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','74125319-ed21-40cb-9aad-ce8696c45494')
,('6346d078-65fc-4166-bb2a-33c7c3febc9a','643c22e4-ec3c-4794-9586-46b6e48456a7')
,('c7e230da-3c22-4915-9ad9-968f874536a5','643c22e4-ec3c-4794-9586-46b6e48456a7')
,('17949107-a0d3-42da-997c-5b70f0831444','643c22e4-ec3c-4794-9586-46b6e48456a7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','643c22e4-ec3c-4794-9586-46b6e48456a7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','643c22e4-ec3c-4794-9586-46b6e48456a7')
,('6346d078-65fc-4166-bb2a-33c7c3febc9a','7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431')
,('c7e230da-3c22-4915-9ad9-968f874536a5','7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431')
,('17949107-a0d3-42da-997c-5b70f0831444','7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7dbc11ee-0a1e-4c3d-b53e-a5dc1d5fc431')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','3b5fcee1-abb3-47cd-8458-154784579250')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b5fcee1-abb3-47cd-8458-154784579250')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b5fcee1-abb3-47cd-8458-154784579250')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','3b5fcee1-abb3-47cd-8458-154784579250')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','b9ae306b-d968-4c59-bd2c-2a314b53bcf6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9ae306b-d968-4c59-bd2c-2a314b53bcf6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9ae306b-d968-4c59-bd2c-2a314b53bcf6')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','b9ae306b-d968-4c59-bd2c-2a314b53bcf6')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d2b4bc2b-3d99-435b-afc8-55a736aec24a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d2b4bc2b-3d99-435b-afc8-55a736aec24a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d2b4bc2b-3d99-435b-afc8-55a736aec24a')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','d2b4bc2b-3d99-435b-afc8-55a736aec24a')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','93ad8f06-a597-4895-840a-fe6f358b1f00')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','93ad8f06-a597-4895-840a-fe6f358b1f00')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','93ad8f06-a597-4895-840a-fe6f358b1f00')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','93ad8f06-a597-4895-840a-fe6f358b1f00')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','e28296fe-b9ca-4d2f-8feb-11b6467e2a82')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e28296fe-b9ca-4d2f-8feb-11b6467e2a82')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e28296fe-b9ca-4d2f-8feb-11b6467e2a82')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','e28296fe-b9ca-4d2f-8feb-11b6467e2a82')
,('f124db40-9975-4d9b-8e04-81cd3ed8d363','acdfa76b-12a8-4869-8284-4d19fdfb5302')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','acdfa76b-12a8-4869-8284-4d19fdfb5302')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','acdfa76b-12a8-4869-8284-4d19fdfb5302')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','acdfa76b-12a8-4869-8284-4d19fdfb5302')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','b21b9a96-6f7f-4d63-a393-553761a32325')
,('17949107-a0d3-42da-997c-5b70f0831444','b21b9a96-6f7f-4d63-a393-553761a32325')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b21b9a96-6f7f-4d63-a393-553761a32325')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b21b9a96-6f7f-4d63-a393-553761a32325')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','b21b9a96-6f7f-4d63-a393-553761a32325')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','bf340b9f-411b-4727-9e44-452d22cb274e')
,('17949107-a0d3-42da-997c-5b70f0831444','bf340b9f-411b-4727-9e44-452d22cb274e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bf340b9f-411b-4727-9e44-452d22cb274e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','bf340b9f-411b-4727-9e44-452d22cb274e')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','bf340b9f-411b-4727-9e44-452d22cb274e')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','7d7ac01c-f6b0-42c7-97f1-732d321e7d99')
,('17949107-a0d3-42da-997c-5b70f0831444','7d7ac01c-f6b0-42c7-97f1-732d321e7d99')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7d7ac01c-f6b0-42c7-97f1-732d321e7d99')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7d7ac01c-f6b0-42c7-97f1-732d321e7d99')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','7d7ac01c-f6b0-42c7-97f1-732d321e7d99')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','9be36d44-5062-47da-aebf-baa1e95aa50c')
,('17949107-a0d3-42da-997c-5b70f0831444','9be36d44-5062-47da-aebf-baa1e95aa50c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9be36d44-5062-47da-aebf-baa1e95aa50c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9be36d44-5062-47da-aebf-baa1e95aa50c')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','9be36d44-5062-47da-aebf-baa1e95aa50c')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','9d8b2b23-968c-4f1f-9af7-6383d4fabb4e')
,('17949107-a0d3-42da-997c-5b70f0831444','9d8b2b23-968c-4f1f-9af7-6383d4fabb4e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9d8b2b23-968c-4f1f-9af7-6383d4fabb4e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9d8b2b23-968c-4f1f-9af7-6383d4fabb4e')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','9d8b2b23-968c-4f1f-9af7-6383d4fabb4e')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','39d6c618-d07f-41d2-9745-e0d0f564aa86')
,('17949107-a0d3-42da-997c-5b70f0831444','39d6c618-d07f-41d2-9745-e0d0f564aa86')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','39d6c618-d07f-41d2-9745-e0d0f564aa86')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','39d6c618-d07f-41d2-9745-e0d0f564aa86')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','39d6c618-d07f-41d2-9745-e0d0f564aa86')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','c1f402e4-ff66-4ba6-896c-75ce577e7b1b')
,('17949107-a0d3-42da-997c-5b70f0831444','c1f402e4-ff66-4ba6-896c-75ce577e7b1b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c1f402e4-ff66-4ba6-896c-75ce577e7b1b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c1f402e4-ff66-4ba6-896c-75ce577e7b1b')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','c1f402e4-ff66-4ba6-896c-75ce577e7b1b')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','cffc36e2-81cf-4cab-b9f8-f7808e7d3449')
,('17949107-a0d3-42da-997c-5b70f0831444','cffc36e2-81cf-4cab-b9f8-f7808e7d3449')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cffc36e2-81cf-4cab-b9f8-f7808e7d3449')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','cffc36e2-81cf-4cab-b9f8-f7808e7d3449')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','cffc36e2-81cf-4cab-b9f8-f7808e7d3449')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','49a307e5-6587-44e2-ae56-bba3089a1e92')
,('17949107-a0d3-42da-997c-5b70f0831444','49a307e5-6587-44e2-ae56-bba3089a1e92')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','49a307e5-6587-44e2-ae56-bba3089a1e92')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','49a307e5-6587-44e2-ae56-bba3089a1e92')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','49a307e5-6587-44e2-ae56-bba3089a1e92')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a99159b8-0f6a-42d9-9e4f-c67023182530')
,('17949107-a0d3-42da-997c-5b70f0831444','a99159b8-0f6a-42d9-9e4f-c67023182530')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a99159b8-0f6a-42d9-9e4f-c67023182530')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a99159b8-0f6a-42d9-9e4f-c67023182530')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','a99159b8-0f6a-42d9-9e4f-c67023182530')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','05bebe39-0ee0-4508-94ff-b50c79148bd8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','05bebe39-0ee0-4508-94ff-b50c79148bd8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','05bebe39-0ee0-4508-94ff-b50c79148bd8')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','05bebe39-0ee0-4508-94ff-b50c79148bd8')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','de0c002f-ca3f-45ff-8a0a-293764b14d81')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','de0c002f-ca3f-45ff-8a0a-293764b14d81')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','de0c002f-ca3f-45ff-8a0a-293764b14d81')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','de0c002f-ca3f-45ff-8a0a-293764b14d81')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','3e3a7f86-7daf-4696-9768-37c8d4b95dd2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3e3a7f86-7daf-4696-9768-37c8d4b95dd2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3e3a7f86-7daf-4696-9768-37c8d4b95dd2')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','3e3a7f86-7daf-4696-9768-37c8d4b95dd2')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','014c143d-6b6c-49f1-876f-3cbe4c1b53b9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','014c143d-6b6c-49f1-876f-3cbe4c1b53b9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','014c143d-6b6c-49f1-876f-3cbe4c1b53b9')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','014c143d-6b6c-49f1-876f-3cbe4c1b53b9')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','aa1a3477-ce1c-44bf-bcd7-14681c56ca6c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aa1a3477-ce1c-44bf-bcd7-14681c56ca6c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','aa1a3477-ce1c-44bf-bcd7-14681c56ca6c')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','aa1a3477-ce1c-44bf-bcd7-14681c56ca6c')
,('17949107-a0d3-42da-997c-5b70f0831444','43c64478-d407-472d-ae62-92b7b306a6ac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','43c64478-d407-472d-ae62-92b7b306a6ac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','43c64478-d407-472d-ae62-92b7b306a6ac')
,('17949107-a0d3-42da-997c-5b70f0831444','77b62ccc-b591-4696-ade9-e16bf59a34c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','77b62ccc-b591-4696-ade9-e16bf59a34c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','77b62ccc-b591-4696-ade9-e16bf59a34c7')
,('17949107-a0d3-42da-997c-5b70f0831444','e9a5fb2c-4284-4699-abed-906136db7d67')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e9a5fb2c-4284-4699-abed-906136db7d67')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e9a5fb2c-4284-4699-abed-906136db7d67')
,('17949107-a0d3-42da-997c-5b70f0831444','75735713-7847-4112-a84d-7886b705fac3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','75735713-7847-4112-a84d-7886b705fac3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','75735713-7847-4112-a84d-7886b705fac3')
,('17949107-a0d3-42da-997c-5b70f0831444','c5307a3e-bd03-4c7d-883a-09ddb943341e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c5307a3e-bd03-4c7d-883a-09ddb943341e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c5307a3e-bd03-4c7d-883a-09ddb943341e')
,('17949107-a0d3-42da-997c-5b70f0831444','67bf41f6-ef09-446e-b930-d0219afa0a57')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','67bf41f6-ef09-446e-b930-d0219afa0a57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','67bf41f6-ef09-446e-b930-d0219afa0a57')
,('17949107-a0d3-42da-997c-5b70f0831444','abf40028-1d34-41ed-b94b-bc088c1a64ae')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','abf40028-1d34-41ed-b94b-bc088c1a64ae')
,('b8094194-ffc5-4091-908d-9fcace16dc71','abf40028-1d34-41ed-b94b-bc088c1a64ae')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','abf40028-1d34-41ed-b94b-bc088c1a64ae')
,('17949107-a0d3-42da-997c-5b70f0831444','0f7d3b74-5650-45c0-9bd2-ff7ff8405fc6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0f7d3b74-5650-45c0-9bd2-ff7ff8405fc6')
,('b8094194-ffc5-4091-908d-9fcace16dc71','0f7d3b74-5650-45c0-9bd2-ff7ff8405fc6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0f7d3b74-5650-45c0-9bd2-ff7ff8405fc6')
,('17949107-a0d3-42da-997c-5b70f0831444','e545892d-349a-410c-a721-643b74f36191')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e545892d-349a-410c-a721-643b74f36191')
,('b8094194-ffc5-4091-908d-9fcace16dc71','e545892d-349a-410c-a721-643b74f36191')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e545892d-349a-410c-a721-643b74f36191')
,('17949107-a0d3-42da-997c-5b70f0831444','90f669b6-e417-408a-bd79-a4e0f8a25dfe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','90f669b6-e417-408a-bd79-a4e0f8a25dfe')
,('b8094194-ffc5-4091-908d-9fcace16dc71','90f669b6-e417-408a-bd79-a4e0f8a25dfe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','90f669b6-e417-408a-bd79-a4e0f8a25dfe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','97952a28-6038-40dc-a1dc-f8a81d0518fe')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','97952a28-6038-40dc-a1dc-f8a81d0518fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0ab9a132-1199-4d21-b096-59f927f3d8e2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0ab9a132-1199-4d21-b096-59f927f3d8e2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2d307902-d5ea-4a18-bd1e-d9419bf112d4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2d307902-d5ea-4a18-bd1e-d9419bf112d4')
,('17949107-a0d3-42da-997c-5b70f0831444','ca9d7959-b260-4d1e-b536-156fec3a812b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ca9d7959-b260-4d1e-b536-156fec3a812b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ca9d7959-b260-4d1e-b536-156fec3a812b')
,('17949107-a0d3-42da-997c-5b70f0831444','b2d1a7a4-babc-45e3-8afd-8207f00a18e6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b2d1a7a4-babc-45e3-8afd-8207f00a18e6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b2d1a7a4-babc-45e3-8afd-8207f00a18e6')
,('17949107-a0d3-42da-997c-5b70f0831444','7128628c-3a1c-4ae4-80c6-e5e07c5ea1df')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7128628c-3a1c-4ae4-80c6-e5e07c5ea1df')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7128628c-3a1c-4ae4-80c6-e5e07c5ea1df')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea1658db-20dc-4483-8fd6-ce1e5bdf29ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b09b4c68-9eb0-4335-ae59-6dc778e0c027')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','98f67b9a-73b1-4086-8107-64a51301d67a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fa5bdd9c-5efc-4ddd-b7c9-251f5d0ab838')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','76ebbdfb-94f1-41b7-a0fa-20ed0b822419')
,('17949107-a0d3-42da-997c-5b70f0831444','76ebbdfb-94f1-41b7-a0fa-20ed0b822419')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','76ebbdfb-94f1-41b7-a0fa-20ed0b822419')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','76ebbdfb-94f1-41b7-a0fa-20ed0b822419')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','76ebbdfb-94f1-41b7-a0fa-20ed0b822419')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','b2c2650a-bee5-4cb0-b5a8-253ff34dea05')
,('17949107-a0d3-42da-997c-5b70f0831444','b2c2650a-bee5-4cb0-b5a8-253ff34dea05')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b2c2650a-bee5-4cb0-b5a8-253ff34dea05')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b2c2650a-bee5-4cb0-b5a8-253ff34dea05')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','b2c2650a-bee5-4cb0-b5a8-253ff34dea05')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','43e2aef7-100f-4601-8792-ba3aa4c0f191')
,('17949107-a0d3-42da-997c-5b70f0831444','43e2aef7-100f-4601-8792-ba3aa4c0f191')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','43e2aef7-100f-4601-8792-ba3aa4c0f191')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','43e2aef7-100f-4601-8792-ba3aa4c0f191')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','43e2aef7-100f-4601-8792-ba3aa4c0f191')
,('17949107-a0d3-42da-997c-5b70f0831444','5da6bda1-c7cb-451d-bda6-3c96bc5cae14')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5da6bda1-c7cb-451d-bda6-3c96bc5cae14')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5da6bda1-c7cb-451d-bda6-3c96bc5cae14')
,('17949107-a0d3-42da-997c-5b70f0831444','5063e2c1-7586-4977-8c21-0f9f24e7b39f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5063e2c1-7586-4977-8c21-0f9f24e7b39f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5063e2c1-7586-4977-8c21-0f9f24e7b39f')
,('17949107-a0d3-42da-997c-5b70f0831444','0f826a3c-8694-4406-8e6a-c30c4b9099b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0f826a3c-8694-4406-8e6a-c30c4b9099b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0f826a3c-8694-4406-8e6a-c30c4b9099b1')
,('17949107-a0d3-42da-997c-5b70f0831444','3c9e6b69-ce38-4979-bca3-aa25ef86f0a9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3c9e6b69-ce38-4979-bca3-aa25ef86f0a9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3c9e6b69-ce38-4979-bca3-aa25ef86f0a9')
,('17949107-a0d3-42da-997c-5b70f0831444','30dd35c8-d442-4322-829d-fd9acba0f724')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30dd35c8-d442-4322-829d-fd9acba0f724')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','30dd35c8-d442-4322-829d-fd9acba0f724')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','61a839f9-b3a1-4b92-b1db-96c6608e93be')
,('17949107-a0d3-42da-997c-5b70f0831444','61a839f9-b3a1-4b92-b1db-96c6608e93be')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','61a839f9-b3a1-4b92-b1db-96c6608e93be')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','61a839f9-b3a1-4b92-b1db-96c6608e93be')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','61a839f9-b3a1-4b92-b1db-96c6608e93be')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','fe957d35-63e8-4620-ad6e-1e4addf0878c')
,('17949107-a0d3-42da-997c-5b70f0831444','fe957d35-63e8-4620-ad6e-1e4addf0878c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fe957d35-63e8-4620-ad6e-1e4addf0878c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fe957d35-63e8-4620-ad6e-1e4addf0878c')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','fe957d35-63e8-4620-ad6e-1e4addf0878c')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','6ee4fa34-1756-41b1-a52b-b31a2f552338')
,('17949107-a0d3-42da-997c-5b70f0831444','6ee4fa34-1756-41b1-a52b-b31a2f552338')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ee4fa34-1756-41b1-a52b-b31a2f552338')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ee4fa34-1756-41b1-a52b-b31a2f552338')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','6ee4fa34-1756-41b1-a52b-b31a2f552338')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a3dd19e2-bedf-4b35-ab42-6a8c6e32c493')
,('17949107-a0d3-42da-997c-5b70f0831444','a3dd19e2-bedf-4b35-ab42-6a8c6e32c493')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a3dd19e2-bedf-4b35-ab42-6a8c6e32c493')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a3dd19e2-bedf-4b35-ab42-6a8c6e32c493')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','a3dd19e2-bedf-4b35-ab42-6a8c6e32c493')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d1e5acfd-e750-4d8a-ac7b-19ea09fd197c')
,('17949107-a0d3-42da-997c-5b70f0831444','d1e5acfd-e750-4d8a-ac7b-19ea09fd197c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d1e5acfd-e750-4d8a-ac7b-19ea09fd197c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d1e5acfd-e750-4d8a-ac7b-19ea09fd197c')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','d1e5acfd-e750-4d8a-ac7b-19ea09fd197c')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1')
,('17949107-a0d3-42da-997c-5b70f0831444','a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','a7a8aad3-e0f1-4cf5-a0c0-08a78d020cb1')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','120f6046-96d3-4e30-a967-ebdb72fd4be8')
,('17949107-a0d3-42da-997c-5b70f0831444','120f6046-96d3-4e30-a967-ebdb72fd4be8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','120f6046-96d3-4e30-a967-ebdb72fd4be8')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','120f6046-96d3-4e30-a967-ebdb72fd4be8')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','120f6046-96d3-4e30-a967-ebdb72fd4be8')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','2269185a-7af9-47d4-95f3-8bfdd77c1161')
,('17949107-a0d3-42da-997c-5b70f0831444','2269185a-7af9-47d4-95f3-8bfdd77c1161')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2269185a-7af9-47d4-95f3-8bfdd77c1161')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2269185a-7af9-47d4-95f3-8bfdd77c1161')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','2269185a-7af9-47d4-95f3-8bfdd77c1161')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','5306579d-53be-429c-81ea-26567a9157d2')
,('17949107-a0d3-42da-997c-5b70f0831444','5306579d-53be-429c-81ea-26567a9157d2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5306579d-53be-429c-81ea-26567a9157d2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5306579d-53be-429c-81ea-26567a9157d2')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','5306579d-53be-429c-81ea-26567a9157d2')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','a7b8b6fe-4e7c-4a70-962e-430a6b446f84')
,('17949107-a0d3-42da-997c-5b70f0831444','a7b8b6fe-4e7c-4a70-962e-430a6b446f84')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a7b8b6fe-4e7c-4a70-962e-430a6b446f84')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a7b8b6fe-4e7c-4a70-962e-430a6b446f84')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','a7b8b6fe-4e7c-4a70-962e-430a6b446f84')
,('17949107-a0d3-42da-997c-5b70f0831444','b4ec3e4a-54d4-4c65-a061-57be553d0b77')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b4ec3e4a-54d4-4c65-a061-57be553d0b77')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b4ec3e4a-54d4-4c65-a061-57be553d0b77')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','b4ec3e4a-54d4-4c65-a061-57be553d0b77')
,('17949107-a0d3-42da-997c-5b70f0831444','451f2ebf-54c9-45f1-9062-c95ce8010afa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','451f2ebf-54c9-45f1-9062-c95ce8010afa')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','451f2ebf-54c9-45f1-9062-c95ce8010afa')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','451f2ebf-54c9-45f1-9062-c95ce8010afa')
,('17949107-a0d3-42da-997c-5b70f0831444','3b76fcad-e73c-462e-8e32-24717e00b0cb')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3b76fcad-e73c-462e-8e32-24717e00b0cb')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3b76fcad-e73c-462e-8e32-24717e00b0cb')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','3b76fcad-e73c-462e-8e32-24717e00b0cb')
,('17949107-a0d3-42da-997c-5b70f0831444','d3ffc515-edcd-44af-8723-612242eb9daf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d3ffc515-edcd-44af-8723-612242eb9daf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d3ffc515-edcd-44af-8723-612242eb9daf')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','d3ffc515-edcd-44af-8723-612242eb9daf')
,('17949107-a0d3-42da-997c-5b70f0831444','de18145c-9bdb-474e-bdcb-be64ff36bc1c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','de18145c-9bdb-474e-bdcb-be64ff36bc1c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','de18145c-9bdb-474e-bdcb-be64ff36bc1c')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','de18145c-9bdb-474e-bdcb-be64ff36bc1c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65f9f3be-5d2a-4364-9d5f-7209ad6285d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','29c6f51e-3fd9-42ab-aedd-80ddd316aff7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8aba69b-d281-4257-8ea9-967e9df526d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','135b9454-b82d-48c0-aedd-f011caae37c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','533e70c0-d0e1-4890-a5f6-7616e8c3d4c8')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','607eb948-a701-44fd-bf85-2cd8a5f08cfe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','62c98dd4-7a04-4f61-bf12-fa3e8af38539')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8bd45a5e-322b-4a4e-99c6-d84cb5a1d141')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','25b54f37-9398-41e4-94e4-2c42445bbf5e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','932567e0-acf1-44ab-9a11-54ebffba9baa')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b98964ed-4ed5-407f-a63f-ba2da0e4adc2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d0631ae4-99aa-404e-ad76-d6009c94ff2c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c2b87a3e-6d13-478f-9f69-63c5253313f7')
,('c7e230da-3c22-4915-9ad9-968f874536a5','8a0db450-a2b3-4500-95fe-699f0ef29974')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8a0db450-a2b3-4500-95fe-699f0ef29974')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','7c164d72-40c5-45e1-bbd6-0efef5fab9da')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','50bd97f9-5eb1-4b84-b0e7-7476ede6a02a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','089792e2-0d31-472b-8b1e-a77c4b1dfff5')
,('17949107-a0d3-42da-997c-5b70f0831444','8997d399-daf0-4918-bb5a-9752a3108c6e')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','8997d399-daf0-4918-bb5a-9752a3108c6e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8997d399-daf0-4918-bb5a-9752a3108c6e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8997d399-daf0-4918-bb5a-9752a3108c6e')
,('17949107-a0d3-42da-997c-5b70f0831444','3a98d3b7-33f2-4ebe-b8bd-f55ee6f04c57')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','3a98d3b7-33f2-4ebe-b8bd-f55ee6f04c57')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3a98d3b7-33f2-4ebe-b8bd-f55ee6f04c57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3a98d3b7-33f2-4ebe-b8bd-f55ee6f04c57')
,('17949107-a0d3-42da-997c-5b70f0831444','71bd3ede-ad9d-4705-8478-c8764e87cb38')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','71bd3ede-ad9d-4705-8478-c8764e87cb38')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','71bd3ede-ad9d-4705-8478-c8764e87cb38')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','71bd3ede-ad9d-4705-8478-c8764e87cb38')
,('17949107-a0d3-42da-997c-5b70f0831444','0e9b2055-a431-4f42-afae-9736b9a33544')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','0e9b2055-a431-4f42-afae-9736b9a33544')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0e9b2055-a431-4f42-afae-9736b9a33544')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0e9b2055-a431-4f42-afae-9736b9a33544')
,('17949107-a0d3-42da-997c-5b70f0831444','682efef6-a4d6-4d42-bed1-dd9e74129da3')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','682efef6-a4d6-4d42-bed1-dd9e74129da3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','682efef6-a4d6-4d42-bed1-dd9e74129da3')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','682efef6-a4d6-4d42-bed1-dd9e74129da3')
,('17949107-a0d3-42da-997c-5b70f0831444','2e909828-9c7c-4f64-82c6-5e2f9df8875d')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','2e909828-9c7c-4f64-82c6-5e2f9df8875d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e909828-9c7c-4f64-82c6-5e2f9df8875d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2e909828-9c7c-4f64-82c6-5e2f9df8875d')
,('17949107-a0d3-42da-997c-5b70f0831444','0f6d0462-2f7f-4f89-b8a1-39df560ca6dd')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','0f6d0462-2f7f-4f89-b8a1-39df560ca6dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0f6d0462-2f7f-4f89-b8a1-39df560ca6dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0f6d0462-2f7f-4f89-b8a1-39df560ca6dd')
,('17949107-a0d3-42da-997c-5b70f0831444','7650e614-c530-48bf-b97e-1d80478f8f04')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','7650e614-c530-48bf-b97e-1d80478f8f04')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7650e614-c530-48bf-b97e-1d80478f8f04')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7650e614-c530-48bf-b97e-1d80478f8f04')
,('17949107-a0d3-42da-997c-5b70f0831444','e8e2dd6f-f52d-4fe3-a898-0f6932161798')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','e8e2dd6f-f52d-4fe3-a898-0f6932161798')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e8e2dd6f-f52d-4fe3-a898-0f6932161798')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e8e2dd6f-f52d-4fe3-a898-0f6932161798')
,('17949107-a0d3-42da-997c-5b70f0831444','6ce66440-c3f0-4c2f-a407-954ed95a916c')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','6ce66440-c3f0-4c2f-a407-954ed95a916c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6ce66440-c3f0-4c2f-a407-954ed95a916c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6ce66440-c3f0-4c2f-a407-954ed95a916c')
,('17949107-a0d3-42da-997c-5b70f0831444','30fd9377-056c-4384-b8e7-62990cc80c63')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','30fd9377-056c-4384-b8e7-62990cc80c63')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30fd9377-056c-4384-b8e7-62990cc80c63')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','30fd9377-056c-4384-b8e7-62990cc80c63')
,('17949107-a0d3-42da-997c-5b70f0831444','e06b8ed7-32fd-407d-b32a-d3a945466b37')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','e06b8ed7-32fd-407d-b32a-d3a945466b37')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e06b8ed7-32fd-407d-b32a-d3a945466b37')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e06b8ed7-32fd-407d-b32a-d3a945466b37')
,('17949107-a0d3-42da-997c-5b70f0831444','d1685c34-4022-4ba5-9fcb-447cffc3d3bf')
,('44d897e1-fc5e-4667-84a7-ed4414165e33','d1685c34-4022-4ba5-9fcb-447cffc3d3bf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d1685c34-4022-4ba5-9fcb-447cffc3d3bf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d1685c34-4022-4ba5-9fcb-447cffc3d3bf')
,('17949107-a0d3-42da-997c-5b70f0831444','5efa4635-1e79-41a9-9c0c-85975570f2c6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5efa4635-1e79-41a9-9c0c-85975570f2c6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5efa4635-1e79-41a9-9c0c-85975570f2c6')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','5efa4635-1e79-41a9-9c0c-85975570f2c6')
,('17949107-a0d3-42da-997c-5b70f0831444','8dd2d190-e509-4a20-8db8-704271c89a42')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8dd2d190-e509-4a20-8db8-704271c89a42')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8dd2d190-e509-4a20-8db8-704271c89a42')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','8dd2d190-e509-4a20-8db8-704271c89a42')
,('17949107-a0d3-42da-997c-5b70f0831444','97f7fc7b-2735-49c9-89fd-6037853a139f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','97f7fc7b-2735-49c9-89fd-6037853a139f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','97f7fc7b-2735-49c9-89fd-6037853a139f')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','97f7fc7b-2735-49c9-89fd-6037853a139f')
,('17949107-a0d3-42da-997c-5b70f0831444','e903b201-0ff6-4060-8cda-b37f5283b3ac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e903b201-0ff6-4060-8cda-b37f5283b3ac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e903b201-0ff6-4060-8cda-b37f5283b3ac')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','e903b201-0ff6-4060-8cda-b37f5283b3ac')
,('17949107-a0d3-42da-997c-5b70f0831444','2d409bac-c4f0-4152-ba1e-1648d0d2e8d0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2d409bac-c4f0-4152-ba1e-1648d0d2e8d0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2d409bac-c4f0-4152-ba1e-1648d0d2e8d0')
,('17949107-a0d3-42da-997c-5b70f0831444','7f5d6eb9-9bb6-46c6-8947-40e5cfbb1887')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7f5d6eb9-9bb6-46c6-8947-40e5cfbb1887')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7f5d6eb9-9bb6-46c6-8947-40e5cfbb1887')
,('17949107-a0d3-42da-997c-5b70f0831444','1fb23c66-236c-451b-be1f-57770aa5aa8f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1fb23c66-236c-451b-be1f-57770aa5aa8f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1fb23c66-236c-451b-be1f-57770aa5aa8f')
,('17949107-a0d3-42da-997c-5b70f0831444','9322c7cb-320d-42e5-aa79-c7f36935fd65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9322c7cb-320d-42e5-aa79-c7f36935fd65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9322c7cb-320d-42e5-aa79-c7f36935fd65')
,('17949107-a0d3-42da-997c-5b70f0831444','026421ba-5bce-45da-bd25-474386630895')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','026421ba-5bce-45da-bd25-474386630895')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','026421ba-5bce-45da-bd25-474386630895')
,('17949107-a0d3-42da-997c-5b70f0831444','f08ccdac-06f1-468a-98a4-96198e5e5b7d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f08ccdac-06f1-468a-98a4-96198e5e5b7d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f08ccdac-06f1-468a-98a4-96198e5e5b7d')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','f08ccdac-06f1-468a-98a4-96198e5e5b7d')
,('17949107-a0d3-42da-997c-5b70f0831444','7aff899c-cd3d-4d7b-bdf0-10d1961e2a8f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7aff899c-cd3d-4d7b-bdf0-10d1961e2a8f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7aff899c-cd3d-4d7b-bdf0-10d1961e2a8f')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','7aff899c-cd3d-4d7b-bdf0-10d1961e2a8f')
,('17949107-a0d3-42da-997c-5b70f0831444','60dd4b96-6374-4415-a5f7-d81fa90df8dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','60dd4b96-6374-4415-a5f7-d81fa90df8dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','60dd4b96-6374-4415-a5f7-d81fa90df8dd')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','60dd4b96-6374-4415-a5f7-d81fa90df8dd')
,('17949107-a0d3-42da-997c-5b70f0831444','9c8f4578-6144-46fa-87b7-bb30b16239cf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9c8f4578-6144-46fa-87b7-bb30b16239cf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9c8f4578-6144-46fa-87b7-bb30b16239cf')
,('d3999613-30a5-44f1-bcb8-1391bef45b96','9c8f4578-6144-46fa-87b7-bb30b16239cf')
,('17949107-a0d3-42da-997c-5b70f0831444','ea183614-dd10-42de-be71-8c27ef1f80c7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ea183614-dd10-42de-be71-8c27ef1f80c7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ea183614-dd10-42de-be71-8c27ef1f80c7')
,('17949107-a0d3-42da-997c-5b70f0831444','e078d511-012f-4f2b-b975-8dc8e02408b0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e078d511-012f-4f2b-b975-8dc8e02408b0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e078d511-012f-4f2b-b975-8dc8e02408b0')
,('17949107-a0d3-42da-997c-5b70f0831444','55b6226a-c090-4ad1-84fb-77c093bdd12b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','55b6226a-c090-4ad1-84fb-77c093bdd12b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','55b6226a-c090-4ad1-84fb-77c093bdd12b')
,('17949107-a0d3-42da-997c-5b70f0831444','b0025386-e7ce-41cf-bfec-4d4294fa284c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0025386-e7ce-41cf-bfec-4d4294fa284c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0025386-e7ce-41cf-bfec-4d4294fa284c')
,('17949107-a0d3-42da-997c-5b70f0831444','4881a830-f318-4f86-83d4-a3bf78a4da24')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4881a830-f318-4f86-83d4-a3bf78a4da24')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4881a830-f318-4f86-83d4-a3bf78a4da24')
,('17949107-a0d3-42da-997c-5b70f0831444','48346b94-9cd2-411c-b2e7-76671f862a00')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','48346b94-9cd2-411c-b2e7-76671f862a00')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','48346b94-9cd2-411c-b2e7-76671f862a00')
,('17949107-a0d3-42da-997c-5b70f0831444','2ae5ccce-85b8-4c88-9ead-819d5bb8fd26')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2ae5ccce-85b8-4c88-9ead-819d5bb8fd26')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2ae5ccce-85b8-4c88-9ead-819d5bb8fd26')
,('17949107-a0d3-42da-997c-5b70f0831444','8d92567c-00ac-4a3f-98dd-393f410de062')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d92567c-00ac-4a3f-98dd-393f410de062')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8d92567c-00ac-4a3f-98dd-393f410de062')
,('17949107-a0d3-42da-997c-5b70f0831444','781cf868-8c62-416a-90ec-3835cc0bf1dd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','781cf868-8c62-416a-90ec-3835cc0bf1dd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','781cf868-8c62-416a-90ec-3835cc0bf1dd')
,('17949107-a0d3-42da-997c-5b70f0831444','8376e4c1-5210-4cf1-ae3f-d5fa3354bd82')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8376e4c1-5210-4cf1-ae3f-d5fa3354bd82')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8376e4c1-5210-4cf1-ae3f-d5fa3354bd82')
,('17949107-a0d3-42da-997c-5b70f0831444','c8eac661-21b6-444e-9615-c220e7251612')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c8eac661-21b6-444e-9615-c220e7251612')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c8eac661-21b6-444e-9615-c220e7251612')
,('17949107-a0d3-42da-997c-5b70f0831444','28ab6e65-2fa3-4d08-a2db-7bbae603361f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','28ab6e65-2fa3-4d08-a2db-7bbae603361f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','28ab6e65-2fa3-4d08-a2db-7bbae603361f')
,('17949107-a0d3-42da-997c-5b70f0831444','381eb988-de7e-46be-87a0-ca9e84750e5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','381eb988-de7e-46be-87a0-ca9e84750e5b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','381eb988-de7e-46be-87a0-ca9e84750e5b')
,('17949107-a0d3-42da-997c-5b70f0831444','1682abea-6bf9-4918-91d5-0058868ae58d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1682abea-6bf9-4918-91d5-0058868ae58d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1682abea-6bf9-4918-91d5-0058868ae58d')
,('17949107-a0d3-42da-997c-5b70f0831444','827e7a8e-4738-4c1b-9bd9-980b856d62df')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','827e7a8e-4738-4c1b-9bd9-980b856d62df')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','827e7a8e-4738-4c1b-9bd9-980b856d62df')
,('17949107-a0d3-42da-997c-5b70f0831444','e61360bd-c9f0-4586-a1ba-87ecd10d1aac')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e61360bd-c9f0-4586-a1ba-87ecd10d1aac')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e61360bd-c9f0-4586-a1ba-87ecd10d1aac')
,('17949107-a0d3-42da-997c-5b70f0831444','10df8781-99aa-44e1-a731-b4eab2a468b4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','10df8781-99aa-44e1-a731-b4eab2a468b4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','10df8781-99aa-44e1-a731-b4eab2a468b4')
,('17949107-a0d3-42da-997c-5b70f0831444','4ae80ef4-1382-4d24-95e1-2cfaca881c65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4ae80ef4-1382-4d24-95e1-2cfaca881c65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4ae80ef4-1382-4d24-95e1-2cfaca881c65')
,('17949107-a0d3-42da-997c-5b70f0831444','42e0d3e4-d7aa-456d-94cc-ea046c96ccb7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','42e0d3e4-d7aa-456d-94cc-ea046c96ccb7')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','42e0d3e4-d7aa-456d-94cc-ea046c96ccb7')
,('17949107-a0d3-42da-997c-5b70f0831444','23a5d12d-16fe-4c05-9590-4dde12d52a3d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','23a5d12d-16fe-4c05-9590-4dde12d52a3d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','23a5d12d-16fe-4c05-9590-4dde12d52a3d')
,('17949107-a0d3-42da-997c-5b70f0831444','56e0bebb-9c5b-4c1d-9794-522b86d7ce36')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','56e0bebb-9c5b-4c1d-9794-522b86d7ce36')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','56e0bebb-9c5b-4c1d-9794-522b86d7ce36')
,('17949107-a0d3-42da-997c-5b70f0831444','71370ed1-77e3-49f1-a8d4-557a4a501d29')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','71370ed1-77e3-49f1-a8d4-557a4a501d29')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','71370ed1-77e3-49f1-a8d4-557a4a501d29')
,('17949107-a0d3-42da-997c-5b70f0831444','2932ea90-5a90-4a50-99fa-80a77abf1f6c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2932ea90-5a90-4a50-99fa-80a77abf1f6c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','2932ea90-5a90-4a50-99fa-80a77abf1f6c')
,('17949107-a0d3-42da-997c-5b70f0831444','70f1817f-3c57-420f-8391-082a6416ba86')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','70f1817f-3c57-420f-8391-082a6416ba86')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','70f1817f-3c57-420f-8391-082a6416ba86')
,('17949107-a0d3-42da-997c-5b70f0831444','6dccf861-c16e-4940-9c8a-85bbeffbb61a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6dccf861-c16e-4940-9c8a-85bbeffbb61a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6dccf861-c16e-4940-9c8a-85bbeffbb61a')
,('17949107-a0d3-42da-997c-5b70f0831444','84bbf43b-fc6c-47c8-ae15-784b47aa9f34')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','84bbf43b-fc6c-47c8-ae15-784b47aa9f34')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','84bbf43b-fc6c-47c8-ae15-784b47aa9f34')
,('17949107-a0d3-42da-997c-5b70f0831444','69ad8ebc-8b63-459b-922d-d3a3d00ca465')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69ad8ebc-8b63-459b-922d-d3a3d00ca465')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69ad8ebc-8b63-459b-922d-d3a3d00ca465')
,('17949107-a0d3-42da-997c-5b70f0831444','5e0a12b3-72ec-4625-b194-eaa3925ea084')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','5e0a12b3-72ec-4625-b194-eaa3925ea084')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5e0a12b3-72ec-4625-b194-eaa3925ea084')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5e0a12b3-72ec-4625-b194-eaa3925ea084')
,('17949107-a0d3-42da-997c-5b70f0831444','adcf3d32-6a5f-413d-87c5-54508e73704e')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','adcf3d32-6a5f-413d-87c5-54508e73704e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','adcf3d32-6a5f-413d-87c5-54508e73704e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','adcf3d32-6a5f-413d-87c5-54508e73704e')
,('17949107-a0d3-42da-997c-5b70f0831444','403927ae-cdfa-4d1b-a54e-dcd66e401cee')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','403927ae-cdfa-4d1b-a54e-dcd66e401cee')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','403927ae-cdfa-4d1b-a54e-dcd66e401cee')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','403927ae-cdfa-4d1b-a54e-dcd66e401cee')
,('17949107-a0d3-42da-997c-5b70f0831444','0c9fd115-95c0-4fa7-a37a-973e51216fa6')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','0c9fd115-95c0-4fa7-a37a-973e51216fa6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0c9fd115-95c0-4fa7-a37a-973e51216fa6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0c9fd115-95c0-4fa7-a37a-973e51216fa6')
,('17949107-a0d3-42da-997c-5b70f0831444','491f290d-8d58-41cf-a48e-71f56d95a0b1')
,('342347b7-d78b-4c9f-b9be-6422977d8a79','491f290d-8d58-41cf-a48e-71f56d95a0b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','491f290d-8d58-41cf-a48e-71f56d95a0b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','491f290d-8d58-41cf-a48e-71f56d95a0b1')
,('e837e90d-d57f-4271-a606-3965b0e9f9b9','238dbfd3-bdb1-4604-8efa-9ae0574ebcc6')
,('17949107-a0d3-42da-997c-5b70f0831444','238dbfd3-bdb1-4604-8efa-9ae0574ebcc6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','238dbfd3-bdb1-4604-8efa-9ae0574ebcc6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','238dbfd3-bdb1-4604-8efa-9ae0574ebcc6')
,('e837e90d-d57f-4271-a606-3965b0e9f9b9','4f0d7fd4-3bf9-431e-9e9c-67cbe2c907bc')
,('17949107-a0d3-42da-997c-5b70f0831444','4f0d7fd4-3bf9-431e-9e9c-67cbe2c907bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4f0d7fd4-3bf9-431e-9e9c-67cbe2c907bc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4f0d7fd4-3bf9-431e-9e9c-67cbe2c907bc')
,('e837e90d-d57f-4271-a606-3965b0e9f9b9','5793859e-5c51-4fd1-abc0-fc39706e328c')
,('17949107-a0d3-42da-997c-5b70f0831444','5793859e-5c51-4fd1-abc0-fc39706e328c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5793859e-5c51-4fd1-abc0-fc39706e328c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5793859e-5c51-4fd1-abc0-fc39706e328c')
,('e837e90d-d57f-4271-a606-3965b0e9f9b9','9c17590b-d993-445d-b3a0-ebec07b393f6')
,('17949107-a0d3-42da-997c-5b70f0831444','9c17590b-d993-445d-b3a0-ebec07b393f6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9c17590b-d993-445d-b3a0-ebec07b393f6')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9c17590b-d993-445d-b3a0-ebec07b393f6')
,('17949107-a0d3-42da-997c-5b70f0831444','83766785-7dc3-4488-a1c7-ef6abb945d57')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','83766785-7dc3-4488-a1c7-ef6abb945d57')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','83766785-7dc3-4488-a1c7-ef6abb945d57')
,('17949107-a0d3-42da-997c-5b70f0831444','fdc6e7dd-fa58-45dc-b62d-dfaf6fa35222')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fdc6e7dd-fa58-45dc-b62d-dfaf6fa35222')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','fdc6e7dd-fa58-45dc-b62d-dfaf6fa35222')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','fdc6e7dd-fa58-45dc-b62d-dfaf6fa35222')
,('17949107-a0d3-42da-997c-5b70f0831444','6b0e00f1-49b4-4cc9-ad03-e6520f0bf152')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6b0e00f1-49b4-4cc9-ad03-e6520f0bf152')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','6b0e00f1-49b4-4cc9-ad03-e6520f0bf152')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','6b0e00f1-49b4-4cc9-ad03-e6520f0bf152')
,('17949107-a0d3-42da-997c-5b70f0831444','f35deab4-1752-4f5c-a2fa-ecba884c2b88')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f35deab4-1752-4f5c-a2fa-ecba884c2b88')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f35deab4-1752-4f5c-a2fa-ecba884c2b88')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','f35deab4-1752-4f5c-a2fa-ecba884c2b88')
,('17949107-a0d3-42da-997c-5b70f0831444','514e44fe-3aca-48e5-8beb-31b60b5be919')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','514e44fe-3aca-48e5-8beb-31b60b5be919')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','514e44fe-3aca-48e5-8beb-31b60b5be919')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','514e44fe-3aca-48e5-8beb-31b60b5be919')
,('17949107-a0d3-42da-997c-5b70f0831444','505b430e-0f3e-4b21-9956-ac2f5a443c7d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','505b430e-0f3e-4b21-9956-ac2f5a443c7d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','505b430e-0f3e-4b21-9956-ac2f5a443c7d')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','505b430e-0f3e-4b21-9956-ac2f5a443c7d')
,('17949107-a0d3-42da-997c-5b70f0831444','66cf227c-2f9b-455c-aee8-aada17b93490')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','66cf227c-2f9b-455c-aee8-aada17b93490')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','66cf227c-2f9b-455c-aee8-aada17b93490')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','66cf227c-2f9b-455c-aee8-aada17b93490')
,('17949107-a0d3-42da-997c-5b70f0831444','1cc63521-2624-48a2-b957-004f9896f5ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1cc63521-2624-48a2-b957-004f9896f5ab')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1cc63521-2624-48a2-b957-004f9896f5ab')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','1cc63521-2624-48a2-b957-004f9896f5ab')
,('17949107-a0d3-42da-997c-5b70f0831444','5669e084-6246-4df9-9b24-ef8fd8fc1986')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5669e084-6246-4df9-9b24-ef8fd8fc1986')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','5669e084-6246-4df9-9b24-ef8fd8fc1986')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','5669e084-6246-4df9-9b24-ef8fd8fc1986')
,('17949107-a0d3-42da-997c-5b70f0831444','1d61e155-307c-489f-8c93-5e85076f3b65')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1d61e155-307c-489f-8c93-5e85076f3b65')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','1d61e155-307c-489f-8c93-5e85076f3b65')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','1d61e155-307c-489f-8c93-5e85076f3b65')
,('17949107-a0d3-42da-997c-5b70f0831444','71b0f0a7-fa56-4a5f-8b5d-828f1c26cd27')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','71b0f0a7-fa56-4a5f-8b5d-828f1c26cd27')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','71b0f0a7-fa56-4a5f-8b5d-828f1c26cd27')
,('4c9fd1f7-7a2c-4bea-ba8d-18ef93e7888d','71b0f0a7-fa56-4a5f-8b5d-828f1c26cd27')
,('17949107-a0d3-42da-997c-5b70f0831444','4e117b6a-7447-4bad-b80f-3171a12d48a0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4e117b6a-7447-4bad-b80f-3171a12d48a0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4e117b6a-7447-4bad-b80f-3171a12d48a0')
,('17949107-a0d3-42da-997c-5b70f0831444','569a979b-225c-457a-ae13-dca7d6e960f9')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','569a979b-225c-457a-ae13-dca7d6e960f9')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','569a979b-225c-457a-ae13-dca7d6e960f9')
,('17949107-a0d3-42da-997c-5b70f0831444','e79fde9a-b513-4776-8bf5-f657cd115215')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e79fde9a-b513-4776-8bf5-f657cd115215')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','e79fde9a-b513-4776-8bf5-f657cd115215')
,('17949107-a0d3-42da-997c-5b70f0831444','16d111be-7665-4df1-b05b-28263b73ffb2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','16d111be-7665-4df1-b05b-28263b73ffb2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','16d111be-7665-4df1-b05b-28263b73ffb2')
,('17949107-a0d3-42da-997c-5b70f0831444','17c3482a-e09e-4f36-a030-62600bb6342f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','17c3482a-e09e-4f36-a030-62600bb6342f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','17c3482a-e09e-4f36-a030-62600bb6342f')
,('17949107-a0d3-42da-997c-5b70f0831444','602e271e-2049-4009-9293-8fde7e54b601')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','602e271e-2049-4009-9293-8fde7e54b601')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','602e271e-2049-4009-9293-8fde7e54b601')
,('17949107-a0d3-42da-997c-5b70f0831444','b9b4186d-7fad-4940-acb7-1fd9f2086bb4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b9b4186d-7fad-4940-acb7-1fd9f2086bb4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b9b4186d-7fad-4940-acb7-1fd9f2086bb4')
,('17949107-a0d3-42da-997c-5b70f0831444','142d3993-aea7-44ce-82ff-6b9a4aabd3fd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','142d3993-aea7-44ce-82ff-6b9a4aabd3fd')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','142d3993-aea7-44ce-82ff-6b9a4aabd3fd')
,('17949107-a0d3-42da-997c-5b70f0831444','b6d7a908-c602-4735-86cd-1f7d8b20ec08')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b6d7a908-c602-4735-86cd-1f7d8b20ec08')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b6d7a908-c602-4735-86cd-1f7d8b20ec08')
,('17949107-a0d3-42da-997c-5b70f0831444','0d67621d-e2d6-4457-bd6f-d40df681f43f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0d67621d-e2d6-4457-bd6f-d40df681f43f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0d67621d-e2d6-4457-bd6f-d40df681f43f')
,('17949107-a0d3-42da-997c-5b70f0831444','a0ce43dc-4793-43d6-9684-47ced2b8d0ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a0ce43dc-4793-43d6-9684-47ced2b8d0ab')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a0ce43dc-4793-43d6-9684-47ced2b8d0ab')
,('17949107-a0d3-42da-997c-5b70f0831444','201c7452-6897-4483-937f-0e0c9febd745')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','201c7452-6897-4483-937f-0e0c9febd745')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','201c7452-6897-4483-937f-0e0c9febd745')
,('17949107-a0d3-42da-997c-5b70f0831444','f6a082dd-e61c-4a7f-9bc0-82a83b61262d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f6a082dd-e61c-4a7f-9bc0-82a83b61262d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f6a082dd-e61c-4a7f-9bc0-82a83b61262d')
,('17949107-a0d3-42da-997c-5b70f0831444','3985b6cd-629e-4591-8249-f9c51080ca33')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3985b6cd-629e-4591-8249-f9c51080ca33')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3985b6cd-629e-4591-8249-f9c51080ca33')
,('17949107-a0d3-42da-997c-5b70f0831444','272e4473-e29e-43ba-b48c-76b5781a8e06')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','272e4473-e29e-43ba-b48c-76b5781a8e06')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','272e4473-e29e-43ba-b48c-76b5781a8e06')
,('17949107-a0d3-42da-997c-5b70f0831444','601912fc-bf31-45ff-aadc-c89b176924ff')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','601912fc-bf31-45ff-aadc-c89b176924ff')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','601912fc-bf31-45ff-aadc-c89b176924ff')
,('17949107-a0d3-42da-997c-5b70f0831444','8207e31e-42c4-41ce-98f3-3bb69a3a117d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8207e31e-42c4-41ce-98f3-3bb69a3a117d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8207e31e-42c4-41ce-98f3-3bb69a3a117d')
,('17949107-a0d3-42da-997c-5b70f0831444','4416db34-641b-4eb2-ac0b-a84eaa3452d4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4416db34-641b-4eb2-ac0b-a84eaa3452d4')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4416db34-641b-4eb2-ac0b-a84eaa3452d4')
,('17949107-a0d3-42da-997c-5b70f0831444','c46248b7-e326-48dd-901a-a740393bbd88')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c46248b7-e326-48dd-901a-a740393bbd88')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','c46248b7-e326-48dd-901a-a740393bbd88')
,('17949107-a0d3-42da-997c-5b70f0831444','40d70704-35f8-4960-81da-c94a7cc2b34e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','40d70704-35f8-4960-81da-c94a7cc2b34e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','40d70704-35f8-4960-81da-c94a7cc2b34e')
,('17949107-a0d3-42da-997c-5b70f0831444','4b37c6a4-c3f2-4636-8df3-84981427212c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4b37c6a4-c3f2-4636-8df3-84981427212c')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4b37c6a4-c3f2-4636-8df3-84981427212c')
,('17949107-a0d3-42da-997c-5b70f0831444','618c736d-5684-43d2-a237-89195221a7da')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','618c736d-5684-43d2-a237-89195221a7da')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','618c736d-5684-43d2-a237-89195221a7da')
,('17949107-a0d3-42da-997c-5b70f0831444','69136838-c18a-4541-8528-77df5bb6a0f2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','69136838-c18a-4541-8528-77df5bb6a0f2')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','69136838-c18a-4541-8528-77df5bb6a0f2')
,('17949107-a0d3-42da-997c-5b70f0831444','d4231e4a-0d7a-4a04-8c9a-bc409e2136b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d4231e4a-0d7a-4a04-8c9a-bc409e2136b1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d4231e4a-0d7a-4a04-8c9a-bc409e2136b1')
,('17949107-a0d3-42da-997c-5b70f0831444','55bc3ae2-f25b-4dda-ae7f-d1a1becaebdc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','55bc3ae2-f25b-4dda-ae7f-d1a1becaebdc')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','55bc3ae2-f25b-4dda-ae7f-d1a1becaebdc')
,('17949107-a0d3-42da-997c-5b70f0831444','939a2e9a-c92b-4112-a3cb-e26cc56b7b35')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','939a2e9a-c92b-4112-a3cb-e26cc56b7b35')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','939a2e9a-c92b-4112-a3cb-e26cc56b7b35')
,('17949107-a0d3-42da-997c-5b70f0831444','4254330d-9928-4339-883c-c7dc31e8c036')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4254330d-9928-4339-883c-c7dc31e8c036')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','4254330d-9928-4339-883c-c7dc31e8c036')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','abb6b44a-a2f9-460d-a25d-70adc1875522')
,('17949107-a0d3-42da-997c-5b70f0831444','abb6b44a-a2f9-460d-a25d-70adc1875522')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','abb6b44a-a2f9-460d-a25d-70adc1875522')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','abb6b44a-a2f9-460d-a25d-70adc1875522')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','abb6b44a-a2f9-460d-a25d-70adc1875522')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','948fc8e7-dd15-42e5-924e-425ed93734c5')
,('17949107-a0d3-42da-997c-5b70f0831444','948fc8e7-dd15-42e5-924e-425ed93734c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','948fc8e7-dd15-42e5-924e-425ed93734c5')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','948fc8e7-dd15-42e5-924e-425ed93734c5')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','948fc8e7-dd15-42e5-924e-425ed93734c5')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','f196e5ea-68b7-4ea4-859d-094bfd9f19cf')
,('17949107-a0d3-42da-997c-5b70f0831444','f196e5ea-68b7-4ea4-859d-094bfd9f19cf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f196e5ea-68b7-4ea4-859d-094bfd9f19cf')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','f196e5ea-68b7-4ea4-859d-094bfd9f19cf')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','f196e5ea-68b7-4ea4-859d-094bfd9f19cf')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e')
,('17949107-a0d3-42da-997c-5b70f0831444','d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','d34eca6c-29cc-4f8a-8b45-f43fc9c2d76e')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','b0aa3cbf-52fb-4430-a1e9-9680e7023454')
,('17949107-a0d3-42da-997c-5b70f0831444','b0aa3cbf-52fb-4430-a1e9-9680e7023454')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0aa3cbf-52fb-4430-a1e9-9680e7023454')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','b0aa3cbf-52fb-4430-a1e9-9680e7023454')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','b0aa3cbf-52fb-4430-a1e9-9680e7023454')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','0184daef-b371-4913-96ec-e2187979a8db')
,('17949107-a0d3-42da-997c-5b70f0831444','0184daef-b371-4913-96ec-e2187979a8db')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0184daef-b371-4913-96ec-e2187979a8db')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','0184daef-b371-4913-96ec-e2187979a8db')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','0184daef-b371-4913-96ec-e2187979a8db')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','07331b5d-b704-432a-8e51-eb5f82ce376a')
,('17949107-a0d3-42da-997c-5b70f0831444','07331b5d-b704-432a-8e51-eb5f82ce376a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','07331b5d-b704-432a-8e51-eb5f82ce376a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','07331b5d-b704-432a-8e51-eb5f82ce376a')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','07331b5d-b704-432a-8e51-eb5f82ce376a')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','31af4d53-3eee-46fa-bc15-ff9399588050')
,('17949107-a0d3-42da-997c-5b70f0831444','31af4d53-3eee-46fa-bc15-ff9399588050')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','31af4d53-3eee-46fa-bc15-ff9399588050')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','31af4d53-3eee-46fa-bc15-ff9399588050')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','31af4d53-3eee-46fa-bc15-ff9399588050')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','3da07f86-d887-44e1-8fd3-ce3ad8d074e0')
,('17949107-a0d3-42da-997c-5b70f0831444','3da07f86-d887-44e1-8fd3-ce3ad8d074e0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3da07f86-d887-44e1-8fd3-ce3ad8d074e0')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','3da07f86-d887-44e1-8fd3-ce3ad8d074e0')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','3da07f86-d887-44e1-8fd3-ce3ad8d074e0')
,('17261ec2-82c2-449b-a58d-588b74f5a2f5','df11e4f7-ba6d-4879-974a-e4ff71cf749d')
,('17949107-a0d3-42da-997c-5b70f0831444','df11e4f7-ba6d-4879-974a-e4ff71cf749d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df11e4f7-ba6d-4879-974a-e4ff71cf749d')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df11e4f7-ba6d-4879-974a-e4ff71cf749d')
,('b273f9c4-a11f-4e01-aba4-0e626cbb2f2e','df11e4f7-ba6d-4879-974a-e4ff71cf749d')
,('17949107-a0d3-42da-997c-5b70f0831444','ac291ab0-29b1-4c17-be8c-1476cb02a572')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ac291ab0-29b1-4c17-be8c-1476cb02a572')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','ac291ab0-29b1-4c17-be8c-1476cb02a572')
,('17949107-a0d3-42da-997c-5b70f0831444','9adcc527-ddba-4474-a6c3-3ffd6fba5c3e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','9adcc527-ddba-4474-a6c3-3ffd6fba5c3e')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','9adcc527-ddba-4474-a6c3-3ffd6fba5c3e')
,('17949107-a0d3-42da-997c-5b70f0831444','8f0c7c03-5234-483f-a8f9-40b89809827b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8f0c7c03-5234-483f-a8f9-40b89809827b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','8f0c7c03-5234-483f-a8f9-40b89809827b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','93d7f4cb-d26a-4ee2-bf0e-9e3e434a34c1')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','93d7f4cb-d26a-4ee2-bf0e-9e3e434a34c1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','976e277c-6745-4eb4-ba21-f09b7e7bcd2b')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','976e277c-6745-4eb4-ba21-f09b7e7bcd2b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','7b803fd8-7b46-4ff5-a759-b6a93e83f39f')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','7b803fd8-7b46-4ff5-a759-b6a93e83f39f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','223fa84c-724a-4431-82be-ccd74ea7042a')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','223fa84c-724a-4431-82be-ccd74ea7042a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','97b0d801-c21a-4abd-82b1-825f7dae8979')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','97b0d801-c21a-4abd-82b1-825f7dae8979')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a864932d-6585-40df-b56a-601232d7de87')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','a864932d-6585-40df-b56a-601232d7de87')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','333461b6-99c6-47b4-b86e-d5a2a6e02d87')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','333461b6-99c6-47b4-b86e-d5a2a6e02d87')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','333461b6-99c6-47b4-b86e-d5a2a6e02d87')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','5b31c15b-0efb-45c6-9e63-edd77ada86f1')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','5b31c15b-0efb-45c6-9e63-edd77ada86f1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5b31c15b-0efb-45c6-9e63-edd77ada86f1')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','c541910b-1446-4e12-a435-5abb903c324d')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','c541910b-1446-4e12-a435-5abb903c324d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c541910b-1446-4e12-a435-5abb903c324d')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','3f456852-d9b4-4e54-9e34-25353703118f')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','3f456852-d9b4-4e54-9e34-25353703118f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3f456852-d9b4-4e54-9e34-25353703118f')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','c9041a1c-8c1b-497a-94a8-e137457557c5')
,('83f24db5-32e0-4c1a-9d85-c649de5dfd50','c9041a1c-8c1b-497a-94a8-e137457557c5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c9041a1c-8c1b-497a-94a8-e137457557c5')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','30b992b3-22cd-406e-9c0d-7d745bef3bc4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30b992b3-22cd-406e-9c0d-7d745bef3bc4')
,('3f29763e-aa51-4e87-8667-86c39fed8251','30b992b3-22cd-406e-9c0d-7d745bef3bc4')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','a35ec0cd-78e5-44a8-bd18-5a6864091a12')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a35ec0cd-78e5-44a8-bd18-5a6864091a12')
,('3f29763e-aa51-4e87-8667-86c39fed8251','a35ec0cd-78e5-44a8-bd18-5a6864091a12')
,('371fcc76-3fe4-4c3a-9d47-5cb0dae54592','0b2cd780-7366-470a-973f-88b009338914')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0b2cd780-7366-470a-973f-88b009338914')
,('3f29763e-aa51-4e87-8667-86c39fed8251','0b2cd780-7366-470a-973f-88b009338914')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','75b47b66-5b2c-4360-8a79-527c99d755ef')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0cef4959-6d5c-4cfe-b2ab-69102ce798ab')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6c3eea3d-14f8-4c4f-9b51-a04d391134d5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b32431cb-e087-4b2f-913b-bd026a9a398a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','42f59a96-5dd3-45e2-99fc-7c0e0165544e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','30a5f87f-a37e-405b-9b93-d17df7fc635c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bef4f3c2-e346-4064-a0a0-80e4485e0239')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','af9f21d1-2788-4eb5-ad8a-ae2ebab04d8b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d0015155-7523-42d9-adc9-f19a0549b605')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','885e84f4-11fc-4481-b892-a221bc47d599')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','ab37d1c8-5d1e-4169-beb8-b24f9a0e9828')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8c9e5cef-ab86-4a4b-8478-c0f1ad0d1ffd')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dcaedc3d-8d93-4d75-99a5-48f865d664d3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8da41c39-b41e-4116-9d76-1cb36d947faf')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','50700215-703d-4d01-8acf-fedac0fa40de')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','3f4c2861-459e-400c-bb8c-adfb29c67877')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5cf8f321-0871-4cac-a1cc-b73ad9e8bb6e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f6c66192-cf5f-4e2e-b98e-665938894472')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','78225dab-f8e0-49a2-8ca3-a14735aa0412')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','bbfc4cf1-1c45-4fdb-a486-29eb6ee84f5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','05e9c267-c1eb-4f94-8e7d-93c274ebdda7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cc594afa-635e-4c73-acb9-da25f8a77bb4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','81d16efd-885b-4bff-ad84-c06ad0c38dd5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','86d16141-1ac0-4aa1-a5a0-738cc5cb8b2c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','aef0cb0c-e668-4286-b89e-64b20c234742')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','13b3ac16-aa8f-48a5-82fa-3e66c8124659')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6baad905-6fa2-47d0-97b3-43bd3aec75fe')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','dbc3b827-ef80-42a4-bcab-763ede9ccb20')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','52c2b573-e920-4476-9b2b-6d3b8239d6b0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1f649ff2-a771-4de1-9211-3e8536e6d727')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a86de4df-0612-4147-95e5-d17883ed6812')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2971274d-cba1-47b0-ae07-d031ee3b7303')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6b0cc0c2-9da3-4e1b-a948-bbc1fc162b5d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5175fc10-e0ae-44e1-94e5-3775a7157bff')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b1472723-4a03-4936-bba1-6e2dd8230d30')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a741056b-0267-4175-887c-a700fbcfa01b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cd8d4452-6cc1-4ee7-b1e4-8a6b43b71c3d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a1d8f586-4e22-4126-8907-906da699cdc0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8706650f-b465-43d2-accf-a2d354b0a0b5')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c0ba36f0-8ee8-4d9b-8e14-19c73b16db02')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6351d4f8-94f8-440c-a076-5aa415292364')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','6847a624-9894-4851-965a-7239a3705f56')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b0074f4e-ffc8-4a69-acf0-0c33ac13c3b1')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','660d4047-7f9c-40a1-a148-dc9d8759a598')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','65af5e91-6a54-45b3-9fa6-d3f13f3274bc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c7b5c16d-8d5c-42ac-a9d2-1934f998ef03')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','fb3d19ee-dfa9-44f0-adaf-79330b105c30')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1ee3fb3f-bec9-4ee5-85d8-2ea6a646e5ef')
,('223f4787-af72-40d1-986e-51d048898c9d','412dd280-9bf1-476d-b4bc-419973ef878c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','412dd280-9bf1-476d-b4bc-419973ef878c')
,('223f4787-af72-40d1-986e-51d048898c9d','599fe5fc-bc00-476c-9678-2098538cdc5c')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','599fe5fc-bc00-476c-9678-2098538cdc5c')
,('223f4787-af72-40d1-986e-51d048898c9d','5ed85717-4802-4e32-a333-7b8c7508c28d')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','5ed85717-4802-4e32-a333-7b8c7508c28d')
,('223f4787-af72-40d1-986e-51d048898c9d','15dca0bb-9e84-41fd-80f1-4fc06d057c71')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','15dca0bb-9e84-41fd-80f1-4fc06d057c71')
,('223f4787-af72-40d1-986e-51d048898c9d','1868b15c-1380-415d-8c6d-99cf75720141')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1868b15c-1380-415d-8c6d-99cf75720141')
,('223f4787-af72-40d1-986e-51d048898c9d','8ba820a2-2c83-4dcb-b166-5e279dbc011a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8ba820a2-2c83-4dcb-b166-5e279dbc011a')
,('223f4787-af72-40d1-986e-51d048898c9d','8d573932-9b80-47bb-9171-1646db12d2ec')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','8d573932-9b80-47bb-9171-1646db12d2ec')
,('223f4787-af72-40d1-986e-51d048898c9d','007d82f6-8d83-4060-86de-194483bf5acc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','007d82f6-8d83-4060-86de-194483bf5acc')
,('223f4787-af72-40d1-986e-51d048898c9d','914f6a03-b9c9-4dbc-951a-cbfbe4ad19ea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','914f6a03-b9c9-4dbc-951a-cbfbe4ad19ea')
,('223f4787-af72-40d1-986e-51d048898c9d','c3fa5dec-fd2e-461e-9929-84f7fd1952dc')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c3fa5dec-fd2e-461e-9929-84f7fd1952dc')
,('223f4787-af72-40d1-986e-51d048898c9d','a715e78f-9b00-4655-905e-7b4b2941a294')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a715e78f-9b00-4655-905e-7b4b2941a294')
,('223f4787-af72-40d1-986e-51d048898c9d','cbbb52ca-398b-4f91-9e02-d06c4bc7cf9a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','cbbb52ca-398b-4f91-9e02-d06c4bc7cf9a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4a90871b-4c48-4e8d-b7b6-3c2849bd8926')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f0084385-02d5-43ca-921b-a75651f2d46f')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','f6f1445d-7888-46f6-8bf7-91d5c50949e0')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','0fbda0ec-8efe-4f54-9d1a-fdad0a354bd3')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d14c3892-6330-4ee0-b27c-3aed699ff867')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','b4215cac-294a-4c62-a714-5387ef91170a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1778a774-4abe-4d33-a255-e9fe1630f8c4')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','2e2738cc-afe9-43ae-a126-0e9eddcedd5b')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','53357435-5037-4117-84f8-6d5224db0ee7')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e9985b9c-50de-4b5e-826b-4e072785ed5e')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','427be9f7-b209-44e1-8dfa-a96883c3fe46')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','21b298f6-9f8e-4e69-83eb-82a444a42695')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','911ec8d6-263f-4264-8b6c-88f49277573a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','a38c36bc-077c-48db-bc8e-a65a1e789070')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','c27beb40-378e-451a-a2f3-dfa49808a25a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','4769aaa0-aaff-4799-9744-640b7035b766')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','761655fa-eae3-40e5-b3b1-1257dc7f0788')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','d915bc8f-1f31-4d41-8abc-200d41fecdea')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','40e5f357-dc26-4ec9-9840-bea664f5cba2')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','1d4b276f-abf1-46f8-b469-8b9caa4adcb6')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','be387638-12e8-44b8-9225-77d5d81cda0a')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','df0027d1-8a90-4220-9861-eb6233a20e23')
,('07f4ef9d-607c-4c83-80ec-47c25fe7d248','df0027d1-8a90-4220-9861-eb6233a20e23')
,('ddd15703-21c8-4eac-b6f4-8c640c6180da','e625c4fb-52dd-48fb-b7c9-d5e7a1d5b230')
,('4b055876-e210-4e43-aea3-9167e5afb724','e625c4fb-52dd-48fb-b7c9-d5e7a1d5b230')
;