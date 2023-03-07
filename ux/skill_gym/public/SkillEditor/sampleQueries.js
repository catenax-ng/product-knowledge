var sampleQueries = {
	"example.1" :
  {
    "distinct": true,
    "variables": [
      "telematicsAsset",
      "EquipmentManufacturer"
    ],
    "order": null,
    "branches": [
      {
        "line": {
          "s": "?telematicsAsset",
          "p": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#author",
          "o": "?EquipmentManufacturer",
          "sType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Artwork",
          "oType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Category",
          "values": []
        },
        "children": []
      }
    ]
  },
	"example.2" :
{
  "distinct": true,
  "variables": [
    "?Date_3",
    "?Date_4",
    "?this"
  ],
  "defaultLang": "fr",
  "order": null,
  "branches": [
    {
      "line": {
        "s": "?this",
        "p": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#movement",
        "o": "?Movement_1",
        "sType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Person",
        "oType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Movement",
        "values": [
          {
            "label": "GearSet",
            "uri": "http://fr.dbpedia.org/resource/Impressionnisme"
          }
        ]
      },
      "children": []
    },
    {
      "line": {
        "s": "?this",
        "p": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#birthDate",
        "o": "?Date_3",
        "sType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Person",
        "oType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Date",
        "values": []
      },
      "children": []
    },
    {
      "line": {
        "s": "?this",
        "p": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#deathYear",
        "o": "?Date_4",
        "sType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Person",
        "oType": "http://ontologies.sparna.fr/sparnatural-demo-dbpedia#Date",
        "values": []
      },
      "children": [],
      "optional": true
    }
  ]
}
};