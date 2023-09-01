*** Settings ***
Documentation       Cenarios de de testes de atualizações de tarefas

Resource        ../../resources/base.resource


Test Setup        Start Session
Test Teardown     Take Screenshot


*** Test Cases ***
Deve poder marcar uma tarefa como concluida

    ${data}        Get fixture    tasks    done
    
    Reset user from database    ${data}[user]
    Create a new task from API  ${data}

    Do login   ${data}[user]
    Sleep    2
    Mark task as completed      ${data}[task][name]
    Sleep    2
    Task should be complete     ${data}[task][name]
    Sleep    2

    
