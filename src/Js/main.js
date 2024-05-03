document.addEventListener('DOMContentLoaded', function () {
    // Cria o mapa apenas uma vez e atribui a uma variável de nível de script
    var map = L.map('map').setView([-15, -55], 4);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap'
    }).addTo(map);

    var geojsonLayer; // Para armazenar a camada GeoJSON das espécies
    var biomeLayer; // Para armazenar a camada Cerrado

    // adicionar camadas GeoJSON com estilo específico
    function addGeoJsonLayer(url, style) {
        fetch(url)
            .then(response => response.json())
            .then(data => {
                if (style === 'biome') {
                    if (biomeLayer) {
                        map.removeLayer(biomeLayer); // Remove a camada antiga
                    }
                    biomeLayer = L.geoJSON(data, {
                        style: function () {
                            return { color: "#feb24c", weight: 1 };
                        }
                    }).addTo(map);
                } else {
                    if (geojsonLayer) {
                        map.removeLayer(geojsonLayer); // Remove a camada antiga, se houver
                    }
                    geojsonLayer = L.geoJSON(data, {
                        pointToLayer: function(feature, latlng) {
                            return L.circleMarker(latlng, {
                                radius: 3,
                                fillColor: "#08519c",
                                color: "#000",
                                weight: 1,
                                opacity: 1,
                                fillOpacity: 0.8
                            });
                        },
                        onEachFeature: function(feature, layer) {
                            layer.bindPopup(feature.properties.scientificName);
                        }
                    }).addTo(map);
                }
            })
            .catch(err => console.error('Error loading the GeoJSON data: ', err));
    }

    // Carregar a camada do bioma do Cerrado ao inicializar
    addGeoJsonLayer('/data/biome.geojson', 'biome');

    function loadSpeciesData(speciesFile) {
        addGeoJsonLayer(speciesFile, 'species');
    }

    document.getElementById('species1').onclick = function() {
        loadSpeciesData('/data/ocorrencias-Anodorhynchus-leari.geojson'); // Arara-azul-de-Lear
    };

    document.getElementById('species2').onclick = function() {
        loadSpeciesData('/data/ocorrencias-Chrysocyon-brachyurus.geojson'); // Lobo Guará
    };

    document.getElementById('species3').onclick = function() {
        loadSpeciesData('/data/ocorrencias-mergus.geojson'); // Pato-Mergulhão
    };

    document.getElementById('species4').onclick = function() {
        loadSpeciesData('/data/ocorrencias-Myrmecophaga-tridactyla.geojson'); // Tamanduá-Bandeira
    };

    document.getElementById('species5').onclick = function() {
        loadSpeciesData('/data/ocorrencias_panthera_onca.geojson'); // Onça Pintada   
    };

});


