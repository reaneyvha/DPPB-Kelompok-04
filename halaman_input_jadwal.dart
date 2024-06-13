import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InputJadwal extends StatefulWidget {
  const InputJadwal({super.key});

  @override
  State<InputJadwal> createState() => _InputJadwalState();
}

class _InputJadwalState extends State<InputJadwal> {
  final formkey = GlobalKey<FormState>();
  TextEditingController keterangan = TextEditingController();
  TextEditingController tanggal = TextEditingController();
  TextEditingController waktu = TextEditingController();
  TextEditingController tempat = TextEditingController();
  
  Future _simpan() async {
    final respon = 
        await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/input_jadwal.php'),
        body: {
          'keterangan':keterangan.text,
          'tanggal':tanggal.text,
          'waktu':waktu.text,
          'tempat':tempat.text,
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
        title: Text('Input Jadwal'),
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: keterangan,
                decoration: InputDecoration(hintText: 'Keterangan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Keterangan tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tanggal,
                decoration: InputDecoration(hintText: 'Tanggal',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Tanggal tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: waktu,
                decoration: InputDecoration(hintText: 'Waktu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Waktu tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tempat,
                decoration: InputDecoration(hintText: 'Tempat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Tempat tidak boleh kosong!";
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
                      ('Pendaftaran Sukses'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    } else {
                      final snackBar = SnackBar(content: const Text
                      ('Pendaftaran Gagal'),);
                      ScaffoldMessenger.of(context).showSnackBar
                      (snackBar);
                    }
                  });
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: ((context)=>InputJadwal())),
                      (route) => false);
                }
              }, child: Text('Input'))
            ],
          ),
        )),
    );
  }
}