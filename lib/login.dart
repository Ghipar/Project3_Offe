import 'package:flutter/material.dart';
import 'package:project_3/dashboard.dart';
import 'package:project_3/regis.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  var obscuretext1 = true;
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
                    autofocus: false,
                    //controller: usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.email),
                      //labelText: 'Username',
                      hintText: 'Email',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
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
                  //controller: passwordController,
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
                      child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Lupa password ?',
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    ),
                  ))
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
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                      color:
                                          Color.fromARGB(255, 76, 101, 75))))),
                      onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => dashboard(),
                            ),
                          ))),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => regis(),
                        ),
                      );
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
