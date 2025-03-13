*** Settings ***
Documentation   Tests the Product EPs of the APIs

Resource        ../../resources/imports.robot

*** Test Cases ***
Add New Product
    [Documentation]    Test adding a new product
    [Tags]  API
    ${BEARER_TOKEN}=        Get Auth Token
    ${product_payload}=     Adds a new product payload
    POST Product            ${BEARER_TOKEN}    ${product_payload}
    Log To Console          **INFO: Product created with ID ${PRODUCT_ID}**

Get Product
    [Documentation]    Test getting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=    Get Auth Token
    ${response}=    GET Product by ID    ${BEARER_TOKEN}
    Should Be Equal As Strings    ${response.json()['nome']}    ${PRODUCT_NAME}
    Should Be Equal As Numbers    ${response.json()['preco']}    ${PRODUCT_PRICE}

Delete Product
    [Documentation]    Test deleting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=    Get Auth Token
    Set Suite Variable    ${TOKEN_DELETE}    ${BEARER_TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_DELETE}
    ${response}=    DELETE On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}/${PRODUCT_ID}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    Log To Console      **INFO: Product with ID ${PRODUCT_ID} deleted**