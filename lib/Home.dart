import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:prova_app/museoPage.dart';
import 'package:prova_app/Details/operaDetails5.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:sqflite/sqflite.dart';

import 'Ricerca.dart';

//SEGNATE I VALORI PRECEDENTI SE CAMBIATE
//USATE LE PROPORZIONI DOVE POSSIBILE
//Altezza e larghezza degli item nei grid. PRIMA ERANO A 145-230
const itemWidthPercentage = 0.33;
const itemHeightPercentage = 0.27;

const FontWeight titleFontWeight = FontWeight.bold;
const double titleFontSize = 17;
const Color titleFontColor = Colors.black;

const double itemTitleFontSize = 15;
const Color itemFontColor = Colors.white;
const String itemBackgroundColor = "111B22";
const double itemPadding = 5.0;
const double rowsPadding = 25.0;
const double leftPadding = 10.0;

const Color backgroundColor = null;


class Home extends StatefulWidget {
  @override
  StorageUploadState createState() => new StorageUploadState();
}



class StorageUploadState extends State<Home> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Theme(data: Theme.of(context).copyWith(), child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: AutoSizeText("MuSwift", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                color: Colors.amber[400],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Ricerca()),
                  );
                }
            )
          ],
        ),
        body: Container(
            child: ListView( // Per mettere più liste una sotto l'altra
                  children: <Widget> [
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: leftPadding, top: rowsPadding/2),  // padding è lo spazio vuoto
                          child: new AutoSizeText(
                            'Opere più viste',
                            style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                          )
                      ),
                    ),
                    Divider(),
                    Container(
                        height: MediaQuery.of(context).size.height * itemHeightPercentage,
                        child: FutureBuilder(
                          future: DefaultAssetBundle.of(context).loadString('assets/loadjson/opere.json'),
                          builder: (context, snapshot){
                            var newOpere = json.decode(snapshot.data.toString());

                            return ListView.builder(
                              padding: EdgeInsets.only(left: leftPadding, bottom: rowsPadding),
                              scrollDirection: Axis.horizontal,
                              itemCount: newOpere == null ? 0 : newOpere.length,
                              itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => operaDetails3(newOpere[index]['img'], newOpere[index]['title'])
                                        )
                                    );
                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: HexColor(itemBackgroundColor),
                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                          new Radius.circular(5.0)
                                      ),
                                      image: new DecorationImage( // per metterci l'immagine dentro
                                        image: new ExactAssetImage(
                                          newOpere[index]['img'],
                                        ),
                                        fit: BoxFit.cover, // per adattarla al container
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    child: Align( // per allineare la scritta in una posizione specifica
                                        alignment: Alignment.bottomLeft,
                                        child: AutoSizeText(newOpere[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                    ),
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: leftPadding), // padding è lo spazio vuoto
                          child: new AutoSizeText(
                            'Musei più visitati',
                            style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                          )
                      ),
                    ),
                    Divider(),
                    Container(
                        height: MediaQuery.of(context).size.height * itemHeightPercentage,
                        child: FutureBuilder(
                          future: DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json'),
                          builder: (context, snapshot){
                            var newMuseo = json.decode(snapshot.data.toString());

                            return ListView.builder(
                              padding: EdgeInsets.only(left: leftPadding, bottom: rowsPadding),
                              scrollDirection: Axis.horizontal,
                              itemCount: newMuseo == null ? 0 : newMuseo.length,
                              itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => museoPage(
                                              newMuseo[index]['title'],
                                            )
                                        )
                                    );
                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: HexColor(itemBackgroundColor),
                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                          new Radius.circular(5.0)
                                      ),
                                      image: new DecorationImage( // per metterci l'immagine dentro
                                        image: new ExactAssetImage(
                                          newMuseo[index]['img'],
                                        ),
                                        fit: BoxFit.cover, // per adattarla al container
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    child: Align( // per allineare la scritta in una posizione specifica
                                        alignment: Alignment.bottomLeft,
                                        child: AutoSizeText(newMuseo[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                    ),
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: leftPadding), // padding è lo spazio vuoto
                          child: new AutoSizeText(
                            'Musei preferiti',
                            style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                          )
                      ),
                    ),
                    Divider(),
                    preferiti.isEmpty ?
                    Container(
                        height: MediaQuery.of(context).size.height * itemHeightPercentage,
                        child: Expanded(child: FutureBuilder(
                          future: DefaultAssetBundle.of(context).loadString('assets/loadjson/viste.json'),
                          builder: (context, snapshot){
                            var newViste = json.decode(snapshot.data.toString());

                            return ListView.builder(
                              padding: EdgeInsets.only(left: leftPadding, bottom: rowsPadding/2),
                              scrollDirection: Axis.horizontal,
                              itemCount: newViste == null ? 0 : newViste.length,
                              itemBuilder: (BuildContext context, int index){
                                return GestureDetector(
                                  onTap: (){

                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altraZ
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: HexColor(itemBackgroundColor),
                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                          new Radius.circular(5.0)
                                      ),
                                      image: new DecorationImage( // per metterci l'immagine dentro
                                        image: new ExactAssetImage(
                                          newViste[index]['img'],
                                        ),
                                        fit: BoxFit.cover, // per adattarla al container
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    ),
                                    child: Align( // per allineare la scritta in una posizione specifica
                                        alignment: Alignment.bottomLeft,
                                        child: AutoSizeText(newViste[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ))
                    ):
                    Container(
                      height: MediaQuery.of(context).size.height * itemHeightPercentage,
                      child: Expanded(child: FutureBuilder(
                        builder: (context,snapshot) {
                          return ListView.builder(
                            padding: EdgeInsets.only(left: leftPadding, bottom: rowsPadding),
                            scrollDirection: Axis.horizontal,
                            itemCount: preferiti == null ? 0 : preferiti.length,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                onTap: (){
                                  if (operePreferite.contains(preferiti[index])){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => operaDetails3(immaginiPreferiti[index], preferiti[index])
                                        ));
                                  }
                                  else Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => museoPage(preferiti[index])
                                      )
                                  );
                                },
                                child: Container( // primo elemento della prima lista di opere
                                  padding: EdgeInsets.all(itemPadding),
                                  margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                  width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                  decoration: BoxDecoration(
                                    color: HexColor(itemBackgroundColor),
                                    borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                        new Radius.circular(5.0)
                                    ),
                                    image: new DecorationImage( // per metterci l'immagine dentro
                                      image: new ExactAssetImage(
                                          immaginiPreferiti[index]
                                      ),
                                      fit: BoxFit.cover, // per adattarla al container
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      )
                                    ],
                                  ),
                                  child: Align( // per allineare la scritta in una posizione specifica
                                      alignment: Alignment.bottomLeft,
                                      child: AutoSizeText(preferiti[index], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
                                  ),
                                ),
                              );
                            },
                          );
                        },

                      ))
                    ),
                  ],
                )

            )

        )
    );
  }
}
