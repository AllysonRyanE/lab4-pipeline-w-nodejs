#!/bin/bash
nomeApp="lab4-pipeline-w-nodejs"
cd /data/app/
npm install

sudo supervisord
sudo supervisorctl start $nomeApp
