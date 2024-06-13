import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DaftarBeasiswa extends StatefulWidget {
  const DaftarBeasiswa({super.key});

  @override
  State<DaftarBeasiswa> createState() => _DaftarBeasiswaState();
}

class _DaftarBeasiswaState extends State<DaftarBeasiswa> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController ipk = TextEditingController();
  TextEditingController jurusan = TextEditingController();
  TextEditingController jenis_kelamin = TextEditingController();
  TextEditingController semester = TextEditingController();
  TextEditingController tgl_lahir = TextEditingController();
  TextEditingController status_pendaftaran = TextEditingController();
  
  Future _simpan() async {
    final respon = 
        await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/daftar_beasiswa.php'),
        body: {
          'nama':nama.text,
          'email':email.text,
          'ipk':ipk.text,
          'jurusan':jurusan.text,
          'jenis_kelamin':jenis_kelamin.text,
          'semester':semester.text,
          'tgl_lahir':tgl_lahir.text,
          'status_pendaftaran':status_pendaftaran.text,
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
        title: Text('Daftar Beasiswa'),
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
                controller: email,
                decoration: InputDecoration(hintText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Email tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: ipk,
                decoration: InputDecoration(hintText: 'Ipk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Ipk tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jurusan,
                decoration: InputDecoration(hintText: 'Jurusan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Jurusan tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: jenis_kelamin,
                decoration: InputDecoration(hintText: 'Jenis Kelamin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Jenis Kelamin tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: semester,
                decoration: InputDecoration(hintText: 'Semester',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Semester tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tgl_lahir,
                decoration: InputDecoration(hintText: 'Tanggal Lahir',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                )),
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Tanggal Lahir tidak boleh kosong!";
                  }
                  return null;
                }
              ),
              SizedBox(height: 10),
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
                      builder: ((context)=>DaftarBeasiswa())),
                      (route) => false);
                }
              }, child: Text('Daftar'))
            ],
          ),
        )),
    );
  }
}