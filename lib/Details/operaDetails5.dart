import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/Object/opera.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prova_app/museoPage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:prova_app/Details/storia.dart';

const waitValue = 0;

const int animationMilliseconds = 300;
const double dropDownPixelPercentage = 0.86;
const double bottomHeightPercentage = 0.32;
const double initalScrollPercentage = 0.13;
const Color statusBarColor = Colors.white;

const double titleFontSize = 20;
const double subTextFontSize = 17;

const Color titleColorFont = Colors.black;
const Color subTextColorFont = Colors.black87;

const double opacity = 1;
const Color descContainerColor = Colors.white;
const String backgroundHexColor = "#FAFAFA";

const double textDistancePercentage = 0.01;

const FontWeight titleFontWeight = FontWeight.bold;

Future<String> loadOpereAsset() async {
  return await rootBundle.loadString('assets/loadjson/infoopere.json');
}
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}
Future loadOpera(String nome) async {
  await wait(waitValue);
  String jsonString = await loadOpereAsset();
  final jsonResponse = json.decode(jsonString);
  return new opera.fromJson(jsonResponse, nome);
}

String img;
String titolo;

class operaDetails3 extends StatelessWidget {

  operaDetails3(String immagine, String nome){
    img = immagine;
    titolo = nome;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: AutoSizeText("Info", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          backgroundColor: Colors.white,
          actions: [
            favorite()
          ],
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Hero(
                tag: titolo,
                child: Container(
                  height: MediaQuery. of(context). size. height * (1.1 - bottomHeightPercentage),
                  decoration: BoxDecoration(
                    image: new DecorationImage( // per metterci l'immagine dentro
                        image: new AssetImage(img),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter// per adattarla al container
                    ),
                  ),
                )
            ),
            moreInfo(),
          ],
        )
    );
  }
}

class moreInfo extends StatefulWidget {
  @override
  _moreInfoState createState() => new _moreInfoState();
}

class _moreInfoState extends State<moreInfo>{
  ScrollController _scrollController = ScrollController();

  bool isDropped = true;

  void dropping(){
    setState(() {
      isDropped = !isDropped;
    });
  }

  Widget dropDown(){
    if(isDropped){
      return Icon(Icons.keyboard_arrow_down, size: 30,);
    }
    return Container();
  }

  Widget build(BuildContext context){
    return FutureBuilder(
        future: loadOpera(titolo),
        builder: (context, snapshot){
          if(snapshot.hasData) return ListView(
            controller: _scrollController,
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  isDropped = false;
                  dropping();
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: animationMilliseconds),
                  );
                },
                child: Container(color: Colors.transparent, height: MediaQuery. of(context). size. height * (1 - bottomHeightPercentage)),
              ),
              GestureDetector(
                onTap: (){
                  if(isDropped){
                    dropping();
                    _scrollController.animateTo(
                      MediaQuery. of(context). size. height * dropDownPixelPercentage,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: animationMilliseconds),
                    );
                  }
                  else{
                    dropping();
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: animationMilliseconds),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: HexColor(backgroundHexColor),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(titolo, style: TextStyle(fontSize: titleFontSize, color: titleColorFont , fontWeight: FontWeight.bold)),
                      SizedBox(height: MediaQuery. of(context). size. height * textDistancePercentage,),
                      AutoSizeText(snapshot.data.autore, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      AutoSizeText(snapshot.data.tipo, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      AutoSizeText(snapshot.data.anno, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      AutoSizeText(snapshot.data.nav, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      Container(
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                                dropping();
                            },
                            child: dropDown(),
                          )
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(),
                      AutoSizeText("Stile", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      AutoSizeText(snapshot.data.stile, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 20),
                      Divider(),
                      AutoSizeText("Storia", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      Text(snapshot.data.storia, maxLines: 3, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 5,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new PageRouteBuilder(
                                      opaque: true,
                                      transitionDuration: Duration(milliseconds: 225),
                                      pageBuilder: (BuildContext context, _, __) {
                                        return new storia('Storia', titolo ,snapshot.data.storia);
                                      },
                                      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {

                                        return new SlideTransition(
                                          child: child,
                                          position: new Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                        );
                                      }
                                  )
                                  );
                                },
                                child: AutoSizeText(
                                  "...leggi di più",
                                  style: TextStyle(fontSize: subTextFontSize, color: readMoreColor, fontWeight: FontWeight.bold) ,
                                )
                            )
                          ]
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      AutoSizeText("Autore", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      Text(snapshot.data.autore_storia, maxLines: 3, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 5,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){
                                  Navigator.of(context).push(new PageRouteBuilder(
                                      opaque: true,
                                      transitionDuration: Duration(milliseconds: 225),
                                      pageBuilder: (BuildContext context, _, __) {
                                        return new storia('Autore' , snapshot.data.autore_real , snapshot.data.autore_storia);
                                      },
                                      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {

                                        return new SlideTransition(
                                          child: child,
                                          position: new Tween<Offset>(
                                            begin: const Offset(1, 0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                        );
                                      }
                                  )
                                  );
                                },
                                child: AutoSizeText(
                                  "...leggi di più",
                                  style: TextStyle(fontSize: subTextFontSize, color: readMoreColor, fontWeight: FontWeight.bold) ,
                                )
                            )
                          ]
                      ),
                      SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: buttonColor,
                                          elevation: elevationButton
                                      ),
                                      onPressed: () {
                                        print(snapshot.data.nav_real);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => museoPage(snapshot.data.nav_real)
                                            )
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          "MUSEO",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: textButtonColor,
                                              fontWeight: buttonFontWeight
                                          ),
                                        ),
                                      )
                                  )
                              )
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * buttonDistancePercentage,),
                          Expanded(
                              child: Center(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          elevation: elevationButton
                                      ),
                                      onPressed: () {
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          "MAPPA",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: buttonFontWeight
                                          ),
                                        ),
                                      )
                                  )
                              )
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],
          );
          return Container();
        }
    );
  }

}

class favorite extends StatefulWidget {
  @override
  _favoriteState createState() => new _favoriteState();
}

class _favoriteState extends State<favorite>{

  Widget build(BuildContext context){
    return FavoriteButton(
      iconSize: 40,
      isFavorite: preferiti.contains(titolo) ? true : false,
      valueChanged: (_isFavorite) {
        print(preferiti);
        print(immaginiPreferiti);
        if (_isFavorite == true){
          setState((){
            preferiti.add(titolo);
            immaginiPreferiti.add(img);
            operePreferite.add(titolo);
            immaginiOperePreferite.add(img);
          });
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Opera aggiunto ai preferiti')));
        }
        else {
          setState((){
            preferiti.remove(titolo);
            immaginiPreferiti.remove(img);
            operePreferite.remove(titolo);
            immaginiOperePreferite.remove(img);
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('Opera rimossa dai preferiti')));
          });
        };

      },
    );
  }
}



