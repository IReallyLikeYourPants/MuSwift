import 'dart:ui';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:prova_app/Object/biglietto.dart';
import 'package:prova_app/Biglietti.dart';
import 'package:prova_app/museoPage.dart';
import 'package:prova_app/main.dart';
import 'package:flutter/services.dart';

const FontWeight titleFontWeight = FontWeight.bold;
const double textFontSize = 17;
const double titleFontSize = 30;

const double intFieldPercentage = 0.15;
const double textPercentage = 0.25;

const String textFieldColor = "FAFAFA";

biglietto Biglietto = new biglietto();
int adulti_prezzo;
int bambini_prezzo;
int adulti = 1;
int bambini = 0;
int totale;
String nome;
String cognome;

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) { assert(mask != null); assert (separator != null); }

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length > 0) {
      if(newValue.text.length > oldValue.text.length) {
        if(newValue.text.length > mask.length) return oldValue;
        if(newValue.text.length < mask.length && mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: '${oldValue.text}$separator${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

class prenotazione extends StatefulWidget {

  prenotazione(String museo, int adu, int bam){
    Biglietto.museo = museo;
    adulti_prezzo = adu;
    bambini_prezzo = bam;

    totale = adu;
  }

  @override
  _prenotazioneState createState() => _prenotazioneState();
}

class _prenotazioneState extends State<prenotazione> {
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();

  void increment(int adu, int bam){
    setState(() {
      totale = (adulti_prezzo * adu) + (bambini_prezzo * bam);
    });
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
              ),
              SizedBox(height: 20,),
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
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * textPercentage,
                          child: AutoSizeText("Adulti", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          child: AutoSizeText("$adulti_prezzo€", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child : Container()),
                        Container( child:
                          CustomNumberPicker(
                            valueTextStyle: TextStyle(fontSize: textFontSize, color: textFontColor),
                            initialValue: 1,
                            maxValue: 10,
                            minValue: 1,
                            step: 1,
                            customAddButton: Icon(Icons.add),
                            customMinusButton: Icon(Icons.remove),
                            onValue: (value) {
                              adulti = value;
                              increment(adulti, bambini);
                            },
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * textPercentage,
                          child: AutoSizeText("Bambini", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            child: AutoSizeText("$bambini_prezzo€", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        ),
                        Expanded(child : Container()),
                        Container( child:
                        CustomNumberPicker(
                          valueTextStyle: TextStyle(fontSize: textFontSize, color: textFontColor),
                          initialValue: 0,
                          maxValue: 10,
                          minValue: 0,
                          step: 1,
                          customAddButton: Icon(Icons.add),
                          customMinusButton: Icon(Icons.remove),
                          onValue: (value) {
                            bambini = value;
                            increment(adulti, bambini);
                          },
                        ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("TOTALE:  $totale €", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
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
                                  return new prenotazione2();
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
                            width: 75,
                            child: AutoSizeText(
                              "AVANTI",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textButtonColor,
                                  fontWeight: buttonFontWeight
                              ),
                            ),
                          )
                      )
                  )
                ],
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

class prenotazione2 extends StatefulWidget {
  @override
  _prenotazione2State createState() => _prenotazione2State();
}

class _prenotazione2State extends State<prenotazione2> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nome'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nome non valido';
        }

        return null;
      },
      onSaved: (String value) {
        nome = value;
      },
    );
  }

  Widget _buildCognome() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Cognome'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Cognome non valido';
        }

        return null;
      },
      onSaved: (String value) {
        cognome = value;
      },
    );
  }

  Widget _buildTitolare() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Titolare della carta'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Titolare non valido';
        }

        return null;
      },
    );
  }

  Widget _buildNumero() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Numero carta'),
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        MaskedTextInputFormatter(
          mask: 'xxxx-xxxx-xxxx-xxxx',
          separator: '-',
        ),
      ],
      validator: (String value) {

        if (value.isEmpty) {
          return 'Numero carta non valido';
        }
        return null;
      },
    );
  }

  Widget _buildScadenza(){
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            decoration: InputDecoration(labelText: 'Mese'),
            validator: (String value) {
              if (value.isEmpty || int.parse(value) > 12 || int.parse(value)< 0) {
                return 'Mese non valido';
              }

              return null;
            },
          ),
        ),
        SizedBox(width: 10,),
        Container(
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: InputDecoration(labelText: 'Anno'),
            validator: (String value) {
              if (value.isEmpty || int.parse(value) < 2021) {
                return 'Anno non valido';
              }
              return null;
            },
          ),
        ),
        Expanded(child: Container()),
        Container(
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(labelText: 'CVC'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'CVC non valido ';
              }

              return null;
            },
          ),
        ),
      ],
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
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
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
                    width: double.infinity,
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
                        AutoSizeText("Nominativi", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        _buildNome(),
                        SizedBox(height: 10,),
                        _buildCognome()
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
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
                        AutoSizeText("Dati della carta", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10,),
                        _buildTitolare(),
                        SizedBox(height: 10,),
                        _buildNumero(),
                        SizedBox(height: 10,),
                        _buildScadenza(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("TOTALE:  $totale €", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor,
                                  elevation: elevationButton
                              ),
                              onPressed: () {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                _formKey.currentState.save();

                                Navigator.of(context).push(new PageRouteBuilder(
                                    opaque: true,
                                    transitionDuration: Duration(milliseconds: 225),
                                    pageBuilder: (BuildContext context, _, __) {
                                      return new riepilogo();
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
                                width: 75,
                                child: AutoSizeText(
                                  "AVANTI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: textButtonColor,
                                      fontWeight: buttonFontWeight
                                  ),
                                ),
                              )
                          )
                      )
                    ],
                  ),

                ],
              ),
            )
          )
        )
    );
  }

}

class riepilogo extends StatelessWidget {

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
                width: double.infinity,
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
                  children: [
                    AutoSizeText("Rileggi attentamente i dati prima di confermare.", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                    Divider(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("Data", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                              AutoSizeText("Adulti", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                              AutoSizeText("Bambini", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                              AutoSizeText("Nome", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                              AutoSizeText("Cognome", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                              AutoSizeText("Costo", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              SizedBox(height: 20,),
                            ],
                          ),
                          width: MediaQuery.of(context).size.width * 0.4,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AutoSizeText("E mo? ", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                              AutoSizeText("$adulti", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                              AutoSizeText("$bambini", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                              AutoSizeText("$nome", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                              AutoSizeText("$cognome", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                              AutoSizeText("$totale€", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: buttonColor,
                              elevation: elevationButton
                          ),
                          onPressed: () {

                            Biglietto.nome = nome;
                            Biglietto.cognome = cognome;
                            Biglietto.adulti = adulti;
                            Biglietto.bambini = bambini;
                            Biglietto.costo = totale;
                            Biglietto.data = "non lo so";

                            isBooked.add(Biglietto.museo);
                            prenotati.add(Biglietto);

                            int count = 0;
                            Navigator.popUntil(context, (route) {
                              return count++ == 3;
                            });
                          },
                          child: Container(
                            width: 75,
                            child: AutoSizeText(
                              "CONFERMA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textButtonColor,
                                  fontWeight: buttonFontWeight
                              ),
                            ),
                          )
                      )
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}