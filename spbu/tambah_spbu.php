<?php
include "../config/koneksi.php";

$nama = $_POST['nama_spbu'];
$wa = $_POST['no_wa'];
$buka = $_POST['buka_24'];
$lat = $_POST['latitude'];
$lng = $_POST['longitude'];

$query = "INSERT INTO spbu (nama_spbu, no_wa, buka_24, latitude, longitude) 
          VALUES ('$nama', '$wa', '$buka', '$lat', '$lng')";

if(mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success', 'id' => mysqli_insert_id($koneksi)]);
} else {
    echo json_encode(['status' => 'error', 'message' => mysqli_error($koneksi)]);
}
?>