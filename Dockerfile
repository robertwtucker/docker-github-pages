#
# Jekyll container to mirror configuration of GitHub Pages
#
FROM robertwtucker/ruby-dev:2-node5
MAINTAINER Robert Tucker <robertwtucker@gmail.com>

ENV GITHUB_PAGES_GEM_VERSION 44

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile Gemfile
RUN bundle install

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--force_polling", "-H 0.0.0.0", "-P 4000"]
