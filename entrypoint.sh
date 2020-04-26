#!/bin/sh
set -e

echo "I am the Docker container of the are-you-there-api!"
echo "Running the migrations now:"
rake db:migrate
echo "Done. Running whatever you gave me as a CMD now:"
exec "$@"
