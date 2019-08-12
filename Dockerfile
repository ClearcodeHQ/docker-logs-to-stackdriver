# Using Fluent v1.3 because fluent-plugin-google-cloud does not worked with the newest at the time when I was testing it
FROM fluent/fluentd:v1.3-debian-1

USER root

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
&& apt-get update \
&& apt-get install -y --no-install-recommends $buildDeps \
&& sudo gem install \
      fluent-plugin-google-cloud \
&& sudo gem sources --clear-all \
&& SUDO_FORCE_REMOVE=yes \
  apt-get purge -y --auto-remove \
                -o APT::AutoRemove::RecommendsImportant=false \
                $buildDeps \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY ./config/fluent/fluent.conf /fluentd/etc/fluent.conf

USER fluent

