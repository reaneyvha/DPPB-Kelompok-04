import 'dart:convert';

import 'package:app_beasiswa1/detail_pendaftar.dart';
import 'package:app_beasiswa1/edit_pendaftar.dart';
import 'package:app_beasiswa1/halaman_daftar_beasiswa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanBeasiswa extends StatefulWidget {
  const HalamanBeasiswa({super.key});

  @override
  State<HalamanBeasiswa> createState() => _HalamanBeasiswaState();
}

class _HalamanBeasiswaState extends State<HalamanBeasiswa> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http.get(Uri.parse('http://172.20.10.2/API_BEASISWA/read_daftar_beasiswa.php'));
          if (respon.statusCode == 200){
            final data = jsonDecode(respon.body);
            setState((){
              _listdata = data;
              _loading = false;
            });
          } 
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respon = await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/delete_pendaftar.php'), body: {
        "id_pendaftaran": id,
      });
          if (respon.statusCode == 200){
            return true;
          } else {
            return false;
          }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    _getdata();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Halaman Beasiswa'),
        backgroundColor: Colors.redAccent,
      ),
      body: _loading ? Center(
        child: CircularProgressIndicator(),
      )
      :ListView.builder(
        itemCount: _listdata.length,
        itemBuilder: ((context, index) {
          return Card(
            child: InkWell(
              onTap: (){
                Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => DetailPendaftar(
              ListData: {
                'id_pendaftaran':_listdata[index]['id_pendaftaran'],
                'nama':_listdata[index]['nama'],
                'email':_listdata[index]['email'],
                'ipk':_listdata[index]['ipk'],
                'jurusan':_listdata[index]['jurusan'],
                'jenis_kelamin':_listdata[index]['jenis_kelamin'],
                'semester':_listdata[index]['semester'],
                'tgl_lahir':_listdata[index]['tgl_lahir'],
                'status_pendaftaran':_listdata[index]['status_pendaftaran'],
              },
            ))
          );
              },
              child: ListTile(
                title: Text(_listdata[index]['nama']),
                subtitle: Text(_listdata[index]['status_pendaftaran']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPendaftar(
                              ListData: {
                                'status_pendaftaran':_listdata[index]['status_pendaftaran'],
                              },
                            )
                          ));
                      },
                      icon: Icon(Icons.edit)),
                      IconButton(onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                        builder: ((context){
                          return AlertDialog(
                            content: Text('Hapus data ini ?'),
                            actions: [
                              ElevatedButton(onPressed: () {
                                _hapus(_listdata[index]
                                ['id_pendaftaran']).then
                                ((value){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder: ((context)=>HalamanBeasiswa())),
                                    (route) => false);
                                });
                              },
                              style: ElevatedButton.
                              styleFrom(
                                backgroundColor: Colors.redAccent
                              ),
                              child: Text('Hapus')),
                              ElevatedButton(onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.
                              styleFrom(
                                backgroundColor: Colors.redAccent
                              ),
                              child: Text('Batal')),
                            ],
                          );
                        }));
                      }, icon: Icon(Icons.delete))
                  ],
                ),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('+',
        style: TextStyle(fontSize: 24),),
        onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => DaftarBeasiswa
          ()));
      }),
    );
  }
}