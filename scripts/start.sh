#!/bin/bash
nomeApp="<NOME-APP>"
cd /appdir
npm install

sudo supervisord
sudo supervisorctl start $nomeApp
