# Нет смысла разделять stdout и stderr, так как
# Both standard output and standard error output are forwarded to git send-pack on the other end,
# so you can simply echo messages for the user.
# @see https://git-scm.com/docs/githooks

# Разрешаем алиасы, нужно для управления git
shopt -s expand_aliases

# Следует ли раскрашивать вывод?
# core.quotepath=off - исправление проблемы с файлами в unicode кодировке
if [ -n "$GIT_CLI" ] && [ "$GIT_CLI" -eq "1" ]; then
	# Отключаем встроенное раскрашивание git
	alias git='git -c core.quotepath=off -c color.ui=false'
else
	# Включаем встроенное раскрашивание git
	alias git='git -c core.quotepath=off -c color.ui=always'
	# Библиотека цветов
	source "$(dirname $0)/colors.sh"
fi

# С чем делать git-diff

if git rev-parse --verify HEAD >/dev/null 2>&1
then
	against=HEAD
else
# Initial commit: diff against an empty tree object
	against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi


#
# Функции
#

# Вывод сообщений, если включен подробный режим
function echoVerbose {
	if [ -n "$GIT_HOOKS_VERBOSE" ] && [ "$GIT_HOOKS_VERBOSE" -eq "1" ]; then
		echo -e $@
	fi
}

function echoColorVerbose {
	echoVerbose "$BPurple""$@""$Color_Off"
}

#
# Конфигурация
#

declare -A GIT_HOOKS
# Загружаем умолчания
source "$(dirname $0)/etc/config-defaults.sh"
# Переопределяем настройки
if [ -f "$(dirname $0)/etc/config.sh" ]; then
	source "$(dirname $0)/etc/config.sh"
else
	echoColorVerbose "Настройки проекта не найдены (config.sh). Используются значения по-умолчанию"
fi
