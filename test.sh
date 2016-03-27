#!/bin/sh

echo "Status"
curl --silent -X GET http://localhost:8080/status | xargs -0 echo

echo "1- Test POST, DELETE"
curl --silent -X POST -d '{"data":"value"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X DELETE http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo

echo "2-  Test POST, PUT, DELETE"
curl --silent -X POST -d '{"data":"value"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X PUT -d '{"data":"value--2"}' -H "Content-Type: application/json" http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X DELETE http://localhost:8080/entry/10 | xargs -0 echo
curl --silent -X GET http://localhost:8080/entry/10 | xargs -0 echo
