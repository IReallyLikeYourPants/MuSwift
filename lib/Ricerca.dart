import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';

class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class Ricerca extends StatefulWidget {
  @override
  StorageUploadState createState() => new StorageUploadState();

}




class StorageUploadState extends State<Ricerca> {
  List results = [];

  var rows = [];
  String query = '';
  TextEditingController tc;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    rows = [
      {
        'img': 'assets/images/deposizione.jpg',
        'contact_name': 'Test User 1',
        'contact_phone': '066 560 4900',
      },
      {
        'img': 'assets/images/deposizione.jpg',
        'contact_name': 'Test User 2',
        'contact_phone': '066 560 7865',
      },
      {
        'img': 'assets/images/deposizione.jpg',
        'contact_name': 'Test User 3',
        'contact_phone': '906 500 4334',
      }
    ];
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      appBar: new AppBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          icon: Icon(Icons.search),color: Colors.white,),
        title: new Text(
          "Search",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Theme(
                      child: TextField(
                          //style: TextStyle(color: Colors.grey),
                          controller: tc,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search...',
                            hintStyle: TextStyle(color: Colors.grey)
                          ),
                          onChanged: (v) {
                          setState(() {
                            query = v;
                            setResults(query);
                          });
                    },
                  ),
                    data: new ThemeData( //colore della search bar
                        primaryColor: Colors.white,
                        accentColor: Colors.orange,
                        hintColor: Colors.white
                    ),
                  ),
                ),
                Container(
                  color: Colors.black12,
                  child: query.isEmpty
                      ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: rows.length,
                    itemBuilder: (con, ind) {
                      return Card (color: Colors.black12,child: ListTile(
                        title: Text(rows[ind]['contact_name'],style: TextStyle(color: Colors.white)),
                        subtitle: Text(rows[ind]['contact_phone'],style: TextStyle(color: Colors.white54)),

                        onTap: () {
                          setState(() {
                            tc.text = rows[ind]['contact_name'];
                            query = rows[ind]['contact_name'];
                            setResults(query);
                          });
                        },
                      ));
                    },
                  )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: results.length,
                    itemBuilder: (con, ind) {
                      return Card(color: Colors.black12,child: ListTile(
                        title: Text(results[ind]['contact_name'],style: TextStyle(color: Colors.white)),
                        subtitle: Text(results[ind]['contact_phone'],style: TextStyle(color: Colors.white54)),

                        onTap: () {
                          setState(() {
                            tc.text = results[ind]['contact_name'];
                            query = results[ind]['contact_name'];
                            setResults(query);
                          });
                        },
                      ));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void setResults(String query) {
    results = rows
        .where((elem) =>
    elem['contact_name']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem['contact_phone']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }
}