#!/bin/bash

featureBranch=$(git symbolic-ref --short HEAD)

branchPadrao=$(git config --global --get init.defaultBranch)

if [ -z "$branchPadrao" ]; then
  echo "Erro: A branch padrão não foi encontrada. Verifique sua configuração do Git."
  exit 1
fi

git checkout $branchPadrao
if [ $? -ne 0 ]; then
  echo "Erro ao fazer checkout na branch $branchPadrao."
  exit 1
fi

git merge $featureBranch
if [ $? -ne 0 ]; then
  echo "Erro ao fazer merge da branch $featureBranch na $branchPadrao."
  exit 1
fi

git branch -D $featureBranch
if [ $? -ne 0 ]; then
  echo "Erro ao deletar a branch local $featureBranch."
  exit 1
fi

git push origin --delete $featureBranch
if [ $? -ne 0 ]; then
  echo "Erro ao deletar a branch remota $featureBranch."
fi

echo "$featureBranch merged into main and deleted"
