import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UnggahBeasiswa extends StatefulWidget {
  const UnggahBeasiswa({super.key});

  @override
  State<UnggahBeasiswa> createState() => _UnggahBeasiswaState();
}

class _UnggahBeasiswaState extends State<UnggahBeasiswa> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  
  Future _simpan() async {
    final respon = 
        await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/unggah_beasiswa.php'),
        body: {
          'nama':nama.text,
          'deskripsi':deskripsi.text,
        });
        if (respon.statusCode == 200) {
          return true;
        }
        return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unggah Beasiswa'),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                decoration: InputDecoration(hintText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: deskripsi,
                decoration: InputDecoration(hintText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Deskripsi tidak boleh kosong!";
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
                  _simpan().then((value) {
                    if(value) {
                      final snackBar = SnackBar(content: const Text
                      ('Unggah Sukses'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    } else {
                      final snackBar = SnackBar(content: const Text
                      ('Unggah Gagal'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    }
                  });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: ((context)=>UnggahBeasiswa())),
                      (route) => false);
                }
              }, child: Text('Unggah'))
            ],
          ),
        )),
    );
  }
}