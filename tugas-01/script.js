let tempLat, tempLng;
const map = L.map('map').setView([-0.0263, 109.3425], 13);

const baseOsm = L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
}).addTo(map);

const greenIcon = new L.Icon({
    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
    iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
});

const redIcon = new L.Icon({
    iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
    shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
    iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
});

const layerSPBU = L.layerGroup().addTo(map);
const drawnItems = new L.FeatureGroup().addTo(map);

let searchableLayers = [];

// Setup Leaflet Draw Toolbar
const drawControl = new L.Control.Draw({
    draw: {
        marker: { icon: redIcon },
        circle: false, rectangle: false, circlemarker: false, polyline: false, polygon: false
    },
    edit: { featureGroup: drawnItems }
}).addTo(map);

// Memindahkan UI Draw Toolbar dari peta ke dalam Sidebar
document.getElementById('drawControlWrapper').appendChild(drawControl.getContainer());

// FUNGSI RENDER DATA SPBU
function createSPBUMarker(data) {
    const statusBuka = data.buka.trim();
    const markerIcon = (statusBuka === 'Ya') ? redIcon : greenIcon; 
    const marker = L.marker([data.lat, data.lng], { icon: markerIcon, draggable: true });

    function updatePopupContent(id, nama, wa, buka, lat, lng, leafletId) {
        return `<div class="popup-content">
            <b>${nama}</b><br>WA: ${wa}<br>Buka 24: ${buka}<br>
            Lat: ${lat.toFixed(6)}<br>Lng: ${lng.toFixed(6)}<br>
            <div class="button-group">
                <button class="btn-edit" onclick="editData(${id}, '${nama}', '${wa}', '${buka}')">Edit</button>
                <button class="btn-delete" onclick="deleteMarker(${id}, ${leafletId})">Hapus</button>
            </div>
        </div>`;
    }

    marker.bindPopup(updatePopupContent(data.id, data.nama, data.wa, data.buka, data.lat, data.lng, marker._leaflet_id));
    
    marker.on('dragend', async function (e) {
        const newLatLng = marker.getLatLng();
        const fd = new FormData();
        fd.append('id', data.id); fd.append('lat', newLatLng.lat); fd.append('lng', newLatLng.lng);
        await fetch('../spbu/update_koordinat.php', { method: 'POST', body: fd });
        marker.setPopupContent(updatePopupContent(data.id, data.nama, data.wa, data.buka, newLatLng.lat, newLatLng.lng, marker._leaflet_id));
    });
    marker.addTo(layerSPBU);

    searchableLayers.push({ nama: data.nama, layer: marker, tipe: 'titik' });
}

// Mengeksekusi variabel global DATA_SPBU yang dilempar dari index.php
if (typeof DATA_SPBU !== 'undefined') {
    DATA_SPBU.forEach(spbu => createSPBUMarker(spbu));
}

// EVENT HANDLING LEAFLET DRAW
map.on(L.Draw.Event.CREATED, async function (e) {
    const layer = e.layer;
    const latlng = layer.getLatLng();
    tempLat = latlng.lat; tempLng = latlng.lng;
    
    const formContent = `<div class="popup-content">
        <h4>Tambah SPBU Baru</h4>
        <input type="text" id="input_nama" placeholder="Nama SPBU">
        <input type="text" id="input_wa" placeholder="No WA">
        <select id="input_buka">
            <option value="Ya">Buka 24 Jam</option>
            <option value="Tidak">Tidak 24 Jam</option>
        </select>
        <button class="btn-save" onclick="simpanData()">Simpan</button>
    </div>`;
    L.popup().setLatLng(latlng).setContent(formContent).openOn(map);
    map.removeLayer(layer);
});

// CRUD BACKEND (FETCH API)
window.simpanData = async function() {
    const formData = new FormData();
    formData.append('nama_spbu', document.getElementById('input_nama').value);
    formData.append('no_wa', document.getElementById('input_wa').value);
    formData.append('buka_24', document.getElementById('input_buka').value);
    formData.append('latitude', tempLat); formData.append('longitude', tempLng);
    
    const response = await fetch('../spbu/tambah_spbu.php', { method: 'POST', body: formData });
    if ((await response.json()).status === 'success') location.reload();
}

