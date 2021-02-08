import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:prova_app/Object/biglietto.dart';
import 'package:prova_app/main.dart';
import 'package:prova_app/Biglietti.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:prova_app/constant.dart';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

const String titleFontColor = "000000";
const FontWeight titleFontWeight = FontWeight.bold;
const double titleFontSize = 30;
const double subTitleFontSize = 16;
const double textFontSize = 17;

const Color textButtonColor = Colors.white;
const Color buttonColor = Colors.blue;
const FontWeight buttonFontWeight = FontWeight.normal;
const double elevationButton = 5;

biglietto Biglietto;
const String _documentPath = 'assets/PDF/biglietto.pdf';

class bigliettoDetails extends StatefulWidget{

  bigliettoDetails(biglietto B){
    Biglietto = B;
  }

  _bigliettoDetailsState createState() => _bigliettoDetailsState();
}

class _bigliettoDetailsState extends State<bigliettoDetails> {



  Future<String> prepareTestPdf() async {
    final ByteData bytes =
    await DefaultAssetBundle.of(context).load(_documentPath);
    final Uint8List list = bytes.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$_documentPath';

    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back, color: HexColor(bianco),),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          title: AutoSizeText('Prenotazione', style: TextStyle(color: HexColor(bianco), fontWeight: titleFontWeight)),
          backgroundColor: HexColor(primoColor),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Column(
                      children: [
                        AutoSizeText(Biglietto.museo, style: TextStyle( fontSize: titleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                        AutoSizeText(Biglietto.luogo, style: TextStyle( fontSize: subTitleFontSize, fontWeight: FontWeight.bold, color: HexColor(titleFontColor)), ),
                      ],
                    )
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    AutoSizeText('Data', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: FontWeight.bold)),
                    Expanded(child: Container()),
                    AutoSizeText(Biglietto.data, style : TextStyle(color: Colors.black, fontSize: textFontSize )),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(),
                Row(
                  children: [
                    AutoSizeText('Adulti', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: FontWeight.bold )),
                    Expanded(child: Container()),
                    AutoSizeText(Biglietto.adulti.toString(), style : TextStyle(color: Colors.black, fontSize: textFontSize )),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(),
                Row(
                  children: [
                    AutoSizeText('Bambini', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: FontWeight.bold )),
                    Expanded(child: Container()),
                    AutoSizeText(Biglietto.bambini.toString(), style : TextStyle(color: Colors.black, fontSize: textFontSize )),
                  ],
                ),
                SizedBox(height: 10,),
                Divider(),
                Row(
                  children: [
                    AutoSizeText('Costo', style : TextStyle(color: Colors.black, fontSize: textFontSize, fontWeight: FontWeight.bold )),
                    Expanded(child: Container()),
                    AutoSizeText(Biglietto.costo.toString() + "€", style : TextStyle(color: Colors.black, fontSize: textFontSize )),
                  ],
                ),
                Expanded(child: Container()),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor(accentuatoColor),
                        elevation: elevationButton
                    ),
                    onPressed: () {
                      prenotati.remove(Biglietto);
                      isBooked.remove(Biglietto.museo);
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      child: AutoSizeText(
                        "CANCELLA LA PRENOTAZIONE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textButtonColor,
                            fontWeight: buttonFontWeight
                        ),
                      ),
                    )
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: HexColor(accentuatoColor),
                        elevation: elevationButton
                    ),
                    onPressed: () => {
                      // We need to prepare the test PDF, and then we can display the PDF.
                      prepareTestPdf().then((path) {
                        Navigator.of(context).push(new PageRouteBuilder(
                            opaque: true,
                            transitionDuration: Duration(milliseconds: 225),
                            pageBuilder: (BuildContext context, _, __) {
                              return new FullPdfViewerScreen(path);
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
                      })
                    },
                    child: Container(
                      width: double.infinity,
                      child: AutoSizeText(
                        "VISUALIZZA PDF",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: textButtonColor,
                            fontWeight: buttonFontWeight
                        ),
                      ),
                    )
                ),
                SizedBox(height: 30,),
                Divider()
              ],
            )
        ),
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
            backgroundColor: HexColor(primoColor),
          title: AutoSizeText("PDF", style: TextStyle(color: HexColor(bianco))),
        ),
        path: pdfPath);
  }
}