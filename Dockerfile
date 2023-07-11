FROM wordpress

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

RUN apt update && \ 
  apt upgrade -y && \ 
  apt autoremove -y && \
  apt install -y vim

RUN rm -rf /var/www/html/wp-admin/about.php

COPY about.php /usr/src/wordpress/wp-admin
