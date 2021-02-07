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

const Color statusBarColor = Colors.white;
const Color backgroundColor = Colors.white;
const Color topColor = Colors.blue;

const double topSizePercentage = 0.15;

const FontWeight titleFontWeight = FontWeight.bold;
const double textFontSize = 17;
const double subTitleFontSize = 16;
const double titleFontSize = 30;
const String titleFontColor = "FFFFFF";

const double intFieldPercentage = 0.15;
const double textPercentage = 0.25;

const String textFieldColor = "FAFAFA";

biglietto Biglietto;
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

  prenotazione(String museo, String luogo, int adu, int bam){
    Biglietto = new biglietto(museo, luogo);
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

    TextEditingController controllerData = TextEditingController();
    final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

    return Container(
      color : statusBarColor,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: topColor,
                ),
                Column(
                  children: [
                    Container(height: MediaQuery. of(context). size. height * topSizePercentage,
                      padding: EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.arrow_back, color: HexColor(titleFontColor),),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText("Prenotazione", style: TextStyle( fontSize: titleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                  AutoSizeText(Biglietto.museo, style: TextStyle( fontSize: subTitleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          AutoSizeText("Seleziona una data", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10,),
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                color: HexColor(textFieldColor),
                                borderRadius:  BorderRadius.circular(10),
                              ),
                              child: Form(
                                key: _formKey2,
                                child: TextFormField(
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Inserisci una data';
                                    }

                                    return null;
                                  },
                                  onSaved: (String value) {
                                    Biglietto.data = value;
                                  },
                                  decoration: InputDecoration(
                                    fillColor: Colors.green,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintText: "Data",
                                  ),
                                  focusNode: AlwaysDisabledFocusNode(),
                                  controller: _textEditingController,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
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
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("TOTALE:  $totale €", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: buttonColor,
                                  elevation: elevationButton
                              ),
                              onPressed: () {
                                if (!_formKey2.currentState.validate()) {
                                  return;
                                }
                                _formKey2.currentState.save();

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
                                width: double.infinity,
                                child: AutoSizeText(
                                  "AVANTI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: textButtonColor,
                                      fontWeight: buttonFontWeight
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 30,)
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )
        ),
      ),
    );
  }

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isBefore(DateTime.now().subtract(Duration(days: 1))) || DateFormat('E').format(day) == 'Mon') {
      return false;
    }

    return true;
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        selectableDayPredicate: _decideWhichDayToEnable,
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
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: HexColor(textFieldColor),
        borderRadius:  BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.green,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Nome",
        ),

        validator: (String value) {
          if (value.isEmpty) {
            return 'Nome non valido';
          }

          return null;
        },
        onSaved: (String value) {
          nome = value;
        },
      ),
    );
  }

  Widget _buildCognome() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: HexColor(textFieldColor),
        borderRadius:  BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.green,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Cognome",
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Cognome non valido';
          }

          return null;
        },
        onSaved: (String value) {
          cognome = value;
        },
      ),
    );
  }

  Widget _buildTitolare() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: HexColor(textFieldColor),
        borderRadius:  BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.green,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Titolare della carta",
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'Titolare non valido';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildNumero() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: HexColor(textFieldColor),
        borderRadius:  BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          fillColor: Colors.green,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: "Numero carta",
        ),
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
      ),
    );
  }

  Widget _buildScadenza(){
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: HexColor(textFieldColor),
            borderRadius:  BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
            decoration: InputDecoration(
              fillColor: Colors.green,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: "Mese",
            ),
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
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: HexColor(textFieldColor),
            borderRadius:  BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: InputDecoration(
              fillColor: Colors.green,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: "Anno",
            ),
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
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: HexColor(textFieldColor),
            borderRadius:  BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * intFieldPercentage,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            decoration: InputDecoration(
              fillColor: Colors.green,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: "CVC",
            ),
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

    return Container(
      color : statusBarColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: topColor,
                ),
                Column(
                  children: [
                    Container(height: MediaQuery. of(context). size. height * topSizePercentage,
                      padding: EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.arrow_back, color: HexColor(titleFontColor),),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pagamento", style: TextStyle( fontSize: titleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                  Text(Biglietto.museo, style: TextStyle( fontSize: subTitleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                    Expanded(child: Form(
                      key: _formKey,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText("Nominativi", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                            SizedBox(height: 10,),
                            _buildNome(),
                            SizedBox(height: 15,),
                            _buildCognome(),
                            SizedBox(height: 25,),
                            AutoSizeText("Dati della carta", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                            SizedBox(height: 15,),
                            _buildTitolare(),
                            SizedBox(height: 15,),
                            _buildNumero(),
                            SizedBox(height: 15,),
                            _buildScadenza(),
                            SizedBox(height: 30,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("TOTALE:  $totale €", style: TextStyle(fontSize: textFontSize, color: textFontColor, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
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
                                  width: double.infinity,
                                  child: AutoSizeText(
                                    "AVANTI",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: textButtonColor,
                                        fontWeight: buttonFontWeight
                                    ),
                                  ),
                                )
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),
                    ))
                  ],
                )
              ],
            )
        ),
      ),
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
    return Container(
      color : statusBarColor,
      child: SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: topColor,
                ),
                Column(
                  children: [
                    Container(height: MediaQuery. of(context). size. height * topSizePercentage,
                      padding: EdgeInsets.all(10),
                      child:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                child: Icon(Icons.arrow_back, color: HexColor(titleFontColor),),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Riepilogo", style: TextStyle( fontSize: titleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                  Text(Biglietto.museo, style: TextStyle( fontSize: subTitleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText("Rileggi attentamente i dati prima di confermare.", style: TextStyle(fontSize: textFontSize, color: textFontColor)),
                          SizedBox(height: 10,),
                          Divider(),
                          SizedBox(height: 10,),
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
                                    AutoSizeText(Biglietto.data, style: TextStyle(fontSize: textFontSize, color: textFontColor)),
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
                          Expanded(child: Container()),
                          ElevatedButton(
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

                                isBooked.add(Biglietto.museo);
                                prenotati.add(Biglietto);

                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 3;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                child: AutoSizeText(
                                  "CONFERMA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: textButtonColor,
                                      fontWeight: buttonFontWeight
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 30,)
                        ],
                      ),
                    ))
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}