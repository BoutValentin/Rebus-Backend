ARG RUBY_VERSION=3.0.2

FROM ruby:${RUBY_VERSION}
RUN apt-get update -qq && apt-get install -y postgresql-client
WORKDIR /app
COPY Gemfile ./Gemfile
COPY Gemfile.lock ./Gemfile.lock
RUN bundle install

COPY ./ ./

COPY ./entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
