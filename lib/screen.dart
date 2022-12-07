import 'package:flutter/material.dart';
import 'package:project_3/login.dart';
import 'package:project_3/regis.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo.png'),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    child: Text("Login",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 25.0,
                                right: 25.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    child: Text("Register", style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(15)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 56, 88, 53)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.white)))),
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/regis'),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Color.fromARGB(100, 104, 166, 100));
  }
}
