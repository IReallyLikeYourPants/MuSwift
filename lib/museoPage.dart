import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prova_app/misc/SmoothStarRating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prova_app/Object/museo.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:prova_app/Details/storia.dart';
import 'package:prova_app/prenotazione.dart';
import 'package:prova_app/Details/operaDetails3.dart';
import 'package:prova_app/main.dart';
import 'package:background_app_bar/background_app_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'Home.dart';

const waitValue = 0;
const double textFontSize = 17;
const double titleFontSize = 20;
const double tabTextFontSize = 16;
const double itemFontSize = 16;
const FontWeight titleFontWeight = FontWeight.bold;

const double iconSize = 30;
const double nextIconSize = 30;
const double backIconSize = 35;
const double starIconSize = 20;

const Color tabTextColor = Colors.blueGrey;
const Color tabActiveTextColor = Colors.black;
const Color tabIndicatorColor = Colors.black;

const Color textFontColor = Colors.black;
const Color titleFontColor = Colors.white;
const Color itemFontColor = Colors.white;

const Color textButtonColor = Colors.white;
const Color buttonColor = Colors.blue;
const FontWeight buttonFontWeight = FontWeight.normal;
const double elevationButton = 5;

const double infoMargin = 9;
const Color starIconColor = Colors.white;
const Color iconColor = Colors.black87;
const Color iconGoToColor = Colors.blueGrey;
const Color readMoreColor = Colors.black;

const double itemWidthPercentage = 0.30;
const double itemHeightPercentage = 0.20;
const int itemPerLine = 3;

const double collapsedHeightPercentage = 0.20;
const double expandedHeightPercentage = 0.38;
const double flexBottomPercentage = 0.5;
const int maxLinesStory = 3;

const double buttonDistancePercentage = 0.03;

const Color statusBarColor = Colors.white;

String nome;
List preferiti = ["Musei Capitolini"];
List immaginiPreferiti = ["assets/images/museocapitolino.jpg"];
List operePreferite = [];
List immaginiOperePreferite = [];


museo Museo = new museo();
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
Future<String> loadMuseumAsset() async {
  return await rootBundle.loadString('assets/loadjson/infomusei.json');
}
Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}
Future loadMuseum(String nome) async {
  await wait(waitValue);
  String jsonString = await loadMuseumAsset();
  final jsonResponse = json.decode(jsonString);
  return new museo.fromJson(jsonResponse, nome);
}

Container infoRow(IconData icon, String label){
  return Container(
    margin: EdgeInsets.only(top: infoMargin),
    child: Row(
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: AutoSizeText(
            label,
            style: TextStyle(fontSize: textFontSize, color: textFontColor),
          ),
        )
      ],
    ),
  );
}
Container noteRow(IconData icon, String label){
  return Container(
    child: Row(
      children: [
        Icon(icon, size: iconSize, color: Colors.green),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: AutoSizeText(
            label,
            style: TextStyle(fontSize: textFontSize, color: textFontColor),
          ),
        )
      ],
    ),
  );
}

class museoPage extends StatefulWidget {

  museoPage(String title){
    nome = title;
  }

  @override
  _museoPageState createState() => _museoPageState();
}

