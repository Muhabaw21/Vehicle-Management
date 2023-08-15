import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// car model
class Car with ChangeNotifier {
  final LatLng location;
  final String name;
  final String history;
  final String image;
  final String id;
  final int distance;
  final String time;

  Car({
    required this.location,
    required this.name,
    required this.history,
    required this.image,
    required this.id,
    required this.distance,
    required this.time,
  });
}

// ignore: prefer_final_fields
// car provider
class Carinfo with ChangeNotifier {
  List<Car> products = [
    Car(
        distance: 12,
        id: "111",
        time: "12/12/2022",
        location: LatLng(7.6785, 36.8384),
        image: "assets/images/h.png",
        name: " carA",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 300,
        time: "12/12/2029",
        id: "222",
        location: LatLng(27.6602292, 85.308027),
        name: " carB",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 400,
        time: "12/12/2026",
        id: "333",
        location: LatLng(27.6602292, 85.308027),
        name: " Track",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 160,
        time: "12/15/2022",
        id: "6621",
        location: LatLng(27.6602292, 85.308027),
        name: " Minbus",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 100,
        time: "12/12/2025",
        id: "6621",
        location: LatLng(27.6602292, 85.308027),
        name: " Minbus",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 60,
        time: "12/12/2027",
        id: "6621",
        location: const LatLng(27.6602292, 85.308027),
        name: " Minbus",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  "),
    Car(
        distance: 100,
        time: "12/14/2022",
        id: "6621",
        location: const LatLng(27.6602292, 85.308027),
        name: " Minbus",
        image: "assets/images/h.png",
        history: "  11 ,3,2022 ,move  to Adama , 11,3,2025, to Gondar  ")
  ];
  Car findById(String productId) {
    return products.firstWhere((element) => element.id == productId);
  }

  List<Car> get product {
    return [...products];
  }

  List<Car> searchQuery(String searchText) {
    List _searchList = products
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    return [..._searchList];
  }
}
