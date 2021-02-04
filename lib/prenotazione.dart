import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:prova_app/misc/numberpicker.dart';
import 'package:prova_app/Object/biglietto.dart';
import 'package:prova_app/museoPage.dart';

const FontWeight titleFontWeight = FontWeight.bold;
const double textFontSize = 17;
const double titleFontSize = 30;

const String textFieldColor = "FAFAFA";

biglietto Biglietto = new biglietto();

class prenotazione extends StatefulWidget {

  prenotazione(String museo){
    Biglietto.museo = museo;
  }

  @override
  _prenotazioneState createState() => _prenotazioneState();
}

class _prenotazioneState extends State<prenotazione> {
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.decimal(
            minValue: 1,
            maxValue: 10,
            title: new Text("Pick a new price"),
            initialDoubleValue: 5,
          );
        }
    );
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
          title: AutoSizeText("Prenotazione", style: TextStyle(color: Colors.black, fontWeight: titleFontWeight)),
          backgroundColor: Colors.white,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                width: double.infinity,
                child: Text(Biglietto.museo, textAlign: TextAlign.center, style: TextStyle( fontSize: titleFontSize, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 50,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all( // per i bordi arrotondati
                      new Radius.circular(5.0)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText("Seleziona una data", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: HexColor(textFieldColor),
                      borderRadius:  BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.green,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,

                        //contentPadding: EdgeInsets.only(left: 2),

                        hintText: "Data",
                      ),
                      focusNode: AlwaysDisabledFocusNode(),
                      controller: _textEditingController,
                      onTap: () {
                        _selectDate(context);
                      },
                    )
                ),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}