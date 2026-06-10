<?php
include "../config/koneksi.php";

$id = $_POST['id'];
$type = $_POST['type']; // Akan berisi 'jalan' atau 'parsil'
$nilai = $_POST['nilai']; // Akan berisi panjang (meter) atau luas (meter persegi) baru
$koordinat = $_POST['koordinat'];

if ($type === 'jalan') {
    $query = "UPDATE jalan SET panjang_jalan='$nilai', koordinat='$koordinat' WHERE id='$id'";
} else if ($type === 'parsil') {
    $query = "UPDATE parsil SET luas_tanah='$nilai', koordinat='$koordinat' WHERE id='$id'";
}

if (mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error', 'message' => mysqli_error($koneksi)]);
}
?>