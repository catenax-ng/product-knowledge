/**
 * Copyright (c) 2021-2022 T-Systems International GmbH (Catena-X Consortium)
 *
 * See the AUTHORS file(s) distributed with this work for additional
 * information regarding authorship.
 *
 * See the LICENSE file(s) distributed with this work for
 * additional information regarding license terms.
 */

const fs = require('fs')
const crypto = require('crypto')

// Test Data Generation Module
// defines useful functions for randomized, but controlled generation of json objects

// use safe crypto random
exports.randomFloat = function() {
  return crypto.webcrypto.randomInt(0,Number.MAX_SAFE_INTEGER)*1.0/Number.MAX_SAFE_INTEGER;
}

// The export context is a stack (list) of context maps.
// Each context map is an object containing the current generation context.

exports.context = {};

exports.getContext = function(property, def) {
   if(exports.context.hasOwnProperty(property)) {
     return exports.context[property];
   } else {
    if (typeof def === 'function') {
        return def();
    } else {
        return def;
    }
   }
};

exports.putContext = function(property, value) {
    exports.context[property]=value;
};

exports.noop = function(iterator) {
  console.log("Noop iterator called on argument "+iterator);
  return {};
}

exports.repeat = function() {
 var continuation=exports.noop;
 var candidates=[];
 if(arguments.length==3) {
    var min = arguments[0];
    var max = arguments[1];
    var continuation = arguments[2];
    var times=Math.ceil(exports.randomFloat()*(max-min));
    for (let i = 0; i < times; i++) {
      candidates[i] = min+i;
    }
 } else if(arguments.length==2) {
    candidates=arguments[0];
    continuation=arguments[1];
 }
 var result = [];
 for (let i = 0; i < candidates.length; i++) {
   result.push(continuation(candidates[i]));
 }
 return result;
};

const loremipsumtext = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  At accusam aliquyam diam diam dolore dolores duo eirmod eos erat, et nonumy sed tempor et et invidunt justo labore Stet clita ea et gubergren, kasd magna no rebum. sanctus sea sed takimata ut vero voluptua. est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. Consetetur sadipscing elitr,  sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.At vero eos et accusam et justo duo dolores et ea rebum.Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.At vero eos et accusam et justo duo dolores et ea rebum.Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.At vero eos et accusam et justo duo dolores et ea rebum.Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.";
const loremipsumwords = loremipsumtext.replace(","," ").replace("."," ").replace("  "," ").split(" ");
const loremipsumsentences = loremipsumtext.split(".");

exports.loremIpsum = function(spec) {
 return loremipsumwords[Math.round(exports.randomFloat()*loremipsumwords.length)];
};


exports.guid = function() {
    var d = new Date().getTime();//Timestamp
    var d2 = (performance && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = exports.randomFloat() * 16;//random number between 0 and 16
        if(d > 0){//Use timestamp until depleted
            r = (d + r)%16 | 0;
            d = Math.floor(d/16);
        } else {//Use microseconds since page-load if supported
            r = (d2 + r)%16 | 0;
            d2 = Math.floor(d2/16);
        }
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
};

exports.objectId = function() {
  return 'xxxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = exports.randomFloat * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
    return v.toString(16);
  });
};


exports.random = function() {
    var candidates=Array.from(arguments);
    return candidates[Math.round(exports.randomFloat*candidates.length)];
};

exports.writeTestFile = function(fileName,object) {
  var size=1;
  if(Array.isArray(object)) {
    size=object.length;
  } else {
    object=[object];
  }
  var partitionSize=size;
  if(arguments.length>2) {
   partitionSize=arguments[2];
  }

  console.log("Outputting "+size+" objects using partition size "+partitionSize+" into "+fileName);

  var partitions=partition(object,partitionSize);

  for(let i = 0; i < partitions.length; i++) {
    var targetName=fileName;
    if(i>0) {
      targetName=targetName+i.toString();
    }
    targetName=targetName+".json";
    console.log("Exporting "+partitions[i].length+" objects into "+targetName);

    // convert JSON object to a string
    exports.writeFile(targetName,partitions[i]);
  }
};

exports.writeFile = function(fileName,object) {
    var data = JSON.stringify(object,undefined,2);
    // write file to disk
    fs.writeFile(fileName, data, 'utf8', (err) => {
        if (err) {
            console.log(`Error writing file: ${err}`);
        }
    });
}

exports.readFile = function(fileName) {
  var content=fs.readFileSync(fileName, 'utf8');
  return JSON.parse(content);
};

