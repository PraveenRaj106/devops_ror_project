FROM ruby:2.6.7

RUN sed -i 's/deb.debian.org/archive.debian.org/g' /etc/apt/sources.list \
 && sed -i '/security.debian.org/d' /etc/apt/sources.list \
 && apt-get update -y \
 && apt-get install -y build-essential libpq-dev nodejs \
 && rm -rf /var/lib/apt/lists/*

RUN gem install bundler:2.2.21

WORKDIR /app

COPY . /app/

RUN bundle install

RUN bundle exec rake assets:precompile

COPY /docker/app/entrypoint.sh /usr/bin/entrypoint.sh

RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

# CMD ["rails", "s", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]