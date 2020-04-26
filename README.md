# are-you-there-api

You can start a console of the proejct with the following command:

```shell
./bin/console
```

## Web Application Container setup

```shell
docker build -t ayt .
docker run -p 9292:9292 ayt:latest
curl 127.0.0.1:9292/hello
```


## Database Setup

We are using SQLite as our database. The following rake task are there to
migrate the database:

Migrate to the latest step of the database
```shell
rake db:migrate
```

Rollback the whole datasbase to verion 0
```shell
rake db:rollback
```
or for a specific version
``` shell
rake db:rollback[0]
rake 'db:rollback[0]' # for zsh, because i can't parse the rake task correctly
```

If you want as a starting playground have some example data laying arround execute

```bash
rake data:fixtures
```
## Test launcher

To launch tests, simply use test environment, create database, insert data and launch tests

```shell
export RACK_ENV=test
rake db:migrate
rake data:fixtures
rake tests:api
```

## List APIs

API routes should be annotated this way

```shell
# route[List_wards]: /api/wards
```

Then, a json is generated with

```shell
rake assets:precompile
```
