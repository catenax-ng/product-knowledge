DROP TABLE IF EXISTS kba CASCADE;

CREATE TABLE kba (
    "index" INTEGER PRIMARY KEY,
    herst_schluessel TEXT NOT NULL,
    typ_schluessel TEXT NOT NULL,	
    fahrzeugklasse TEXT NOT NULL,
    handelsname	TEXT NOT NULL,
    amtl_klartext_typ	TEXT NOT NULL,
    amtl_aufbau	TEXT,
    anzachs	TEXT NOT NULL,
    antriebsachs TEXT ,	
    techzulgesamtm	TEXT NOT NULL,
    code_kraftstoff	TEXT NOT NULL,
    nennleistkw_4	TEXT NOT NULL,
    genehmigungsnr	TEXT NOT NULL,
    genehmigungsdat	TEXT NOT NULL,
    baumuster	TEXT NOT NULL,
    hubraum	TEXT ,
    code_getrtyp	TEXT,
    standgeraeusch_3	TEXT,
    fahrgeraeusch_3	TEXT,
    sld	TEXT,
    eurostufe	TEXT,
    abgasrichtl	TEXT NOT NULL,
    prfver1co	NUMERIC,
    prfver1hc	NUMERIC,
    prfver1nox	NUMERIC,
    prfver1hcplusnox	NUMERIC,
    prfver1partikel	NUMERIC,
    prfver1rauch	NUMERIC,
    prfbivalentco	NUMERIC,
    prfbivalenthc	NUMERIC,
    prfbivalentnox	NUMERIC ,
    prfbivalenthcplusnox	NUMERIC,
    prfbivalentpartikel	NUMERIC,
    prfbivalentrauch	NUMERIC,
    prftypico	NUMERIC,
    prftypithc	NUMERIC,
    prftypinmhc	NUMERIC,
    prftypinox	NUMERIC,
    prftypihcplusnox	NUMERIC,
    prftypinh3	NUMERIC,
    prftypipartikel	NUMERIC,
    prftypipartikelzahl	NUMERIC,
    prftypipartikelzexp	NUMERIC,
    prftypibivco	NUMERIC,
    prftypibivthc	NUMERIC,
    prftypibivnmhc	NUMERIC,
    prftypibivnox	NUMERIC,
    prftypibivhcplusnox	NUMERIC,
    prftypibivnh3	NUMERIC,
    prftypibivpartikel	NUMERIC,
    prftypibivpartikelzahl	NUMERIC,
    prftypibivpartikelzexp	NUMERIC,
    prftypisonstigeco	NUMERIC,
    prftypisonstigethc	NUMERIC,
    prftypisonstigenmhc	NUMERIC,
    prftypisonstigenox	NUMERIC,
    prftypisonstigehcplusnox	NUMERIC,
    prftypisonstigenh3	NUMERIC,
    prftypisonstigepartikel	NUMERIC,
    prftypisonstigepartikelzahl	NUMERIC,
    prftypisonstigepartikelzexp	NUMERIC,
    prf2_1co	NUMERIC,
    prf2_1nox	NUMERIC,
    prf2_1nmhc	NUMERIC,
    prf2_1thc	NUMERIC,
    prf2_1ch4	NUMERIC,
    prf2_1partikel	NUMERIC,
    prf2_1bivco	NUMERIC,
    prf2_1bivnox	NUMERIC,
    prf2_1bivnmhc	NUMERIC,
    prf2_1bivthc	NUMERIC,
    prf2_1bivch4	NUMERIC,
    prf2_1bivpartikel	NUMERIC,
    prf2_2co	NUMERIC,
    prf2_2nox	NUMERIC,
    prf2_2nmhc	NUMERIC,
    prf2_2thc	NUMERIC,
    prf2_2ch4	NUMERIC,
    prf2_2nh3	NUMERIC,
    prf2_2partikel	NUMERIC,
    prf2_2partikelzahl	NUMERIC,
    prf2_2partikelzexp	NUMERIC,
    prf2_2bivco	NUMERIC,
    prf2_2bivnox	NUMERIC,
    prf2_2bivnmhc	NUMERIC,
    prf2_2bivthc	NUMERIC,
    prf2_2bivch4	NUMERIC,
    prf2_2bivnh3	NUMERIC,
    prf2_2bivpartikel	NUMERIC,
    prf2_2bivpartikelzahl	NUMERIC,
    prf2_2bivpartikelzexp	NUMERIC,
    prf2_2sonstigeco	NUMERIC,
    prf2_2sonstigenox	NUMERIC,
    prf2_2sonstigenmhc	NUMERIC,
    prf2_2sonstigethc	NUMERIC,
    prf2_2sonstigech4	NUMERIC,
    prf2_2sonstigenh3	NUMERIC,
    prf2_2sonstigepartikel	NUMERIC,
    prf2_2sonstigepartikelzahl	NUMERIC,
    prf2_2sonstigepartikelzexp	NUMERIC,
    rauch	NUMERIC,
    co2innerortbenzindiesel	NUMERIC,
    co2aussortbenzindiesel	NUMERIC,
    co2kombibenzindiesel	NUMERIC,
    co2gewichtet	NUMERIC,
    verbrliterinnort	NUMERIC,
    verbrliteraussort	NUMERIC,
    verbrliterkombi	NUMERIC,
    verbrlitergewichtet	NUMERIC,
    co2innerortgas	NUMERIC,
    co2aussortgas	NUMERIC,
    co2kombigas	NUMERIC,
    co2gewichtetgas	NUMERIC,
    verbrkubikminnort	NUMERIC,
    verbrkubikmaussort	NUMERIC,
    verbrkubikmkombi	NUMERIC,
    verbrgasgewichtet	NUMERIC,
    co2innerortsonstige	NUMERIC,
    co2aussortsonstige	NUMERIC,
    co2kombisonstige	NUMERIC,
    co2gewichtetsonstige	NUMERIC,
    verbrsonstigeinnort	NUMERIC,
    verbrsonstigeaussort	NUMERIC,
    verbrsonstigekombi	NUMERIC,
    verbrsonstigegewichtet	NUMERIC,
    verbrelektrokombi	NUMERIC,
    reichwelektro	NUMERIC,
    code_oekoinnovation	TEXT,
    tx_oekoinnovation	TEXT,
    codeoekoinnovation	TEXT,
    eingespco2emibenzindiesel	NUMERIC,
    eingespco2emigas	NUMERIC,
    eingespco2emisonstige	NUMERIC,
    cogkmfzkll	NUMERIC,
    hcgkmfzkll	NUMERIC,
    noxgkmfzkll	NUMERIC,
    hcplusnoxgkmfzkll	NUMERIC,
    cogminfzkll	NUMERIC,
    hcgminfzkll	NUMERIC,
    co_prozfzkll	NUMERIC,
    korrwertfzkll	NUMERIC,
    euronorm TEXT
);

