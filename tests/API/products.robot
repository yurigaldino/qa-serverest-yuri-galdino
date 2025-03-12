*** Settings ***
Documentation   Tests the Product API
Library         RequestsLibrary
Library         Collections
Resource        ../../resources/imports.robot

*** Variables ***
${LOGIN_URL}            ${BASE_URl}/login
${USERS_URL}            ${BASE_URL}/usuarios
${PRODUCTS_URL}         ${BASE_URL}/produtos
${EMAIL}                yuri@admin.com
${PASSWORD}             321
${ADMIN_NAME}           Yuri Test Admin
${TOKEN}                None
${PRODUCT_NAME}         Óculos Mormaii
${PRODUCT_PRICE}        199
${PRODUCT_DESCRIPTION}  Óculos de sol Mormaii cor preta
${PRODUCT_QUANTITY}     3
${PRODUCT_ID}           None

*** Keywords ***
Given a new product payload
    [Documentation]    Create a payload for a new product
    ${payload}=    Create Dictionary    nome=${PRODUCT_NAME}    preco=${PRODUCT_PRICE}    descricao=${PRODUCT_DESCRIPTION}    quantidade=${PRODUCT_QUANTITY}
    Set Suite Variable    ${payload}

When the product is added
    [Documentation]    Add the product using the payload
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${response}=    POST On Session    serverest    /produtos    json=${payload}    headers=${headers}
    Set Suite Variable    ${response}
    HTTP Response Status Code Should Be 201 OK    ${response}
    ${PRODUCT_ID_JSON}=    Get From Dictionary    ${response.json()}    _id
    Set Suite Variable    ${PRODUCT_ID}    ${PRODUCT_ID_JSON}

*** Test Cases ***
Add New Product
    [Documentation]    Test adding a new product
    [Tags]  API
    Given a new product payload
    ${BEARER_TOKEN}=    Get Auth Token
    Set Suite Variable    ${TOKEN}    ${BEARER_TOKEN}
    ${payload}=    Create Dictionary    nome=${PRODUCT_NAME}    preco=${PRODUCT_PRICE}    descricao=${PRODUCT_DESCRIPTION}    quantidade=${PRODUCT_QUANTITY}
    When the product is added
    Log To Console    **INFO: Product created with ID ${PRODUCT_ID}**

Get Product
    [Documentation]    Test getting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=    Get Auth Token
    Set Suite Variable    ${TOKEN}    ${BEARER_TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${response}=    GET On Session    serverest    /produtos/${PRODUCT_ID}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    Should Be Equal As Strings    ${response.json()['nome']}    ${PRODUCT_NAME}
    Should Be Equal As Numbers    ${response.json()['preco']}    ${PRODUCT_PRICE}

Delete Product
    [Documentation]    Test deleting the specific product
    [Tags]  API
    ${BEARER_TOKEN}=    Get Auth Token
    Set Suite Variable    ${TOKEN}    ${BEARER_TOKEN}
    ${headers}=    Create Dictionary    Authorization=${TOKEN}
    ${response}=    DELETE On Session    serverest    /produtos/${PRODUCT_ID}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    Log To Console    **INFO: Product with ID ${PRODUCT_ID} deleted**