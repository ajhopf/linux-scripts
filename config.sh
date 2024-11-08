#!/bin/bash

adicionar_alias() {
    local alias_nome=$1
    local alias_comando=$2

    # Veronica se o alias já existe no arquivo .bashrc
    if ! grep -q "alias $alias_nome=" ~/.bashrc; then
        echo "Adicionando alias: $alias_nome"
        echo "alias $alias_nome='$alias_comando'" >> ~/.bashrc
    else
        echo "Alias $alias_nome já existe. Nenhuma alteração feita."
    fi
}

currentPath=$(pwd)

echo $currentPath

adicionar_alias "iniciarProjeto" "$currentPath/iniciarProjeto.sh"
adicionar_alias "aczginit" "$currentPath/aczginit.sh"
adicionar_alias "aczgfinish" "$currentPath/aczgfinish.sh"
adicionar_alias "scheduleTests" "$currentPath/scheduleTests.sh $currentPath"
adicionar_alias "scheduleDailyCommit" "$currentPath/scheduleDailyCommit.sh $currentPath"
adicionar_alias "getLogs" "$currentPath/getLogs.sh"

# Recarrega o arquivo de configuração para aplicar as mudanças
source ~/.bashrc

chmod 755 "$currentPath/iniciarProjeto.sh"
chmod 755 "$currentPath/aczginit.sh"
chmod 755 "$currentPath/aczgfinish.sh"
chmod 755 "$currentPath/scheduleTests.sh"
chmod 755 "$currentPath/runTests.sh"
chmod 755 "$currentPath/scheduleDailyCommit.sh"
chmod 755 "$currentPath/dailyCommit.sh"
chmod 755 "$currentPath/getLogs.sh"
