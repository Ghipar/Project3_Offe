import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_3/db.dart';
import 'package:project_3/regis.dart';
import 'package:project_3/terdekat.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView(children: [
      Column(
        children: [
          // Carousel(),
          Container(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 20.0, right: 10.0),
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
                                Image.asset(
                                  'assets/images/original.jpg',
                                  height: 200,
                                  fit: BoxFit.fitWidth,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
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
                                Image.asset(
                                  'assets/images/hisoka.jpg',
                                  height: 200,
                                  fit: BoxFit.fitWidth,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 10.0, right: 20.0),
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
                                Image.asset(
                                  'assets/images/umami.jpg',
                                  height: 200,
                                  fit: BoxFit.fitWidth,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  height: 60.0, //MediaQuery.of(context).size.width * .08,
                  width: 350.0, //MediaQuery.of(context).size.width * .3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      LayoutBuilder(builder: (context, constraints) {
                        print(constraints);
                        return Container(
                          height: constraints.maxHeight,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 78, 210, 162),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 35,
                          ),
                        );
                      }),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Ada voucher gabut....',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Terdekat(),
                        ),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 30.0),
                        width: 59.0,
                        height: 58.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Image.asset('assets/icons/mapss.png')),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Terdekat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => dB(),
                        ),
                      );
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(left: 32.0),
                        width: 59.0,
                        height: 58.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Image.asset('assets/icons/love.png')),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Terfavorit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('sattt');
                    },
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(left: 32.0),
                        width: 59.0,
                        height: 58.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Image.asset('assets/icons/terlaris.png')),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 30.0),
                    child: Text(
                      'Terlaris',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('sattt');
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: 59.0,
                        height: 58.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: Image.asset('assets/icons/hemat.png')),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Menu Hemat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Caffe Terdekat',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )
            ],
          ),
          Container(
            height: 280,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
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
                                      Image.asset(
                                        'assets/images/mdar.jpg',
                                        height: 100,
                                        fit: BoxFit.fitWidth,
                                      )
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
                                        Text(
                                          '0,6 Km',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        Text('${list[i]['username']}'),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 3.0,
                                                  left: 42.0,
                                                ),
                                                child: IconButton(
                                                    onPressed: () {
                                                      showSnackBarFav(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: Colors.pink,
                                                    ))),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 3.0),
                                              child: Icon(
                                                Icons.star,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 5.0),
                                              child: Text('4,5'),
                                            )
                                          ],
                                        )
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
                }

                // Column(
                //   children: [
                //     Center(
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //             top: 15.0, left: 10.0, right: 5.0),
                //         child: Card(
                //           clipBehavior: Clip.antiAlias,
                //           elevation: 10,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20)),
                //           child: InkWell(
                //             onTap: () {
                //               print('hola');
                //             },
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Stack(
                //                   alignment: Alignment.bottomLeft,
                //                   children: [
                //                     Image.asset(
                //                       'assets/images/aogi.jpeg',
                //                       height: 100,
                //                       fit: BoxFit.fitWidth,
                //                     )
                //                   ],
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsets.only(
                //                       left: 16.0,
                //                       top: 16.0,
                //                       right: 20.0,
                //                       bottom: 20.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Text(
                //                         '0,6 Km',
                //                         style:
                //                             TextStyle(color: Colors.black54),
                //                       ),
                //                       Text('Caffe Wibu'),
                //                       Row(
                //                         children: [
                //                           Container(
                //                               padding: EdgeInsets.only(
                //                                   bottom: 3.0, left: 42.0),
                //                               child: IconButton(
                //                                   onPressed: () {
                //                                     showSnackBarFav(context);
                //                                   },
                //                                   icon: Icon(
                //                                     Icons.favorite,
                //                                     color: Colors.pink,
                //                                   ))),
                //                           Container(
                //                             padding:
                //                                 EdgeInsets.only(bottom: 3.0),
                //                             child: Icon(
                //                               Icons.star,
                //                               color: Colors.orange,
                //                             ),
                //                           ),
                //                           Container(
                //                             padding:
                //                                 EdgeInsets.only(left: 5.0),
                //                             child: Text('4,5'),
                //                           )
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // Column(
                //   children: [
                //     Center(
                //       child: Padding(
                //         padding: EdgeInsets.only(
                //             top: 15.0, left: 10.0, right: 5.0),
                //         child: Card(
                //           clipBehavior: Clip.antiAlias,
                //           elevation: 10,
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20)),
                //           child: InkWell(
                //             onTap: () {
                //               print('hola');
                //             },
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Stack(
                //                   alignment: Alignment.bottomLeft,
                //                   children: [
                //                     Image.asset(
                //                       'assets/images/aot.jpg',
                //                       height: 100,
                //                       fit: BoxFit.fitWidth,
                //                     )
                //                   ],
                //                 ),
                //                 Padding(
                //                   padding: EdgeInsets.only(
                //                       left: 16.0,
                //                       top: 16.0,
                //                       right: 20.0,
                //                       bottom: 20.0),
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: <Widget>[
                //                       Text(
                //                         '0,6 Km',
                //                         style:
                //                             TextStyle(color: Colors.black54),
                //                       ),
                //                       Text('Caffe Wibu'),
                //                       Row(
                //                         children: [
                //                           Container(
                //                               padding: EdgeInsets.only(
                //                                   bottom: 3.0, left: 42.0),
                //                               child: IconButton(
                //                                   onPressed: () {
                //                                     showSnackBarFav(context);
                //                                   },
                //                                   icon: Icon(
                //                                     Icons.favorite,
                //                                     color: Colors.pink,
                //                                   ))),
                //                           Container(
                //                             padding:
                //                                 EdgeInsets.only(bottom: 3.0),
                //                             child: Icon(
                //                               Icons.star,
                //                               color: Colors.orange,
                //                             ),
                //                           ),
                //                           Container(
                //                             padding:
                //                                 EdgeInsets.only(left: 5.0),
                //                             child: Text('4,5'),
                //                           )
                //                         ],
                //                       )
                //                     ],
                //                   ),
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Caffe Terfavorit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )
            ],
          ),
          Container(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/mdar.jpg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                bottom: 3.0,
                                                left: 42.0,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/aogi.jpeg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 3.0, left: 42.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/aot.jpg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 3.0, left: 42.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Caffe Terlaris',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              )
            ],
          ),
          Container(
            height: 280,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/mdar.jpg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                bottom: 3.0,
                                                left: 42.0,
                                              ),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/aogi.jpeg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 3.0, left: 42.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
                Column(
                  children: [
                    Center(
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: 15.0, left: 10.0, right: 5.0),
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
                                    Image.asset(
                                      'assets/images/aot.jpg',
                                      height: 100,
                                      fit: BoxFit.fitWidth,
                                    )
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
                                      Text(
                                        '0,6 Km',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Text('Caffe Wibu'),
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  bottom: 3.0, left: 42.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    showSnackBarFav(context);
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: Colors.pink,
                                                  ))),
                                          Container(
                                            padding:
                                                EdgeInsets.only(bottom: 3.0),
                                            child: Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 5.0),
                                            child: Text('4,5'),
                                          )
                                        ],
                                      )
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
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }
}

Future<List> getData() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.7/cobak/getdata.php'));
  return jsonDecode(response.body);
}

class _homeState extends State<home> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Text("error bre");
            }
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data ?? [],
                  )
                : new Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }
}

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
  }) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;

  List<String> images = [
    "https://i.ibb.co/7twJjxM/aot.jpg",
    "https://i.ibb.co/Xb7jCjW/gugu.jpg",
    "https://i.ibb.co/gvJsMvm/original.jpg"
  ];

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 230,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images, pagePosition, active);
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, activePage))
      ],
    );
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 0.0 : 10;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: NetworkImage(images[pagePosition]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

void showSnackBarFav(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Add to favorite :)',
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

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
