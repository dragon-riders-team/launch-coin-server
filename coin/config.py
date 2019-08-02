#!/usr/bin/env python3
import sys
import json
import os


script_dir = os.path.dirname(os.path.realpath(__file__))
config_json = None
with open(script_dir + '/config.json') as json_file:
    config = json.load(json_file)

PARAMS = config
try:
    print(PARAMS[sys.argv[1]])
except:
    params_string = " "
    for i in PARAMS:
        params_string += "-" + i + "=" + str(PARAMS[i]) + " "
    print(params_string)

