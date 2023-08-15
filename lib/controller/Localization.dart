import 'dart:convert';
import 'dart:ui';


import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TranslationController extends GetxController {
  Map<String, String>? _localizedStrings;

  Map<String, String>? get localizedStrings => _localizedStrings;

  Future<void> loadTranslations(String languageCode) async {
    String jsonString =
        await rootBundle.loadString('assets/locales/$languageCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }
}

class LocaleController extends GetxController {
  static List<Locale> get supportedLocales =>
      const [Locale('en', ''), Locale('am', ''), Locale('a', '')];
}

class TranslationUtil {
  static String text(String key) =>
      Get.find<TranslationController>().localizedStrings![key] ?? '';
}
