# Symfony-Docker

This is a quick plug-and-play setup for your Symfony projects.

Comes with:
* Symfony application with Supervisor: `php:fpm-alpine`
* Web server: `nginx`
* Database: `bitnami/mariadb:latest`
* Database for testing: `bitnami/mariadb:latest`

## Installation

Create a new symfony project using

```shell script
$ symfony new my_project
```

Navigate to the project directory and add the Symfony-Docker module

```shell script
$ cd path/to/my_project
$ git subtree add --prefix docker https://github.com/mradhi/symfony-docker.git master
```

Create the environment file based on `docker/.env.dist` file

```shell script
$ cp docker/.env.dist docker/.env
```

Replace parameters the way they fits your needs

```shell script
TIME_ZONE=Africa/Tunis

PROJECT_PATH=../.

APP_PORT=18000
WEB_PORT=80 # Web server external access port

DB_NAME=test
DB_USER=user
DB_PASS=password
DB_PORT=13306 # Database external access port - DON'T  use this in your symfony .env.local file
DB_TEST_PORT=13307 # Database testing external access port - DON'T use this in your symfony .env.local file
DB_ALLOW_EMPTY_PASSWORD=no

# Additional env parameters here.
```

Update your Symfony project `.env.local` file to match Docker containers configuration, and don't forget 
to use the container name as a **host** to connect to the container services such as:

```shell script
###> doctrine/doctrine-bundle ###
DATABASE_URL=mysql://DB_USER:DB_PASS@[CONTAINER_NAME]:3306/DB_NAME?serverVersion=5.7
###< doctrine/doctrine-bundle ###
```

It means that if we need to configure our database URL using the environment 
variables used on `docker/.env` file, see below

```shell script
###> doctrine/doctrine-bundle ###
DATABASE_URL=mysql://user:password@database:3306/test?serverVersion=5.7
###< doctrine/doctrine-bundle ###
```

Finally navigate to the `docker/` directory and build and start your containers 
using the following command

```shell script
$ cd docker/
$ docker-compose up -d --build
```

Navigate to  http://localhost or http://symfony.local, and you'll get your amazing new Symfony app running behind Docker.

Don't forget to add this line to your `/etc/hosts` file

```shell script
127.0.0.1       symfony.local
```

ENJOY CODING...
