#!/bin/bash
nomeApp="<NOME-APP>"
cd /data/app
npm install

sudo supervisord
sudo supervisorctl start $nomeApp
