*** Settings ***
Resource    ../../resources/imports.robot
Resource   ../../variables/api_locators.robot
Library    Collections

*** Keywords ***
Get Auth Token
    [Documentation]    Ensure the admin user exists and retrieve the authentication token
    Create Session    serverest    ${BASE_URL}
    ${payload}=    Create Dictionary    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    ${response}=    GET On Session    serverest    url=/usuarios    params=email=${ADMIN_EMAIL}
    ${user_exists}=    Evaluate    len(${response.json()['usuarios']}) > 0
    IF    ${user_exists}
        Log To Console    **INFO: Admin user already exists, ready to proceed with Auth Token generation**
    ELSE
        Create Admin User
    END
    ${response}=    POST On Session    serverest    /login    json=${payload}
    #Log To Console    **INFO: POST Response : ${response.status_code}, ${response.reason}**
    HTTP Response Status Code Should Be 200 OK    ${response}
    ${BEARER_TOKEN}=    Set Variable    ${response.json()['authorization']}
    Log To Console    **INFO: BEARER_TOKEN retrieved: ${BEARER_TOKEN}**
    RETURN    ${BEARER_TOKEN}

Create Admin User
    [Documentation]    Create the admin user if it does not exist
    ${payload}=    Create Dictionary    nome=${ADMIN_NAME}    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}
    ${message}=    Get From Dictionary    ${response.json()}    message
    Run Keyword If    '${message}' == 'Cadastro realizado com sucesso'    Log To Console    **INFO: Admin user created successfully**
    Run Keyword If    '${message}' == 'Este email já está sendo usado'    Log To Console    **INFO: Cannot create, Admin user already exists**

Adds a New Product Payload
    [Documentation]    Create a payload for a new product
    ${payload}=    Create Dictionary    nome=${PRODUCT_NAME}    preco=${PRODUCT_PRICE}    descricao=${PRODUCT_DESCRIPTION}    quantidade=${PRODUCT_QUANTITY}
    RETURN      ${payload}

POST Product
    [Documentation]    Add the product using the payload
    [Arguments]    ${TOKEN_POST}    ${payload}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_POST}
    ${response}=   POST On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}    json=${payload}    headers=${headers}
    Set Suite Variable      ${response}
    HTTP Response Status Code Should Be 201 OK      ${response}
    ${PRODUCT_ID_JSON}=    Get From Dictionary      ${response.json()}    _id
    Set Suite Variable      ${PRODUCT_ID}           ${PRODUCT_ID_JSON}

GET Product by ID
    [Documentation]    Get the product by ID
    [Arguments]    ${TOKEN_GET}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_GET}
    # Makes sure that product exists
    # ${product_exists}=    Evaluate    len(${response.json()['usuarios']}) > 0
    # IF    ${product_exists}
    #     ${response}=    GET On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}/${PRODUCT_ID}    headers=${headers}
    # ELSE
    #     Given a new product payload
    #     ${payload}=     Create Dictionary    nome=${PRODUCT_NAME}    preco=${PRODUCT_PRICE}    descricao=${PRODUCT_DESCRIPTION}    quantidade=${PRODUCT_QUANTITY}
    #     When the product is added
    #     Log To Console      **INFO: Product created with ID ${PRODUCT_ID}**
    # END
    ${response}=    GET On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}/${PRODUCT_ID}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    RETURN    ${response}