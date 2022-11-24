import pandas as pd
import rdfpandas
from rdflib import Graph, URIRef, Literal, Namespace, BNode
from rdflib.namespace import NamespaceManager, RDF, RDFS, SKOS, OWL, DC
from rdflib.collection import Collection

from datetime import date

def extract_header(df, header, first_string=False):
    sel = df['type'].str.startswith('#') & df['type'].str.contains(header)
    result = [x.strip() for x in df[sel]['identifier']]     # extract to list
    result = [x for x in result if x != '']                 # remove empty strings
    # if result[0].__contains__(','):                         # split comma separated values
    #     result = [x.split(',') for x in result if x.__contains__(',')][0]
    #     result = [x.strip() for x in result]
    if first_string & (result != []):                       # select first element
        result = result[0]
    return result

def extract_abbreviations(df, col='synonyms_en'):
    aa = None
    row = df[col].str.contains('(', regex=False) & df[col].str.contains(')', regex=False)
    if sum(row) > 0:
        aa = df.loc[row, col].str.split('(', expand=True)
        aa.columns = ['value', 'key']
        aa = aa[['key', 'value']]
        aa['key'] = aa['key'].str.replace(')', '', regex=False)
        # split multiple abbreviations, e.g. (IoT, IOT)
        aa['key'] = aa['key'].str.split(',')
        aa = aa.explode('key')
        aa['key'] = aa['key'].str.strip()
        #aa['value'] = aa['value'].str.lower()
    return aa

# some, value, only -> owl:someValuesFrom, owl:hasValue, owl:allValuesFrom
def add_class_restriction(graph, property, domain, range, ns, data_type=''):
    XSD = Namespace('http://www.w3.org/2001/XMLSchema#')
    bn = BNode()
    graph.add((ns[domain], RDFS.subClassOf, bn))
    graph.add((bn, RDF.type, OWL.Restriction))
    graph.add((bn, OWL.onProperty, ns[property]))
    if (data_type == ''):
        graph.add((bn, OWL.someValuesFrom, ns[range]))
    else:
        graph.add((bn, OWL.someValuesFrom, XSD[data_type]))
    #graph.add((bn, OWL.allValuesFrom, CX[range]))
    return graph

# def add_property_range(graph, property, range):
#     bn = BNode()
#     cn = BNode()
#     Collection(self, cn, [self.map_string_to_uri(property_range) for property_range in property_ranges])
#     graph.add((CX['property'], RDFS.range, bn))
#     graph.add((bn, RDF.type, OWL.Class))
#     graph.add((bn, OWL.unionOf, cn))
#     return graph

