*** Settings ***
Documentation   Tests the Product EPs of the APIs

Resource        ../../resources/imports.robot

*** Test Cases ***
Post New Product
    [Documentation]    Test adding a new product
    [Tags]  API
    ${BEARER_TOKEN}=        Given Get Auth Token
    ${product_payload}=     When Adds a new product payload 
    ${product_existance}=   And Check if Product Exists by Product Name     ${BEARER_TOKEN}
    And Delete Product If Exists By ID          ${product_existance}    ${BEARER_TOKEN}
    Log To Console    **INFO: Ready to proceed with Product Creation.**
    ${PRODUCT_ID_JSON}=     Then POST Product               ${BEARER_TOKEN}    ${product_payload}

Get Product
    [Documentation]    Test getting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Given Get Auth Token
    ${product_existance}=   When Check if Product Exists by Product Name     ${BEARER_TOKEN}
    Then GET or Create Product by ID due to Existance       ${product_existance}    ${BEARER_TOKEN}

Delete Product
    [Documentation]    Test deleting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=        Given Get Auth Token
    ${product_existance}=   When Check if Product Exists by Product Name     ${BEARER_TOKEN}
    Then DELETE or Create Product by ID due to Existance    ${product_existance}    ${BEARER_TOKEN}