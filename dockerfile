FROM wordpress:latest

WORKDIR /var/www/html

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    less \
&& rm -rf /var/lib/apt/lists/*
	
# Download WP CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY plugins /tmp
COPY fast-rest-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/fast-rest-entrypoint.sh


ENTRYPOINT ["fast-rest-entrypoint.sh"]
CMD ["apache2-foreground"]