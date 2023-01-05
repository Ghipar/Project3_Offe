import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:project_3/api.dart';
import 'package:project_3/login.dart';

class pickup extends StatefulWidget {
  const pickup({super.key});

  @override
  State<pickup> createState() => _pickupState();
}

Future<List> getDatariwa() async {
  final response = await http.post(Uri.parse(pikup), body: {
    "user": finaluser,
  });
  return jsonDecode(response.body);
}

Future<List> getbatal(String kd) async {
  final response = await http.post(Uri.parse(tal), body: {
    "trans": kd,
  });
  return jsonDecode(response.body);
}

class _pickupState extends State<pickup> {
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
          return Navigator.pushReplacementNamed(context, '/pu');
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
                              SizedBox(
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: '${list[i]['Nama_toko']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: '${list[i]['Kode_Transaksi']}',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: '${list[i]['Tanggal_transaksi']}',
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    RichText(
                                        text: list[i]['statust_trans'] == '0'
                                            ? TextSpan(
                                                text: 'Menunggu Konfirmasi',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : TextSpan(
                                                text: 'Sedang Diproses',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: list[i]['statust_trans'] == '0'
                                ? () {
                                    showAlertDialogtal(
                                        context, list[i]['Kode_Transaksi']);
                                  }
                                : null,
                            child: Container(
                                width: 40,
                                decoration: BoxDecoration(
                                    color: list[i]['statust_trans'] == '0'
                                        ? Colors.red
                                        : Colors.grey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )),
                          )
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

showAlertDialogtal(BuildContext context, String tran) {
  // set up the buttons

  Widget continueButton = TextButton(
    child: Text("yakin"),
    onPressed: () {
      getbatal(tran);
      Navigator.pushReplacementNamed(context, '/pu');
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Peringatan!!",
    ),
    content: Text("Anda yakin ingin membatalkan?"),
    actions: [
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
