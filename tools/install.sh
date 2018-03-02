#!/usr/bin/env bash

#################################################
#																								#
#								Скрипт установки								#
#																								#
#################################################

# Находясь в любом каталоге, находящемся под управлением git, выполнить любое из действий (два варианта устнановки):

# /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh)"
# /usr/bin/env bash -c "$(wget https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh -O -)"

# Ручная установка, находясь в корне проекта:
# cd .git/hooks
# echo y | rm -rf ./*
# git clone https://github.com/dbfun/hooks-workflow.git .
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

echo "Необходимо очистить каталог с хуками $GIT_ROOT/.git/hooks:"
cd "$GIT_ROOT/.git/hooks"
ls -l

read -p "Удалить все эти файлы (y/n)?"
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
