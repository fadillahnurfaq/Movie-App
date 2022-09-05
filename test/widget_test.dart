// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movie_app/main.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/now_showing_model.dart';

void main() async {
  // Uri url = Uri.parse(
  //     "https://api.themoviedb.org/3/trending/movie/week?api_key=05753dc1274b70e15d4c690bf4ec4d61");
  // final response = await http.get(url);
  // Map<String, dynamic> detail =
  //     (jsonDecode(response.body) as Map<String, dynamic>);
  // NowShowing nowShowing = NowShowing.fromJson(detail);
  // print(nowShowing.dates?.maximum);
}
