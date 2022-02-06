import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Permission _locationPerm = Permission.location;
  PermissionStatus _locationPermStatus  = PermissionStatus.denied;
  
  
  late GoogleMapController mapController;
    
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    }
  
  @override
  void initState(){
    super.initState();

    _listenForPermissionStatus();
  }

  void _listenForPermissionStatus() async{
    final status = await _locationPerm.status;
    setState(() => _locationPermStatus = status);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.hybrid,
            zoomControlsEnabled: false,
            onMapCreated: _onMapCreated,
            zoomGesturesEnabled: true,
            rotateGesturesEnabled: true,
            initialCameraPosition: const CameraPosition(target: LatLng(50.7934166, -1.0904852))
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              child: const Icon(Icons.location_on_sharp),
              onPressed: (){
                //From here the app should first check is location is enabled if it is not then it should
                //open up the dialog box to get location then the user can press outside of the box to get location
                //once location is turned on the floatingActionbutton should change to location tracking
                requestPermission(_locationPerm);
                checkServiceStatus(context, _locationPermStatus as PermissionWithService);
              },
          ),
          )
        ],)
      ),
    );
  }

  void checkServiceStatus(BuildContext context,PermissionWithService permission) async{
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text((await permission.serviceStatus).toString()))
    // );
    Fluttertoast.showToast(
      msg: (permission.serviceStatus).toString(),
      gravity: ToastGravity.BOTTOM,

    );
  }

  Future<void> requestPermission(Permission permission) async{
    final status = await permission.request();

    setState(() {
      print(status);
      _locationPermStatus = status;
      print(_locationPermStatus);
    });
  }
}