import 'dart:convert';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:hexcolor/hexcolor.dart';
import 'package:prova_app/Home.dart';
import 'package:sqflite/sqflite.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:prova_app/Details/operaDetails5.dart';
import 'museoPage.dart';

const statusBarColor = Colors.white;
const String backroundColor = "FAFAFA";
const String textFieldColor = "FAFAFA";
const String barColor = "FFFFFF";

const searchbarPrimaryColor = Colors.black;
const searchbarHintColor = Colors.black;
const searchbarTextColor = Colors.black;
const searchbarText = "Ricerca...";

const listviewCardColor = Colors.white;
const listviewTitleColor = Colors.black;
const listviewSubtitleColor = Colors.black;
const double listviewImgSize = 60;

const double tabsFontSize = 15;

const double itemImageSizeHeight = 60;
const double itemImageSizeWidth = 60;
const double roundedValue = 10;

const Color tabTextColor = Colors.blueGrey;
const Color tabActiveTextColor = Colors.black;
const Color tabIndicatorColor = Colors.black;

const double titleFontSize = 20;
const Color titleFontColor = Colors.black;
const FontWeight titleFontWeight = FontWeight.bold;

List recenti = [];
List titoli = [];
List ricercheRecenti = [];
var rows = [];

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
  String yo = '';
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

  /*Widget buildSuggestions(BuildContext context) {
    final suggestionList = ricercheRecenti.isEmpty ? ricercheRecenti : [];
    return ListView.builder(
        itemBuilder: (context,index) => ListTile(
          leading: Icon(Icons.history),
          title: Text(suggestionList[index])
        ),
        itemCount: ricercheRecenti.length,

    );
  }*/

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
    return Theme(data: Theme.of(context).copyWith(), child: Container(
        color: statusBarColor,
        child: SafeArea(
            child: FutureBuilder(
                future: loadJson(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    var rows = json.decode(snapshot.data['jsonMusei'].toString());
                    rows = new List<dynamic>.from(rows)..addAll(json.decode(snapshot.data['jsonOpere'].toString()));

                    return Scaffold(
                      appBar: yo.isEmpty ?
                      AppBar( //yo serve per risolvere un bug
                        leading: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.black,),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        backgroundColor: HexColor(barColor),
                        title: Theme(
                            child : Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: HexColor(textFieldColor),
                                borderRadius:  BorderRadius.circular(10),
                              ),
                              child: TextField(
                                //style: TextStyle(color: Colors.grey),
                                autofocus: true,
                                controller: tc,
                                decoration: InputDecoration(
                                  fillColor: Colors.green,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,

                                  //contentPadding: EdgeInsets.only(left: 2),

                                  hintText: searchbarText,
                                  hintStyle: TextStyle(color: searchbarTextColor),
                                  suffixIcon: IconButton(
                                    onPressed: () => tc.clear(),
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                onChanged: (t){
                                  //buildSuggestions(context);
                                  setState(() {
                                    query = t;
                                    setResults(query,rows);
                                  });
                                },
                                onSubmitted: (v) {
                                  setState(() {
                                    yo = v;
                                    if (ricercheRecenti.contains(v) == false){
                                      ricercheRecenti.add(v);
                                    };
                                    setResults(yo,rows);
                                  });
                                },
                              ),
                            ),
                            data: ThemeData(
                              primaryColor: HexColor("FFCB05"),
                              hintColor: HexColor("FFCB05"),
                            )
                        ),
                      ) :

                      AppBar(
                        leading: GestureDetector(
                          child: Icon(Icons.arrow_back, color: Colors.black,),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        ),
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          controller: _tabController,
                          indicatorColor: tabIndicatorColor,
                          labelColor: tabActiveTextColor,
                          unselectedLabelColor: tabTextColor,
                          tabs: <Widget>[
                            Tab(
                              child: AutoSizeText(
                                "TUTTO",
                                style: TextStyle(
                                    fontSize: tabsFontSize
                                ),
                              ),
                            ), // TUTTO TAB
                            Tab(
                              child: AutoSizeText(
                                "MUSEI",
                                style: TextStyle(
                                    fontSize: tabsFontSize
                                ),
                              ),
                            ), // MUSEI TAB
                            Tab(
                              child: AutoSizeText(
                                "OPERE",
                                style: TextStyle(
                                    fontSize: tabsFontSize
                                ),
                              ),
                            ), // OPERE TAB
                          ],
                        ),
                        title: Theme(
                            child : Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: HexColor(textFieldColor),
                                borderRadius:  BorderRadius.circular(10),
                              ),
                              child: TextField(
                                //style: TextStyle(color: Colors.grey),
                                controller: tc,
                                decoration: InputDecoration(
                                  fillColor: Colors.green,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,

                                  //contentPadding: EdgeInsets.only(left: 2),

                                  hintText: searchbarText,
                                  hintStyle: TextStyle(color: searchbarTextColor),
                                  suffixIcon: IconButton(
                                    onPressed: () => tc.clear(),
                                    icon: Icon(Icons.clear),
                                  ),
                                ),
                                onChanged: (t){
                                  //buildSuggestions(context);
                                  setState(() {
                                    query = t;
                                    setResults(query,rows);
                                  });
                                },
                                onSubmitted: (v) {
                                  setState(() {
                                    yo = v;
                                    if (ricercheRecenti.contains(v) == false){
                                      ricercheRecenti.add(v);
                                    };
                                    setResults(yo,rows);
                                  });
                                },

                              ),
                            ),
                            data: ThemeData(
                              primaryColor: HexColor("FFCB05"),
                              hintColor: HexColor("FFCB05"),
                            )
                        ),
                      ),

                      backgroundColor: HexColor(backroundColor),
                      body: Container(
                        padding: EdgeInsets.only(top:10),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                query.isEmpty ?
                                Expanded(
                                    child:
                                    Column(children : [
                                      titoli.isEmpty ?
                                      Expanded(child:
                                      ListView(children: [
                                        SizedBox(width: double.infinity,child: AutoSizeText(
                                          '  Consigliati',
                                          style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                                        )),
                                        Divider(color: Colors.black54,),
                                        Expanded (child :
                                        ListView.builder(
                                          physics: NeverScrollableScrollPhysics(),
                                          padding: EdgeInsets.only(top:10.0),
                                          shrinkWrap: true,
                                          itemCount: rows.length,
                                          itemBuilder: (con, ind) {
                                            return Container(
                                              padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                              child: Card(color: listviewCardColor,child: ListTile(
                                                leading: Container(
                                                  width: itemImageSizeWidth,
                                                  height: itemImageSizeHeight,
                                                  decoration: BoxDecoration(
                                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                          new Radius.circular(roundedValue)
                                                      ),
                                                      image : DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(rows[ind]['img'].toString())
                                                      )
                                                  ),
                                                ),
                                                title: AutoSizeText(rows[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                subtitle: AutoSizeText(rows[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                onTap: () {
                                                  if(titoli.contains(rows[ind]['title'])==false){
                                                    titoli.add(rows[ind]['title']);
                                                    recenti.insert(0,rows[ind]);

                                                  }

                                                  if(rows[ind]['tipo'] == "museo") {

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                museoPage(
                                                                  rows[ind]['title'],
                                                                )
                                                        )
                                                    );
                                                  }
                                                  else Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => operaDetails3(rows[ind]['img'], rows[ind]['title'])
                                                      )
                                                  );
                                                },
                                              )),
                                            );
                                          },
                                        )),
                                      ],)) :
                                          Expanded(child:
                                          ListView(children: [
                                            SizedBox(width: double.infinity,child: AutoSizeText(
                                              '  Recenti',
                                              style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                                            )),
                                            Divider(color: Colors.black54,),
                                            Expanded (child :
                                            ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(top:10.0),
                                              shrinkWrap: true,
                                              itemCount: recenti == null ? 0 : recenti.length,
                                              itemBuilder: (con, ind) {
                                                return Container(
                                                  padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                                  child : Card (
                                                      color: listviewCardColor,
                                                      child: ListTile(
                                                        leading: Container(
                                                          width: itemImageSizeWidth,
                                                          height: itemImageSizeHeight,
                                                          decoration: BoxDecoration(
                                                              borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                                  new Radius.circular(roundedValue)
                                                              ),
                                                              image : DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: AssetImage(recenti[ind]['img'].toString())
                                                              )
                                                          ),
                                                        ),
                                                        title: AutoSizeText(recenti[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                        subtitle: AutoSizeText(recenti[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                        onTap: () {
                                                          if(recenti[ind]['tipo'] == "museo") {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        museoPage(
                                                                          recenti[ind]['title'],
                                                                        )
                                                                )
                                                            );
                                                          }
                                                          else Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => operaDetails3(recenti[ind]['img'], recenti[ind]['title'])
                                                              )
                                                          );
                                                        },
                                                      ))
                                                );
                                              },
                                            )),

                                            SizedBox(width: double.infinity,child: AutoSizeText(
                                              '  Consigliati',
                                              style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                                            )),
                                            Divider(color: Colors.black54,),
                                            Expanded (child :
                                            ListView.builder(
                                              physics: NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(top:10.0),
                                              shrinkWrap: true,
                                              itemCount: rows.length,
                                              itemBuilder: (con, ind) {
                                                return Container(
                                                  padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                                  child: Card(
                                                      color: listviewCardColor,child:
                                                  ListTile(
                                                    leading: Container(
                                                      width: itemImageSizeWidth,
                                                      height: itemImageSizeHeight,
                                                      decoration: BoxDecoration(
                                                          borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                              new Radius.circular(roundedValue)
                                                          ),
                                                          image : DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: AssetImage(rows[ind]['img'].toString())
                                                          )
                                                      ),
                                                    ),
                                                    title: AutoSizeText(rows[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                    subtitle: AutoSizeText(rows[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                    onTap: () {
                                                      if(titoli.contains(rows[ind]['title'])==false){
                                                        titoli.add(rows[ind]['title']);
                                                        recenti.insert(0,rows[ind]);

                                                      }

                                                      if(rows[ind]['tipo'] == "museo") {

                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    museoPage(
                                                                      rows[ind]['title'],
                                                                    )
                                                            )
                                                        );
                                                      }
                                                      else Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => operaDetails3(rows[ind]['img'], rows[ind]['title'])
                                                          )
                                                      );
                                                    },
                                                  )),
                                                );
                                              },
                                            )),
                                          ],))
                                    ]))
                                    : Expanded(
                                    child: Column(children : [
                                      //SizedBox(width: double.infinity,child: AutoSizeText("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                                      //Divider(color: Colors.black54,),
                                      SizedBox(height: 5,),
                                      Expanded(
                                          child: TabBarView(
                                              controller : _tabController,
                                              children: [
                                                ListView.builder(
                                                  padding: EdgeInsets.only(top:10.0),
                                                  shrinkWrap: true,
                                                  itemCount: results.length,
                                                  itemBuilder: (con, ind) {
                                                    return Container(
                                                        padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                                        child : Card(
                                                        color: listviewCardColor,
                                                        child: ListTile(
                                                      leading: Container(
                                                        width: itemImageSizeWidth,
                                                        height: itemImageSizeHeight,
                                                        decoration: BoxDecoration(
                                                            borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                                new Radius.circular(roundedValue)
                                                            ),
                                                            image : DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: AssetImage(results[ind]['img'].toString())
                                                            )
                                                        ),
                                                      ),
                                                      title: AutoSizeText(results[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                      subtitle: AutoSizeText(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                      onTap: () {
                                                        if(titoli.contains(results[ind]['title'])==false){
                                                          titoli.add(results[ind]['title']);
                                                          recenti.insert(0,results[ind]);

                                                        }

                                                        if(results[ind]['tipo'] == "museo") {

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      museoPage(
                                                                        results[ind]['title'],
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
                                                    )));
                                                  },
                                                ), // TUTTO TAB
                                                ListView.builder(
                                                  padding: EdgeInsets.only(top:10.0),
                                                  shrinkWrap: true,
                                                  itemCount: results.length,
                                                  itemBuilder: (con, ind) {
                                                    if (results[ind]["tipo"] == "museo" ){
                                                      return Container(
                                                          padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                                          child: Card(
                                                          color: listviewCardColor,
                                                          child: ListTile(
                                                        leading: Container(
                                                          width: itemImageSizeWidth,
                                                          height: itemImageSizeHeight,
                                                          decoration: BoxDecoration(
                                                              borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                                  new Radius.circular(roundedValue)
                                                              ),
                                                              image : DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: AssetImage(results[ind]['img'].toString())
                                                              )
                                                          ),
                                                        ),
                                                        title: AutoSizeText(results[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                        subtitle: AutoSizeText(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                        onTap: () {
                                                          if(titoli.contains(results[ind]['title'])==false){
                                                            titoli.add(results[ind]['title']);
                                                            recenti.insert(0,results[ind]);
                                                          }

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => museoPage(
                                                                    results[ind]['title'],
                                                                  )
                                                              )
                                                          );
                                                        },
                                                      )));
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
                                                      return Container(
                                                          padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                                                          child: Card(
                                                          color: listviewCardColor,
                                                          child: ListTile(
                                                        leading: Container(
                                                          width: itemImageSizeWidth,
                                                          height: itemImageSizeHeight,
                                                          decoration: BoxDecoration(
                                                              borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                                  new Radius.circular(roundedValue)
                                                              ),
                                                              image : DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: AssetImage(results[ind]['img'].toString())
                                                              )
                                                          ),
                                                        ),
                                                        title: AutoSizeText(results[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                                        subtitle: AutoSizeText(results[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                                        onTap: () {
                                                          if(titoli.contains(results[ind]['title'])==false){
                                                            titoli.add(results[ind]['title']);
                                                            recenti.insert(0,results[ind]);
                                                          }

                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => operaDetails3(results[ind]['img'], results[ind]['title'])
                                                              )
                                                          );
                                                        },
                                                      )));
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
    ));

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

