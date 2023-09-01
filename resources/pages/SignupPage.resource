*** Settings ***

Documentation        Elementos e ações da pagina de cadastro

Library           Browser
Resource          ../env.resource

*** Keywords ***

Go to signup page
    
    Go To        ${BASE_URL}/signup
    
    Wait For Elements State        css=h1     visible        5
    Get Text                       css=h1     equal          Faça seu cadastro
Submit signup form
    [Arguments]        ${user}
    
    
    Sleep    1
    Fill Text            css=input[name=name]                ${user}[name]
    Sleep    1 
    Fill Text            css=input[name=email]               ${user}[email]
    Sleep    1 
    Fill Text            css=input[name=password]            ${user}[password]
    Sleep    1  
    
    Click                css=button[type=submit] >> text=Cadastrar
# Notice should be
#     [Arguments]         ${expected_text}    
        
#     ${element}            Set Variable        css=.notice p 
    
#     Wait For Elements State        ${element}         visible        5
#     Get Text                       ${element}         equal          ${expected_text}



    

#PascalCage
#camelCase
#Snake_case
# Boas vindas ao Mark85, o seu gerenciador de tarefas.