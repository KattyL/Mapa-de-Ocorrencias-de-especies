// Esta folha foi unificada em conjunção com a folha de script mapa-ocorrencias devido a conflitos
// durante o processamento do mapa. Mantendo como backup

var map = L.map('map').setView([-15, -55], 4); // Centraliza o mapa no Brasil

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '© OpenStreetMap'
}).addTo(map);

// Carregar GeoJSON
function addGeoJsonLayer(url) {
    fetch(url)
        .then(response => response.json())
        .then(data => {
            console.log(data); // Isso para ver os dados do connsole
            L.geoJSON(data, {
                style: function (feature) {
                    return {color: "#feb24c", weight: 1}; // 
                }
            }).addTo(map);
        })
        .catch(err => console.error('Error loading the GeoJSON data: ', err));
}


// Carregar a camada do bioma do Cerrado
addGeoJsonLayer('biome.geojson');
