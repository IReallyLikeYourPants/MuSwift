import "package:flutter/material.dart";



class Biglietti extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Biglietti> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Biglietti"),
        ),
        body: new Center(
            child: new Text("this is biglietti")
        )
    );
  }
}