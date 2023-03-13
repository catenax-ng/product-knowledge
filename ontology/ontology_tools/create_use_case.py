import pandas as pd
import numpy as np
import openpyxl
import graphviz
from os.path import exists
from rdflib import Graph, URIRef, Literal, Namespace, RDF, OWL, RDFS, SKOS, DC
from ontology.ontology_tools.create_ontology import write_formatted_excel
from ontology.ontology_tools.settings import cx_url, cx_file, mapping_path, use_case_path

def get_attribute_or_relation (df_row):
    if pd.notna(df_row['attribute']):
        return df_row['attribute']
    else:
        return df_row['relation']

def is_attribute_or_relation (df_row):
    if pd.notna(df_row['attribute']):
        return 'attribute'
    else:
        return 'relation'

def get_data_type_or_object (df_row):
    if pd.notna(df_row['data_type']):
        return df_row['data_type']
    else:
        return df_row['object']

def create_use_case_template(use_case_name):
    
    defined_columns = ['ontology','class', 'description', 'is_attribute_or_relation','attribute_or_relation','type_or_object', 'selection','comment','originator_role','consumer_role','provider_role','2nd_originator_role','2nd_consumer_role',"2nd_provider_role","..."]    
    header = ['# use case id','# use case name','# use case description','# use case roles [list]','# contract','# skill name','']
    header_part = ['','','','','','','']

    # read csv & get # ontology,class,attribute,data_type,relation,object
    ontology_table = pd.read_csv(mapping_path+'/cx_ontology.csv')
    ontology_table["is_attribute_or_relation"] = ontology_table.apply(is_attribute_or_relation,axis=1)
    ontology_table["attribute_or_relation"] = ontology_table.apply(get_attribute_or_relation,axis=1)
    ontology_table["type_or_object"] = ontology_table.apply(get_data_type_or_object,axis=1)
    ontology = ontology_table.loc[:,"ontology"]
    ontClass = ontology_table.loc[:,"class"]
    isAttribute = ontology_table.loc[:,"is_attribute_or_relation"]
    attribute = ontology_table.loc[:,"attribute_or_relation"]
    data_type = ontology_table.loc[:,"type_or_object"]
    
    # put ontology information in template
    main_table = pd.DataFrame({'ontology':  np.append(header, ontology.values),
    'class': np.append(header_part,ontClass.values),
    'is_attribute_or_relation': np.append(header_part, isAttribute.values),
    'attribute_or_relation': np.append(header_part, attribute.values),
    'type_or_object': np.append(header_part, data_type.values)
    }
    , columns= defined_columns)

    #write excel
    excel_file = 'ontology/ontology_use_case/'+ use_case_name + '_use_case_template.xlsx'
    if not exists(excel_file):
        print('# writing:', excel_file)
        write_formatted_excel(main_table, excel_file)
    else:
        print('# file already exists:', excel_file)

