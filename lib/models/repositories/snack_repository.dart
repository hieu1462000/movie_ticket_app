import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_ticket/models/snack_model.dart';

import '../sources/api_config.dart';

class SnackRepository {
  String baseUrl = ApiConfig.baseUrl;

  Future getListSnack() async {
    var response = await http.get(Uri.parse("$baseUrl/snacks"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data.map<SnackModel>((e) => SnackModel.fromJson(e)).toList();
    } else {
      throw Exception('something wrong');
    }
  }
}
