import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response = await http.get(
      Uri.parse("http://api.bamswp.my.id/index.php/mahasiswa"),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Text("Data Mahasiswa"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ItemList(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.only(top: 5, left: 3, right: 3),
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(list[i]['nama']),
                leading: Icon(Icons.person),
                subtitle: Text("${list[i]['nim']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
