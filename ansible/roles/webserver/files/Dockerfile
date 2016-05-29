FROM nginx:1.9
MAINTAINER Dockerized Rails App

COPY rails-app.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
