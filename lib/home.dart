import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'package:project_3/api.dart';
import 'package:project_3/db.dart';
import 'package:project_3/login.dart';
import 'package:project_3/menu.dart';
import 'package:project_3/regis.dart';
import 'package:project_3/terdekat.dart';
import 'package:like_button/like_button.dart';
import 'package:project_3/terfavorit.dart';
import 'package:project_3/terlaris.dart';
import 'package:validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

List<dynamic> banner = [];
List<dynamic> terlaris = [];
List<dynamic> terfavorit = [];
List<dynamic> cekilike = [];
List<dynamic> terdekat = [];

var kodto;
Future<List> getDataTerdekat() async {
  final response = await http.get(Uri.parse(terdekatApi));
  final get = jsonDecode(response.body);
  terdekat = await _getTheDistance(get, isSorted: true);
  return terdekat;
}

Future<List> getDataBanner() async {
  final response = await http.get(Uri.parse(bannerApi));
  final get = jsonDecode(response.body);
  banner = get;
  return banner;
}

Future<List> getDataterlaris() async {
  final response = await http.get(Uri.parse(terlarisApi));
  final get = jsonDecode(response.body);
  terlaris = await _getTheDistance(get);
  return terlaris;
}

Future<List> getDataterfavorit() async {
  final response = await http.get(Uri.parse(terfavoritApi));
  final get = jsonDecode(response.body);
  terfavorit = await _getTheDistance(get);
  return terfavorit;
}

Future<List> getDataceklike() async {
  final response = await http.post(Uri.parse(ceklike), body: {
    "Kode_Toko": kodto,
    "Username": finaluser,
  });
  var data = jsonDecode(response.body);
  return await _getTheDistance(data);
}

Future _getTheDistance(List<dynamic> data, {bool isSorted = false}) async {
  _currentUserPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);

  for (int i = 0; i < data.length; i++) {
    double storelat = double.parse(data[i]['latitude']);
    double storelng = double.parse(data[i]['longtitude']);

    distanceImMeter = Geolocator.distanceBetween(
      _currentUserPosition!.latitude,
      _currentUserPosition!.longitude,
      storelat,
      storelng,
    );
    int? distance = distanceImMeter?.round().toInt();
    data[i]['distance'] = (distance! / 1000);
  }

  if (isSorted) {
    data.sort((a, b) => a['distance'].compareTo(b['distance']));
  }

  return data;
}

