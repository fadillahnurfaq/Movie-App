import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:movie_app/models/now_showing_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/popular_model.dart';
import 'package:movie_app/utils/constants.dart';

class HomeController with ChangeNotifier {
  static Future<NowShowing> getAllNowShowing() async {
    Uri url = Uri.parse("$baseUrl/3/trending/movie/week?api_key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>);

      return NowShowing.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static Future<PopularModel> getAllPopular() async {
    Uri url = Uri.parse("$baseUrl/3/movie/now_playing?api_key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>);

      return PopularModel.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }
}
