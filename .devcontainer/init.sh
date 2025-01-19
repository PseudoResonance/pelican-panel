#!/usr/bin/env sh

cp -n ./.devcontainer/.env.example ./.local/.env

if [ ! -f '/var/www/html/.local/crontab' ]; then
	ln -s /var/www/html/docker/crontab /var/www/html/.local/crontab
fi
if [ ! -f '/var/www/html/.local/supervisord.conf' ]; then
	ln -s /var/www/html/docker/supervisord.conf /var/www/html/.local/supervisord.conf
fi
if [ ! -f '/var/www/html/.local/Caddyfile' ]; then
	ln -s /var/www/html/docker/Caddyfile /var/www/html/.local/Caddyfile
fi