exports.date = function(minDate, maxDate) {
    var min=minDate.getTime();
    var max=maxDate.getTime();
    var rand=Math.ceil(exports.randomFloat()*(max-min));
    return new Date(rand+min);
};

const countries = [ "GER", "USA", "GBR", "AUS", "FRA", "RUS", "UCR", "ZAR"];

exports.country = function() {
    return exports.random(...countries);
};

exports.integer = function() {
    var min = 0;
    if(arguments.length>0) {
        min=arguments[0];
    }
    // it is max int 32 bit value (we want to use it later also in java)
    var max = Math.pow(2,31)-1;
    if(arguments.length>1) {
        max=arguments[1];
    }
    var rand=Math.ceil(exports.randomFloat()*(max-min))+min;
    return rand;
}

const streets = [ "In den Dellen", "Unter den Linden", "Auf Hobels", "Am Turm", "Martin-Luther-Strasse", "Friedrich-Nietzsche Allee", "Altes Wasserwerk", "Schlossallee", "Badstrasse", "Turmstrasse"];

exports.street = function() {
    return exports.random(...streets);
}

const domains = [ "microsoft", "apple", "youtube", "overleaf", "catena-x", "t-systems", "bosch", "bmw"];
const toplevel = [ "com","org","io","ai","de","uk","gov","net"];

exports.domainZone = function() {
    return "."+exports.random(...domains)+"."+exports.random(...toplevel);
}

const firstNames = [ "Adam", "Berta", "Carsten", "Dietlinde", "Emma", "Friedolin", "Gerlinde", "Hugo", "Ingrid", "Julia", "Krisztof", "Ludwig", "Margot", "Nike", "Oskar", "Peter", "Quentin", "Roswitha", "Sandra", "Titus", "Uwe", "Vanessa", "Wilfried"];

exports.firstName = function() {
    return exports.random(...firstNames);
}

const lastNames = [ "Antonov", "Breitzkreuz", "Ceaucescu", "Deutscher", "Edel", "Fischbach", "Günther", "Holzapfel", "Igel", "Jung", "Klein", "Lammert", "Mozart", "Nonnweiler", "Ondraczek", "Paul", "Rost", "Sawatzki", "Thomas", "Underberg", "Vanderfart", "Willich", "Zimmer"];

exports.lastName = function() {
    return exports.random(...lastNames);
}

const cities = [ "Amsterdam", "Berlin", "Cairo", "Dortmund", "Essen", "Friedrichshafen", "Gross-Gerau", "Hamburg", "Ingolstadt", "Jülich", "Köln", "Ludwigsburg", "München", "Nagold", "Oberkirchen", "Potsdam", "Quatar City", "Regensburg", "Stuttgart", "Tuttlingen", "Ulm", "Vancouver", "Wiesbaden", "Xanten", "York"];

exports.city = function() {
    return exports.random(...cities);
}

exports.floating = function() {
    var min = 0;
    if(arguments.length>0) {
        min=arguments[0];
    }
    var max = 1;
    if(arguments.length>1) {
        max=arguments[1];
    }
    var scale = 100000;
    if(arguments.length>2) {
        scale=Math.pow(10,arguments[2]);
    }
    return Math.floor(exports.randomFloat()*(max-min)*scale)/scale;
}

exports.bool = function() {
 return exports.randomFloat()>0.5;
}

const companyName = [ "VW", "BMW", "MERCEDES", "Trafalga", "Petrochem", "Lumberjack", "Dack Janiels", "Bim Jeam"];
const companyForm = [ "AG","KG","GmbH","GmbH & Co KG","Ltd","Inc","Corp"];

exports.company = function() {
 return exports.random(...companyName)+" "+exports.random(...companyForm);
}

function partition(array, n) {
  return array.length ? [array.splice(0, n)].concat(partition(array, n)) : [];
}


const partNumberBattery = ["8844604-01"]

const partNumberBatteryModule = ["8840841-04","8840838-04" ];

