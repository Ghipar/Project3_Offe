import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_3/api.dart';
import 'package:project_3/cart_model.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/cart_screen.dart';
import 'package:project_3/home.dart';

import 'package:like_button/like_button.dart';
import 'package:project_3/menu.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class searchPage extends SearchDelegate {
  List<String> searchResults = [
    'Caffe wuft',
    'setarbucek',
    'sus',
    'siuu',
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                FocusScope.of(context).unfocus();
              } else {
                query = '';
              }
            },
            icon: Icon(Icons.clear))
      ];
  @override
  Widget buildResults(BuildContext context) => Center(
        child: RefreshIndicator(
          child: FutureBuilder<List>(
              future: getDatasear(query),
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
            // getDataceklike();
            return showSearch(context: context, delegate: searchPage());
          },
        ),
      );
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResults) {
      final result = searchResults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => list[i]['statust_toko'] == '0'
                        ? showSnackBartok(context)
                        : Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    menu(index: i, list: list)),
                          ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${list[i]['Nama_toko']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              width: 40,
                                              child: Text(
                                                '${cari[i]['distance']} Km',
                                                style: TextStyle(
                                                    color: Colors.black54),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )),
                                          Text(
                                            ' | ',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                          Container(
                                            width: 40,
                                            child: Text(
                                              '${list[i]['Produk_Terjual']}',
                                              style: TextStyle(
                                                  color: Colors.black54),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            'Terjual',
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                  padding:
                                      EdgeInsets.only(left: 15, bottom: 3.0),
                                  child: LikeButton(
                                    isLiked: list[i]['like_status'] == ''
                                        ? false
                                        : true,
                                    size: 25,
                                    likeCount: int.parse(list[i]['like_count']),
                                    onTap: (isLiked) async {
                                      final SharedPreferences
                                          sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      sharedPreferences.setString(
                                          'kd', list[i]['Kode_Toko']);
                                      final SharedPreferences
                                          sharedPreferences1 =
                                          await SharedPreferences.getInstance();
                                      var kode =
                                          sharedPreferences1.getString('kd');
                                      kodto = kode;
                                      print(kodto);
                                      isLiked == false
                                          ? getDataceklike() //nambah
                                          : getDataceklike(); //kurang

                                      return !isLiked;
                                    },
                                    countPostion: CountPostion.right,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )
        : Center(
            child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image(
                image: AssetImage('assets/images/resul.png'),
                height: 300,
              ),
              Text(
                'Caffe tidak ditemukan',
                style: TextStyle(fontSize: 30),
              )
            ],
          ));
  }
}
