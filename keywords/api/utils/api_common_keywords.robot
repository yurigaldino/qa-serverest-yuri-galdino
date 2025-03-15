*** Settings ***
Resource    ../../../resources/imports.robot

*** Keywords ***
HTTP Response Status Code Should Be 200 OK
    [Documentation]    Check whether response status code is 200 OK
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    200

HTTP Response Status Code Should Be 201 OK
    [Documentation]    Check whether response status code is 201 OK
    [Arguments]    ${response}
    Should Be Equal As Strings    ${response.status_code}    201