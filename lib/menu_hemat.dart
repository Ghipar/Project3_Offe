import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:project_3/api.dart';
import 'package:project_3/cart_model.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/cart_screen.dart';
import 'package:project_3/db_helper.dart';
import 'package:project_3/menu.dart';
import 'package:provider/provider.dart';

DBHelper? dbHelper = DBHelper();
CartProvider? crt = CartProvider();

class Paket extends StatelessWidget {
  final List list;
  const Paket({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Column(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                      onTap: () {
                        dbHelper!
                            .insert(
                          Cart(
                              id: list[i]['Kode_Menu'],
                              productId: list[i]['Kode_Menu'],
                              productName: list[i]['Nama_Menu'].toString(),
                              initialPrice: int.parse(list[i]['Harga']),
                              productPrice: int.parse(list[i]['Harga']),
                              quantity: 1,
                              unitTag: list[i]['katagori_menu'],
                              image: list[i]['gambar'].toString()),
                        )
                            .then((value) {
                          print('Product add to cart');
                          cart.addTotalPrice(
                            double.parse(list[i]['Harga'].toString()),
                          );
                          cart.addCounter();
                        }).onError((error, stackTrace) {
                          print(error.toString());
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                    '$imgProf${list[i]['gambar']}'),
                                height: 180,
                                width: 500,
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.0,
                                top: 16.0,
                                right: 20.0,
                                bottom: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 250,
                                  child: Text(
                                    '${list[i]['Nama_Menu']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                    child: Text(
                                  'Rp ${list[i]['Harga']}',
                                )),
                                Container(
                                  width: 250,
                                  child: Text(
                                    '${list[i]['deskripsi']}',
                                    style: TextStyle(color: Colors.black54),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                    child: Text(
                                  'Caffe : ${list[i]['Nama_toko']}',
                                  // style: TextStyle(
                                  //     // color: Colors.redAccent,
                                  //     fontWeight: FontWeight.bold),
                                )),
                                Container(
                                    padding: EdgeInsets.only(left: 250),
                                    child: TextButton(
                                        onPressed: () {
                                          showAlertDialogc(
                                              BuildContext context) {
                                            // set up the button

                                            // set up the AlertDialog
                                            AlertDialog alert = AlertDialog(
                                              title: Text("Detail deskripsi"),
                                              content: Text(
                                                  "${list[i]['deskripsi']}"),
                                              actions: [],
                                            );
                                            // show the dialog
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          }

                                          showAlertDialogc(context);
                                        },
                                        child: Text('Detail'))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}

class hemat extends StatefulWidget {
  const hemat({super.key});

  @override
  State<hemat> createState() => _hematState();
}

Future<List> getDatahmt() async {
  final response = await http.post(Uri.parse(pktallapi));
  var data = jsonDecode(response.body);

  return data;
}

class _hematState extends State<hemat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            dbHelper!.clearCartItem();
            cart!.fremoveCounter();
            cart!.fremoveTotalPrice();
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: ((context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: TextStyle(color: Colors.white),
                  );
                }),
              ),
              animationDuration: Duration(milliseconds: 300),
              // position: const BadgePosition(start: 30, bottom: 30),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
        toolbarHeight: 65,
        title: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      'Menu hemat',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Text(
                    'Cobain menu hemat dari kami:)',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
      body: RefreshIndicator(
        child: FutureBuilder<List>(
            future: getDatahmt(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Text("error bre");
              }
              return snapshot.hasData
                  ? Paket(
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
          return Navigator.pushReplacementNamed(context, '/hmt');
        },
      ),
    );
  }
}
