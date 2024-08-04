#!/bin/sh
cp -r ./assets ./linux-amd64
cp -r ./assets ./windows-amd64

zip -o linux-amd64.zip -r ./linux-amd64/
zip -o windows-amd64.zip -r ./windows-amd64/