window.updateData = async function(id) {
    const formData = new FormData();
    formData.append('id', id);
    formData.append('nama', document.getElementById('edit_nama').value);
    formData.append('wa', document.getElementById('edit_wa').value);
    formData.append('buka', document.getElementById('edit_buka').value);
    
    const response = await fetch('../spbu/update_spbu.php', { method: 'POST', body: formData });
    if ((await response.json()).status === 'success') location.reload();
}

window.deleteMarker = async function(id, leafletId) {
    if (confirm("Hapus data?")) {
        const response = await fetch(`../spbu/hapus_spbu.php?id=${id}`);
        if ((await response.json()).status === 'success') location.reload();
    }
}

window.editData = function(id, nama, wa, buka) {
    const editForm = `<div class="popup-content">
        <h4>Edit SPBU</h4>
        <input type="text" id="edit_nama" value="${nama}">
        <input type="text" id="edit_wa" value="${wa}">
        <select id="edit_buka">
            <option value="Ya" ${buka === 'Ya' ? 'selected' : ''}>Buka 24 Jam</option>
            <option value="Tidak" ${buka === 'Tidak' ? 'selected' : ''}>Tidak 24 Jam</option>
        </select>
        <button class="btn-save" onclick="updateData(${id})">Update Data</button>
    </div>`;
    map.closePopup();
    L.popup().setLatLng(map.getCenter()).setContent(editForm).openOn(map);
}

// FUNGSI PENCARIAN DATA
window.cariData = function() {
    const keyword = document.getElementById('searchInput').value.toLowerCase().trim();
    if (!keyword) { alert("Masukkan kata kunci pencarian!"); return; }

    let found = false;
    for (let item of searchableLayers) {
        if (item.nama && item.nama.toLowerCase().includes(keyword)) {
            found = true;
            if (item.tipe === 'titik') { map.flyTo(item.layer.getLatLng(), 17); } 
            else { map.flyToBounds(item.layer.getBounds(), { maxZoom: 17 }); }
            item.layer.openPopup();
            break;
        }
    }
    if (!found) alert("Data tidak ditemukan! Pastikan nama SPBU sudah benar.");
}

window.handleEnter = function(e) {
    if (e.key === 'Enter') cariData();
}

// MUAT BASEMAP KECAMATAN
async function loadBasemapPontianak() {
    const adminGrp = L.layerGroup().addTo(map);

    async function fetchGeoJSON(url) {
        const response = await fetch(url);
        if (!response.ok) throw new Error(`File tidak ditemukan: ${url}`);
        return await response.json();
    }

    function getColorKecamatan(nama) {
        if (!nama) return "#cccccc";
        const n = nama.toUpperCase();
        if (n.includes("BARAT")) return "#e41a1c";
        if (n.includes("KOTA")) return "#377eb8";
        if (n.includes("SELATAN")) return "#4daf4a";
        if (n.includes("TENGGARA")) return "#984ea3";
        if (n.includes("TIMUR")) return "#ff7f00";
        if (n.includes("UTARA")) return "#f1c40f"; 
        return "#a65628";
    }

    try {
        const dataAdmin = await fetchGeoJSON('../assets/data/Admin_Kecamatan.json');
        L.geoJSON(dataAdmin, {
            style: function (feature) {
                const namaKecamatan = feature.properties.Ket || "";
                return { color: "black", weight: 2, fillOpacity: 0.2, fillColor:getColorKecamatan(namaKecamatan) };
            },
            onEachFeature: function (feature, layer) {
                const namaKecamatan = feature.properties.Ket || "Tidak Diketahui";
                const jumlahPenduduk = feature.properties.penduduk || 0;
                const formatPenduduk = new Intl.NumberFormat('id-ID').format(jumlahPenduduk);

                layer.bindPopup(`
                    <div style="text-align: center;">
                        <b>Kecamatan ${namaKecamatan}</b><br>
                        <hr style="margin: 5px 0;">
                        Jumlah Penduduk: <b>${formatPenduduk} Jiwa</b>
                    </div>
                `);
            }
        }).addTo(adminGrp);

    } catch (e) {
        console.error("Gagal memuat peta kecamatan:", e.message);
    }

    const baseLayers = { "OpenStreetMap": baseOsm };
    const overlays = {
        "Batas Kecamatan": adminGrp,
        "SPBU (Titik)": layerSPBU,
        "Alat Digitasi": drawnItems
    };
    L.control.layers(baseLayers, overlays).addTo(map);
}

loadBasemapPontianak();