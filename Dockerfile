FROM heroku/cedar

RUN cd /tmp && git clone https://github.com/heroku/heroku-buildpack-ruby
ENV HOME=/app
WORKDIR /app

ARG BUNDLE_WITHOUT=development:test

ENV CURL_CONNECT_TIMEOUT=0 CURL_TIMEOUT=0 GEM_PATH="$HOME/vendor/bundle/ruby/2.2.0:$GEM_PATH" LANG=${LANG:-en_US.UTF-8} PATH="$HOME/bin:$HOME/vendor/bundle/bin:$HOME/vendor/bundle/ruby/2.2.0/bin:$PATH" RACK_ENV=${RACK_ENV:-production} RAILS_ENV=${RAILS_ENV:-production} RAILS_LOG_TO_STDOUT=${RAILS_LOG_TO_STDOUT:-enabled} RAILS_SERVE_STATIC_FILES=${RAILS_SERVE_STATIC_FILES:-enabled} SECRET_KEY_BASE=${SECRET_KEY_BASE:-d43dd47a1cfc640ca39ab94dd882822ef32d6f0b1c1abe7361832a71512fa5298a006df8346b4f81a89311bd3fcd88be2125570686779719eda3face16296e7f} STACK=cedar-14 

# This is to install sqlite for any ruby apps that need it
# This line can be removed if your app doesn't use sqlite3
RUN apt-get update && apt-get install sqlite3 libsqlite3-dev && apt-get clean

COPY . /app

RUN /tmp/heroku-buildpack-ruby/bin/compile /app /tmp/cache