# df needs to be strings only
def convert_df2graph(df=None, mapping=None, ontology_name='', csv_file='', ttl_file='', prefix = '',
                     write_simple = False, empty_parents=False, write_csv='', verbose=True):
    # empty_inverse, misspelled inverse_of relations
    # check for relations as strings, vsso

    ontology_domain = ontology_name.replace('_ontology', '')

    # clean mapping
    for col in mapping.columns:
        mapping[col] = mapping[col].str.strip()

    # clean df
    for col in df.columns:
        df[col] = df[col].astype(str)
    df = df.dropna(how='all').fillna('')

    # check if mandatory columns exist
    #mandatory_cols = mapping.loc[mapping['mandatory'] == 'yes', 'simple_name'].to_list()
    missing_parents = df[(df['type'] == 'class') & (df['parents'] == '')]['identifier'].to_list()
    missing_datatype = df[(df['type'] == 'attribute') & (df['relation_to'] == '')]['identifier'].to_list()
    if verbose:
        if (len(missing_parents) > 0):
            print('- missing parents in classes:', len(missing_parents))
        if (len(missing_datatype) > 0):
            print('- missing data type in attributes:', len(missing_datatype))

    # add namespaces for prefixes
    namespace_manager = NamespaceManager(Graph())
    for index, row in mapping[mapping['usage'] == 'prefix'].iterrows():
        namespace_manager.bind(str(row['simple_name']), str(row['rdf_name']))

    # read and clean df
    if csv_file != '':
        df = pd.read_csv(csv_file, dtype=str).dropna(how='all').fillna('')  # necessary

    # remove empty columns
    if (df.columns.isna().sum() > 0):
        print('- found empty column names')
        df = df.loc[:, df.columns.notna()]

    # check for empty identifier
    empty_identifier = ((df['identifier'] == '') & ~df['type'].str.startswith('#'))
    if (empty_identifier.sum() > 0):
        print('- missing identifiers: ', empty_identifier.sum())

    # remove is_part_of
    if ('is_part_of' in df.columns):
        df = df.drop(columns=['is_part_of'])

    # extract header
    authors = extract_header(df, 'author')
    contributors = extract_header(df, 'contributor')
    title = extract_header(df, 'title', first_string=True)
    prefix = extract_header(df, 'prefix', first_string=True)
    ns_url = extract_header(df, 'namespace', first_string=True)
    version = extract_header(df, 'version', first_string=True)
    description = extract_header(df, 'description')
    dependency = extract_header(df, 'import')
    namespace_manager.bind(prefix, ns_url)

    # check header
    if (title == []):
        print('- ontology title is emtpy -> stop')
        return('stop')

    # rename types to owl
    for index, row in mapping[mapping['usage'] == 'type'].iterrows():
        sel = df['type'].str.lower() == str(row['simple_name']).lower()
        df.loc[sel, 'type'] = str(row['rdf_name'])

    # split columns separated with comma
    for index, row in mapping[mapping['split'] == 'yes'].iterrows():
        col = row['simple_name']
        if col in df.columns:
            df[col] = df[col].str.split(',')
            df = df.explode(col)
            df[col] = df[col].str.strip()
    #df.to_csv('ontology/test.csv')

    # add empty_parents
    if empty_parents:
        df.loc[(df['parents'] == '') & (df['type'] == 'class'), 'parents'] = 'empty_parents'

    # rename datatypes to xsd
    for index, row in mapping[mapping['usage'] == 'relation_to'].iterrows():
        sel = df['type'].str.lower().str.strip() == str(row['simple_name']).lower().strip()
        df.loc[sel, 'type'] = str(row['rdf_name'])

    # copy name_en from identifier & vice versa
    sel = (df['name_en'] == '') & (df['identifier'] != '')
    df.loc[sel, 'name_en'] = df.loc[sel, 'identifier'].str.title()
    sel = (df['name_en'] != '') & (df['identifier'] == '')
    df.loc[sel, 'identifier'] = df.loc[sel, 'name_en']

    # remove empty identifier, commented lines
    df = df[(df['identifier'] != '') & (df['type'].str[0:1] != '#')]

    # add class to individuals
    separator = '_'
    sel = ~df['type'].str.startswith('#') & ~df['type'].str.contains(':')
    df.loc[sel, 'identifier'] = df.loc[sel, 'type'] + separator + df.loc[sel, 'identifier']
    #df.to_csv('ontology/test.csv')

    # split parents between class and attribute
    df['attribute_parents'] = ''
    sel = (df['type'].str.contains('DatatypeProperty') | df['type'].str.contains('AnnotationProperty')) & (df['parents'] != '')
    df.loc[sel, 'attribute_parents'] = df.loc[sel, 'parents']
    df.loc[sel, 'parents'] = ''

    # relation name in lowercase
    relation = df['type'].isin(['owl:ObjectProperty', 'owl:TransitiveProperty', 'owl:SymmetricProperty'])
    df.loc[relation, 'name_en'] = df.loc[relation, 'name_en'].str.lower()

    property_list = ['identifier', 'is_inverse_of', 'attribute_parents']

    # add provenance
    df['is_defined_by'] = ''
    sel = df['type'].str.contains('Class') | df['type'].str.contains('Property')
    # if ontology_name.__contains__('_'):
    #     ontology_name = ontology_name.replace('_', ' ') # e.g plant_ontology > plant ontology
    # df.loc[sel, 'is_defined_by'] = ontology_name
    df.loc[sel, 'is_defined_by'] = ns_url.replace('cx_ontology.ttl#', '')+ontology_name+'.ttl'

    # add attribute_parents based on attribute identifier ending (identifier, name, type, ...)
    attribute_suffix = mapping[(mapping['usage'] == 'attribute_suffix') & mapping['simple_name'].notnull()] \
        [['simple_name', 'type']].drop_duplicates()
    for index, row in attribute_suffix.iterrows():
        sel = (df['type'] == 'owl:DatatypeProperty') & \
              df['identifier'].str.lower().str.endswith(row['simple_name'])
        df.loc[sel, 'attribute_parents'] = row['type']

    # add attribute_parents based on attribute data type (date, date time, int, float, ...)
    attribute_type = mapping[(mapping['usage'] == 'relation_to') & mapping['type'].notnull()] \
        [['rdf_name', 'type']].drop_duplicates().sort_values('rdf_name')
    for index, row in attribute_type.iterrows():
        sel = (df['type'] == 'owl:DatatypeProperty') & (df['identifier'] != 'date time') & \
              df['relation_to'].str.lower().str.contains(row['rdf_name'])
        df.loc[sel, 'attribute_parents'] = row['type']

    # # part_of
    # if sum(df['is_part_of'] != '') > 0:
    #     part_of = df[df['is_part_of'] != '']
    #     part_of = part_of[['identifier', 'is_part_of']]
    #     part_of.columns = ['relation_from', 'relation_to']
    #     part_of['type'] = 'relation'
    #     part_of['identifier'] = 'is part of'
    #     df.loc[df.shape[0]+1] = ['']*df.shape[1]
    #     #df = pd.concat([df, part_of], axis=0, ignore_index=True)

    # clean URIs: camel case + prefix
    for index, row in mapping[mapping['type'] == 'URIRef'].iterrows():
        col = row['simple_name']
        if col in df.columns:
            # exclude empty rows and URIs, e.g. owl:Thing
            sel = (df[col] != '') & ~df[col].str.contains(':')
            # camel case for classes
            df.loc[sel, col] = df.loc[sel, col].str.title()
            df.loc[sel, col] = df.loc[sel, col].str.replace(' ', '')
            # lower camel case for properties
            relation = df['type'].str.contains('Property')
            if col in property_list:
                df.loc[relation, col] = \
                    df.loc[relation, col].str[:1].str.lower() + df.loc[relation, col].str[1:]
            # clean everything that is not A-z0-9:_
            df.loc[sel, col] = df.loc[sel, col] .str.replace('[^A-z0-9:_]', '', regex=True)
            # add prefix
            df.loc[sel, col] = prefix+':'+df.loc[sel, col]

    # extract abbreviations, syntax: word/phrase (abbrev.)
    aa_en = extract_abbreviations(df, col='synonyms_en')
    aa_de = extract_abbreviations(df, col='synonyms_de')

    # split abbreviations as own label, e.g. 'xx (X)' > 'xx', 'X'
    cols = ['synonyms_en', 'synonyms_de']
    for col in cols:
        if col in df.columns:
            df[col] = df[col].str.split('(')
            df = df.explode(col)
            df[col] = df[col].str.replace(')', '', regex=False)
            df[col] = df[col].str.strip()

    # create index (subject) from identifier
    df.set_index('identifier', inplace=True)

    if write_simple:
        #df = df[['type', 'name_en', 'name_de', 'parents']]
        df = df[['type', 'name_en', 'name_de', 'parents', 'relation_from', 'relation_to']]

    # rename column names from simple to rdf
    for index, row in mapping[mapping['usage'] == 'schema'].iterrows():
        df = df.rename(columns={row['simple_name']: row['rdf_name']})

    # clean all columns
    for col in df.columns:
        if type(df[col][0]) == str:
            df[col] = df[col].str.replace('[\(].*?[\)]', '', regex=True) # bracket content ()
            df[col] = df[col].str.replace('[\[].*?[\]]', '', regex=True) # bracket content []
            df[col] = df[col].str.strip()

    # convert back to NaN
    df = df.replace('', None) # necessary

    # convert and write turtle file
    g = rdfpandas.to_graph(df, namespace_manager = namespace_manager)

    # add class restrictions
    ns = Namespace(ns_url)
    for index, row in df[df['rdf:type'].str.endswith('Property')].iterrows():
        if (row['rdfs:domain'] != None) & (row['rdfs:range'] != None):
            property = index.replace('cx:', '')
            domain = row['rdfs:domain'].replace('cx:', '')
            range = row['rdfs:range'].replace('cx:', '')
            if row['rdfs:range'].startswith('xsd:'):
                data_type = row['rdfs:range'].replace('xsd:', '')
            else :
                data_type = ''
            g = add_class_restriction(g, property, domain, range, ns, data_type=data_type)

    # add metadata
    ns = Namespace(ns_url.replace('cx_ontology.ttl#', ''))
    ontology_uri = title.lower().replace(' ', '_')+'.ttl'
    g = g.add((ns[ontology_uri], RDF.type, OWL.Ontology))
    g = g.add((ns[ontology_uri], DC.title, Literal(title.title())))
    g = g.add((ns[ontology_uri], DC.date, Literal(date.today())))
    if len(version) > 0:
        g = g.add((ns[ontology_uri], OWL.versionInfo, Literal(version)))
    if len(authors) > 0:
        for author in authors:
            g = g.add((ns[ontology_uri], DC.creator, Literal(author)))
    if len(contributors) > 0:
        for contributor in contributors:
            g = g.add((ns[ontology_uri], DC.contributor, Literal(contributor)))
    if len(description) > 0:
        for x in description:
            g = g.add((ns[ontology_uri], DC.description, Literal(x)))
    if len(dependency) > 0:
        for import_ontology in dependency:
            g = g.add((ns[ontology_uri], OWL.imports, URIRef(ns[import_ontology.lower().replace(' ', '_')+'.ttl'])))

    # write ontology
    if ttl_file != '':
        g.serialize(destination=ttl_file, format = 'turtle')

    if write_csv != '':
        df.to_csv(write_csv)

    return g