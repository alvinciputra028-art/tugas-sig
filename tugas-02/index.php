<?php
include "../config/koneksi.php";
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>WebGIS Manajemen Spasial Kota Pontianak</title>

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet.draw/1.0.4/leaflet.draw.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/leaflet-geodesic"></script>

    <link rel="stylesheet" href="../assets/css/style.css">
</head>

<body>
    <div class="app-container">
        <div id="sidebar">
            <h2>WebGIS Manajemen Spasial Kota Pontianak</h2>
            <h4>Tugas 02 SIG: Manajemen Data Polyline (Jalan) & Polygon (Parsil)</h4>

            <h4>Pencarian Data</h4>
            <div class="search-container">
                <input type="text" id="searchInput" placeholder="Cari SPBU, Jalan, Parsil..."
                    onkeypress="handleEnter(event)">
                <button onclick="cariData()">Cari Lokasi</button>
            </div>

            <h4>Alat Digitasi</h4>
            <div id="drawControlWrapper"></div>
        </div>

        <div id="map"></div>
    </div>

    <script>
        const DATA_SPBU = <?php
        // Pemanggilan data dari PHP (Backend) sebelum file JS dimuat
        $query = mysqli_query($koneksi, "SELECT id, nama_spbu as nama, no_wa as wa, buka_24 as buka, latitude as lat, longitude as lng FROM spbu");
        $data = [];
        if ($query) {
            while ($row = mysqli_fetch_assoc($query)) {
                $row['lat'] = (float) $row['lat'];
                $row['lng'] = (float) $row['lng'];
                $data[] = $row;
            }
        }
        echo json_encode($data);
        ?>;
    </script>

    <script src="script.js"></script>
</body>

</html>