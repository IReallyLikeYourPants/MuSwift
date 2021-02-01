import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/Object/opera.dart';

const waitValue = 0;

const double bottomHeightPercentage = 0.22;
const Color statusBarColor = Colors.blue;

const double titleFontSizePercentage = 0.0355;
const double subTextFontSizePercentage = 0.025;

const Color titleColorFont = Colors.black;
const Color subTextColorFont = Colors.grey;

const Color descBackgroundColor = Colors.white;

const double textDistancePercentage = 0.01;

Future<String> loadOpereAsset() async {
  return await rootBundle.loadString('assets/loadjson/infomusei.json');
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

class operaDetails extends StatelessWidget {

  String img;

  operaDetails(String immagine){
    this.img = immagine;
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
                      Expanded(child: GestureDetector(
                        child: Center(
                          child: Hero(
                              tag: 'imageHero',
                              child: Container(
                                decoration: BoxDecoration(
                                  image: new DecorationImage( // per metterci l'immagine dentro
                                    image: new AssetImage(img),
                                    fit: BoxFit.cover, // per adattarla al container
                                  ),
                                ),
                              )
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )),
                      Container(
                        height: MediaQuery. of(context). size. height * 0.2,
                      )
                    ]
                ),
                Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container()),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: MediaQuery. of(context). size. height * bottomHeightPercentage,
                        decoration: BoxDecoration(
                            color: descBackgroundColor,
                            borderRadius: BorderRadius.all(Radius.circular(0))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("La deposizione", style: TextStyle(fontSize: MediaQuery. of(context). size. height * titleFontSizePercentage, color: titleColorFont , fontWeight: FontWeight.bold)),
                            SizedBox(height: MediaQuery. of(context). size. height * textDistancePercentage,),
                            Text("Michelangelo Merisi da Caravaggio", style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                            Text("Olio su tela, cm 300 x 203", style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                            Text("1600 - 1604 ac.", style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont)),
                            Text("Musei Vaticani - Roma", style: TextStyle(fontSize: MediaQuery. of(context). size. height * subTextFontSizePercentage, color: subTextColorFont))
                          ],
                        ),
                      )
                    ]
                )
              ],
            )
        ),
      ),
    );
  }
}