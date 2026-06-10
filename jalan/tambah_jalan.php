<?php
include "../config/koneksi.php";

$query = "INSERT INTO jalan (nama_jalan, status_jalan, panjang_jalan, koordinat) VALUES 
         ('".$_POST['nama']."', '".$_POST['status']."', '".$_POST['panjang']."', '".$_POST['koordinat']."')";
mysqli_query($koneksi, $query);
?>