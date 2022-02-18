import 'package:flutter/material.dart';
import 'package:location/location.dart';

class locationPerms extends StatefulWidget {
  const locationPerms({Key? key}) : super(key: key);

  @override
  _locationPermsState createState() => _locationPermsState();
}

class _locationPermsState extends State<locationPerms> {

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
    return Container(
      child: FloatingActionButton(
        onPressed: (){
          print("does this work");
          _permissionGranted == PermissionStatus.granted
                        ? null
                        : _requestPermissions();
                    _serviceEnabled == true ? null : _requestService();
        }
      ),
    );


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){
      _permissionGranted == PermissionStatus.granted
                    ? null
                    : _requestPermissions();
                _serviceEnabled == true ? null : _requestService();
    });
  }
}
