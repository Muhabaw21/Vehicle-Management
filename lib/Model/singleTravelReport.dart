import 'package:flutter/material.dart';

// car model
class TravelReport with ChangeNotifier {
  final double totalTraveltime;
  final dateOftravelstart;
  final String dateOftravelend;
  final double speedOfcar;
  final String travelPlace;

  TravelReport({
    required this.totalTraveltime,
    required this.dateOftravelstart,
    required this.dateOftravelend,
    required this.speedOfcar,
    required this.travelPlace,
  });
}

// ignore: prefer_final_fields
// car provider
class TravelReportinfo with ChangeNotifier {
  List<TravelReport> products = [
    TravelReport(
      totalTraveltime: 12,
      speedOfcar: 22,
      travelPlace: "jimma  - Addisa ",
      dateOftravelstart: "24/02/2023",
      dateOftravelend: "12/19/202",
    ),
    TravelReport(
      totalTraveltime: 12,
      speedOfcar: 22,
      travelPlace: "jimma - Addisa ",
      dateOftravelstart: "12/19/202",
      dateOftravelend: "12/19/202",
    ),
    TravelReport(
      totalTraveltime: 12,
      dateOftravelstart: "12/01/2023",
      speedOfcar: 22,
      travelPlace: "Jimma - Gondarhhhhhhhhhhhhhhhhhh",
      dateOftravelend: "12/19/202",
    ),
    TravelReport(
      totalTraveltime: 12,
      dateOftravelstart: "12/19/202",
      speedOfcar: 22,
      travelPlace: "Adamaa - Addisa",
      dateOftravelend: "12/19/202",
    ),
    TravelReport(
      totalTraveltime: 12,
      dateOftravelstart: "24/12/2022",
      speedOfcar: 22,
      travelPlace: "Gondar - Mekele",
      dateOftravelend: "12/24/2022",
    ),
    TravelReport(
      totalTraveltime: 12,
      dateOftravelstart: "12/01/2023",
      speedOfcar: 22,
      travelPlace: "Debra merkos - Addisa ",
      dateOftravelend: "19/01/2023",
    ),
    TravelReport(
      totalTraveltime: 12,
      speedOfcar: 22,
      travelPlace: "Jimma - Debra merkos ",
      dateOftravelend: "19/01/2023",
      dateOftravelstart: "12/01/2023",
    )
  ];

  List<TravelReport> get product {
    return [...products];
  }

  List<TravelReport> searchQuery(String searchText) {
    List _searchList = products
        .where((element) => element.travelPlace
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return [..._searchList];
  }

  // List getCategoryList(List<dynamic> inputlist) {
  //   List outputList = inputlist.where((o) => o['category_id'] == '1').toList();
  //   return outputList;
  // }

  List<TravelReport> findByCategory(String categorystart) {
    List _categoryList = products
        .where((element) => element.dateOftravelend.contains(categorystart))
        .toList();
    return [..._categoryList];
    print(_categoryList);
  }
}
