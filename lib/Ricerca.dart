import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';

import 'package:prova_app/Details/operaDetails3.dart';
import 'museoPage.dart';

const statusBarColor = Colors.white;
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

    Future<Map<String, String>> loadJson() async {
      final jsonA = await DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json');
      final jsonB = await DefaultAssetBundle.of(context).loadString('assets/loadjson/opere.json');
      return {
        'jsonMusei': jsonA,
        'jsonOpere': jsonB
      };
    }

    return  Container(
        color: statusBarColor,
        child: SafeArea(
            child: FutureBuilder(
                future: loadJson(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    var rows = json.decode(snapshot.data['jsonMusei'].toString());
                    rows = new List<dynamic>.from(rows)..addAll(json.decode(snapshot.data['jsonOpere'].toString()));
                    print(rows.runtimeType);
                    return Scaffold(
                      backgroundColor: backroundColor,
                      body: Container(
                        padding: EdgeInsets.only(top:10),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: TextField(
                                        //style: TextStyle(color: Colors.grey),

                                        controller: tc,
                                        decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.search),
                                            hintText: searchbarText,
                                            hintStyle: TextStyle(color: searchbarTextColor),
                                            suffixIcon: IconButton(
                                              onPressed: () => tc.clear(),
                                              icon: Icon(Icons.clear),
                                            ),

                                        ),
                                        onChanged: (v) {
                                          setState(() {
                                            query = v;
                                            setResults(query,rows);
                                          });
                                        },
                                      )),

                                    ],
                                  ),
                                ),  //SearchBar
                                query.isEmpty ?
                                Expanded(
                                    child:
                                    Column(children : [
                                      //SizedBox(width: double.infinity,child: Text("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                                      //Divider(color: Colors.black54,),
                                      Expanded (child :
                                      ListView.builder(
                                        padding: EdgeInsets.only(top:10.0),
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
                                                subtitle: Text(rows[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                onTap: () {
                                                  if(results[ind]['tipo'] == "museo") {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                museoPage(
                                                                  rows[ind]['title'],
                                                                  rows[ind]['img'],
                                                                  rows[ind]['rate'],
                                                                )
                                                        )
                                                    );
                                                  }
                                                  else Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => operaDetails3(results[ind]['img'], results[ind]['title'])
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
                                                  padding: EdgeInsets.only(top:10.0),
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
                                                      subtitle: Text(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                      onTap: () {
                                                        if(results[ind]['tipo'] == "museo") {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      museoPage(
                                                                        rows[ind]['title'],
                                                                        rows[ind]['img'],
                                                                        rows[ind]['rate'],
                                                                      )
                                                              )
                                                          );
                                                        }
                                                        else Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => operaDetails3(results[ind]['img'], results[ind]['title'])
                                                            )
                                                        );
                                                      },
                                                    ));
                                                  },
                                                ), // TUTTO TAB
                                                ListView.builder(
                                                  padding: EdgeInsets.only(top:10.0),
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
                                                        subtitle: Text(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => museoPage(
                                                                    results[ind]['title'],
                                                                    results[ind]['img'],
                                                                    results[ind]['rate'],
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
                                                  padding: EdgeInsets.only(top:10.0),
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
                                                        subtitle: Text(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => operaDetails3(results[ind]['img'], results[ind]['title'])
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
                  return Container();
                }
            )
        )
    );
  }

  void setResults(String query,var rowss) {
    results = rowss
        .where((elem) =>
    elem['title']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem['nav'].toString()
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

  }
}

