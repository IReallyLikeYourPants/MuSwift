import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

const FontWeight titleFontWeight = FontWeight.bold;
const double textFontSize = 17;

class storia extends StatelessWidget {

  String titolo;
  String sottotitolo;
  String testo;

  storia(String titolo, String sottotitolo, String testo){
    this.titolo = titolo;
    this.sottotitolo = sottotitolo;
    this.testo = testo;
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
        title: AutoSizeText(titolo, style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(sottotitolo, style : TextStyle(color: Colors.black, fontSize: textFontSize + 10, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    AutoSizeText(testo, style : TextStyle(color: Colors.black, fontSize: textFontSize)),
                  ],
                )
            ),
        ],
      )
    );
  }
}