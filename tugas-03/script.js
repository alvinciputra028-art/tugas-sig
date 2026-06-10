let tempLat, tempLng;

const map = L.map('map', { zoomControl: false }).setView([-0.0263, 109.3425], 13);
L.control.zoom({ position: 'topright' }).addTo(map);

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

// Layer Groups Visual
const layerSPBU24 = L.layerGroup().addTo(map);
const layerSPBUNon24 = L.layerGroup().addTo(map);
const layerJalanDB = L.layerGroup().addTo(map);
const layerParsilDB = L.layerGroup().addTo(map);
const drawnItems = new L.FeatureGroup().addTo(map);

let searchableLayers = [];

// SETUP LEAFLET DRAW TOOLBAR
const drawControl = new L.Control.Draw({
    draw: {
        polyline: { shapeOptions: { color: 'blue' } },
        polygon: { shapeOptions: { color: 'orange' } },
        marker: { icon: redIcon },
        circle: false, rectangle: false, circlemarker: false
    },
    edit: { featureGroup: drawnItems }
}).addTo(map);

// Memindahkan UI Draw Toolbar ke dalam Sidebar
document.getElementById('drawControlWrapper').appendChild(drawControl.getContainer());

// FUNGSI RENDER DATA SPBU (DENGAN KONDISI LAYER GROUP)
function createSPBUMarker(data) {
    const statusBuka = data.buka.trim();
    // Buka 24 jam = GreenIcon, Tidak = RedIcon
    const markerIcon = (statusBuka === 'Ya') ? greenIcon : redIcon;
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

    // Memasukkan marker ke kelompok layer group yang sesuai
    if (statusBuka === 'Ya') {
        marker.addTo(layerSPBU24);
    } else {
        marker.addTo(layerSPBUNon24);
    }

    searchableLayers.push({ nama: data.nama, layer: marker, tipe: 'titik' });
}

if (typeof DATA_SPBU !== 'undefined') {
    DATA_SPBU.forEach(spbu => createSPBUMarker(spbu));
}

// EVENT HANDLING LEAFLET DRAW (CREATED & EDITED)
map.on(L.Draw.Event.CREATED, async function (e) {
    const layer = e.layer;
    const type = e.layerType;
    if (type === 'polyline') {
        const coords = layer.getLatLngs();
        let panjang = 0;
        for (let i = 0; i < coords.length - 1; i++) { panjang += coords[i].distanceTo(coords[i + 1]); }
        const nama = prompt("Nama Jalan:");
        const status = prompt("Status (Nasional/Provinsi/Kabupaten):");
        if (nama && status) {
            const fd = new FormData();
            fd.append('nama', nama); fd.append('status', status); fd.append('panjang', panjang.toFixed(2)); fd.append('koordinat', JSON.stringify(coords));
            await fetch('../jalan/tambah_jalan.php', { method: 'POST', body: fd }); location.reload();
        }
    } else if (type === 'polygon') {
        const coords = layer.getLatLngs()[0];
        const luas = L.GeometryUtil.geodesicArea(coords);
        const pemilik = prompt("Nama Pemilik:");
        const status = prompt("Status (SHM/HGB/HGU/HP):");
        if (pemilik && status) {
            const fd = new FormData();
            fd.append('pemilik', pemilik); fd.append('status', status); fd.append('luas', luas.toFixed(2)); fd.append('koordinat', JSON.stringify(coords));
            await fetch('../parsil/tambah_parsil.php', { method: 'POST', body: fd }); location.reload();
        }
    } else if (type === 'marker') {
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
    }
});

