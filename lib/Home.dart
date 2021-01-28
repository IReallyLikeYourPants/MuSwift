import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Home",
            style: TextStyle( color: Colors.amber[800]),),
            backgroundColor: Color.fromRGBO(0, 0, 0, 30),
          ),
          body: Container(
            color: Colors.black,
            child: SingleChildScrollView( // Per evitare "bottom overflowed pixel"
                child: Column( // Per mettere più liste una sotto l'altra
                  children: <Widget> [
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: 8.0, top: 20.0), // padding è lo spazio vuoto
                          child: new Text(
                            'Opere più viste',
                            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber[800], fontStyle: FontStyle.normal),
                          )),
                    ),
                    Container(
                        height: 230,
                        child: ListView(
                          padding: EdgeInsets.all(10.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container( // primo elemento della prima lista di opere
                              margin: EdgeInsets.only(right: 10.0), // il bordo tra un'opera e l'altra
                              width: 145,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(50, 50, 50, 130),
                                borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                    new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                                image: new DecorationImage( // per metterci l'immagine dentro
                                  image: new ExactAssetImage(
                                    'assets/images/deposizione.jpg',
                                  ),
                                  fit: BoxFit.cover, // per adattarla al container
                                )
                              ),
                              child: Align( // per allineare la scritta in una posizione specifica
                                alignment: Alignment(-0.40, 0.90),
                                child: Text('Deposizione', style: TextStyle(fontSize: 18, color: Colors.white),)
                             ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                          ],

                        )
                    ),
                    Divider(),
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: 8.0, top: 20.0),
                          child: new Text(
                            'Musei più visitati',
                            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber[800]),
                          )),
                    ),
                    Container(
                        height: 230,
                        child: ListView(
                          padding: EdgeInsets.all(10.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                          ],

                        )
                    ),
                    Divider(), // linea separatrice
                    new Align(
                      alignment: Alignment.centerLeft,
                      child: new Padding(
                          padding: new EdgeInsets.only(left: 8.0, top: 16.0),
                          child: new Text(
                            'Musei vicino a te',
                            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.amber[800]),
                          )),
                    ),
                    Container(
                        height: 230,
                        child: ListView(
                          padding: EdgeInsets.all(10.0),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              width: 145,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                            Container(
                              width: 145,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(50, 50, 50, 130),
                                  borderRadius: new BorderRadius.all(
                                      new Radius.circular(5.0)),
                                /*boxShadow: [ // per l'ombra
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  )
                                ], */
                              ),
                              child: const Center(child: Text('In arrivo!', style: TextStyle(fontSize: 18, color: Colors.white),)),
                            ),
                          ],

                        )
                    ),
                    Divider(),
                  ],
                )

            )

          )
      ),
    );
  }
}
