<?php
include "../config/koneksi.php";

$id = $_POST['id'];
$nama = $_POST['nama'];
$wa = $_POST['wa'];
$buka = $_POST['buka'];

$query = "UPDATE spbu SET nama_spbu='$nama', no_wa='$wa', buka_24='$buka' WHERE id='$id'";
if(mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>