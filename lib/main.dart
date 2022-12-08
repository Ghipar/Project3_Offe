import 'package:flutter/material.dart';
import 'package:project_3/dashboard.dart';
import 'package:project_3/forgotPass.dart';
import 'package:project_3/home.dart';
import 'package:project_3/login.dart';
import 'package:project_3/regis.dart';
import 'package:project_3/screen.dart';
import 'package:project_3/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splash(),
      routes: <String, WidgetBuilder>{
        '/dashboard': (BuildContext context) => new dashboard(),
        '/login': (BuildContext context) => new login(),
        '/screen': (BuildContext context) => new screen(),
        '/regis': (BuildContext context) => new regis(),
        '/fpass': (BuildContext context) => new forgotPass(),
      },
    );
  }
}
