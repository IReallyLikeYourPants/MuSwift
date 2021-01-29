import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:prova_app/museumPage.dart';

class Home extends StatelessWidget {

  List musei;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("HomePage"),
          ),
          body: Container(
              child: SingleChildScrollView( // Per evitare "bottom overflowed pixel"
                  child: Column( // Per mettere più liste una sotto l'altra
                    children: <Widget> [
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 8.0, top: 20.0), // padding è lo spazio vuoto
                            child: new Text(
                              'Opere più viste',
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                            )
                        ),
                      ),
                      Container(
                          height: 230,
                          child: FutureBuilder(
                            future: DefaultAssetBundle.of(context).loadString('assets/loadjson/opere.json'),
                            builder: (context, snapshot){
                              var newOpere = json.decode(snapshot.data.toString());

                              return ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: newOpere == null ? 0 : newOpere.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                    onTap: (){

                                    },
                                    child: Container( // primo elemento della prima lista di opere
                                      margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: Colors.purple[600],
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
                                          alignment: Alignment(-0.40, 0.90),
                                          child: Text(newOpere[index]['title'], style: TextStyle(fontSize: 18, color: Colors.white),)
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                      ),
                      Divider(),
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 8.0, top: 20.0), // padding è lo spazio vuoto
                            child: new Text(
                              'Musei più visitati',
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                            )
                        ),
                      ),
                      Container(
                          height: 230,
                          child: FutureBuilder(
                            future: DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json'),
                            builder: (context, snapshot){
                              var newMuseo = json.decode(snapshot.data.toString());

                              return ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: newMuseo == null ? 0 : newMuseo.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => museumPage(
                                                /*    prezzo = price;
                                                      luogo = address;
                                                      orario = schedule;
                                                      numero = number;
                                                      sito = site;
                                                      storia = story;
                                                      immagine = img;*/
                                                  newMuseo[index]['title'],
                                                newMuseo[index]['prezzo'],
                                                newMuseo[index]['luogo'],
                                                newMuseo[index]['orario'],
                                                newMuseo[index]['numero'],
                                                newMuseo[index]['sito'],
                                                newMuseo[index]['storia'],
                                                newMuseo[index]['img'],

                                              )
                                          )
                                      );//IMPLEMENTARE ANDATA
                                    },
                                    child: Container( // primo elemento della prima lista di opere
                                      margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: Colors.purple[600],
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
                                          alignment: Alignment(-0.40, 0.90),
                                          child: Text(newMuseo[index]['title'], style: TextStyle(fontSize: 18, color: Colors.white),)
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                      ),
                      Divider(), // linea separatrice
                      new Align(
                        alignment: Alignment.centerLeft,
                        child: new Padding(
                            padding: new EdgeInsets.only(left: 8.0, top: 20.0), // padding è lo spazio vuoto
                            child: new Text(
                              'Musei nei dintorni',
                              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                            )
                        ),
                      ),
                      Container(
                          height: 230,
                          child: FutureBuilder(
                            future: DefaultAssetBundle.of(context).loadString('assets/loadjson/viste.json'),
                            builder: (context, snapshot){
                              var newViste = json.decode(snapshot.data.toString());

                              return ListView.builder(
                                padding: EdgeInsets.all(10.0),
                                scrollDirection: Axis.horizontal,
                                itemCount: newViste == null ? 0 : newViste.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                    onTap: (){
                                      //IMPLEMENTARE ANDATA
                                    },
                                    child: Container( // primo elemento della prima lista di opere
                                      margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                                      width: 145,
                                      decoration: BoxDecoration(
                                        color: Colors.purple[600],
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
                                          alignment: Alignment(-0.40, 0.90),
                                          child: Text(newViste[index]['title'], style: TextStyle(fontSize: 18, color: Colors.white),)
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
      ),
    );
  }
}
