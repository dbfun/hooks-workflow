#!/bin/bash

#################################################
#																								#
#								Скрипт установки								#
#																								#
#################################################

# Находясь в любом каталоге, находящемся под управлением git, выполнить любое из действий (два варианта устнановки):

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh)"
# sh -c "$(wget https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh -O -)"

# Ручная установка, находясь в корне проекта:
# cd .git/hooks
# echo y | rm -rf ./*
# git clone https://github.com/dbfun/hooks-workflow .
# ./configure

GIT_ROOT=`git rev-parse --show-toplevel`
if [ $? != 0 ]; then
	echo "Необходимо выполнять скрипт, находять в каталоге, находящимся под управлением Git"
	exit 1
fi

if [ ! -d "$GIT_ROOT/.git/hooks" ]; then
	echo "Не удалось найти каталог с хуками: $GIT_ROOT/.git/hooks"
	exit 1
fi

cd "$GIT_ROOT/.git/hooks"
ls -la

echo "Необходимо очистить каталог с хуками $GIT_ROOT/.git/hooks"
read -p "Удалить все эти файлы (y/n)?" -r
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	echo "Разумно"
	exit 1
fi

# Не будем удалять абсолютно все, чтобы был минимальный ущерб
echo y | rm -rf ./*
git clone https://github.com/dbfun/hooks-workflow.git .
if [ $? != 0 ]; then
	echo "Не удалось клонировать репозиторий"
	exit 1
fi

./configure
