# Проверка Code Style с помощью PHP_CodeSniffer (phpcs)
# @see https://github.com/s0enke/git-hooks/blob/master/phpcs-pre-commit/pre-commit
# Я поправил этот скрипт, в частности, исправил ошибки обработки пробелом в именах файлов
#
# Установка phpcs для нативного PHP:
# which pear || (wget http://pear.php.net/go-pear.phar && sudo php go-pear.phar)
# sudo su
# pear install PHP_CodeSniffer
#
# Установка phpcs для remi:
# yum --enablerepo=remi,remi-php56 install php-pear-PHP-CodeSniffer.noarch

# Временный каталог для проверки файлов
TMP_STAGING="./${GIT_HOOKS['tmp.dir']}/tmp_staging-$USER"

# create temporary copy of staging area
function make_staging_dir {
	if [ -e $TMP_STAGING ]; then
		rm -rf $TMP_STAGING
	fi
	mkdir -p $TMP_STAGING
}

# delete temporary copy of staging area
function remove_staging_dir {
	rm -rf $TMP_STAGING
}

#
# Run
#

# Проверка корректной установки CodeSniffer
if [ ! -x "${GIT_HOOKS['phpcs.bin']}" ]; then
	echo -e "$Red""Ошибка выполнения PHP CodeSniffer: ${GIT_HOOKS['phpcs.bin']}""$Color_Off"
	retcode=1
	return
fi

# Так как на сервере могут быть установлены различные интерпретаторы PHP, выбираем нужный
PHPCS_BIN="${GIT_HOOKS['php.bin']} ${GIT_HOOKS['phpcs.bin']}"
PHPINFO=$(${GIT_HOOKS['php.bin']} -r 'echo phpversion() . " " . PHP_BINARY;')

# Показываем расширенную информацию о CodeSniffer и PHP
echoColorVerbose "Проверка на Code Style через CodeSniffer: $PHPCS_BIN"
echoColorVerbose $PHPINFO

#
# Различные параметры запуска CodeSniffer
#

if [ "${GIT_HOOKS['phpcs.file.ignore']}" != "" ]; then
	PHPCS_OPT_IGNORE="--ignore=${GIT_HOOKS['phpcs.file.ignore']}"
fi

if [ "${GIT_HOOKS['phpcs.file.encoding']}" != "" ]; then
	PHPCS_OPT_ENCODING="--encoding=${GIT_HOOKS['phpcs.file.encoding']}"
fi

if [ "${GIT_HOOKS['phpcs.warnings.ignore']}" == "1" ]; then
	PHPCS_OPT_IGNORE_WARNINGS="-n"
fi

# retrieve all files in staging area that are added, modified or renamed
# but no deletions etc

# @see https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# фильтруем только "измененные" - Added, Copied, Renamed, Type changed, Modified
FILES_TO_CHECK=$(git diff-index --name-only --cached --diff-filter=ACRTM $against -- | grep -iP "${GIT_HOOKS['phpcs.file.pattern']}")

if [ "$FILES_TO_CHECK" == "" ]; then
	IFS=$SAVEIFS
	return
fi

make_staging_dir

# Copy contents of staged version of files to temporary staging area
# because we only want the staged version that will be commited and not
# the version in the working directory
for FILE in $FILES_TO_CHECK
do
	ID=$(git diff-index --cached $against -- "$FILE" | cut -d " " -f4)

	# create staged version of file in temporary staging area with the same
	# path as the original file so that the phpcs ignore filters can be applied
	mkdir -p "$TMP_STAGING/$(dirname $FILE)"
	git cat-file blob $ID > "$TMP_STAGING/$FILE"
done

IFS=$SAVEIFS

PHPCS_OUTPUT=$($PHPCS_BIN -s $PHPCS_OPT_IGNORE_WARNINGS --standard=${GIT_HOOKS['phpcs.standard']} $PHPCS_OPT_ENCODING $PHPCS_OPT_IGNORE $TMP_STAGING)

if [ $? -ne 0 ]; then
	NLINES=`echo "$PHPCS_OUTPUT" | wc -l`
	echo -e "$Red""Коммит отклонен: не пройден контроль стиля CodeSniffer по стандарту ${GIT_HOOKS['phpcs.standard']} (строки ${GIT_HOOKS['phpcs.errors.lines']} из $NLINES):""$Color_Off"
	echo "$PHPCS_OUTPUT" | head -n${GIT_HOOKS['phpcs.errors.lines']}
	retcode=1
fi

remove_staging_dir
