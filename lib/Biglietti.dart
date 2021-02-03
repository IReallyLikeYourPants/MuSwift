import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';

class Biglietti extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Biglietti> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new AutoSizeText("Biglietti"),
        ),
        body: new Center(
            child: new AutoSizeText("in Arrivo!")
        )
    );
  }
}