exports.partNamesRealisticCX = function() {
  var partNamesMap = new Map()
  partNamesMap.set('5A047C7-01', "LU GETRIEBE GA8L51CZ B48B20M1  CODE SXJ8");
  partNamesMap.set('8849262-01', "ZB LU HVS SP41 G30 G31"); 
  partNamesMap.set('8840838-04', "ZB ZELLMODUL PHEV1 34AH NEG 16S1P U3"); 
  partNamesMap.set('8844604-01', "LI-ION ZELLE Z10 PHEV1 34AH U3.0 LF2 RPT"); 
  partNamesMap.set('8840841-04', "ZB ZELLMODUL PHEV1 34AH POS 16S1P U3");  
  partNamesMap.set('N6C6M2ZYX', "NiCoMg-Cathode"); 
  partNamesMap.set('LiElo100', "Lithium Electrolyte");  
  partNamesMap.set('N25-247', "Positive Terminal N25 Spec 24.7");
  partNamesMap.set('S331-247', "Negative Terminal S331 Spec 24.7");
  partNamesMap.set('PE17-247', "PE Cover Spec 24.7");

  return partNamesMap;
}

const vehicleModel = [ "BMW 320e", "C 300 e", "BMW X1 xDrive30e", "GOLF VARIANT 1,5 BLUEMOTION TECHNOLOGY HIGHLINE"];

exports.vehicleModel = function() {
    return exports.random(...vehicleModel);
}

