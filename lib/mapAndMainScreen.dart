import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_settings/app_settings.dart';
import 'package:location/location.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //var enabledLoc = await Permission.location.status;
  
  
    late GoogleMapController mapController;
    
    void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          mapType: MapType.hybrid,
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          zoomGesturesEnabled: true,
          rotateGesturesEnabled: true,
          initialCameraPosition: LatLng
        ),
        floatingActionButton:
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.location_on_sharp),
                  onPressed: (){
                    //From here the app should first check is location is enabled if it is not then it should
                    //open up the dialog box to get location then the user can press outside of the box to get location
                    //once location is turned on the floatingActionbutton should change to location tracking
                    showDialog(context: context, builder: (context) => AlertDialog(
                      title: const Text("Location Required"),
                      content: const Text("Do you want to turn on location for tracking?"),
                      actions: [
                        TextButton(
                            onPressed: (){},
                            child: const Text("No")),
                        TextButton(
                            onPressed: (){
                              AppSettings.openLocationSettings();
                              Navigator.of(context).pop();
                            },
                            child: const Text("Yes")
                        ),
                      ],
                    ));
                  },
                ),
                FloatingActionButton(
                    child: const Icon(Icons.location_searching_sharp),
                    onPressed: (){

                    }
                )
              ],
            ),
      ),
    );
  }
}