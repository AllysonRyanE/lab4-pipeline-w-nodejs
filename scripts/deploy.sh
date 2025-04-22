#!/bin/bash

set -e
set -x

# Instalar Node.js, npm, git e supervisor
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
#!/bin/bash

set -e
set -x

apt-get update -y
apt-get install -y nodejs git supervisor

# Corrige permissões do projeto
chown -R ubuntu:ubuntu /home/ubuntu/data/app

# Entrar na pasta do projeto
cd /home/ubuntu/data/app

# Instalar dependências e buildar como ubuntu
sudo -u ubuntu npm install
sudo -u ubuntu NODE_OPTIONS=--openssl-legacy-provider npm run build

# Criar/atualizar arquivo do Supervisor
SUPERVISOR_CONF="/etc/supervisor/conf.d/lab4-pipeline-w-nodejs.conf"
cat <<EOF > $SUPERVISOR_CONF
[program:lab4-pipeline-w-nodejs]
directory=/home/ubuntu/data/app
command=npx serve -s build -l 3000
autostart=true
autorestart=true
stopasgroup=true
killasgroup=true
stderr_logfile=/var/log/lab4-pipeline-w-nodejs.err.log
stdout_logfile=/var/log/lab4-pipeline-w-nodejs.out.log
user=ubuntu
environment=NODE_OPTIONS="--openssl-legacy-provider",HOME="/home/ubuntu",USER="ubuntu"
EOF

# Atualizar Supervisor e reiniciar o app
supervisorctl reread
supervisorctl update
supervisorctl stop lab4-pipeline-w-nodejs || true
supervisorctl start lab4-pipeline-w-nodejs
