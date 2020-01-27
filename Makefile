PROJECT_DIR ?= $(realpath ./)
C_COMPOSE := cd $(PROJECT_DIR)/docker && sudo docker-compose

up:
	$(C_COMPOSE) up -d
up-debug:
	$(C_COMPOSE) up
build:
	$(C_COMPOSE) build
stop:
	$(C_COMPOSE) stop
restart:
	$(C_COMPOSE) restart
down:
	$(C_COMPOSE) down
destroy:
	$(C_COMPOSE) down --rmi all --volumes
app:
	$(C_COMPOSE) exec application bash -l
symfony:
	$(C_COMPOSE) exec application php bin/console
database:
	$(C_COMPOSE) exec database bash
database-test:
	$(C_COMPOSE) exec database-test bash
mysql:
	$(C_COMPOSE) exec database bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
mysql-test:
	$(C_COMPOSE) exec database-test bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
