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
or for a specific version
``` shell
rake db:rollback[0]
rake 'db:rollback[0]' # for zsh, because i can't parse the rake task correctly
```

If you want as a starting playground have some example data laying arround execute

```bash
rake data:fixtures
```
