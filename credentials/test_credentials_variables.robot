*** Variables ***

#Test Credentials (data is mocked since is a open testing environment, be careful with real data)
#This structure were chosen to make it more simple for everyone to run the tests
#If you want to use real data, please use the environment variables
${USER_NAME}            Yuri Galdino Test User
${USER_EMAIL}           yurig@test.com
${USER_PASSWORD}        123
${ADMIN_NAME}           Yuri Galdino Test Admin
${ADMIN_EMAIL}          yurig@admin.com
${ADMIN_PASSWORD}       321
${OK_FORMATTED_EMAIL}   test@test.com
${BAD_FORMATTED_EMAIL}  user@notsigned.up
${WRONG_PASSWORD}       butPasswordIsWrong