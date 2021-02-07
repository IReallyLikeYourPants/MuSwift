import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:prova_app/Ricerca.dart';
import 'dart:math';

List recentiMappa = [];
double COSTANTE_DI_OFFSET = 0.00532;



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
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
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
    final jsonB = await DefaultAssetBundle.of(context).loadString('assets/loadjson/opere.json');
    return {
      'jsonMusei': jsonA,
      'jsonOpere': jsonB
    };
  }

  void setCustomMarker() async {
      mapMarker = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(2, 2)), 'assets/images/iconamuseo3.png');
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
            print('Hai tappato');
            pointOnLocation(LatLng(41.906487,12.453641-COSTANTE_DI_OFFSET));
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context){
                return Container(
                  color: Colors.yellow,
                  height: 200,
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
            print('Hai tappato');
            pointOnLocation(LatLng(41.892944,12.482558-COSTANTE_DI_OFFSET));  // This is shifted for the lng by -0.0053: from (41.892944,12.482558) to(41.892944,12.477258)
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context){
                  return Container(
                    color: Colors.yellow,
                    height: 200,
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
      color: Colors.white,
      child: SafeArea(
        child: FutureBuilder(
                future: loadJson(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    var rows = json.decode(snapshot.data['jsonMusei'].toString());
                    rows = new List<dynamic>.from(rows)..addAll(json.decode(snapshot.data['jsonOpere'].toString()));

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
                              backgroundColor: Colors.white,
                              focusColor: Colors.red,
                              foregroundColor: Colors.amber[400],
                              hoverColor: Colors.white,
                              splashColor: Colors.white,
                              label: Icon(Icons.location_on),
                            )
                        ),
                        Column(children: [
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
                                        onPressed: () => tc.clear(),
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
                              SizedBox(height: 5,),
                              Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(top:10.0),
                                    shrinkWrap: true,
                                    itemCount: results.length,
                                    itemBuilder: (con, ind) {
                                      return Container(
                                          color: Colors.white,
                                          child : ListTile(
                                            title: AutoSizeText(rows[ind]['title'],style: TextStyle(color: listviewTitleColor, fontWeight: FontWeight.bold)),
                                            subtitle: AutoSizeText(rows[ind]['nav'].toString(),style: TextStyle(color: listviewSubtitleColor)),

                                            onTap: () {
                                              print("Hai cliccato nella listview");
                                              pointOnLocation(LatLng(41.906487,12.453641));
                                              if(titoli.contains(rows[ind]['title'])==false){
                                                titoli.add(rows[ind]['title']);
                                                recentiMappa.insert(0,rows[ind]);
                                              };
                                              print(recentiMappa);

                                            },
                                          ));
                                    },
                                  )
                              )

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
        elem['nav'].toString()
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

  }

}