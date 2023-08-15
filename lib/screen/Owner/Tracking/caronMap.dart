// import 'dart:convert';
// import 'dart:ui';

// import 'package:bazralogin/Model/report.dart';

// import 'package:bazralogin/const/constant.dart';
// import 'package:flutter/services.dart';

// import 'package:location/location.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:substring_highlight/substring_highlight.dart';

// import 'carInfoSearch.dart';

// class displaycarlaction extends StatefulWidget {
//   const displaycarlaction({super.key});

//   @override
//   State<displaycarlaction> createState() => _displaycarlactionState();
// }

// // ignore: camel_case_types
// class _displaycarlactionState extends State<displaycarlaction> {
//   GoogleMapController? mapController;
//   static LatLng SOURCE_LOCATION = LatLng(9.005401, 38.763611);
//   static LatLng DEST_LOCATION = LatLng(8.5263, 39.2583);

//   // search
//   bool isLoading = false;
//   String? userSelected;
//   List<String>? autoCompleteData;
//   String? latitude;
//   String? longitude;

//   TextEditingController? controller;
//   // get current location
//   Location currentLocationcar = Location();
//   Set<Marker> _markers = {};

//   // void getLocation() async {
//   //   var location = await currentLocationcar.getLocation();
//   //   currentLocationcar.onLocationChanged.listen((LocationData loc) {
//   //     mapController
//   //         ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
//   //       target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
//   //       zoom: 12.0,
//   //     )));
//   //     print(loc.latitude);
//   //     print(loc.longitude);
//   //     setState(() {
//   //       _markers.add(Marker(
//   //           markerId: MarkerId('Home'),
//   //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
//   //     });
//   //   });
//   // }
// //
//   Future<void> _goto(double x, double y) async {
//     mapController?.animateCamera(CameraUpdate.newCameraPosition(
//         CameraPosition(target: LatLng(x, y), zoom: 18)));
//     Marker(
//         markerId: MarkerId("strat"),
//         position: LatLng(x, y),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         infoWindow: InfoWindow(title: "CarB"));
//     Marker(
//         markerId: MarkerId("Adama"),
//         position: currentlocation,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         infoWindow: InfoWindow(title: "CarB"));
//     // setPolylines();
//   }

//   //ployline

//   Set<Polyline> _polylines = Set<Polyline>();
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints? polylinePoints;
//   late LatLng dEST_LOCATION;
//   late LatLng currentlocation;
//   void setInitialLocation() {
//     currentlocation =
//         LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);

//     dEST_LOCATION = LatLng(DEST_LOCATION.latitude, DEST_LOCATION.longitude);
//   }

//   List<String> images = [
//     'assets/images/h.png',
//   ];

//   Uint8List? markerImage;
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

// //list of car
//   final List<Map<String, dynamic>> carList = const [
//     {
//       "address": "Addisa Ababa",
//       "id": "CarA",
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
//       "lat": 9.6009,
//       "lng": 41.8501,
//       "name": "dire dawa",
//       "phone": "7014333352",
//       "region": "oromia"
//     },
//     {
//       "address": "Adama",
//       "id": "Carb",
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
//       "lat": 12.6030,
//       "lng": 37.4521,
//       "name": "Gondar",
//       "phone": "7014333352",
//       "region": "Sidima"
//     },
//     {
//       "address": "Addisa Ababa",
//       "id": "CarA",
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
//       "lat": 9.005401,
//       "lng": 38.763611,
//       "name": "Addisa Ababa",
//       "phone": "7014333352",
//       "region": "oromia"
//     },
//     {
//       "address": "Adama",
//       "id": "Carb",
//       "image":
//           "https://upload.wikimedia.org/wikipedia/commons/6/6f/Evening_view%2C_City_Palace%2C_Udaipur.jpg",
//       "lat": 8.5263,
//       "lng": 39.2583,
//       "name": "Adama",
//       "phone": "7014333352",
//       "region": "Sidima"
//     }
//   ];

//   final Map<String, Marker> _marker = {};
//   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
//   void addCustomIcon() {
//     Icon:
//     BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/h.png')
//         .then((icon) {
//       setState(
//         () {
//           markerIcon = icon;
//         },
//       );
//     });
//   }

// // multiple marker
//   Future<void> _onMapCreated(GoogleMapController controller) async {
//     final Uint8List markerIcon =
//         await getBytesFromAsset('assets/images/marker.png'.toString(), 100);
//     _marker.clear();
//     setState(() {
//       for (int i = 0; i < carList.length; i++) {
//         print("For Loop");
//         final marker = Marker(
//           icon: BitmapDescriptor.fromBytes(markerIcon),
//           markerId: MarkerId(carList[i]['name']),
//           position: LatLng(carList[i]['lat'], carList[i]['lng']),
//           infoWindow: InfoWindow(
//               title: carList[i]['name'],
//               snippet: carList[i]['address'],
//               onTap: () {
//                 print("${carList[i]['lat']}, ${carList[i]['lng']}");
//               }),
//           onTap: () {
//             print("Clicked on marker");
//           },
//         );
//         print("${carList[i]['lat']}, ${carList[i]['lng']}");
//         _marker[carList[i]['name']] = marker;
//       }
//     });
//   }

//   @override
//   void initState() {
//     polylinePoints = PolylinePoints();
//     this.setInitialLocation();
//     addCustomIcon();
//     // getLocation();
//     super.initState();
//   }

//   void dispose() {
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
// //       backgroundColor: kBackgroundColor,
// //       body: SizedBox(
// //           child: Stack(
// //         children: [
// //           // GoogleMap(
// //           //   onMapCreated: _onMapCreated,
// //           //   initialCameraPosition: CameraPosition(
// //           //     target: LatLng(carList[0]['lat'], carList[0]['lng']),
// //           //     zoom: 4.8,
// //           //   ),
// //           //   markers: _marker.values.toSet(),
// //           // ),

// //         ],
// //       )),
// //     );
// //   }

// // // draw polyline
// //   void setPolylines() async {
// //     PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
// //       "AIzaSyDd81MpJcxjNdICQeKRg3Emywp4e_29Sfc",
// //       PointLatLng(currentlocation.latitude, currentlocation.longitude),
// //       PointLatLng(
// //         dEST_LOCATION.latitude,
// //         dEST_LOCATION.longitude,
// //       ),
// //     );
// //     if (result.status == 'OK') {
// //       result.points.forEach((PointLatLng point) {
// //         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
// //       });
// //       print("yyyyyyyyyyyyyyyyyyyyyyyy");

// //       setState(() {
// //         _polylines.add(Polyline(
// //             width: 3,
// //             polylineId: PolylineId('polyLine'),
// //             color: Colors.blue,
// //             points: polylineCoordinates));
// //       });
// //     }
//         );
//   }
// }
