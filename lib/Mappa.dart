import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:prova_app/Ricerca.dart';
import 'dart:math';

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

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
MarkerId selectedMarker;
int _markerIdCounter = 1;
static final LatLng center = const LatLng(-33.86711, 151.1947171);

  void _onMarkerTapped(MarkerId markerId) {
    final Marker tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        if (markers.containsKey(selectedMarker)) {
          final Marker resetOld = markers[selectedMarker]
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[selectedMarker] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;
      });
    }
  }

  void _add() {
    var markerIdVal = 'marker_id_$_markerIdCounter';
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
        center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: SafeArea(
        child: Stack(
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