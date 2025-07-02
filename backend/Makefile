.PHONY: all build compile docker-up clean

ifeq ($(OS),Windows_NT)
    MVNW := mvnw.cmd
else
    MVNW := ./mvnw
endif
compile:
	$(MVNW) clean package -DskipTests
build: compile
	docker compose build
up:
	docker compose up
all: build up
up-build: all
