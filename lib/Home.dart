import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:prova_app/museoPage.dart';
import 'package:google_fonts/google_fonts.dart';


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
const Color itemBackgroundColor = Colors.blue;
const double itemPadding = 5.0;
const double rowsPadding = 25.0;
const double leftPadding = 10.0;

const Color backgroundColor = null;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: Theme.of(context).copyWith(), child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text("MuSwift", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          backgroundColor: Colors.white,
        ),
        body: Container(
            child: SingleChildScrollView( // Per evitare "bottom overflowed pixel"
                child: Column( // Per mettere più liste una sotto l'altra
                  children: <Widget> [
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: leftPadding, top: rowsPadding/2),  // padding è lo spazio vuoto
                          child: new Text(
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

                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: itemBackgroundColor,
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
                                        child: Text(newOpere[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
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
                          child: new Text(
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
                                              newMuseo[index]['img'],
                                              newMuseo[index]['rate'],
                                            )
                                        )
                                    );
                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: itemBackgroundColor,
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
                                        child: Text(newMuseo[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
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
                          child: new Text(
                            'Musei nei dintorni',
                            style: new TextStyle(fontWeight: titleFontWeight, fontSize: titleFontSize, color: titleFontColor),
                          )
                      ),
                    ),
                    Divider(),
                    Container(
                        height: MediaQuery.of(context).size.height * itemHeightPercentage,
                        child: FutureBuilder(
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
                                    //IMPLEMENTARE ANDATA
                                  },
                                  child: Container( // primo elemento della prima lista di opere
                                    padding: EdgeInsets.all(itemPadding),
                                    margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altraZ
                                    width: MediaQuery.of(context).size.width * itemWidthPercentage,
                                    decoration: BoxDecoration(
                                      color: itemBackgroundColor,
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
                                        child: Text(newViste[index]['title'], style: TextStyle(fontSize: itemTitleFontSize, color: itemFontColor),)
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                    ),
                  ],
                )

            )

        )
    ));
  }
}
