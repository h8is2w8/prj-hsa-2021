FROM ruby:2.7.4

WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

EXPOSE 9292

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]