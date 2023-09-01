*** Settings ***
Documentation            Ações e elementos da pagina login


Library     Browser

*** Keywords ***

Submit login form

    [Arguments]        ${user}

    Sleep    1
    Fill Text          css=input[name=email]               ${user}[email]
    Sleep    1
    Fill Text          css=input[placeholder=Senha]        ${user}[password]
    Sleep    1
    
    Click            css=button >> text=Entrar






# Click            id=buttonLogin
# Click            xpath=//button[text()="Entrar"]


    


