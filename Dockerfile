FROM ruby:2.6.6-slim-buster

## Install required dependencies / packages
RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends \
  build-essential \
  nodejs

## Install bundler in proper version
RUN gem install bundler -v 2.2.31

WORKDIR /app
ADD . .
RUN bundle config --local deployment true
RUN bundle install --jobs=8 --retry=3 --without development test

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-e", "production"]


