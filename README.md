# Описание

При коммите необходимы проверки на Code Style и другие договоренности, например, формат сообщений. Это делается с помощью хуков.

Хуки возможно положить сюда `/usr/share/git-core/templates/hooks`, это "скелет" для `git init`, копируются все файлы, и проверить признак выполнения (`chmod +x *`).

Другой способ - скопировать в каталог `.git/hooks` текущего проекта.

Автоматическая установка в существующий проект, находясь в каталоге, находящемся под управлением git:

для curl:

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh)`

для wget:

`sh -c "$(wget https://raw.githubusercontent.com/dbfun/hooks-workflow/master/tools/install.sh -O -)`

Советы:

* Сделать симлинк из `.git/hooks` в рабочий каталог, тогда и сами хуки будут под управлением версиями.
* Сделать симлинк из `.git/hooks` в отдельный каталог, тогда возможно менять правила сразу для всех проектов.

# Теория: какие хуки возможно использовать и для чего?

## На клиенте

* [+] `commit-msg` - проверять сообщение на наличие номера задачи и краткого пояснения
* [+] `pre-commit` - перед коммитом проверять синтаксис, качество кода
* [-] `prepare-commit-msg` - выполняется при отправке сообщение коммита в редактор, до создания коммита (не подходит)
* [?] `post-commit` - уведомлялка "что нового в репозитории"
* [?] `pre-push` - перед push
* [?] `post-checkout`
* [?] `pre-rebase`

## На сервере

* [?] `pre-receive` - (из stdin список отправленных ссылок)
* [?] `update`
* [+] `post-receive` - для уведомления о накатке изменений (выкладка на прод)

# Настройка хуков

Следующие параметры, переданные через [окружение](https://wiki.archlinux.org/index.php/Environment_variables_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)), влияют на работу хуков:

  * `GIT_CLI` - использовать формат для скриптов (отключены цвета).
  * `GIT_HOOKS_VERBOSE` - подробный режим вывода сообщений.

"Да" - "1", любое другое значение, или не установлено - "нет".

```
# Так устанавливается подробный режим вывода сообщений
export GIT_HOOKS_VERBOSE=1
# Так этот режим снимается
unset GIT_HOOKS_VERBOSE
# Или так
export GIT_HOOKS_VERBOSE=0
```

Чтобы обойти проверку хуками, следует установить флаг "-n":

```
# В данном случае обходится ошибка отсутствия номера задачи в тексте коммита
git commit -nm "обновление задач" -- .
```

Родная конфигурация git для настройки хуков не используется: @see `config.sh`.

# CodeSniffer

Для проверки Code Style используется CodeSniffer, который необходимо минимально настроить: указать путь до phpcs и PHP (если не указаны). Также не стоит забывать, что на машине может быть установлено несколько версий PHP и phpcs, что также настраивается в `config.sh`.

Возможно использовать предустановленные стандарты (`Generic`, `MySource`, `PEAR`, `PSR1`, `PSR2`, `Squiz`, `Zend`), либо написать собственные.
Настройки хранятся в `PEAR_PATH/PHP/CodeSniffer/Standards/`, например `/usr/share/pear/PHP/CodeSniffer/src/Standards/`.

Советы по добавлению стандарта:

* Скопировать стандарт из этого репозитория `sudo cp -R ./codesniffer-standarts/IEK /usr/share/pear/PHP/CodeSniffer/src/Standards/`
* Сделать симлинки из этого репозитория: `sudo ln -s /home/user/git-test/.git/hooks/codesniffer-standarts/IEK /usr/share/pear/PHP/CodeSniffer/src/Standards/`
* Использовать абсолютный путь к XML файлу со стандартом, например `/home/user/git-test/.git/hooks/codesniffer-standards/IEK/ruleset.xml`

# Ссылки для изучения

## Git hooks

* [Перехватчики в Git](https://git-scm.com/book/ru/v1/%D0%9D%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B9%D0%BA%D0%B0-Git-%D0%9F%D0%B5%D1%80%D0%B5%D1%85%D0%B2%D0%B0%D1%82%D1%87%D0%B8%D0%BA%D0%B8-%D0%B2-Git)
* [Забудьте про SVN](https://gist.github.com/aminin/4520418)
* [Git Hooks (en), atlassian.com](https://www.atlassian.com/git/tutorials/git-hooks)
* [Git Hooks (en), githooks.com](http://githooks.com/)
* [Learn how to use Pre-Commit Today (en)](https://github.com/dwyl/learn-pre-commit)
* [Deploying Websites With a Tiny Git Hook (en)](http://ryanflorence.com/deploying-websites-with-a-tiny-git-hook/)
* [Tips for using a git pre-commit hook (en)](http://codeinthehole.com/tips/tips-for-using-a-git-pre-commit-hook/)

## Качество кода

* [PHP Quality Assurance](https://phpqa.io/)
* [Continuous integration для php](https://habrahabr.ru/post/68571/)


# TODO

* Два режима: строгий с подсказками и обычный. Строгий проверяет неудаленные "TODO", "console.log", "var_dump" и прочий хлам.
* Проверка на копипасту: [phpcpd.noarch : Copy/Paste Detector (CPD) for PHP code](https://github.com/sebastianbergmann/phpcpd)
* [PMD](https://pmd.github.io/)?
