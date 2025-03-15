*** Variables ***

# URLs
${ADMIN_ADD_PRODUCT_URL}                        https://front.serverest.dev/admin/cadastrarprodutos
${ADMIN_ADD_USER_URL}                           https://front.serverest.dev/admin/cadastrarusuarios
${ADMIN_LIST_PRODUCT_URL}                       https://front.serverest.dev/admin/listarprodutos
${ADMIN_LIST_USERS_URL}                         https://front.serverest.dev/admin/usuarios
${LOGIN_URL}                                    https://front.serverest.dev/login
${SIGN_UP_URL}                                  https://front.serverest.dev/cadastrarusuarios

# Login Page
${login_email_input}                            id=email
${login_invalid_email_alert_span}               xpath=//span[text()='Email deve ser um email válido']
${login_invalid_email_or_password_alert_span}   xpath=//span[text()='Email e/ou senha inválidos']
${login_password_input}                         id=password
${login_submit_button}                          xpath=//button[@data-testid='entrar']
${login_without_email_alert_span}               xpath=//span[text()='Email é obrigatório']
${login_without_password_alert_span}            xpath=//span[text()='Password é obrigatório']

# Sign Up Page
${sign_up_admin_checkbox_input}                 id=administrador
${sign_up_email_already_in_use_alert_span}      xpath=//span[text()='Este email já está sendo usado']
${sign_up_email_input}                          id=email
${sign_up_email_success_span}                   xpath=//a[text()='Cadastro realizado com sucesso']
${sign_up_name_input}                           id=nome
${sign_up_password_input}                       id=password
${sign_up_submit_button}                        xpath=//button[@data-testid='cadastrar']
${admin_sign_up_submit_button}                  xpath=//button[@data-testid='cadastrarUsuario']

# Admin Add User Page
${admin_user_add_title_h1}                      xpath=//h1[text()='Cadastro de usuários']
${admin_user_list_table}                        .table.table-striped

# Admin Add Product Page
${admin_product_add_title_h1}                   xpath=//h1[text()='Cadastro de produtos']
${admin_product_description_input}              id=description
${admin_product_list_table}                     .table.table-striped
${admin_product_name_input}                     id=nome
${admin_product_price_input}                    id=price
${admin_product_quantity_input}                 id=quantity
${admin_product_submit_button}                  xpath=//button[@data-testid='cadastarProdutos']

# Home Page
${home_admin_subtitle_p}                        xpath=//p[text()='Este é seu sistema para administrar seu ecommerce.']
${home_user_title_h1}                           xpath=//h1[text()='Serverest Store']