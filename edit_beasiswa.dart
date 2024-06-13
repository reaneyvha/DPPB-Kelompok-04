import 'dart:convert';
import 'package:app_beasiswa1/halaman_list_beasiswa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditBeasiswa extends StatefulWidget {
  final Map ListData;
  const EditBeasiswa({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditBeasiswa> createState() => _EditBeasiswaState();
}

class _EditBeasiswaState extends State<EditBeasiswa> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController deskripsi = TextEditingController();

  @override
  void initState() {
    super.initState();
    nama.text = widget.ListData['nama'];
    deskripsi.text = widget.ListData['deskripsi'];
  }

  Future<bool> _ubah() async {
    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2/API_BEASISWA/edit_beasiswa.php'),
        body: {
          'id_beasiswa': widget.ListData['id_beasiswa'].toString(),  // Tambahkan id_beasiswa
          'nama': nama.text,
          'deskripsi': deskripsi.text,
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        return result['pesan'] == 'Sukses Update';
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Beasiswa'),
      ),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama beasiswa tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: deskripsi,
                decoration: InputDecoration(
                  hintText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Deskripsi Beasiswa tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _ubah().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value
                            ? 'Data Berhasil Diubah'
                            : 'Data Gagal Diubah'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      if (value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: ((context) =>
                                HalamanUnggahBeasiswa()),  // Pastikan ini adalah halaman yang benar
                          ),
                          (route) => false,
                        );
                      }
                    });
                  }
                },
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
