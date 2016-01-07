#
# Jekyll container to mirror configuration of GitHub Pages
#

FROM alpine:3.3
MAINTAINER Robert Tucker <robertwtucker@gmail.com>

ENV BUILD_PACKAGES bash curl-dev build-base libffi-dev zlib-dev libxml2-dev libxslt-dev
ENV RUBY_PACKAGES ruby ruby-dev ruby-bundler ruby-io-console nodejs python

# Install packages
RUN apk --no-cache add $BUILD_PACKAGES $RUBY_PACKAGES

# Install/cache Jekyll and friends
WORKDIR /tmp
ADD Gemfile Gemfile
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

# Copy source
RUN mkdir -p /srv/app
WORKDIR /srv/app
COPY . .
COPY script/jekyll-serve.sh /usr/local/bin/jekyll-serve.sh
RUN chmod +x /usr/local/bin/jekyll-serve.sh

# Communication points
VOLUME ["/srv/app"]
EXPOSE 4000

# Set default command
CMD ["/usr/local/bin/jekyll-serve.sh"]
