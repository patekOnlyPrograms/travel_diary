// ignore: file_names
// ignore_for_file: camel_case_types, unused_field, unused_element

import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class getLocationWidget extends StatefulWidget {
  const getLocationWidget({ Key? key }) : super(key: key);

  @override
  _getLocationWidgetState createState() => _getLocationWidgetState();
}

class _getLocationWidgetState extends State<getLocationWidget> {
  final Location locationPackage = Location();

  bool _loading = false;

  LocationData? _location;
  String? _error;

  Future<void> _getUserLocation() async{
    setState(() {
      _error = null;
      _loading = true;
    });
    try{
      final LocationData _locationResult = await locationPackage.getLocation();
      setState(() {
        _location = _locationResult;
        _loading = false;
      });
    } on PlatformException catch (err){
      setState(() {
        _error = err.code;
        _loading = false;
      });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: Text(
          'Loaction: ' + (_error ?? '${_location ?? "Unkown"}'),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      );
  }
}