#!/bin/bash -x


set -e

TIMESTAMP=`date +%s`
HEADER_FILE=/tmp/header-${TIMESTAMP}.log


try_failed_auth () {
  curl \
    -H 'Content-Type: application/json' \
    -H "Authorization: foobar" \
    localhost:9292/api/wards

}

try_out_login () {
  curl \
    -H 'Content-Type: application/json' \
    --data '{"login": "john@doe.com", "password": "JohnDoe1"}' \
    --dump-header "$HEADER_FILE" \
    localhost:9292/login

  JWT_TOKEN=$(grep '^Authorization' "$HEADER_FILE" | cut -d: -f2 | tr -d '[:space:]')

  curl \
    -H 'Content-Type: application/json' \
    -H "Authorization: ${JWT_TOKEN}" \
    localhost:9292/api/wards
}

main () {
  echo '#################'
  echo 'Try without login'
  echo '#################'
  echo ''
  try_failed_auth
  echo ''

  echo ''
  echo '#################'
  echo 'Try without login'
  echo '#################'
  echo ''
  try_out_login
}

main
