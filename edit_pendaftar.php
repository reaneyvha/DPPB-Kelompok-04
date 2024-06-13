<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$id_pendaftaran = $_POST['id_pendaftaran'];
$status_pendaftaran = $_POST['status_pendaftaran'];
$data = mysqli_query($koneksi, "update pendaftaran set
status_pendaftaran='$status_pendaftaran' where id_pendaftaran='$id_pendaftaran");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses Update'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal Update'
    ]);
}
