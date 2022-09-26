import 'dart:convert';

import 'package:http/http.dart' as http;

class APIHelper {
  APIHelper._();

  static APIHelper apiHelper = APIHelper._();

  Future getJsonData() async {
    http.Response _response =
        await http.get(Uri.parse("https://api.covid19api.com/summary"));
    //return jsonDecode(_response.body);

    if (_response.statusCode == 200) {
      jsonDecode(_response.body);
    }
  }
}
