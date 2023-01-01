// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:project_3/cart_model.dart';
// import 'package:project_3/db_helper.dart';

// class hemat extends StatefulWidget {
//   const hemat({super.key});

//   @override
//   State<hemat> createState() => _hematState();
// }
// DBHelper? dbHelper = DBHelper();
// class _hematState extends State<hemat> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: list == null ? 0 : list.length,
//               itemBuilder: (context, i) {
//                 return Column(
//                   children: [
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(
//                             top: 15.0, left: 10.0, right: 5.0),
//                         child: Card(
//                           clipBehavior: Clip.antiAlias,
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(20)),
//                           child: InkWell(
//                             onTap: () {
//                               dbHelper!
//                                   .insert(
//                                 Cart(
//                                     id: list[i]['Kode_Menu'],
//                                     productId: list[i]['Kode_Menu'],
//                                     productName:
//                                         list[i]['Nama_Menu'].toString(),
//                                     initialPrice: int.parse(list[i]['Harga']),
//                                     productPrice: int.parse(list[i]['Harga']),
//                                     quantity: 1,
//                                     unitTag: list[i]['katagori_menu'],
//                                     image: list[i]['gambar'].toString()),
//                               )
//                                   .then((value) {
//                                 print('Product add to cart');
//                                 cart.addTotalPrice(
//                                   double.parse(list[i]['Harga'].toString()),
//                                 );
//                                 cart.addCounter();
//                               }).onError((error, stackTrace) {
//                                 print(error.toString());
//                               });
//                             },
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Stack(
//                                   alignment: Alignment.bottomLeft,
//                                   children: [
//                                     Ink.image(
//                                       image: NetworkImage(
//                                           '$imgProf${list[i]['gambar']}'),
//                                       height: 100,
//                                       width: 185,
//                                       fit: BoxFit.fitWidth,
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 16.0,
//                                       top: 16.0,
//                                       right: 20.0,
//                                       bottom: 20.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       Container(
//                                         width: 140,
//                                         child: Text(
//                                           '${list[i]['Nama_Menu']}',
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.justify,
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Container(
//                                               child: Text(
//                                             'Rp ${list[i]['Harga']}',
//                                           )),
//                                         ],
//                                       ),
//                                       Container(
//                                         width: 140,
//                                         child: Text(
//                                           '${list[i]['deskripsi']}',
//                                           style:
//                                               TextStyle(color: Colors.black54),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           textAlign: TextAlign.justify,
//                                         ),
//                                       ),
//                                       Container(
//                                           padding: EdgeInsets.only(left: 85),
//                                           child: TextButton(
//                                               onPressed: () {
//                                                 showAlertDialogc(
//                                                     BuildContext context) {
//                                                   // set up the button

//                                                   // set up the AlertDialog
//                                                   AlertDialog alert =
//                                                       AlertDialog(
//                                                     title: Text(
//                                                         "Detail deskripsi"),
//                                                     content: Text(
//                                                         "${list[i]['deskripsi']}"),
//                                                     actions: [],
//                                                   );
//                                                   // show the dialog
//                                                   showDialog(
//                                                     context: context,
//                                                     builder:
//                                                         (BuildContext context) {
//                                                       return alert;
//                                                     },
//                                                   );
//                                                 }

//                                                 showAlertDialogc(context);
//                                               },
//                                               child: Text('Detail'))),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               });
//   }
// }
