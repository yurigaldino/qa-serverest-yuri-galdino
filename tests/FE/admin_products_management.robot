*** Settings ***
Documentation   Tests the Admin Products Management of the Application

Resource        ../../resources/imports.robot
Test Setup      Initialization     ${LOGIN_URL}    ${HEADLESS}
Test Teardown   Close Browser

Default Tags    E2E

*** Test Cases ***
Admin Setting Up a New Product
    [Documentation]    Test admin setting up a new product
    [Tags]  E2E  smoke
    Given user goes to sign up page
    When user ensures that admin exists             ${ADMIN_NAME}  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    And user goes to sign in page
    And user login                                  ${ADMIN_EMAIL}   ${ADMIN_PASSWORD}
    And Wait Until Element Is Visible               ${home_admin_subtitle_p}    10s
    ${new_random_product_name}=    set up a new random product                   
    Then check product in products list after creation    ${new_random_product_name}      
