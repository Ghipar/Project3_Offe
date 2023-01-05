import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_3/histori.dart';
import 'package:project_3/home.dart';
import 'package:project_3/login.dart';
import 'package:project_3/pickup.dart';
import 'package:project_3/profile.dart';
import 'package:project_3/regis.dart';
import 'package:project_3/search.dart';

class dashboardpick extends StatefulWidget {
  const dashboardpick({Key? key}) : super(key: key);

  @override
  _dashboardpickState createState() => _dashboardpickState();
}

TextEditingController searchController = TextEditingController();

class _dashboardpickState extends State<dashboardpick> {
  var obscuretext1 = true;
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    home(),
    pickup(),
    histori(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green[300],
        title: Container(
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Icon(Icons.location_city)),
                  Container(
                      width: 216,
                      margin: EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Text(
                        '${address}',
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 48, top: 20),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                      )),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showSearch(context: context, delegate: searchPage());
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 10, bottom: 30.0),
                  // width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    enabled: false,
                    controller: searchController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        prefix: Padding(padding: EdgeInsets.only(left: 30.0)),
                        hintText: 'Caffe mana lagi nih...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        contentPadding: EdgeInsets.only(bottom: 8.0),
                        border: InputBorder.none),
                  ),
                ),
              )
            ],
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.track_changes),
            label: 'Pickup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
