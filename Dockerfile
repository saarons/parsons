FROM jruby:1.7.19-jdk
MAINTAINER Sam Aarons <samaarons@gmail.com>

RUN jruby -S gem install jbundler
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD Gemfile /usr/src/app/
ADD Gemfile.lock /usr/src/app/
ADD Jarfile /usr/src/app/
ADD Jarfile.lock /usr/src/app/
RUN jbundle install --path vendor/cache

ADD . /usr/src/app

EXPOSE 8787
CMD ["ruby", "server.rb"]
