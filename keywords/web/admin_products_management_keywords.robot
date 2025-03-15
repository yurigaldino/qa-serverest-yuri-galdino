*** Settings ***
Resource    ../../resources/imports.robot
Resource   ../../variables/web_locators.robot

*** Keywords ***
Set up a new random product              
    [Documentation]    Set up a new random product
    User Goes to Admin Add Product Page
    ${new_random_product_name}=    Generate Random Product Name
    ${new_random_product_price}=    Generate Random Price
    ${new_random_product_description}=    Generate Random Description
    ${new_random_product_quantity}=    Generate Random Quantity 
    Admin Ensures That Product Exists    ${new_random_product_name}    ${new_random_product_price}    ${new_random_product_description}    ${new_random_product_quantity}
    RETURN    ${new_random_product_name}

Admin Ensures That Product Exists          
    [Documentation]    Admin ensures that product exists
    [Arguments]     ${new_random_product_name}    ${new_random_product_price}    ${new_random_product_description}    ${new_random_product_quantity}
    Input Text    ${admin_product_name_input}    ${new_random_product_name}
    Input Text    ${admin_product_price_input}    ${new_random_product_price}
    Input Text    ${admin_product_description_input}    ${new_random_product_description}
    Input Text    ${admin_product_quantity_input}    ${new_random_product_quantity}
    Click Element    ${admin_product_submit_button}
    Check Product in Products List after Creation    ${new_random_product_name}
    
Check Product in Products List after Creation
    [Documentation]    Check if the product is in the products list  
    [Arguments]     ${new_random_product_name}
    ${product_exists}=    Run Keyword And Return Status    Wait Until Element Is Visible    xpath=//td[text()='${new_random_product_name}']    10s
    IF    ${product_exists}
        Log To Console    **INFO: Product ${new_random_product_name} found in the list**
    ELSE
        Fail    **ERROR: Product ${new_random_product_name} not found in the list**
    END

User Goes to Admin Add Product Page
    Go To           ${ADMIN_ADD_PRODUCT_URl}
    Wait Until Element Is Visible               ${admin_product_name_input}