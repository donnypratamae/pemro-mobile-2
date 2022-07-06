import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController nimController;
  TextEditingController namaController;
  TextEditingController prodiController;

  void editData() {
    var url = Uri.parse("http://api.bamswp.my.id/index.php/mahasiswa");
    http.put(url, body: {
      "nim": nimController.text,
      "nama": namaController.text,
      "prodi": prodiController.text,
    });
  }

  void deleteData() {
    var url = Uri.parse("http://api.bamswp.my.id/index.php/mahasiswa");
    http.delete(url, body: {
      'nim': widget.list[widget.index]['nim']
    });
  }

  void konfirmasi() {
    AlertDialog alertDialog = AlertDialog(
      content: Text("Apakah anda yakin akan menghapus data '${widget.list[widget.index]['nama']}'"),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          child: Text(
            "OK DELETE!",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            deleteData();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Home()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: Text("CANCEL", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  @override
  void initState() {
    nimController = TextEditingController(text: widget.list[widget.index]['nim']);
    namaController = TextEditingController(text: widget.list[widget.index]['nama']);
    prodiController = TextEditingController(text: widget.list[widget.index]['prodi']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EDIT DATA"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Ubah Data Mahasiswa",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  onPressed: () {
                    editData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text("Ubah"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {
                    konfirmasi();
                  },
                  child: Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
