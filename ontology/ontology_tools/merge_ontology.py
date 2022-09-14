import os
from rdflib.namespace import RDF, RDFS, OWL, DC
from rdflib import Graph, URIRef, Literal
from datetime import date


def merge_ontology(path = 'group_ontology', folder = 'bmw_ontology', file_out = 'bmw_ontology.ttl'):

    # create bmw ontology folder
    if not os.path.exists(folder):
        os.makedirs(folder)

    # get file list
    files = os.listdir(path)
    files.sort()

    # start
    g = Graph()
    for file in files:
        if not file.startswith('.'):
            ttl_file = path+'/'+file+'/'+file+'_ontology.ttl'
            if os.path.exists(ttl_file):
                #print('# merging: ', ttl_file)

                # read ontology
                graph = Graph().parse(ttl_file)

                status = 'red'
                # remove ontology annotations
                if (None, RDF['type'], OWL['Ontology']) in graph:
                    ontology = graph.value(None, RDF.type, OWL.Ontology)
                    status = str(graph.value(ontology, BMW['ontologyStatus'], None))
                    graph = graph.remove((ontology, None, None))

                # merge ontology
                if status.startswith('green'):
                    print('# merging: ', ttl_file)
                    g = g + graph

    # add meta data
    link = 'https://atc.bmwgroup.net/confluence/display/EKG/Group+Ontology'
    ontology_iri = 'BmwOntology'
    g = g.add((BMW[ontology_iri], RDF.type, OWL.Ontology))
    g = g.add((BMW[ontology_iri], DC.title, Literal('BMW Group Ontology')))
    g = g.add((BMW[ontology_iri], DC.date, Literal(date.today())))
    g = g.add((BMW[ontology_iri], DC.creator, Literal('BMW Group')))
    g = g.add((BMW[ontology_iri], RDFS.seeAlso, URIRef(link)))

    # write
    print(file_out)
    g.serialize(destination=folder+'/'+file_out, format='turtle')
