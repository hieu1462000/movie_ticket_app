import 'dart:convert';

import 'package:movie_ticket/models/showtime_management_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_ticket/models/showtime_model.dart';
import '../sources/api_config.dart';

class ShowtimeRepository {
  String baseUrl = ApiConfig.baseUrl;

  Future getListShowtime(String date) async {
    //showtime of all movie
    var response =
        await http.get(Uri.parse("$baseUrl/showtime-mangement/$date"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data
          .map<ShowtimeManagementModel>(
              (e) => ShowtimeManagementModel.fromJson(e))
          .toList();
    } else {
      throw Exception('something wrong');
    }
  }

  Future getShowtimeByMovie(date, movieId) async {
    //Showtime of single movie
    var response =
        await http.get(Uri.parse("$baseUrl/showtime-mangement/$date/$movieId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data
          .map<ShowtimeManagementModel>(
              (e) => ShowtimeManagementModel.fromJson(e))
          .toList();
    } else {
      throw Exception('something wrong');
    }
  }

  Future<ShowtimeModel> getDetailShowtime(String showtimeId) async {
    var response = await http.get(Uri.parse("$baseUrl/showtimes/$showtimeId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return ShowtimeModel.fromJson(data);
    } else {
      throw Exception('something wrong');
    }
  }
}
