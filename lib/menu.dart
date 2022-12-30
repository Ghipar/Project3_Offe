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

class _menuState extends State<menu> {
  Future<List> getDataceklike() async {
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
        title: Text("${widget.list[widget.index]['Nama_toko']}"),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: () {
                getDataceklike();
              },
              child: Text('test'))),
    );
  }
}
