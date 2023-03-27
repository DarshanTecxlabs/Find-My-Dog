import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/animal_model.dart';

class AnimalProvider with ChangeNotifier {
  List<String> contectList = [];
  List<String> demo = [];
  var myUrl = "";

  void getAll() async {
    const url = "https://dog.ceo/api/breeds/image/random";
    final url1 = Uri.parse(url);
    final response = await http.get(url1);
    if (response.statusCode == 200) {
      log(response.body);
      final res = json.decode(response.body);
      myUrl = res["message"];
      contectList.add(res["message"]);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setStringList("dogs", contectList);
      log(pref.toString());
    }
    notifyListeners();
  }

  setupImages() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    demo = pref.getStringList("dogs")!;
    // for (var element in myList!) {
    //   log(element);
    //   demo.add(element);
    // }
    // contectList = demo;
    // notifyListeners();
  }

  void saveImages(res) async {}
}
