import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class ApiControllerdriverimage extends GetxController {
  Map<String, dynamic>? dataList;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'jwt');
    var client = http.Client();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
        Uri.parse('http://164.90.174.113:9090/Api/Message/All'),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      // Parse the response body and store the
      var data = json.decode(response.body);
      dataList = data;
      update();
    }
  }
}

class DataController extends GetxController {
  final dataBoxName = 'dataBox';

  // Use RxList to store the new data fetched from the API
  var newDataList = <dynamic>[].obs;

  @override
  void onInit() async {
    await initHive();
    fetchDataFromApi(); // Fetch data initially
    Timer.periodic(Duration(seconds: 30),
        (_) => fetchDataFromApi()); // Fetch data every 30 seconds
    super.onInit();
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox(dataBoxName);
  }

  Future<void> fetchDataFromApi() async {
    try {
      final storage = new FlutterSecureStorage();
      var token = await storage.read(key: 'jwt');
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
          Uri.parse('http://64.226.104.50:9090/Api/Vehicle/Alerts/ByStatus'),
          headers: requestHeaders);
      if (response.statusCode == 200) {
        final alert = json.decode(response.body);
        final jsonData = alert["activeAlerts"];
        final dataBox = Hive.box(dataBoxName);
        final existingData = dataBox.get('data', defaultValue: []);

        // Filter out new data that is not already present in Hive
        newDataList.assignAll(
            jsonData.where((item) => !existingData.contains(item)).toList());

        // Update Hive with the new data
        final List<dynamic> newData = [...existingData, ...newDataList];
        dataBox.put('data', newData);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data from API: $e');
    }
  }
}
