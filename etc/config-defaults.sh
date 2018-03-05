#################################################
#																								#
#				Запрещено измененять этот файл					#
#		Для настройки используйте файл config.sh		#
#																								#
#################################################

# Файл конфигурации с значениями по-умолчанию
# Параметры конфигурации следует переопределять в файле config.sh

#################################################
#																								#
#				Отдельные несвязанные настройки					#
#																								#
#################################################

# Проверка формата сообщения перед коммитом по регулярному выражению
# Чтобы отключить проверку, следует закомментировать строчку
GIT_HOOKS[commit.msg.regexp]='[0-9]+:.+'

# Проверка на файлы, которые не должны попасть в коммит
GIT_HOOKS[files.check.tmp]='1'

# Проверка на пробелы
GIT_HOOKS[files.check.whitespace]='1'

# Проверка на BOM-символ
GIT_HOOKS[files.check.bom]='1'

# Проверка на права доступа
GIT_HOOKS[files.permissions.check]='1'
# Минимальные права, которые должны быть у файла
GIT_HOOKS[files.permissions.min]='664'
# Группа, которой должен принадлежать файл
GIT_HOOKS[files.permissions.group]='apache'

# Проверка на большие файлы
# Лимит указывается в Мб
# Для пропуска проверки следует указать пустое значение (GIT_HOOKS[files.size.limit]=)
GIT_HOOKS[files.size.limit]=100

# Путь до PHP CLI - необходимо правильно указать для корректного запуска CodeSniffer
# Для нативной установки '/usr/bin/php' или `which php`
# Для 5.6 remi: /opt/remi/php56/root/usr/bin/php
GIT_HOOKS[php.bin]=`which php`

# Временный каталог, от корня проекта, с разрешенной записью.
# В нем будут создаваться временные подкаталоги, например ./tmp_staging-user
# Его следует закрыть для доступа извне, и от индексации git, добавив правило в .gitignore
GIT_HOOKS[tmp.dir]='tmp'

#################################################
#																								#
#						Настройки CodeSniffer								#
#																								#
#################################################

# Проверка на стандарты кодирования (если не установлена, все остальное - лишнее)
GIT_HOOKS[php.check.codesniffer]='1'

# Путь до PHP CodeSniffer, также необходимо указать GIT_HOOKS[php.bin] для вызова "правильного" PHP
# Обычно '/usr/bin/phpcs' или `which phpcs`
GIT_HOOKS[phpcs.bin]=`which phpcs`

# Используемый формат проверки Code Style
# Возможно использовать предустановленные стандарты: Generic, MySource, PEAR, PSR1, PSR2, Squiz, Zend, либо написать собственные стандарты.
# @see http://pear.php.net/manual/en/package.php.php-codesniffer.annotated-ruleset.php
# Возможно использовать абсолютный путь к XML файлу со стандартом, например
# '/home/user/git-test/.git/hooks/codesniffer-standards/IEK/ruleset.xml'
GIT_HOOKS[phpcs.standard]='PSR2'

# Шаблон проверки PHP-файлов
GIT_HOOKS[phpcs.file.pattern]='\.(php|phtml)$'

# Файлы для пропуска проверки
GIT_HOOKS[phpcs.file.ignore]=''

# Кодировка файлов
GIT_HOOKS[phpcs.file.encoding]=''

# Пропускать предупреждения (Warnings)
GIT_HOOKS[phpcs.warnings.ignore]='0'

# Количество строк с ошибками
GIT_HOOKS[phpcs.errors.lines]='20'
