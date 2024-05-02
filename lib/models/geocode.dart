import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_light_map_for_cars/models/geolocation.dart';

class Geocoding {
  String? apiKey;
  String? language;
  Geocoding({this.apiKey, language = 'en'});

  Future<dynamic> getGeolocation(String address) async {
    String trimmedAddress = address.replaceAllMapped(' ', (m) => '+');
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$trimmedAddress&key=$apiKey&language=$language";
    final response = await http.get(Uri.parse(url));
    final json = jsonDecode(response.body);
    if (json["error_message"] == null) {
      return Geolocation.fromJSON(json);
    } else {
      var error = json["error_message"];
      if (error == "This API project is not authorized to use this API.")
        error +=
            " Make sure both the Geolocation and Geocoding APIs are activated on your Google Cloud Platform";
      throw Exception(error);
    }
  }
}
