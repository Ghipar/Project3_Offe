import 'dart:convert';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:project_3/api.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;

class forgotPass extends StatefulWidget {
  const forgotPass({super.key});

  @override
  State<forgotPass> createState() => _forgotPassState();
}

TextEditingController emai = new TextEditingController();
TextEditingController pass = new TextEditingController();
void showSnackBarFav(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Email tidak terdaftar!!!',
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

void showSnackBarFav2(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Berhasil reset password',
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

class _forgotPassState extends State<forgotPass> {
  bool isValid = false;
  var obscuretext1 = true;
  Future<List> _konfirmasi() async {
    final response = await http.post(Uri.parse(respasApi), body: {
      "Email": emai.text,
      "Password": pass.text,
    });

    var datauser = jsonDecode(response.body);
    if (datauser == 'Error') {
      setState(() {
        showSnackBarFav(context);
      });
    } else {
      showSnackBarFav2(context);
      Navigator.pushReplacementNamed(context, '/login');
      emai.clear();
      pass.clear();
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
                      child: Text('Lupa password',
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
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    controller: emai,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.grey,
                      suffixIcon: isValid == false
                          ? const Icon(
                              Icons.error_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: isValid == false
                            ? BorderSide(color: Colors.red)
                            : BorderSide(color: Colors.greenAccent),
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
                      Icons.login,
                      color: Colors.white70,
                    ),

                    // Text('Lupas password?'),
                  ),
                  Container(
                      // padding: EdgeInsets.only(left: 10.0),

                      child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                      emai.clear();
                      pass.clear();
                    },
                    child: Text("Login Disini"),
                  )),
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
                    child: Text("Konfirmasi",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 125.0,
                                right: 125.0)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: isValid == false
                            ? MaterialStateProperty.all<Color>(Colors.grey)
                            : MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 76, 101, 75)),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 76, 101, 75))))),
                    onPressed: isValid == false
                        ? null
                        : () {
                            _konfirmasi();
                          },
                  )),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )),
        backgroundColor: Color.fromARGB(100, 104, 166, 100));
  }
}
