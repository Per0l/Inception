FROM debian:buster

RUN apt-get update && apt-get install -y mariadb-server mariadb-client

EXPOSE 3306

COPY tools/entrypoint.sh .

ENTRYPOINT [ "sh", "./entrypoint.sh" ]