def create_use_case_ontology(use_case_name):

    #ontology settings
    main_ontology = Graph()
    main_ontology.parse(cx_file)
    use_case_ontology = Graph()
    cx_s = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#'
    schema_s = 'https://schema.org/'
    cx = Namespace(cx_s)
    schema = Namespace(schema_s)
    use_case_ontology.bind('cx',cx)
    use_case_ontology.bind('schema',schema)
    use_case_ontology.bind('skos',Namespace('http://www.w3.org/2004/02/skos/core#'))
    use_case_ontology.bind('dc',Namespace(DC._NS.__str__()))
    
    #read excel & get selected elements
    df = pd.read_excel('ontology/ontology_use_case/' + use_case_name + '_use_case_template.xlsx')
    rslt_df = df[(df['selection'] == 'x')]
    lisOfClasses = rslt_df['class']
    listOfObjects = rslt_df['type_or_object']
    listOfMode = rslt_df['is_attribute_or_relation']
    listOfPredicate = rslt_df['attribute_or_relation']

    meta_df = df[df["ontology"].str.contains("#")==True]
    print(meta_df)

       #add meta data
        # use case id
        # use case name
        # use case description
        # use case roles [list]
        # contract
        # skill name

    ontology = URIRef(cx_s + 'CxOntology')
    use_case_ontology.add((ontology, RDF.type, OWL.Ontology))

    for index, row in meta_df.iterrows():
        if((row['ontology'] =='# use case id')):
            use_case_ontology.add((ontology, DC.identifier, Literal(row['class'])))

        if((row['ontology'] =='# use case name')):
            use_case_ontology.add((ontology, DC.title, Literal(row['class'])))
    
        if((row['ontology'] =='# use case description')):
            use_case_ontology.add((ontology, DC.description, Literal(row['class'])))

        if((row['ontology'] =='# use case roles [list]')):
            use_case_ontology.add((ontology, DC.rights, Literal(row['class'])))

    #iter rows, create copy and paste classes, data properties and object properties
    for index, row in rslt_df.iterrows():
    
        classInExcel = URIRef(cx_s + row['class'].replace('cx:',''))

        #data property
        if( row['is_attribute_or_relation'] == 'attribute'):

            dataPropInExcel = URIRef(cx_s + row['attribute_or_relation'].replace('cx:',''))
            
            #if class not in graph add it
            if not (classInExcel, RDF.type, OWL.Class) in use_case_ontology:
                use_case_ontology.add((classInExcel, RDF.type, OWL.Class))

            #add ontology information of class
            addOntologyInformationOfClass(main_ontology, use_case_ontology, classInExcel, lisOfClasses, listOfObjects)

            #add data property
            if not (dataPropInExcel, RDF.type, OWL.DatatypeProperty) in use_case_ontology:
                use_case_ontology.add((dataPropInExcel, RDF.type, OWL.DatatypeProperty))

            #add dataproperty domain
            use_case_ontology.add((dataPropInExcel, RDFS.domain, classInExcel))

            #add other properties from cx ontology
            for s, p, o in main_ontology.triples((dataPropInExcel, None, None)):
                pAsString = p.__str__()
                if( (SKOS._NS.__str__() in pAsString) | 
                    (DC._NS.__str__() in pAsString) | 
                    (schema_s in pAsString) | 
                    (RDFS.seeAlso.__str__() in pAsString) |
                    (RDFS.range.__str__() in pAsString)  ):
                    
                    use_case_ontology.add((s, p, o))
            
            # add super property
            for s, p, o in main_ontology.triples((dataPropInExcel, RDFS.subPropertyOf, None)):
                simpleO = o.__str__().replace(cx_s,'cx:')
                if( (rslt_df['attribute_or_relation'].eq(simpleO)).any()):
                    use_case_ontology.add((s, p, o))

            #add roles
            if(not pd.isna(row['originator_role'])):
                use_case_ontology.add((dataPropInExcel, URIRef(cx_s + "UseCaseOriginator"), Literal(row['originator_role'] )))
            if(not pd.isna(row['consumer_role'])):
                use_case_ontology.add((dataPropInExcel, URIRef(cx_s + "UseCaseConsumer"), Literal(row['consumer_role'] )))
            if(not pd.isna(row['provider_role'])):
                use_case_ontology.add((dataPropInExcel, URIRef(cx_s + "UseCaseProvider"), Literal(row['provider_role'] )))

        #object property
        if((row['is_attribute_or_relation'] =='relation')):

            objectPropInExcel = URIRef(cx_s + row['attribute_or_relation'].replace('cx:',''))
            objectInExcel = URIRef(cx_s + row['type_or_object'].replace('cx:',''))
            
            # if class not in graph add it
            if not (classInExcel, RDF.type, OWL.Class) in use_case_ontology:
                use_case_ontology.add((classInExcel, RDF.type, OWL.Class))

            #add ontology information of class
            addOntologyInformationOfClass(main_ontology, use_case_ontology, classInExcel, lisOfClasses, listOfObjects)
            
            # if object not in graph add it
            if not (objectInExcel, RDF.type, OWL.Class) in use_case_ontology:
                use_case_ontology.add((objectInExcel, RDF.type, OWL.Class))
            
            #add ontology information of class
            addOntologyInformationOfClass(main_ontology, use_case_ontology, objectInExcel, lisOfClasses, listOfObjects)

            #add other properties from cx ontology
            for s, p, o in main_ontology.triples((objectPropInExcel, None, None)):
                pAsString = p.__str__()
                if( (SKOS._NS.__str__() in pAsString) |
                    (DC._NS.__str__() in pAsString) | 
                    (schema_s in pAsString) | 
                    (RDFS.seeAlso.__str__() in pAsString) ):
                    
                    use_case_ontology.add((s, p, o))
                
            # add super property
            for s, p, o in main_ontology.triples((objectPropInExcel, RDFS.subPropertyOf, None)):
                simpleO = o.__str__().replace(cx_s,'cx:')
                if( (rslt_df['attribute_or_relation'].eq(simpleO)).any()):
                    use_case_ontology.add((s, p, o))

            # add object property
            if not (objectPropInExcel, RDF.type, OWL.ObjectProperty) in use_case_ontology:
                use_case_ontology.add((objectPropInExcel, RDF.type, OWL.ObjectProperty))
                use_case_ontology.add((objectPropInExcel, RDFS.domain, classInExcel))
                use_case_ontology.add((objectPropInExcel, RDFS.range, objectInExcel))
            else:
                use_case_ontology.add((objectPropInExcel, RDFS.domain, classInExcel))
                use_case_ontology.add((objectPropInExcel, RDFS.range, objectInExcel))

            if(not pd.isna(row['originator_role'])):
                use_case_ontology.add((objectPropInExcel, URIRef(cx_s + "UseCaseOriginator"), Literal(row['originator_role'] )))
            if(not pd.isna(row['consumer_role'])):
                use_case_ontology.add((objectPropInExcel, URIRef(cx_s + "UseCaseConsumer"), Literal(row['consumer_role'] )))
            if(not pd.isna(row['provider_role'])):
                use_case_ontology.add((objectPropInExcel, URIRef(cx_s + "UseCaseProvider"), Literal(row['provider_role'] )))

    #output 
    use_case_ontology.serialize(destination= 'ontology/ontology_use_case/' + use_case_name +'_use_case_ontology.ttl', format='turtle')

