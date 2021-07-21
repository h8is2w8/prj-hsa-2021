FROM nginx:latest
RUN apt-get update -qq && apt-get -y install apache2-utils

RUN rm /etc/nginx/conf.d/default.conf
COPY docker/web/app.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]