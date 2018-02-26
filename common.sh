# Нет смысла разделять stdout и stderr, так как
# Both standard output and standard error output are forwarded to git send-pack on the other end,
# so you can simply echo messages for the user.
# @see https://git-scm.com/docs/githooks

# Разрешаем алиасы, нужно для управления git
shopt -s expand_aliases

# Следует ли раскрашивать вывод?
if [ -n "$GIT_CLI" ] && [ "$GIT_CLI" -eq "1" ]; then
	# Отключаем встроенное раскрашивание git
	alias git='git -c color.ui=false'
else
	# Включаем встроенное раскрашивание git
	alias git='git -c color.ui=always'
	# Библиотека цветов
	source $(dirname "$0")/colors.sh
fi

#
# Конфигурация
#

declare -A GIT_HOOKS
source $(dirname "$0")/config.sh

# Если значения не определены, загружаем умолчания

if [[ ! -n "${GIT_HOOKS['files.check.tmp']}" ]]; then
  GIT_HOOKS[files.check.tmp]='1'
fi

if [[ ! -n "${GIT_HOOKS['files.check.whitespace']}" ]]; then
  GIT_HOOKS[files.check.whitespace]='1'
fi

if [[ ! -n "${GIT_HOOKS['files.check.bom']}" ]]; then
  GIT_HOOKS[files.check.bom]='1'
fi

if [[ ! -n "${GIT_HOOKS['php.check.codestyle']}" ]]; then
  GIT_HOOKS[php.check.codestyle]='1'
fi

if [[ ! -n "${GIT_HOOKS['php.bin']}" ]]; then
	GIT_HOOKS[php.bin]=`which php`
fi

#
# Функции
#

# Вывод сообщений, если включен подробный режим
function echoVerbose {
	if [ -n "$GIT_HOOKS_VERBOSE" ] && [ "$GIT_HOOKS_VERBOSE" -eq "1" ]; then
		echo -e $1
	fi
}

function echoColorVerbose {
	echoVerbose "$BPurple""$1""$Color_Off"
}


# if git rev-parse --verify HEAD >/dev/null 2>&1
# then
# 	against=HEAD
# else
# # Initial commit: diff against an empty tree object
# 	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
# fi
