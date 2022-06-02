FROM ruby:2.6.6-slim-buster

ENV RAILS_ENV "production"
ENV MONGO_HOST "localhost"
ENV MONGO_PASSWORD "password"
ENV MONGO_USERNAME "username"

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
RUN bundle exec rails assets:precompile

EXPOSE 3000

CMD bundle exec rake db:seed && bundle exec rails server
# CMD bundle exec rake db:seed -e $RAILS_ENV
# CMD bundle exec rails server -e $RAILS_ENV


