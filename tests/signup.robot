*** Settings ***
Documentation        Cenarios de testes do cadastro de usuários

Library        FakerLibrary
Resource       ../resources/base.resource
#são executados antes e depois de cada test
Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário
    
    ${user}         Create Dictionary
    ...    name=Glaucio Silveira
    ...    email=glaucio.silveira@gmail.com
    ...    password=123456

    Removendo usuario do DB       ${user}[email]
    
    Go to signup page
    Submit signup form         ${user}
    Notice should be           Boas vindas ao Mark85, o seu gerenciador de tarefas.

    Sleep        2
    
Não deve permitir o cadastro de email duplicado
    [Tags]    dup
    
    ${user}         Create Dictionary
    ...    name=GlaucioJose
    ...    email=glaucio.jose@hotmail.com
    ...    password=123456

    Removendo usuario do DB           ${user}[email]
    Inserindo usuario do DB           ${user}
    
    Go to signup page
    Submit signup form         ${user}
    Notice should be           Oops! Já existe uma conta com o e-mail informado.
    
    Sleep        3   

Campos obrigatorios
    [Tags]  required

    ${user}        Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    
    Go to signup page
    Submit signup form         ${user}

    Alert should be        Informe seu nome completo
    Alert should be        Informe seu e-email
    Alert should be        Informe uma senha com pelo menos 6 digito
    
    Sleep        3


Não deve cadastrar com email incorreto
    [Tags]    inv_email

    ${user}        Create Dictionary
    ...            name=Glaucio
    ...            email=xavier.com.br
    ...            password=123456
    
    Go to signup page
    Submit signup form         ${user}        
    Alert should be            Digite um e-mail válido

    Sleep        3

Não deve cadastrar com senha menor que 6 digitos
    [Tags]     inv_pass
    
    @{password_list}        Create List    1    12    123    1234    12345

    FOR  ${password}  IN  @{password_list}
            ${user}        Create Dictionary
    ...    name=Glaucio Silveira
    ...    email=glaucio.silveira@gmail.com
    ...    password=${password}
    Sleep        2
    Go to signup page
    Submit signup form         ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos
    Sleep        2
    END




# Não deve cadastrar com senha de 2 digitos
#     [Tags]  pass

#     ${user}        Create Dictionary
#     ...    name=Glaucio Silveira
#     ...    email=glaucio.silveira@gmail.com
#     ...    password=12
    
#     Go to signup page
#     Submit signup form         ${user}

#     Alert should be        Informe uma senha com pelo menos 6 digitos
    
#     Sleep        3

# Não deve cadastrar com senha de 3 digitos
#     [Tags]  pass

#     ${user}        Create Dictionary
#     ...    name=Glaucio Silveira
#     ...    email=glaucio.silveira@gmail.com
#     ...    password=123
    
#     Go to signup page
#     Submit signup form         ${user}

#     Alert should be        Informe uma senha com pelo menos 6 digitos
    
#     Sleep        3

# Não deve cadastrar com senha de 4 digitos
#     [Tags]  pass

#     ${user}        Create Dictionary
#     ...    name=Glaucio Silveira
#     ...    email=glaucio.silveira@gmail.com
#     ...    password=1234
    
#     Go to signup page
#     Submit signup form         ${user}

#     Alert should be        Informe uma senha com pelo menos 6 digitos
    
#     Sleep        3
    
# Não deve cadastrar com senha de 5 digitos
    # [Tags]  pass

    # ${user}        Create Dictionary
    # ...    name=Glaucio Silveira
    # ...    email=glaucio.silveira@gmail.com
    # ...    password=12345
    
    # Go to signup page
    # Submit signup form         ${user}

    # Alert should be        Informe uma senha com pelo menos 6 digitos
    
    # Sleep        3

    # Wait For Elements State         css=.alert-error >> text=Informe seu nome completo
    # ...    visible     5

    # Wait For Elements State         css=.alert-error >> text=Informe seu e-email
    # ...    visible     5

    # Wait For Elements State         css=.alert-error >> text=Informe uma senha com pelo menos 6 digito
    # ...    visible     5

    # Wait For Elements State        xpath=//small[@class='alert-error'][contains(.,'Informe seu nome completo')]     visible    5
    
    # Wait For Elements State        xpath=//small[@class='alert-error'][contains(.,'Informe seu e-email')]        visible    5

    # Wait For Elements State        xpath=//small[@class='alert-error'][contains(.,'Informe uma senha com pelo menos 6 digitos')]    visible    5



  


# O sleep é só paraacompanhar visualmente os testes é meramente visual, podendo ficar sem ele para ganhar tempo e pricipalmente em uma esteira de testes
# Oops! Já existe uma conta com o e-mail informado.

    # Suite Setup           Log        Tudo aqui ocorre antes da suite(tantes, de todos os testes)
    # Suite Teardown        Log        Tudo aqui ocorre depois da suite(depois, de todos os testes)

    #No inicio da construção dos testes costumo usar variaveis locais, mas no final uso globais para compartilhar com outros cenrios e deicar o codigo mais limpo e facilitar a manutenção
    # # ... Variables ***
    # ${name}             Glaucio Silveira
    # ${email}            glaucio.silveira@gmail.com
    # ${password}         123456

    # ${name}         Set Variable        Glaucio Silveira
    # ${email}        Set Variable        glaucio.silveira@gmail.com
    # ${password}     Set Variable        123456

    #FakerLibrary - deve ser usada em caso inicial que tenha como depois limpar o banco, pois ela gera massas aleatorias e o banco pode ficar muito poluido
    # ${name}         FakerLibrary.Name
    # ${email}        FakerLibrary.Free Email
    # ${password}     Set Variable        123456
    # Por boas praticas a Faker deve ser usada nos primeiros testes, depois deve ser feito(glaucio J Silveira)
    # uma automatização de exclusão no banco de dados de preferencia sempre antes de executar o teste(Glaucio J Silveira)