import pandas as pd
import numpy as np
import openpyxl
from os.path import exists
from rdflib import Graph, URIRef, Literal, Namespace, RDF, OWL, RDFS, SKOS, DC
from ontology.ontology_tools.create_ontology import write_formatted_excel
from ontology.ontology_tools.settings import cx_url, cx_file, mapping_path

def create_use_case_template(use_case_name):
    
    defined_columns = ['ontology','class', 'description', 'classattribute','data_type', 'attribute_selection', 'relation', 'object','relation_selection', 'consumer roles', 'provider roles']
    header = ['# use case id','# use case name','# use case description','# use case roles [list]','# contract','# skill name','']
    header_part = ['','','','','','','']

    # read csv & get # ontology,class,attribute,data_type,relation,object
    ontology_table = pd.read_csv(mapping_path+'/cx_ontology.csv')
    ontology = ontology_table.loc[:,"ontology"]
    ontClass = ontology_table.loc[:,"class"]
    attribute = ontology_table.loc[:,"attribute"]
    data_type = ontology_table.loc[:,"data_type"]
    relation = ontology_table.loc[:,"relation"]
    object = ontology_table.loc[:,"object"]

    # put ontology information in template
    main_table = pd.DataFrame({'ontology':  np.append(header, ontology.values),
    'class': np.append(header_part,ontClass.values),
    'classattribute': np.append(header_part, attribute.values),
    'data_type': np.append(header_part, data_type.values),
    'relation':  np.append(header_part, relation.values),
    'object': np.append(header_part, object.values),
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
    
    #read excel & get selected elements
    df = pd.read_excel('ontology/ontology_use_case/' + use_case_name + '_use_case_template.xlsx')
    rslt_df = df[(df['relation_selection'] == 'x') | (df['attribute_selection'] == 'x')]
    lisOfClasses = rslt_df['class']
    listOfObjects = rslt_df['object']

    #iter rows, create copy and paste classes, data properties and object properties
    for index, row in rslt_df.iterrows():
        
        classInExcel = URIRef(cx_s + row['class'].replace('cx:',''))

        #data property
        if((row['attribute_selection'] =='x')):

            dataPropInExcel = URIRef(cx_s + row['classattribute'].replace('cx:',''))
            
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
                if( (rslt_df['classattribute'].eq(simpleO)).any()):
                    use_case_ontology.add((s, p, o))

            #add roles
            if(not pd.isna(row['consumer roles'])):
                use_case_ontology.add((dataPropInExcel, URIRef(cx_s + "consumer_role"), Literal(row['consumer roles'] )))
            if(not pd.isna(row['provider roles'])):
                use_case_ontology.add((dataPropInExcel, URIRef(cx_s + "provider_role"), Literal(row['provider roles'] )))

        #object property
        if((row['relation_selection'] =='x')):

            objectPropInExcel = URIRef(cx_s + row['relation'].replace('cx:',''))
            objectInExcel = URIRef(cx_s + row['object'].replace('cx:',''))
            
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
                if( (rslt_df['relation'].eq(simpleO)).any()):
                    use_case_ontology.add((s, p, o))

            # add object property
            if not (objectPropInExcel, RDF.type, OWL.ObjectProperty) in use_case_ontology:
                use_case_ontology.add((objectPropInExcel, RDF.type, OWL.ObjectProperty))
                use_case_ontology.add((objectPropInExcel, RDFS.domain, classInExcel))
                use_case_ontology.add((objectPropInExcel, RDFS.range, objectInExcel))
            else:
                use_case_ontology.add((objectPropInExcel, RDFS.domain, classInExcel))
                use_case_ontology.add((objectPropInExcel, RDFS.range, objectInExcel))

            if(not pd.isna(row['consumer roles'])):
                use_case_ontology.add((objectPropInExcel, URIRef(cx_s + "consumer_role"), Literal(row['consumer roles'] )))
            if(not pd.isna(row['provider roles'])):
                use_case_ontology.add((objectPropInExcel, URIRef(cx_s + "provider_role"), Literal(row['provider roles'] )))

    #output 
    use_case_ontology.serialize(destination= 'ontology/ontology_use_case/' + use_case_name +'_use_case_ontolog.ttl', format='turtle')

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