# Define container names
APP_CONTAINER=app
NGINX_CONTAINER=nginx
POSTGRES_CONTAINER=postgres
REDIS_CONTAINER=redis
NPM_CONTAINER=npm
ARTISAN_CONTAINER=artisan

# Define dev override file


## 📜 Display all available commands
help:
	@echo ""
	@echo "🔥  Available Makefile Commands 🔥"
	@echo "--------------------------------------------------------------"
	@echo "💻  Start environment:"
	@echo "  make up             - Start the DEV environment"
	@echo "  make build          - Start build Containers"
	@echo ""
	@echo "🛑  Stop and manage containers:"
	@echo "  make stop           - Stop all containers"
	@echo "  make down           - Remove all containers and volumes"
	@echo "  make restart        - Restart all containers"
	@echo "  make restart-container CONTAINER=<name> - Restart a specific container"
	@echo "  make stop-container CONTAINER=<name>    - Stop a specific container"
	@echo ""
	@echo "🎭  Artisan commands:"
	@echo "  make artisan <cmd>  - Run 'php artisan <cmd>' inside the app container"
	@echo ""
	@echo "👀  PHPUnit:"
	@echo "  make test  - Run PHPUnit tests"
	@echo ""
	@echo "🎼  Composer commands:"
	@echo "  make composer <cmd> - Run 'composer <cmd>' inside the app container"
	@echo ""
	@echo "🎸  NPM commands:"
	@echo "  make npm <cmd>      - Run 'npm <cmd>' inside the app container"
	@echo ""
	@echo "🖥  Open container shell:"
	@echo "  make bash           - Open a bash shell inside the app container"
	@echo ""
	@echo "📜  Logs:"
	@echo "  make logs <container> - View logs of a specific container"
	@echo ""
	@echo "🐘  PostgreSQL CLI:"
	@echo "  make psql           - Open psql shell with credentials from .env"
	@echo ""
	@echo "🔥  Redis CLI:"
	@echo "  make redis          - Open redis-cli inside the Redis container"
	@echo ""

## 💻 Start the DEV environment (with override)
up:
	docker-compose up -d

build:
	docker-compose build

## 🛑 Stop all running containers
stop:
	docker-compose stop

## 🗑 Remove all containers and volumes
down:
	docker-compose down -v

## 🔄 Restart all containers
restart:
	docker-compose restart

## 🔄 Restart a specific container (usage: make restart-container CONTAINER=nginx)
restart-container:
	docker-compose restart $(CONTAINER)

## 🛑 Stop a specific container (usage: make stop-container CONTAINER=postgres)
stop-container:
	docker-compose stop $(CONTAINER)

## 🎭 Run PHP inside the app container (usage: make php -v)
php:
	docker-compose exec -u www-data $(APP_CONTAINER) php $(filter-out $@,$(MAKECMDGOALS))

## 🎭 Run an Artisan command (usage: make artisan migrate)
artisan:
	docker-compose exec -u www-data $(APP_CONTAINER) php artisan $(filter-out $@,$(MAKECMDGOALS))

# Single artisan rule that handles both direct and pattern matching
#artisan:
#	docker-compose run --rm $(ARTISAN_CONTAINER) $(if $(cmd),$(cmd),$*)

## 🎼 Run a Composer command (usage: make composer install)
composer:
	docker-compose exec -u www-data $(APP_CONTAINER) composer $(filter-out $@,$(MAKECMDGOALS))

## 🎸 Run an NPM command (usage: make npm run dev)
npm:
	docker-compose exec -u www-data $(NPM_CONTAINER) npm $(filter-out $@,$(MAKECMDGOALS))

npm-dev:
	docker-compose run --rm npm run dev

## 🖥 Open a bash shell inside the app container
bash:
	docker-compose exec -u www-data $(APP_CONTAINER) bash

## 📜 View logs of a specific container (usage: make logs nginx)
logs:
	docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

## 🐘 Open PostgreSQL shell with credentials from .env
psql:
	docker-compose exec -e PGPASSWORD=$(POSTGRES_PASSWORD) $(POSTGRES_CONTAINER) psql -U $(POSTGRES_USER) -d $(POSTGRES_DB)

## 🔥 Open Redis CLI inside the Redis container
redis:
	docker-compose exec $(REDIS_CONTAINER) redis-cli

## 🧪 Run PHPUnit tests
test:
	docker-compose exec -u www-data $(APP_CONTAINER) php artisan test

composer-update:
	docker-compose run --rm composer update

migrate:
	docker-compose run --rm $(ARTISAN_CONTAINER) migrate

migrate-new:
	echo "🗃️ Refreshing migrations and seeding..."
	docker-compose run --rm $(ARTISAN_CONTAINER) migrate:refresh --seed
	echo "✅ Done!"

app-artisan-migrate:
	docker-compose run --rm $(ARTISAN_CONTAINER) migrate

storage-link:
	docker-compose run --rm $(ARTISAN_CONTAINER) storage:link

clear:
	docker-compose run --rm $(ARTISAN_CONTAINER) cache:clear
	docker-compose run --rm $(ARTISAN_CONTAINER) optimize:clear
	docker-compose run --rm $(ARTISAN_CONTAINER) route:clear
	docker-compose run --rm $(ARTISAN_CONTAINER) config:clear
	docker-compose run --rm $(ARTISAN_CONTAINER) view:clear
	docker-compose run --rm $(ARTISAN_CONTAINER) filament:clear-cache

clear-composer:
	docker-compose exec -T $(APP_CONTAINER) composer clear-cache

alias:
	nano ~/.bashrc