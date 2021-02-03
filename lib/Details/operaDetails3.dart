import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/Object/opera.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prova_app/museoPage.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        title: AutoSizeText("Storia", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
        backgroundColor: Colors.white,
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
                  _scrollController.animateTo(
                    MediaQuery. of(context). size. height * dropDownPixelPercentage,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: animationMilliseconds),
                  );
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
                      SizedBox(height: 20),
                      AutoSizeText("Stile", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      Divider(),
                      AutoSizeText(snapshot.data.stile, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 20),
                      AutoSizeText("Storia", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      Divider(),
                      Text(snapshot.data.storia, maxLines: 3, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 5,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){

                                },
                                child: AutoSizeText(
                                  "...leggi di più",
                                  style: TextStyle(fontSize: textFontSize, color: readMoreColor, fontWeight: FontWeight.bold) ,
                                )
                            )
                          ]
                      ),
                      AutoSizeText("Autore", style: TextStyle(fontSize: titleFontSize, color: subTextColorFont, fontWeight: FontWeight.bold)),
                      Divider(),
                      Text(snapshot.data.autore_storia, maxLines: 3, style: TextStyle(fontSize: subTextFontSize, color: subTextColorFont)),
                      SizedBox(height: 5,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                                onTap: (){

                                },
                                child: AutoSizeText(
                                  "...leggi di più",
                                  style: TextStyle(fontSize: textFontSize, color: readMoreColor, fontWeight: FontWeight.bold) ,
                                )
                            )
                          ]
                      ),
                      SizedBox(height: 10,),
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
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: AutoSizeText(
                                          "PRENOTA",
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