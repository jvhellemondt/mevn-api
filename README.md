# Docker-MEVN-GraphQL

## Docker

Make sure docker and docker-compose is installed.

### Docker installation

#### Uninstall old versions

Start clean:

`sudo apt-get remove docker docker-engine docker.io containerd runc`

#### Install docker

```bash
sudo apt-get update
sudo apt-get install docker docker-io
```

### Docker-compose

#### Install docker-compose

```bash
sudo apt-get update
sudo apt install docker-compose
```

#### Start local dev server

`docker-compose up -d`

### Using the app

The app runs at localhost. As it is using Caddy, it is automatically https.

There is an example running by default. This example contains views (Vue) and the link to graphiql. Do note, the backend is served on localhost:4000/api. However, this is served through http. Therefore, you will not be able to do mutations.

## Mongo shell

### Install mongo shell

To connect to the local mongodb, use the mongo shell.

Install via [mongodb.com](https://www.mongodb.com/try/download/community?tck=docs_server). Make sure to set the package to 'shell'.

### Connect

Use `mongo --authenticationDatabase mongodb`


# Development API

Start developing your backend with hot reload by following these steps.

## Start MongoDB

### MongoDB from root directory

`docker-compose down -v && docker-compose -f ./docker-mongodb.yml up -d`

### MongoDB from this directory

`docker-compose down -v && docker-compose -f ../docker-mongodb.yml up -d`

## Start development server

### Development server from root directory

`yarn --cwd ./api/ serve`

### Development server from this directory

`yarn serve`

---

## Utilities

### Generate (64 long) secret key

Never expose your secret key -- nor store it in your version control (Github/ Gitlab etc.). If you did, always generate a new one!

#### Launch node in terminal

`node`

#### Import crypto

`const crypto = require('crypto')`

#### Generate secret

`crypto.randomBytes(256).toString('hex').slice(0, 64)`

## Kubernetes

Launch minikube
`minikube start`
`minikube dashboard --url`


Update dockerhub with dockerfile
```bash
COMMIT=$(git rev-parse --verify HEAD) && docker image build -f "./Dockerfile" . --build-arg "app_name=mern-api" -t "mern-api:latest" -t "mern-api:${COMMIT}" -t "jennesnl/mern-api:latest"

docker image tag mern-api:latest jennesnl/mern-api:latest
docker login
docker push jennesnl/mern-api:latest
```
