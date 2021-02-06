import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';
import 'package:prova_app/Object/biglietto.dart';

const String testoSenzaBiglietti = "Non hai prenotato alcun biglietto.";
const double tSBsize = 20;
const tSBcolor = Colors.black;
const tSBweight = FontWeight.w300;
const listviewCardColor = Colors.white;
const listviewTitleColor = Colors.black;
const listviewSubtitleColor = Colors.black;

const FontWeight titleFontWeight = FontWeight.bold;

List prenotati = [
];
List scaduti = [
];

class Biglietti extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Biglietti> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new AutoSizeText("Biglietto", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          backgroundColor: Colors.white,
        ),
        body: Container(child:
        Stack(children: [
          Column(children: [
            if (prenotati.isEmpty == true)
              scaduti.isEmpty ? Expanded(child:
              Container(child:
              Center(child:
              Text(testoSenzaBiglietti,style:
              TextStyle(fontSize: tSBsize, color: tSBcolor, fontWeight: tSBweight)
                ,)),),) :
              Expanded(
                  child: ListView(children: [
                    SizedBox(width: double.infinity,child: AutoSizeText("   Biglietti Scaduti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 15),textAlign: TextAlign.left)),
                    Divider(color: Colors.black54,),
                    Expanded (child :
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top:10.0),
                      shrinkWrap: true,
                      itemCount: scaduti.length,
                      itemBuilder: (con, ind) {
                        return Card(color: listviewCardColor,child: ListTile(
                          title: AutoSizeText(scaduti[ind].museo,style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                          subtitle: AutoSizeText(scaduti[ind].data,style: TextStyle(color: listviewSubtitleColor)),
                          trailing: Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                          },
                        ));
                      },
                    )),
                  ],)
              )
            else scaduti.isEmpty? Expanded(
                child: ListView(children: [
                  SizedBox(width: double.infinity,child: AutoSizeText("   Biglietti Validi",style: TextStyle(color: Colors.black54,height: 2,fontSize: 15),textAlign: TextAlign.left)),
                  Divider(color: Colors.black54,),
                  Expanded (child :
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top:10.0),
                    shrinkWrap: true,
                    itemCount: prenotati == null ? 0 : prenotati.length,
                    itemBuilder: (con, ind) {
                      return Card (
                          color: listviewCardColor,
                          child: ListTile(
                            title: AutoSizeText(prenotati[ind].museo,style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                            subtitle: AutoSizeText(prenotati[ind].data,style: TextStyle(color: listviewSubtitleColor)),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ));
                    },
                  )),
                ],)
            ) :
            Expanded(
                child: ListView(children: [
                  SizedBox(width: double.infinity,child: AutoSizeText("   Biglietti Validi",style: TextStyle(color: Colors.black54,height: 2,fontSize: 15),textAlign: TextAlign.left)),
                  Divider(color: Colors.black54,),
                  Expanded (child :
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
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ));
                    },
                  )),

                  SizedBox(width: double.infinity,child: AutoSizeText("   Biglietti Scaduti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 15),textAlign: TextAlign.left)),
                  Divider(color: Colors.black54,),
                  Expanded (child :
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(top:10.0),
                    shrinkWrap: true,
                    itemCount: scaduti.length,
                    itemBuilder: (con, ind) {
                      return Card(color: listviewCardColor,child: ListTile(
                        title: AutoSizeText(scaduti[ind].museo,style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                        subtitle: AutoSizeText(scaduti[ind].data,style: TextStyle(color: listviewSubtitleColor)),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                        },
                      ));
                    },
                  )),
                ],)
            )


          ],)
        ],),)
    );
  }
}

