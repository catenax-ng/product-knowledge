# path settings
ontology_path = 'ontology'
tables_path = 'ontology/ontology_tables'
numbers_path = 'ontology/ontology_numbers'
tools_path = 'ontology/ontology_tools'
mapping_path = 'ontology/ontology_mapping'

# namespace settigns
from rdflib import Namespace
#cx_url = 'https://github.com/catenax-ng/product-knowledge/ontology/'
cx_url = 'https://raw.githubusercontent.com/catenax-ng/product-knowledge/main/ontology/cx_ontology.ttl#'
cx = Namespace(cx_url)
cx_file = ontology_path + '/cx_ontology.ttl'