FROM ruby:2.3.0

RUN apt-get update -qq && apt-get install -y \ 
  build-essential \
  libpq-dev \
  nodejs

RUN mkdir /ur_secured
WORKDIR /ur_secured
ADD Gemfile /ur_secured/Gemfile
ADD Gemfile.lock /ur_secured/Gemfile.lock
RUN bundle install
ADD . /ur_secured