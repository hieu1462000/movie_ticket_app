import 'dart:convert';

import 'package:movie_ticket/models/list_movie_model.dart';
import 'package:movie_ticket/models/sources/api_config.dart';

import '../movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  String baseUrl = ApiConfig.baseUrl;

  Future<MovieModel> getDetailMovie(movieId) async {
    var response = await http.get(Uri.parse("$baseUrl/movies/$movieId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception('something wrong');
    }
  }

  Future<ListMovieModel> getListMovie(String listName) async {
    var response = await http.get(Uri.parse("$baseUrl/$listName"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return ListMovieModel.fromJson(data[0]);
    } else {
      print("fail conectiion");
      throw Exception('something wrong');
    }
  }
}
