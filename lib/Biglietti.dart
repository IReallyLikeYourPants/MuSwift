import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'package:prova_app/Object/biglietto.dart';
import 'package:prova_app/Details/bigliettoDetails.dart';
import 'package:prova_app/constant.dart';
import 'package:hexcolor/hexcolor.dart';

const String testoSenzaBiglietti = "Non hai prenotato alcun biglietto.";
const double tSBsize = 20;
const tSBcolor = Colors.black;
const tSBweight = FontWeight.w300;
const listviewCardColor = Colors.white;
const listviewTitleColor = Colors.black;
const listviewSubtitleColor = Colors.black;

const FontWeight titleFontWeight = FontWeight.bold;

List prenotati = [];
List scaduti = [
];

class Biglietti extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Biglietti> {

  void reload(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new AutoSizeText("Biglietti", style: TextStyle(color: HexColor(bianco), fontWeight: titleFontWeight)),
          backgroundColor: HexColor(primoColor),
        ),
        body: Container(
          padding: EdgeInsets.all((10)),
          child:
        Stack(children: [
          Column(children: [
            (prenotati.isEmpty) ?
              Container(
                width:  MediaQuery. of(context). size. width,
                height: MediaQuery. of(context). size. width,
                child:
              Center(child:
              Text(testoSenzaBiglietti,style:
              TextStyle(fontSize: tSBsize, color: tSBcolor, fontWeight: tSBweight)
                ,)),) :
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(top:10.0),
                shrinkWrap: true,
                itemCount: prenotati == null ? 0 : prenotati.length,
                itemBuilder: (con, ind) {
                  return Card (
                      color: listviewCardColor,
                      child: ListTile(
                        title:AutoSizeText(prenotati[ind].museo,style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                        subtitle: AutoSizeText(prenotati[ind].data,style: TextStyle(color: listviewSubtitleColor)),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, color: HexColor(accentuatoColor)),
                        onTap: () async {
                          final value = await Navigator.of(context).push(new PageRouteBuilder(
                              opaque: true,
                              transitionDuration: Duration(milliseconds: 225),
                              pageBuilder: (BuildContext context, _, __) {
                                return new bigliettoDetails(prenotati[ind]);
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
                          reload();
                        },
                      ));
                },
              )
          ],
          )
        ],
        ),
        )
    );
  }
}

