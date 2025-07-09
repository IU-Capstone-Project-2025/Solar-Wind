.PHONY: all build compile docker-up clean

ifeq ($(OS),Windows_NT)
    MVNW := mvnw.cmd
else
    MVNW := ./mvnw
endif
compile:
	$(MVNW) clean package -DskipTests
build: compile
	docker compose --env-file .env.example -f docker-compose.local.yml build
up:
	docker compose --env-file .env.example -f docker-compose.local.yml up -d
all: build up
up-build: all
