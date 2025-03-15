*** Settings ***
Resource    ../../../resources/imports.robot

*** Keywords ***
Initialization
    [Arguments]    ${url}    ${headless_status}
    ${options}=         Evaluate     sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Run Keyword If      ${headless_status}    Call Method    ${options}    add_argument    --headless
    Run Keyword If      not ${headless_status}    Call Method    ${options}    add_argument    chrome
    Create Webdriver    driver_name=Chrome    options=${options}
    Go to               ${url} 
    
Open Other Browsers
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}   browser=${browser}
    Maximize Browser Window

User Login
    [Arguments]     ${user_email}    ${user_password}
    Input Text      ${login_email_input}        ${user_email}
    Input Text      ${login_password_input}     ${user_password}
    Click Button    ${login_submit_button}

Admin Login in the Application
    User goes to sign up page
    User ensures that admin exists             ${ADMIN_NAME}  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    User goes to sign in page
    User login                                  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    Wait Until Element Is Visible               ${home_admin_subtitle_p}    10s
    
Generate Random Price
    [Documentation]    Generates a random price
    ${random_price}=    Evaluate    random.randint(1000, 9999)    random
    RETURN    ${random_price}

Generate Random Description
    [Documentation]    Generates a random description
    ${random_description}=    Evaluate    "YuriRandomDescription" + str(random.randint(1000, 9999))    random
    RETURN    ${random_description}

Generate Random Product Name
    [Documentation]    Generates a random name
    ${random_name}=    Evaluate    "YuriRandomProduct" + str(random.randint(1000, 9999))    random
    RETURN    ${random_name}

Generate Random Quantity 
    [Documentation]    Generates a random quantity
    ${random_quantity}=    Evaluate    random.randint(1, 100)    random
    RETURN    ${random_quantity}

Generate Random Email
    [Documentation]    Generates a random email address
    ${random_email}=    Evaluate    "yuriRandomUser" + str(random.randint(1000, 9999)) + "@example.com"    random
    RETURN    ${random_email}

Generate Random User Name   
    [Documentation]    Generates a random name
    ${random_name}=    Evaluate    "YuriRandomUser" + str(random.randint(1000, 9999))    random
    RETURN    ${random_name}   

Generate Random Password
    [Documentation]    Generates a random password
    ${random_password}=    Evaluate    "YuriRandomPassword" + str(random.randint(1000, 9999))    random
    RETURN    ${random_password}

User Goes to Sign Up Page    
    Go To           url=${SIGN_UP_URL}
    Wait Until Element Is Visible               ${sign_up_name_input}

User Goes to Sign In Page
    Go To           url=${LOGIN_URL}
    Wait Until Element Is Visible               ${login_email_input}

User Ensures That Admin Exists
    [Arguments]     ${admin_name}    ${admin_email}    ${admin_password}
    Input Text      ${sign_up_name_input}       ${admin_name}
    Input Text      ${sign_up_email_input}      ${admin_email}
    Input Text      ${sign_up_password_input}   ${admin_password}
    Click Element   ${sign_up_admin_checkbox_input}
    Click Button    ${sign_up_submit_button}
    ${admin_existence}=  Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_already_in_use_alert_span}    3s
    ${admin_creation}=   Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_success_span}    3s
    Run Keyword If  ${admin_existence}   Log To Console    **INFO: Admin email already exists -> Login ready to proceed**
    Run Keyword If  ${admin_creation}    Log To Console    **INFO: ${admin_name} was created with ${admin_email} -> Login ready to proceed**