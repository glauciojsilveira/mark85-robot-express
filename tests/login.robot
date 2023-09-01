*** Settings ***
Documentation        Cenários de autenticação

Library              Collections
Resource             ../resources/base.resource


Test Setup           Start Session
Test Teardown        Take Screenshot

*** Test Cases ***

Deve poder logar com um usuário pré-cadastrado

    ${user}    Create Dictionary
    ...    name=Glaucio Silveira
    ...    email=glaucio.silveira@yahoo.com.br
    ...    password=123456
    
    Removendo usuario do DB           ${user}[email]   
    Inserindo usuario do DB           ${user}
    
    Submit login form    ${user}
    User should be logged in    ${user}[name]
    

    Sleep    3
Não deve logar com senha inválida

    ${user}    Create Dictionary
    ...    name=Steve Waz
    ...    email=waz@apple.com
    ...    password=123456
    
    Removendo usuario do DB           ${user}[email]   
    Inserindo usuario do DB           ${user}

    Set To Dictionary     ${user}        password=abc123
    
    Submit login form        ${user}
    Notice should be       Ocorreu um erro ao fazer login, verifique suas credenciais.

    Sleep    3


