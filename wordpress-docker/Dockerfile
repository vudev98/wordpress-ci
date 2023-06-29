FROM wordpress 

RUN apt update && \
    apt upgrade -y && \
    apt autoremove && \
    apt install -y \
    vim 

RUN rm -rf /var/www/html/wp-admin/about.php

COPY about.php /var/www/html/wp-admin/about.php
COPY about1.php /var/www/html/wp-admin/

RUN ls -l /var/www/html/wp-admin/

RUN cat /var/www/html/wp-admin/about1.php

RUN cat /var/www/html/wp-admin/about.php
