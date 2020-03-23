#!/bin/sh
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

# shellcheck disable=SC2039
if [[ ! "$ARGUMENTS" =~ ^analyse* ]]; then
  echo "INFO: no mode have been detected.  Setting mode to «analyse»"
  ARGUMENTS="analyse ${ARGUMENTS}"
fi

echo "## Running PHPStan with arguments «${ARGUMENTS}»"
echo "PHP Version : ${PHP_FULL_VERSION}"

php -d memory_limit=-1 /phpstan "${ARGUMENTS}"
