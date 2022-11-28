import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_3/db.dart';

class test extends StatefulWidget {
  List list;
  int index;
  test({required this.index, required this.list});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['username']}"),
      ),
      body: Center(
        child: Text(
          "Password : ${widget.list[widget.index]['password']}",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
