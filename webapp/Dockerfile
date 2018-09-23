FROM phusion/baseimage:master
CMD ["/sbin/my_init"]

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
                       libyaml-dev 
                       nodejs \
                       ruby-switch \
                       ruby2.5 \
                       ruby2.5-dev \
                       rubygems \
                       software-properties-common \
                       tzdata \
                       wget 
RUN ruby-switch --set ruby2.5
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /var/lib/gems/2.5.0/cache/*

RUN adduser --disabled-password --gecos "" webapp

RUN mkdir /webapp

WORKDIR /webapp

ADD Gemfile /webapp/Gemfile
ADD Gemfile.lock /webapp/Gemfile.lock

RUN chown -R webapp.webapp /webapp

USER webapp
WORKDIR /webapp

RUN echo "gem: --user-install --env-shebang --no-rdoc --no-ri" > /home/webapp/.gemrc
ENV PATH /home/webapp/.gem/ruby/2.5.0/bin:$PATH
ENV GEM_HOME /home/webapp/.gem/ruby/2.5.0

RUN gem install bundler
RUN gem install rake
RUN bundle install
ADD . /webapp
