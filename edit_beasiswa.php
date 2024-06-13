<?php
header('Content-Type: application/json');

// Establish database connection
$koneksi = new mysqli('localhost', 'root', '', 'beasiswa');

// Check if connection is successful
if ($koneksi->connect_error) {
    die("Connection failed: " . $koneksi->connect_error);
}

// Retrieve POST data
$id_beasiswa = $_POST['id_beasiswa'];
$nama = $_POST['nama'];
$deskripsi = $_POST['deskripsi'];

// Validate POST data
if (!isset($id_beasiswa) || !isset($nama) || !isset($deskripsi)) {
    echo json_encode([
        'pesan' => 'Data tidak lengkap'
    ]);
    exit;
}

// Update data in database
$query = "UPDATE beasiswa SET nama=?, deskripsi=? WHERE id_beasiswa=?";
$stmt = $koneksi->prepare($query);
$stmt->bind_param("ssi", $nama, $deskripsi, $id_beasiswa);
$result = $stmt->execute();

// Check if update was successful
if ($result) {
    echo json_encode([
        'pesan' => 'Sukses Update'
    ]);
} else {
    echo json_encode([
        'pesan' => 'Gagal Update'
    ]);
}

// Close statement and connection
$stmt->close();
$koneksi->close();
?>
