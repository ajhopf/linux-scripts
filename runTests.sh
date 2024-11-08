#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: runTests <diretorio> <java-home>"
    exit 1
fi

#Necessita setar a java_home para ser executado como cron job
JAVA_HOME=$2
export JAVA_HOME

#Cria / Busca arquivo para logs
logdir="$HOME/logs"
mkdir -p $logdir
logfile="$logdir/cronjob.log"

diretorio=$1
dirpath="$HOME/$diretorio"

cd $dirpath

# Verifica se é um projeto com gradle
if [ ! -d "gradle" ]; then
	echo "Erro: o diretório não é um projeto gradle"
	exit 1	
fi

data=$(date "+%Y-%m-%d %H:%M:%S")
n
echo "-----------------------------------------------------------" >> $logfile
echo "[ACZG_CI] [TEST] Iniciando testes" >> $logfile

./gradlew test >> $logfile 2>&1
if [ $? -eq 0 ]; then
    echo "[ACZG_CI] [TEST] [SUCCESS] Testes concluídos com sucesso. Projeto: $dirpath Data: $(date)" >> $logfile
else
    echo "[ACZG_CI] [TEST] [ERROR] Ao menos um teste falhou. Projeto: $dirpath Data: $(date)" >> $logfile
fi

# Configura e envia notificação
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

notify-send "Testes realizados no $dirpath"


