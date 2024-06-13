<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$nama = $_POST['nama'];
$deskripsi = $_POST['deskripsi'];
$data = mysqli_query($koneksi, "insert into beasiswa set
nama='$nama', deskripsi='$deskripsi'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
