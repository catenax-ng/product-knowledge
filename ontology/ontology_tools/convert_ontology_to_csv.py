import pandas as pd
from rdflib import Graph, URIRef, Literal
from ontology.ontology_tools.settings import cx_url, cx_file, mapping_path

def convert_ontology_to_csv():

    # read ontology
    graph = Graph()
    graph.parse(cx_file)

    # query classes with attributes
    query = """
    SELECT DISTINCT ?ontology ?class ?attribute ?data_type WHERE {
        ?bn owl:someValuesFrom ?data_type ;
            owl:onProperty ?attribute .
        ?attribute rdf:type owl:DatatypeProperty .
        ?class rdfs:subClassOf ?bn;
            rdfs:isDefinedBy ?ontology .
    }
    ORDER BY ?ontology ?class ?attribute
    """
    r = graph.query(query)
    r.serialize(mapping_path+'/cx_ontology_attribute.csv', format='csv')

    # query classes with relations
    query = """
    SELECT DISTINCT ?ontology ?class ?relation ?object WHERE {
        ?bn owl:someValuesFrom ?object ;
            owl:onProperty ?relation .
        ?relation rdf:type owl:ObjectProperty .
        ?class rdfs:subClassOf ?bn;
            rdfs:isDefinedBy ?ontology .
    }
    ORDER BY ?ontology ?class ?relation
    """
    r = graph.query(query)
    r.serialize(mapping_path+'/cx_ontology_relation.csv', format='csv')

    # concat attributes & relations
    df = pd.concat([
        pd.read_csv(mapping_path+'/cx_ontology_attribute.csv'),
        pd.read_csv(mapping_path + '/cx_ontology_relation.csv')
        ])

    # add prefixes
    for col in df.columns:
        df[col] = df[col].str.replace(cx_url, 'cx:', regex=False)
        df[col] = df[col].str.replace('http://www.w3.org/2002/07/owl#', 'owl:', regex=False)
    df['ontology'] = df['ontology'].str.replace('https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/', '', regex=False)
    df['ontology'] = df['ontology'].str.replace('.ttl', '', regex=False).str.title().str.replace('_',  '')
    df['data_type'] = df['data_type'].str.replace('http://www.w3.org/2001/XMLSchema#', 'xsd:', regex=False)

    # write csv
    df = df.sort_values(['class', 'attribute'])
    out_file = mapping_path+'/cx_ontology.csv'
    print('# writing:', out_file)
    df.to_csv(out_file, index=False)