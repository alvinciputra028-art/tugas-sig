<?php
include "../congif/koneksi.php";

$id = $_POST['id'];
$lat = $_POST['lat'];
$lng = $_POST['lng'];
mysqli_query($koneksi, "UPDATE spbu SET latitude='$lat', longitude='$lng' WHERE id='$id'");
?>