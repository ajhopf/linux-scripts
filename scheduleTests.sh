#!/bin/bash


# Verifica se o número de argumentos é menor que 2
if [ "$#" -lt 2 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: scheduleTests <diretorio-do-projeto-gradle> [periodicidade]"
    exit 1
fi

#Diretório do script que já vem como padrão com execução através do alias scheduleTests
scriptPath="$1/runTests.sh"

# Verifica se o script de testes existe
if [ ! -f "$scriptPath" ]; then
    echo "Erro: o script $scriptPath não foi encontrado."
    exit 1
fi

# Parâmetro para o diretório do projeto
projectDir="$2"

# Parâmetro com a periodicidade da cron job
periodicidade="0 12 * * *"

if [ -n "$3" ]; then
	periodicidade="$3"
fi

echo "Periodicidade: $periodicidade"

JAVA_HOME=$(dirname $(dirname $(readlink -f $(which javac))))

cronJob="$periodicidade $scriptPath $projectDir $JAVA_HOME"

# Adiciona cronJob e remove duplicatas
(crontab -l; echo "$cronJob") | sort -u | crontab -

if [ $? -eq 0 ]; then
    echo "Cron job criada com sucesso: $cronJob"
else
    echo "Erro ao criar a cron job."
fi




