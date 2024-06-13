<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$id_jadwal = $_POST['id_jadwal'];
$data = mysqli_query($koneksi, "delete from jadwal_interview where id_jadwal='$id_jadwal'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses Delete'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal Delete'
    ]);
}
