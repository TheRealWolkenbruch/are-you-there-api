# are-you-there-api

You can start a console of the proejct with the following command:

```shell
./bin/console
```

## Setup

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
