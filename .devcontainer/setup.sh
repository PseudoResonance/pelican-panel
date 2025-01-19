#!/usr/bin/env sh

composer install --no-interaction --optimize-autoloader

yarn config set network-timeout 300000 \
    && yarn install --frozen-lockfile
