*** Variables ***

#URLs
${LOGIN_URL}                                    https://front.serverest.dev/login
${SIGN_UP_URL}                                  https://front.serverest.dev/cadastrarusuarios

#Login Page
${login_email_input}                            id=email
${login_password_input}                         id=password
${login_submit_button}                          xpath=//button[@data-testid='entrar']
${login_invalid_email_alert_span}               xpath=//span[text()='Email deve ser um email válido']
${login_invalid_email_or_password_alert_span}   xpath=//span[text()='Email e/ou senha inválidos']
${login_without_password_alert_span}            xpath=//span[text()='Password é obrigatório']
${login_without_email_alert_span}               xpath=//span[text()='Email é obrigatório']

#Sign Up Page
${sign_up_name_input}                           id=nome
${sign_up_email_input}                          id=email    
${sign_up_password_input}                       id=password
${sign_up_admin_checkbox_input}                 id=administrador
${sign_up_submit_button}                        xpath=//button[@data-testid='cadastrar']
${sign_up_email_already_in_use_alert_span}      xpath=//span[text()='Este email já está sendo usado']
${sign_up_email_success_span}                   xpath=//a[text()='Cadastro realizado com sucesso']

#Home Page
${home_user_title_h1}                           xpath=//h1[text()='Serverest Store']
${home_admin_subtitle_p}                        xpath=//p[text()='Este é seu sistema para administrar seu ecommerce.']