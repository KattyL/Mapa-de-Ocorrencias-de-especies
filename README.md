# Mapa Interativo das Espécies Ameaçadas do Cerrado Brasileiro

&nbsp;&nbsp;&nbsp;O "Mapa Interativo das Espécies Ameaçadas do Cerrado Brasileiro" é um projeto de extensão universitária focado na gestão ambiental e na conscientização sobre a preservação de espécies em risco de extinção. Este projeto utiliza uma abordagem tecnológica e data-driven para visualizar a distribuição geográfica de cinco espécies ameaçadas presentes no Cerrado, uma das savanas mais ricas e ameaçadas do mundo.

&nbsp;&nbsp;&nbsp;Para isso, desenvolvi um mapa interativo usando tecnologias como R, para o processamento de dados, e JavaScript, HTML e CSS para a construção da interface de usuário. Os dados de ocorrência são extraídos do Global Biodiversity Information Facility (GBIF), enquanto os mapas base são adquiridos de fontes confiáveis como TerraBrasilis e Natural Earth.

&nbsp;&nbsp;&nbsp;O objetivo do projeto é fornecer uma ferramenta visual que possa apoiar pesquisas e iniciativas de conservação, possibilitando futuramente a inclusão de análises de dados temporais para investigar o impacto das mudanças climáticas e atividades humanas na distribuição dessas espécies.


## Tecnologias Utilizadas

- Foi utilizado a biblioteca Leaflet, um mapa base é criado e configurado para exibir o território brasileiro com um foco inicial no Cerrado. A Leaflet foi escolhida por sua flexibilidade e facilidade de uso, permitindo a integração com diversas fontes de tiles de mapas, como o OpenStreetMap que foi utilizado neste projeto.

- **Duas camadas principais são manipuladas no projeto:**
    * **Camada do Bioma Cerrado:** Uma camada GeoJSON que destaca a região do Cerrado, aplicando um estilo específico para distinguir esta área importante.
    * **Camadas de Espécies Ameaçadas:** Várias camadas GeoJSON, uma para cada espécie, que são carregadas dinamicamente. Estas camadas mostram pontos de ocorrência de cada espéciece com um popup interativo que fornece o nome científico da espécie observada no local.

- As camadas de dados são carregadas de usando a função fetch do JavaScript. Isso garante que o mapa seja responsivo e que os dados possam ser atualizados ou modificados sem necessidade de recarregar a página inteira.