import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nimController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController prodiController = TextEditingController();

  void addData() {
    var url = Uri.parse("http://api.bamswp.my.id/index.php/mahasiswa");

    http.post(url, body: {
      "nim": nimController.text,
      "nama": namaController.text,
      "prodi": prodiController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD DATA"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Input Data Mahasiswa",
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: nimController,
              decoration: InputDecoration(
                labelText: "NIM",
              ),
            ),
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextFormField(
              controller: prodiController,
              decoration: InputDecoration(labelText: "Prodi"),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                addData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
