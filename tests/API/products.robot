*** Settings ***
Documentation   Tests the Product EPs of the APIs

Resource        ../../resources/imports.robot

*** Test Cases ***
Post New Product
    [Documentation]    Test adding a new product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${product_payload}=     Adds a new product payload 
    ${PRODUCT_ID_JSON}=     POST Product    ${BEARER_TOKEN}    ${product_payload}

Get Product
    [Documentation]    Test getting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${response}=            GET Product by ID                   ${BEARER_TOKEN}

Delete Product
    [Documentation]    Test deleting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    DELETE Product by ID    ${BEARER_TOKEN}    