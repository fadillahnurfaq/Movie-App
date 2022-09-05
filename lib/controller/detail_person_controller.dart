import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/person_model.dart';

import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class DetailPersonController with ChangeNotifier {
  static Future<PersonModel> getAllPersonDetail(int movieId) async {
    Uri url = Uri.parse("$baseUrl/3/person/$movieId?api_key=$apiKey");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return PersonModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static String convertBirtdayToAge(String birthday) {
    final date = DateTime.parse(birthday);
    final now = DateTime.now();
    final difference = now.difference(date);
    final age = difference.inDays ~/ 365;
    return '$age years old';
  }

  static String parseJenisKelamin(String jenisKelamin) {
    if (jenisKelamin == '2') {
      return 'Male';
    } else {
      return 'Female';
    }
  }
}
