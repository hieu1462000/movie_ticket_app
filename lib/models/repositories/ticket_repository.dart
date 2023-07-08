import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:movie_ticket/models/ticket_model.dart';

import '../sources/api_config.dart';

class TicketRepository {
  String baseUrl = ApiConfig.baseUrl;

  Future confirmBooking(TicketModel data) async {
    var response = await http.post(Uri.parse("$baseUrl/tickets"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));

    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.body);
      throw Exception('something wrong');
    }
  }

  Future getListTicketByUserId(userId) async {
    var response = await http.get(Uri.parse("$baseUrl/tickets/user/$userId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data.map<TicketModel>((e) => TicketModel.fromJson(e)).toList();
    } else {
      throw Exception('something wrong');
    }
  }

  Future getDetailTicket(ticketId) async {
    var response = await http.get(Uri.parse("$baseUrl/tickets/$ticketId"));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return TicketModel.fromJson(data);
    } else {
      print(response.body);
      throw Exception('something wrong');
    }
  }
}
