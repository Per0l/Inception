COMPOSE_YML		=	./srcs/docker-compose.yml
DCMD			= docker-compose -f ${COMPOSE_YML}


ALL: up

build:
	${DCMD} build $(c)

create:
	${DCMD} create 

start:
	${DCMD} start

up:
	${DCMD} up


.PHONY: up start create