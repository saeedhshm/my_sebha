import 'dart:convert';

import 'package:flutter/services.dart';

class ReadJson{
  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString("assets/db/azkar.json");
  }

  Future<dynamic> parseJson() async {
    String jsonString = await _loadFromAsset();

    final jsonResponse = jsonDecode(jsonString);
    return jsonResponse;
  }
}