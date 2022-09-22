import pandas as pd
import os
from ontology.ontology_tools.settings import ontology_path, tables_path, tools_path
from ontology.ontology_tools.ontology_tools import read_numbers2df
from ontology.ontology_tools.convert_df2graph import convert_df2graph
from ontology.ontology_tools.merge_ontology import merge_ontology

# get ontology_list from files
file_ext = 'numbers'
files = os.listdir(tables_path)
files.sort()
files = [file for file in files if ~file.startswith('_') & file.endswith(file_ext)]
ontology_list = [file.replace('_ontology.'+file_ext, '') for file in files]
print('# found nfiles:', len(files))

# read mapping
mapping = pd.read_csv(tools_path + '/rdf_mapping.csv', dtype=str).dropna(how='all')

# run over all ontologies
for ontology in ontology_list:
    print(ontology)
    ontology_file = tables_path+'/'+ontology+'_ontology.'

    # read numbers
    #numbers_file = tables_path + '/' + ontology + '_ontology.numbers'
    df = read_numbers2df(ontology_file+'numbers').dropna(how='all').fillna('')  # necessary
    #df.to_csv(ontology_file+'csv', index=False)
    df.to_excel(ontology_file+'xlsx', index=False)

    # read csv
    # csv_file = tables_path+'/csv/'+ontology+'_ontology.csv'
    # df = pd.read_csv(csv_file, dtype=str).dropna(how='all').fillna('')  # necessary

    # convert csv and write ttl file
    g = convert_df2graph(df, mapping, ontology_name=ontology+'_ontology', prefix='cx')

    # write file
    ttl_file = ontology_path + '/' + ontology + '_ontology.ttl'
    g.serialize(destination=ttl_file, format = 'turtle')
    #g.serialize(destination=ontology_path + '/' + ontology + '_ontology.jsonld', format = 'json-ld', indent=4)

merge_ontology()

# ontology = 'diagnosis'
# numbers_file = tables_path + '/' + ontology + '_ontology.numbers'
# df = read_numbers2df(numbers_file).dropna(how='all').fillna('')  # necessary
# ttl_file = ontology_path + '/' + ontology + '_ontology.ttl'
# g = convert_df2graph(df, mapping, ontology_name=ontology + '_ontology', prefix='cx', write_csv='test.csv')
# g.serialize(destination=ttl_file, format='turtle')
