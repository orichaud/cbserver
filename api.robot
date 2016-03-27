*** Settings ***
Documentation       API test
Library             HttpLibrary.HTTP
Library             OperatingSystem

*** Variables ***
${SERVER}           localhost:8080
${KEY}              10
${DATA}             {"data":"the data"}
${DATA_UDPATE}      {"data":"the updated data"}
${STATUS_SVC}       http://${SERVER}/status
${ENTRY_SVC}        http://${SERVER}/entry/${KEY}

*** Test Cases ***
Validate /status service
    Create HTTP Context                 ${SERVER}               http
    GET                                 /status
    Response Status Code Should Equal   200

Validate /entry service - create, retrieve, delete, fail to retrieve
    Create entry
    Retrieve entry
    Delete entry
    Fail to retrieve entry

Validate /entry service - create, update, delete, fail to retrieve
    Create entry
    Retrieve entry
    Update entry
    Retrieve entry
    Delete entry
    Fail to retrieve entry

*** Keywords ***
Create entry
    Create HTTP Context                 ${SERVER}               http
    Set Request Header                  Content-Type            application/json
    Set Request Body                    ${DATA}
    POST                                /entry/${KEY}
    Response Body Should Contain        "status":"success"
    Response Body Should Contain        ${DATA}
    Response Status Code Should Equal   200

Retrieve entry
    Create HTTP Context                 ${SERVER}               http
    GET                                 /entry/${KEY}
    Response Body Should Contain        "status":"success"
    Response Status Code Should Equal   200

Fail to retrieve entry
    Create HTTP Context                 ${SERVER}               http
    GET                                 /entry/${KEY}
    Response Body Should Contain        "status":"failed"
    Response Status Code Should Equal   200

Delete entry
    Create HTTP Context                 ${SERVER}               http
    DELETE                              /entry/${KEY}
    Response Body Should Contain        "status":"success"
    Response Status Code Should Equal   200

Update entry
    Create HTTP Context                 ${SERVER}               http
    Set Request Header                  Content-Type            application/json
    Set Request Body                    ${DATA_UDPATE}
    PUT                                 /entry/${KEY}
    Response Body Should Contain        "status":"success"
    Response Body Should Contain        ${DATA_UDPATE}
    Response Status Code Should Equal   200
