<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$query = mysqli_query($koneksi, "select * from jadwal_interview");
$data = mysqli_fetch_all($query, MYSQLI_ASSOC);
echo json_encode($data);