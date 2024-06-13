import 'package:flutter/material.dart';

class DetailInterview extends StatefulWidget {
  final Map ListData;
  DetailInterview({Key? key, required this.ListData}):super(key: key);
  // const DetailInterview({super.key});

  @override
  State<DetailInterview> createState() => _DetailInterviewState();
}

class _DetailInterviewState extends State<DetailInterview> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_jadwal = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController tempat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    id_jadwal.text = widget.ListData['id_jadwal'];
    keterangan.text = widget.ListData['keterangan'];
    tanggal.text = widget.ListData['tanggal'];
    waktu.text = widget.ListData['waktu'];
    tempat.text = widget.ListData['tempat'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jadwal'),
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
                  title: Text('ID Jadwal'),
                  subtitle: Text(widget.ListData['id_jadwal']),
                ),
                ListTile(
                  title: Text('Keterangan'),
                  subtitle: Text(widget.ListData['keterangan']),
                ),
                ListTile(
                  title: Text('Tanggal'),
                  subtitle: Text(widget.ListData['tanggal']),
                ),
                ListTile(
                  title: Text('Waktu'),
                  subtitle: Text(widget.ListData['waktu']),
                ),
                ListTile(
                  title: Text('Tempat'),
                  subtitle: Text(widget.ListData['tempat']),
                ),
              ]),
          ),
        ),
      ),
    );
  }
}