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
    Given Admin Login in the Application
    ${new_random_user_email}=    When set up a new random user                   
    Then check user in users list after creation    ${new_random_user_email}