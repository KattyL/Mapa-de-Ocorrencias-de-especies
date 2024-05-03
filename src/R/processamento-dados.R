# Instalar pacotes se ainda não estiverem instalados
if (!require("rgbif")) install.packages("rgbif")
if (!require("maptools")) install.packages("maptools", repos = "https://packagemanager.posit.co/cran/2023-10-13")
if (!require("raster")) install.packages("raster")
if (!require("sp")) install.packages("sp")
if (!require("sf")) install.packages("sf")
if (!require("rgdal")) install.packages("rgdal")

# Ativar pacotes
library(rgbif)
library(maptools)
library(raster)
library(sp)
library(rgdal)
library(sf)

# Definir extensão
extensao <- c(-57.7897, -42.8230, -22.2015, -5.8515)
r <- raster(extent(extensao), nrows=100, ncols=100)  # Defini um raster mais detalhado

# Criar SpatialPolygons
poligono <- st_sfc(st_polygon(list(cbind(c(extensao[1], extensao[2], extensao[2], extensao[1], extensao[1]), 
                                         c(extensao[3], extensao[3], extensao[4], extensao[4], extensao[3])))), 
                   crs = 4326)

# Carregar o conjunto de dados wrld_simpl
data("wrld_simpl", package="maptools")

# Plotagem
plot(wrld_simpl, main="Mapa com Polígono", col = "white", axes = TRUE)
plot(poligono, add=TRUE, col="red", border="blue")  # Adicionei uma borda azul para destaque


# Criar dataframe como indentificador
poligono_df <- st_sf(data = data.frame(id = 1), geometry = poligono)

# Salvando
arq_shapefile <- "C:/Users/kattu/OneDrive/Documentos/Diretórios/Mapa-de-ocorrencias"

# Salvar o polígono como um shapefile
st_write(poligono_df, dsn = arq_shapefile, layer = "area_de_interesse", driver = "ESRI Shapefile")

if (!requireNamespace("sf", quietly = TRUE)) install.packages("sf")
if (!requireNamespace("rgbif", quietly = TRUE)) install.packages("rgbif")
if (!requireNamespace("ggplot2", quietly = TRUE)) install.packages("ggplot2")

library(sf)
library(rgbif)
library(ggplot2)
library(dplyr)

# Importando mapa com área do cerrado
map <- st_read("C:/Users/kattu/OneDrive/Documentos/Diretórios/Mapa-de-ocorrencias/biome.shp")

#Carregando um dado de especie
dados_especie <- occ_data(scientificName="Anodorhynchus hyacinthinus", hasCoordinate=TRUE, 
                          hasGeospatialIssue=FALSE)

head(dados_especie$data)
df_especie <- dados_especie$data

# Converter os dados de ocorrência para sf para facilitar a plotagem
ocorrencias_sf <- st_as_sf(df_especie, coords = c("decimalLongitude", "decimalLatitude"), 
                           crs = 4326, agr = "constant")

ggplot() +
  geom_sf(data = map, fill = "white", color = "black") +
  geom_sf(data = ocorrencias_sf, color = "red", size = 2, shape = 18) +
  theme_minimal() +
  labs(title = "Distribuição de Espécies no Cerrado")

# Objeto sf para um arquivo GeoJSON
st_write(ocorrencias_sf, "ocorrencias.geojson", driver = "GeoJSON")

install.packages("plotly")

library(plotly)

# Criando ploty


p <- plot_ly(data = ocorrencias_sf, type = 'scattergeo', mode = 'markers',
             text = ~scientificName,  # Supondo que você queira mostrar o nome científico ao passar o mouse
             marker = list(size = 10)) %>%
  layout(
    geo = list(
      scope = 'south america',
      showland = TRUE,
      landcolor = 'rgb(243, 243, 243)',
      countrycolor = 'rgb(204, 204, 204)'
    )
  )


# Para gerar uma página HTML com o gráfico
htmlwidgets::saveWidget(as_widget(p), "mapa.html")

#Verificando se as colunas decimalLongitude e latitude existem
print(names(df_especie))

