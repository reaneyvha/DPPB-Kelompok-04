import 'dart:convert';

import 'package:app_beasiswa1/edit_beasiswa.dart';
import 'package:app_beasiswa1/halaman_detail_beasiswa.dart';
import 'package:app_beasiswa1/halaman_unggah_beasiswa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanUnggahBeasiswa extends StatefulWidget {
  const HalamanUnggahBeasiswa({super.key});

  @override
  State<HalamanUnggahBeasiswa> createState() => _HalamanUnggahBeasiswaState();
}

class _HalamanUnggahBeasiswaState extends State<HalamanUnggahBeasiswa> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http.get(Uri.parse('http://172.20.10.2/API_BEASISWA/read_unggah_beasiswa.php'));
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
      final respon = await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/delete_beasiswa.php'), body: {
        "id_beasiswa": id,
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
            builder: (context) => DetailListBeasiswa(
              ListData: {
                'id_beasiswa':_listdata[index]['id_beasiswa'],
                'nama':_listdata[index]['nama'],
                'deskripsi':_listdata[index]['deskripsi'],
              },
            ))
          );
              },
              child: ListTile(
                title: Text(_listdata[index]['nama']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBeasiswa(
                              ListData: {
                                'id_beasiswa':_listdata[index]['id_beasiswa'],
                                'nama':_listdata[index]['nama'],
                                'deskripsi':_listdata[index]['deskripsi'],
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
                                ['id_beasiswa']).then
                                ((value){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder: ((context)=>HalamanUnggahBeasiswa())),
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
          context, MaterialPageRoute(builder: (context) => UnggahBeasiswa
          ()));
      }),
    );
  }
}