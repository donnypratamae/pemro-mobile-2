import 'package:flutter/material.dart';
import 'mahasiswa.dart';
import 'database_helper.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Mahasiswa"),
      ),
      body: FutureBuilder<List<Mahasiswa>>(
        future: DatabaseHelper.instance.getAllMahasiswa(),
        builder: (BuildContext context, AsyncSnapshot<List<Mahasiswa>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Loading...'),
            );
          }
          return snapshot.data.isEmpty
              ? Center(child: Text('No Data in List.'))
              : ListView(
                  children: snapshot.data.map(
                    (mahasiswa) {
                      return Center(
                        child: Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: Text(mahasiswa.nama),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}
