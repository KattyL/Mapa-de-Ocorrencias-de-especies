// Esta folha foi unificada em conjunção com a folha camada-cerrado.js devido a conflitos
// durante o processamento do mapa. Mantendo como backup

var map = L.map('map').setView([-15, -55], 4); // Aqui Centraliza o mapa no Brasil

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '© OpenStreetMap'
}).addTo(map);

var geojsonLayer; // Para armazenar a camada GeoJSON

function loadSpeciesData(speciesFile) {
if (geojsonLayer) {
map.removeLayer(geojsonLayer); // Remove a camada anterior, se necessário
}
fetch(speciesFile)
.then(response => response.json())
.then(data => {
    geojsonLayer = L.geoJSON(data, {
        pointToLayer: function(feature, latlng) {
            return L.circleMarker(latlng, {
                // Características para os marcadores
                radius: 3, // Define o tamanho do ponto
                fillColor: "#08519c", // Cor do preenchimento
                color: "#000", // Cor da borda
                weight: 1, // Espessura da borda
                opacity: 1, // Opacidade da borda
                fillOpacity: 0.8 // Opacidade do preenchimento
            });
        },
        onEachFeature: function(feature, layer) {
            // popup com nome da espécies
            layer.bindPopup(feature.properties.scientificName);
        }
    }).addTo(map);
})
.catch(error => console.error('Error loading the GeoJSON data:', error));
}

document.getElementById('species1').onclick = function() {
loadSpeciesData('ocorrencias.geojson');
};

document.getElementById('species2').onclick = function() {
loadSpeciesData('ocorrencias_species2.geojson');
};

// Carrega espécie inicial
loadSpeciesData('ocorrencias_species1.geojson');
