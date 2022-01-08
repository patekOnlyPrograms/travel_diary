
// ignore_for_file: camel_case_types

import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';

class permissionLocation {
  checkpermission_location() async{
    var locationStatus = await Permission.location.status;

    if(!locationStatus.isGranted){
      await Permission.location.request();
    }
    else{
      showToast("Please provide location permission",position: ToastPosition.bottom);
    }
  }
}
  // showAlertDialogBuild(BuildContext context){
  //   Widget okButton = TextButton(
  //     onPressed: (){},
  //     child: Text("OK")
  //   );

  //   AlertDialog locationDialog =AlertDialog(
  //     title: Text("Location Request failed"),
  //     content: Text("Please grant location access"),
  //     actions: <Widget>[
  //       okButton
  //     ],
  //   );
  //   showDialog(
  //     context: context, 
  //     builder: (BuildContext context) {
  //         return locationDialog;
  //       }
  //   );
  // }
