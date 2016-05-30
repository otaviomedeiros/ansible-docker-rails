# Bootstrap a dockerized rails app

Script to quickly bootstrap a new dockerized rails app.

The ansible playbook provisions a vagrant box with a dockerized rails app with nginx, puma, redis, postgres and sidekiq.

## Requirements
[Vagrant](https://www.vagrantup.com/downloads.html)

[Ansible](http://docs.ansible.com/ansible/intro_installation.html)

## Getting started

Clone the repo

`git clone https://github.com/otaviomedeiros/ansible-docker-rails.git`

`cd ansible-docker-rails`

Run vagrant box

`vagrant up`

This command will provision the vm and bootstrap a new dockerized rails app.

Now ssh into the machine

`vagrant ssh`

Cd into the app folder

`cd /vagrant/railsapp `

Run the app

`docker-compose up`

To create the database

`docker-compose run app rake db:create`


The `docker-compose.yml` is described bellow


```
nginx:
  build: ./docker-images/nginx
  container_name: nginx
  volumes:
    - /var/log/nginx:/var/log/nginx
  volumes_from:
    - app
  ports:
    - '8080:8080'

postgres:
  image: postgres:9.5.3
  container_name: postgres
  ports:
    - '5432:5432'
  volumes:
    - ~/.docker-volumes/rails-app/postgresql/data:/var/lib/postgresql/data

redis:
  image: redis:3.2.0
  container_name: redis
  ports:
    - '6379:6379'
  volumes:
    - ~/.docker-volumes/rails-app/redis/data:/var/lib/redis/data

sidekiq:
  build: .
  container_name: sidekiq
  volumes:
    - .:/app
  links:
    - redis
    - postgres
  env_file:
    - .rails-app.env
  command: bundle exec sidekiq -C config/sidekiq.yml

app:
  build: .
  container_name: app
  volumes:
    - .:/app
    - /var/run/app-socket:/var/run/app-socket
  links:
    - redis
    - postgres
    - sidekiq
  env_file:
    - .rails-app.env
  command: bundle exec puma -C config/puma.rb
```
