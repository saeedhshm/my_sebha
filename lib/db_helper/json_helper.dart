import 'dart:convert';

import 'package:flutter/services.dart';

class ReadJson{
  Future<String>_loadFromAsset() async {
    return await rootBundle.loadString("assets/db/azkar.json");
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();

    final jsonResponse = jsonDecode(jsonString);
    for(var map in jsonResponse)
      print(map);
  }
}