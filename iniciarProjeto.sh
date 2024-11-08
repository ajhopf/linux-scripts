#!/bin/bash

# Verifica se o número de argumentos é menor que 2
if [ "$#" -lt 2 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: iniciarProjeto <diretorio> <nomeDoProjeto>"
    exit 1
fi

diretorio=$1
nomeDoProjeto=$2

dirpath="$HOME/$diretorio/$nomeDoProjeto"

echo "Criando diretório: $dirpath"

mkdir -p $dirpath

cd $dirpath

echo "Inicializando repositório"

git init
echo "projeto $nomeDoProjeto inicializado...." >> README.md
git add README.md
git commit -m "first commit - repositório configurado"