const eqtDescription = [

  "System-Diebstahlschutz: Wegfahrsperre elektronisch",
  "Einlagen: Dekor-Einlagen",
  "Einstiegleisten: Ohne Trittschutzfolie für Türeinstieg",
  "Einparkhilfe: Einparkhilfe vorn und hinten",
  "Erweitertem Sicherheitssystem: Ohne erweitertem Sicherheitssystem",
  "Elektrische Schnittstelle für externe Nutzung: Extern, USB Typ-A, 2x USB Buchsen",
  "Fensterheber: Fensterheber mit Komfortschaltung und Abschaltsicherung, elektrisch",
  "Fußgängerschutz: Fußgängerschutzmaßnahmen erweitert und vorausschauend",
  "Fußhebelwerk: Fußhebelwerk Standard",
  "Frischluftansaugung für Innenraum (mit Partikelfilter): Frischluftansaugung mit Aktivkohlefilter",
  "Fahrzeugspezifikationen: Kein Sonderfahrzeug,Standard-Ausführung",
  "Generatoren: Drehstromgenerator 140 A",
  "Gewichtsklasse Hinterachse: Gewichtsbereich 5 nur Einbausteuerung keine Bedarfsprognose",
  "Gewichtsklasse Vorderachse: Federbereich 04 nur Einbausteuerung keine Bedarfsprognose",
  "Geschwindigkeitsregelanlage: Automatische Distanzregelung (mit follow to stop) und Speed-Limiter",
  "Geschwindigkeitswarn- /Begrenzungsanlage: Geschwindigkeitsbegrenzungsanlage",
  "Heckspoiler: Ohne Heckspoiler",
  "Heckscheiben Wischwaschanlage: Heckscheiben-Wisch-Waschanlage mit Intervallschaltung",
  "Hinterachse: Vier-Lenkerachse",
  "Formteilhimmel: Formteilhimmel ungeteilt",
  "Hintersitze: Rücksitzbank ungeteilt, Lehne geteilt umlegbar mit Mittelarmlehne",
  "Heizung-Klimaanlage: Climatronic mit Stauluftregelung, FCKW-frei",
  "Hauptscheinwerfer: LED- Hauptscheinwerfer",
  "Hybridantrieb: Mit Elektromotor ( Hybrid )",
  "Innenleuchte im Fußraum: Innenleuchte im Fußraum",
  "Instrumenteneinsätze: Instrumenteneinsatz, Anzeige in KM/H",
  "Sicherheitsinnenspiegel: Sicherheitsinnenspiegel automatisch abblendbar",
  "Abschließbare Radschrauben: Radschrauben mit Diebstahlsicherung (nicht abschließbar)",
  "Fahrzeugklassendifferenzierung Aggregate / Plattformteile: Fahrzeugklassen-Differenzierung -5G0-",
  "Abgasendrohr: Abgasendrohr hinten (Standard)",
  "Abgaskonzept: Abgaskonzept, EU6 ZD/E/F",
  "Anhängevorrichtung: Ohne Anhängevorrichtung",
  "Airbag: Airbag für Fahrer und Beifahrer mit Knieairbag u.Beifahrer-Airbag- Deaktivierung",
  "Aktivkohlebehälter / Ottopartikelfilter: Aktivkohlebehälter",
  "Antennen: Antenne nur für FM Empfang, Diversity",
  "Außenspiegel-Einstellung: Außenspiegel mit Memoryfunktion elektrisch anklapp-/einstellbar, separat beheizbar",
  "Außenspiegel links: Außenspiegel links, asphärisch",
  "Außen-Sound-Maßnahmen: Außen-Sound Standard",
  "Außenspiegel rechts: Außenspiegel rechts, konvex",
  "Alternativ-Antriebssystem: Ohne alternativ-Antriebssystem",
  "Antriebsart: Frontantrieb",
  "Ausstattungsstufen: Sport-Ausstattung",
  "Bremsenausführung hinten: Scheibenbremsen hinten",
  "Batterien: Batterie 320A (59Ah)",
  "Bremsenausführung vorn: Scheibenbremsen vorn (Geomet D)",
  "Bauteile mit besonderer Oberfläche: Außenspiegelgehäuse und diverse Anbauteile in Wagenfarbe",
  "Batterien/Generatoren Kapazitäten: Batterie/Generator Kapazität Standard",
  "Bauteilesatz länderspezifischer Bauvor- schriften: Bauteilesatz ohne länderspezifische Bauvorschrift",
  "Bordwerkzeug und Wagenheber: Bordwerkzeug",
  "Bremssysteme: Elektronisches Stabilisierungsprogramm (ESP)",
  "Betriebsanleitungen: Bordliteratur in deutsch",
  "Sitzheizung: Sitzheizung für Vordersitze getrennt regelbar",
  "Start/Stopp-Anlage/Rekuperation: Start/Stopp-Anlage mit Rekuperation",
  "Signalhörner: Doppelton-Signalhorn",
  "Steuerungsnummer (keine PR-Familie): Fahrzeugrückkauf",
  "Sonnenblenden: Sonnenblenden mit Spiegel, beleuchtet, mit Airbag-Label auf Sonnenblende und B-Säule",
  "Sprachbediensystem / Sprachsteuerung: Ohne Sprachsteuerung",
  "Spurwechsel/Spurhalteassistent: Ohne Spurwechselassistent",
  "Scheiben seitlich und hinten: Scheiben seitlich in Wärmeschutzver- glasung, ab B-Säule und hinten dunkel eingefärbt",
  "Steckdose: 12 Volt-Steckdose im Kofferraum",
  "Stoßfänger: Stoßfänger Sport",
  "Stabilisator hinten: Stabilisator hinten",
  "Stabilisator vorn: Stabilisator vorn",
  "Schubladen unter den Vordersitzen: Ohne Schubladen unter den Vordersitzen",
  "Scheinwerferreinigungsanlage: Scheinwerferreinigungsanlage",
  "Scheibenwischerintervallschaltung / Licht / Regensensor: Scheibenwischer-Intervallschaltung mit Licht/Regensensor",
  "Schriftzugsatz: Ohne Schriftzugsatz (ohne Typbezeichnung)",
  "Tilgergewichte Lenkräder: Tilgergewicht Lenkrad, 36 HZ",
  "Tür- und Klappenverriegelung: Zentralverriegelung m. Funkfernbedienung Innenbetätigung ohne Safesicherung",
  "Trägerfrequenz für Funkbedienung: Trägerfrequenz 433,92 bis 434,42 MHz",
  "Tür und Seitenverkleidungen: Tür und Seitenverkleidung Schaumfolie und Gewebe",
  "Türen: 4 Türen",
  "Triebwerks-Unterschutz: Ohne zus. Triebwerks-Unterschutz",
  "Überführungsausrüstung: Ohne Überführungsausrüstung",
  "Verbandkasten / Warndreieck: Verbandmaterial mit Warndreieck und Warnweste",
  "Vordersitze: Sport-Komfortsitze vorn",
  "Verriegelung Hintersitz: Entriegelung Hintersitz mechanisch",
  "Telefon / Telematik: Komfort telefonie und Wireless charging ( ohne LTE )",
  "Zusätzliche Warnleuchten: Zus.Rückstrahler (Türbereich)",
  "Wartungsintervallverlängerung: Wartungsintervallverlängerung",
  "Wärmespeicheranlage / Zusatzheizung: Ohne Wärmespeicher/Zusatzheizung",
  "Windschutzscheibe: Frontscheibe, Wärmeschutzglas",
  "Waschwasserstandanzeige: Waschwasser-Standanzeige"
];

exports.eqtDescription = function() {
  return exports.random(...eqtDescription);
};

const eqtGroup = [ "Sonderausstattung"];

exports.eqtGroup = function() {
    return exports.random(...eqtGroup);
};


