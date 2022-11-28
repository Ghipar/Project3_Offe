import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_3/screen.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => screen(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/Logo.png")],
          ),
        ),
        backgroundColor: Color.fromARGB(100, 104, 166, 100));
  }
}
