import 'package:flutter/material.dart';
import 'package:prova_app/Biglietti.dart';
import 'package:prova_app/Ricerca.dart';
import 'package:prova_app/Mappa.dart';
import 'package:prova_app/Home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';



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
      theme: ThemeData(
        //textTheme: GoogleFonts.sirinStencilTextTheme(Theme.of(context).textTheme)
          textTheme: GoogleFonts.robotoTextTheme((Theme.of(context).textTheme))

      ),
    );
  }
}


class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [Home(),Ricerca(),Mappa(),Biglietti()];

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
          selectedItemColor: HexColor("FFCB05"),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          iconSize: 25,
          unselectedItemColor: Colors.black54,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: new Icon(Icons.home),
                title: new Text("Home"))
            ,
            BottomNavigationBarItem(icon: new Icon(Icons.search),
                title: new Text("Ricerca"))
            ,
            BottomNavigationBarItem(icon: new Icon(Icons.map),
                title: new Text("Mappa")),
            BottomNavigationBarItem(icon: new Icon(Icons.book),
                title: new Text("Biglietti"))
          ]
      ),
    );
  }
}

