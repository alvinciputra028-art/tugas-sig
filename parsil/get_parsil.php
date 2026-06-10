<?php
include "../config/koneksi.php";

// Set header agar browser tahu ini adalah file JSON
header('Content-Type: application/json');

$q = mysqli_query($koneksi, "SELECT * FROM parsil");
$features = [];

while($row = mysqli_fetch_assoc($q)) {
    $raw_coords = json_decode($row['koordinat']);
    $formatted_coords = [];

    // GeoJSON Polygon membutuhkan koordinat dalam array 3 lapis: [[[lng, lat], [lng, lat]]]
    // Kita ambil dari koordinat mentah dan balik urutannya ke [longitude, latitude]
    $polygon_ring = [];
    foreach($raw_coords as $c) {
        $polygon_ring[] = [(float)$c->lng, (float)$c->lat];
    }

    // Pastikan poligon tertutup (titik pertama sama dengan titik terakhir)
    if (!empty($polygon_ring) && ($polygon_ring[0] !== end($polygon_ring))) {
        $polygon_ring[] = $polygon_ring[0];
    }

    $features[] = [
        "type" => "Feature",
        "geometry" => [
            "type" => "Polygon",
            "coordinates" => [$polygon_ring] // Array bersarang untuk Polygon
        ],
        "properties" => [
            "id" => $row['id'],
            "pemilik" => $row['nama_pemilik'],
            "status" => $row['status_kepemilikan'],
            "luas" => $row['luas_tanah']
        ]
    ];
}

$geojson = [
    "type" => "FeatureCollection",
    "features" => $features
];

echo json_encode($geojson);
?>