#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: ./dailyCommit.sh <diretorio-do-projeto> <message>"
    exit 1
fi

projectDir="$HOME/$1"
message="$2"

cd $projectDir

# Verifica se é um repositório git
if [ ! -d ".git" ]; then
	echo "[ACZG_CI] [ERROR] o diretório informado não é um repostório git: $projectDir Data: $(date)"
	exit 1	
fi

#Cria / Busca arquivo para logs
logdir="$HOME/logs"
mkdir -p $logdir
logfile="$logdir/cronjob.log"
echo "-----------------------------------------------------------" >> $logfile
echo "[ACZG_CI] [COMMIT] Iniciando processo de commit automático." >> $logfile

git add .

commit_output=$(git commit -m "$message Data: $(date)" 2>&1) # Captura a saída do comando

if [ $? -eq 0 ]; then
    echo "$commit_output" >> $logfile # Adiciona a saída ao log
    echo "[ACZG_CI] [COMMIT] [SUCCESS] commit automático realizado com sucesso. Projeto: $projectDir. Data: $(date)" >> $logfile
else
    echo "$commit_output" >> $logfile # Adiciona a saída ao log em caso de erro também
    echo "[ACZG_CI] [COMMIT] [ERROR] commit não realizado. Projeto: $projectDir Data: $(date)" >> $logfile
    exit 1
fi

# Configura e envia notificação
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

notify-send "Commit automático realizado no projeto: $projectDir"


