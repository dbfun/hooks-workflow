# Файл конфигурации
# Значения могут принимать значения: "1" - да, "0" - нет, либо "строковое" значение
# Если параметр не определен, используется значение по-умолчанию
# Отказался от использования родного конфига git (`git config --add workflow.checktmp 1`), так как:
#   1. невозможно сделать одинаковые настройки для всех пользователей в пределах проекта
#   2. `git -c workflow.checktmp=1 config --list` НЕ работает в git-commit,
# 		 так как используется там для других целей, @see man git-commit

# Проверка формата сообщения перед коммитом по регулярному выражению
# Чтобы отключить проверку, следует закомментировать строчку
# Default value: "[0-9]+:.+"
GIT_HOOKS[commit.msg.regexp]='[0-9]+:.+'

# Проверка на файлы, которые не должны попасть в коммит
# Default value: "1"
# GIT_HOOKS[files.check.tmp]='1'

# Проверка на пробелы
# Default value: "1"
# GIT_HOOKS[files.check.whitespace]='1'

# Проверка на BOM-символ
# Default value: "1"
# GIT_HOOKS[files.check.bom]='1'

# Проверка на стандарты кодирования
# Default value: "1"
# GIT_HOOKS[php.check.codestyle]='1'

# Путь до PHP CLI - необходимо правильно указать для корректного запуска CodeSniffer
# Default value: `which php`
# Для 5.6 remi: /opt/remi/php56/root/usr/bin/php
# GIT_HOOKS[php.bin]='/usr/bin/php'

# Путь до PHP CodeSniffe, также необходимо указать GIT_HOOKS[php.bin] для вызова "правильного" PHP
# Default value: `which phpcs`
# GIT_HOOKS[phpcs.bin]='/usr/bin/phpcs'