# Verificando se foi carregado corretamente
print(ocorrencias_sf)

# Shiny para aplicações web para mostrar o mapa usando plotly
if (!require("shiny")) install.packages("shiny")
library(shiny)


ui <- fluidPage(
  titlePanel("Distribuição de Espécies no Cerrado"),
  plotlyOutput("plot")  # Output do plotly
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    p <- plot_ly(data = ocorrencias_sf, type = 'scattergeo', mode = 'markers',
                 text = ~scientificName,  # Mostrar nome científico ao passar o mouse
                 marker = list(size = 10)) %>%
      layout(
        geo = list(
          scope = 'south america',
          showland = TRUE,
          landcolor = 'rgb(243, 243, 243)',
          countrycolor = 'rgb(204, 204, 204)'
        )
      )
    return(p)
  })
}

shinyApp(ui = ui, server = server)

# Buscar dados de ocorrência da onça pintada
dados_especie <- occ_data(scientificName = "Panthera onca", hasCoordinate = TRUE, hasGeospatialIssue = FALSE)
df_especie <- dados_especie$data

# Converter para sf
ocorrencias_sf <- st_as_sf(df_especie, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326, agr = "constant")

# Gerando dados geoespaciais
ggplot() +
  geom_sf(data = ocorrencias_sf, color = "red", size = 2, shape = 18) +
  theme_minimal() +
  labs(title = "Distribuição de Panthera onca")

# Salvar como GeoJSON
st_write(ocorrencias_sf, "ocorrencias_panthera_onca.geojson", driver = "GeoJSON")


# Repetindo procedimento e salvando arquivos de outros animais


#### Lobo guará

# Buscar dados de ocorrência 
dados_especie <- occ_data(scientificName = "Chrysocyon brachyurus", hasCoordinate = TRUE, hasGeospatialIssue = FALSE)
df_especie <- dados_especie$data

# Converter para sf
ocorrencias_sf <- st_as_sf(df_especie, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326, agr = "constant")

# Gerando dados geoespaciais
ggplot() +
  geom_sf(data = ocorrencias_sf, color = "red", size = 2, shape = 18) +
  theme_minimal() +
  labs(title = "Distribuição de Chrysocyon brachyurus")

# Salvar como GeoJSON
st_write(ocorrencias_sf, "ocorrencias_Chrysocyon_brachyurus.geojson", driver = "GeoJSON")

##### Tamanduá Bandeira

# Buscar dados de ocorrência 
dados_especie <- occ_data(scientificName = "Myrmecophaga tridactyla", hasCoordinate = TRUE, hasGeospatialIssue = FALSE)
df_especie <- dados_especie$data

# Converter para sf
ocorrencias_sf <- st_as_sf(df_especie, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326, agr = "constant")

# Gerando dados geoespaciais
ggplot() +
  geom_sf(data = ocorrencias_sf, color = "red", size = 2, shape = 18) +
  theme_minimal() +
  labs(title = "Distribuição de Myrmecophaga tridactyla")

# Salvar como GeoJSON
st_write(ocorrencias_sf, "ocorrencias_Myrmecophaga_tridactyla.geojson", driver = "GeoJSON")


####  Pato Mergulhão ( Mergus octosetaceus )

# Buscar dados de ocorrência 
dados_especie <- occ_data(scientificName = "Mergus octosetaceus", hasCoordinate = TRUE, hasGeospatialIssue = FALSE)
df_especie <- dados_especie$data

# Converter para sf
ocorrencias_sf <- st_as_sf(df_especie, coords = c("decimalLongitude", "decimalLatitude"), crs = 4326, agr = "constant")

# Gerando dados geoespaciais
ggplot() +
  geom_sf(data = ocorrencias_sf, color = "red", size = 2, shape = 18) +
  theme_minimal() +
  labs(title = "Distribuição de Mergus octosetaceus")

# Salvar como GeoJSON
st_write(ocorrencias_sf, "ocorrencias_Mergus_octosetaceus.geojson", driver = "GeoJSON")