def addOntologyInformationOfClass(main_ontology, use_case_ontology, ontClass, lisOfClasses, listOfObjects):
    cx_s = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#'
    schema_s = 'https://schema.org/'
    
    #add other properties from cx ontology
    for s, p, o in main_ontology.triples((ontClass, None, None)):
        pAsString = p.__str__()
        if( (SKOS._NS.__str__() in pAsString) | 
        (DC._NS.__str__() in pAsString) | 
        (schema_s in pAsString) | 
        (RDFS.seeAlso.__str__() in pAsString)):
            use_case_ontology.add((s, p, o))

    for s, p, o in main_ontology.triples((ontClass, RDFS.subClassOf, None)):
        simpleO = o.__str__().replace(cx_s,'cx:')
        if( (lisOfClasses.eq(simpleO)).any() | (listOfObjects.eq(simpleO)).any() ):
            use_case_ontology.add((s, p, o))

    for s, p, o in main_ontology.triples((ontClass, RDFS.isDefinedBy, None)):
          use_case_ontology.add((s, URIRef(cx_s + "has_domain"), Literal(o.__str__().replace('https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/','').replace('.ttl',''))))  

def create_ontology_visualization(use_case_name):
    cx_s = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#'
    main_ontology = Graph()
    main_ontology.parse(use_case_path + '/' + use_case_name + '_use_case_ontology.ttl' )
    counter = 0
    colors = ['deepskyblue', 'yellowgreen', 'yellow', 'magenta', 'orange', 'deeppink', 'purple', 'springgreen', 'green', 'blue' , 'red' , 'white',]
    dict = {}

    dot = graphviz.Digraph(name = 'use case ontology', 
    #,'rankdir':'RL'
    graph_attr = {'label': use_case_name + ' use case ontology', 'labelloc':'t','rankdir':'RL', 'fontsize':'10', 'fontname' : 'Helvetica,Arial,sans-serif'},  
    node_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'},edge_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'})
    dot_2 = graphviz.Digraph(name= 'cluster_mysubgraph',graph_attr = {'label':'Keys', 'fontsize':'5' ,'fontname' : 'Helvetica,Arial,sans-serif'}, 
    node_attr={'fontsize':'5','fontname' : 'Helvetica,Arial,sans-serif'})
    
    #add legend
    for s, p, o in main_ontology.triples((None, None, OWL.Class)):
        for s1, p1, o1 in main_ontology.triples((s, URIRef(cx_s + 'has_domain'), None)):

            domain_name = o1.__str__().replace(cx_s,'')

            if domain_name not in dict:
                dict.update({domain_name:colors[counter]})
                counter = counter +1
                node_color = dict[domain_name]
    n = 0
    keys = [*dict] 
    for key in keys:
        dot_2.node(key, key, style='filled' ,  fillcolor = dict[key])
        if ( (n-1) >= 0):
            dot_2.edge(key, keys[n-1], style='invis')
            print(keys[n-1])
        n = n+1

    dot_2.node('n1','subClassOf', color='white', shape = 'box')
    dot_2.node('n2','', style='invis', shape = 'point')
    dot_2.edge('n1', 'n2', style='dashed')
    
    #dot_2.node('n3','ObjectProperty', color='white', shape = 'box')
    #dot_2.node('n4','', style='invis', shape = 'point')
    #dot_2.edge('n3', 'n4')
    
    dot.subgraph(dot_2)

    for s, p, o in main_ontology.triples((None, None, OWL.Class)):
        node_color = 'white'
        for s1, p1, o1 in main_ontology.triples((s, URIRef(cx_s + 'has_domain'), None)):
            domain_name = o1.__str__().replace(cx_s,'')
            if domain_name in dict:
                node_color = dict[domain_name]
        dot.node(s.__str__().replace(cx_s,''), s.__str__().replace(cx_s,''), style='filled' ,  fillcolor = node_color) 

    # add edges
    for s, p, o in main_ontology.triples((None, None, OWL.ObjectProperty)):
        for s1, p1, o1 in main_ontology.triples((s, RDFS.domain, None)):
            for s2, p2, o2 in main_ontology.triples((s, RDFS.range, None)):

               dot.edge(o1.__str__().replace(cx_s,''), o2.__str__().replace(cx_s,''), label = s.__str__().replace(cx_s,'') ) 
    
    # add sub classes style=dashed
    for s, p, o in main_ontology.triples((None, RDFS.subClassOf, None)):
        dot.edge(s.__str__().replace(cx_s,''), o.__str__().replace(cx_s,''), style='dashed') 
    
    print(dot.source)  
    dot.render(directory= use_case_path, view=True)