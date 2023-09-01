*** Settings ***
Documentation            Online

Resource       ../resources/base.resource

#o robot precisa das bibliotecas adicionais para abrir o site
# vou usar o Browser Library que tem vantagem em relação ao selenium por ser mais rapida e estar preparada para a web e linguagens modernas
# da suporte frbrowser init instalando o Playwright,vai instalar todos os navegadores suportados pela biblioteca browser tipo chromium=edge, firefox, webkit(da suporte ao safari da appple) 

*** Test Cases ***
Webapp deve estar online
    Start Session
    Get Title       equal    Mark85 by QAx
    
    Sleep        2

