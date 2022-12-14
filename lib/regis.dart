import 'dart:convert';
import 'package:project_3/api.dart';
import 'package:flutter/material.dart';
import 'package:project_3/login.dart';
import 'package:project_3/regis.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';

class regis extends StatefulWidget {
  const regis({Key? key}) : super(key: key);

  @override
  _regisState createState() => _regisState();
}

TextEditingController user = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController pass = TextEditingController();

class _regisState extends State<regis> {
  var obscuretext1 = true;
  bool isValid = false;
  Future<List> _regis() async {
    final response = await http.post(Uri.parse(registerApi), body: {
      "Username": user.text,
      "Email": email.text,
      "Password": pass.text,
    });
    var data = jsonDecode(response.body);

    if (data == "Error") {
      showSnackBarFav2err(context);
    } else {
      showSnackBarFav2(context);
      Navigator.pushReplacementNamed(context, '/login');
      user.clear();
      email.clear();
      pass.clear();
    }

    return data;
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
                      child: Text('Sign up',
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
                    autofocus: false,
                    controller: user,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.person),
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
                    onChanged: (val) {
                      setState(() {
                        isValid = isEmail(val);
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    controller: email,
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

                      //labelText: 'Username',
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Udah punya akun?',
                    style: TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                      user.clear();
                      email.clear();
                      pass.clear();
                    },
                    child: Text("Login Disini"),
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
                    child: Text("Register",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.only(
                                top: 15.0,
                                bottom: 15.0,
                                left: 135.0,
                                right: 135.0)),
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
                            _regis();
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

void showSnackBarFav2(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Berhasil Registrasi',
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

void showSnackBarFav2err(BuildContext context) {
  final snackBar = SnackBar(
    content: Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: const Text(
        'Gagal registrasi username atau email telah terpakai!!',
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
