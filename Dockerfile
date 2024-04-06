FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    git \
    curl \
    bzip2 \
    wget \
    unzip \
    autoconf \
    bison \
    build-essential \
    imagemagick \
    libbz2-dev \
    libcurl4-openssl-dev \
    libevent-dev \
    libffi-dev \
    libgdbm-dev \
    libglib2.0-dev \
    libjpeg-dev \
    liblzma-dev \
    libmagickcore-dev \
    libmagickwand-dev \
    libncurses-dev \
    libpq-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libyaml-dev \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# Install rbenv and ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build \
  && echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bash_profile

ENV PATH /root/.rbenv/shims:/root/.rbenv/bin::$PATH
RUN rbenv install 1.9.3-p551 && rbenv global 1.9.3-p551 && rbenv rehash

# Install bundler
RUN gem install bundler -v 1.17.3  # https://bundler.io/compatibility.html
ENV PATH $PATH:/root/.rbenv/versions/1.9.3-p551/bin

CMD ["/bin/bash"]
