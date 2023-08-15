import 'package:bazralogin/Route/Routes.dart';
import 'package:bazralogin/screen/Driver/driverBottomnav.dart';
import 'package:bazralogin/screen/Loging/Login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ionicons/ionicons.dart';
import '../controller/ownerinfocontroller.dart';
import '../screen/Bottom/Bottom.dart';

class AlertDialoug {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  // margin: EdgeInsets.only(
                  //   left: 100,
                  // ),
                  height: 30,
                  width: 70,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.3), // Shadow color
                              blurRadius: 3, // Spread radius
                              offset:
                                  Offset(0, 3), // Offset in (x,y) coordinates
                            ),
                          ],
                          color: Color.fromRGBO(226, 193, 121, 1),
                          shape: BoxShape.circle),
                      width: 50,
                      height: 50,
                      child: Container(
                          child: Icon(
                        Ionicons.alert,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ))),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Text(
                      message,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  decoration: const BoxDecoration(
                    color: const Color.fromRGBO(178, 142, 22, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    ),
                  ),
                  height: 30,
                  child: TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog

                      // Navigator.of(context).pop(true);
                      // Get.offAllNamed('/home');
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} // comman alert

class alertutils {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  height: 20,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    message,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final ApiControllerforowner _ownerinfo =
                        Get.put(ApiControllerforowner());
                    Navigator.of(context).pop(); // Close the dialog
                    _ownerinfo.fetchData();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => BottomTabBarPageforowner()),
                      (route) => false,
                    ); //

                    // Navigator.of(context).pop(true);
                    // Get.offAllNamed('/home');
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// alert dialoug for driver
class alertutilsfordriver {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
          ),
          height: 200,
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  // margin: EdgeInsets.only(
                  //   left: 100,
                  // ),
                  height: 30,
                  width: 70,
                  child: Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.3), // Shadow color
                              blurRadius: 3, // Spread radius
                              offset:
                                  Offset(0, 3), // Offset in (x,y) coordinates
                            ),
                          ],
                          color: Color.fromRGBO(226, 193, 121, 1),
                          shape: BoxShape.circle),
                      width: 50,
                      height: 50,
                      child: Container(
                          child: Icon(
                        Ionicons.alert,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ))),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Text(
                      message,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(226, 193, 121, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6.0),
                      bottomLeft: Radius.circular(6.0),
                      bottomRight: Radius.circular(6.0),
                      topRight: Radius.circular(6.0),
                    ),
                  ),
                  height: 30,
                  child: TextButton(
                    child: const Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => BottomTabBarPage()),
                        (route) => false,
                      ); //

                      // Navigator.of(context).pop(true);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// forget pin
class alertutilsforgetpin {
  static showMyDialog(
      BuildContext context, String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6.0),
              bottomLeft: Radius.circular(6.0),
              bottomRight: Radius.circular(6.0),
              topRight: Radius.circular(6.0),
            ),
          ),
          child: AlertDialog(
            titlePadding: EdgeInsets.all(0),
            title: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.0),
                  bottomLeft: Radius.circular(6.0),
                  bottomRight: Radius.circular(6.0),
                  topRight: Radius.circular(6.0),
                ),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Container(
                  height: 20,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Center(
                    child: Text(
                      message,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login()),
                      (route) => false,
                    ); //

                    // Navigator.of(context).pop(true);
                    // Get.offAllNamed('/home');
                  },
                ),
              ),
              Container(
                width: 100,
                margin: EdgeInsets.only(right: 25),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                    topRight: Radius.circular(6.0),
                  ),
                ),
                height: 30,
                child: TextButton(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// alert for error

class alertforeror {
  void showCustomToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}

// alertforsuccess
class alertforscuccess {
  void showCustomToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color.fromRGBO(76, 176, 80, 1),
      textColor: Colors.white,
    );
  }
}
