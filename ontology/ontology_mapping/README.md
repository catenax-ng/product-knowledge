# Ontology Mapping via R2RML
## How to map an ontology to a database
In order to make data available, the classes and attributes of 
an ontology (logical layer) needs to be referenced or linked to the
data in the physical layer. This is called a **mapping** and we use 
the W3C standard [R2RML](https://www.w3.org/TR/r2rml/).
We have scripts that provides ontology information,
mask the complexity and simplifies the mapping process.

### Create csv file for mapping
First, one needs to create a csv table containing the necessary classes, therefore execute
```
create_mapping_table(mapping_name = 'bmw_vehicle_part', mapping_classes = ['vehicle', 'part'])
```
then the csv file ontology/ontology_mapping/bmw_vehicle_part_mapping.csv will be created.

### Fill out template with mapping information
##### Create mapping for a table

Enter in rows with type is **class** the following:
* table name 
* table type (SQL2008, Parquet, CSV, XPath, JSONPath)
* table path

Enter in rows with type is **attribute** the following:
* column
* subject (mark with x, when it is the primary key)

##### Create mapping for two tables with relations
Enter in rows with type is **relation** the following:
* foreign key (column)
* primary key (column)

In relations
The primary key can be left empty, when it is same as foreign key.

### Convert csv to turtle file
Now execute 
```
create_mapping('bmw_vehicle_part_mapping.csv')
```
and a turtle file (e.g. bmw_vehicle_part_mapping.ttl) will be created that contains the mapping in R2RML.