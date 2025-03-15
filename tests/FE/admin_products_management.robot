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
    Given Admin Login in the Application
    ${new_random_product_name}=    When set up a new random product                   
    Then check product in products list after creation    ${new_random_product_name}