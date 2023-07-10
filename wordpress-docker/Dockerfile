FROM wordpress

RUN apt update && \ 
    apt upgrade -y && \ 
    apt autoremove -y && \
    apt install -y vim

RUN rm -rf /var/www/html/wp-admin/about.php

COPY about.php /usr/src/wordpress/wp-admin
