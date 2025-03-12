*** Settings ***
Resource    ../../../resources/imports.robot
Resource   ../../../variables/api_locators.robot
Library    Collections

*** Keywords ***
Get Auth Token
    [Documentation]    Ensure the admin user exists and retrieve the authentication token
    Create Session    serverest    ${BASE_URL}
    ${payload}=    Create Dictionary    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}
    ${response}=    GET On Session    serverest    url=/usuarios    params=email=${ADMIN_EMAIL}
    ${user_exists}=    Evaluate    len(${response.json()['usuarios']}) > 0
    IF    ${user_exists}
        Log To Console    **INFO: Admin user already exists**
    ELSE
        Create Admin User
    END
    ${response}=    POST On Session    serverest    /login    json=${payload}
    Log To Console    **INFO: POST Response : ${response.status_code}, ${response.reason}**
    HTTP Response Status Code Should Be 200 OK    ${response}
    ${BEARER_TOKEN}=    Set Variable    ${response.json()['authorization']}
    Log To Console    **INFO: BEARER_TOKEN retrieved: ${BEARER_TOKEN}**
    [Return]    ${BEARER_TOKEN}

Create Admin User
    [Documentation]    Create the admin user if it does not exist
    ${payload}=    Create Dictionary    nome=${ADMIN_NAME}    email=${ADMIN_EMAIL}    password=${ADMIN_PASSWORD}    administrador=true
    ${response}=    POST On Session    serverest    /usuarios    json=${payload}
    ${message}=    Get From Dictionary    ${response.json()}    message
    Run Keyword If    '${message}' == 'Cadastro realizado com sucesso'    Log To Console    **INFO: Admin user created successfully**
    Run Keyword If    '${message}' == 'Este email já está sendo usado'    Log To Console    **INFO: Admin user already exists**