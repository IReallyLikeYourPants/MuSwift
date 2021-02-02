import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

const FontWeight titleFontWeight = FontWeight.bold;

class storia extends StatelessWidget {

  String text;

  storia(String txt){
    this.text = txt;
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
        title: AutoSizeText("Storia", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: AutoSizeText(text),
            ),
        ],
      )
    );
  }
}