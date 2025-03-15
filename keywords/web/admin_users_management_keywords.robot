*** Settings ***
Resource    ../../resources/imports.robot
Resource   ../../variables/web_locators.robot

*** Keywords ***
Set up a new random user              
    [Documentation]    Set up a new random user
    User Goes to Admin Add User Page
    ${new_random_user_email}=    Generate Random Email
    ${new_random_user_name}=    Generate Random Name
    ${new_random_user_email}=    Generate Random Email
    ${new_random_user_password}=    Generate Random Password
    Admin Ensures That User Exists    ${new_random_user_name}    ${new_random_user_email}    ${new_random_user_password}
    RETURN    ${new_random_user_email}

Check User in Users List after Creation
    [Documentation]    Check if the user is in the users list  
    [Arguments]     ${new_random_user_email}
    ${user_exists}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//td[text()='${new_random_user_email}']    10s
    Run Keyword If    not ${user_exists}    Fail    **ERROR: User ${new_random_user_email} not found in the list**
    Log To Console    **INFO: User ${new_random_user_email} found in the list** 

User Goes to Admin List Users Page    
    Go To           url=${ADMIN_LIST_USERS_URL}
    Wait Until Element Is Visible               ${admin_user_list_table}

Generate Random Email
    [Documentation]    Generates a random email address
    ${random_email}=    Evaluate    "yuriRandomUser" + str(random.randint(1000, 9999)) + "@example.com"    random
    RETURN    ${random_email}

Generate Random Name   
    [Documentation]    Generates a random name
    ${random_name}=    Evaluate    "YuriRandomUser" + str(random.randint(1000, 9999))    random
    RETURN    ${random_name}   

Generate Random Password
    [Documentation]    Generates a random password
    ${random_password}=    Evaluate    "YuriRandomPassword" + str(random.randint(1000, 9999))    random
    RETURN    ${random_password}
