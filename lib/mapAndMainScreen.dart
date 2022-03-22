// ignore: file_names
import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

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
  late Marker marker;
  late Circle blueSurround;
  List<LocationData> VisitedLocations = [];

  Timer? timeCounter;

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

  static const CameraPosition CurrentLatLong =
      CameraPosition(target: LatLng(0.000000, 0.000000), zoom: 15);

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
          rotation: newLocationData.headingAccuracy!,
          zIndex: 2,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageMarker));
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      Uint8List imageData = await Custommarker();
      _locationSubcriber =
          locationStuff.onLocationChanged.listen((newLocaldata) {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 192.8334901395799,
                target:
                    LatLng((newLocaldata.latitude)!, (newLocaldata.longitude)!),
                tilt: 0,
                zoom: 18.00)));
        updateMarkerAndSurround(newLocaldata, imageData);
        timeCounter = Timer.periodic((Duration(seconds: 10)), (timer) {
          VisitedLocations.add(newLocaldata);
          print('$newLocaldata');
        });
      });
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        debugPrintStack();
      }
    }
  }

  Future<void> _stopListening() async {
    setState(() {
      timeCounter!.cancel();
      _locationSubcriber?.cancel();
      _locationSubcriber = null;
    });
  }

  @override
  void dispose() {
    _locationSubcriber?.cancel();

    super.dispose();
  }

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
                          onPressed: () => _getCurrentUserLocation(),
                          child: const Text("Start Tracking"),
                        )),
                    Positioned(
                        right: 200,
                        top: 650,
                        child: ElevatedButton(
                          child: const Text("Stop Tracking"),
                          onPressed: () => _stopListening(),
                        ))
              ],
        )
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}
