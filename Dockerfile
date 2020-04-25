FROM ruby:2.7.1-buster

RUN mkdir /app
WORKDIR /app

ADD Gemfile Gemfile.lock .tool-versions /app/
RUN bundle install

ADD . /app
