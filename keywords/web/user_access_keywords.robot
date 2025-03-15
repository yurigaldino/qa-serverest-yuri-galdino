*** Settings ***
Resource    ../../resources/imports.robot
Resource   ../../variables/web_locators.robot

*** Keywords ***
User Login
    [Arguments]     ${user_email}    ${user_password}
    Input Text      ${login_email_input}        ${user_email}
    Input Text      ${login_password_input}     ${user_password}
    Click Button    ${login_submit_button}

User Goes to Sign Up Page    
    Go To           url=${SIGN_UP_URL}
    Wait Until Element Is Visible               ${sign_up_name_input}

User Goes to Admin Add User Page    
    Go To           url=${ADMIN_ADD_USER_URL}
    Wait Until Element Is Visible               ${admin_user_add_title_h1}  

User Goes to Sign In Page
    Go To           url=${LOGIN_URL}
    Wait Until Element Is Visible               ${login_email_input}

User Ensures That User Exists
    [Arguments]     ${user_name}    ${user_email}    ${user_password}
    Input Text      ${sign_up_name_input}       ${user_name}
    Input Text      ${sign_up_email_input}      ${user_email}
    Input Text      ${sign_up_password_input}   ${user_password}    
    Click Button    ${sign_up_submit_button}
    ${user_existence}=  Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_already_in_use_alert_span}    3s
    ${user_creation}=   Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_success_span}    3s
    Run Keyword If  ${user_existence}   Log To Console    **INFO: Email already exists -> Login ready to proceed**
    Run Keyword If  ${user_creation}    Log To Console    **INFO: ${user_name} was created with ${user_email} -> Login ready to proceed**

Admin Ensures That User Exists
    [Arguments]     ${user_name}    ${user_email}    ${user_password}
    Input Text      ${sign_up_name_input}       ${user_name}
    Input Text      ${sign_up_email_input}      ${user_email}
    Input Text      ${sign_up_password_input}   ${user_password}    
    Click Button    ${admin_sign_up_submit_button}
    ${user_existence}=  Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_already_in_use_alert_span}    3s
    ${user_creation}=   Run Keyword And Return Status    Wait Until Element Is Visible   ${sign_up_email_success_span}    3s
    Run Keyword If  ${user_existence}   Log To Console    **INFO: Email already exists -> Login ready to proceed**
    Run Keyword If  ${user_creation}    Log To Console    **INFO: ${user_name} was created with ${user_email} -> Login ready to proceed**

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