import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:project_3/api.dart';
import 'package:project_3/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as MATH;

import 'package:validators/validators.dart';

Future<void> kill() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('username');
}

class ItemList extends StatelessWidget {
  File? _image;
  File? prof;
  final List list;
  ItemList({super.key, required this.list});
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController alamat = TextEditingController();
  Future<List> _editProf() async {
    final response = await http.post(Uri.parse(editProfApi), body: {
      "Username": user.text,
      "Email": email.text,
      "no_hp": phone.text,
      "Alamat": alamat.text,
      "Usernama": finaluser,
    });
    var data = jsonDecode(response.body);

    return data;
  }

  Future upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(profileApi);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));

    request.fields['Username'] = finaluser;
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      getDataprof();
    } else {
      print("Upload Failed");
    }
  }

  Future pickImage(source) async {
    try {
      final imageFile = await ImagePicker().pickImage(source: source);
      if (imageFile == null) return;
      final tempDir = await getTemporaryDirectory();
      final path = tempDir.path;

      int rand = new MATH.Random().nextInt(100000);

      Img.Image image = Img.decodeImage(await imageFile.readAsBytes());
      Img.Image smallerImg = Img.copyResize(image, width: 500);

      var compressImg = new File("$path/image_$rand.jpg")
        ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
      final imageTemporary = File(imageFile.path);
      this._image = compressImg;
      // (context as Element).markNeedsBuild();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    upload(_image!);
  }

  @override
  Widget build(BuildContext Context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      height: 150,
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 15,
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.camera_alt),
                                            title: Text('Ambil foto'),
                                            onTap: () =>
                                                pickImage(ImageSource.camera),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.image),
                                            title: Text('Pilih dari galeri'),
                                            onTap: () =>
                                                pickImage(ImageSource.gallery),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Ink.image(
                                image: NetworkImage(
                                  '$imgProf${list[i]['gambar']}',
                                ),
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 15,
                        right: 5,
                        child: Container(
                            child: RawMaterialButton(
                          fillColor: Color.fromARGB(255, 245, 245, 245),
                          onPressed: null,
                          child: RawMaterialButton(
                            onPressed: null,
                            elevation: 0,
                            fillColor: Colors.blueAccent,
                            child: Icon(
                              Icons.camera_alt,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(11.0),
                            shape: CircleBorder(),
                          ),
                          shape: CircleBorder(),
                        )))
                  ],
                ),
                Container(
                  width: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "${list[i]['Username']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Text(
                          "${list[i]['no_hp']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Text(
                          "${list[i]['Email']}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: Text(
                          "${list[i]['Alamat']}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    child: IconButton(
                  onPressed: () {
                    user.text = "${list[i]['Username']}";
                    email.text = "${list[i]['Email']}";
                    phone.text = "${list[i]['no_hp']}";
                    alamat.text = "${list[i]['Alamat']}";
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (_) => Container(
                              padding: EdgeInsets.only(
                                top: 15,
                                left: 15,
                                right: 15,
                                // this will prevent the soft keyboard from covering the text fields
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        120,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: user,
                                      decoration: const InputDecoration(
                                          label: Text('Username'),
                                          hintText: 'Masukkan username baru'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: email,
                                      decoration: const InputDecoration(
                                          label: Text('Email'),
                                          hintText: 'Masukkan email baru'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: phone,
                                      decoration: const InputDecoration(
                                          label: Text('Phone'),
                                          hintText: 'Masukkan phone baru'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      controller: alamat,
                                      decoration: const InputDecoration(
                                          label: Text('Alamat'),
                                          hintText: 'Masukkan alamat baru'),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pushReplacementNamed(
                                            context, '/prof');
                                        _editProf();
                                        final SharedPreferences
                                            sharedPreferences =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPreferences.setString(
                                            'username', user.text);
                                        final SharedPreferences
                                            sharedPreferences1 =
                                            await SharedPreferences
                                                .getInstance();
                                        var obtainedEmail = sharedPreferences1
                                            .getString('username');
                                        finaluser = obtainedEmail;
                                      },
                                      child: Text('SIMPAN'),
                                    ),
                                    const SizedBox(
                                      height: 210,
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blueAccent,
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text('Voucherku'),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/vou');
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Card(
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text('Riwayat pesanan'),
                  onTap: () {},
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () => {showAlertDialog(context)},
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }

  showAlertDialogc(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () async {
        _editProf();
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('username', user.text);
        final SharedPreferences sharedPreferences1 =
            await SharedPreferences.getInstance();
        var obtainedEmail = sharedPreferences1.getString('username');
        finaluser = obtainedEmail;
        Navigator.pushReplacementNamed(context, '/prof');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Informasi!!"),
      content: Text("Berhasil edit akun"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons

    Widget continueButton = TextButton(
      child: Text("yakin"),
      onPressed: () {
        kill();
        Navigator.pushReplacementNamed(context, '/login');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Peringatan!!",
      ),
      content: Text("Anda yakin ingin logout?"),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

List<Map<String, dynamic>> _journals = [];

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Future<List> getDataprof() async {
  final response = await http.post(Uri.parse(profile2Api), body: {
    "Username": finaluser,
  });

  return jsonDecode(response.body);
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      child: new FutureBuilder<List>(
          future: getDataprof(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Text("error bre");
            }
            return snapshot.hasData
                ? new ItemList(
                    list: snapshot.data ?? [],
                  )
                : new Center(
                    child: CircularProgressIndicator(),
                  );
          }),
      onRefresh: () {
        return Navigator.pushReplacementNamed(context, '/prof');
      },
    ));
  }
}