map.on(L.Draw.Event.EDITED, async function (e) {
    const layers = e.layers;
    layers.eachLayer(async function (layer) {
        const id = layer.db_id;
        const type = layer.db_type;

        if (id && type) {
            let coords_str = '';
            let nilai_baru = 0;

            if (type === 'jalan') {
                const coords = layer.getLatLngs();
                let panjang = 0;
                for (let i = 0; i < coords.length - 1; i++) { panjang += coords[i].distanceTo(coords[i + 1]); }
                nilai_baru = panjang.toFixed(2);
                coords_str = JSON.stringify(coords);
            } else if (type === 'parsil') {
                const coords = layer.getLatLngs()[0];
                nilai_baru = L.GeometryUtil.geodesicArea(coords).toFixed(2);
                coords_str = JSON.stringify(coords);
            }

            const fd = new FormData();
            fd.append('id', id); fd.append('type', type); fd.append('nilai', nilai_baru); fd.append('koordinat', coords_str);
            await fetch('../shared/update_geometri.php', { method: 'POST', body: fd });
        }
    });
    alert("Perubahan garis/bidang berhasil disimpan!");
    location.reload();
});

// CRUD SPBU
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

// CRUD JALAN & PARSIL
window.editDataJalan = function(id, nama, status) {
    const editForm = `<div class="popup-content">
        <h4>Edit Jalan</h4>
        <input type="text" id="edit_nama_jalan" value="${nama}">
        <select id="edit_status_jalan">
            <option value="Nasional" ${status === 'Nasional' ? 'selected' : ''}>Nasional</option>
            <option value="Provinsi" ${status === 'Provinsi' ? 'selected' : ''}>Provinsi</option>
            <option value="Kabupaten" ${status === 'Kabupaten' ? 'selected' : ''}>Kabupaten</option>
        </select>
        <button class="btn-save" onclick="updateDataJalan(${id})">Update Jalan</button>
    </div>`;
    map.closePopup();
    L.popup().setLatLng(map.getCenter()).setContent(editForm).openOn(map);
}

window.updateDataJalan = async function(id) {
    const fd = new FormData();
    fd.append('id', id); fd.append('nama', document.getElementById('edit_nama_jalan').value); fd.append('status', document.getElementById('edit_status_jalan').value);
    const response = await fetch('../jalan/update_jalan.php', { method: 'POST', body: fd });
    if ((await response.json()).status === 'success') location.reload();
}

window.deleteJalan = async function(id) {
    if (confirm("Hapus data jalan ini?")) {
        const response = await fetch(`../jalan/hapus_jalan.php?id=${id}`);
        if ((await response.json()).status === 'success') location.reload();
    }
}

window.editDataParsil = function(id, pemilik, status) {
    const editForm = `<div class="popup-content">
        <h4>Edit Parsil</h4>
        <input type="text" id="edit_pemilik_parsil" value="${pemilik}">
        <select id="edit_status_parsil">
            <option value="SHM" ${status === 'SHM' ? 'selected' : ''}>SHM</option>
            <option value="HGB" ${status === 'HGB' ? 'selected' : ''}>HGB</option>
            <option value="HGU" ${status === 'HGU' ? 'selected' : ''}>HGU</option>
            <option value="HP" ${status === 'HP' ? 'selected' : ''}>HP</option>
        </select>
        <button class="btn-save" onclick="updateDataParsil(${id})">Update Parsil</button>
    </div>`;
    map.closePopup();
    L.popup().setLatLng(map.getCenter()).setContent(editForm).openOn(map);
}

window.updateDataParsil = async function(id) {
    const fd = new FormData();
    fd.append('id', id); fd.append('pemilik', document.getElementById('edit_pemilik_parsil').value); fd.append('status', document.getElementById('edit_status_parsil').value);
    const response = await fetch('../parsil/update_parsil.php', { method: 'POST', body: fd });
    if ((await response.json()).status === 'success') location.reload();
}

window.deleteParsil = async function(id) {
    if (confirm("Hapus data parsil ini?")) {
        const response = await fetch(`../parsil/hapus_parsil.php?id=${id}`);
        if ((await response.json()).status === 'success') location.reload();
    }
}

