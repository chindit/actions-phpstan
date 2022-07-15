FROM php:8.1-cli

LABEL version="1.0"
LABEL repository="https://github.com/chindit/actions-phpstan"
LABEL homepage="https://github.com/chindit/actions-phpstan"
LABEL maintainer="David Lumaye <littletiger58@gmail.com>"

RUN curl -L https://github.com/phpstan/phpstan/releases/latest/download/phpstan.phar -o /phpstan

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh && chmod a+x /phpstan
ENTRYPOINT ["/entrypoint.sh"]
