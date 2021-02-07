import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

const FontWeight titleFontWeight = FontWeight.bold;
const double textFontSize = 17;

class orario extends StatelessWidget {

  String museo;
  var tabella;
  String giorno;
  String chiusura_biglietteria;
  String ultimo_ingresso;

  orario(String museo, var tabella, String chiusura_biglietteria, String ultimo_ingresso){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('E');
    giorno = formatter.format(now);
    print("ORARIO");
    print(giorno);
    this.museo = museo;
    this.tabella = tabella;
    this.chiusura_biglietteria = chiusura_biglietteria;
    this.ultimo_ingresso = ultimo_ingresso;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black,),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          title: AutoSizeText('Orario', style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(museo, style : TextStyle(color: Colors.black, fontSize: textFontSize + 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText('Lunedì', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Mon' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Martedì', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Tue' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Mercoledì', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Wed' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Giovedì', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Thu' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Venerdì', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Fri' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Sabato', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Sat' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText('Domenica', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Sun' ? FontWeight.bold : FontWeight.normal))),
                          ],
                        ),
                        Expanded(child: Container(),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(tabella['Mon'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Mon' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Tue'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Tue' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Wed'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Wed' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Thu'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Thu' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Fri'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Fri' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Sat'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Sat' ? FontWeight.bold : FontWeight.normal))),
                            SizedBox(height: 5,),
                            AutoSizeText(tabella['Sun'], style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: (giorno == 'Sun' ? FontWeight.bold : FontWeight.normal))),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    AutoSizeText("Chiusura biglietteria ore $chiusura_biglietteria", style : TextStyle(color: Colors.black, fontSize: textFontSize)),
                    SizedBox(height: 5,),
                    AutoSizeText("Ultimo ingresso ore $ultimo_ingresso", style : TextStyle(color: Colors.black, fontSize: textFontSize)),
                  ],
                )
            ),
          ],
        )
    );
  }
}