import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/Object/opera.dart';
import 'package:hexcolor/hexcolor.dart';

const waitValue = 0;

const int animationMilliseconds = 300;
const double bottomHeightPercentage = 0.13;
const double initalScrollPercentage = 0.13;
const Color statusBarColor = Colors.white;

const double titleFontSizePercentage = 0.0355;
const double subTextFontSizePercentage = 0.025;

const Color titleColorFont = Colors.black;
const Color subTextColorFont = Colors.black87;

const double opacity = 1;
const Color descContainerColor = Colors.white;
const String backgroundHexColor = "#FAFAFA";

const double textDistancePercentage = 0.01;

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
    return Container(
      color: statusBarColor,
      child: SafeArea(
        child: Scaffold(
            body: Stack(
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Center(
                        child: Hero(
                            tag: titolo,
                            child: Container(
                              decoration: BoxDecoration(
                                image: new DecorationImage( // per metterci l'immagine dentro
                                  image: new AssetImage(img),
                                  fit: BoxFit.cover, // per adattarla al container
                                ),
                              ),
                            )
                        ),
                      )),
                    ]
                ),
                moreInfo()
              ],
            )
        ),
      ),
    );
  }
}

class moreInfo extends StatefulWidget {
  @override
  _moreInfoState createState() => new _moreInfoState();
}

class _moreInfoState extends State<moreInfo>{
  ScrollController _scrollController = ScrollController(initialScrollOffset: 100);

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
                  if(_scrollController.position.pixels == 0.0 ){
                    Navigator.pop(context);
                  }
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: animationMilliseconds),
                  );
                },
                child: Container(color: Colors.transparent, height: MediaQuery. of(context). size. height * (1 - bottomHeightPercentage),),
              ),
              GestureDetector(
                onTap: (){
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
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
                      Text(titolo, style: TextStyle(fontSize: MediaQuery. of(context). size. height * titleFontSizePercentage, color: titleColorFont , fontWeight: FontWeight.bold)),
                      SizedBox(height: MediaQuery. of(context). size. height * textDistancePercentage,),
                      Text(snapshot.data.autore, style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                      Text(snapshot.data.tipo, style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                      Text(snapshot.data.anno, style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                      Text(snapshot.data.nav, style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont))
                    ],
                  ),
                ),
              )
            ],
          );
          return Container();
        }
    );
  }

}