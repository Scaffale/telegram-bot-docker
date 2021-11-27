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
      POSTGRES_USER: user <-- db user
      POSTGRES_PASSWORD: password <-- db password
  web:
    build: .
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - .:/rambot
      - /data:/rambot/data <-- folder containing the converted video files
      - /to_convert:/rambot/to_conver <-- folder containing video and subs to convert and add to the db
    environment:
      SKIP_FILE_CONVERSION: false <-- set true to skip file conversion and subs add at startup
    ports:
      - "3000:3000"
    depends_on:
      - db
```

**ALSO MAKE SURE THAT:**
1. File names are without spaces
2. Subs are with the same name of the video and in `.srt` format
3.

* TODO list
- [ ] telegram bot (come env)
- [ ] cron (a startup)
- [ ] far girare in produzione
- [ ] migliorare il readme
