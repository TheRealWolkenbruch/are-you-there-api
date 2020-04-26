FROM ruby:2.7.1-buster

RUN mkdir /app
WORKDIR /app

ADD Gemfile Gemfile.lock .tool-versions /app/
RUN bundle install
EXPOSE 9292

ADD . /app

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["rackup","--host", "0.0.0.0"]
