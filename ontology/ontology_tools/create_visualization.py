import graphviz
from rdflib import Graph, SKOS, OWL, RDFS
from ontology.ontology_tools.settings import ontology_path, refactored_path

# only for rectored ontologies
def create_domain_ontology_visualization(domain_name):
    cx_s = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#'
    main_ontology = Graph()
    main_ontology.parse( refactored_path + '/' + domain_name + '_ontology_refactored.ttl')
    counter = 0
    colors = ['deepskyblue', 'yellowgreen', 'yellow', 'magenta', 'orange', 'deeppink', 'purple', 'springgreen', 'green', 'blue' , 'red' , 'white',]
    dict = {}

    dot = graphviz.Digraph(name = 'domain ontology', 
    #,'rankdir':'RL'
    graph_attr = {'label': domain_name + ' ontology', 'labelloc':'t','rankdir':'RL', 'fontsize':'10', 'fontname' : 'Helvetica,Arial,sans-serif'},  
    node_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'},edge_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'})
    dot_2 = graphviz.Digraph(name= 'cluster_mysubgraph',graph_attr = {'label':'Keys', 'fontsize':'5' ,'fontname' : 'Helvetica,Arial,sans-serif'}, 
    node_attr={'fontsize':'5','fontname' : 'Helvetica,Arial,sans-serif'})
    
    #add legend
    '''
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
    '''

    dot_2.node('n1','subClassOf', color='white', shape = 'box')
    dot_2.node('n2','', style='invis', shape = 'point')
    dot_2.edge('n1', 'n2', style='dashed')
    dot.subgraph(dot_2)

    for s, p, o in main_ontology.triples((None, None, OWL.Class)):
        node_color = 'white'
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
    dot.render(directory= refactored_path, view=True)

def create_taxonomy_visualization():
    cx_s = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_taxonomy.ttl#'
    main_ontology = Graph()
    main_ontology.parse(ontology_path + '/' + 'cx_taxonomy.ttl' )
    dot = graphviz.Digraph(name = 'taxonomy', 
    graph_attr = {'label': 'skos taxonomy', 'labelloc':'t','rankdir':'LR', 'fontsize':'10', 'fontname' : 'Helvetica,Arial,sans-serif'},  
    node_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'},edge_attr = {'fontsize':'8', 'fontname':'Helvetica,Arial,sans-serif'})
    
    #Node
    for s, p, o in main_ontology.triples((None, None, SKOS.Concept)): 
        dot.node(s.__str__().replace(cx_s,''), s.__str__().replace(cx_s,'')) 

    # add edges
    for s, p, o in main_ontology.triples((None, SKOS.broader, None)):
        dot.edge(o.__str__().replace(cx_s,''), s.__str__().replace(cx_s,''),) 
    
    print(dot.source)  
    dot.render(directory = ontology_path, view=True)