import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_3/home.dart';
import 'package:project_3/screen.dart';
import 'package:project_3/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> kill() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');
}

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        getDataBanner();
        getDataterlaris();
        getDataterfavorit();
        Navigator.pushReplacementNamed(
            context, finaluser == null ? '/screen' : '/dashboard');
      });
    });
    super.initState();
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('username');
    setState(() {
      //kill();
      finaluser = obtainedEmail;
    });
    print(finaluser);
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
