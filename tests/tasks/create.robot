*** Settings ***
Documentation            Cenários de cadastro de tarefas

Resource      ../../resources/base.resource


Test Setup        Start Session
Test Teardown     Take Screenshot



*** Test Cases ***

Deve poder cadastrar uma nova tarefa
    
    ${data}    Get fixture    tasks    create

    Reset user from database     ${data}[user] 

    Do login       ${data}[user]
    
    Go to task form
    Submit task form             ${data}[task]
    Task should be registered    ${data}[task][name]

    Sleep   3
Não deve cadastrar tarefa com nome duplicado
    [Tags]    duplicate

    ${data}     Get fixture     tasks     duplicate
    #via banco
    # Dado que eu tenho um novo usuário - em Gherkin  BDD
    Reset user from database    ${data}[user]
    #via API
    # E que esse ususario já cadastrou uma tarefa - em Gherkin  BDD
    Create a new task from API  ${data}
    # E que estou logado na aplicação WEB - em Gherkin  BDD

    Do login       ${data}[user]
    Sleep    2

    # Quando tento cadastrar essa tarefa que já foi cadastrada- em Gherkin  BDD
    Go to task form
    Submit task form              ${data}[task]
    Sleep    2

    # Então devo ver uma notificação de dupricidade- em Gherkin  BDD
    Notice should be             Oops! Tarefa duplicada.
    Sleep    2

Não deve cadastrar una nova tarefa quando atingir o limite de tags
    [Tags]    tags_limit 
    
    ${data}     Get fixture     tasks     tags_limit

    Reset user from database      ${data}[user]
    
    Do login       ${data}[user]
    
    Go to task form
    Submit task form              ${data}[task]
    Sleep    2
        
    Notice should be             Oops! Limite de tags atingido.
    Sleep    2




















    #usamos a sintaxe Gherkin, para escrever as funcionalidades 
    # do sistema guiados ao comportamento(BDD) e também guiadas 
    # a teste(BDT) e podemos usar ambos na automatização dos testes
    #  com o Cucumber que interpretará essa escrita
    # O Test Driven Development (TDD) e o Behavior Driven Development (BDD) são duas metodologias 
    # de desenvolvimento de software que têm como objetivo garantir a qualidade do código produzido.
    # A principal diferença entre elas é que o TDD é focado em uma linguagem mais técnica, 
    # com o objetivo de testar alguma funcionalidade, enquanto o BDD é focado em uma linguagem
    #  mais próxima da linguagem natural, ou seja, testes de comportamento.
    # No TDD, escrevemos testes unitários, por exemplo, antes de escrever o código em si.
    # Isso nos ajuda a garantir que o código está fazendo o que deveria fazer e que não há erros
    #  de lógica. Já no BDD, escrevemos testes de comportamento antes de escrever o código. 
    # Esses testes são escritos em uma linguagem natural e descrevem o comportamento esperado 
    # do sistema em termos de entradas e saídas.
    # Sobre utilizar ambos, não há problema em utilizar as duas metodologias em um mesmo projeto,
    #  desde que isso faça sentido para o contexto em que você está trabalhando. 
    # O importante é entender as diferenças entre elas e escolher a que melhor se adequa às
    #  necessidades do projeto.#/ 