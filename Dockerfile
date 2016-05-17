FROM ruby:2.2.0

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# Create application home.
RUN mkdir /ol

# Set our working directory inside the image
WORKDIR /ol

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
ADD Gemfile /ol/Gemfile
ADD Gemfile.lock /ol/Gemfile.lock

# Finish establishing our Ruby enviornment
RUN bundle install

# Copy the Rails application into place
ADD . /ol
