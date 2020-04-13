build: #Build or rebuild servises
	docker-compose build

up: #Create, start servises
	docker-compose up

up -d: #Create, start servises on backgrand
	docker-compose up -d

check: #Check containers
	docker-compose ps

stop: #Stop services
	docker-compose stop
 
bash: #Get inside the container
	docker-compose exec app /bin/bash

connect db: #Connect db
	docker-compose exec app psql -h db -p 5432 -U postgres

#Create migration
migrate:
	docker-compose exec app rails db:migrate:reset

migrate_reset: #Reset migration
	docker-compose exec app rails db:migrate:reset

seed: #Input seed
	docker-compose exec app rails db:seed
