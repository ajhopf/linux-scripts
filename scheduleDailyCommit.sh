#!/bin/bash

if [ "$#" -lt 2 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: scheduleDailyCommit <diretorio-do-projeto> [mensagem-de-commit] [periodicidade]"
    exit 1
fi

# Diretório do script que já vem como padrão com execução através do alias scheduleDailyCommit
scriptPath="$1/dailyCommit.sh"
projectDir="$2"
commitMessage="auto-commit: commit automático."
periodicidade="0 12 * * *"

# Parsing de argumentos nomeados
shift 2 #começa na terceira posição pois o primeiro e segundo são pois o 1 e 2 sao posicionais
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --m) commitMessage="$2"; shift ;;
        --p) periodicidade="$2"; shift ;;
        *) echo "Parâmetro desconhecido: $1"; exit 1 ;;
    esac
    shift
done

echo "$projectDir"

cd "$HOME/$projectDir"

# Verifica se é um repositório git
if [ ! -d ".git" ]; then
	echo "Erro: o diretório informado não é um repostório git"
	exit 1	
fi

#Dir

# Verifica se o script de testes existe
if [ ! -f "$scriptPath" ]; then
    echo "Erro: o script $scriptPath não foi encontrado."
    exit 1
fi


cronJob="$periodicidade $scriptPath $projectDir \"$commitMessage\""


# Adiciona cronJob e remove duplicatas
(crontab -l; echo "$cronJob") | sort -u | crontab -

if [ $? -eq 0 ]; then
    echo "Cron job criada com sucesso: $cronJob"
else
    echo "Erro ao criar a cron job."
fi


