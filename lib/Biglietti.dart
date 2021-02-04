import "package:flutter/material.dart";
import 'package:auto_size_text/auto_size_text.dart';

const String testoSenzaBiglietti = "Non hai prenotato alcun biglietto.";
const double tSBsize = 20;
const tSBcolor = Colors.black;
const tSBweight = FontWeight.w300;
const listviewCardColor = Colors.white;
const listviewTitleColor = Colors.black;
const listviewSubtitleColor = Colors.black;

List prenotati = [
  {
    "title":"Musei Vaticani",
    "img": "assets/images/museovaticano.jpg",
    "nav" : "Città del Vaticano",
    "date": "14-07-2021"
  },
  {
    "title":"Museo Nazionale Castel Sant'Angelo",
    "img": "assets/images/nazionale.jpg",
    "nav" : "Lungotevere Castello",
    "date": "15-07-2021"
  },
  {
    "title":"Musei Capitolini",
    "img": "assets/images/museocapitolino.jpg",
    "nav" : "Via dei Musei Capitolini",
    "date": "16-07-2021"
  },
  {
    "title":"Galleria Borghese",
    "img": "assets/images/galleriaborghese.jpg",
    "nav" : "Villa Borghese",
    "date": "17-07-2021"
  }
];
List scaduti = [
  {
    "title":"Musei Capitolini",
    "img": "assets/images/museocapitolino.jpg",
    "nav" : "Via dei Musei Capitolini",
    "date": "03-04-2020"
  },
  {
    "title":"Galleria Borghese",
    "img": "assets/images/galleriaborghese.jpg",
    "nav" : "Villa Borghese",
    "date": "03-04-2020"
  }
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
          title: new AutoSizeText("Biglietti"),
        ),
        body: Container(child:
        Stack(children: [
          Column(children: [
            prenotati.isEmpty ?
            Expanded(child:
            Container(child:
            Center(child:
            Text(testoSenzaBiglietti,style:
            TextStyle(fontSize: tSBsize, color: tSBcolor, fontWeight: tSBweight)
              ,)),),):
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
                            title: AutoSizeText(prenotati[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                            subtitle: AutoSizeText(prenotati[ind]['date'].toString(),style: TextStyle(color: listviewSubtitleColor)),
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
                        title: AutoSizeText(scaduti[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                        subtitle: AutoSizeText(scaduti[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),
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