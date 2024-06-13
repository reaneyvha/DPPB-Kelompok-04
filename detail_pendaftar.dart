import 'package:flutter/material.dart';

class DetailPendaftar extends StatefulWidget {
  final Map ListData;
  DetailPendaftar({Key? key, required this.ListData}):super(key: key);
  // const DetailPendaftar({super.key});

  @override
  State<DetailPendaftar> createState() => _DetailPendaftarState();
}

class _DetailPendaftarState extends State<DetailPendaftar> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_pendaftaran = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ipk = TextEditingController();
  TextEditingController jurusan = TextEditingController();
  TextEditingController jenis_kelamin = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController status_pendaftaran = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_pendaftaran.text = widget.ListData['id_pendaftaran'];
    nama.text = widget.ListData['nama'];
    email.text = widget.ListData['email'];
    ipk.text = widget.ListData['ipk'];
    jurusan.text = widget.ListData['jurusan'];
    jenis_kelamin.text = widget.ListData['jenis_kelamin'];
    semester.text = widget.ListData['semester'];
    tgl_lahir.text = widget.ListData['tgl_lahir'];
    status_pendaftaran.text = widget.ListData['status_pendaftaran'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pendaftar'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('ID Pendaftaran'),
                  subtitle: Text(widget.ListData['id_pendaftaran']),
                ),
                ListTile(
                  title: Text('Nama'),
                  subtitle: Text(widget.ListData['nama']),
                ),
                ListTile(
                  title: Text('Email'),
                  subtitle: Text(widget.ListData['email']),
                ),
                ListTile(
                  title: Text('IPK'),
                  subtitle: Text(widget.ListData['ipk']),
                ),
                ListTile(
                  title: Text('Jurusan'),
                  subtitle: Text(widget.ListData['jurusan']),
                ),
                ListTile(
                  title: Text('Jenis Kelamin'),
                  subtitle: Text(widget.ListData['jenis_kelamin']),
                ),
                ListTile(
                  title: Text('Semester'),
                  subtitle: Text(widget.ListData['semester']),
                ),
                ListTile(
                  title: Text('Tanggal Lahir'),
                  subtitle: Text(widget.ListData['tgl_lahir']),
                ),
                ListTile(
                  title: Text('Status Pendaftaran'),
                  subtitle: Text(widget.ListData['status_pendaftaran']),
                ),
              ]),
          ),
        ),
      ),
    );
  }
}