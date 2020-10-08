import 'dart:convert';

import 'package:http/http.dart' as http;

const BASE_URL = "https://fakestoreapi.com/";

class Network {

  Future<dynamic> getRequest(String url) async {
    final response = await http.get(BASE_URL + url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}