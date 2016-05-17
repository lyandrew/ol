OL is a REST API that will serve business data in JSON format. It uses [kaminari](https://github.com/amatsuda/kaminari) for pagination and rails for the api services.

### Endpoints
- GET /businesses
- GET /businesses/:id

### Getting Started using Dockers

**Tested using ruby 2.2.3, Docker 1.11.1, docker-compose 1.7.0, Postgres 9.5*
 
1) Ensure docker is installed: https://docs.docker.com/engine/installation/linux/ubuntulinux/
```sh
$ docker -v
Docker version 1.11.1, build 5604cbe
$ docker-compose -v
docker-compose version 1.7.0, build 0d7bf73
```
2) Download git repository:
```sh
https://github.com/lyandrew/ol.git
```
3) Run build
```sh
bin/docker-compose build
```
4) Start docker container
```sh
bin/docker-compose up
```
5) In another terminal, migrate database
```sh
docker-compose run ol rake db:setup db:migrate db:seed
```


### Getting Started on localhost

**tested using ruby 2.2.3*
 
1) Install dependencies
```sh
bundle install
```
2) Change config/database.yml to match user postgres's credential.
3) Set up database
```sh
bin/rake db:setup
bin/rake db:migrate
bin/rake db:seed
```
4) Start server
```sh
bin/rails server
```

### Testing the API

Once the server is up and running: to list businesses, use the path `/businesses`. 

By default, there will be 50 businesses in 1 page. To change the page number, simply append `?page=#` to the url.

For example:
```
localhost:3000/businesses?page=20
```

To change the businesses per page, append `?per=#` to the url.

For example:
```
localhost:3000/businesses?per=20
```

To change both the page and number per page, append `?page=#&per=#`

For example:
```
localhost:3000/businesses?per=50&per=10
```

To retreive a business use the path `/business/:id`

For example:
```
localhost:3000/businesses/29
```

### Running unit tests
If running locally:
```sh
bin/rake test -v
```

If using dockers:
```sh
docker-compose run ol rake test -v
```
