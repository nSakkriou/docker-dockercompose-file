@echo off

mkdir %1
mkdir %1\docker
mkdir %1\docker-compose

echo FROM baseImage > %1\docker\Dockerfile
type NUL > %1\docker-compose\compose.yaml
type NUL > %1\docker-compose\.env