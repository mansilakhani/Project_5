// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import 'screens/randomuser_class.dart';
//
// class APIHelper {
//   APIHelper._();
//
//   static APIHelper apiHelper = APIHelper._();
//   String URL = "https://randomuser.me/api/";
//   List<User> users = [];
//   Future<List<User>?> fetchUserDetails() async {
//
//     http.Response res = await http.get(Uri.parse(URL));
//     if (res.statusCode == 200) {
//       List decodedData = jsonDecode(res.body);
//
//       List<User> users =
//           decodedData.map((e) => User.fromJson(json: e)).toList();
//       return users;
//     }
//     return null;
//   }
// }
