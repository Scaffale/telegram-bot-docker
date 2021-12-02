# telegram-bot on docker

The docker-compose file manages almost everything:

`docker-compose up -d`


Before launching it make sure you setted some variables:

```yml
db:
    image: postgres
    volumes:
      - ./tmp/db:/var/lib/postgresql/data <-- the place where the db is saved
    environment:
      POSTGRES_USER: user # <-- db user
      POSTGRES_PASSWORD: password # <-- db password
  web:
    build: .
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/rambot
      - /data:/rambot/data # <-- folder containing the converted video files
      - /to_convert:/rambot/to_conver # <-- folder containing video and subs to convert and add to the db
      - /gifs:/rambot/public/gifs # <-- folder with the created gifs
    environment:
      SKIP_FILE_CONVERSION: false # <-- set true to skip file conversion and subs add at startup
      SERVER_URL: 'your.server/url' # <-- server url for the webhook
      TELEGRAM_WEBHOOK_LINK: false # <-- runs rails telegram:bot:webhook (needs credentials!)
    ports:
      - "3000:3000"
    depends_on:
      - db
```
## At first start

### BUILD

`docker-compose build`

### SET TELEGRAM BOT CREDENTIALS:
1. Edit the secretes adding the telegram bot token (inside docker):
`rails credentials:edit`
```yml
telegram:
  bot:
    token: XXXX
    username: XXXX
    server: https:XXXX
```

### Also make sure that
1. File names are without spaces
1. Subs are with the same name of the video and in `.srt` format

* TODO list
- [ ] telegram bot (come env) (se fattibile)
- [ ] far girare in produzione
- [ ] migliorare il readme
