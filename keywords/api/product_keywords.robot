*** Settings ***
Resource    ../../resources/imports.robot
Resource   ../../variables/api_locators.robot
Library    Collections

*** Keywords ***
Disable Insecure Request Warnings
    Evaluate    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
    #Usage only in dev mode

Get Auth Token
    [Documentation]    Ensure the admin user exists and retrieve the authentication token
    Disable Insecure Request Warnings
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
    HTTP Response Status Code Should Be 200 OK    ${response}
    ${BEARER_TOKEN}=    Set Variable    ${response.json()['authorization']}
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

Check if Product Exists by Product Name
    [Documentation]    Check if the product exists by name and set the product ID if it does
    [Arguments]    ${TOKEN_GET}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_GET}
    ${params}=    Create Dictionary    nome=${PRODUCT_NAME}
    ${response}=    GET On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}    headers=${headers}    params=${params}
    ${product_exists}=    Evaluate    len(${response.json()['produtos']}) > 0
    IF    ${product_exists}
        Log To Console    **INFO: Product already exists**
        ${existing_product_id}=    Get From Dictionary    ${response.json()['produtos'][0]}    _id
        Set Suite Variable    ${PRODUCT_ID}    ${existing_product_id}
    ELSE
        Log To Console    **INFO: Product does not exist.**
    END
    RETURN    ${product_exists}

Delete Product If Exists By ID    
    [Documentation]    Delete the product if it exists
    [Arguments]     ${product_existance}     ${BEARER_TOKEN}
    IF    ${product_existance}
        DELETE Product by ID    ${BEARER_TOKEN}
    END

GET or Create Product by ID due to Existance
    [Documentation]    Get the product by ID or create it if it does not exist
    [Arguments]     ${product_existance}    ${BEARER_TOKEN}
    IF    not ${product_existance}
        ${product_payload}=     Adds a new product payload 
        ${PRODUCT_ID_JSON}=     POST Product    ${BEARER_TOKEN}    ${product_payload}
    END
    ${response}=            GET Product by ID                   ${BEARER_TOKEN}

DELETE or Create Product by ID due to Existance
    [Documentation]    Get the product by ID or create it if it does not exist
    [Arguments]     ${product_existance}    ${BEARER_TOKEN}
    IF    not ${product_existance}
        ${product_payload}=     Adds a new product payload 
        ${PRODUCT_ID_JSON}=     POST Product    ${BEARER_TOKEN}    ${product_payload}
    END
    DELETE Product by ID    ${BEARER_TOKEN}

POST Product
    [Documentation]    Add the product using the payload
    [Arguments]    ${TOKEN_POST}    ${payload}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_POST}
    ${response}=   POST On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}    json=${payload}    headers=${headers}
    HTTP Response Status Code Should Be 201 OK      ${response}
    ${PRODUCT_ID_JSON}=    Get From Dictionary      ${response.json()}    _id
    Set Suite Variable    ${PRODUCT_ID}           ${PRODUCT_ID_JSON}
    Log To Console          **INFO: Product created with ID ${PRODUCT_ID}**
    RETURN    ${PRODUCT_ID_JSON}

GET Product by ID
    [Documentation]    Get the product by ID
    [Arguments]    ${TOKEN_GET}    ${current_product_id}=${PRODUCT_ID}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_GET}
    ${response}=    GET On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}/${current_product_id}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    Should Be Equal As Strings    ${response.json()['nome']}    ${PRODUCT_NAME}
    Should Be Equal As Numbers    ${response.json()['preco']}    ${PRODUCT_PRICE}
    Log To Console      **INFO: Got the Product ID ${current_product_id}**
    RETURN    ${response}

DELETE Product by ID
    [Documentation]    Get the product by ID
    [Arguments]    ${TOKEN_GET}    ${current_product_id}=${PRODUCT_ID}
    ${headers}=    Create Dictionary    Authorization=${TOKEN_GET}
    ${response}=    DELETE On Session    ${ALIAS_API}    ${PRODUCTS_ROUTE}/${current_product_id}    headers=${headers}
    HTTP Response Status Code Should Be 200 OK    ${response}
    Log To Console      **INFO: Product with ID ${current_product_id} deleted**