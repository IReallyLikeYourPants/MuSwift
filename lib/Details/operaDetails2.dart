import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:prova_app/Object/opera.dart';

const waitValue = 0;

const int animationMilliseconds = 300;
const double bottomHeightPercentage = 0.24;
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

class operaDetails2 extends StatelessWidget {

  String img;

  operaDetails2(String immagine){
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
                      Expanded(child: Center(
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
                      )),
                      Container(
                        height: MediaQuery. of(context). size. height * (bottomHeightPercentage - 0.05),
                      )
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
  ScrollController _scrollController = new ScrollController();

  Widget build(BuildContext context){
    return ListView(
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
            height: 300,
            decoration: BoxDecoration(
                color: descBackgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(15))
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
          ),
        )
      ],
    );
  }

}