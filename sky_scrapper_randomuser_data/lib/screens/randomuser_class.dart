class User {
  final int index;
  final String first;
  final String last;
  final String email;
  final String phone;
  final String pictureSmall;
  final String pictureLarge;
  final String gender;
  final String dob;

  User({
    required this.index,
    required this.first,
    required this.last,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dob,
    required this.pictureLarge,
    required this.pictureSmall,
  });

  ///
  // factory User.fromJson({required Map<String, dynamic> json}) {
  //   return User(
  //       index: json['index'],
  //       first: json['name']['first'],
  //       last: json['name']['last'],
  //       email: json['email'],
  //       phone: json['phone'],
  //       gender: json['gender'],
  //       dob: json['dob']['date'],
  //       pictureLarge: json['picture']['large'],
  //       pictureSmall: json['picture']['medium']);
  // }
}
