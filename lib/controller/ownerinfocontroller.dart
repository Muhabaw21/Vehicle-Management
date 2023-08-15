import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiControllerforowner extends GetxController {
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
        Uri.parse("http://164.90.174.113:9090/Api/Vehicle/Owner/Info"),
        headers: requestHeaders);

    if (response.statusCode == 200) {
      // Parse the response body and store the
      var mapResponse = json.decode(response.body);
      var results = mapResponse['ownerINF'];

      dataList = results;
      update();
    }
  }
}
