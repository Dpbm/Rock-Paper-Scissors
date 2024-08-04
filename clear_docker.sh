#!/bin/sh
yes | docker container prune && yes | docker image prune -a
