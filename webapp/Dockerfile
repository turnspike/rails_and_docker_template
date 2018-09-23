# phusion/baseimage is an Ubuntu image optimized for docker
FROM phusion/baseimage:master
CMD ["/sbin/my_init"]

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
RUN rm -rf /var/lib/gems/2.5.0/cache/*

# run as "webapp" user not root
RUN adduser --disabled-password --gecos "" webapp

# create "webapp" folder
RUN mkdir -p /webapp
WORKDIR /webapp

# copy project files into app folder
ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock
RUN chown -R webapp.webapp /webapp

# change to "webapp" user
USER webapp
WORKDIR /webapp

# setup ruby env
RUN echo "gem: --user-install --env-shebang --no-rdoc --no-ri" > /home/webapp/.gemrc
ENV GEM_HOME /home/webapp/.gem/ruby/2.5.0
ENV PATH /home/webapp/.gem/ruby/2.5.0/bin:$PATH
ENV BUNDLE_PATH /home/webapp/.gem/ruby/2.5.0
ENV BUNDLE_BIN /home/webapp/.gem/ruby/2.5.0/bin

# install rails dependencies
RUN gem install bundler
RUN gem install rake
RUN bundle install
ADD . /webapp
