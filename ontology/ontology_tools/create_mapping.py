from ontology.ontology_tools.settings import mapping_path, cx_url
from ontology.ontology_tools.ontology_tools import read_numbers2df, title_to_camel, title_to_pascal
from rdflib import Graph, URIRef, Literal, Namespace, BNode
from rdflib.namespace import RDF

def create_mapping(mapping_file, verbose = False):
    # no subject
    table_type_list = ["SQL2008", "Parquet", "CSV", "XPath", "JSONPath"]

    # read csv file
    df = read_numbers2df(mapping_file).dropna(how='all').fillna('')

    CX = Namespace(cx_url)
    RR = Namespace('http://www.w3.org/ns/r2rml#')
    RML = Namespace('http://semweb.mmlab.be/ns/rml#')
    QL = Namespace('http://semweb.mmlab.be/ns/ql')
    XSD = Namespace('http://www.w3.org/2001/XMLSchema#')

    # start
    graph = Graph()

    # add name space
    graph.bind("cx", CX)
    graph.bind("rr", RR)
    graph.bind("rml", RML)
    graph.bind("ql", QL)
    graph.bind("xsd", XSD)

    maps = df[~df['type'].str.startswith('#') & (df['map'] != '')]['map'].unique().tolist()
    print('# found number of maps: ', len(maps), maps)
    for map in maps:
        # create triple map (mapping)
        df_map = df[df['map'] == map]
        triple_map = map.replace('cx:', '')
        if triple_map.startswith('cx:'): triple_map = triple_map.replace('cx:', '')
        #triple_map = title_to_pascal(map)
        if verbose: print(triple_map)
        graph.add((CX[triple_map], RDF.type, RR.TriplesMap))

        # add class & table
        class_name = df_map[df_map['type'] == 'class']['class'].to_string(index=False)
        if class_name.startswith('cx:'): class_name = class_name.replace('cx:', '')
        #class_name = title_to_pascal(class_name)
        table_name = df_map[df_map['type'] == 'class']['table_name'].to_string(index=False)
        table_type = df_map[df_map['type'] == 'class']['table_type'].to_string(index=False)
        table_path = df_map[df_map['type'] == 'class']['table_path'].to_string(index=False)
        assert table_type in table_type_list, f"'{table_type}' is not a valid table type"
        if verbose: print(class_name, '->', table_name)

        bn_table = BNode()
        graph.add((CX[triple_map], RR.logicalTable, bn_table))
        graph.add((bn_table, RR.tableName, Literal(table_name, lang="en")))
        graph.add((bn_table, RML.source, Literal(table_path, lang="en")))
        graph.add((bn_table, RML.referenceFormulation, RR[table_type] if table_type=="SQL2008" else QL[table_type]))
        #if table_type in ("XPath", "JSONPath"): graph.add((bn_table, RML.iterator, Literal(iterator)))

        # prepare subject & primary key
        subject = df_map[df_map['type'] == 'subject']['attribute'].to_string(index=False)
        if subject.startswith('cx:'): subject = subject.replace('cx:', '')
        #subject = title_to_pascal(subject)
        primary_key = df_map[df_map['type'] == 'subject']['column'].to_string(index=False)
        if verbose: print(subject, '->', primary_key)

        # add subject & primary key
        bn_subject = BNode()
        graph.add((CX[triple_map], RR.subjectMap, bn_subject))
        # rr:template "http://data.example.com/employee-{EMPNO}";
        # http://data.example.com/employee={EMPNO}/department={DEPTNO}
        graph.add((bn_subject, RR.template, Literal(cx_url + class_name + '_' + f"{{{primary_key}}}")))
        graph.add((bn_subject, RR["class"], CX[class_name]))
        graph.add((bn_subject, RR.column, Literal(primary_key)))

        # add attribute & column
        df_attr = df_map[df_map['type'].isin(['attribute', 'subject'])]
        for index, row in df_attr.iterrows():
            attribute = row['attribute']
            if attribute.startswith('cx:'): attribute = attribute.replace('cx:', '')
            #attribute = title_to_camel(attribute)
            column = row['column']
            if column != '':
                data_type = row['data_type']
                if verbose: print(attribute, '->', column)

                bn_predicate = BNode()
                graph.add((CX[triple_map], RR.predicateObjectMap, bn_predicate))
                graph.add((bn_predicate, RR.predicate, CX[attribute]))

                bn_object = BNode()
                graph.add((bn_predicate, RR.objectMap, bn_object))
                graph.add((bn_object, RR.column, Literal(column)))
                if data_type.startswith('xsd:'): data_type = data_type.replace('xsd:', '')
                graph.add((bn_object, RR.datatype, XSD[data_type]))


        # add relation, i.e. join from child to parent, i.e. from triple_map to target_map
        df_rel = df_map[df_map['type'] == 'relation']
        for index, row in df_rel.iterrows():
            relation = row['relation']                       # child (triple_map)
            #relation = title_to_camel(relation)
            foreign_key = row['foreign_key']                 # child column
            target_map = row['target_map']                   # parent (target_map)
            #target_map = title_to_camel(target_map)
            primary_key = row['primary_key']                 # parent column
            if foreign_key != '':
                if primary_key == '': primary_key = foreign_key  # under the assumption that they are the same
                if verbose: print(relation, '->', foreign_key)

                bn_predicate = BNode()
                graph.add((CX[triple_map], RR.predicateObjectMap, bn_predicate))
                graph.add((bn_predicate, RR.predicate, CX[relation]))

                bn_object = BNode()
                graph.add((bn_predicate, RR.objectMap, bn_object))
                graph.add((bn_object, RR.parentTriplesMap, CX[target_map]))

                bn_condition = BNode()
                graph.add((bn_object, RR.joinCondition, bn_condition))
                graph.add((bn_condition, RR.child, Literal(foreign_key)))  # child column
                graph.add((bn_condition, RR.parent, Literal(primary_key))) # parent column

    return graph


# mapping_file = mapping_path+'/vehicle_bmw_mapping.numbers'
# ttl_file = mapping_path + '/vehicle_bmw_mapping.ttl'#'/' + ontology + '_ontology.ttl'
#
# graph=create_mapping(mapping_file)
# graph.serialize(destination=ttl_file, format='turtle')


mapping_file = mapping_path+'/bmw_test_mapping.numbers'
ttl_file = mapping_path + '/bmw_test_mapping.ttl'#'/' + ontology + '_ontology.ttl'
graph=create_mapping(mapping_file, verbose=True)
graph.serialize(destination=ttl_file, format='turtle')
