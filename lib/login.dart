import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:project_3/dashboard.dart';
import 'package:project_3/home.dart';
import 'package:project_3/regis.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_3/api.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent_plus/android_intent.dart';

var finaluser;

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

void showSnackBarFav(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Gagal login username dan password salah!!!',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.red[900],
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 20.0),
    elevation: 30,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String username = '';
void showSnackBarFav1(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: Text(
        'Selamat datang $username',
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

String location = '___';
String address = '___';

class _loginState extends State<login> {
  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error(
        'Location service not enabled',
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
          'Location permission denied',
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getAddressFromLongLat(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark);
    Placemark place = placemark[0];
    setState(() {
      address = '${place.subLocality}, ${place.subAdministrativeArea}';
    });
  }

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  var obscuretext1 = true;
  bool isValid = false;
  Future<List> _login() async {
    final response = await http.post(Uri.parse(loginApi), body: {
      "Username": user.text,
      "Password": pass.text,
    });

    var datauser = jsonDecode(response.body);
    if (datauser.length == 0) {
      setState(() {
        showSnackBarFav(context);
      });
    } else {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('username', user.text);
      final SharedPreferences sharedPreferences1 =
          await SharedPreferences.getInstance();
      var obtainedEmail = sharedPreferences1.getString('username');
      finaluser = obtainedEmail;

      Navigator.pushReplacementNamed(context, '/dashboard');

      setState(() {
        username = datauser[0]['Username'];
      });

      showSnackBarFav1(context);
    }
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/log2.png",
                // height: 300,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Sign in',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white)))),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        isValid = isEmail(val);
                      });
                    },
                    autofocus: false,
                    controller: user,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
                      prefixIconColor: Colors.grey,

                      //labelText: 'Username',
                      hintText: 'Username',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  controller: pass,
                  obscureText: obscuretext1,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.key),
                    hintText: "Password",
                    hintStyle: TextStyle(fontSize: 16),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscuretext1 = !obscuretext1;
                        });
                      },
                      child: obscuretext1
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Colors.blue,
                            ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.greenAccent)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(
                      Icons.lock,
                      color: Colors.white70,
                    ),

                    // Text('Lupas password?'),
                  ),
                  Container(
                    // padding: EdgeInsets.only(left: 10.0),

                    child: Text(
                      '  Lupa password ?',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/fpass');
                    },
                    child: Text("Klik Disini"),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 60,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 143, 158, 1),
                          Color.fromRGBO(255, 188, 143, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 4,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: ElevatedButton(
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 150.0,
                                right: 150.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 76, 101, 75)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 76, 101, 75))))),
                    onPressed: () async {
                      Position position = await _getGeoLocationPosition();
                      setState(() {
                        location =
                            '${position.latitude}, ${position.longitude}';
                      });
                      getAddressFromLongLat(position);
                      _login();
                      getDataBanner();
                      getDataterlaris();
                      getDataterfavorit();
                      getDataTerdekat();
                      getDatalv();
                    },
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ga punya akun?',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/regis');
                    },
                    child: Text("Register Disini"),
                  )
                ],
              )
            ],
          ),
        )),
        backgroundColor: Color.fromARGB(100, 104, 166, 100));
  }
}
