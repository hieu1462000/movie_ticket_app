import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_ticket/models/advertisement_model.dart';
import 'package:movie_ticket/models/sources/api_config.dart';

class AdvertisementRepository {
  String baseUrl = ApiConfig.baseUrl;

  Future getListAdvertisement() async {
    var response = await http.get(Uri.parse("$baseUrl/advertisement"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data
          .map<AdvertisementModel>((e) => AdvertisementModel.fromJson(e))
          .toList();
    } else {
      throw Exception('something wrong');
    }
  }

  Future<AdvertisementModel> getDetailAdvertisement(advertisementId) async {
    var response =
        await http.get(Uri.parse("$baseUrl/advertisement/$advertisementId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return AdvertisementModel.fromJson(data);
    } else {
      throw Exception('something wrong');
    }
  }
}
