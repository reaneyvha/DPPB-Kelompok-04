import 'package:flutter/material.dart';

class DetailListBeasiswa extends StatefulWidget {
  final Map ListData;
  DetailListBeasiswa({Key? key, required this.ListData}):super(key: key);
  // const DetailListBeasiswa({super.key});

  @override
  State<DetailListBeasiswa> createState() => _DetailListBeasiswaState();
}

class _DetailListBeasiswaState extends State<DetailListBeasiswa> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_beasiswa = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_beasiswa.text = widget.ListData['id_beasiswa'];
    nama.text = widget.ListData['nama'];
    deskripsi.text = widget.ListData['deskripsi'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Beasiswa'),
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
                  title: Text('ID Beasiswa'),
                  subtitle: Text(widget.ListData['id_beasiswa']),
                ),
                ListTile(
                  title: Text('Nama'),
                  subtitle: Text(widget.ListData['nama']),
                ),
                ListTile(
                  title: Text('Deskripsi'),
                  subtitle: Text(widget.ListData['deskripsi']),
                ),
              ]),
          ),
        ),
      ),
    );
  }
}