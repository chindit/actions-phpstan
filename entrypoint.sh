#!/bin/bash
set -e

PHP_FULL_VERSION=$(php -r 'echo phpversion();')

if [ -z "$1" ]; then
  ARGUMENTS="analyse ."
else
  ARGUMENTS="$1"
fi

if [ -z "$(ls)" ]; then
  echo "No code have been found.  Did you checkout with «actions/checkout» ?"
  exit 1
fi

if [ ! -d vendor/ ] || [ ! -f vendor/autoload.php ]; then
  echo "WARNING!!!: No autoload detected.  You may get errors from PHPStan due to missing autoload";
  echo "Consider adding this snippet:
      - name: Install dependencies
        run: composer install --prefer-dist --no-progress --no-suggest"
fi

if [[ ! "$ARGUMENTS" =~ ^analyse* ]]; then
  echo "INFO: no mode have been detected.  Setting mode to «analyse»"
  ARGUMENTS="analyse ${ARGUMENTS}"
fi

/phpstan -V
echo "## Running PHPStan with arguments «${ARGUMENTS}»"
echo "PHP Version : ${PHP_FULL_VERSION}"

php -d memory_limit=-1 /phpstan ${ARGUMENTS}
