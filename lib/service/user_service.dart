import 'dart:convert';

import 'package:brieftest/model/user_model.dart';
import 'package:http/http.dart' as http;
class UserService {
  Future getUserById(id) async {
    try {
      final uri = Uri.parse('https://jsonplaceholder.typicode.com/users/$id');
      final response = await http.get(uri);
      return User.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
