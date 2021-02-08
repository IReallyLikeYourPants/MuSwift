import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:prova_app/Object/museo.dart';
import 'package:prova_app/Ricerca.dart';
import 'dart:math';
import 'package:prova_app/constant.dart';
import 'package:hexcolor/hexcolor.dart';

import 'museoPage.dart';

List recentiMappa = [];
double COSTANTE_DI_OFFSET = 0.00532;
const double boxHeightPercentage = 0.25;
const double titleFontSize = 30;
const double subtitleFontSize = 20;

class Mappa extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<Mappa> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 14,
  );
  String _mapStyle;



  void pointOnLocation(loc) async{
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: loc,
        zoom: 17.0,
      ),
    ));
  }

  void _currentLocation() async {
    GoogleMapController controller = await _controller.future;
    LocationData currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude-COSTANTE_DI_OFFSET),
        zoom: 17.0,
      ),
    ));
  }



  //String _mapStyle;
  GoogleMapController _mapController;
  TextEditingController tc;
  BitmapDescriptor vaticano;
  BitmapDescriptor mapMarker;

  List<Marker> markers = [];
  List results = [];
  String query = '';

  Future<Map<String, String>> loadJson() async {
    final jsonA = await DefaultAssetBundle.of(context).loadString('assets/loadjson/musei.json');
    //final jsonB = await DefaultAssetBundle.of(context).loadString('assets/loadjson/opere.json');
    return {
      'jsonMusei': jsonA,
      //'jsonOpere': jsonB
    };
  }

  void setCustomMarker() async {
      mapMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(1, 1)), 'assets/images/iconamuseo3.png');
  }


  initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    setCustomMarker();

    tc = TextEditingController();


  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (mounted) {
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
    }
    markers.add(
        Marker(
          markerId: MarkerId('Musei Vaticani'),
          draggable: false,
          position: LatLng(41.906487,12.453641),
          icon: mapMarker,
          onTap: (){
            setState(() {
            query = "";
            print(rows);
            setResults(query,rows);
            });
            print('Hai tappato');

            pointOnLocation(LatLng(41.906487,12.453641-COSTANTE_DI_OFFSET));
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context){
                return Container(
                  height: MediaQuery.of(context).size.height * boxHeightPercentage,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                      new Radius.circular(5.0)
                                  ),
                                  image: new DecorationImage( // per metterci l'immagine dentro
                                    image: new ExactAssetImage(
                                      "assets/images/museovaticano.jpg",
                                    ),
                                    fit: BoxFit.cover, // per adattarla al container
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    )
                                  ],
                                )
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText('Musei Vaticani', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),),
                                AutoSizeText('Città del Vaticano - Roma', style: TextStyle(fontSize: subtitleFontSize,)),
                              ],
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: HexColor(accentuatoColor),
                                elevation: elevationButton
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => museoPage('Musei Vaticani')
                                  )
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              child: AutoSizeText(
                                "MUSEO",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: textButtonColor,
                                    fontWeight: buttonFontWeight
                                ),
                              ),
                            )
                        ),
                      ]

                    )
                );
              }
            );
          },
        )
    );
    markers.add(
        Marker(
          markerId: MarkerId("Museo Nazionale Castel Sant'Angelo"),
          draggable: false,
          position: LatLng(41.90308,12.4661811),
          icon: mapMarker,
          onTap: (){
            setState(() {
              query = "";
              print(rows);
              setResults(query,rows);
            });
            print('Hai tappato');
            pointOnLocation(LatLng(41.90308,12.4661811-COSTANTE_DI_OFFSET));
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context){
                return Container(
                    height: MediaQuery.of(context).size.height * boxHeightPercentage,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                        new Radius.circular(5.0)
                                    ),
                                    image: new DecorationImage( // per metterci l'immagine dentro
                                      image: new ExactAssetImage(
                                        "assets/images/nazionale.jpg",
                                      ),
                                      fit: BoxFit.cover, // per adattarla al container
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 6.0,
                                      )
                                    ],
                                  )
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText('Museo Nazionale', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),),
                                  AutoSizeText('Castel Sant\'Angelo', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),),
                                  AutoSizeText('Lungotevere Castello,50-ROMA', style: TextStyle(fontSize: subtitleFontSize,)),
                                ],
                              )
                            ],
                          ),
                          Expanded(child: Container()),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: HexColor(accentuatoColor),
                                  elevation: elevationButton
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => museoPage("Museo Nazionale Castel Sant'Angelo")
                                    )
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                child: AutoSizeText(
                                  "MUSEO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: textButtonColor,
                                      fontWeight: buttonFontWeight
                                  ),
                                ),
                              )
                          ),
                        ]

                    )
                );
              }
            );
          },
        )
    );
    markers.add(
        Marker(
          markerId: MarkerId('Musei Capitolini'),
          draggable: false,
          position: LatLng(41.892944,12.482558),
          icon: mapMarker,
          onTap: (){
            setState(() {
              query = "";
              print(rows);
              setResults(query,rows);
            });
            print('Hai tappato');
            pointOnLocation(LatLng(41.892944,12.482558-COSTANTE_DI_OFFSET));  // This is shifted for the lng by -0.0053: from (41.892944,12.482558) to(41.892944,12.477258)
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context){
                  return Container(
                      height: MediaQuery.of(context).size.height * boxHeightPercentage,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                          new Radius.circular(5.0)
                                      ),
                                      image: new DecorationImage( // per metterci l'immagine dentro
                                        image: new ExactAssetImage(
                                          "assets/images/museocapitolino.jpg",
                                        ),
                                        fit: BoxFit.cover, // per adattarla al container
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText('Museo Capitolino', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),),
                                    AutoSizeText('Via dei Musei Capitolini', style: TextStyle(fontSize: subtitleFontSize,)),
                                    AutoSizeText('ROMA', style: TextStyle(fontSize: subtitleFontSize,)),
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor(accentuatoColor),
                                    elevation: elevationButton
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => museoPage("Musei Capitolini")
                                      )
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: AutoSizeText(
                                    "MUSEO",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: textButtonColor,
                                        fontWeight: buttonFontWeight
                                    ),
                                  ),
                                )
                            ),
                          ]

                      )
                  );
                }
            );
          },
        )
    );
    markers.add(
        Marker(
          markerId: MarkerId('Galleria Borghese'),
          draggable: false,
          position: LatLng(41.9083963664,12.4885313792),
          icon: mapMarker,
          onTap: (){
            setState(() {
              query = "";
              print(rows);
              setResults(query,rows);
            });
            print('Hai tappato');
            pointOnLocation(LatLng(41.9083963664,12.4885313792-COSTANTE_DI_OFFSET));  // This is shifted for the lng by -0.0053: from (41.892944,12.482558) to(41.892944,12.477258)
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context){
                  return Container(
                      height: MediaQuery.of(context).size.height * boxHeightPercentage,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all( // per i bordi arrotondati
                                          new Radius.circular(5.0)
                                      ),
                                      image: new DecorationImage( // per metterci l'immagine dentro
                                        image: new ExactAssetImage(
                                          "assets/images/galleriaborghese.jpg",
                                        ),
                                        fit: BoxFit.cover, // per adattarla al container
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 6.0,
                                        )
                                      ],
                                    )
                                ),
                                SizedBox(width: 15,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText('Galleria Borghese', style: TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold),),
                                    AutoSizeText('Villa Borghese - ROMA', style: TextStyle(fontSize: subtitleFontSize,)),
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: HexColor(accentuatoColor),
                                    elevation: elevationButton
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => museoPage("Galleria Borghese")
                                      )
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  child: AutoSizeText(
                                    "MUSEO",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: textButtonColor,
                                        fontWeight: buttonFontWeight
                                    ),
                                  ),
                                )
                            ),
                          ]

                      )
                  );
                }
            );
          },
        )
    );

  }

