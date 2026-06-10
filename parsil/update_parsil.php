<?php
include "../config/koneksi.php";

$id = $_POST['id'];
$pemilik = $_POST['pemilik'];
$status = $_POST['status'];

$query = "UPDATE parsil SET nama_pemilik='$pemilik', status_kepemilikan='$status' WHERE id='$id'";
if(mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>