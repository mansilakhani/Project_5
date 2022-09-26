import 'dart:convert';

import 'package:http/http.dart' as http;

import '../screens/randomuser_class.dart';

class APIHelper {
  APIHelper._();

  static APIHelper apiHelper = APIHelper._();
  String URL = "https://randomuser.me/api/?results=4";

  List<User> users = [];

  Future<List<User>> fetchUserDetails() async {
    if (users.length == 0) {
      http.Response res = await http.get(Uri.parse(URL));
      var jsonData = jsonDecode(res.body);
      int index = 0;

      for (var user in jsonData['results']) {
        User data = User(
          index: index,
          first: user['name']['first'],
          last: user['name']['last'],
          email: user['email'],
          phone: user['phone'],
          gender: user['gender'],
          dob: user['dob']['date'],
          pictureLarge: user['picture']['large'],
          pictureSmall: user['picture']['medium'],
        );
        users.add(data);
        index++;
      }
    }
    return users;
  }
}
