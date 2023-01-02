import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_3/cart_provider.dart';
import 'package:project_3/dashboard.dart';
import 'package:project_3/dashboardProf.dart';
import 'package:project_3/dashboardVou.dart';
import 'package:project_3/forgotPass.dart';
import 'package:project_3/home.dart';
import 'package:project_3/login.dart';
import 'package:project_3/lovePage.dart';
import 'package:project_3/menu.dart';
import 'package:project_3/menu_hemat.dart';
import 'package:project_3/profile.dart';
import 'package:project_3/regis.dart';
import 'package:project_3/screen.dart';
import 'package:project_3/search.dart';
import 'package:project_3/splash.dart';
import 'package:project_3/terdekat.dart';
import 'package:project_3/terfavorit.dart';
import 'package:project_3/terlaris.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
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
            '/prof': (BuildContext context) => new dashboardprof(),
            '/vou': (BuildContext context) => new dashboardvou(),
            '/dekat': (BuildContext context) => new Terdekat(),
            '/fav': (BuildContext context) => new Terfavorit(),
            '/laris': (BuildContext context) => new Terlaris(),
            '/lvp': (BuildContext context) => new lovePages(),
            '/hmt': (BuildContext context) => new hemat(),
          },
        );
      }),
    );
  }
}
