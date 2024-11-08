#!/bin/bash

# Verifica se o número de argumentos é menor que 1
if [ "$#" -lt 1 ]; then
    echo "Erro: Parâmetros insuficientes."
    echo "Uso correto: aczginit <nome-da-feature>"
    exit 1
fi


# Verifica se é um repositório git e loga o status
if [ ! -d ".git" ]; then
	echo "Erro: o diretório atual não é um repostório git"
	exit 1	
fi

echo "Status do repositório:"
git status
echo

branchName="feature-$1"

git switch -c $branchName

echo
echo "Branch '$branchName' criada."

echo
echo "Branches locais e remotas:"
git branch -a


