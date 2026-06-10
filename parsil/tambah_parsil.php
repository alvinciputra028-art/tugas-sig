<?php
include "../config/koneksi.php";

$query = "INSERT INTO parsil (nama_pemilik, status_kepemilikan, luas_tanah, koordinat) VALUES 
         ('".$_POST['pemilik']."', '".$_POST['status']."', '".$_POST['luas']."', '".$_POST['koordinat']."')";
mysqli_query($koneksi, $query);
?>