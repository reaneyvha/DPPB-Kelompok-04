<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$query = mysqli_query($koneksi, "select * from pendaftaran");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);