<?php
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');
$keterangan = $_POST['keterangan'];
$tanggal = date('Y-m-d', strtotime($_POST['tanggal'])); // Convert date to 'YYYY-MM-DD' format
$waktu = date('H:i:s', strtotime($_POST['waktu'])); // Convert time to 'HH:MM:SS' format
$tempat = $_POST['tempat'];
$data = mysqli_query($koneksi, "insert into jadwal_interview set
keterangan='$keterangan', tanggal='$tanggal', waktu='$waktu', tempat='$tempat'");
if ($data) {
    echo json_encode([
        'pesan' => 'Sukses'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal'
    ]);
}
?>
