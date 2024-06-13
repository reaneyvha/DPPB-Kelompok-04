import 'dart:convert';

import 'package:app_beasiswa1/halaman_detail_jadwal.dart';
import 'package:app_beasiswa1/halaman_input_jadwal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HalamanJadwal extends StatefulWidget {
  const HalamanJadwal({super.key});

  @override
  State<HalamanJadwal> createState() => _HalamanJadwalState();
}

class _HalamanJadwalState extends State<HalamanJadwal> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon = await http.get(Uri.parse('http://172.20.10.2/API_BEASISWA/read_jadwal.php'));
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
      final respon = await http.post(Uri.parse('http://172.20.10.2/API_BEASISWA/delete_jadwal.php'), body: {
        "id_jadwal": id,
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
        title: Text ('Halaman Jadwal Interview'),
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
            builder: (context) => DetailInterview(
              ListData: {
                'id_jadwal':_listdata[index]['id_jadwal'],
                'keterangan':_listdata[index]['keterangan'],
                'tanggal':_listdata[index]['tanggal'],
                'waktu':_listdata[index]['waktu'],
                'tempat':_listdata[index]['tempat'],
              },
            ))
          );
              },
              child: ListTile(
                title: Text(_listdata[index]['keterangan']),
                subtitle: Text(_listdata[index]['tanggal']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                                ['id_jadwal']).then
                                ((value){
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                    builder: ((context)=>HalamanJadwal())),
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
          context, MaterialPageRoute(builder: (context) => InputJadwal
          ()));
      }),
    );
  }
}