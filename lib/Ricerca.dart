import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';

import 'museumPage.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json'),
        builder: (context, snapshot){

          var rows = json.decode(snapshot.data.toString());
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(
              backgroundColor: Colors.black54,
              //leading: IconButton(
              //icon: Icon(Icons.search),color: Colors.white,),
              title: new Text(
                "MuSwift",
                style: new TextStyle(
                  color: Colors.white.withOpacity(0.4),

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
                                hintStyle: TextStyle(color: Colors.white)
                            ),
                            onChanged: (v) {
                              setState(() {
                                query = v;
                                setResults(query,rows);
                              });
                            },
                          ),
                          data: new ThemeData( //colore della search bar
                              primaryColor: Colors.black54,
                              accentColor: Colors.orange,
                              hintColor: Colors.black54
                          ),
                        ),
                      ),


                      query.isEmpty ?
                      Expanded(
                          child: Column(children : [
                            SizedBox(width: double.infinity,child: Text("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                            Divider(color: Colors.black54,),
                            Expanded (child :
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: rows == null ? 0 : rows.length,
                              itemBuilder: (con, ind) {
                                return Card (color: Colors.black12,
                                    child: ListTile(
                                      leading: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: 60,
                                          minHeight: 60,
                                          maxWidth: 60,
                                          maxHeight: 60,
                                        ),
                                        child: Image.asset(rows[ind]['img'].toString(), fit: BoxFit.cover),
                                      ),
                                      title: Text(rows[ind]['title'],style: TextStyle(color: Colors.white)),
                                      subtitle: Text(rows[ind]['rate'].toString(),style: TextStyle(color: Colors.white54)),

                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => museumPage(
                                                  rows[ind]['title'],
                                                  rows[ind]['img'],
                                                  rows[ind]['rate'],
                                                )
                                            )
                                        );
                                      },
                                    ));
                              },
                            ))]))
                          : Expanded(
                          child:ListView.builder(
                            shrinkWrap: true,
                            itemCount: results.length,
                            itemBuilder: (con, ind) {
                              return Card(color: Colors.black12,child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 60,
                                    maxWidth: 60,
                                    maxHeight: 60,
                                  ),
                                  child: Image.asset(rows[ind]['img'].toString(), fit: BoxFit.cover),
                                ),
                                title: Text(results[ind]['title'],style: TextStyle(color: Colors.white)),
                                subtitle: Text(results[ind]['rate'].toString(),style: TextStyle(color: Colors.white54)),

                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => museumPage(
                                            rows[ind]['title'],
                                            rows[ind]['img'],
                                            rows[ind]['rate'],
                                          )
                                      )
                                  );
                                },
                              ));
                            },
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  void setResults(String query,var rowss) {
    results = rowss
        .where((elem) =>
    elem['title']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem['rate'].toString()
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

  }
}