class _museoPageState extends State<museoPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadMuseum(nome),
      builder: (context, snapshot){
        if(snapshot.hasData){
          Museo = snapshot.data;
          return Container(
            color: statusBarColor,
            child: SafeArea(
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                      body: NestedScrollView(
                          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                leading: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.white,
                                      size: backIconSize
                                  ),
                                ),
                                collapsedHeight: MediaQuery. of(context). size. height * collapsedHeightPercentage,
                                expandedHeight: MediaQuery. of(context). size. height * expandedHeightPercentage,
                                backgroundColor: statusBarColor,
                                elevation: 0,
                                floating: false,
                                snap: false,
                                pinned: true,
                                flexibleSpace: BackgroundFlexibleSpaceBar(
                                  title: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.55,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                AutoSizeText(
                                                    nome,
                                                    style: GoogleFonts.roboto(
                                                      textStyle : TextStyle(fontSize: titleFontSize, color: Colors.white, fontWeight: titleFontWeight),
                                                    )
                                                ),
                                                Container(
                                                  child: SmoothStarRating(
                                                      allowHalfRating: false,
                                                      starCount: 5,
                                                      rating: Museo.rate,
                                                      size: starIconSize,
                                                      color: starIconColor,
                                                      halfFilledIconData: Icons.star_half_outlined,
                                                      borderColor: starIconColor,
                                                      spacing:0.0
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            child: FavoriteButton(
                                              iconSize: 40,
                                              isFavorite: preferiti.contains((nome)) ? true : false,
                                              valueChanged: (_isFavorite) {
                                                print(preferiti);
                                                print(immaginiPreferiti);
                                                if (_isFavorite == true){
                                                      setState((){
                                                      preferiti.add(nome);
                                                      immaginiPreferiti.add(Museo.immagine);
                                                    });
                                                  }
                                                else {
                                                      setState((){
                                                      preferiti.remove(nome);
                                                      immaginiPreferiti.remove(
                                                          Museo.immagine);
                                                    });
                                                  };

                                              },
                                            ),
                                          ),
                                        ],
                                      )

                                    ],
                                  ),
                                  ),
                                  centerTitle: false,
                                  titlePadding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                                  background: new ClipRect(
                                    child: new Container(
                                      decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                              Museo.immagine,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverPersistentHeader(
                                delegate: _SliverAppBarDelegate(
                                  TabBar(
                                    indicatorColor: tabIndicatorColor,
                                    labelColor: tabActiveTextColor,
                                    unselectedLabelColor: tabTextColor,
                                    tabs: <Widget>[
                                      Tab(
                                        child: AutoSizeText("INFORMAZIONI",
                                          style: TextStyle(fontSize: tabTextFontSize),
                                        ),
                                      ),
                                      Tab(
                                        child: AutoSizeText("OPERE",
                                          style: TextStyle(fontSize: tabTextFontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                pinned: true,
                              ),
                            ];
                          },
                          body: new TabBarView(
                            children: [
                              SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text(Museo.storia,
                                          maxLines: maxLinesStory,
                                          style: TextStyle(
                                              fontSize: textFontSize,
                                              color: textFontColor
                                          )
                                      ),
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
                                                        return new storia(Museo.storia);
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
                                                  style: TextStyle(fontSize: textFontSize, color: readMoreColor, fontWeight: FontWeight.bold) ,
                                                )
                                            )
                                          ]
                                      ),
                                      SizedBox(height: 10,),
                                      Divider(color: Colors.black),
                                      GestureDetector(
                                          onTap: (){
                                            launchURL(Museo.sito);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: infoMargin),
                                            child: Row(
                                              children: [
                                                Icon(Icons.web, size: iconSize, color: iconColor),
                                                Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: AutoSizeText(
                                                        Museo.sito,
                                                        style: TextStyle(
                                                            fontSize: textFontSize,
                                                            color: textFontColor
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Icon(Icons.navigate_next_sharp, size: nextIconSize, color: iconGoToColor)
                                              ],
                                            ),
                                          )
                                      ),
                                      GestureDetector(
                                          onTap: (){
                                            launch("tel://" + Museo.numero);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: infoMargin),
                                            child: Row(
                                              children: [
                                                Icon(Icons.call, size: iconSize, color: iconColor),
                                                Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: AutoSizeText(
                                                        Museo.numero,
                                                        style: TextStyle(
                                                            fontSize: textFontSize,
                                                            color: textFontColor
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Icon(Icons.navigate_next_sharp, size: nextIconSize, color: iconGoToColor)
                                              ],
                                            ),
                                          )
                                      ),
                                      GestureDetector(
                                          onTap: (){

                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(top: infoMargin),
                                            child: Row(
                                              children: [
                                                Icon(Icons.schedule, size: iconSize, color: iconColor),
                                                Expanded(
                                                    child: Container(
                                                      margin: EdgeInsets.only(left: 10),
                                                      child: AutoSizeText(
                                                        Museo.orario,
                                                        style: TextStyle(
                                                            fontSize: textFontSize,
                                                            color: textFontColor
                                                        ),
                                                      ),
                                                    )
                                                ),
                                                Icon(Icons.navigate_next_sharp, size: nextIconSize, color: iconGoToColor)
                                              ],
                                            ),
                                          )
                                      ),
                                      infoRow(Icons.map, Museo.luogo),
                                      infoRow(Icons.confirmation_num, "Prezzo biglietto " + Museo.prezzo + "€"),
                                      Divider(color: Colors.black),
                                      isBooked.contains(nome) ? Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined, color: Colors.red,),
                                          SizedBox(width: 5,),
                                          AutoSizeText("Esiste una prenotazione per questo museo", style: TextStyle( color: Colors.redAccent, fontSize: textFontSize),)
                                        ],
                                      ) : Container(),
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
                                                        Navigator.of(context).push(new PageRouteBuilder(
                                                            opaque: true,
                                                            transitionDuration: Duration(milliseconds: 225),
                                                            pageBuilder: (BuildContext context, _, __) {
                                                              return new prenotazione(nome);
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
                                                          onPrimary: Colors.grey,
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
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          AutoSizeText(
                                            "Note aggiuntive: ",
                                            style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),

                                      noteRow(Icons.check, "Adibito per disabili"),
                                      noteRow(Icons.check, "Visita interattiva"),
                                      noteRow(Icons.check, "Percheggio a pagamento"),
                                      noteRow(Icons.check, "Presenza guida"),
                                    ],
                                  )
                                ),
                              ),
                              Container(
                                child: GridView.count(
                                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: (2/3),
                                  crossAxisCount: itemPerLine,
                                  children: List.generate(Museo.opere.length, (index) {
                                    return Center(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            return operaDetails3(Museo.opere[index]['img'], Museo.opere[index]['title']);
                                          }));
                                        },
                                        child: Hero(
                                            tag: Museo.opere[index]['title'],
                                            child: Container( // primo elemento dell// il bordo tra un'opera e l'altra
                                              padding: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                                    new Radius.circular(5.0)
                                                ),
                                                image: new DecorationImage( // per metterci l'immagine dentro
                                                  image: new AssetImage(Museo.opere[index]['img']),
                                                  fit: BoxFit.cover, // per adattarla al container
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(0.0, 1.0), //(x,y)
                                                    blurRadius: 6.0,
                                                  )
                                                ],
                                              ),
                                              child: Align( // per allineare la scritta in una posizione specifica
                                                alignment: Alignment.bottomLeft,
                                                  child: AutoSizeText(Museo.opere[index]['title'], style: TextStyle(fontSize: itemFontSize, color: itemFontColor),)
                                              ),
                                            )
                                        ),
                                      ),
                                    );
                                  }),

                                ),
                              ),
                            ],
                          )
                      )
                  )
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}