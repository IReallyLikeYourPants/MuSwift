import "package:flutter/material.dart";



class Mappa extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Mappa> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Mappa"),
        ),
        body: new Center(
            child: new Text("this is mappa")
        )
    );
  }
}