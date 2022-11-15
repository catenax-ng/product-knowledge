import pandas as pd
from rdflib import Graph, URIRef, Literal, Namespace, BNode
from ontology.ontology_tools.settings import cx_url, cx_file, mapping_path

def create_mapping_table(mapping_name = 'name', mapping_classes = ['vehicle']):

    # read ontology as table
    df = pd.read_csv(mapping_path+'/cx_ontology.csv')

    # filter by classes
    class_list = ['cx:'+c.title().replace(' ', '') for c in mapping_classes]
    sel = df['class'].isin(class_list)# | df['object'].isin(class_list)
    df = df[sel]

    #df = df.sort_values(['attribute'])
    df['type'] = ''
    df.loc[(df['attribute'].notna()), 'type'] = 'attribute'
    df.loc[(df['relation'].notna()), 'type'] = 'relation'

    #+mapping_name.title().replace(' ', '').replace('_', '')
    df['map'] = df['class']+'TripleMap'
    df['target_map'] = df['object']+'TripleMap'
    df = df.drop(columns=['ontology', 'object'])

    # add columns
    columns = ['table_name', 'table_type', 'table_path', 'column', 'foreign_key', 'primary_key']
    for col in columns:
        df[col] = ''
    df_template = pd.read_csv(mapping_path+'/_mapping_template.csv', sep=';')
    df = pd.concat([df_template, df])

    # write csv file
    csv_file = mapping_path+'/'+mapping_name.lower().replace(' ', '_')+'_mapping.csv'
    print('# writing: ', csv_file)
    df.to_csv(csv_file, index=False)
