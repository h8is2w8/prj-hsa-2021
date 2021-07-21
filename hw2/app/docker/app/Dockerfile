FROM ruby:2.7.4

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 4567

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]