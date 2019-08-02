#!/usr/bin/env python3
import json
import sys
import re


# define user and password
coin_name = sys.argv[1]
file_name = (
    "/var/lib/docker/volumes/" +
    coin_name +
    "/_data/" +
    coin_name +
    "/" +
    coin_name +
    ".conf")
rpcuser = ''
rpcpassword = ''
with open(file_name, 'r') as file:
    for line in file:
        line = line.rstrip()
        regex = re.compile("rpcuser=(.*)")
        try:
            rpcuser = regex.match(line).group(1)
        except: pass
        regex = re.compile("rpcpassword=(.*)")
        try:
            rpcpassword = regex.match(line).group(1)
        except: pass

config_object = {
    "network": "mainnet",
    "port": 3001,
    "services": [
        "bitcoind",
        "insight-api-komodo",
        "insight-ui-komodo",
        "web"
    ],
    "servicesConfig": {
        "bitcoind": {
            "connect": [
                {
                    "rpchost": "127.0.0.1",
                    "rpcport": 28388,
                    "rpcuser": rpcuser,
                    "rpcpassword": rpcpassword,
                    "zmqpubrawtx": "tcp://127.0.0.1:8332"
                }
            ]
        },
        "insight-api-komodo": {
            "rateLimiterOptions": {
                "whitelist": [
                    "::ffff:127.0.0.1",
                    "127.0.0.1"
                ],
                "whitelistLimit": 500000,
                "whitelistInterval": 3600000
            }
        }
    }
}

print(json.dumps(config_object))

