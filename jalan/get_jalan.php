<?php
include "../config/koneksi.php";

$q = mysqli_query($koneksi, "SELECT * FROM jalan");
$features = [];

while($row = mysqli_fetch_assoc($q)) {
    // GeoJSON menggunakan format [longitude, latitude]
    // Kita perlu membalik urutan jika di database tersimpan sebagai [lat, lng]
    $raw_coords = json_decode($row['koordinat']);
    $formatted_coords = [];
    foreach($raw_coords as $c) {
        $formatted_coords[] = [$c->lng, $c->lat]; 
    }

    $features[] = [
        "type" => "Feature",
        "geometry" => [
            "type" => "LineString",
            "coordinates" => $formatted_coords
        ],
        "properties" => [
            "id" => $row['id'],
            "nama" => $row['nama_jalan'],
            "status" => $row['status_jalan'],
            "panjang" => $row['panjang_jalan']
        ]
    ];
}

$geojson = ["type" => "FeatureCollection", "features" => $features];
echo json_encode($geojson);
?>