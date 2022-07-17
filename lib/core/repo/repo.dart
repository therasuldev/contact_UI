import 'dart:convert';

import 'package:contact_ui/core/model/user_model.dart';
import 'package:http/http.dart' as http;

class ContactRepo {
  Future<List<User>> getContacts() async {
    const _url = 'https://api.github.com/users/repository/followers';
    var response = await http.get(Uri.parse(_url));
    List<User> allUser = [];

    if (response.statusCode == 200) {
      final List<dynamic> userJson = json.decode(response.body);
      allUser = userJson.map<User>((json) => User.fromJson(json)).toList();
    }
    return allUser;
  }
}
