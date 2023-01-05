import 'dart:convert';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_3/api.dart';
import 'package:project_3/cart_model.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/db_helper.dart';
import 'package:project_3/home.dart';
import 'package:project_3/login.dart';
import 'package:project_3/menu.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

TextEditingController pgm = new TextEditingController();
DBHelper? dbHelper = DBHelper();
CartProvider? crut = CartProvider();
var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);
var pengam;

class _CartScreenState extends State<CartScreen> {
  List<String> number = List.generate(5, (int index) => '$index');
  late String _item;
  @override
//  void initState() {
//    super.initState();
//    context.read<CartProvider>().getData();
//  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        centerTitle: true,
        title: Column(
          children: [
            Text("Keranjang", style: TextStyle(fontSize: 20)),
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
              child: Icon(Icons.shopping_cart),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          Image(image: AssetImage('assets/images/empty2.png')),
                          Text(
                            'Belum melakukan pesanan',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/pu');
                              },
                              child: Text('Lihat pick up'))
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot == null ? 0 : snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 5,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 254, 254, 254),
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      '$imgProf${snapshot.data![index].image}',
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
                                                  width: 130,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            text: 'Name: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${snapshot.data![index].productName.toString()}\n',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ]),
                                                      ),
                                                      RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            text: 'Unit: ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${snapshot.data![index].unitTag.toString()}\n',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ]),
                                                      ),
                                                      RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                            text:
                                                                'Price: ' r"Rp",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      '${snapshot.data![index].productPrice.toString()}\n',
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ]),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 85,
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 32, 204, 121),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity--;
                                                            int? newPrice =
                                                                price *
                                                                    quantity;
                                                            if (quantity > 0) {
                                                              dbHelper!
                                                                  .updateQuantity(Cart(
                                                                      id: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id,
                                                                      productId: snapshot
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      productName: snapshot
                                                                          .data![
                                                                              index]
                                                                          .productName,
                                                                      initialPrice: snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice,
                                                                      productPrice:
                                                                          newPrice,
                                                                      quantity:
                                                                          quantity,
                                                                      unitTag: snapshot
                                                                          .data![
                                                                              index]
                                                                          .unitTag!
                                                                          .toString(),
                                                                      image: snapshot
                                                                          .data![
                                                                              index]
                                                                          .image
                                                                          .toString()))
                                                                  .then(
                                                                      (value) {
                                                                newPrice = 0;
                                                                quantity = 0;
                                                                cart.removeTotalPrice(
                                                                    double.parse(snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!
                                                                        .toString()));
                                                              }).onError((error,
                                                                      stackTrace) {
                                                                print(error
                                                                    .toString());
                                                              });
                                                            }
                                                            ;
                                                          },
                                                          child: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          '${snapshot.data![index].quantity.toString()}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            int quantity =
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .quantity!;
                                                            int price = snapshot
                                                                .data![index]
                                                                .initialPrice!;
                                                            quantity++;
                                                            int? newPrice =
                                                                price *
                                                                    quantity;

                                                            dbHelper!
                                                                .updateQuantity(Cart(
                                                                    id: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id,
                                                                    productId: snapshot
                                                                        .data![
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    productName: snapshot
                                                                        .data![
                                                                            index]
                                                                        .productName,
                                                                    initialPrice: snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice,
                                                                    productPrice:
                                                                        newPrice,
                                                                    quantity:
                                                                        quantity,
                                                                    unitTag: snapshot
                                                                        .data![
                                                                            index]
                                                                        .unitTag!
                                                                        .toString(),
                                                                    image: snapshot
                                                                        .data![
                                                                            index]
                                                                        .image
                                                                        .toString()))
                                                                .then((value) {
                                                              newPrice = 0;
                                                              quantity = 0;
                                                              cart.addTotalPrice(
                                                                  double.parse(snapshot
                                                                      .data![
                                                                          index]
                                                                      .initialPrice!
                                                                      .toString()));
                                                            }).onError((error,
                                                                    stackTrace) {
                                                              print(error
                                                                  .toString());
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      dbHelper!.deleteCartItem(
                                                          snapshot.data![index]
                                                              .id!);

                                                      cart.removeCounter();
                                                      cart.removeTotalPrice(
                                                          double.parse(snapshot
                                                              .data![index]
                                                              .productPrice
                                                              .toString()));
                                                    },
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       print(snapshot.data![index].productName
                              //           .toString());
                              //     },
                              //     child: Text('Klik'))
                            ],
                          );
                        },
                      ),
                    );
                  }
                } else {}
                return Text('data');
              }),
          Container(
              padding: EdgeInsets.all(10.0),
              child: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Visibility(
                    visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                        ? false
                        : true,
                    child: Column(
                      children: [
                        TextField(
                          controller: pgm,
                          decoration: InputDecoration(
                              labelText: 'Alamat', hintText: 'Masukkan alamat'),
                        ),
                        DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: [
                            "Dine inn",
                            "Take away",
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Pengambilan",
                              hintText: "Piih pengambilan anda",
                            ),
                          ),
                          onChanged: (value) {
                            //print(value);
                            pengam = value;
                          },
                        ),
                        ReusableWidget(
                            title: 'Grand Total',
                            value: r'Rp ' +
                                value.getTotalPrice().toStringAsFixed(2)),
                      ],
                    ),
                  );
                },
              ))
        ],
      ),
      bottomNavigationBar: InkWell(
        onTap: cart.getCounter() == 0
            ? null
            : () {
                pengam == null
                    ? showSnackBarpengam(context)
                    : cart.getData().then((result) {
                        for (var i = 0; i < result.length; i++) {
                          getDatatrans(
                              finaluser,
                              cart.getTotalPrice().toString(),
                              pengam,
                              cart.getktok(),
                              result[i].id.toString(),
                              result[i].quantity.toString(),
                              result[i].productPrice.toString(),
                              pgm.text == '' ? address2 : pgm.text);
                        }
                        showSnackBaryar(context);
                      });
                getDataproter(cart.getktok());
                print(cart.getktok());
                pengam == null
                    ? print('pengam kosong')
                    : dbHelper!.clearCartItem();
                pengam == null
                    ? print('pengam kosong')
                    : crut!.fremoveCounter();
                pengam == null
                    ? print('pengam kosong')
                    : crut!.fremoveTotalPrice();
              },
        child: Container(
          color: cart.getCounter() == 0 ? Colors.grey : Colors.yellow.shade600,
          alignment: Alignment.center,
          height: 50.0,
          child: const Text(
            'Lanjutkan Pembayaran',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Future<List> getDatatrans(String user, String total, String ambil, String kdtok,
    String kdmn, String pes, String sub, String lamut) async {
  final response = await http.post(Uri.parse(trans2), body: {
    "Uname": user,
    "total": total,
    "ambil": ambil,
    "kdtok": kdtok,
    "kdmn": kdmn,
    "pes": pes,
    "subtl": sub,
    "lamet": lamut
  });
  var data = jsonDecode(response.body);
  // if (data == 'error') {
  //   print('uyee');
  // } else {
  //   print('uyee2');
  // }
  return data;
}

// Future<List> getDatadettrans(String user, String total, String ambil,
//     String kdtok, String kdmn, String pes, String sub, String lamut) async {
//   final response = await http.post(Uri.parse(trans), body: {
//     "Uname": user,
//     "total": total,
//     "ambil": ambil,
//     "kdtok": kdtok,
//     "kdmn": kdmn,
//     "pes": pes,
//     "subtl": sub,
//     "lamet": lamut,
//   });
//   var data = jsonDecode(response.body);
//   if (response.statusCode == 200) {
//     return json.decode(response.body);
//   } else {
//     throw Exception('Failed to load');
//   }
// }

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}

void showSnackBarpengam(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Harap isi pengambilan!!!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
    elevation: 30,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showSnackBaryar(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Pembayaran berhasil',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
    elevation: 30,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
