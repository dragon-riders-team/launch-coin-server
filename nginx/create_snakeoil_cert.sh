#!/bin/bash
openssl req -subj '/CN=localhost' -x509 -newkey rsa:4096 -nodes -keyout privkey.pem -out cert.pem -days 365

