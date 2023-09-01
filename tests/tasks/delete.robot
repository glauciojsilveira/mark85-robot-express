*** Settings ***
Documentation       Cenarios de de testes deremoção de tarefas de tarefas

Resource        ../../resources/base.resource


Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve poder marcar uma tarefa indesejada

    ${data}        Get fixture    tasks    delete
    
    Reset user from database    ${data}[user]
    Create a new task from API  ${data}

    Do login   ${data}[user]
    Sleep    2
    Request removal          ${data}[task][name]
    Sleep    2
    Task should not exist    ${data}[task][name]

    Sleep    2

    
