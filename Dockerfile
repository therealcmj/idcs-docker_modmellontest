
FROM php:7.0-apache
MAINTAINER Chris Johnson (christopher.johnson@oracle.com)

RUN apt-get -y update
RUN apt-get -y install libapache2-mod-auth-mellon; a2enmod auth_mellon
RUN mkdir /etc/apache2/mellon

COPY metadata/* /etc/apache2/mellon/
COPY mellon.conf /etc/apache2/conf-enabled

COPY html/ /var/www/html/
