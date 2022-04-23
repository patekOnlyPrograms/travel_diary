// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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
  late String locationDatatoString;
  Timer? timer;

  LocationData? locationOfUser;

  List<LocationData> VisitedLocations = [];

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

  void updateMarkerAndSurround(
      LocationData newLocationData, Uint8List imageMarker) {
    LatLng latlong =
        LatLng((newLocationData.latitude)!, (newLocationData.longitude!));
    setState(() {
      marker = Marker(
          markerId: const MarkerId("Walking Icon"),
          position: latlong,
          rotation: newLocationData.heading!,
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
                target: LatLng(
                    (currentLocation.latitude)!, (currentLocation.longitude)!),
                tilt: 0,
                zoom: 18.00)));
        updateMarkerAndSurround(currentLocation, imageData);
        error = null;

        location = currentLocation;
        locationDatatoString = currentLocation.toString();
      });
    });
    setState(() {});
    listAdder();
  }

  Future<void> stoplistening() async {
    _locationSubcriber?.cancel();
    setState(() {
      _locationSubcriber = null;
    });
    stopTimer();
  }

  @override
  void dispose() {
    _locationSubcriber?.cancel();
    setState(() {
      _locationSubcriber = null;
    });
    super.dispose();
  }

  Future<void> getLocation() async {
    try {
      final LocationData locationResult = await locationStuff.getLocation();
      setState(() {
        locationOfUser = locationResult;
      });
    } on PlatformException catch (err) {
      setState(() {
        error = err.code;
        print(error);
      });
    }
  }

  void listAdder() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getLocation();

      VisitedLocations.add(locationOfUser!);
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: [
            SafeArea(
                child: Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.all(15),
              width: 450,
              height: 450,
              child: GoogleMap(
                mapType: MapType.hybrid,
                onMapCreated: _onMapCreated,
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                rotateGesturesEnabled: true,
                initialCameraPosition: CurrentLatLong,
                markers: Set.of((marker != null) ? [marker] : []),
              ),
            )),
            Container(
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: VisitedLocations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('${VisitedLocations.elementAt(index)}'),
                      ),
                    );
                  }),
            )
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
                heroTag: "Floating action button 1",
                child: Icon(Icons.play_arrow),
                onPressed: () => _listenLocation()),
            FloatingActionButton(
                heroTag: "Floating action button 2",
                child: Icon(Icons.stop),
                onPressed: () => stoplistening())
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
