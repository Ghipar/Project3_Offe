import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_3/api.dart';

class Destination {
  double lat;
  double lng;
  String name;
  double distance;
  Destination(this.lat, this.lng, this.name, this.distance);
}

Future<List> getDatater() async {
  final response = await http.get(Uri.parse(terdekatApi));
  var des = jsonDecode(response.body);
  var destinations = [
    Destination(
        des[0]['latitude'], des[0]['longtitude'], des[0]['Nama_toko'], 0),
    // Destination(-8.186031865526132, 113.68993450486035, "Luminor", 0),
    // Destination(-8.188653356749999, 113.6891011831817, "zara", 0),
  ];

  return des;
}
