// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:csv/csv.dart';


class googleMapLocation extends StatefulWidget {
  const googleMapLocation({Key? key}) : super(key: key);
  @override
  _googleMapLocationState createState() => _googleMapLocationState();
}

class _googleMapLocationState extends State<googleMapLocation>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription? _locationSubcriber;
  late GoogleMapController mapController;
  Location locationStuff = Location();
  LocationData? location;
  late Marker marker;
  late Circle blueSurround;
  String? error;

  //List<dynamic> VisitedLocations = [];

  @override
  void initState() {
    marker = const Marker(
      markerId: MarkerId("Walking Icon"),
      position: LatLng(0.000000, 0.000000),
      rotation: 0.0,
      zIndex: 2,
      anchor: Offset(0.5, 0.5),
    );
    super.initState();
  }

  static const CameraPosition CurrentLatLong = CameraPosition(target: LatLng(0.000000, 0.000000), zoom: 15);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Uint8List> Custommarker() async {
    ByteData imageMarker = await DefaultAssetBundle.of(context)
        .load("assets/images/navigation.png");
    return imageMarker.buffer.asUint8List();
  }

  void updateMarkerAndSurround(LocationData newLocationData, Uint8List imageMarker) {
    LatLng latlong = LatLng((newLocationData.latitude)!, (newLocationData.longitude!));
    setState(() {
      marker = Marker(
          markerId: const MarkerId("Walking Icon"),
          position: latlong,
          rotation: newLocationData.heading! ,
          zIndex: 2,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageMarker));
    });
  }

  Future<void> _listenLocation() async {
    Uint8List imageData = await Custommarker();
    _locationSubcriber =
        locationStuff.onLocationChanged.handleError((dynamic err) {
          if (err is PlatformException) {
            setState(() {
              error = err.code;
            });
          }
          _locationSubcriber?.cancel();
          setState(() {
            _locationSubcriber = null;
          });
        }).listen((LocationData currentLocation) {
          setState(() {
            mapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  bearing: 192.8334901395799,
                  target:
                  LatLng((currentLocation.latitude)!, (currentLocation.longitude)!),
                  tilt: 0,
                  zoom: 18.00
              )
            ));
            updateMarkerAndSurround(currentLocation, imageData);
            error = null;

            location = currentLocation;
            //add current location to list
            //VisitedLocations.add(currentLocation);
            //convert List<Dynamic> to List<String>
            //List<String> visitedLocationsStrings = VisitedLocations.map((e) => e.toString()).toList();
            //print(visitedLocationsStrings);
          });
        });
    setState(() {});
  }

  Future<void> stoplistening() async{
    _locationSubcriber?.cancel();
    setState(() {
      _locationSubcriber = null;
    });
  }

 @override
 void dispose(){
   _locationSubcriber?.cancel();
   setState(() {
     _locationSubcriber = null;
   });
   super.dispose();
 }

  //add items from the list to a CSV file
  //String listToCSV = ListToCsvConverter().convert(VisitedLocations);

  //getting application document directory as a string to find where it is.
  //External storage so i can verify that is works


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(
              children: <Widget>[
                    GoogleMap(
                      mapType: MapType.hybrid,
                      onMapCreated: _onMapCreated,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      initialCameraPosition: CurrentLatLong,
                      markers: Set.of((marker != null) ? [marker] : []),
                    ),
                    Positioned(
                        right: 70,
                        top: 650,
                        child: ElevatedButton(
                          onPressed: () => _listenLocation(),
                          child: const Text("Start Tracking"),
                        )),
                    Positioned(
                        right: 200,
                        top: 650,
                        child: ElevatedButton(
                          child: const Text("Stop Tracking"),
                          onPressed: () => stoplistening(),
                        ))
              ],
        )
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
