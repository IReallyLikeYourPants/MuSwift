import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';

import 'museoPage.dart';

const appbarColor = Colors.black54;
const backroundColor = Colors.white;

const searchbarPrimaryColor = Colors.black;
const searchbarHintColor = Colors.black;
const searchbarTextColor = Colors.black;
const searchbarText = "Search...";

const listviewCardColor = Colors.grey;
const listviewTitleColor = Colors.white;
const listviewSubtitleColor = Colors.white;
const double listviewImgSize = 60;


class Post {
  final String title;
  final String description;

  Post(this.title, this.description);
}

class Ricerca extends StatefulWidget {
  @override
  StorageUploadState createState() => new StorageUploadState();

}



class StorageUploadState extends State<Ricerca> with TickerProviderStateMixin{

  TabController _tabController;

  List results = [];
  var rows = [];
  String query = '';
  TextEditingController tc;

  @override
  void initState() {
    super.initState();
    tc = TextEditingController();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json'),
        builder: (context, snapshot){

          var rows = json.decode(snapshot.data.toString());
          return Scaffold(
            backgroundColor: backroundColor,
            appBar: new AppBar(
              backgroundColor: appbarColor,
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
                                hintText: searchbarText,
                                hintStyle: TextStyle(color: searchbarTextColor)
                            ),
                            onChanged: (v) {
                              setState(() {
                                query = v;
                                setResults(query,rows);
                              });
                            },
                          ),
                          data: new ThemeData( //colore della search bar
                              primaryColor: searchbarPrimaryColor,
                              //accentColor: Colors.orange,
                              hintColor: searchbarHintColor
                          ),
                        ),
                      ),  //SearchBar
                      query.isEmpty ?
                      Expanded(
                          child: Column(children : [
                            //SizedBox(width: double.infinity,child: Text("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                            //Divider(color: Colors.black54,),
                            Expanded (child :
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: rows == null ? 0 : rows.length,
                              itemBuilder: (con, ind) {
                                return Card (color: Colors.black12,
                                    child: ListTile(
                                      leading: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minWidth: listviewImgSize,
                                          minHeight: listviewImgSize,
                                          maxWidth: listviewImgSize,
                                          maxHeight: listviewImgSize,
                                        ),
                                        child: Image.asset(rows[ind]['img'].toString(), fit: BoxFit.cover),
                                      ),
                                      title: Text(rows[ind]['title'],style: TextStyle(color: listviewTitleColor)),
                                      subtitle: Text(rows[ind]['rate'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => museoPage(
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
                          child: Column(children : [
                            //SizedBox(width: double.infinity,child: Text("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                            //Divider(color: Colors.black54,),
                            TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.blue,
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.black,
                              tabs: <Widget>[
                                Tab(
                                  child: Text(
                                    "TUTTO",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                ), // TUTTO TAB
                                Tab(
                                  child: Text(
                                    "MUSEI",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                ), // MUSEI TAB
                                Tab(
                                  child: Text(
                                    "OPERE",
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                ), // OPERE TAB
                              ],
                            ),
                            Expanded(
                                child: TabBarView(
                                    controller : _tabController,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: results.length,
                                        itemBuilder: (con, ind) {
                                          return Card(color: listviewCardColor,child: ListTile(
                                            leading: ConstrainedBox(
                                              constraints: BoxConstraints(
                                                minWidth: listviewImgSize,
                                                minHeight: listviewImgSize,
                                                maxWidth: listviewImgSize,
                                                maxHeight: listviewImgSize,
                                              ),
                                              child: Image.asset(results[ind]['img'].toString(), fit: BoxFit.cover),
                                            ),
                                            title: Text(results[ind]['title'],style: TextStyle(color: listviewTitleColor)),
                                            subtitle: Text(results[ind]['rate'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => museoPage(
                                                        rows[ind]['title'],
                                                        rows[ind]['img'],
                                                        rows[ind]['rate'],
                                                      )
                                                  )
                                              );
                                            },
                                          ));
                                        },
                                      ), // TUTTO TAB
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: results.length,
                                        itemBuilder: (con, ind) {
                                          if (results[ind]["tipo"] == "museo" ){
                                            return Card(color: listviewCardColor,child: ListTile(
                                              leading: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth: listviewImgSize,
                                                  minHeight: listviewImgSize,
                                                  maxWidth: listviewImgSize,
                                                  maxHeight: listviewImgSize,
                                                ),
                                                child: Image.asset(results[ind]['img'].toString(), fit: BoxFit.cover),
                                              ),
                                              title: Text(results[ind]['title'],style: TextStyle(color: listviewTitleColor)),
                                              subtitle: Text(results[ind]['rate'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => museoPage(
                                                          rows[ind]['title'],
                                                          rows[ind]['img'],
                                                          rows[ind]['rate'],
                                                        )
                                                    )
                                                );
                                              },
                                            ));
                                          }
                                          return Container();
                                        },
                                      ), // MUSEI TAB
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: results.length,
                                        itemBuilder: (con, ind) {
                                          if (results[ind]["tipo"] == "opera" ){
                                            return Card(color: listviewCardColor,child: ListTile(
                                              leading: ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minWidth: listviewImgSize,
                                                  minHeight: listviewImgSize,
                                                  maxWidth: listviewImgSize,
                                                  maxHeight: listviewImgSize,
                                                ),
                                                child: Image.asset(results[ind]['img'].toString(), fit: BoxFit.cover),
                                              ),
                                              title: Text(results[ind]['title'],style: TextStyle(color: listviewTitleColor)),
                                              subtitle: Text(results[ind]['rate'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => museoPage(
                                                          rows[ind]['title'],
                                                          rows[ind]['img'],
                                                          rows[ind]['rate'],
                                                        )
                                                    )
                                                );
                                              },
                                            ));
                                          }
                                          return Container();
                                        },
                                      ), // OPERE TAB
                                    ]
                                )
                            )

                          ])),
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

