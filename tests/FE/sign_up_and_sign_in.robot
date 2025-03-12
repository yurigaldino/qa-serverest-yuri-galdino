*** Settings ***
Documentation   Tests the Login and the Sign Up of the Application

Resource        ../../resources/imports.robot
Test Setup      Initialization     ${LOGIN_URL}    ${HEADLESS}
#Test Setup      Open Browser     ${LOGIN_URL}    chrome
Test Teardown   Close Browser

Default Tags    E2E

*** Test Cases ***
User Successful Login
    [Documentation]    Test user login with valid credentials 
    ...                (From time to time all users are deleted from the database. Here we create if our Test User does not exist)
    [Tags]  E2E  smoke
    Given user goes to sign up page
    When user ensures that user exists      ${USER_NAME}    ${USER_EMAIL}   ${USER_PASSWORD}
    And user goes to sign in page
    And user login                          ${USER_EMAIL}   ${USER_PASSWORD}
    Then Wait Until Element Is Visible      ${home_user_title_h1}    10s

Admin Successful Login
    [Documentation]    Test admin login with valid credentials 
    [Tags]  E2E  smoke
    Given user goes to sign up page
    When user ensures that admin exists     ${ADMIN_NAME}  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    And user goes to sign in page
    And user login                          ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    Then Wait Until Element Is Visible           ${home_admin_subtitle_p}    10s

Login with Invalid Email
    [Documentation]    Test login with an invalid email
    When user login                         user@notsigned.up   123
    Then Wait Until Element Is Visible      ${login_invalid_email_alert_span}    10s

Login with Invalid Password
    [Documentation]    Test login with an invalid password
    When user login                         test@test.com   butPasswordIsWrong
    Then Wait Until Element Is Visible      ${login_invalid_email_or_password_alert_span}    10s

Login Without Email
    [Documentation]    Test login without an email
    When user login                         ${EMPTY}    123
    Then Wait Until Element Is Visible      ${login_without_email_alert_span}    10s

Login Without Password
    [Documentation]    Test login without a password
    When user login                         test@test.com    ${EMPTY}
    Then Wait Until Element Is Visible      ${login_without_password_alert_span}    10s