COPY kba
FROM '/tmp/data/kba_202303091401.csv'
DELIMITER ','
CSV HEADER;

DROP TABLE IF EXISTS vehicle_type CASCADE;
CREATE TABLE IF NOT EXISTS vehicle_type AS (
  SELECT 
    herst_schluessel,
    typ_schluessel,
    MIN("index") as "index",
    MIN(fahrzeugklasse) as fahrzeugklasse,
    MIN(CASE 
         WHEN fahrzeugklasse like 'L1e%' THEN 'Leichtes 2-rädrige Kraftfahrzeug' 
         WHEN fahrzeugklasse like 'L2e%' THEN '2-rädriges Kleinkraftrad' 
         WHEN fahrzeugklasse like 'L3e%' THEN 'Zweirädriges Kraftrad'
         WHEN fahrzeugklasse like 'L4e%' THEN 'Zweirädriges Kraftrad mit Beiwagen'
         WHEN fahrzeugklasse like 'L5e%' THEN 'Dreirädriges Kraftfahrzeug'
         WHEN fahrzeugklasse like 'L6e%' THEN 'Leichtes Vierrädriges Kraftfahrzeug'
         WHEN fahrzeugklasse like 'L7e%' THEN 'Schweres Vierrädriges Kraftfahrzeug'
         WHEN fahrzeugklasse like 'M1G%' THEN 'Geländefahrzeug zur Personenbeförderung' 
         WHEN fahrzeugklasse like 'M1%' THEN 'Kraftfahrzeug zur Personenbeförderung' 
         WHEN fahrzeugklasse like 'M2G%' THEN 'Geländefahrzeug zur Personenbeförderung mit mehr als 8 Sitzplätzen' 
         WHEN fahrzeugklasse like 'M2%' THEN 'Kraftfahrzeug zur Personenbeförderung mit mehr als 8 Sitzplätzen' 
         WHEN fahrzeugklasse like 'M3G%' THEN 'Geländefahrzeug zur Personenbeförderung  mit mehr als 5t' 
         WHEN fahrzeugklasse like 'M3%' THEN 'Kraftfahrzeug zur Personenbeförderung mit mehr als 5t' 
         WHEN fahrzeugklasse like 'N1G%' THEN 'Geländefahrzeug zur Güterbeföderung bis 3,5t' 
         WHEN fahrzeugklasse like 'N1%' THEN 'Kraftfahrzeug zur Güterbeföderung bis 3,5t' 
         WHEN fahrzeugklasse like 'N2G%' THEN 'Geländefahrzeug zur Güterbeföderung bis 12t' 
         WHEN fahrzeugklasse like 'N2%' THEN 'Kraftfahrzeug zur Güterbeföderung bis 12t' 
         WHEN fahrzeugklasse like 'N3G%' THEN 'Geländefahrzeug zur Güterbeföderung über 12t' 
         WHEN fahrzeugklasse like 'N3%' THEN 'Kraftfahrzeug zur Güterbeföderung über 12t' 
         WHEN fahrzeugklasse like 'O1%' THEN 'Anhänger bis 0,75t' 
         WHEN fahrzeugklasse like 'O2%' THEN 'Anhänger bis 3,5t' 
         WHEN fahrzeugklasse like 'O3%' THEN 'Anhänger bis 10t' 
         WHEN fahrzeugklasse like 'O4%' THEN 'Anhänger über 10t' 
         WHEN fahrzeugklasse like 'R1%' THEN 'Land- oder forstwirtschaftlicher Anhänger bis 1,5t je Achse' 
         WHEN fahrzeugklasse like 'R2%' THEN 'Land- oder forstwirtschaftlicher Anhänger bis 3,5t je Achse' 
         WHEN fahrzeugklasse like 'R3%' THEN 'Land- oder forstwirtschaftlicher Anhänger bis 21t je Achse' 
         WHEN fahrzeugklasse like 'R4%' THEN 'Land- oder forstwirtschaftlicher Anhänger über 21t je Achse' 
         WHEN fahrzeugklasse like 'S1%' THEN 'Gezogenes auswechselbares Gerät für die Land- oder Forstwirtschaft bis 3,5t je Achse' 
         WHEN fahrzeugklasse like 'S2%' THEN 'Gezogenes auswechselbares Gerät für die Land- oder Forstwirtschaft über 3,5t je Achse' 
         WHEN fahrzeugklasse like 'T%' THEN 'Land- oder forstwirtschaftliche Zugmaschine auf Rädern' 
         WHEN fahrzeugklasse like 'C%' THEN 'Zugmaschine auf Gleisketten' 
         ELSE 'UNBEKANNT' 
        END) AS amtl_klartext_fahrzeugklasse,
    MIN(handelsname) as handelsname,
    MIN(amtl_klartext_typ) as amtl_klartext_typ,
    MIN(amtl_aufbau) as amtl_aufbau,
    MIN(CASE 
         WHEN amtl_aufbau like 'AA%' THEN 'Limousine' 
         WHEN amtl_aufbau like 'AB%' THEN 'Schräghecklimousine' 
         WHEN amtl_aufbau like 'AC%' THEN 'Kombilimousine' 
         WHEN amtl_aufbau like 'AD%' THEN 'Coupé' 
         WHEN amtl_aufbau like 'AE%' THEN 'Kabrio-Limousine' 
         WHEN amtl_aufbau like 'AF%' THEN 'Mehrzweckfahrzeug' 
         WHEN amtl_aufbau like 'AG%' THEN 'Pkw-Pick-up' 
         WHEN amtl_aufbau like 'BA%' THEN 'Lastkraftwagen' 
         WHEN amtl_aufbau like 'BB%' THEN 'Van' 
         WHEN amtl_aufbau like 'BC%' THEN 'Sattelzugmaschine' 
         WHEN amtl_aufbau like 'BD%' THEN 'Straßenzugmaschine' 
         WHEN amtl_aufbau like 'BE%' THEN 'Pick-up' 
         WHEN amtl_aufbau like 'BX%' THEN 'Unvollständiges N-Fahrzeug' 
         WHEN amtl_aufbau like 'DA%' THEN 'Sattelanhänger' 
         WHEN amtl_aufbau like 'DB%' THEN 'Deichselanhänger' 
         WHEN amtl_aufbau like 'DC%' THEN 'Zentralachsanhänger' 
         WHEN amtl_aufbau like 'DE%' THEN 'Anh.m.starr.Zugeinrichtg.' 
         WHEN amtl_aufbau like 'SA%' THEN 'Wohnmobil' 
         WHEN amtl_aufbau like 'SB%' THEN 'Beschussgeschützt' 
         WHEN amtl_aufbau like 'SC%' THEN 'Krankenwagen' 
         WHEN amtl_aufbau like 'SD%' THEN 'Leichenwagen' 
         WHEN amtl_aufbau like 'SE%' THEN 'Wohnanhänger' 
         WHEN amtl_aufbau like 'SG%' THEN 'Sonstige' 
         WHEN amtl_aufbau like 'SJ%' THEN 'Untersetzachse (Dolly) K' 
         WHEN amtl_aufbau like 'SK%' THEN 'Anhänger f. Schwertransport' 
         WHEN amtl_aufbau like 'SM%' THEN 'Geräteträger' 
         WHEN amtl_aufbau like 'SH%' THEN 'Rollstuhlgerecht' 
         WHEN amtl_aufbau like 'CA%' THEN 'Eindecker' 
         WHEN amtl_aufbau like 'CB%' THEN 'Doppeldecker' 
         WHEN amtl_aufbau like 'CC%' THEN 'EDeck-Gelenkfz' 
         WHEN amtl_aufbau like 'CD%' THEN 'DDeck-Gelenkfz' 
         WHEN amtl_aufbau like 'CE%' THEN 'EDeck-Niederflurfz' 
         WHEN amtl_aufbau like 'CF%' THEN 'DDeck-Niederflurfz' 
         WHEN amtl_aufbau like 'CG%' THEN 'EDeckNiederflurgelenkfz' 
         WHEN amtl_aufbau like 'CH%' THEN 'DDeckNiederflurgelenkfz ' 
         WHEN amtl_aufbau like 'CI%' THEN 'Offenes EDeckfz' 
         WHEN amtl_aufbau like 'CJ%' THEN 'Offenes DDeckfz' 
         WHEN amtl_aufbau like 'CK%' THEN 'EDeckGel KLII' 
         WHEN amtl_aufbau like 'CL%' THEN 'DDeckGel KLII' 
         WHEN amtl_aufbau like 'CM%' THEN 'EDeckNfl KLII' 
         WHEN amtl_aufbau like 'CN%' THEN 'DDeckNfl KLII' 
         WHEN amtl_aufbau like 'CO%' THEN 'EDeckNflGel KLII' 
         WHEN amtl_aufbau like 'CP%' THEN 'DDeckNflGel KLII' 
         WHEN amtl_aufbau like 'CQ%' THEN 'EDeck KL III' 
         WHEN amtl_aufbau like 'CR%' THEN 'DDeck KL III' 
         WHEN amtl_aufbau like 'CS%' THEN 'EDeckGel KLIII' 
         WHEN amtl_aufbau like 'CT%' THEN 'DDeckGel KLIII' 
         WHEN amtl_aufbau like 'CU%' THEN 'EDeck KL A' 
         WHEN amtl_aufbau like 'CV%' THEN 'EDeckNfl KL A' 
         WHEN amtl_aufbau like 'CW%' THEN 'EDeck KL B' 
         WHEN amtl_aufbau like 'CX%' THEN 'Unvollständiges Fahrzeug' 
         ELSE 'UNBEKANNT' 
        END ) AS amtl_klartext_aufbau,
    MIN(anzachs) as anzachs,
    MIN(antriebsachs) as antriebsachs,
    MIN(code_kraftstoff) as code_kraftstoff,
    MIN(nennleistkw_4) as nennleistkw_4,
    MIN(genehmigungsnr) as genehmigungsnr,
    MIN(genehmigungsdat) as genehmigungsdat,
    MIN(baumuster) as baumuster,
    MIN(hubraum) as hubraum,
    MIN(sld) as sld,
    MIN(coalesce(eurostufe,euronorm)) as eurostufe,
    MIN(abgasrichtl) as abgasrichtl,
    MIN(code_oekoinnovation) as code_oekoinnovation
  FROM (
    SELECT 
       herst_schluessel,
       typ_schluessel,
       FIRST_VALUE("index") OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS "index",
       FIRST_VALUE(fahrzeugklasse) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS fahrzeugklasse,
       FIRST_VALUE(handelsname) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS handelsname,
       FIRST_VALUE(amtl_klartext_typ) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS amtl_klartext_typ,
       FIRST_VALUE(amtl_aufbau) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS amtl_aufbau,
       FIRST_VALUE(anzachs) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS anzachs,
       FIRST_VALUE(antriebsachs) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS antriebsachs,
       FIRST_VALUE(code_kraftstoff) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS code_kraftstoff,
       FIRST_VALUE(nennleistkw_4) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS nennleistkw_4,
       FIRST_VALUE(genehmigungsnr) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS genehmigungsnr,
       FIRST_VALUE(genehmigungsdat) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS genehmigungsdat,
       FIRST_VALUE(baumuster) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS baumuster,
       FIRST_VALUE(hubraum) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS hubraum,
       FIRST_VALUE(sld) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS sld,
       FIRST_VALUE(eurostufe) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS eurostufe,
       FIRST_VALUE(euronorm) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS euronorm,
       FIRST_VALUE(abgasrichtl) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS abgasrichtl,
       FIRST_VALUE(code_oekoinnovation) OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS code_oekoinnovation
    FROM kba
  ) kba_unique GROUP BY herst_schluessel, typ_schluessel
);

