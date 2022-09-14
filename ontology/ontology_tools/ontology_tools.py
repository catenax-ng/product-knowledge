################################################################################################################
import json

def write_json(json, file):
    with open(file, 'w') as f:
        json.dump(file, f, indent=4, sort_keys=True)
    f.close()

def read_json(file):
    with open(file, 'r') as f:
        json.load(f)
    f.close()

from bs4 import BeautifulSoup

def write_html_string(html, file):
    with open(file, 'w') as f:
        f.write(BeautifulSoup(html, 'html.parser').prettify())
    f.close()

import os
def change_file_ext(file, ext):
    return os.path.splitext(file)[0]+ext

################################################################################################################
import re

# CamelToSnake > camel_to_snake
def camel_to_snake(name):
    return ''.join(['_'+char.lower() if char.isupper() else char for char in name])

# snake_to_camel > snakeToCamel
def snake_to_camel(name):
    name = name.split('_')
    return name[0].lower() + ''.join(word.title() for word in name[1:])

# snake_to_pascal > SnakeToPascal
def snake_to_pascal(name):
    return ''.join(word.title() for word in name.split('_'))

# Title To Snake > title_to_snake
def title_to_snake(name):
    return '_'.join(word.lower() for word in name.split(' '))

# Title To Camel > titleToCamel
def title_to_camel(name):
    name = name.split(' ')
    return name[0].lower() + ''.join(word.title() for word in name[1:])

# Title To Pascal > TitleToPascal
def title_to_pascal(name):
    return ''.join(word.title() for word in name.split(' '))

def camel_to_snake_fast(name):
    return re.compile(r'(?<!^)(?=[A-Z])').sub('_', name).lower()

def camel_to_title_fast(name):
    return re.compile(r'(?<!^)(?=[A-Z])').sub(' ', name).Title()

# def camel_to_snake(name):
#     #name = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
#     return re.sub('([a-z0-9])([A-Z])', r'\1_\2', name).lower()

def camel_to_snake_re(name):
    return re.sub(r'(?<!^)(?=[A-Z])', '_', name).lower()

# clean arbitrary notation
def clean_notation(name, notation='default', case='default', delimiter=' ', leave_case=False):

    # clean notation
    name = re.sub('([a-z0-9])([A-Z])', r'\1 \2', name)          # space for camel cases
    name = re.sub('([A-Z])([A-Z])([a-z]+)', r'\1 \2\3', name)   # space after acronyms
    name = re.sub('([0-9])([a-z])', r'\1 \2', name)             # space after numbers
    name = re.sub('([A-z])([0-9])', r'\1 \2', name)             # space before numbers
    name = ' '.join(word for word in name.split('_'))           # clean snake cases
    name = re.sub('[^A-z0-9]', ' ', name).strip()               # replace special characters with delimiter
    name = re.sub('\s+', ' ', name).strip()                     # remove multiple spaces

    # prepare notation
    if notation == 'snake':
        case = 'lower'
        delimiter = '_'
    if notation == 'pascal' or notation == 'camel':
        case = 'title'
        delimiter = ''
    if notation == 'title':
        case = 'title'
        delimiter = ' '

    # prepare case
    if not leave_case:
        if case == 'default':
            if name.isupper():
                name = name.lower()
            else:
                # convert title to lower and leave acronyms upper
                name = ' '.join([word.lower() if word.istitle() else word for word in name.split()])
        if case == 'lower':
            name = name.lower()
        if case == 'upper':
            name = name.upper()
        if case == 'title':
            name = name.title()
        if case == 'capitalize':
            name = name.capitalize()

    # prepare delimiter
    if delimiter != ' ':
        name = re.sub(' ', delimiter, name)
    if notation == 'camel':
         name = name[:1].lower() + name[1:]

    return name

# check if name has clean notation
def notation_is_clean(name, notation='snake'):
    clean_name = clean_notation(name, notation=notation)
    if clean_name == name:
        return True
    else:
        return False

# read numbers file
from numbers_parser import Document # pip install numbers-parser
import pandas as pd
def read_numbers2df(file, sheet=0, table=0):
    doc = Document(file)
    sheets = doc.sheets()
    tables = sheets[0].tables()
    data = tables[0].rows(values_only=True)
    df = pd.DataFrame(data, columns=data[0])
    df = df[1:] # remove first column
    return df
