<?php
include "../config/koneksi.php";

$id = $_POST['id'];
$nama = $_POST['nama'];
$status = $_POST['status'];

$query = "UPDATE jalan SET nama_jalan='$nama', status_jalan='$status' WHERE id='$id'";
if(mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>