CREATE UNIQUE INDEX ON vehicle_type("index");
CREATE UNIQUE INDEX ON vehicle_type(herst_schluessel,typ_schluessel);

DROP TABLE IF EXISTS vehicle_model CASCADE;
CREATE TABLE IF NOT EXISTS vehicle_model AS (
  SELECT 
    herst_schluessel,
    typ_schluessel,
    code_getrtyp,
    CASE 
      WHEN code_getrtyp = 'A0' THEN 'Manuelle Schaltung'
      WHEN  code_getrtyp = 'A1' THEN 'Automatische Schaltung'
      ELSE 'UNBEKANNT'
    END AS amt_klartext_getrtyp,
    MIN("index") as "index",
    MIN(typ_index) as typ_index,
    MIN(techzulgesamtm) as techzulgesamtm
  FROM (
    SELECT 
       herst_schluessel,
       typ_schluessel,
       code_getrtyp,
       FIRST_VALUE("index") OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp ORDER BY "index" DESC) AS "index",
       FIRST_VALUE("index") OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS typ_index,
       FIRST_VALUE(techzulgesamtm) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp ORDER BY "index" DESC) AS techzulgesamtm
    FROM kba
  ) kba_unique GROUP BY herst_schluessel, typ_schluessel, code_getrtyp
);

