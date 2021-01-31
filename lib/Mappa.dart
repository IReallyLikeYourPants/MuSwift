import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prova_app/Ricerca.dart';


class Mappa extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<Mappa> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.9028, 12.4964),
    zoom: 14,
  );
  String _mapStyle;
  GoogleMapController _mapController;

  initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

//...

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    if (mounted) {
      setState(() {
        _mapController = controller;
        controller.setMapStyle(_mapStyle);
      });
    }
  }

//...

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue,
      child: SafeArea(
        child: Stack(
          children: [
            Scaffold(
                body: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                ),

                floatingActionButton: FloatingActionButton.extended(
                  onPressed: _currentLocation,
                  backgroundColor: Colors.black,
                  focusColor: Colors.red,
                  foregroundColor: Colors.amber[800],
                  hoverColor: Colors.white,
                  splashColor: Colors.white,
                  label: Icon(Icons.location_on),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Ricerca()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(72.0),
                    ),
                    margin : EdgeInsets.only(top: MediaQuery. of(context). size.height * 0.025),
                    width: MediaQuery. of(context). size.width * 0.87,
                    height: MediaQuery. of(context). size.height * 0.05,
                    child: Row(
                      children: [
                        SizedBox(width: MediaQuery. of(context). size.width * 0.03,),
                        Icon(
                          Icons.search,
                        )],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
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
}