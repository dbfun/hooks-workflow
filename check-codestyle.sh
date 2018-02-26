# Проверка Code Style с помощью PHP_CodeSniffer (phpcs)
#
# Установка phpcs для нативного PHP:
# which pear || (wget http://pear.php.net/go-pear.phar && sudo php go-pear.phar)
# pear install PHP_CodeSniffer
#
# Установка phpcs для remi:
# yum --enablerepo=remi,remi-php56 install php-pear-PHP-CodeSniffer.noarch

echoColorVerbose "Проверка на Code Style"
echoColorVerbose "php: ${GIT_HOOKS['php.bin']}"
