<?php
include "../config/koneksi.php";

$id = $_GET['id'];
$query = "DELETE FROM parsil WHERE id = '$id'";
if(mysqli_query($koneksi, $query)) {
    echo json_encode(['status' => 'success']);
} else {
    echo json_encode(['status' => 'error']);
}
?>