// RENDER DATA SPASIAL (DIKUNCI KE LAYER GROUP)
function getColorJalan(status) { return status === 'Nasional' ? 'red' : status === 'Provinsi' ? 'blue' : 'green'; }
function getColorParsil(status) {
    const colors = { 'SHM': '#8B4513', 'HGB': '#FFD700', 'HGU': '#ADFF2F', 'HP': '#87CEEB' };
    return colors[status] || '#CCCCCC';
}

async function loadSpasial() {
    const resJ = await fetch('../jalan/get_jalan.php');
    const dataJ = await resJ.json();
    L.geoJSON(dataJ, {
        style: function (f) { return { color: getColorJalan(f.properties.status), weight: 4 }; },
        onEachFeature: function (f, layer) {
            layer.bindPopup(`
                <div class="popup-content">
                    <b>${f.properties.nama}</b><br>
                    Status: ${f.properties.status}<br>
                    Panjang: ${f.properties.panjang} m<br>
                    <div class="button-group">
                        <button class="btn-edit" onclick="editDataJalan(${f.properties.id}, '${f.properties.nama}', '${f.properties.status}')">Edit</button>
                        <button class="btn-delete" onclick="deleteJalan(${f.properties.id})">Hapus</button>
                    </div>
                </div>
            `);
            layer.db_id = f.properties.id; layer.db_type = 'jalan';
            drawnItems.addLayer(layer);
            searchableLayers.push({ nama: f.properties.nama, layer: layer, tipe: 'garis' });
        }
    }).addTo(layerJalanDB); // Memasukkan ke Layer Group Jalan

    const resP = await fetch('../parsil/get_parsil.php');
    const dataP = await resP.json();
    L.geoJSON(dataP, {
        style: function (f) {
            return { fillColor: getColorParsil(f.properties.status), fillOpacity: 0.6, color: "black", weight: 1 };
        },
        onEachFeature: function (f, layer) {
            layer.bindPopup(`
                <div class="popup-content">
                    <b>Pemilik: ${f.properties.pemilik}</b><br>
                    Status: ${f.properties.status}<br>
                    Luas: ${f.properties.luas} m²<br>
                    <div class="button-group">
                        <button class="btn-edit" onclick="editDataParsil(${f.properties.id}, '${f.properties.pemilik}', '${f.properties.status}')">Edit</button>
                        <button class="btn-delete" onclick="deleteParsil(${f.properties.id})">Hapus</button>
                    </div>
                </div>
            `);
            layer.db_id = f.properties.id; layer.db_type = 'parsil';
            drawnItems.addLayer(layer);
            searchableLayers.push({ nama: f.properties.pemilik, layer: layer, tipe: 'bidang' });
        }
    }).addTo(layerParsilDB); // Memasukkan ke Layer Group Parsil
}

// MUAT BASEMAP KECAMATAN & MENU LAYER INTERAKTIF SIDEBAR
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
                return { color: "black", weight: 2, fillOpacity: 0.2, fillColor: getColorKecamatan(namaKecamatan) };
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

    // Grouping Overlays
    const overlays = {
        "Batas Kecamatan": adminGrp,
        "SPBU Buka 24 Jam": layerSPBU24,
        "SPBU Tidak Buka 24 Jam": layerSPBUNon24,
        "Data Jalan (Polyline)": layerJalanDB,
        "Data Parsil (Polygon)": layerParsilDB
    };

    // Membuat menu kontrol layer selalu terbuka (collapsed: false) dan dimasukkan ke sidebar
    const layerControl = L.control.layers(baseLayers, overlays, { collapsed: false }).addTo(map);
    document.getElementById('layerControlWrapper').appendChild(layerControl.getContainer());

    // Memaksa peta kalkulasi ulang ukurannya di dalam layout CSS Flexbox
    setTimeout(function () { map.invalidateSize(); }, 500);
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
    if (!found) alert("Data tidak ditemukan! Pastikan nama SPBU, Jalan, atau Pemilik sudah benar.");
}

window.handleEnter = function(e) {
    if (e.key === 'Enter') cariData();
}

loadSpasial();
loadBasemapPontianak();