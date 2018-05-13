FROM ruby:2.3.7-slim-stretch

RUN apt-get update && apt-get install -qq -y --fix-missing --no-install-recommends build-essential \
nodejs libpq-dev postgresql-client-9.6 chrpath git-core libssl-dev \
libfontconfig1-dev wget imagemagick git mysql-client default-libmysqlclient-dev

RUN gem update bundler

WORKDIR /usr/local/share
ARG PHANTOMJS_VERISON
ENV PHANTOMJS_VERISON=$PHANTOMJS_VERISON
COPY deps/phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2 .
RUN tar xjf phantomjs-$PHANTOMJS_VERISON-linux-x86_64.tar.bz2 \
&& ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs \
&& ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs \
&& ln -s /usr/local/share/phantomjs-$PHANTOMJS_VERISON-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

ENV RAILS_ENV=production
RUN mkdir /peatio
WORKDIR /peatio

COPY ./app/peatio/Gemfile Gemfile
COPY ./app/peatio/Gemfile.lock Gemfile.lock
RUN bundle install

COPY ./app/peatio .
RUN bundle exec rake SECRET_TOKEN=pickasecuretoken assets:precompile
COPY init.sh ./
CMD ./init.sh
