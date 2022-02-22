import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late StreamSubscription _locationSubcriber;
  late GoogleMapController mapController;
  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  final Location locationStuff = Location();
  late Marker marker;
  late Circle blueSurround;

  @override
  void initState(){

    marker = const Marker(
        markerId: MarkerId("Walking Icon"),
        position:  LatLng(0.000000, 0.000000),
        rotation: 0.0,
        zIndex: 2,
        anchor: Offset(0.5,0.5),
    );
    blueSurround = Circle(
        circleId: const CircleId("Surround"),
        radius: 0,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: const LatLng(0.000000, 0.000000),
        fillColor: Colors.blue.withBlue(70)
    );
    super.initState();
  }

  static const CameraPosition CurrentLatLong =
  CameraPosition(target: LatLng(0.000000, 0.000000), zoom: 15);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  Future<Uint8List> Custommarker() async{
    ByteData imageMarker = await DefaultAssetBundle.of(context).
    load("assets/images/car_icon.png");
    return imageMarker.buffer.asUint8List();
  }

  Future<void> _requestPermissions() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await locationStuff.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  Future<void> _requestService() async {
    if (_serviceEnabled == true) {
      return;
    }
    final bool serviceRequestedResult = await locationStuff.requestService();
    setState(() {
      _serviceEnabled = serviceRequestedResult;
    });
  }

  void updateMarkerAndSurround(LocationData newLocationData,
      Uint8List imageMarker){
    LatLng latlong = LatLng((newLocationData.latitude)!, (newLocationData.longitude!));
    setState(() {
      marker = Marker(
        markerId: const MarkerId("Walking Icon"),
        position:  latlong,
        rotation: (newLocationData.heading)!,
        zIndex: 2,
        anchor: const Offset(0.5,0.5),
        icon: BitmapDescriptor.fromBytes(imageMarker)
      );
    });
  }


  Future<void> _getCurrentUserLocation() async {
    try {
      Uint8List imageData = await Custommarker();
      var location = await locationStuff.getLocation();
      updateMarkerAndSurround(location, imageData);

      _locationSubcriber = locationStuff.onLocationChanged.
      listen((newLocaldata) {
        mapController.animateCamera(
            CameraUpdate.newCameraPosition(CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng((newLocaldata.latitude)!,
                    (newLocaldata.longitude)!),
                tilt: 0,
                zoom: 18.00)));
        updateMarkerAndSurround(newLocaldata, imageData);
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrintStack();
      }
    }
  }


    @override
    void dispose() {
      _locationSubcriber.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Padding(
            padding:
                const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 350),
            child: SafeArea(
              left: true,
              right: true,
              top: true,
              child: GoogleMap(
                mapType: MapType.hybrid,
                zoomControlsEnabled: false,
                onMapCreated: _onMapCreated,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                initialCameraPosition: CurrentLatLong,
                markers: Set.of((marker != null) ? [marker] : []),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Start Tracking"),
            icon: const Icon(Icons.location_on_sharp),
            onPressed: () {
              _getCurrentUserLocation();
            }
          ),
        ));
  }
}
