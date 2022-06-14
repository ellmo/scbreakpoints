FROM ruby:2.6.6-slim-buster

ENV RAILS_ENV "production"

## Install required dependencies / packages
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
  build-essential \
  nodejs \
  libsqlite3-dev \
  sqlite3

## Install bundler in proper version
RUN gem install bundler -v 2.2.31

WORKDIR /app
ADD . .
RUN bundle config --local deployment true
RUN bundle install --jobs=8 --retry=3 --without development test
RUN bundle exec rails assets:precompile
RUN bundle exec rake db:prepare

EXPOSE 3000

CMD bundle exec rake db:seed && bundle exec rails server


