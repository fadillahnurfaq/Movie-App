import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/search_model.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class SearchPageController with ChangeNotifier {
  static TextEditingController searchInput = TextEditingController();
  static ValueNotifier<bool> isLoading = ValueNotifier(false);
  static TextEditingController movieName = TextEditingController();

  static ValueNotifier<List<Result>> searchResult = ValueNotifier([]);

  static Future<SearchModel> getAllPopular(String movieName) async {
    Uri url = Uri.parse(
        "$baseUrl/3/search/movie?api_key=$apiKey&language=en-US&query=$movieName&page=1&include_adult=false");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          (jsonDecode(response.body) as Map<String, dynamic>);

      return SearchModel.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }

  static void search() async {
    isLoading.value = true;
    if (movieName.text.isNotEmpty) {
      final listResult = await getAllPopular(movieName.text);
      final hasil = listResult.results;
      searchResult.value = hasil!;
    }
    isLoading.value = false;
    searchResult.notifyListeners();
  }
}
