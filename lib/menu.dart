import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'package:project_3/api.dart';
import 'package:project_3/cart_model.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/cart_screen.dart';
import 'package:project_3/db_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class menu extends StatefulWidget {
  List list;
  int index;
  menu({required this.index, required this.list});

  @override
  State<menu> createState() => _menuState();
}

var g = 2;
DBHelper dbHelper = DBHelper();

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Makanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              ],
            ),
            Container(
              height: 290,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10.0, right: 5.0),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: InkWell(
                                onTap: () {
                                  dbHelper
                                      .insert(
                                    Cart(
                                        id: i,
                                        productId: i.toString(),
                                        productName:
                                            list[i]['Nama_Menu'].toString(),
                                        initialPrice:
                                            int.parse(list[i]['Harga']),
                                        productPrice:
                                            int.parse(list[i]['Harga']),
                                        quantity: 1,
                                        unitTag: list[i]['Nama_Menu'],
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
                                          height: 100,
                                          width: 185,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['Nama_Menu']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                  child: Text(
                                                'Rp ${list[i]['Harga']}',
                                              )),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['deskripsi']}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(left: 85),
                                              child: TextButton(
                                                  onPressed: () {
                                                    showAlertDialogc(
                                                        BuildContext context) {
                                                      // set up the button

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text(
                                                            "Detail deskripsi"),
                                                        content: Text(
                                                            "${list[i]['deskripsi']}"),
                                                        actions: [],
                                                      );
                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    }

                                                    showAlertDialogc(context);
                                                  },
                                                  child: Text('Detail'))),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Minuman',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              ],
            ),
            Container(
              height: 290,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10.0, right: 5.0),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: InkWell(
                                onTap: () {
                                  print('hola');
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
                                          height: 100,
                                          width: 185,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['Nama_Menu']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Container(
                                                  child: Text(
                                                'Rp ${list[i]['Harga']}',
                                              )),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['deskripsi']}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),

                                          Container(
                                              padding:
                                                  EdgeInsets.only(left: 85),
                                              child: TextButton(
                                                  onPressed: () {
                                                    showAlertDialogc(
                                                        BuildContext context) {
                                                      // set up the button

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text(
                                                            "Detail deskripsi"),
                                                        content: Text(
                                                            "${list[i]['deskripsi']}"),
                                                      );
                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    }

                                                    showAlertDialogc(context);
                                                  },
                                                  child: Text('Detail'))),

                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //         padding: EdgeInsets.only(
                                          //           bottom: 3.0,
                                          //           left: 15.0,
                                          //         ),
                                          //         child: LikeButton(
                                          //           isLiked: terdekat[i]
                                          //                       ['like_status'] ==
                                          //                   ''
                                          //               ? false
                                          //               : true,
                                          //           size: 25,
                                          //           likeCount: int.parse(
                                          //               terdekat[i]['like_count']),
                                          //           onTap: (isLiked) async {
                                          //             final SharedPreferences
                                          //                 sharedPreferences =
                                          //                 await SharedPreferences
                                          //                     .getInstance();
                                          //             sharedPreferences.setString(
                                          //                 'kd',
                                          //                 terdekat[i]['Kode_Toko']);
                                          //             final SharedPreferences
                                          //                 sharedPreferences1 =
                                          //                 await SharedPreferences
                                          //                     .getInstance();
                                          //             var kode = sharedPreferences1
                                          //                 .getString('kd');
                                          //             kodto = kode;
                                          //             print(kodto);
                                          //             isLiked == false
                                          //                 ? getDataceklike() //nambah
                                          //                 : getDataceklike(); //kurang

                                          //             return !isLiked;
                                          //           },
                                          //         )),
                                          //     SizedBox(
                                          //       width: 20,
                                          //     ),
                                          //     Container(
                                          //       padding:
                                          //           EdgeInsets.only(bottom: 3.0),
                                          //       child: Icon(
                                          //         Icons.star,
                                          //         color: Colors.orange,
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       padding: EdgeInsets.only(left: 5.0),
                                          //       child: Text('4,5'),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Paket hemat',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )
              ],
            ),
            Container(
              height: 290,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10.0, right: 5.0),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: InkWell(
                                onTap: () {
                                  print('hola');
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
                                          height: 100,
                                          width: 185,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['Nama_Menu']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),

                                          Row(
                                            children: [
                                              Container(
                                                  child: Text(
                                                'Rp ${list[i]['Harga']}',
                                              )),
                                            ],
                                          ),
                                          Container(
                                            width: 140,
                                            child: Text(
                                              '${list[i]['deskripsi']}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),

                                          Container(
                                              padding:
                                                  EdgeInsets.only(left: 85),
                                              child: TextButton(
                                                  onPressed: () {
                                                    showAlertDialogc(
                                                        BuildContext context) {
                                                      // set up the button

                                                      // set up the AlertDialog
                                                      AlertDialog alert =
                                                          AlertDialog(
                                                        title: Text(
                                                            "Detail deskripsi"),
                                                        content: Text(
                                                            "${list[i]['deskripsi']}"),
                                                      );
                                                      // show the dialog
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return alert;
                                                        },
                                                      );
                                                    }

                                                    showAlertDialogc(context);
                                                  },
                                                  child: Text('Detail'))),

                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Container(
                                          //         padding: EdgeInsets.only(
                                          //           bottom: 3.0,
                                          //           left: 15.0,
                                          //         ),
                                          //         child: LikeButton(
                                          //           isLiked: terdekat[i]
                                          //                       ['like_status'] ==
                                          //                   ''
                                          //               ? false
                                          //               : true,
                                          //           size: 25,
                                          //           likeCount: int.parse(
                                          //               terdekat[i]['like_count']),
                                          //           onTap: (isLiked) async {
                                          //             final SharedPreferences
                                          //                 sharedPreferences =
                                          //                 await SharedPreferences
                                          //                     .getInstance();
                                          //             sharedPreferences.setString(
                                          //                 'kd',
                                          //                 terdekat[i]['Kode_Toko']);
                                          //             final SharedPreferences
                                          //                 sharedPreferences1 =
                                          //                 await SharedPreferences
                                          //                     .getInstance();
                                          //             var kode = sharedPreferences1
                                          //                 .getString('kd');
                                          //             kodto = kode;
                                          //             print(kodto);
                                          //             isLiked == false
                                          //                 ? getDataceklike() //nambah
                                          //                 : getDataceklike(); //kurang

                                          //             return !isLiked;
                                          //           },
                                          //         )),
                                          //     SizedBox(
                                          //       width: 20,
                                          //     ),
                                          //     Container(
                                          //       padding:
                                          //           EdgeInsets.only(bottom: 3.0),
                                          //       child: Icon(
                                          //         Icons.star,
                                          //         color: Colors.orange,
                                          //       ),
                                          //     ),
                                          //     Container(
                                          //       padding: EdgeInsets.only(left: 5.0),
                                          //       child: Text('4,5'),
                                          //     )
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        )
      ],
    );
  }
}

class _menuState extends State<menu> {
  Future<List> getDatamenu() async {
    final response = await http.post(Uri.parse(menuapi), body: {
      "store_id": widget.list[widget.index]['Kode_Toko'],
    });
    var data = jsonDecode(response.body);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        centerTitle: true,
        title: Column(
          children: [
            Text("${widget.list[widget.index]['Nama_toko']}",
                style: TextStyle(fontSize: 20)),
            Text(
              '${widget.list[widget.index]['distance']} Km',
              style: TextStyle(
                fontSize: 15,
              ),
            )
          ],
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
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: RefreshIndicator(
        child: FutureBuilder<List>(
            future: getDatamenu(),
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
          return Navigator.pushReplacementNamed(context, '/laris');
        },
      ),
    );
  }
}
