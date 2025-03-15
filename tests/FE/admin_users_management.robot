*** Settings ***
Documentation   Tests the Admin Users Management of the Application

Resource        ../../resources/imports.robot
Test Setup      Initialization     ${LOGIN_URL}    ${HEADLESS}
Test Teardown   Close Browser

Default Tags    E2E

*** Test Cases ***
Admin Setting Up a New User
    [Documentation]    Test admin setting up a new user
    [Tags]  E2E  smoke
    Given user goes to sign up page
    When user ensures that admin exists             ${ADMIN_NAME}  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    And user goes to sign in page
    And user login                                  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    And Wait Until Element Is Visible               ${home_admin_subtitle_p}    10s
    ${new_random_user_email}=    set up a new random user                   
    Then check user in users list after creation    ${new_random_user_email}      
