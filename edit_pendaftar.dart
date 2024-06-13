import 'package:app_beasiswa1/halaman_beasiswa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPendaftar extends StatefulWidget {
  final Map ListData;
  const EditPendaftar({super.key, required this.ListData});

  @override
  State<EditPendaftar> createState() => _EditPendaftarState();
}

class _EditPendaftarState extends State<EditPendaftar> {
  final formkey = GlobalKey<FormState>();
  TextEditingController status_pendaftaran = TextEditingController();
  
  Future _ubah() async {
    final respon = 
        await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/edit_pendaftar.php'),
        body: {
          'status_pendaftaran':status_pendaftaran.text,
        });
        if (respon.statusCode == 200) {
          return true;
        }
        return false;
  }
  @override
  Widget build(BuildContext context) {
    status_pendaftaran.text = widget.ListData['status_pendaftaran'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pendaftaran'),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: status_pendaftaran,
                decoration: InputDecoration(hintText: 'Status Pendaftaran',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Status Pendaftaran tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                )),
                onPressed: () {
                if(formkey.currentState!.validate()) {
                  _ubah().then((value) {
                    if(value) {
                      final snackBar = SnackBar(content: const Text
                      ('Data Berhasil Diubah'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    } else {
                      final snackBar = SnackBar(content: const Text
                      ('Data Gagal Diubah'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    }
                  });
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: ((context)=> HalamanBeasiswa())),
                      (route) => false);
                }
              }, child: Text('Update'))
            ],
          ),
        )),
    );
  }
}