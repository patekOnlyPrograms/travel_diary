import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  late GoogleMapController mapController;

  late LatLng CurrentLatLong;

    
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    }

  final Location locationStuff = Location();

  PermissionStatus? _permissionGranted;
  bool? _serviceEnabled;
  bool _loading = false;

  LocationData? _location;
  String? _error;

  Future<void> _requestPermissions() async {
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult = await
      locationStuff.requestPermission();
      setState(() {
        _permissionGranted = permissionRequestedResult;
      });
    }
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



  Future<void> _getUserLocation() async{
    setState(() {
      _error = null;
      _loading = true;
    });
    try{
      final LocationData _locationResult = await locationStuff.getLocation();
      setState(()  {
        _location = _locationResult;
        _loading = false;
        CurrentLatLong = LatLng(_locationResult.latitude!, _locationResult.longitude!);
      });
    } on PlatformException catch (err){
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
    //return print('Loaction: ' + (_error ?? '${_location ?? "Unkown"}'));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
              padding: const EdgeInsets.only(left: 0,right: 0,top: 0,bottom: 350),
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
                  initialCameraPosition: CameraPosition(
                  target: CurrentLatLong,zoom: 15),
                ),
              )
          ),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Start Tracking"),
            icon: const Icon(Icons.location_on_sharp),
            onPressed: (){

              _permissionGranted == PermissionStatus.granted
                  ? null
                  : _requestPermissions();
              _serviceEnabled == true ? null : _requestService();
              _getUserLocation();
            },
          ),
      ),
    );
  }
}