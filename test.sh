#!/bin/sh

echo "1- TEST POST, DELETE"
curl --silent -X POST -d '{"data":"value"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X DELETE http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo

echo "2-  TEST POST, PUT, DELETE"
curl --silent -X POST -d '{"data":"value"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X PUT -d '{"data":"value--2"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X DELETE http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