const PartNameISO18542 = [
"chassis",
"body",
"diagonal strut",
"door sill",
"subframe",
"transmission tunnel",
"bulkhead",
"firewall",
"roof frame",
"A-pillar",
"B-pillar",
"C-pillar",
"D-pillar",
"roll bar",
"impact absorber",
"pedestrian protection system",
"transmission carrier",
"engine mount",
"load anchor point",
"central lubrication",
"fifth wheel",
"suspension",
"leaf spring",
"shock absorber",
"steering knuckle",
"steering lock",
"stabilizer bar",
"bogie",
"tridem",
"liftable axle",
"rear axle breather",
"non-driven axle",
"front axle",
"rear axle",
"steering",
"wheel",
"wheel hub",
"wheel carrier",
"tire",
"tie rod",
"control arm",
"trailing arm",
"drivetrain",
"drive shaft",
"output shaft",
"cardan shaft",
"differential",
"differential housing",
"axle",
"axle drive",
"disc brake",
"drum brake",
"brake caliper",
"brake caliper piston",
"wheel brake cylinder",
"brake fluid reservoir",
"brake shoe",
"brake pad",
"brake disc",
"brake line",
"brake circuit",
"parking brake cable",
"brake",
"brake booster",
"pressure relief valve",
"pressure reducing valve",
"compressed-air tank",
"brake vacuum sensor",
"brake pressure sensor",
"brake pad wear sensor",
"brake pedal position sensor",
"steering wheel angle sensor",
"drain valve",
"brake drum",
"air compressor",
"cooling coil",
"air dryer",
"trailer brake",
"tailgate trim",
"door lock",
"door handle",
"trunk lid handle",
"window seal",
"sunroof",
"air deflector",
"hardtop",
"convertible top",
"door",
"trunk lid",
"hood",
"sliding door",
"fuel filler cap",
"fuel filler flap",
"door latch",
"roof hatch",
"liftgate",
"roof railing",
"bumper",
"radiator grille",
"spoiler",
"diffuser",
"windshield",
"rear window",
"side window",
"grille guard",
"underride protection",
"running board",
"spare wheel",
"towing eye",
"trailer hitch",
"horn",
"front grille",
"roof panel",
"side panel",
"fender",
"rocker panel",
"side skirt",
"outside rearview mirror",
"curb mirror",
"parcel shelf",
"airbag system",
"wheelchair lift",
"steering wheel controls",
"hand throttle control",
"seat",
"head restraint",
"footrest",
"backrest",
"lumbar support",
"armrest",
"seat cover",
"head restraint cover",
"folding table",
"speaker",
"microphone",
"head-up display",
"speedometer",
"tachometer",
"taximeter",
"seat belt",
"child restraint system",
"seat belt retractor",
"seat belt tensioner",
"seat belt buckle",
"cup holder",
"glasses compartment",
"glove compartment",
"stowage compartment",
"ashtray",
"cigarette lighter",
"USB port",
"sunshade",
"sunblind",
"inside mirror",
"accelerator pedal",
"parking brake",
"brake pedal",
"clutch pedal",
"gear shift lever",
"selector lever",
"window regulator",
"instrument panel",
"center console",
"washer fluid reservoir",
"noise insulation",
"wiper motor",
"compressed-air antifreeze system",
"fire suppression system",
"protective cover",
"window motor",
"sliding door motor",
"seat adjustment motor",
"headlining",
"storage shelf",
"steering wheel",
"steering column",
"charging socket",
"charging plug",
"trailer socket",
"battery main switch",
"backup battery",
"starter battery",
"electric vehicle battery",
"battery module",
"cell block",
"charging cable",
"ignition lock",
"generator",
"fuse box",
"main fuse",
"alternator",
"center high mounted stop lamp",
"clearance lamp",
"reflector",
"roof sign",
"special signaling system",
"headlamp",
"active safety system",
"anti-lock braking system",
"traction control system",
"active roll stabilization",
"vehicle stability system",
"continuous damping control",
"brake force regulator",
"tire pressure monitoring system",
"automatic braking system",
"noise filter",
"infotainment",
"antenna",
"antenna amplifier",
"DAB Receiver",
"visual assistance system",
"driver monitoring system",
"data link connector",
"infrastructure-to-vehicle interface",
"parking assist",
"long range radar",
"anti-theft alarm",
"vibration motor",
"seat belt presenter",
"seat belt adjustment",
"radar sensor",
"ultrasonic sensor",
"LIDAR sensor",
"laser sensor",
"acceleration sensor",
"rollover sensor",
"impact sensor",
"air humidity sensor",
"glass breakage sensor",
"seat sensor",
"central locking system",
"wireless communications network",
"HVAC Control Module",
"restraints control module",
"CAN bus",
"LIN bus",
"FlexRay bus",
"MOST bus",
"seat belt buckle sensor",
"body builder module",
"body control module",
"SIM card reader",
"fuel cell",
"drive motor",
"high-voltage battery",
"exhaust system",
"exhaust manifold",
"exhaust manifold gasket",
"exhaust pipe",
"tailpipe",
"exhaust pressure regulator",
"exhaust gas recirculation cooler",
"exhaust gas recirculation pipe",
"exhaust gas recirculation valve",
"particulate filter",
"catalytic converter",
"catalytic converter heater",
"secondary air injection",
"exhaust gas recirculation",
"combustion engine",
"naturally aspirated engine",
"natural gas engine",
"engine block",
"crankcase",
"crankcase ventilation system",
"oil pan",
"cylinder head",
"cylinder head cover",
"cylinder head gasket",
"shutoff valve",
"stopcock",
"throttle valve",
"pressure switch valve",
"compression ring",
"oil scraper ring",
"starter",
"fuel injection system",
"ignition coil",
"timing belt",
"belt pulley",
"intake valve",
"exhaust valve",
"camshaft",
"common rail",
"fuel injector",
"injection pump",
"turbocharger",
"charge air cooler",
"intake manifold",
"engine cooling",
"coolant expansion tank",
"coolant pump",
"coolant heater",
"radiator",
"air filter",
"air filter housing",
"lubrication system",
"oil filter",
"oil pump",
"oil line",
"fuel system",
"fuel cooler",
"fuel tank",
"fuel filter",
"fuel pump",
"evaporative emission",
"fuel tank vent valve",
"fuel line",
"fuel filler receptacle",
"engine control module",
"exhaust aftertreatment system",
"oil cooler",
"fuel quality sensor",
"crankshaft position sensor",
"differential pressure sensor",
"fuel tank pressure sensor",
"fuel pressure sensor",
"hydrogen sensor",
"intake air temperature sensor",
"barometric pressure sensor",
"combustion pressure sensor",
"engine oil pressure sensor",
"exhaust pressure sensor",
"exhaust temperature sensor",
"particulate matter sensor",
"oxygen sensor",
"fuel temperature sensor",
"engine oil temperature sensor",
"transmission oil temperature sensor",
"cylinder block",
"timing chain",
"high-pressure fuel pump",
"water separator",
"cylinder liner",
"piston",
"crankshaft",
"connecting rod",
"flywheel",
"timing gear",
"oil dipstick",
"spark plug",
"selective catalytic reduction",
"reductant tank",
"reductant heater",
"reductant pump",
"intake air duct",
"clutch",
"clutch fluid reservoir",
"transmission housing",
"reduction gear",
"automatic transmission",
"pressure regulating valve",
"clutch master cylinder",
"transfer case",
"retarder",
"brake band",
"gear position sensor",
"flex plate",
"manual transmission",
"door trim",
"spring-loaded brake cylinder",
"oil separator",
"air silencer",
"brake control module",
"brake pressure modulator valve",
"ball joint",
"air suspension",
"slave cylinder",
"door seal",
"sensitized edge",
"wheelchair ramp",
"handrail",
"fire detection system",
"battery energy control module",
"battery compartment",
"battery carrier",
"battery housing",
"battery cover",
"electric drive",
"fuel level sensor",
"DC/DC converter",
"LNG evaporator",
"drive motor control module",
"gas tank",
"evaporative emission canister"
];

exports.PartNameRandomISO18542 = function() {
  return exports.random(...PartNameISO18542);
};

const materialClass = [
    "CathodeMaterial_LeadDioxide",
    "CathodeMaterial_LithiumNickelManganeseCobaltOxides",
    "CathodeMaterial",
    "PolymerMaterial_Rubber",
    "PolymerMaterial",
    "PolymerMaterial_Plastic",
    "OrganicMaterial_Rubber",
    "OrganicMaterial",
    "OrganicMaterial_Leather",
    "OrganicMaterial_ArtificialLeather",
    "CompositeMaterial_Carbon",
    "CompositeMaterial",
    "MetalMaterial_Steel",
    "MetalMaterial_Copper",
    "MetalMaterial_Aluminium",
    "MetalMaterial",
    "Alloy",
    "NativeMetal",
    "LightMetal",
    "HeavyMetal",
    "CeramicMaterial",
    "SemiconductorMaterial",
    "EngineeringMaterial"
    ];

exports.materialClass = function() {
    return exports.random(...materialClass);
}
