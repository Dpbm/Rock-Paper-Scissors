# syntax=docker/dockerfile:1
FROM ubuntu:22.04
LABEL org.opencontainers.image.source=https://github.com/Dpbm/Rock-Paper-Scissors
RUN apt update && apt upgrade -y
RUN apt install -y curl\ 
                unzip\
                libxtst6\
                libxrender1\
                libxi6\
                libgconf-2-4\
                libfreetype-dev\
                libfreetype6-dev

RUN curl -L -O https://github.com/Dpbm/Rock-Paper-Scissors/releases/download/v1/linux-amd64.zip
RUN unzip linux-amd64.zip && rm -rf *.zip

CMD ./linux-amd64/rock_paper_scissors
