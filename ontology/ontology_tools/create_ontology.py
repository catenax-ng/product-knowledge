import pandas as pd
import os
from os.path import exists
from ontology.ontology_tools.settings import ontology_path, tables_path, numbers_path, tools_path, cx_url
from ontology.ontology_tools.ontology_tools import read_numbers2df
from ontology.ontology_tools.convert_df2graph import convert_df2graph
from ontology.ontology_tools.merge_ontology import merge_ontology
from ontology.ontology_tools.convert_ontology_to_csv import convert_ontology_to_csv

# read mapping
mapping = pd.read_csv(tools_path + '/rdf_mapping.csv', dtype=str).dropna(how='all')
schema = mapping[(mapping['usage'] == 'schema') & mapping['order'].notna()]['simple_name'].to_list()

def create_ontology_table(domain='test', author='Max Mustermann', version = '0.0.1'):
    header = ['# prefix', '# namespace', '# title', '# version', '# author', '# contributor',
              '# description', '# import', '', '', 'class', 'class', 'relation', 'attribute']
    info = ['cx', cx_url, domain.replace('_', ' ') + ' ontology', version, author,
            '', '', 'common ontology', '', '', 'vehicle', 'engine', 'is part of', 'vehicle identification number']
    parents = ['', '', '', '', '', '', '', '', '', '', 'product', 'product', '', '']
    relation_from = ['', '', '', '', '', '', '', '', '', '', '', '', 'engine', 'vehicle']
    relation_to = ['', '', '', '', '', '', '', '', '', '', '', '', 'vehicle', 'xsd:string']
    df = pd.DataFrame({'type': header, 'identifier': info,
                       'parents': parents, 'relation_from': relation_from, 'relation_to': relation_to})
    # add empty columns
    for col in schema[5:]: # already included
        df[col] = ''
    csv_file = tables_path + '/' + domain.replace(' ', '_') + '_ontology.csv'
    if not exists(csv_file):
        print('# writing:', csv_file)
        df.to_csv(csv_file, index=False)
    else:
        print('# file already exists:', csv_file)

def get_ontology_list(tables_path, file_ext='csv'):
    files = os.listdir(tables_path)
    files.sort()
    files = [file for file in files if ~file.startswith('_') & file.endswith('_ontology.' + file_ext)]
    ontology_list = [file.replace('_ontology.' + file_ext, '') for file in files]
    print('# found nfiles:', len(files))
    return ontology_list

def convert_numbers_file(ontology):
    numbers_file = numbers_path + '/' + ontology + '_ontology.numbers'
    print('# converting: ', numbers_file)
    df = read_numbers2df(numbers_file)#.dropna(how='all').fillna('')  # necessary
    if (df.columns.isna().sum() > 0):
        print('- found empty column names in', ontology)
    df.to_csv(tables_path+'/'+ontology+'_ontology.csv', index=False)
    df.to_csv(tables_path + '/' + ontology + '_ontology.csv', index=False)
    #df.to_excel(tables_path + '/' + ontology + '_ontology.xlsx', index=False)

def convert_csv_file(ontology): # convert_ontology('vehice_component')
    ontology = ontology.replace(' ', '_')
    df = pd.read_csv(tables_path+'/'+ontology+'_ontology.csv', dtype=str).dropna(how='all').fillna('')  # necessary
    ttl_file = ontology_path + '/' + ontology + '_ontology.ttl'
    print('# converting: ', ttl_file)
    graph = convert_df2graph(df, mapping, ontology_name=ontology+'_ontology', prefix='cx', write_simple = False)
    graph.serialize(destination=ttl_file, format='turtle')

def convert_all_numbers_files():
    for ontology in get_ontology_list(numbers_path, file_ext='numbers'):
        convert_numbers_file(ontology)

def convert_all_csv_files():
    for ontology in get_ontology_list(tables_path, file_ext='csv'):
        convert_csv_file(ontology)

if __name__ == '__main__':
    convert_all_numbers_files()
    convert_all_csv_files()
    merge_ontology()
    convert_ontology_to_csv()
