import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:project_3/api.dart';

class menu extends StatefulWidget {
  List list;
  int index;
  menu({required this.index, required this.list});

  @override
  State<menu> createState() => _menuState();
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
                                    '$imgProf${list[i]['gambar']}',
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
                                    "${list[i]['Nama_Menu']}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: 40,
                                          child: Text(
                                            '${list[i]['Nama_Menu']}',
                                            style: TextStyle(
                                                color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          )),
                                      Text(
                                        ' | ',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                      Container(
                                        width: 40,
                                        child: Text(
                                          '${list[i]['Nama_Menu']}',
                                          style:
                                              TextStyle(color: Colors.black54),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        'Terjual',
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          // Container(
                          //     padding: EdgeInsets.only(left: 15, bottom: 3.0),
                          //     child: LikeButton(
                          //       isLiked:
                          //           list[i]['like_status'] == '' ? false : true,
                          //       size: 25,
                          //       likeCount: int.parse(list[i]['like_count']),
                          //       onTap: (isLiked) async {
                          //         final SharedPreferences sharedPreferences =
                          //             await SharedPreferences.getInstance();
                          //         sharedPreferences.setString(
                          //             'kd', list[i]['Kode_Toko']);
                          //         final SharedPreferences sharedPreferences1 =
                          //             await SharedPreferences.getInstance();
                          //         var kode = sharedPreferences1.getString('kd');
                          //         kodto = kode;
                          //         print(kodto);
                          //         isLiked == false
                          //             ? getDataceklike() //nambah
                          //             : getDataceklike(); //kurang

                          //         return !isLiked;
                          //       },
                          //       countPostion: CountPostion.right,
                          //     )),
                          // Row(

                          //   children: [
                          //     Container(
                          //       padding: EdgeInsets.only(bottom: 5.0),
                          //       child: Icon(
                          //         Icons.star,
                          //         color: Colors.amber,
                          //       ),
                          //     ),
                          //     Container(
                          //       padding: EdgeInsets.only(
                          //         right: 10.0,
                          //       ),
                          //       child: Text("4.5"),
                          //     ),
                          //   ],
                          // )
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

class _menuState extends State<menu> {
  Future<List> getDatamenu() async {
    final response = await http.post(Uri.parse(menuapi), body: {
      "store_id": widget.list[widget.index]['Kode_Toko'],
    });
    var data = jsonDecode(response.body);
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 65,
        title: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      '${widget.list[widget.index]['Nama_toko']}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.green[300],
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
