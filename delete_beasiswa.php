<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$id_beasiswa = $_POST['id_beasiswa'];
$data = mysqli_query($koneksi, "delete from beasiswa where id_beasiswa='$id_beasiswa'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses Delete'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal Delete'
    ]);
}
