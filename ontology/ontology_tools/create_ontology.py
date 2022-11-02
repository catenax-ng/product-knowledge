import pandas as pd
import os
from ontology.ontology_tools.settings import ontology_path, tables_path, numbers_path, tools_path
from ontology.ontology_tools.ontology_tools import read_numbers2df
#from ontology.ontology_tools.convert_df2graph import convert_df2graph
from ontology.ontology_tools.merge_ontology import merge_ontology

# read mapping
mapping = pd.read_csv(tools_path + '/rdf_mapping.csv', dtype=str).dropna(how='all')

def get_ontology_list(tables_path, file_ext='csv'):
    files = os.listdir(tables_path)
    files.sort()
    files = [file for file in files if ~file.startswith('_') & file.endswith('_ontology.' + file_ext)]
    ontology_list = [file.replace('_ontology.' + file_ext, '') for file in files]
    print('# found nfiles:', len(files))
    return ontology_list

def convert_numbers_files_to_csv_files():
    for ontology in get_ontology_list(numbers_path, file_ext='numbers'):
        # print(ontology)
        df = read_numbers2df(numbers_path + '/' + ontology + '_ontology.numbers')
        if (df.columns.isna().sum() > 0):
            print('- found empty column names in', ontology)
        df.to_csv(tables_path+'/'+ontology+'_ontology.csv', index=False)

def convert_ontology_from_csv():
    for ontology in get_ontology_list(tables_path, file_ext='csv'):
        print(ontology)
        df = pd.read_csv(tables_path+'/'+ontology+'_ontology.csv', dtype=str).dropna(how='all').fillna('')  # necessary
        # convert csv and write ttl file
        g = convert_df2graph(df, mapping, ontology_name=ontology+'_ontology', prefix='cx', write_simple = False)
        # write file
        ttl_file = ontology_path + '/' + ontology + '_ontology.ttl'
        g.serialize(destination=ttl_file, format = 'turtle')

convert_numbers_files_to_csv_files()
convert_ontology_from_csv()
merge_ontology()

def convert_ontology(ontology):
    numbers_file = numbers_path + '/' + ontology + '_ontology.numbers'
    df = read_numbers2df(numbers_file).dropna(how='all').fillna('')  # necessary
    df.to_csv(tables_path+'/'+ontology+'_ontology.csv', index=False)
    df = pd.read_csv(tables_path+'/'+ontology+'_ontology.csv', dtype=str).dropna(how='all').fillna('')  # necessary
    ttl_file = ontology_path + '/' + ontology + '_ontology.ttl'
    g = convert_df2graph(df, mapping, ontology_name=ontology+'_ontology', prefix='cx', write_simple = False)
    g.serialize(destination=ttl_file, format='turtle')

convert_ontology('vehice_component')