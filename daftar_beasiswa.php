<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$nama = $_POST['nama'];
$email = $_POST['email'];
$ipk = $_POST['ipk'];
$jurusan = $_POST['jurusan'];
$jenis_kelamin = $_POST['jenis_kelamin'];
$semester = $_POST['semester'];
$tgl_lahir = $_POST['tgl_lahir'];
$status_pendaftaran = $_POST['status_pendaftaran'];
$data = mysqli_query($koneksi, "insert into pendaftaran set
nama='$nama', email='$email', ipk='$ipk', jurusan='$jurusan', jenis_kelamin='$jenis_kelamin', semester='$semester', tgl_lahir='$tgl_lahir', status_pendaftaran='$status_pendaftaran'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
