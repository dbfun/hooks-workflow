# Файл конфигурации
# Значения могут принимать значения: "1" - да, "0" - нет, либо "строковое" значение
# Если параметр не определен, используется значение по-умолчанию
# Отказался от использования родного конфига git (`git config --add workflow.checktmp 1`), так как:
#   1. невозможно сделать одинаковые настройки для всех пользователей в пределах проекта, в разных репозиториях
#   2. `git -c workflow.checktmp=1 config --list` НЕ работает в git-commit,
# 		 так как используется там для других целей, @see man git-commit
#		3. Все собрано в одном переносимом файле


#################################################
#																								#
#				Отдельные несвязанные настройки					#
#																								#
#################################################

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

# Путь до PHP CLI - необходимо правильно указать для корректного запуска CodeSniffer
# Default value: `which php`
# Для 5.6 remi: /opt/remi/php56/root/usr/bin/php
# GIT_HOOKS[php.bin]='/usr/bin/php'

# Временный каталог, от корня проекта, с разрешенной записью.
# В нем будут создаваться временные подкаталоги, например ./tmp_staging-user
# Его следует закрыть для доступа извне, и от индексации git, добавив правило в .gitignore
# Default value: `tmp`
# GIT_HOOKS[tmp.dir]='tmp'

#################################################
#																								#
#						Настройки CodeSniffer								#
#																								#
#################################################

# Проверка на стандарты кодирования (если не установлена, все остальное - лишнее)
# Default value: "1"
# GIT_HOOKS[php.check.codesniffer]='1'

# Путь до PHP CodeSniffer, также необходимо указать GIT_HOOKS[php.bin] для вызова "правильного" PHP
# Default value: `which phpcs`
# GIT_HOOKS[phpcs.bin]='/usr/bin/phpcs'

# Используемый формат проверки Code Style
# Возможно использовать предустановленные стандарты: Generic, MySource, PEAR, PSR1, PSR2, Squiz, Zend, либо написать собственные стандарты.
# @see http://pear.php.net/manual/en/package.php.php-codesniffer.annotated-ruleset.php
# Возможно использовать абсолютный путь к XML файлу со стандартом, например
# '/home/user/git-test/.git/hooks/codesniffer-standards/IEK/rulest.xml'
# Default value: 'PSR2'
GIT_HOOKS[phpcs.standard]='IEK'


# Шаблон проверки PHP-файлов
# Default value: '\.(php|phtml)$'
# GIT_HOOKS[phpcs.file.pattern]='\.(php|phtml)$'

# Файлы для пропуска проверки
# Default value: ''
# GIT_HOOKS[phpcs.file.ignore]=''

# Кодировка файлов
# Default value: ''
# GIT_HOOKS[phpcs.file.encoding]=''

# Пропускать ошибки
# Default value: '0'
# GIT_HOOKS[phpcs.warnings.ignore]='0'