Position? _currentUserPosition;
double? distanceImMeter = 0.0;
// Data data = Data();

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          // Carousel(),
          Container(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: banner == null ? 0 : banner.length,
                itemBuilder: (context, i) {
                  final img = banner[i];
                  final gambar = img['Gambar'];
                  return Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 30.0, left: 10.0, right: 10.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: null,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Ink.image(
                                        image:
                                            NetworkImage('$imgProf${gambar}'),
                                        height: 200,
                                        width: 380,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
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
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/vou');
                },
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
                          child: const Icon(
                            Icons.credit_card,
                            color: Colors.white,
                            size: 35,
                          ),
                        );
                      }),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: const Text(
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
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 30.0),
                    child: const Text(
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
                          builder: (_) => Terfavorit(),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Terlaris(),
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
                    onTap: () {},
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
                itemCount: terdekat == null ? 0 : terdekat.length,
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
                                            '$imgProf${terdekat[i]['gambar_toko']}'),
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
                                        Row(
                                          children: [
                                            Container(
                                                width: 40,
                                                child: Text(
                                                  '${terdekat[i]['distance']} Km',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )),
                                            // Text('Km',
                                            //     style: TextStyle(
                                            //         color: Colors.black54)),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                            Container(
                                              width: 40,
                                              child: Text(
                                                '${terdekat[i]['Produk_Terjual']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Terjual',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text('${terdekat[i]['Nama_toko']}'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 3.0,
                                                  left: 15.0,
                                                ),
                                                child: LikeButton(
                                                  isLiked: terdekat[i]
                                                              ['like_status'] ==
                                                          ''
                                                      ? false
                                                      : true,
                                                  size: 25,
                                                  likeCount: int.parse(
                                                      terdekat[i]
                                                          ['like_count']),
                                                  onTap: (isLiked) async {
                                                    final SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'kd',
                                                        terdekat[i]
                                                            ['Kode_Toko']);
                                                    final SharedPreferences
                                                        sharedPreferences1 =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var kode =
                                                        sharedPreferences1
                                                            .getString('kd');
                                                    kodto = kode;
                                                    print(kodto);
                                                    isLiked == false
                                                        ? getDataceklike() //nambah
                                                        : getDataceklike(); //kurang

                                                    return !isLiked;
                                                  },
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
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
                }),
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: terfavorit == null ? 0 : terfavorit.length,
                itemBuilder: (context, i) {
                  final fav = terfavorit[i];

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
                                Navigator.of(context).push(
                                  new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          menu(index: i, list: terfavorit)),
                                );
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
                                            '$imgProf${fav['gambar_toko']}'),
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
                                        Row(
                                          children: [
                                            Container(
                                                width: 40,
                                                child: Text(
                                                  '${fav['distance']} Km',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                            Container(
                                              width: 40,
                                              child: Text(
                                                '${fav['Produk_Terjual']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Terjual',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text('${fav['Nama_toko']}'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 3.0,
                                                  left: 15.0,
                                                ),
                                                child: LikeButton(
                                                  isLiked:
                                                      fav['like_status'] == ''
                                                          ? false
                                                          : true,
                                                  size: 25,
                                                  likeCount: int.parse(
                                                      fav['like_count']),
                                                  onTap: (isLiked) async {
                                                    final SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'kd', fav['Kode_Toko']);
                                                    final SharedPreferences
                                                        sharedPreferences1 =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var kode =
                                                        sharedPreferences1
                                                            .getString('kd');
                                                    kodto = kode;
                                                    print(kodto);
                                                    isLiked == false
                                                        ? getDataceklike() //nambah
                                                        : getDataceklike(); //kurang

                                                    return !isLiked;
                                                  },
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
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
                }),
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: list == null ? 0 : list.length,
                itemBuilder: (context, i) {
                  final laris = terlaris[i];
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
                                            '$imgProf${laris['gambar_toko']}'),
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
                                        Row(
                                          children: [
                                            Container(
                                                width: 40,
                                                child: Text(
                                                  '${laris['distance']} Km',
                                                  style: TextStyle(
                                                      color: Colors.black54),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )),
                                            Text(' | ',
                                                style: TextStyle(
                                                    color: Colors.black54)),
                                            Container(
                                              width: 40,
                                              child: Text(
                                                '${laris['Produk_Terjual']}',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                'Terjual',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text('${laris['Nama_toko']}'),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                  bottom: 3.0,
                                                  left: 15.0,
                                                ),
                                                child: LikeButton(
                                                  isLiked:
                                                      laris['like_status'] == ''
                                                          ? false
                                                          : true,
                                                  size: 25,
                                                  likeCount: int.parse(
                                                      laris['like_count']),
                                                  onTap: (isLiked) async {
                                                    final SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'kd',
                                                        laris['Kode_Toko']);
                                                    final SharedPreferences
                                                        sharedPreferences1 =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    var kode =
                                                        sharedPreferences1
                                                            .getString('kd');
                                                    kodto = kode;
                                                    print(kodto);
                                                    isLiked == false
                                                        ? getDataceklike() //nambah
                                                        : getDataceklike(); //kurang

                                                    return !isLiked;
                                                  },
                                                )),
                                            SizedBox(
                                              width: 20,
                                            ),
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
                }),
          ),
        ],
      ),
    ]);
  }
}

class _homeState extends State<home> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: FutureBuilder<List>(
            future: getDataTerdekat(),
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
          getDataBanner();
          getDataterlaris();
          getDataterfavorit();
          getDataTerdekat();
          // getDataceklike();
          return Navigator.pushReplacementNamed(context, '/dashboard');
        },
      ),
    );
  }
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