CREATE UNIQUE INDEX ON vehicle_model("index");
CREATE UNIQUE INDEX ON vehicle_model(herst_schluessel,typ_schluessel, code_getrtyp);
CREATE INDEX ON vehicle_model(typ_index);

ALTER TABLE vehicle_model ADD FOREIGN KEY(typ_index) REFERENCES vehicle_type("index");
ALTER TABLE vehicle_model ADD FOREIGN KEY(herst_schluessel,typ_schluessel) REFERENCES vehicle_type(herst_schluessel,typ_schluessel);

DROP TABLE IF EXISTS vehicle_model_registration CASCADE;
CREATE TABLE IF NOT EXISTS vehicle_model_registration AS (
  SELECT 
    herst_schluessel,
    typ_schluessel,
    code_getrtyp,
    "index",
    MIN(model_index) as model_index,
    MIN(typ_index) as typ_index,
    MIN(standgeraeusch_3) as standgeraeusch_3,
    MIN(fahrgeraeusch_3) as fahrgeraeusch_3,
    MIN(COALESCE(prftypico,cogkmfzkll)) as prftypico,
    MIN(COALESCE(prftypithc,hcgkmfzkll)) as prftypithc,
    MIN(prftypinmhc) as prftypinmhc,
    MIN(COALESCE(prftypinox,noxgkmfzkll)) as prftypinox,
    MIN(COALESCE(prftypihcplusnox,hcplusnoxgkmfzkll)) as prftypihcplusnox,
    MIN(prftypinh3) as prftypinh3,
    MIN(prftypipartikel) as prftypipartikel,
    MIN(prftypipartikelzahl) as prftypipartikelzahl,
    MIN(prftypipartikelzexp) as prftypipartikelzexp,
    MIN(rauch) as rauch,
    MIN(codeoekoinnovation) as codeoekoinnovation,
    MIN(eingespco2emibenzindiesel) as eingespco2emibenzindiesel
  FROM (
    SELECT 
       herst_schluessel,
       typ_schluessel,
       code_getrtyp,
       "index",
       FIRST_VALUE("index") OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp ORDER BY "index" DESC) AS model_index,
       FIRST_VALUE("index") OVER (PARTITION BY herst_schluessel,typ_schluessel ORDER BY "index" DESC) AS typ_index,
       FIRST_VALUE(standgeraeusch_3) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS standgeraeusch_3,
       FIRST_VALUE(fahrgeraeusch_3) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS fahrgeraeusch_3,
       FIRST_VALUE(prftypico) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypico,
       FIRST_VALUE(prftypithc) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypithc,
       FIRST_VALUE(prftypinmhc) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypinmhc,
       FIRST_VALUE(prftypinox) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypinox,
       FIRST_VALUE(prftypihcplusnox) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypihcplusnox,
       FIRST_VALUE(prftypinh3) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypinh3,
       FIRST_VALUE(prftypipartikel) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypipartikel,
       FIRST_VALUE(prftypipartikelzahl) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypipartikelzahl,
       FIRST_VALUE(prftypipartikelzexp) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS prftypipartikelzexp,
       FIRST_VALUE(rauch) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS rauch,
       FIRST_VALUE(codeoekoinnovation) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS codeoekoinnovation,
       FIRST_VALUE(eingespco2emibenzindiesel) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS eingespco2emibenzindiesel,
       FIRST_VALUE(cogkmfzkll) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS cogkmfzkll,
       FIRST_VALUE(hcgkmfzkll) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS hcgkmfzkll,
       FIRST_VALUE(noxgkmfzkll) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS noxgkmfzkll,
       FIRST_VALUE(hcplusnoxgkmfzkll) OVER (PARTITION BY herst_schluessel,typ_schluessel, code_getrtyp, "index" ORDER BY "index" DESC) AS hcplusnoxgkmfzkll
    FROM kba
  ) kba_unique GROUP BY herst_schluessel, typ_schluessel, code_getrtyp, "index"
);

CREATE UNIQUE INDEX ON vehicle_model_registration("index");
CREATE INDEX ON vehicle_model_registration(herst_schluessel,typ_schluessel, code_getrtyp);
CREATE INDEX ON vehicle_model_registration(model_index);
CREATE INDEX ON vehicle_model_registration(typ_index);

ALTER TABLE vehicle_model_registration ADD FOREIGN KEY(model_index) REFERENCES vehicle_model("index");
ALTER TABLE vehicle_model_registration ADD FOREIGN KEY(typ_index) REFERENCES vehicle_type("index");
ALTER TABLE vehicle_model_registration ADD FOREIGN KEY(herst_schluessel,typ_schluessel,code_getrtyp) REFERENCES vehicle_model(herst_schluessel,typ_schluessel,code_getrtyp);
ALTER TABLE vehicle_model_registration ADD FOREIGN KEY(herst_schluessel,typ_schluessel) REFERENCES vehicle_type(herst_schluessel,typ_schluessel);
