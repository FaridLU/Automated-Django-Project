# Code for acktinos.com

import hashlib
import json


def recurion(json_data, exclude_list = []):
    if type(json_data) == dict and json_data: # This is Dictionary
        for key in list(json_data): # Iterating through Dictionary
            if key in exclude_list: # Removing the object if it is in 'exclude_list'
                del json_data[key]
            else:
                recurion(json_data[key], exclude_list)

    elif type(json_data) == list and json_data: # This is a List
        for entity in json_data: # Iterating through List
            recurion(entity, exclude_list)

def json_to_hash(json_data, exclude_list = []):
    org_json = json_data.copy()
    
    org_hash = hashlib.md5(json.dumps(json_data).encode("utf-8")).hexdigest() # Hashvalue before filtering
    
    recurion(json_data, exclude_list)

    filter_hash = hashlib.md5(json.dumps(json_data).encode("utf-8")).hexdigest() # Hashvalue after filtering

    return {
        'org_json': org_json,
        'org_hash': org_hash,
        'filter_json': json_data,
        'filter_hash': filter_hash
    }
    

a = [{
        "widget": {
            "debug": "on",
            "window": {
                "title": "Sample Konfabulator Widget",
                "name": "main_window",
                "width": 500,
                "height": 500
            },
            "image": { 
                "src": "Images/Sun.png",
                "name": "sun1",
                "hOffset": 250,
                "vOffset": 250,
                "alignment": "center"
            },
            "text": {
                "data": "Click Here",
                "size": 36,
                "style": "bold",
                "name": "text1",
                "hOffset": 250,
                "vOffset": 100,
                "alignment": "center",
                "onMouseUp": "sun1.opacity = (sun1.opacity / 100) * 90;"
            }
        }
    }
]


response = json_to_hash(a, ['alignment3'])

print(response['org_hash'])
print(response['filter_hash'])