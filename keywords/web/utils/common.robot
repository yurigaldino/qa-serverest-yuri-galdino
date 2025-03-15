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