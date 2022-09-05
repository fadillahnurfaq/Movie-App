import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/cast_model.dart';
import 'package:movie_app/models/video_model.dart';

import '../models/movie_detail_model.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class DetailMovieController with ChangeNotifier {
  static Future<MovieDetail> getAllMovieDetail(int movieId) async {
    Uri url = Uri.parse("$baseUrl/3/movie/$movieId?api_key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static String converMinutesToHours(int minutes) {
    final hours = (minutes / 60).floor();
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}min';
  }

  static Future<CastModel> getAllCast(int movieId) async {
    Uri url = Uri.parse("$baseUrl/3/movie/$movieId/credits?api_key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return CastModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<VideoModel> getAllVideos(int movieId) async {
    Uri url = Uri.parse("$baseUrl/3/movie/$movieId/videos?api_key=$apiKey");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return VideoModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
