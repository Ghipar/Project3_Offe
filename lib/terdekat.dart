import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:getwidget/getwidget.dart';
import 'package:project_3/test.dart';

class Terdekat extends StatefulWidget {
  const Terdekat({super.key});

  @override
  State<Terdekat> createState() => _TerdekatState();
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
            GestureDetector(
              onTap: () {
                showSnackBarFav(context);
              },
              child: Card(
                elevation: 8,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                '${list[i]['gambar_toko']}',
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
                            children: [
                              Text(
                                "${list[i]['Nama_toko']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '0,6 km',
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(right: 10.0, bottom: 3.0),
                              child: IconButton(
                                  onPressed: () {
                                    showSnackBarFav(context);
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ))),
                          Container(
                            padding: EdgeInsets.only(right: 10.0, bottom: 5.0),
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: 10.0,
                            ),
                            child: Text("4.5"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        );
      },
    );
  }
}

Future<List> getData() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.7/cobak/getdata.php'));
  return jsonDecode(response.body);
}

class _TerdekatState extends State<Terdekat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      'Terdekat',
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
                    'Cobain caffe terdekat dari lokasimu :)',
                    style: TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.green[300],
      ),
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

void showSnackBarFav(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Kepencet kok :)',
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
