#!/usr/bin/env sh

if [ -z $APP_KEY ] && [ ! -f './.env' ]; then
  echo "Generating key."
  APP_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
  echo "Generated app key: $APP_KEY"
  echo "APP_KEY=$APP_KEY" > ./.env
  echo "APP_INSTALLED=false" >> ./.env
elif [ ! -f './.env' ]; then
  echo "APP_KEY exists in environment, using that."
  echo "APP_KEY=$APP_KEY" > ./.env
  echo "APP_INSTALLED=false" >> ./.env
fi

if [ -f './.local/.env' ]; then
  export $(cat ./.local/.env | xargs)
fi

sudo chown -R $(whoami):www-data .env storage database
sudo chmod -R 775 .env storage database

/usr/local/bin/php /var/www/html/artisan migrate --force
/usr/local/bin/php /var/www/html/artisan filament:optimize

export SUPERVISORD_CADDY=true

supervisord -n -c /etc/supervisord.conf
