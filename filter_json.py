# Code for Tareq

import json

FILENAME_LIST = ['a.json', 'a.json']

OUTPUT_FILENAME = 'dictionary.json'

def get_def(json_data):
    try:
        for entity in json_data['meanings']: # Iterating through List
            if entity['def']:
                return entity['def']
    except:
        return ''

def json_filter(json_data, all_output):
    for key in list(json_data):
        all_output['dictionary'].append({
            'word': json_data[key]['word'],
            'meanings': get_def(json_data[key]),
        })

all_output = {}

with open(OUTPUT_FILENAME, 'r') as file:
    try:
        all_output = json.load(file)
    except:
        all_output['dictionary'] = []

for FILENAME in FILENAME_LIST:
    with open(FILENAME, 'r') as file:
        json_file = json.load(file)
        json_filter(json_file, all_output)

with open(OUTPUT_FILENAME, 'w') as file:
    json.dump(all_output, file, indent=4)