# syntax=docker/dockerfile:1
FROM node:6.7.0
RUN npm install -g yarn
FROM ruby:3.0.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client ffmpeg

WORKDIR /rambot
COPY Gemfile /rambot/Gemfile
COPY Gemfile.lock /rambot/Gemfile.lock
RUN bundle install
RUN rails webpacker:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# RUN rails db:migrate

EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
