import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class ContactRepo {
  getContacts() async {
    var response = await http
        .get(Uri.parse('https://api.github.com/users/repository/followers'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      log('exception');
    }
  }
}
