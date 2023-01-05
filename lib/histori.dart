import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:project_3/api.dart';
import 'package:project_3/login.dart';

class histori extends StatefulWidget {
  const histori({super.key});

  @override
  State<histori> createState() => _historiState();
}

Future<List> getDatariwa() async {
  final response = await http.post(Uri.parse(riw), body: {
    "user": finaluser,
  });
  return jsonDecode(response.body);
}

class _historiState extends State<histori> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: FutureBuilder<List>(
            future: getDatariwa(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Text("error bre");
              }
              return snapshot.hasData
                  ? ItemList(
                      list: snapshot.data ?? [],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
        onRefresh: () {
          // getDataBanner();
          // getDataterlaris();
          // getDataterfavorit();
          // getDataTerdekat();
          // getDataceklike();
          return Navigator.pushReplacementNamed(context, '/vou');
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 254, 254, 254),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 6),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 70.0,
                                height: 70.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    '$imgProf${list[i]['gambar_toko']}',
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${list[i]['Nama_toko']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          child: Text(
                                        '${list[i]['Kode_Transaksi']}',
                                        style: TextStyle(color: Colors.black54),
                                      )),
                                    ],
                                  ),
                                  Container(
                                    child: Text(
                                      '${list[i]['Tanggal_transaksi']}',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Pesanan Selesai',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        );
      },
    );
  }
}
