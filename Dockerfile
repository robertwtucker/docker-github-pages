#
# Jekyll container to mirror configuration of GitHub Pages
#
FROM alpine:3.4
MAINTAINER Robert Tucker <robertwtucker@gmail.com>

ENV GITHUB_PAGES_GEM_VERSION 92

# Install all the dependencies for Jekyll
RUN apk --no-cache add bash build-base libffi-dev zlib-dev libxml2-dev libxslt-dev ruby ruby-dev nodejs ruby-rdoc ruby-irb

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install nokogiri separately
RUN gem install --no-document nokogiri -v 1.6.7.2 -- --use-system-libraries

RUN gem install --no-document github-pages:${GITHUB_PAGES_GEM_VERSION}

VOLUME [/usr/src/app]
EXPOSE 4000

CMD ["jekyll", "serve", "--watch", "--force_polling", "--incremental", "-H", "0.0.0.0", "-P", "4000"]
