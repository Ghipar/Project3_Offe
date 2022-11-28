import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_3/test.dart';

class dB extends StatefulWidget {
  const dB({super.key});

  @override
  State<dB> createState() => _dBState();
}

class _dBState extends State<dB> {
  Future<List> getData() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.7/cobak/getdata.php'));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('db'),
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

class ItemList extends StatelessWidget {
  final List list;
  const ItemList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => test(index: i, list: list),
            ));
          },
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Card(
              child: new ListTile(
                leading: Icon(Icons.person),
                title: Text("Username : ${list[i]['username']}"),
                subtitle: Text("Password : ${list[i]['password']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
