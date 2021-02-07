import 'package:flutter/material.dart';
import 'package:prova_app/Biglietti.dart';
import 'package:prova_app/Ricerca.dart';
import 'package:prova_app/Mappa.dart';
import 'package:prova_app/Home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:permission/permission.dart';

List isBooked = [];

const double iconSize = 30;

void main()
{
  runApp
    (
      MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp
      (
      home: MyBottomNavigationBar(),
    );
  }
}


class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [Home(),Mappa(),Biglietti()];

  void onTappedBar(int index)
  {
    setState(()
    {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: _children[_currentIndex],

      bottomNavigationBar: BottomNavigationBar
        (
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: HexColor("FFA62B"),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: iconSize,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: new Icon(Icons.home),
                title: Container()),
            BottomNavigationBarItem(icon: new Icon(Icons.map),
                title: Container()),
            BottomNavigationBarItem(icon: new Icon(Icons.book),
                title: Container())
          ]
      ),
    );
  }
}

