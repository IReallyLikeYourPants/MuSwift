import "package:flutter/material.dart";



class Ricerca extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Ricerca> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Ricerca"),
        ),
        body: new Center(
            child: new Text("this is ricerca")
        )
    );
  }
}
