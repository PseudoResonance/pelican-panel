FROM php:8.3-fpm-alpine

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions bcmath gd intl zip opcache pcntl posix pdo_mysql pdo_pgsql

RUN apk add --update postgresql-client caddy git sudo ca-certificates supervisor supercronic htop gnupg yarn

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ARG REMOTE_USER
ARG REMOTE_UID
ARG REMOTE_GID
RUN <<EOF
    addgroup --gid ${REMOTE_GID} ${REMOTE_USER}
    adduser --disabled-password -u ${REMOTE_UID} --ingroup ${REMOTE_USER} ${REMOTE_USER}
    adduser ${REMOTE_USER} wheel
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
EOF

ENV HOME /home/${REMOTE_USER}

# Set permissions for Laravel/Caddy/Supervisord directories
RUN mkdir -p /var/run/supervisord /etc/supercronic \
    && chmod -R 755 /var/run/supervisord \
    && chown -R ${REMOTE_USER}:${REMOTE_USER} /var/run/supervisord

# Remove default supervisord.conf/Caddyfile
RUN rm /etc/supervisord.conf /etc/caddy/Caddyfile \
    # Link defaults
    && ln -s /var/www/html/.local/crontab /etc/supercronic/crontab \
    && ln -s /var/www/html/.local/supervisord.conf /etc/supervisord.conf \
    && ln -s /var/www/html/.local/Caddyfile /etc/caddy/Caddyfile

USER ${REMOTE_USER}
