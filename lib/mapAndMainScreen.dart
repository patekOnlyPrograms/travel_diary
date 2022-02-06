import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  late GoogleMapController mapController;
    
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    }

  final Location locationStuff = Location();

  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;

  Future<void> _checkPermissions() async{
    final PermissionStatus permissionGrantedResult =
    await locationStuff.hasPermission();
    setState(() {
      _permissionGranted = permissionGrantedResult;
    });
  }

  Future<void> _requestPermissions() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult = await
      locationStuff.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
  }

  Future<void> _checkService() async{
    final bool serviceEnabledResult = await locationStuff.serviceEnabled();
    setState(() {
      _serviceEnabled = serviceEnabledResult;
    });
  }

  Future<void> _requestService() async{
    if(_serviceEnabled == true){
      return;
    }
    final bool serviceRequestedResult = await locationStuff.requestService();
    setState(() {
      _serviceEnabled = serviceRequestedResult;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:
        GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            initialCameraPosition: const CameraPosition(
              target: LatLng(50.7934166, -1.0904852),
              zoom: 15
            ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text("Start Tracking"),
          icon: const Icon(Icons.location_on_sharp),
          onPressed: (){
            _permissionGranted == PermissionStatus.granted
                ? null
                : _requestPermissions();
            _serviceEnabled == true ? null : _requestService();
          },
        ),
      ),
    );
  }
}