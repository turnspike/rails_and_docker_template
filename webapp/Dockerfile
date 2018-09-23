# phusion/baseimage is an Ubuntu image optimized for docker
FROM phusion/baseimage:master
CMD ["/sbin/my_init"]

# set ruby version
ENV RUBY_VERSION 2.5.0

# install base system packages
RUN add-apt-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y \
                       autoconf \
                       build-essential \
                       curl zlib1g-dev \
                       git-core \
                       libcurl4-openssl-dev \
                       libffi-dev \
                       libpq-dev \
                       libreadline-dev \
                       libssl-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       libyaml-dev \
                       nodejs \
                       #ruby-switch \ # obsolete
                       ruby2.5 \
                       ruby2.5-dev \
                       rubygems \
                       software-properties-common \
                       tzdata \
                       wget 
#RUN ruby-switch --set ruby2.5 # obsolete

# remove cache and temp files to slim down image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -rf /var/lib/gems/$RUBY_VERSION/cache/*

# run as "webapp" user not root
RUN adduser --disabled-password --gecos "" webapp

# create "webapp" folder
ENV APP_HOME /opt/webapp
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# copy project files into app folder
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
RUN chown -R webapp.webapp $APP_HOME

# change to "webapp" user
USER webapp
WORKDIR $APP_HOME

# setup ruby env
RUN echo "gem: --user-install --env-shebang --no-rdoc --no-ri" > $APP_HOME/.gemrc
#ENV GEM_HOME $APP_HOME/.gem/ruby/$RUBY_VERSION
ENV GEM_HOME $APP_HOME/vendor/bundle
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_BIN $BUNDLE_PATH/bin

# install rails dependencies
RUN gem install bundler
RUN gem install rake
RUN bundle install
ADD . $APP_HOME
