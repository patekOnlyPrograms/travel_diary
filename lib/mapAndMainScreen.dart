import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  
  
    late GoogleMapController mapController;
    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _center
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_on_sharp),
          onPressed: (){
            showDialog(context: context, builder: (context) => AlertDialog(
              title: Text("Location Requied"),
              content: Text("Do you want to turn on location for tracking?"),
              actions: [
                TextButton(
                  onPressed: (){}, 
                  child: Text("Yes")
                ),
                TextButton(
                  onPressed: (){}, 
                  child: Text("No"))
              ],
            ));
          },
        ),
      ),
    );
  }
}