//...



//...


  @override
  Widget build(BuildContext context) {
    return new Container(
      color: HexColor(primoColor),
      child: SafeArea(
        child: FutureBuilder(
                future: loadJson(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    var rows = json.decode(snapshot.data['jsonMusei'].toString());
                    //rows = new List<dynamic>.from(rows)..addAll(json.decode(snapshot.data['jsonOpere'].toString()));

                    return Stack(
                      children: [
                        Scaffold(
                            body: GoogleMap(
                                padding: EdgeInsets.only(right: 1000),
                                initialCameraPosition: _kGooglePlex,
                                onMapCreated: _onMapCreated,
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                mapType: MapType.normal,
                                zoomControlsEnabled: false,
                                markers: Set.from(markers)
                            ),
                            floatingActionButton: FloatingActionButton.extended(
                              onPressed: _currentLocation,
                              backgroundColor: HexColor(primoColor),
                              focusColor: Colors.red,
                              foregroundColor: HexColor(bianco),
                              hoverColor: Colors.white,
                              splashColor: Colors.white,
                              label: Icon(Icons.location_on),
                            )
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(72.0),
                            ),
                            margin : EdgeInsets.only(top: MediaQuery. of(context). size.height * 0.025),
                            width: MediaQuery. of(context). size.width * 0.87,
                            height: MediaQuery. of(context). size.height * 0.05,
                            child: Theme(
                                child : Container(
                                  padding: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    color: HexColor(textFieldColor),
                                    borderRadius:  BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    //style: TextStyle(color: Colors.grey),
                                    //autofocus: true,
                                    controller: tc,
                                    decoration: InputDecoration(
                                      fillColor: Colors.green,
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,

                                      //contentPadding: EdgeInsets.only(left: 2),

                                      hintText: searchbarText,
                                      hintStyle: TextStyle(color: searchbarTextColor),
                                      suffixIcon: IconButton(
                                        onPressed: () => {
                                          tc.clear(),
                                          setState(() {
                                            query = "";
                                            print(rows);
                                            setResults(query,rows);
                                          }),
                                        },
                                        icon: Icon(Icons.clear),
                                      ),
                                    ),
                                    onChanged: (t){
                                      //buildSuggestions(context);
                                      setState(() {
                                        query = t;
                                        print(rows);
                                        setResults(query,rows);
                                      });
                                    },
                                    onSubmitted: (v) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                                data: ThemeData(
                                  primaryColor: HexColor("FFCB05"),
                                  hintColor: HexColor("FFCB05"),
                                )
                            )
                        ),
                        query.isEmpty ?
                        Expanded(child: Container())
                            : Expanded(
                            child: Column(children : [
                              //SizedBox(width: double.infinity,child: AutoSizeText("  Recenti",style: TextStyle(color: Colors.black54,height: 2,fontSize: 23),textAlign: TextAlign.left)),
                              //Divider(color: Colors.black54,),
                              SizedBox(width: MediaQuery. of(context). size.width),
                              results.isEmpty ? Container() : Container(height: (results.length > 10) ? 300 : results.length * 50.0, width: MediaQuery. of(context). size.width * 0.87,
                                  child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: results.length,
                                itemBuilder: (con, ind) {
                                  return Container(
                                      height: 50,
                                      width: 200,
                                      color: Colors.white,
                                      child : ListTile(
                                        title: AutoSizeText(results[ind]['title'],style: TextStyle(color: listviewTitleColor)),
                                        onTap: () {
                                          setState(() {
                                            query = "";
                                            print(rows);
                                            setResults(query,rows);
                                          });
                                          print("Hai cliccato nella listview");

                                          String titolo = results[ind]['title'];

                                          for (var i = 0; i < markers.length; i++){
                                            if (markers[i].markerId == MarkerId(titolo)){
                                              print(markers[i].markerId);
                                              print(titolo);
                                              print(MarkerId(titolo));
                                              print(markers[i].markerId == MarkerId(titolo));
                                              pointOnLocation(LatLng(markers[i].position.latitude,markers[i].position.longitude-COSTANTE_DI_OFFSET));
                                            }
                                          };

                                          if(titoli.contains(results[ind]['title'])==false){
                                            titoli.add(results[ind]['title']);
                                            recentiMappa.insert(0,results[ind]);
                                          };
                                          print(recentiMappa);


                                        },
                                      ));
                                },
                              ))


                            ])),
                      ],
                      )
                      ]);
                  }
                  return Container();
                }
            )
      ),
    );
  }

  void setResults(String query,var rowss) {
    results = rowss
        .where((elem) =>
    elem['title']
        .toString()
        .toLowerCase()
        .contains(query.toLowerCase()) ||
        elem['title'].toString()
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

  }

}