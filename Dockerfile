#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx
  
  
#route53 updator 
#RUN apt-get update -qq
RUN apt-get install -y python-boto python-requests

ADD bin/route53-presence /bin/route53-presence

ENTRYPOINT ["/bin/route53-presence"]
#CMD ["-h"]

#route53 updator 

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx" , "-h"]

# Expose ports.
EXPOSE 80
EXPOSE 443
