*** Settings ***
Documentation   Tests the Product EPs of the APIs

Resource        ../../resources/imports.robot

*** Test Cases ***
Post New Product
    [Documentation]    Test adding a new product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${product_payload}=     Adds a new product payload 
    ${product_existance}=      Check if Product Exists by Product Name     ${BEARER_TOKEN}
    Delete Product If Exists By ID    ${product_existance}     ${BEARER_TOKEN}
    Log To Console    **INFO: Ready to proceed with Product Creation.**
    ${PRODUCT_ID_JSON}=     POST Product    ${BEARER_TOKEN}    ${product_payload}

Get Product
    [Documentation]    Test getting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${product_existance}=      Check if Product Exists by Product Name     ${BEARER_TOKEN}
    GET or Create Product by ID due to Existance    ${product_existance}    ${BEARER_TOKEN}

Delete Product
    [Documentation]    Test deleting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${product_existance}=      Check if Product Exists by Product Name     ${BEARER_TOKEN}
    DELETE or Create Product by ID due to Existance   ${product_existance}    ${BEARER_TOKEN}