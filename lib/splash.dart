import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_3/home.dart';
import 'package:project_3/screen.dart';
import 'package:project_3/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent_plus/android_intent.dart';

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
      address2 =
          '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      Position position = await _getGeoLocationPosition();
      getDataBanner();
      getDataterlaris();
      getDataterfavorit();
      getDataTerdekat();
      getDatalv();
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(
            context, finaluser == null ? '/screen' : '/dashboard');
      });

      setState(() {
        location = '${position.latitude}, ${position.longitude}';
      });
      getAddressFromLongLat(position);
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
